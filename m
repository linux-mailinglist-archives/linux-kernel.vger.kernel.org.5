Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DD279CC94
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbjILJ7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjILJ7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:59:05 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E000B1BB;
        Tue, 12 Sep 2023 02:59:01 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38C6d7RI008489;
        Tue, 12 Sep 2023 09:58:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2DnRQjtry5xhrgCcDUz9TXqy4/mB/m7tgsPNaHQBrLo=;
 b=ghgZYz16cFVhognQmTgdCAQa58byx8ZGIOAX5VUcm7b3/+XxyRKqOTARr9Tz6nC97kQ4
 0OaE+qbdIZtw+RL/K8Fz3zH3gSbTEPIjHSunzHKAYc5gauPiAoDFId14ll7HOu8Oy7ut
 cHXpAt/bGNCC4P3QsiCtlQEbN/5FXB3ygamPTiaayDRpVtW2H5fvHIzJ4g3eDUjzDqQX
 V13IVUYP8Pfg5jGMkxwoI9jCE7sZfNpD6Ph3WWLsrs0kU0txQWdXV61RiQqW2LfmswQH
 WvJaG1eqWxmxTbRxsuUUJmEFimNlKlOFHsay1iyUC09sBhGY5c85mO2/L/CY3Fsh0SUR QQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t22hyjm9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 09:58:25 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38C9wObY013903
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 09:58:24 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 12 Sep
 2023 02:58:08 -0700
Message-ID: <777a031b-7295-371d-0f08-0247a365b2f5@quicinc.com>
Date:   Tue, 12 Sep 2023 15:28:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 06/17] soc: qcom: Add Qualcomm APSS minidump kernel
 driver
Content-Language: en-US
From:   Mukesh Ojha <quic_mojha@quicinc.com>
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
In-Reply-To: <0eeef9c4-14c0-8283-803b-4684854d4be6@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nTsXh_FuCi6fS3h9yomC8mkAb_rHlCUt
X-Proofpoint-GUID: nTsXh_FuCi6fS3h9yomC8mkAb_rHlCUt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_07,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 phishscore=0 spamscore=0
 impostorscore=0 mlxscore=0 adultscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309120084
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/12/2023 2:56 PM, Mukesh Ojha wrote:
> Thanks for your time in reviewing this.
> 
> On 9/11/2023 4:31 PM, Krzysztof Kozlowski wrote:
>> On 09/09/2023 22:16, Mukesh Ojha wrote:
>>> Minidump is a best effort mechanism to collect useful and predefined
>>> data for first level of debugging on end user devices running on
>>> Qualcomm SoCs. It is built on the premise that System on Chip (SoC)
>>> or subsystem part of SoC crashes, due to a range of hardware and
>>> software bugs. Hence, the ability to collect accurate data is only
>>> a best-effort. The data collected could be invalid or corrupted,
>>> data collection itself could fail, and so on.
>>
>> ...
>>
>>> +static int qcom_apss_md_table_init(struct minidump *md,
>>> +                   struct minidump_subsystem *mdss_toc)
>>> +{
>>> +    struct minidump_ss_data *mdss_data;
>>> +
>>> +    mdss_data = devm_kzalloc(md->dev, sizeof(*mdss_data), GFP_KERNEL);
>>> +    if (!mdss_data)
>>> +        return -ENOMEM;
>>> +
>>> +    mdss_data->md_ss_toc = mdss_toc;
>>> +    mdss_data->md_regions = devm_kcalloc(md->dev, MAX_NUM_ENTRIES,
>>> +                         sizeof(struct minidump_region),
>>> +                         GFP_KERNEL);
>>> +    if (!mdss_data->md_regions)
>>> +        return -ENOMEM;
>>> +
>>> +    mdss_toc = mdss_data->md_ss_toc;
>>> +    mdss_toc->regions_baseptr = 
>>> cpu_to_le64(virt_to_phys(mdss_data->md_regions));
>>> +    mdss_toc->enabled = cpu_to_le32(MINIDUMP_SS_ENABLED);
>>> +    mdss_toc->status = cpu_to_le32(1);
>>> +    mdss_toc->region_count = cpu_to_le32(0);
>>> +
>>> +    /* Tell bootloader not to encrypt the regions of this subsystem */
>>> +    mdss_toc->encryption_status = cpu_to_le32(MINIDUMP_SS_ENCR_DONE);
>>> +    mdss_toc->encryption_required = 
>>> cpu_to_le32(MINIDUMP_SS_ENCR_NOTREQ);
>>> +
>>> +    md->apss_data = mdss_data;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int qcom_apss_minidump_probe(struct platform_device *pdev)
>>> +{
>>> +    struct minidump_global_toc *mdgtoc;
>>> +    struct minidump *md;
>>> +    size_t size;
>>> +    int ret;
>>> +
>>> +    md = devm_kzalloc(&pdev->dev, sizeof(struct minidump), GFP_KERNEL);
>>
>> sizeof(*)
>>
>> Didn't you get such comments already?
> 
> Ok, will fix this, no i have not got such comments as of yet.
> Any reason of using this way?

Got the reason, thanks.

-Mukesh

> 
>>
>>
>>> +    if (!md)
>>> +        return -ENOMEM;
>>> +
>>> +    md->dev = &pdev->dev;
>>> +    mdgtoc = qcom_smem_get(QCOM_SMEM_HOST_ANY, SBL_MINIDUMP_SMEM_ID, 
>>> &size);
>>> +    if (IS_ERR(mdgtoc)) {
>>> +        ret = PTR_ERR(mdgtoc);
>>> +        dev_err(md->dev, "Couldn't find minidump smem item: %d\n", 
>>> ret);
>>> +        return ret;
>>
>> The syntax is:
>> return dev_err_probe
> 
> ACK.
> 
>>
>>> +    }
>>> +
>>> +    if (size < sizeof(*mdgtoc) || !mdgtoc->status) {
>>> +        dev_err(md->dev, "minidump table is not initialized: %d\n", 
>>> ret);
>>
>> ret is uninitialized here. Please use automated tools for checking your
>> code:
>> coccinelle, smatch and sparse
> 
> Thanks.
> 
>>
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    mutex_init(&md->md_lock);
>>> +    ret = qcom_apss_md_table_init(md, 
>>> &mdgtoc->subsystems[MINIDUMP_APSS_DESC]);
>>> +    if (ret) {
>>> +        dev_err(md->dev, "apss minidump initialization failed: 
>>> %d\n", ret);
>>> +        return ret;
>>> +    }
>>> +
>>> +    /* First entry would be ELF header */
>>> +    ret = qcom_md_add_elfheader(md);
>>> +    if (ret) {
>>> +        dev_err(md->dev, "Failed to add elf header: %d\n", ret);
>>> +        memset(md->apss_data->md_ss_toc, 0, sizeof(struct 
>>> minidump_subsystem));
>>
>> Why do you need it?
> 
> Earlier, i got comment about clearing the SS TOC(subsystem table of 
> content) which is shared with other SS and it will have stale values.
> 
>>
>>> +        return ret;
>>> +    }
>>> +
>>> +    platform_set_drvdata(pdev, md);
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static int qcom_apss_minidump_remove(struct platform_device *pdev)
>>> +{
>>> +    struct minidump *md = platform_get_drvdata(pdev);
>>> +    struct minidump_ss_data *mdss_data;
>>> +
>>> +    mdss_data = md->apss_data;
>>> +    memset(mdss_data->md_ss_toc, cpu_to_le32(0), sizeof(struct 
>>> minidump_subsystem));
>>
>> Why do you need it?
> 
> Same as above.
> 
>>
>>> +    md = NULL;
>>
>> That's useless assignment.
> 
> Ok.
> 
>>
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static struct platform_driver qcom_minidump_driver = {
>>> +    .probe = qcom_apss_minidump_probe,
>>> +    .remove = qcom_apss_minidump_remove,
>>> +    .driver  = {
>>> +        .name = "qcom-minidump-smem",
>>> +    },
>>> +};
>>> +
>>> +module_platform_driver(qcom_minidump_driver);
>>> +
>>> +MODULE_DESCRIPTION("Qualcomm APSS minidump driver");
>>> +MODULE_LICENSE("GPL");
>>> +MODULE_ALIAS("platform:qcom-minidump-smem");
>>
>> Add a proper ID table instead of re-inventing it with module aliases.
> 
> Ok.
> 
> -Mukesh
> 
>>
>> Best regards,
>> Krzysztof
>>
