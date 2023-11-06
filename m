Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A787E2CE6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbjKFTeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjKFTeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:34:12 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE5598;
        Mon,  6 Nov 2023 11:34:09 -0800 (PST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6If1EH013911;
        Mon, 6 Nov 2023 19:33:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=pR17r1i6xD2ZC1y/ELQ9wYH3czcd++vzBZ22lKrS8lM=;
 b=dxw4uxV5E11BVQof7h9BMUzZOXAMjSUrrde8wTLMPj69A0LHH9cRaKTa48J2Slk4u5w2
 7xEDVrKfJ4/sOjjlAM3ZkFlAuKqG5vIGJPDohTlhhv+owQ7wpCVOerKEVyaZREb8pxKh
 KmHlOdTpr+QAuCkwdUuOf0sxra8/J+5VZBQbL+/qqgFqDTuvJPp81f3vfVjX6ruzhEFy
 HXvdCk7htMsnt/74vFtLsXXYTQyJEFQqf8D3ml5oy5Lvx/zsXPZ+mcmsDwEAs6jdyRUB
 KMGkofU5qGEszI/ObcS8EkSo7pplMPyz0KEr5ZUC8XoWELFiO2u0kZnEyshmB1X73S5w cg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u73f4npmr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 19:33:57 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A6JAmjf032547;
        Mon, 6 Nov 2023 19:33:56 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u73f4npkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 19:33:56 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6Hh3QQ016959;
        Mon, 6 Nov 2023 19:33:55 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u6301k3d6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 19:33:55 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A6JXsRa44237446
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Nov 2023 19:33:54 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7246C5805A;
        Mon,  6 Nov 2023 19:33:54 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E08558051;
        Mon,  6 Nov 2023 19:33:53 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.58.168])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Nov 2023 19:33:53 +0000 (GMT)
Message-ID: <3bae86a2572e1ced0ad069ed6ecd2c0a7d33e11e.camel@linux.ibm.com>
Subject: Re: [PATCH 1/2] ima: Add machine keyring reference to
 IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     dmitry.kasatkin@gmail.com, jarkko@kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 06 Nov 2023 14:33:53 -0500
In-Reply-To: <20231102170617.2403495-2-eric.snowberg@oracle.com>
References: <20231102170617.2403495-1-eric.snowberg@oracle.com>
         <20231102170617.2403495-2-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1ecSAXapnbmuzgGvNH6uEXTtsKj4p1qq
X-Proofpoint-ORIG-GUID: oxDtD7gTF9sK8j8cVjJDhoEugbcVcA4C
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 spamscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060161
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

The subject line is referred to as the 'summary' phrase.  As far as I'm
aware the length is still between 70-75 charcaters.  Refer to 
https://www.kernel.org/doc/Documentation/process/submitting-patches.rst
.

On Thu, 2023-11-02 at 13:06 -0400, Eric Snowberg wrote:
> When the machine keyring is enabled, it may be used as a trust source
> for the .ima keyring.  Add a reference to this in
> IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY.
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
>  security/integrity/ima/Kconfig | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> index a6bd817efc1a..c5dc0fabbc8b 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -243,7 +243,7 @@ config IMA_APPRAISE_MODSIG
>  	   to accept such signatures.
>  
>  config IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
> -	bool "Permit keys validly signed by a built-in or secondary CA cert (EXPERIMENTAL)"
> +	bool "Permit keys validly signed by a built-in, secondary or machine CA cert (EXPERIMENTAL)"

Please add 'machine' in between built-in and secondary, like described
below.

>  	depends on SYSTEM_TRUSTED_KEYRING
>  	depends on SECONDARY_TRUSTED_KEYRING
>  	depends on INTEGRITY_ASYMMETRIC_KEYS
> @@ -251,14 +251,14 @@ config IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
>  	default n
>  	help
>  	  Keys may be added to the IMA or IMA blacklist keyrings, if the
> -	  key is validly signed by a CA cert in the system built-in or
> -	  secondary trusted keyrings. The key must also have the
> -	  digitalSignature usage set.
> +	  key is validly signed by a CA cert in the system built-in,
> +	  machine (if configured), or secondary trusted keyrings. The
> +	  key must also have the digitalSignature usage set.
>  
>  	  Intermediate keys between those the kernel has compiled in and the
>  	  IMA keys to be added may be added to the system secondary keyring,
>  	  provided they are validly signed by a key already resident in the
> -	  built-in or secondary trusted keyrings.
> +	  built-in, machine (if configured) or secondary trusted keyrings.
>  
>  config IMA_BLACKLIST_KEYRING
>  	bool "Create IMA machine owner blacklist keyrings (EXPERIMENTAL)"

-- 
thanks,

Mimi


