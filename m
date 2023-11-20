Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBBC7F0B33
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 05:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjKTEGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 23:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKTEGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 23:06:31 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77D8D8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 20:06:27 -0800 (PST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AK3PnL1020320;
        Mon, 20 Nov 2023 04:06:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=incFlguobFneUxI6bRaxPdCgyvYnp5GESP/LIrqoars=;
 b=ttPKssX8rMBCiXH/AxUdhptivtRyt1yg6fVSNedvy0CppF4pMmV5EcitsVSsOzy/7zN/
 KHZwu3znwbgWwQZdw669FOmwLi2xpLjyAxeoQVRap8iw+0z6RxtNCCzeYRgmNlYzgAHM
 Cy6dFa5jTDP8aplIWJvOMzoSSni4QP/CrbvJrfDUg5RKhEl2YpWw38N9MN/SWad09jOs
 W7Q+iFvgVpxGKqs1VCPOufyUlDPsckA6vnQaaRS6Zq1TfrDAGp+0xVJ48/RtES+pl90C
 V7oGlfHycFT5KR+BLkBTVYefWMRwd9iddKgCMfBNLCwE0gr+frjENZx4aJQJJRV1oj3S Sg== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ufuwrv395-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 04:06:16 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AK1f4Br028027;
        Mon, 20 Nov 2023 04:06:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf7yy6wvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 04:06:15 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AK46DPQ15991390
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Nov 2023 04:06:14 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8AA020049;
        Mon, 20 Nov 2023 04:06:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65B3F20040;
        Mon, 20 Nov 2023 04:06:13 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 20 Nov 2023 04:06:13 +0000 (GMT)
Received: from jarvis.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id DBC5B600A7;
        Mon, 20 Nov 2023 15:06:11 +1100 (AEDT)
Message-ID: <e1447ac194d693ba9f9bfc871b6a15bb28753e21.camel@linux.ibm.com>
Subject: Re: [PATCH] misc: ocxl: context: Remove unnecessary (void*)
 conversions
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     Li zeming <zeming@nfschina.com>, fbarrat@linux.ibm.com,
        arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Mon, 20 Nov 2023 15:06:11 +1100
In-Reply-To: <20231113011543.6940-1-zeming@nfschina.com>
References: <20231113011543.6940-1-zeming@nfschina.com>
Autocrypt: addr=ajd@linux.ibm.com; prefer-encrypt=mutual;
 keydata=mDMEZPaWfhYJKwYBBAHaRw8BAQdAAuMUoxVRwqphnsFua1W+WBz6I2cIn0+Ox4YypJSdBJ+0MEFuZHJldyBEb25uZWxsYW4gKElCTSBzdHVmZikgPGFqZEBsaW51eC5pYm0uY29tPoiTBBMWCgA7FiEE01kE3s9shZVYLX1Aj1Qx8QRYRqAFAmT2ln4CGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQj1Qx8QRYRqAdswD8DhIh4trRQYiPe+7LaM7q+0+Thz+CwUJCW3UFOf0SEO0BAPNdsi7aVV+4Oah6nYzqzH5Zbs4Tz5RY+Vsf+DD/EzUKuDgEZPaWfhIKKwYBBAGXVQEFAQEHQLN9moJRqN8Zop/kcyIjga+2qzLoVaNAL6+4diGnlr1xAwEIB4h4BBgWCgAgFiEE01kE3s9shZVYLX1Aj1Qx8QRYRqAFAmT2ln4CGwwACgkQj1Qx8QRYRqCYkwD/W+gIP9kITfU4wnLtueFUThxA0T/LF49M7k31Qb8rPCwBALeEYAlX648lzjSA07pJB68Jt39FuUno444dSVmhYtoH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 (3.50.1-1.fc39) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cr__BbafTu4XG3ssx8GRJINddWDk9CYT
X-Proofpoint-GUID: cr__BbafTu4XG3ssx8GRJINddWDk9CYT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_01,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 clxscore=1011 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311200027
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-11-13 at 09:15 +0800, Li zeming wrote:
> The ctx pointer does not need to cast the type.
>=20
> Signed-off-by: Li zeming <zeming@nfschina.com>

Acked-by: Andrew Donnellan <ajd@linux.ibm.com>

> ---
> =C2=A0drivers/misc/ocxl/context.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/misc/ocxl/context.c
> b/drivers/misc/ocxl/context.c
> index 7f83116ae11a6..cded7d1caf328 100644
> --- a/drivers/misc/ocxl/context.c
> +++ b/drivers/misc/ocxl/context.c
> @@ -55,7 +55,7 @@ EXPORT_SYMBOL_GPL(ocxl_context_alloc);
> =C2=A0 */
> =C2=A0static void xsl_fault_error(void *data, u64 addr, u64 dsisr)
> =C2=A0{
> -	struct ocxl_context *ctx =3D (struct ocxl_context *) data;
> +	struct ocxl_context *ctx =3D data;
> =C2=A0
> =C2=A0	mutex_lock(&ctx->xsl_error_lock);
> =C2=A0	ctx->xsl_error.addr =3D addr;

--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited
