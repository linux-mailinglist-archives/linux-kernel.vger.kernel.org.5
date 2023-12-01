Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19788009C9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378503AbjLALTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 06:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378535AbjLALTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:19:32 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C73910DF;
        Fri,  1 Dec 2023 03:18:56 -0800 (PST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1B8FZv018133;
        Fri, 1 Dec 2023 11:18:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=SQeMsnkSmvQHWc9TP1DATsAWIlnBwjDXrz6OTIEeqsQ=;
 b=kAQsN+K3EGsgSamBNfuGLzBbEgW0jSGh5sp+407hkH+878d1dKL/Z2jB3xqC4Q0XLr9i
 sLYq1+Glf+acycicHlvSzXz4XV9GLCL78miJUaycDbi7bMp1+ACUnvlxlTI9bdK9Uw7P
 JIOVsG6AVJn4SS8o3FZrUIRTCH5Vf29PqBNFiqukw91BRkn2bX/va62bGnTnvcEvZued
 uSJ+9euorxY57lTe0x8mHxTsygEvPCFVGuENo+om+BoTw+3XBK2b/32Lq/fI9gADlUXB
 TigdGzpRXl02uypV1pK6jyCaUUHjzIYknEXWpJ8wcSDMpraGjJ3TiNs7bkTVbgt8BEXL kw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uqebmrab6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Dec 2023 11:18:49 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B1B8vZ4021075;
        Fri, 1 Dec 2023 11:18:48 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uqebmraas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Dec 2023 11:18:48 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1AY0SY020438;
        Fri, 1 Dec 2023 11:18:47 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukvrm4gy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Dec 2023 11:18:47 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B1BIiUu20906498
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Dec 2023 11:18:44 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88C4420043;
        Fri,  1 Dec 2023 11:18:44 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4FFC420040;
        Fri,  1 Dec 2023 11:18:43 +0000 (GMT)
Received: from [9.179.28.5] (unknown [9.179.28.5])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  1 Dec 2023 11:18:43 +0000 (GMT)
Message-ID: <aab0905a-b77f-4504-a510-83c98f79b2b7@linux.ibm.com>
Date:   Fri, 1 Dec 2023 12:18:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 7/7] net/smc: manage system EID in SMC stack
 instead of ISM driver
To:     Wen Gu <guwen@linux.alibaba.com>, wenjia@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, kgraul@linux.ibm.com, jaka@linux.ibm.com
Cc:     borntraeger@linux.ibm.com, svens@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        raspl@linux.ibm.com, schnelle@linux.ibm.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1701343695-122657-1-git-send-email-guwen@linux.alibaba.com>
 <1701343695-122657-8-git-send-email-guwen@linux.alibaba.com>
Content-Language: en-US
From:   Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <1701343695-122657-8-git-send-email-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FhuwSygUbyqQmJDW3VqesCgWrJ_W82Es
X-Proofpoint-GUID: J4vhBy5WdwyS8I8f6ghFE4d9QqdS_khM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_09,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312010074
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.11.23 12:28, Wen Gu wrote:
> The System EID (SEID) is an internal EID that is used by the SMCv2
> software stack that has a predefined and constant value representing
> the s390 physical machine that the OS is executing on. So it should
> be managed by SMC stack instead of ISM driver and be consistent for
> all ISMv2 device (including virtual ISM devices) on s390 architecture.
> 
> Suggested-by: Alexandra Winter <wintera@linux.ibm.com>
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---

Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>


[...]
> diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
> index a33f861..ac88de2 100644
> --- a/net/smc/smc_ism.c
> +++ b/net/smc/smc_ism.c
[...]
> @@ -431,14 +452,8 @@ static void smcd_register_dev(struct ism_dev *ism)
>  
>  	mutex_lock(&smcd_dev_list.mutex);
>  	if (list_empty(&smcd_dev_list.list)) {
> -		u8 *system_eid = NULL;
> -
> -		system_eid = smcd->ops->get_system_eid();
> -		if (smcd->ops->supports_v2()) {
> +		if (smcd->ops->supports_v2())
>  			smc_ism_v2_capable = true;
> -			memcpy(smc_ism_v2_system_eid, system_eid,
> -			       SMC_MAX_EID_LEN);
> -		}
>  	}

Just a comment:
Here we only check the first smcd device to determine whether we support v2.
Which is ok, for today's platform firmware ISM devices, as they are always the same version.

When you add virtual ISM devices (loopback-ism, virtio-ism) then this needs to be changed.
IMO the logic then needs to be "if all smcd devices support v2,
then smc_ism_v2_capable = true;
else smc_ism_v2_capable = false;"

I don't know if you would like to change that now in this patch, or later when
you add when you add the support for loopback.



