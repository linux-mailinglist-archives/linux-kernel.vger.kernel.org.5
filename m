Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D470975CA1F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 16:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjGUOgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 10:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjGUOgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 10:36:12 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685BB10C3;
        Fri, 21 Jul 2023 07:36:11 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36LEBkBC000790;
        Fri, 21 Jul 2023 14:36:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=R9SDwpgxPts0/H86y/f+yVGHJboXJpEl9wullCar0P8=;
 b=sfHKnbSRnaZazX5082lSBMmbcfVuz483MxOWaf18SrJVky2pU+I5McipGo6Z/7AW/wRl
 ucNCiEv3m3m0Q2kabQZ24OFFxGX+wivF6eCx3f033lFu1StE0WY1ej+Eq7edizkPeyym
 zlHuzTtNeIM60eHD5ksx/fAT2nA6GK94nj5Ut07tKFa8s1pQAxz27tCWazFhGzcCZ/2H
 7Slgotl+VdNvl8ZY30JKEr5fvZ9KhW8CAIXofqHJKwuDgr7zAvMaRoWPQXu4vWDCAbfY
 Ifl15BDadYn7HE8Nicj+4SJWw2CmfKZyPJDumNDxtqugRscQlEPzg37J2U+/fGjtwOZR ew== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rye3fubjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 14:36:08 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36LCnjpF004510;
        Fri, 21 Jul 2023 14:36:07 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rv80jmvej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 14:36:07 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36LEa4Yc25952778
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jul 2023 14:36:04 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A280020043;
        Fri, 21 Jul 2023 14:36:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B8E820040;
        Fri, 21 Jul 2023 14:36:04 +0000 (GMT)
Received: from [9.171.55.243] (unknown [9.171.55.243])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 21 Jul 2023 14:36:04 +0000 (GMT)
Message-ID: <01972a94-fc21-709e-29ac-847b8e60ee23@linux.ibm.com>
Date:   Fri, 21 Jul 2023 16:36:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] s390: use obj-y to descend into drivers/s390/
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>
References: <20230721134107.3437947-1-masahiroy@kernel.org>
Content-Language: en-US
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20230721134107.3437947-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Q-IGwVdz1fxPtzVtYZogGfmjA2GXR9VN
X-Proofpoint-ORIG-GUID: Q-IGwVdz1fxPtzVtYZogGfmjA2GXR9VN
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_09,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 suspectscore=0 phishscore=0
 mlxlogscore=859 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307210131
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 21.07.23 um 15:41 schrieb Masahiro Yamada:
> I like to use obj-y in as many places as possible.

Please do not use "I like". That is just too polite.

This fixes a bug as outlined below and maybe make it a clear statement that the current use is
non-standard and needs to be fixed - I think.
> 
> Change the drivers-y to obj-y. It moves the objects from drivers/s390/
> to slightly lower address, but fixes the single build issue. [1]
> 
> [1]: https://lore.kernel.org/linux-kbuild/d57ba55f-20a3-b836-783d-b49c8a161b6e@kernel.org/T/#m27f781ab60acadfed8a9e9642f30d5414a5e2df3
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Tested-by: Jiri Slaby <jirislaby@kernel.org>
> ---
> 
>   arch/s390/Makefile | 1 -
>   drivers/Makefile   | 2 ++
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/Makefile b/arch/s390/Makefile
> index 5ed242897b0d..a53a36ee0731 100644
> --- a/arch/s390/Makefile
> +++ b/arch/s390/Makefile
> @@ -119,7 +119,6 @@ export KBUILD_CFLAGS_DECOMPRESSOR
>   OBJCOPYFLAGS	:= -O binary
>   
>   libs-y		+= arch/s390/lib/
> -drivers-y	+= drivers/s390/
>   
>   boot		:= arch/s390/boot
>   syscalls	:= arch/s390/kernel/syscalls
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 7241d80a7b29..a7459e77df37 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -195,3 +195,5 @@ obj-$(CONFIG_PECI)		+= peci/
>   obj-$(CONFIG_HTE)		+= hte/
>   obj-$(CONFIG_DRM_ACCEL)		+= accel/
>   obj-$(CONFIG_CDX_BUS)		+= cdx/
> +
> +obj-$(CONFIG_S390)		+= s390/
