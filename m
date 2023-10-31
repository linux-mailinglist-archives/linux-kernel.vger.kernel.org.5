Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBFF7DC4AF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 04:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjJaDAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 23:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjJaDAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 23:00:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B2BA6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 20:00:14 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39V1vXdB002765;
        Tue, 31 Oct 2023 03:00:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=geDnbE64EracsMZJfga61W8eyuH74nvGH/Og9mMRIXU=;
 b=Bnpq8VXDv2FJjPYnujubg+eolwgZQV6a1eMWcDjsrok8+nY9FoEgQgILlLWnB6xqkA2I
 i4FJ178k9HiZmLJWsGaLdSPQzPX8PnL35pBmYR+5mO+hta2egDhuYhegZ0FNyB9h4Rb3
 6jn4EzIhFL5dQAov/+HhOgl+irwSBMiRVteZCw8Rq2twv65L9DwlkyZK98ZuVeVzXWBi
 Pqfa6MVfbqSyseTi8kwkYuuLqERikI1E/M9swV1aoPYtF8C/W+RMoayHUqJ17cJ5HlrX
 n/bIb7kNfA4QPCyvM4lj1TrrpCxky0EXXb7PdV/fh22r199LqYaqR/uAxcEXBt+t4CuF Tw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u2chyhp9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 03:00:11 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39V30A9D000698
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 03:00:10 GMT
Received: from [10.233.17.145] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 30 Oct
 2023 20:00:08 -0700
Message-ID: <5266fe30-849d-4c84-ac5e-7b456ea15929@quicinc.com>
Date:   Tue, 31 Oct 2023 11:00:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to pass software configuration to driver built as module in
 boot up phase
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>
References: <1c001c6f-9902-4803-9406-39e3325422bf@quicinc.com>
 <20231031083500.343b39efded46acf1d349628@kernel.org>
From:   Tingwei Zhang <quic_tingweiz@quicinc.com>
In-Reply-To: <20231031083500.343b39efded46acf1d349628@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: l-ML_sJY1jFYHSbD1uM_EG9W3W96HhI2
X-Proofpoint-GUID: l-ML_sJY1jFYHSbD1uM_EG9W3W96HhI2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxscore=0 adultscore=0 mlxlogscore=933 spamscore=0 phishscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310022
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/2023 7:35 AM, Masami Hiramatsu (Google) wrote:
> On Mon, 30 Oct 2023 19:21:48 +0800
> Tingwei Zhang <quic_tingweiz@quicinc.com> wrote:
> 
>> Hi Masami, Greg and Rafael,
>>
>> I have one driver that needs a bunch to software configuration like 1000
>> settings. These settings can be different according to the use case.
> 
> Is it an out-of-tree driver which can not be embedded?
Current it's out-of-tree and we are trying to get it accepted.
> 
>>
>> They are required in boot up phase so we can't reply on user space to
>> make the configuration.
>>
>> Boot config is not preferred since we'd like to build that driver as
>> dynamic load Kernel module.
>>
>> Could you let me know if there's any mechanism in Kernel to do that?
> 
> Hm, it is interesting situation. So I made the bootconfig API and data
> released after boot (only keep it in /proc/bootconfig). So I thought
> module loader script can parse it and pass params to the modules.
If we use bootconfig API in driver, it can't be built as module. 
Compilation won't pass.
> But I did not expected that the number of params is about 1000.
> 
> Thank you,
> 

-- 
Thanks,
Tingwei

