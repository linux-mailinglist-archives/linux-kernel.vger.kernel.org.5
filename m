Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B4E79E083
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 09:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238502AbjIMHKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 03:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238367AbjIMHKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 03:10:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D921726;
        Wed, 13 Sep 2023 00:10:27 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38D6Ld4e032251;
        Wed, 13 Sep 2023 07:10:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=qqRVKtn6/zyJ17CeKnTMdnuTgtPxVETYhHbBrmlREPw=;
 b=ghG+PRtO5O0X6vZ4Xh3f9VBp8PMbtP+X2XnBsyoSIejQ5qwoEjmEda6/oSz54D5DG3uN
 s1O3DpdB1bng3T6r1l5K6GC3o9e9z8S7IL+2JEaiEhSAoJ+8WjRQJigGmb521gO3I1+B
 IGv2AM/0tE15ueO7oTqybrCgW3N3kwvogrJ+gxe+QUjN7+ZXYwyBlG3BMXpKFmnIUOua
 nX/gwKLrMpXwhw0nMdtAUiwGwFnPOBzcpC1Vt6LOsHxVmOyNR5JSFLYXSwIz+ncgdYJu
 NymOt6ejVAMxMI8OSarMc0QY6NKnk+jlwdGVJ6OtiKkny3MaH69SSRhPHKUP4Y2y8pPH bQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t2y8jrxe8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 07:10:01 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38D7A0vs000953
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 07:10:00 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 13 Sep
 2023 00:09:48 -0700
Message-ID: <fe7d618d-ca22-0fd4-efc0-cad52cb984bc@quicinc.com>
Date:   Wed, 13 Sep 2023 12:39:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 06/17] soc: qcom: Add Qualcomm APSS minidump kernel
 driver
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <corbet@lwn.net>, <agross@kernel.org>, <andersson@kernel.org>,
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
 <3bb1e84f-3b65-0596-1b6b-6decb0ff53cc@linaro.org>
 <0eeef9c4-14c0-8283-803b-4684854d4be6@quicinc.com>
 <94770fc6-7d72-8283-5858-786685620d5c@linaro.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <94770fc6-7d72-8283-5858-786685620d5c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0R0xqRb59Cba6lgs1UtXK0Q91VYNBJeX
X-Proofpoint-GUID: 0R0xqRb59Cba6lgs1UtXK0Q91VYNBJeX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_24,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 impostorscore=0 spamscore=0 mlxlogscore=929 malwarescore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309130059
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/12/2023 3:24 PM, Krzysztof Kozlowski wrote:
> On 12/09/2023 11:26, Mukesh Ojha wrote:
>>>
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	mutex_init(&md->md_lock);
>>>> +	ret = qcom_apss_md_table_init(md, &mdgtoc->subsystems[MINIDUMP_APSS_DESC]);
>>>> +	if (ret) {
>>>> +		dev_err(md->dev, "apss minidump initialization failed: %d\n", ret);
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	/* First entry would be ELF header */
>>>> +	ret = qcom_md_add_elfheader(md);
>>>> +	if (ret) {
>>>> +		dev_err(md->dev, "Failed to add elf header: %d\n", ret);
>>>> +		memset(md->apss_data->md_ss_toc, 0, sizeof(struct minidump_subsystem));
>>>
>>> Why do you need it?
>>
>> Earlier, i got comment about clearing the SS TOC(subsystem table of
>> content) which is shared with other SS and it will have stale values.
> 
> OK, but then the entire code is poorly readable. First, any cleanup of
> qcom_apss_md_table_init() should be named similarly, e.g.
> qcom_apss_md_table_clean() or qcom_apss_md_table_exit() or whatever
> seems feasible.

ACK on this.

> 
> Second, shouldn't writing to shared memory be the last step? Step which
> cannot fail and there is no cleanup afterwards (like
> platform_set_drvdata)? I don't enjoy looking at this interface...

It can be done, if i shift adding elf header as first thing to first
caller of qcom_minidump_region_register() but then i would have to 
remove qcom_ramoops_minidump() from this probe in 11/17 patch.

-Mukesh
> 
> 
> 
> Best regards,
> Krzysztof
> 
