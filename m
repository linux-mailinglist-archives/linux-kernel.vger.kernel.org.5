Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CA27F0B3A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 05:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjKTENI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 23:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKTENG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 23:13:06 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC166C5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 20:13:02 -0800 (PST)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AK3i8El021928;
        Mon, 20 Nov 2023 04:12:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=UkuhkTHXh3KZ0wjePy3kranqh5iqEWUMN+wxlcdWguI=;
 b=Bsq+Sp87G4wthGUmWsZkAdj6c3sLs1UvzqSbkXI/GEqfHyQ/z+9hhqNpJOfeT3KBC+bN
 heoYKw+Pmq7cl8w1TAJZSlgq2J7yP5/0LfKpzzkGOXz0kQ3UEg0j3ziOyVBm49NdS2Uq
 SMGLKBG7ntZJGuY9CvgVKNpFmgmszaSBtrckTBGuBQIUNp6WNo87rKwgN/608lUl585H
 glyENGr+s7BU56K+UvbSVGA2MUgy1aUXF217qaYw6PMlkhCKvh37av+5+HYZi0YhStnF
 hpPgsK7XD8Bys2aQR89jp+ww9LaHSjp5mAYb1KAztE7voYecIRMzzVORno9mkEmZd2R3 Sg== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uf0echvpr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 04:12:53 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AK1U9eH028785;
        Mon, 20 Nov 2023 04:12:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf8knesds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 04:12:52 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AK4CoJH15205118
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Nov 2023 04:12:50 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 563CE20043;
        Mon, 20 Nov 2023 04:12:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7492520040;
        Mon, 20 Nov 2023 04:12:49 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 20 Nov 2023 04:12:49 +0000 (GMT)
Received: from jarvis.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id B44A760100;
        Mon, 20 Nov 2023 15:12:46 +1100 (AEDT)
Message-ID: <65fae3db40ada9a2bc3d1333f27d9a4f4db6ac72.camel@linux.ibm.com>
Subject: Re: [PATCH] misc: ocxl: link: Remove unnecessary (void*) conversions
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     Li zeming <zeming@nfschina.com>, fbarrat@linux.ibm.com,
        arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Mon, 20 Nov 2023 15:12:46 +1100
In-Reply-To: <20231113014533.11064-1-zeming@nfschina.com>
References: <20231113014533.11064-1-zeming@nfschina.com>
Autocrypt: addr=ajd@linux.ibm.com; prefer-encrypt=mutual;
 keydata=mDMEZPaWfhYJKwYBBAHaRw8BAQdAAuMUoxVRwqphnsFua1W+WBz6I2cIn0+Ox4YypJSdBJ+0MEFuZHJldyBEb25uZWxsYW4gKElCTSBzdHVmZikgPGFqZEBsaW51eC5pYm0uY29tPoiTBBMWCgA7FiEE01kE3s9shZVYLX1Aj1Qx8QRYRqAFAmT2ln4CGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQj1Qx8QRYRqAdswD8DhIh4trRQYiPe+7LaM7q+0+Thz+CwUJCW3UFOf0SEO0BAPNdsi7aVV+4Oah6nYzqzH5Zbs4Tz5RY+Vsf+DD/EzUKuDgEZPaWfhIKKwYBBAGXVQEFAQEHQLN9moJRqN8Zop/kcyIjga+2qzLoVaNAL6+4diGnlr1xAwEIB4h4BBgWCgAgFiEE01kE3s9shZVYLX1Aj1Qx8QRYRqAFAmT2ln4CGwwACgkQj1Qx8QRYRqCYkwD/W+gIP9kITfU4wnLtueFUThxA0T/LF49M7k31Qb8rPCwBALeEYAlX648lzjSA07pJB68Jt39FuUno444dSVmhYtoH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 (3.50.1-1.fc39) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ld2FDWfcyVW3D6kLmiRclHUzrtu-RiTy
X-Proofpoint-GUID: Ld2FDWfcyVW3D6kLmiRclHUzrtu-RiTy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_01,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=763 adultscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311200028
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-11-13 at 09:45 +0800, Li zeming wrote:
> The link pointer does not need to cast the type.
>=20
> Signed-off-by: Li zeming <zeming@nfschina.com>

Acked-by: Andrew Donnellan <ajd@linux.ibm.com>

> ---
> =C2=A0drivers/misc/ocxl/link.c | 14 +++++++-------
> =C2=A01 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c
> index c06c699c0e7b1..03402203cacdb 100644
> --- a/drivers/misc/ocxl/link.c
> +++ b/drivers/misc/ocxl/link.c
> @@ -188,7 +188,7 @@ static void xsl_fault_handler_bh(struct
> work_struct *fault_work)
> =C2=A0
> =C2=A0static irqreturn_t xsl_fault_handler(int irq, void *data)
> =C2=A0{
> -	struct ocxl_link *link =3D (struct ocxl_link *) data;
> +	struct ocxl_link *link =3D data;
> =C2=A0	struct spa *spa =3D link->spa;
> =C2=A0	u64 dsisr, dar, pe_handle;
> =C2=A0	struct pe_data *pe_data;
> @@ -483,7 +483,7 @@ static void release_xsl(struct kref *ref)
> =C2=A0
> =C2=A0void ocxl_link_release(struct pci_dev *dev, void *link_handle)
> =C2=A0{
> -	struct ocxl_link *link =3D (struct ocxl_link *) link_handle;
> +	struct ocxl_link *link =3D link_handle;
> =C2=A0
> =C2=A0	mutex_lock(&links_list_lock);
> =C2=A0	kref_put(&link->ref, release_xsl);
> @@ -540,7 +540,7 @@ int ocxl_link_add_pe(void *link_handle, int
> pasid, u32 pidr, u32 tidr,
> =C2=A0		void (*xsl_err_cb)(void *data, u64 addr, u64 dsisr),
> =C2=A0		void *xsl_err_data)
> =C2=A0{
> -	struct ocxl_link *link =3D (struct ocxl_link *) link_handle;
> +	struct ocxl_link *link =3D link_handle;
> =C2=A0	struct spa *spa =3D link->spa;
> =C2=A0	struct ocxl_process_element *pe;
> =C2=A0	int pe_handle, rc =3D 0;
> @@ -630,7 +630,7 @@ EXPORT_SYMBOL_GPL(ocxl_link_add_pe);
> =C2=A0
> =C2=A0int ocxl_link_update_pe(void *link_handle, int pasid, __u16 tid)
> =C2=A0{
> -	struct ocxl_link *link =3D (struct ocxl_link *) link_handle;
> +	struct ocxl_link *link =3D link_handle;
> =C2=A0	struct spa *spa =3D link->spa;
> =C2=A0	struct ocxl_process_element *pe;
> =C2=A0	int pe_handle, rc;
> @@ -666,7 +666,7 @@ int ocxl_link_update_pe(void *link_handle, int
> pasid, __u16 tid)
> =C2=A0
> =C2=A0int ocxl_link_remove_pe(void *link_handle, int pasid)
> =C2=A0{
> -	struct ocxl_link *link =3D (struct ocxl_link *) link_handle;
> +	struct ocxl_link *link =3D link_handle;
> =C2=A0	struct spa *spa =3D link->spa;
> =C2=A0	struct ocxl_process_element *pe;
> =C2=A0	struct pe_data *pe_data;
> @@ -752,7 +752,7 @@ EXPORT_SYMBOL_GPL(ocxl_link_remove_pe);
> =C2=A0
> =C2=A0int ocxl_link_irq_alloc(void *link_handle, int *hw_irq)
> =C2=A0{
> -	struct ocxl_link *link =3D (struct ocxl_link *) link_handle;
> +	struct ocxl_link *link =3D link_handle;
> =C2=A0	int irq;
> =C2=A0
> =C2=A0	if (atomic_dec_if_positive(&link->irq_available) < 0)
> @@ -771,7 +771,7 @@ EXPORT_SYMBOL_GPL(ocxl_link_irq_alloc);
> =C2=A0
> =C2=A0void ocxl_link_free_irq(void *link_handle, int hw_irq)
> =C2=A0{
> -	struct ocxl_link *link =3D (struct ocxl_link *) link_handle;
> +	struct ocxl_link *link =3D link_handle;
> =C2=A0
> =C2=A0	xive_native_free_irq(hw_irq);
> =C2=A0	atomic_inc(&link->irq_available);

--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited
