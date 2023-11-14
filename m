Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C707EAFE0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjKNMbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjKNMbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:31:31 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63A113A;
        Tue, 14 Nov 2023 04:31:28 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEBn11W011963;
        Tue, 14 Nov 2023 12:31:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wKlUcmUmISCBZkF7UbykgoFN5VU5wbK7JYflZom7Itg=;
 b=R3ZtiEByz3D84KvW59SmuLTqozHVpJj7ovgibMZfg9L4ZAuhqWoEDcsdWatRSVgYuIMc
 IrMjQL7YsYqX/J2f1nU3NJVsTDjGyx5m+mHbVeVQD97dnY9rNzAN+3/zSWSemmHpsXBH
 e5aVnzHejH5+x2PwzMx2S6OtoitnLPS7g7sfOW4v6uOYRwNVgvodU7bRjr+LgSCrpLfS
 gLPax/oOYdJhngOTaB8II4LYxlz0j9cvEbcCiiRP19cfXymWpDN/MExYSR840J/sXdYB
 7JhXZO6nqV82gboD46M0IVS0e9wCUXM4zr9R3eAcw3zLNg6aG5lMwhrupy6wdDHbesVf wg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ubqfdj7fp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 12:31:08 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AECV70q015866
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 12:31:07 GMT
Received: from [10.216.63.64] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 14 Nov
 2023 04:31:03 -0800
Message-ID: <364309dc-60d6-3250-b77b-f27935ab41a0@quicinc.com>
Date:   Tue, 14 Nov 2023 18:00:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: timer list corruption in devfreq
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
CC:     <myungjoo.ham@samsung.com>, <kyungmin.park@samsung.com>,
        <cw00.choi@samsung.com>, <jstultz@google.com>,
        <tglx@linutronix.de>, <sboyd@kernel.org>, <jiangshanlai@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <1699459797-21703-1-git-send-email-quic_mojha@quicinc.com>
 <ZU0uNy6l0ZuzBmlf@slm.duckdns.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <ZU0uNy6l0ZuzBmlf@slm.duckdns.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oTcRF3PJT8ocwbec1FLSy3to7AhWhF9t
X-Proofpoint-ORIG-GUID: oTcRF3PJT8ocwbec1FLSy3to7AhWhF9t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_11,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 mlxlogscore=864 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140096
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/10/2023 12:38 AM, Tejun Heo wrote:
> Hello,
> 
> On Wed, Nov 08, 2023 at 09:39:57PM +0530, Mukesh Ojha wrote:
>> We are facing an issue on 6.1 kernel while using devfreq framework
>> and looks like the devfreq_monitor_stop()/devfreq_monitor_start is
>> vulnerable if frequent governor change is being done from user space
>> in a loop.
>>
>> echo simple_ondemand > /sys/class/devfreq/1d84000.ufshc/governor
>> echo performance > /sys/class/devfreq/1d84000.ufshc/governor
>>
>> Here, we are using ufs device, but could be any device.
>>
>> Issue is because same instance of timer is being queued from two
>> places one from devfreq_monitor() and one from devfreq_monitor_start() as
>> cancel_delayed_work_sync() from devfreq_monitor_stop() was not
>> able to delete the delayed work time completely due to which
>> devfreq_monitor() work rearmed the same timer.
>>
>> But there looks to be issue in the timer framework where
>> it was initially discussed in [1] and later fixed in [2]
>> but not sure being whether is it issue in cancel_delayed_work_sync()
>> where del_timer() inside try_to_grab_pending() need to be replaced
>> with timer_delete[_sync]() or devfreq_monitor_stop() need to use
>> this api's and then delete the work.
> 
> So, having shutdown can be more convenient in some cases and that'd be a
> useful addition to workqueue both for immediate and delayed work items. That
> said, that's usually not essential in fixing these issues - e.g. Can't you
> just synchronize devfreq_monitor_start() and stop()?

Thanks for the feedback..

This issue can be fixed with synchronizing devfreq_monitor_[start/stop()].

Posted here,
https://lore.kernel.org/all/1699957648-31299-1-git-send-email-quic_mojha@quicinc.com/

However, It forces the client to have a check in delayed work callback
to not queue the new delayed work timer. It is also possible if
del_timer in below sequence[1] return 'false' but do not want
another instance of the timer to be queued after a call to
cancel_delayed_work_sync() which is what can be achieved with
timer_shutdown() version of __cancel_work_timer or may be a
separate __cancel_work_timer_shutdown() introduction.

[1]
__cancel_work_timer=>try_to_grab_pending=>del_timer()

Let me know if anything wrong with my understanding.

-Mukesh



> 
> Thanks.
> 
