Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B527A7F0B58
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 05:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjKTETx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 23:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKTETv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 23:19:51 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34428E5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 20:19:47 -0800 (PST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AK3fD5D004248;
        Mon, 20 Nov 2023 04:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=hMfDWSsizKfaNGBkGA3TtNzG7wl906lsCoWRQsuBtxI=;
 b=FKr5NK1yJHHZNOf2wKAV9HKyvBLfSiFY7Gz0H0g4fADaEcMEui8qIZBdxW1NB0h8QSFQ
 YcchHbh0+KxYNrlgt5Jfww9MxvTshg86esdM8v1iOT1WoJHKu6pp1xAdgjVG0hPWXc5R
 XTFP+WSjXETT+csFvLmec5ztCPCVq2dGiIpUH8Awf1hF3Uj/4BId0my1dd5TwFWk+VyM
 I5N7jVm/qkwK2pkyDlK9da+++X3D8Ohb5WXc86vvOHLruoZOpg8z9DrRJoTmF8XEarhf
 MZ4qj0YIArBhkAYy9NquBRXPvTO56Ts5abK3jy/iA5UsWSAMdk4bFrvrAW1oUficw0wa +Q== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uf1f71y2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 04:19:36 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AK1imuU000960;
        Mon, 20 Nov 2023 04:19:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ufaa1pa5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 04:19:35 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AK4JXRL47186264
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Nov 2023 04:19:33 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD5BA20040;
        Mon, 20 Nov 2023 04:19:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B7462004D;
        Mon, 20 Nov 2023 04:19:33 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 20 Nov 2023 04:19:33 +0000 (GMT)
Received: from jarvis.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id B0FD660100;
        Mon, 20 Nov 2023 15:19:31 +1100 (AEDT)
Message-ID: <233c463be8440240dde08d0d0d564050a5bf5b73.camel@linux.ibm.com>
Subject: Re: [PATCH] misc: ocxl: main: Remove unnecessary
 =?UTF-8?Q?=E2=80=980=E2=80=99?= values from rc
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     Li kunyu <kunyu@nfschina.com>, fbarrat@linux.ibm.com,
        arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Mon, 20 Nov 2023 15:19:31 +1100
In-Reply-To: <20231113015229.12074-1-kunyu@nfschina.com>
References: <20231113015229.12074-1-kunyu@nfschina.com>
Autocrypt: addr=ajd@linux.ibm.com; prefer-encrypt=mutual;
 keydata=mDMEZPaWfhYJKwYBBAHaRw8BAQdAAuMUoxVRwqphnsFua1W+WBz6I2cIn0+Ox4YypJSdBJ+0MEFuZHJldyBEb25uZWxsYW4gKElCTSBzdHVmZikgPGFqZEBsaW51eC5pYm0uY29tPoiTBBMWCgA7FiEE01kE3s9shZVYLX1Aj1Qx8QRYRqAFAmT2ln4CGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQj1Qx8QRYRqAdswD8DhIh4trRQYiPe+7LaM7q+0+Thz+CwUJCW3UFOf0SEO0BAPNdsi7aVV+4Oah6nYzqzH5Zbs4Tz5RY+Vsf+DD/EzUKuDgEZPaWfhIKKwYBBAGXVQEFAQEHQLN9moJRqN8Zop/kcyIjga+2qzLoVaNAL6+4diGnlr1xAwEIB4h4BBgWCgAgFiEE01kE3s9shZVYLX1Aj1Qx8QRYRqAFAmT2ln4CGwwACgkQj1Qx8QRYRqCYkwD/W+gIP9kITfU4wnLtueFUThxA0T/LF49M7k31Qb8rPCwBALeEYAlX648lzjSA07pJB68Jt39FuUno444dSVmhYtoH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 (3.50.1-1.fc39) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fTF-1KCpYv6uYPD-CKGUwZVEFZO1mi2t
X-Proofpoint-ORIG-GUID: fTF-1KCpYv6uYPD-CKGUwZVEFZO1mi2t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_01,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 clxscore=1011
 phishscore=0 mlxscore=0 spamscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

On Mon, 2023-11-13 at 09:52 +0800, Li kunyu wrote:
> rc is assigned first, so it does not need to initialize the
> assignment.
>=20
> Signed-off-by: Li kunyu <kunyu@nfschina.com>

I don't have strong feelings about whether to get rid of unnecessary
initialisations, but most of the code doesn't do it, so for
consistency:

Acked-by: Andrew Donnellan <ajd@linux.ibm.com>

> ---
> =C2=A0drivers/misc/ocxl/main.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/misc/ocxl/main.c b/drivers/misc/ocxl/main.c
> index ef73cf35dda2b..658974143c3cc 100644
> --- a/drivers/misc/ocxl/main.c
> +++ b/drivers/misc/ocxl/main.c
> @@ -7,7 +7,7 @@
> =C2=A0
> =C2=A0static int __init init_ocxl(void)
> =C2=A0{
> -	int rc =3D 0;
> +	int rc;
> =C2=A0
> =C2=A0	if (!tlbie_capable)
> =C2=A0		return -EINVAL;

--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited
