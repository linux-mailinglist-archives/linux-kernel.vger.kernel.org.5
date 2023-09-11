Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B9079BAF1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355549AbjIKWAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244137AbjIKTKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:10:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF02DD;
        Mon, 11 Sep 2023 12:10:17 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BGsgtC012385;
        Mon, 11 Sep 2023 19:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=yhQj70atmgvOsT2e/TS2qijd+F031F5vj/yr5hSo3NI=;
 b=PMq83McfwsxSX5TjgyapKf9sl6HiVFHrY8Ua0OU0LGSwlf8dDct/0Rf72FodkvRzLYJG
 jdOrbn9zzhlIKX57BFLI/nDFIsvCSLEpFFEi6YlKKPTB6PP/6yAsEbfClZ5nlj1CFq4Z
 8m2N2X+5cUUfzhg+ozceCIl2A2I6Y2/uHHYbgVfT/gHfO9E9A1n/1hOT00yyRg8VZfBJ
 vLZiUpMMWf9vJTcXVEgdxwagMk1+K//S9E/doUQosffx+VyvCsLlHvqBiPcBGhqpCGRv
 d48SRjFEWXsxR0oH4DTJHhhcafze2l36DXy2XQOSwGOgyGQxMHPc7HMMSy/3F51BK9Mq sw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t24ra8r01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 19:09:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38BJ9axL023805
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 19:09:36 GMT
Received: from [10.111.183.71] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 11 Sep
 2023 12:09:32 -0700
Message-ID: <36d9bd32-7ea4-4d84-b1e9-3cfcc3bec85c@quicinc.com>
Date:   Mon, 11 Sep 2023 12:09:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/17] soc: qcom: Add Qualcomm APSS minidump kernel
 driver
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>, <corbet@lwn.net>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>,
        <vigneshr@ti.com>, <nm@ti.com>, <matthias.bgg@gmail.com>,
        <kgene@kernel.org>, <alim.akhtar@samsung.com>,
        <bmasney@redhat.com>, <quic_tsoni@quicinc.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <kernel@quicinc.com>
References: <1694290578-17733-1-git-send-email-quic_mojha@quicinc.com>
 <1694290578-17733-7-git-send-email-quic_mojha@quicinc.com>
 <e35a8b4f-ba1a-514e-9c59-a74442f0cb1f@linaro.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <e35a8b4f-ba1a-514e-9c59-a74442f0cb1f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7KeKQW4RhvHCzdB5VM5NQ_6O6ebGKDeO
X-Proofpoint-ORIG-GUID: 7KeKQW4RhvHCzdB5VM5NQ_6O6ebGKDeO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_14,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 suspectscore=0 phishscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110175
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/2023 4:07 AM, Krzysztof Kozlowski wrote:
> On 09/09/2023 22:16, Mukesh Ojha wrote:
>> +/**
>> + * qcom_minidump_region_register() - Register region in APSS Minidump table.
>> + * @region: minidump region.
>> + *
>> + * Return: On success, it returns 0 and negative error value on failure.
>> + */
>> +int qcom_minidump_region_register(const struct qcom_minidump_region *region)
>> +{
>> +	struct minidump *md;
>> +	int ret;
>> +
>> +	md = qcom_smem_minidump_ready();
>> +	if (!md)
>> +		return -EPROBE_DEFER;
>> +
>> +	if (!qcom_minidump_valid_region(region))
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&md->md_lock);
>> +	ret = qcom_md_region_register(md, region);
>> +	if (ret)
>> +		goto unlock;
>> +
>> +	qcom_md_update_elfheader(md, region);
>> +unlock:
>> +	mutex_unlock(&md->md_lock);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(qcom_minidump_region_register);
> 
> NAK, there is no user for this.
> 
> Drop all exports from minidump drivers. Your upstream driver *must not*
> expose stuff to your vendor drivers.

Do we not expect that upstream drivers would want to register?
Mind you, in the downstream code the following was a bad limitation:
#define MAX_NUM_OF_SS           10


