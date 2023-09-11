Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0D379C052
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378212AbjIKWal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236527AbjIKKzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 06:55:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A741F1;
        Mon, 11 Sep 2023 03:54:56 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38B9gROX030546;
        Mon, 11 Sep 2023 10:54:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=zGnItAZ5Y73mezR2PoXBSScT3FaAj2yQZBN9eCn9dGI=;
 b=TrQX8p7O3qTnIyzoqf8Ht7HvBmpZMckGWmJdM0AvxMQKWE+BR8zajcgelEOYg3AT3C9k
 odK7xicFvsfiqM/Jre7Lqp8jLKws4COrFo77ecGG+1F6Oh3jNHnNgtCQw7uJ+AMeFMrQ
 jU8LJGv5QzyL7dSgDueQ0XXuskiDlDqAJrkLb6dRbBtTM1DqXgAdyyH65HxHo4UVcQMX
 KLlVT6zmVVxLe7ihH/GE5yEw1EkAo4PGJTa8s2rc0ynPQdZp2LZf3iaRG64voxAmYzPH
 K7PBb44zySVdFd7TxKfpKDFvMqEu/nhwDEuNYUBFw0myjQNrZ/fkCVV7XE4YL5Gq9JDP uA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t1xkjre8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 10:54:25 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38BArNJc014747
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 10:54:21 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 11 Sep
 2023 03:51:47 -0700
Message-ID: <35c9d1b1-0f48-b873-d703-c880f3b91422@quicinc.com>
Date:   Mon, 11 Sep 2023 16:21:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 09/17] pstore/ram: Use dynamic ramoops reserve resource
Content-Language: en-US
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
CC:     <corbet@lwn.net>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>,
        <vigneshr@ti.com>, <nm@ti.com>, <matthias.bgg@gmail.com>,
        <kgene@kernel.org>, <alim.akhtar@samsung.com>,
        <bmasney@redhat.com>, <quic_tsoni@quicinc.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <kernel@quicinc.com>
References: <1694290578-17733-1-git-send-email-quic_mojha@quicinc.com>
 <1694290578-17733-10-git-send-email-quic_mojha@quicinc.com>
 <20425ace-3ef5-4eaf-8319-999bafa34a07@quicinc.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20425ace-3ef5-4eaf-8319-999bafa34a07@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Wi2REeSTnAgDa98w0pTipeomyJ0cJ4JQ
X-Proofpoint-ORIG-GUID: Wi2REeSTnAgDa98w0pTipeomyJ0cJ4JQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309110099
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/11/2023 11:03 AM, Pavan Kondeti wrote:
> On Sun, Sep 10, 2023 at 01:46:10AM +0530, Mukesh Ojha wrote:
>> As dynamic ramoops command line parsing is now added, so
>> lets add the support in ramoops driver to get the resource
>> structure and add it during platform device registration.
>>
>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>> ---
>>   fs/pstore/ram.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
> 
> Documentation/admin-guide/ramoops.rst might need an update as well.

I have said in the cover-letter under changes in v5, it is open for
comment and not yet documented it yet.

> 
>> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
>> index 2f625e1fa8d8..e73fbbc1b5b5 100644
>> --- a/fs/pstore/ram.c
>> +++ b/fs/pstore/ram.c
>> @@ -913,13 +913,17 @@ static void __init ramoops_register_dummy(void)
>>   
>>   	/*
>>   	 * Prepare a dummy platform data structure to carry the module
>> -	 * parameters. If mem_size isn't set, then there are no module
>> -	 * parameters, and we can skip this.
>> +	 * parameters. If mem_size isn't set, check for dynamic ramoops
>> +	 * size and extract the information if it is set.
>>   	 */
>> -	if (!mem_size)
>> +	if (!mem_size && !dyn_ramoops_res.end)
>>   		return;
>>   
>>   	pr_info("using module parameters\n");
>> +	if (dyn_ramoops_res.end) {
>> +		mem_size = resource_size(&dyn_ramoops_res);
>> +		mem_address = dyn_ramoops_res.start;
>> +	}
>>   
>>   	memset(&pdata, 0, sizeof(pdata));
>>   	pdata.mem_size = mem_size;
> 
> You might want to add "arch_" prefix to dyn_ramoops resource so that it
> would be clear that it is coming from arch code. This code needs to
> guard against arch not supplying this.

Sure, thanks for pointing this.
Agree, if we finally decide to keep it in arch/arm64 .

-Mukesh
> 
> Thanks,
> Pavan
