Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAEA97D586F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343920AbjJXQc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343747AbjJXQcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:32:55 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF4593;
        Tue, 24 Oct 2023 09:32:53 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39OGJfKA023175;
        Tue, 24 Oct 2023 16:32:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=UkAO23c+2aMfodExmELLTmdZvgxFGuee6Ajbo77NV1A=;
 b=cCqt93SENK/H+YC6+YVBf/QwswVEyBDTJkRD5/wEL08yW/3391sAXxNfKqOA+g0Vcctk
 Mzf7/hh2juzF6P9O/l3xIeuSIVQ/QuGwpqETG+lFidTRTkISHrBRuw8bcpfxyfPqLOvG
 ROWSGwYDqzmithCPHHdlbTyyjuznQZPllnTQi0IzEAckLTP3ujYnDDkeHHOEwDn8PCwj
 16oPYFghnzp7d7zr9R4pH86DwoG0RHlCA6KjTWJ+S0bAQ5kcUMc0YJ8CiBNoxFDqNt+X
 MIdW4UQ3+04laaa8as0sWlqQfQX9mYoT1Rm8riYgu6AESoSxCy+GOr/s+jT6CzxFzmlq DQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3txhbkrgm4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 16:32:51 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39OGKm0R026944;
        Tue, 24 Oct 2023 16:32:50 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3txhbkrgkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 16:32:50 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39OG1UIi010218;
        Tue, 24 Oct 2023 16:32:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tvsbygxgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 16:32:49 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39OGWkGS24707744
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Oct 2023 16:32:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A59E20040;
        Tue, 24 Oct 2023 16:32:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A97F320043;
        Tue, 24 Oct 2023 16:32:45 +0000 (GMT)
Received: from [9.171.57.222] (unknown [9.171.57.222])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 24 Oct 2023 16:32:45 +0000 (GMT)
Message-ID: <6302faa1-b0f3-4405-b4c0-28d309506823@linux.ibm.com>
Date:   Tue, 24 Oct 2023 18:32:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/ctcm: replace deprecated strncpy with strscpy
Content-Language: en-GB
To:     Justin Stitt <justinstitt@google.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20231023-strncpy-drivers-s390-net-ctcm_main-c-v1-1-265db6e78165@google.com>
From:   Thorsten Winkler <twinkler@linux.ibm.com>
In-Reply-To: <20231023-strncpy-drivers-s390-net-ctcm_main-c-v1-1-265db6e78165@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3anXJQg1cO57P-0sE1YqQFOL8TGs8Bqs
X-Proofpoint-ORIG-GUID: RB4OGPEHdMBidTDH8y5UceOR1haKTiMY
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_16,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 clxscore=1011 adultscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310170001 definitions=main-2310240142
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.10.23 21:35, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect chid to be NUL-terminated based on its use with format
> strings:
> 
> 	CTCM_DBF_TEXT_(SETUP, CTC_DBF_INFO, "%s(%s) %s", CTCM_FUNTAIL,
> 			chid, ok ? "OK" : "failed");
> 
> Moreover, NUL-padding is not required as it is _only_ used in this one
> instance with a format string.
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> We can also drop the +1 from chid's declaration as we no longer need to
> be cautious about leaving a spot for a NUL-byte. Let's use the more
> idiomatic strscpy usage of (dest, src, sizeof(dest)) as this more
> closely ties the destination buffer to the length.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

LGTM, thank you!

Reviewed-by: Thorsten Winkler <twinkler@linux.ibm.com>
Tested-by: Thorsten Winkler <twinkler@linux.ibm.com>

> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>   drivers/s390/net/ctcm_main.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
> index 6faf27136024..ac15d7c2b200 100644
> --- a/drivers/s390/net/ctcm_main.c
> +++ b/drivers/s390/net/ctcm_main.c
> @@ -200,13 +200,13 @@ static void channel_free(struct channel *ch)
>   static void channel_remove(struct channel *ch)
>   {
>   	struct channel **c = &channels;
> -	char chid[CTCM_ID_SIZE+1];
> +	char chid[CTCM_ID_SIZE];
>   	int ok = 0;
>   
>   	if (ch == NULL)
>   		return;
>   	else
> -		strncpy(chid, ch->id, CTCM_ID_SIZE);
> +		strscpy(chid, ch->id, sizeof(chid));
>   
>   	channel_free(ch);
>   	while (*c) {
> 
> ---
> base-commit: 9c5d00cb7b6bbc5a7965d9ab7d223b5402d1f02c
> change-id: 20231023-strncpy-drivers-s390-net-ctcm_main-c-f9180f470c69
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 
> 
