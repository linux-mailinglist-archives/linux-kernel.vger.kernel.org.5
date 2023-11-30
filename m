Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3F47FF357
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346204AbjK3PTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346053AbjK3PTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:19:40 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D2310E4;
        Thu, 30 Nov 2023 07:19:46 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUFIA2H023978;
        Thu, 30 Nov 2023 15:19:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=77cknAywjb3vJ0XHOP+azo+o2YZ4goxYI+iunv5cNkc=;
 b=Zq5m9SiUXxY2h1wbcV+obb8yRmbXrTqJosuMDX8dbAWqH2Ttp8dWh4gsroHOduC8ViEn
 B2pC7kjgnYnDTRwEENPtilgVy8oypg5+V9CYsrFVejDgVSseNnRkPj492YvLOpSaeABC
 5nPBk7gDdEz/JrBIsvl+hk//TLbgPgZHiApKrNIQPPDCmRwA+8AY+3dkNOMPvNNT0rNc
 Czmmax0HW1IsBtPFEN0rn6ZOYFuEAAgkQIMglG7S3f1nfW8PWNSQBXojasQVFWDbows7
 NzXJvS9o5j0XsOZ9+jF6diujGGllgzca6WOoUGIrgPssubxxkG8Pk6s2a49o4IJxfPG3 pw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3upbxsjep2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2023 15:19:22 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AUFJLw2003303
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2023 15:19:21 GMT
Received: from [10.251.45.12] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 30 Nov
 2023 07:19:16 -0800
Message-ID: <47f40099-4215-4c9e-9b7a-c5b981abc589@quicinc.com>
Date:   Thu, 30 Nov 2023 17:19:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Add support for Translation Buffer Units
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <joro@8bytes.org>
CC:     <devicetree@vger.kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_cgoldswo@quicinc.com>,
        <quic_sukadev@quicinc.com>, <quic_pdaly@quicinc.com>,
        <quic_sudaraja@quicinc.com>, <djakov@kernel.org>
References: <20231118042730.2799-1-quic_c_gdjako@quicinc.com>
 <fe74b1ab-078d-4c53-9133-cf7ab00a656d@linaro.org>
Content-Language: en-US
From:   Georgi Djakov <quic_c_gdjako@quicinc.com>
In-Reply-To: <fe74b1ab-078d-4c53-9133-cf7ab00a656d@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OBdVb95uphT6pHD6u44i1ixvLsUD4i29
X-Proofpoint-GUID: OBdVb95uphT6pHD6u44i1ixvLsUD4i29
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_14,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=804 lowpriorityscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311300110
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/2023 1:21 PM, Bryan O'Donoghue wrote:
> On 18/11/2023 04:27, Georgi Djakov wrote:
>> The TCUs (Translation Control Units) and TBUs (Translation Buffer
>> Units) are key components of the MMU-500. Multiple TBUs are connected
>> to a single TCU over an interconnect. Each TBU contains a TLB that
>> caches page tables. The MMU-500 implements a TBU for each connected
>> master, and the TBU is designed, so that it is local to the master.
>>
>> The Qualcomm SDM845 platform has an implementation of the SMMU-500,
>> that has multiple TBUs. A DT schema is added to describe the resources
>> for each TBU (register space, power-domains, interconnects and clocks).
>>
>> The TBU driver will manage the resources and allow the system to
>> operate the TBUs during a context fault to obtain details by doing
>> s1 inv, software + hardware page table walks etc. This is implemented
>> with ATOS/eCATs as the ATS feature is not supported. Being able to
>> query the TBUs is useful for debugging various hardware/software
>> issues on these platforms.
>>
>> v2:
>> - Improve DT binding description, add full example. (Konrad)
>> - Drop Qcom specific stuff from the generic binding. (Rob)
>> - Unconditionally try to populate subnodes. (Konrad)
>> - Improve TBU driver commit text, remove memory barriers. (Bjorn)
>> - Move TBU stuff into separate file. Make the driver builtin.
>> - TODO: Evaluate whether to keep TBU support as a separate driver
>>    or just instantiate things from qcom_smmu_impl_init()
>>
>> v1: https://lore.kernel.org/r/20231019021923.13939-1-quic_c_gdjako@quicinc.com
> 
> What is your suggested way to test this series ?

Hi Bryan,

Just break some driver to initiate a memory transaction with no valid context. I used venus for that. Or the simplest would be to just specify an invalid stream ID in DT for some device.

Thanks,
Georgi
