Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694097EC429
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344017AbjKONzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbjKONzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:55:01 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2DE187
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 05:54:56 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFBnNUg030950;
        Wed, 15 Nov 2023 13:54:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dka66wUauTg6oFS+tZQnvbXhJ6hWL+82fFo2lu0kdvM=;
 b=fbeI1fjzhjr9r6no0GVFqqwmzYYXOmh8Kb/hPnPx79KisncWf5vvjdzXKdVFCbjKLCaI
 hgg0SmmSMZzi8Du/MTrcfcU6a7MFoDg1EsoJqWpVPctSlhZ+7/SiikxRFZ8U0X3/KYlH
 VM99PWRg++2Raa5obgBIBu6c85L/JGOHE/RV9zlwkNBo0E2x3JwYfgodj7faHgxfMmQ7
 pEug853ZKzc2MWICssVwvfrI1wN9ER6D4vZz68AmhjpRttjSb+aVRHJWVa/RTJLUatmj
 6ymLc35LrGnRiEIeZEDoHTEE7EF+egcT3MTVQrdwr7EKLQ4OAIaMZ2LAoBlNTkP8x22L MQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ucg2ua0jy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 13:54:45 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AFDsjTI008314
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 13:54:45 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 15 Nov
 2023 05:54:43 -0800
Message-ID: <5ee9b7a2-d10f-791e-8880-2c0e2389529e@quicinc.com>
Date:   Wed, 15 Nov 2023 19:24:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] workqueue: Make a warning when a pending delay work being
 re-init
Content-Language: en-US
To:     huangzaiyang <huangzaiyang@oppo.com>, <tj@kernel.org>,
        <jiangshanlai@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, ZaiYang Huang <hzy0719@163.com>
References: <20231115113427.1420-1-huangzaiyang@oppo.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20231115113427.1420-1-huangzaiyang@oppo.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Zz-3gVOQW8cu8qDwym19yV2jUGf8vpoc
X-Proofpoint-GUID: Zz-3gVOQW8cu8qDwym19yV2jUGf8vpoc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_13,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311150108
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/15/2023 5:04 PM, huangzaiyang wrote:
> There is a timer_list race condition if a delay work is queued twice,
> this usually won't happen unless someone reinitializes the task before performing the enqueue operation,likeï¼?
> https://github.com/torvalds/linux/blob/master/drivers/devfreq/devfreq.c#L487
> A warning message will help developers identify this irregular usage.
> 
> Signed-off-by: ZaiYang Huang <hzy0719@163.com>

I like the idea to have this for developers.

Acked-by: Mukesh Ojha <quic_mojha@quicinc.com>

> ---
>   include/linux/workqueue.h | 33 ++++++++++++++++++---------------
>   1 file changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
> index 24b1e5070f4d..54102ed794e5 100644
> --- a/include/linux/workqueue.h
> +++ b/include/linux/workqueue.h
> @@ -266,6 +266,22 @@ static inline void destroy_delayed_work_on_stack(struct delayed_work *work) { }
>   static inline unsigned int work_static(struct work_struct *work) { return 0; }
>   #endif
> 
> +/**
> + * work_pending - Find out whether a work item is currently pending
> + * @work: The work item in question
> + */
> +#define work_pending(work) \
> +       test_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))
> +
> +/**
> + * delayed_work_pending - Find out whether a delayable work item is currently
> + * pending
> + * @w: The work item in question
> + */
> +#define delayed_work_pending(w) \
> +       work_pending(&(w)->work)
> +
> +
>   /*
>    * initialize all of a work item in one go
>    *
> @@ -310,6 +326,7 @@ static inline unsigned int work_static(struct work_struct *work) { return 0; }
> 
>   #define __INIT_DELAYED_WORK(_work, _func, _tflags)                     \
>          do {                                                            \
> +               WARN_ON(delayed_work_pending(_work));                   \
>                  INIT_WORK(&(_work)->work, (_func));                     \
>                  __init_timer(&(_work)->timer,                           \
>                               delayed_work_timer_fn,                     \
> @@ -318,6 +335,7 @@ static inline unsigned int work_static(struct work_struct *work) { return 0; }
> 
>   #define __INIT_DELAYED_WORK_ONSTACK(_work, _func, _tflags)             \
>          do {                                                            \
> +               WARN_ON(delayed_work_pending(_work));

However, I don't think it will be applicable for _ONSTACK variable as it
is on stack.
                    \
>                  INIT_WORK_ONSTACK(&(_work)->work, (_func));             \
>                  __init_timer_on_stack(&(_work)->timer,                  \
>                                        delayed_work_timer_fn,            \
> @@ -342,21 +360,6 @@ static inline unsigned int work_static(struct work_struct *work) { return 0; }
>   #define INIT_RCU_WORK_ONSTACK(_work, _func)                            \
>          INIT_WORK_ONSTACK(&(_work)->work, (_func))
> 
> -/**
> - * work_pending - Find out whether a work item is currently pending
> - * @work: The work item in question
> - */
> -#define work_pending(work) \
> -       test_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))
> -
> -/**
> - * delayed_work_pending - Find out whether a delayable work item is currently
> - * pending
> - * @w: The work item in question
> - */
> -#define delayed_work_pending(w) \
> -       work_pending(&(w)->work)
> -
>   /*
>    * Workqueue flags and constants.  For details, please refer to
>    * Documentation/core-api/workqueue.rst.
> --
> 2.17.1

Please remove this ..

-Mukesh
> 
> ________________________________
> OPPO
> 
> ±¾µç×ÓÓÊ¼þ¼°Æä¸½¼þº¬ÓÐOPPO¹«Ë¾µÄ±£ÃÜÐÅÏ¢£¬½öÏÞÓÚÓÊ¼þÖ¸Ã÷µÄÊÕ¼þÈË£¨°üº¬¸öÈË¼°Èº×é£©Ê¹ÓÃ¡£½ûÖ¹ÈÎºÎÈËÔÚÎ´¾­ÊÚÈ¨µÄÇé¿öÏÂÒÔÈÎºÎÐÎÊ½Ê¹ÓÃ¡£Èç¹ûÄú´íÊÕÁË±¾ÓÊ¼þ£¬ÇÐÎð´«²¥¡¢·Ö·¢¡¢¸´ÖÆ¡¢Ó¡Ë¢»òÊ¹ÓÃ±¾ÓÊ¼þÖ®ÈÎºÎ²¿·Ö»òÆäËùÔØÖ®ÈÎºÎÄÚÈÝ£¬²¢ÇëÁ¢¼´ÒÔµç×ÓÓÊ¼þÍ¨Öª·¢¼þÈË²¢É¾³ý±¾ÓÊ¼þ¼°Æä¸½¼þ¡£
> ÍøÂçÍ¨Ñ¶¹ÌÓÐÈ±ÏÝ¿ÉÄÜµ¼ÖÂÓÊ¼þ±»½ØÁô¡¢ÐÞ¸Ä¡¢¶ªÊ§¡¢ÆÆ»µ»ò°üº¬¼ÆËã»ú²¡¶¾µÈ²»°²È«Çé¿ö£¬OPPO¶Ô´ËÀà´íÎó»òÒÅÂ©¶øÒýÖÂÖ®ÈÎºÎËðÊ§¸Å²»³Ðµ£ÔðÈÎ²¢±£ÁôÓë±¾ÓÊ¼þÏà¹ØÖ®Ò»ÇÐÈ¨Àû¡£
> ³ý·ÇÃ÷È·ËµÃ÷£¬±¾ÓÊ¼þ¼°Æä¸½¼þÎÞÒâ×÷ÎªÔÚÈÎºÎ¹ú¼Ò»òµØÇøÖ®ÒªÔ¼¡¢ÕÐÀ¿»ò³ÐÅµ£¬ÒàÎÞÒâ×÷ÎªÈÎºÎ½»Ò×»òºÏÍ¬Ö®ÕýÊ½È·ÈÏ¡£ ·¢¼þÈË¡¢ÆäËùÊô»ú¹¹»òËùÊô»ú¹¹Ö®¹ØÁª»ú¹¹»òÈÎºÎÉÏÊö»ú¹¹Ö®¹É¶«¡¢¶­ÊÂ¡¢¸ß¼¶¹ÜÀíÈËÔ±¡¢Ô±¹¤»òÆäËûÈÎºÎÈË£¨ÒÔÏÂ³Æ¡°·¢¼þÈË¡±»ò¡°OPPO¡±£©²»Òò±¾ÓÊ¼þÖ®ÎóËÍ¶ø·ÅÆúÆäËùÏíÖ®ÈÎºÎÈ¨Àû£¬Òà²»¶ÔÒò¹ÊÒâ»ò¹ýÊ§Ê¹ÓÃ¸ÃµÈÐÅÏ¢¶øÒý·¢»ò¿ÉÄÜÒý·¢µÄËðÊ§³Ðµ£ÈÎºÎÔðÈÎ¡£
> ÎÄ»¯²îÒìÅûÂ¶£ºÒòÈ«ÇòÎÄ»¯²îÒìÓ°Ïì£¬µ¥´¿ÒÔYES\OK»òÆäËû¼òµ¥´Ê»ãµÄ»Ø¸´²¢²»¹¹³É·¢¼þÈË¶ÔÈÎºÎ½»Ò×»òºÏÍ¬Ö®ÕýÊ½È·ÈÏ»ò½ÓÊÜ£¬ÇëÓë·¢¼þÈËÔÙ´ÎÈ·ÈÏÒÔ»ñµÃÃ÷È·ÊéÃæÒâ¼û¡£·¢¼þÈË²»¶ÔÈÎºÎÊÜÎÄ»¯²îÒìÓ°Ïì¶øµ¼ÖÂ¹ÊÒâ»ò´íÎóÊ¹ÓÃ¸ÃµÈÐÅÏ¢ËùÔì³ÉµÄÈÎºÎÖ±½Ó»ò¼ä½ÓËðº¦³Ðµ£ÔðÈÎ¡£
> This e-mail and its attachments contain confidential information from OPPO, which is intended only for the person or entity whose address is listed above. Any use of the information contained herein in any way (including, but not limited to, total or partial disclosure, reproduction, or dissemination) by persons other than the intended recipient(s) is prohibited. If you are not the intended recipient, please do not read, copy, distribute, or use this information. If you have received this transmission in error, please notify the sender immediately by reply e-mail and then delete this message.
> Electronic communications may contain computer viruses or other defects inherently, may not be accurately and/or timely transmitted to other systems, or may be intercepted, modified ,delayed, deleted or interfered. OPPO shall not be liable for any damages that arise or may arise from such matter and reserves all rights in connection with the email.
> Unless expressly stated, this e-mail and its attachments are provided without any warranty, acceptance or promise of any kind in any country or region, nor constitute a formal confirmation or acceptance of any transaction or contract. The sender, together with its affiliates or any shareholder, director, officer, employee or any other person of any such institution (hereinafter referred to as "sender" or "OPPO") does not waive any rights and shall not be liable for any damages that arise or may arise from the intentional or negligent use of such information.
> Cultural Differences Disclosure: Due to global cultural differences, any reply with only YES\OK or other simple words does not constitute any confirmation or acceptance of any transaction or contract, please confirm with the sender again to ensure clear opinion in written form. The sender shall not be responsible for any direct or indirect damages resulting from the intentional or misuse of such information.
> ________________________________
> OPPO
> 
> 本电子邮件及其附件含有OPPO公司的保密信息，仅限于邮件指明的收件人（包含个人及群组）使用。禁止任何人在未经授权的情况下以任何形式使用。如果您错收了本邮件，切勿传播、分发、复制、印刷或使用本邮件之任何部分或其所载之任何内容，并请立即以电子邮件通知发件人并删除本邮件及其附件。
> 网络通讯固有缺陷可能导致邮件被截留、修改、丢失、破坏或包含计算机病毒等不安全情况，OPPO对此类错误或遗漏而引致之任何损失概不承担责任并保留与本邮件相关之一切权利。
> 除非明确说明，本邮件及其附件无意作为在任何国家或地区之要约、招揽或承诺，亦无意作为任何交易或合同之正式确认。 发件人、其所属机构或所属机构之关联机构或任何上述机构之股东、董事、高级管理人员、员工或其他任何人（以下称“发件人”或“OPPO”）不因本邮件之误送而放弃其所享之任何权利，亦不对因故意或过失使用该等信息而引发或可能引发的损失承担任何责任。
> 文化差异披露：因全球文化差异影响，单纯以YES\OK或其他简单词汇的回复并不构成发件人对任何交易或合同之正式确认或接受，请与发件人再次确认以获得明确书面意见。发件人不对任何受文化差异影响而导致故意或错误使用该等信息所造成的任何直接或间接损害承担责任。
> This e-mail and its attachments contain confidential information from OPPO, which is intended only for the person or entity whose address is listed above. Any use of the information contained herein in any way (including, but not limited to, total or partial disclosure, reproduction, or dissemination) by persons other than the intended recipient(s) is prohibited. If you are not the intended recipient, please do not read, copy, distribute, or use this information. If you have received this transmission in error, please notify the sender immediately by reply e-mail and then delete this message.
> Electronic communications may contain computer viruses or other defects inherently, may not be accurately and/or timely transmitted to other systems, or may be intercepted, modified ,delayed, deleted or interfered. OPPO shall not be liable for any damages that arise or may arise from such matter and reserves all rights in connection with the email.
> Unless expressly stated, this e-mail and its attachments are provided without any warranty, acceptance or promise of any kind in any country or region, nor constitute a formal confirmation or acceptance of any transaction or contract. The sender, together with its affiliates or any shareholder, director, officer, employee or any other person of any such institution (hereinafter referred to as "sender" or "OPPO") does not waive any rights and shall not be liable for any damages that arise or may arise from the intentional or negligent use of such information.
> Cultural Differences Disclosure: Due to global cultural differences, any reply with only YES\OK or other simple words does not constitute any confirmation or acceptance of any transaction or contract, please confirm with the sender again to ensure clear opinion in written form. The sender shall not be responsible for any direct or indirect damages resulting from the intentional or misuse of such information.
