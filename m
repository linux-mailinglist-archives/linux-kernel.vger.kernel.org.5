Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD84E788D98
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 19:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344192AbjHYRIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 13:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344210AbjHYRII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 13:08:08 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A34C2108;
        Fri, 25 Aug 2023 10:08:06 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PFX7xM029576;
        Fri, 25 Aug 2023 17:07:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=zrcOYqst1jA/BrPRmT0sjHMxf9tJX2mEdJjblw8uuts=;
 b=gcldzpLNbWOpvM4e/mWznQ0B2Ga7tIUgVsIbs2Qy3fcmRdw9cBP4B75hP8tE1tq1MhSi
 wkxn0qX0xaXFaI/Wtmz7TgQSPcpG2bIQGDm0jZ6HUMoGhT8+QIgyP+10p1AudKcItfSO
 L3Lyh7kGONvgkH7Fh3+nTJo3q9wlxVpnpnkG/z4tlWxff3i0LYXoyY4F7RQ4poVXHHkg
 12ZWiuUAK7ebdF/Emr5TlVwdnXOAyXxyP5S+EctIa3mBugeOFtDWChlVDILlZHtLHO3f
 qzqq8jPwdZnubbGJXiiIzPFDmQubEqlLA0/rFXfxD07EglP+3WanR6lsaq57QS1uBFgs gg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3spmtxsdt0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 17:07:53 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37PH7qGe023250
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 17:07:52 GMT
Received: from [10.110.11.89] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 25 Aug
 2023 10:07:52 -0700
Message-ID: <362594bc-6315-0125-ff80-33894c8d9337@quicinc.com>
Date:   Fri, 25 Aug 2023 10:07:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC DNM] perf: Add support for Qualcomm Last-Level Cache
 Controller PMU
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
CC:     Marijn Suijten <marijn.suijten@somainline.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20230809-topic-llcc_pmu-v1-1-dd27bd1f44c9@linaro.org>
 <f71bc35a-c45c-0429-1164-d047d61ef061@quicinc.com>
 <b46d8e10-5f25-4350-b5b9-77bf5885780f@linaro.org>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <b46d8e10-5f25-4350-b5b9-77bf5885780f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Xp4nCQYJfWKYuHKQjAoM3PwVHJIXX9M9
X-Proofpoint-GUID: Xp4nCQYJfWKYuHKQjAoM3PwVHJIXX9M9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_15,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250153
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/2023 4:50 AM, Konrad Dybcio wrote:
> On 24.08.2023 23:31, Trilok Soni wrote:
>> On 8/9/2023 1:09 PM, Konrad Dybcio wrote:
>>> Add support for the Qualcomm LLCC (Last-Level Cache Controller) PMU,
>>> which provides a single event, expressing cache read misses.
>>>
>>> Based on the vendor driver found in the msm-5.10 downstream kernel.
>>>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>> Hi, I've been trying to get this driver going upstream by cleaning it
>>> up and adding the necessary perf boilerplate (the original Qualcomm one
>>> only pokes at the PMU from within the kernel itself) to use the
>>> userspace tool.
>>>
>>> I can not however get it to cooperate.. in this iteration I get a PMU
>>> event registered (though with only a "raw" name - no "x OR y" like with
>>> other PMUs on the system) as:
>>>
>>> llcc_pmu/read_miss/                                [Kernel PMU event]
>>>
>>> but the .read callback is never called when I run:
>>>
>>> sudo perf stat -C 0 -a -e llcc_pmu/read_miss/ stress-ng -C 8 -c 8 -m 10
>>>
>>> which always returns 0
>>>
>>> if I add --always-kernel I get:
>>> <not supported>      llcc_pmu/read_miss/
>>
>> Which SOC you are trying this on?
> 8250

Thanks. Let me see if my team can try this on latest SOCs and if it is 
the same behavior. Did you tried reading the counter by "printk" in the 
kernel and see the values are dumped from the register?


-- 
---Trilok Soni

