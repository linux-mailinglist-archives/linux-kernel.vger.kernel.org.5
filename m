Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D056D776F1D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 06:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjHJEeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 00:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjHJEeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 00:34:12 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11CD1BFB;
        Wed,  9 Aug 2023 21:34:11 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37A40uxx003109;
        Thu, 10 Aug 2023 04:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=S6kR75ySZnvGmsxssLy9ggxyIjSq4gTPXGHsEqsypTo=;
 b=SdGDsP5o2Kxip8zQe7WQB4ZQ8ADs7jLyzeSnrajFIZi1D0ky8UsUOLv1wZmy7RC7vmNY
 PBn0BOJuztbiI4udlNPnzP9CM3QXMPCAgE2rJ5hb4IYpmdFp6SUlKw27m98n/7+gC1eF
 Ykp6Yyoxo73WJMw6c/QhbT0Fn2VLLKwxjngQBhWSqAg8yaZ39mVfd0nzZl9q8p9wUvWL
 xGPEifx2zZ5izvB9gvcuPJx4Vh6x+qRarqlLrM364Xls4u0XmZtqV28IdogUSpujIUHC
 svla3pCyjT3psHBBSG9Yhn17Ugd+tlyJ0p5p1yc8Zv2yVVSoEJVLR9HlVFffguduRp73 bQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3scbcghhe8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 04:34:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37A4Y1Vf003711
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 04:34:01 GMT
Received: from [10.204.118.225] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 9 Aug
 2023 21:33:58 -0700
Message-ID: <85d7c7a3-7a11-bae0-6f37-5da9280792aa@quicinc.com>
Date:   Thu, 10 Aug 2023 10:03:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] Revert "Revert "wifi: ath11k: Enable threaded NAPI""
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
CC:     Johan Hovold <johan+linaro@kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230809073432.4193-1-johan+linaro@kernel.org>
 <42f78c02-1ddc-cf1c-694f-abf9059dfb60@quicinc.com>
 <ZNNZVsFb3_Dt_NMb@hovoldconsulting.com>
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
In-Reply-To: <ZNNZVsFb3_Dt_NMb@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3OdR80ellf5Zx3VsXgJtm23VYCn5uN1W
X-Proofpoint-ORIG-GUID: 3OdR80ellf5Zx3VsXgJtm23VYCn5uN1W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_02,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 mlxlogscore=805 mlxscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308100038
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/2023 2:46 PM, Johan Hovold wrote:
> On Wed, Aug 09, 2023 at 02:32:37PM +0530, Manikanta Pubbisetty wrote:
>> On 8/9/2023 1:04 PM, Johan Hovold wrote:
>>> This reverts commit d265ebe41c911314bd273c218a37088835959fa1.
>>>
>>> Disabling threaded NAPI causes the Lenovo ThinkPad X13s to hang (e.g. no
>>> more interrupts received) almost immediately during RX.
>>>
>>> Apparently something broke since commit 13aa2fb692d3 ("wifi: ath11k:
>>> Enable threaded NAPI") so that a simple revert is no longer possible.
>>>
>>
>> This is getting as weird as it would get :)
>>
>>> As commit d265ebe41c91 ("Revert "wifi: ath11k: Enable threaded NAPI"")
>>> does not address the underlying issue reported with QCN9074, it seems we
>>> need to reenable threaded NAPI before fixing both bugs properly.
>>>
>>
>> It seems that the revert has actually solved the issue reported with
>> QCN9074.
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=217536
> 
> Sure, but it's only a workaround as the underlying cause has not been
> identified.
> 
>> We were trying to reproduce the problem on X86+QCN9074 (with threaded
>> NAPI) from quite some time, but there is no repro yet.
>>
>> Actually, enabling/disabling threaded NAPI is a simple affair; I'm
>> wondering to hear that interrupts are blocked due  to not having
>> threaded NAPI.
> 
> It sounds to me like the driver's locking is broken if moving to softirq
> processing hangs the machine like this. But I have not had time to try
> to try to track it down besides verifying that reenabling threaded NAPI
> makes the problem go away.
> 
>> What is the chip that Lenovo Thinkpad X13s is having?
> 
> It's a WCN6855 (QCNFA765).
> 

WCN6855 & QCN9074 share the same driver code base since both being PCIe 
devices. One working and another not working seems to be surprising. Do 
you have a dmesg log when this problem occurred?

We are working on to root cause the original problem. The hindrance as 
of today is that we are not able to repro this so far in Qualcomm. We 
are planning to work with the reporter to get more logs.

Thanks,
Manikanta
