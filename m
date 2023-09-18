Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377187A4CDD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjIRPm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjIRPmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:42:19 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99C910F6;
        Mon, 18 Sep 2023 08:42:06 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38ICv8BG009815;
        Mon, 18 Sep 2023 15:01:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=pzDWu196/vVfc5Cy6n7DSpFd3OI9eHlBm42sWI2Kw8M=;
 b=aK1ofPuG0f4SWui9IY+VrjnI4JYMXo0kSfP/e4UurKxMAQ/j9IulNuUqJjTFR04WHsMS
 15B95CktnNiK1i8qiYgoCR5CgeE7AqVWrIAmkpf9bze8F5+95/5GutaeY9Z/LqUUgBi9
 cgatOwp796YcRJvYZPa+5Uyg/PLlokOL8wF4pndIFwEDXQYmf8WIe992MnNija5NtSe4
 uP0g2n7dMIO5rW4nx9n2q3OX1cMsBX6LQc8vVkwY46sA7R537i+Y2UxRYlI0rbsWKm5l
 CToC5Yt14DzClitjvpiUmgpyPLe/uZwvDMt7N3LED7WGIzkThSwG/M9/F5uXr427Q8Go sQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t6pmq08sm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 15:01:27 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38IF1RXC011944
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 15:01:27 GMT
Received: from [10.110.81.225] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 18 Sep
 2023 08:01:26 -0700
Message-ID: <0efe305e-031b-bdf5-0268-ca1c6d562653@quicinc.com>
Date:   Mon, 18 Sep 2023 08:01:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 0/4] Add qcom hvc/shmem transport support
To:     <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230911194359.27547-1-quic_nkela@quicinc.com>
Content-Language: en-US
From:   Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <20230911194359.27547-1-quic_nkela@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: M4f-170Wm_3aMa5RAadGq8DqTd9dsuf9
X-Proofpoint-ORIG-GUID: M4f-170Wm_3aMa5RAadGq8DqTd9dsuf9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_08,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309180131
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle Ping!

On 9/11/2023 12:43 PM, Nikunj Kela wrote:
> This change augments smc transport to include support for Qualcomm virtual
> platforms by passing a parameter(capability-id) in the hypervisor call to
> identify which doorbell to assert. This parameter is dynamically generated
> at runtime on the device and insuitable to pass via the devicetree.
>
> The function ID and parameter are stored by firmware in the shmem region.
>
> This has been tested on ARM64 virtual Qualcomm platform.
>
> ---
> v4 -> port the changes into smc.c
>
> v3 -> fix the compilation error reported by the test bot,
>        add support for polling based instances
>
> v2 -> use allOf construct in dtb schema,
>        remove wrappers from mutexes,
>        use architecture independent channel layout
>
> v1 -> original patches
>
> Nikunj Kela (4):
>    firmware: arm_scmi: Add polling support for completion in smc
>    dt-bindings: arm: convert nested if-else construct to allOf
>    dt-bindings: arm: Add new compatible for smc/hvc transport for SCMI
>    firmware: arm_scmi: Add qcom hvc/shmem transport support
>
>   .../bindings/firmware/arm,scmi.yaml           | 67 +++++++++++--------
>   drivers/firmware/arm_scmi/Kconfig             | 14 ++++
>   drivers/firmware/arm_scmi/driver.c            |  1 +
>   drivers/firmware/arm_scmi/smc.c               | 62 +++++++++++++++--
>   4 files changed, 110 insertions(+), 34 deletions(-)
>
