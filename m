Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9005D753ED1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 17:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236046AbjGNP0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 11:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbjGNP0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 11:26:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC42E30C0;
        Fri, 14 Jul 2023 08:26:34 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36ECbstq019424;
        Fri, 14 Jul 2023 15:26:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KlTyfug7EZTBZKaQpxZzWcVPGIFRszohTvpxdR5Kc6k=;
 b=ixhfhWtHAH5MMBtVuvcB7T+CAwWuyvrqrit2WO+RxmSM4gZFUohL3Dt+SYWt6TAJbDsv
 UqNrJNSDvfOrEPizTj27/tMO1j/KiWGurbjxu4kiCQyewmL0rHY9VQAZFe/riA9QwqJx
 ZODC1f0JfTBrmnpyoqyh2DrjA45KDwymCTZtpl+TQ5fgLQW11OeXc+CC/l+ozDQJ0Uu6
 oAz7PziZ5lt2fqTKTHi6GMJcq08Si80VrKvqWyrMbBOb/ynoZNJdnLpDLQvnnveZfnUv
 glFvbv2Bf6gokOfQnvxVMNzTKK/ADJJDDfdkzsYpfQQDQWYLook+8liu+lL5Nc0NclSr TQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rtpts23jr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 15:26:12 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36EFQBK1031783
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 15:26:11 GMT
Received: from [10.216.56.39] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 14 Jul
 2023 08:25:59 -0700
Message-ID: <d77f5601-2b08-a7c7-1400-7ab68b8add3a@quicinc.com>
Date:   Fri, 14 Jul 2023 20:55:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 00/21] Add Qualcomm Minidump kernel driver related
 support
To:     Kathiravan T <quic_kathirav@quicinc.com>, <corbet@lwn.net>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
 <c712597e-f870-f224-fc1b-90c6f8f19710@quicinc.com>
Content-Language: en-US
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <c712597e-f870-f224-fc1b-90c6f8f19710@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: k6kW04K-HSKuFwXlBT09sQYlyELKk4zM
X-Proofpoint-ORIG-GUID: k6kW04K-HSKuFwXlBT09sQYlyELKk4zM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_06,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307140140
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Hi Mukesh,
> 
> For IPQ chipsets, for the crashdump to work, we need the below patch
> 
> firmware: scm: Modify only the download bits in TCSR register
> 
> can you post the below patches separately? Looks like minidump will take 
> some time and also I don't see any dependencies for these to go along 
> with the minidump. Given that, will it be possible to post the below 
> patches separately?
> 
>    firmware: qcom_scm: provide a read-modify-write function
>    pinctrl: qcom: Use qcom_scm_io_update_field()
>    firmware: scm: Modify only the download bits in TCSR register
> 
> Do let us know if we can take these patches and post it separately.

Yes, we can post this separately.

-Mukesh
> 
>>
>>   Documentation/admin-guide/index.rst                |   1 +
>>   Documentation/admin-guide/qcom_minidump.rst        | 293 +++++++++++
>>   .../devicetree/bindings/soc/qcom/qcom,ramoops.yaml | 126 +++++
>>   MAINTAINERS                                        |  15 +
>>   arch/arm64/boot/dts/qcom/sm8450.dtsi               |  12 +
>>   arch/arm64/configs/defconfig                       |   4 +
>>   drivers/firmware/Kconfig                           |  11 -
>>   drivers/firmware/qcom_scm.c                        |  85 ++-
>>   drivers/pinctrl/qcom/pinctrl-msm.c                 |  12 +-
>>   drivers/remoteproc/qcom_common.c                   | 142 +----
>>   drivers/soc/qcom/Kconfig                           |  39 ++
>>   drivers/soc/qcom/Makefile                          |   3 +
>>   drivers/soc/qcom/qcom_minidump.c                   | 582 
>> +++++++++++++++++++++
>>   drivers/soc/qcom/qcom_minidump_internal.h          |  98 ++++
>>   drivers/soc/qcom/qcom_minidump_smem.c              | 387 ++++++++++++++
>>   drivers/soc/qcom/qcom_pstore_minidump.c            | 210 ++++++++
>>   drivers/soc/qcom/smem.c                            |   9 +
>>   fs/pstore/ram.c                                    |  26 +-
>>   include/linux/firmware/qcom/qcom_scm.h             |   2 +
>>   include/linux/pstore_ram.h                         |   2 +
>>   include/soc/qcom/qcom_minidump.h                   |  64 +++
>>   kernel/kallsyms.c                                  |   2 +-
>>   22 files changed, 1973 insertions(+), 152 deletions(-)
>>   create mode 100644 Documentation/admin-guide/qcom_minidump.rst
>>   create mode 100644 
>> Documentation/devicetree/bindings/soc/qcom/qcom,ramoops.yaml
>>   create mode 100644 drivers/soc/qcom/qcom_minidump.c
>>   create mode 100644 drivers/soc/qcom/qcom_minidump_internal.h
>>   create mode 100644 drivers/soc/qcom/qcom_minidump_smem.c
>>   create mode 100644 drivers/soc/qcom/qcom_pstore_minidump.c
>>   create mode 100644 include/soc/qcom/qcom_minidump.h
>>
