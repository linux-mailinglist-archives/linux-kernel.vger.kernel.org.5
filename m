Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C6F7D87E9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 19:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbjJZR67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 13:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbjJZR65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 13:58:57 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B66192;
        Thu, 26 Oct 2023 10:58:54 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39QEKaYr017276;
        Thu, 26 Oct 2023 17:58:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=k/QqVua+OhGtONEfnzazmJjYfXyO1Q3pQk/rLCM9z/0=;
 b=e47RZrCvcW8xqs6+s4O53m4HUY2L1T0w7HLAhCMgfftv4WWFFcQetyFsE3CaSLENkgvs
 vSTOWPoKS+YCnnGoB69aCXxhFiOZoInYMCX+M4BpLcYI2wcE380tPkzLfr6E2hVnBc3n
 DGeNZhHVYwkMAuLTlEuzlF1/IA599g79kcpF44hwRz8MqUeMFNRN9LzuJQIO56z4X4O9
 WZ4+ieAgqVr9XIyZZh29MoADXmkhKRXGO8uwPUw+FJ1cU+HK4xyoIeB/PWK+/NI4fLBO
 wZM/Wj1fMz/YTcJqjRESOzvsFXTAp/Zu73y5MKGkumXudLsQKn1Rgpnjyl5lAHYNcoMk tw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tykw29f8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 17:58:31 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39QHwUwe027175
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 17:58:30 GMT
Received: from [10.251.44.39] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 26 Oct
 2023 10:58:26 -0700
Message-ID: <9a7f77cf-77bc-4a5a-af11-51464fbfdaf4@quicinc.com>
Date:   Thu, 26 Oct 2023 20:58:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: iommu: Add Translation Buffer Unit
 bindings
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <will@kernel.org>, <joro@8bytes.org>, <devicetree@vger.kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_cgoldswo@quicinc.com>, <quic_sukadev@quicinc.com>,
        <quic_pdaly@quicinc.com>, <quic_sudaraja@quicinc.com>,
        <djakov@kernel.org>
References: <20231019021923.13939-1-quic_c_gdjako@quicinc.com>
 <20231019021923.13939-2-quic_c_gdjako@quicinc.com>
 <20231024184248.GA252155-robh@kernel.org>
 <56bbb2ad-5cea-46ad-83be-d6d7fd9bbfde@arm.com>
From:   Georgi Djakov <quic_c_gdjako@quicinc.com>
In-Reply-To: <56bbb2ad-5cea-46ad-83be-d6d7fd9bbfde@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 56i69dhbWJbmVRK1hGCUmPyZkk70GDhf
X-Proofpoint-GUID: 56i69dhbWJbmVRK1hGCUmPyZkk70GDhf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_15,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=801 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 mlxscore=0 clxscore=1011 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310260154
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

Thanks for taking a look at this!

On 10/25/2023 1:26 AM, Robin Murphy wrote:
> On 2023-10-24 19:42, Rob Herring wrote:
>> On Wed, Oct 18, 2023 at 07:19:18PM -0700, Georgi Djakov wrote:
>>> The "apps_smmu" on the Qualcomm sdm845 platform is an implementation
>>> of the ARM SMMU-500, that consists of a single TCU (Translation Control
>>> Unit) and multiple TBUs (Translation Buffer Units). The TCU is already
>>> being described in the ARM SMMU DT schema. Add also bindings for the
>>> TBUs so that we can describe their properties.
>>
>> Arm SMMU-500 is an implementation, too. Is QCom's a modified
>> implementation or you are just the first to want to control TBU
>> resources?
> 
> It's very very modified. The stock MMU-500 has very few microarchitectural registers[1], they all live within the regular SMMU address space, are all Secure-only by default, and don't do anything like the shenanigans here.
> 
> That said, looking at patch #3, I don't really understand why we need any of this stuff upstream... AFAICS it's doing an insane amount of work to use complicated imp-def debug functionality to duplicate things that the main driver can already do far more efficiently. Sure, in general it seems like it could potentially be useful stuff for bringing up and debugging a new driver, but the Linux SMMUv2 driver is mature and frankly already closer to being obsolete than to being new...

Yes, the arm-smmu driver already does similar stuff with the ATS feature, but this unfortunately isn't available in Qualcomm's implementation. Instead of that, there is this eCATS thing for debugging various issues including hardware issues. It supports many features, but here we use it just for hardware page table walks. And in the majority of cases it's expected that the software and hardware page table walks give the same result, but if there is a difference, it's sign of a problem. For example, it helped in the past to trace some power management issues of the SMMU. This of course is a debug feature and can enabled when needed.

> [ digression since I can't be bothered to split this discussion by replying separately to patch #3: ]
> 
> I mean, just looking at qsmmuv500_iova_to_phys(), you do realise that that's going to be called potentially multiple times by iommu-dma for *every* dma_sync and dma_unmap call and really wants to be fast, right? This brings to mind all the work I did a couple of years back[2] because strict TLB invalidation on unmap was considered too slow for certain devices on QCom platforms by ChromeOS, yet what this achieves looks like it could easily be up to an order of magnitude slower again :(

No, this is not going to be called for every dma_sync and dma_unmap. In patch 5 we register a custom context_fault handler that uses this code to get information from the TBUs. So all of this is executed only when a context fault occurs. Does this sound acceptable?

[..]>>> +description:
>>> +  TBU nodes represent Translation Buffer Units in an ARM SMMU. Each TBU node
>>> +  should be a child node of the SMMU in the device tree.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - qcom,qsmmuv500-tbu
>>> +
>>> +  reg:
>>> +    items:
>>> +      - description: Address and size of the TBU's register space.
>>> +
>>> +  reg-names:
>>> +    items:
>>> +      - const: base
>>> +
>>> +  clocks:
>>> +    maxItems: 1
>>> +
>>> +  interconnects:
>>> +    maxItems: 1
> 
> What does this interconnect represent? MMU-500 TBUs don't access memory themselves[3], they only have an internal AXI Stream interface to the TCU to request translations.

It's to enable access from the CPU to the register space of the TBUs.

Thanks,
Georgi
