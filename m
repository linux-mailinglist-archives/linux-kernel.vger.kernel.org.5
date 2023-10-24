Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CA37D4CF9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbjJXJyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjJXJyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:54:09 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EDB83;
        Tue, 24 Oct 2023 02:54:07 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39O7xbcL002048;
        Tue, 24 Oct 2023 09:54:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=R5T/Jdrr21/BhDX3iJZH8nMfjInIu+4kITpjaH/Ovvw=;
 b=QUIG+DmLgwg2Wq+QWU+WhekQEHSk6ZTFsLMLeJ4b21T5cdP8ftHiUiL6+4gJDO3xmznt
 wn9NufimGNmo6q4QUzLuXbXebjFHZSY0GZQMId7Du8I48+I8F5J6RunXjRhaNkx1OhLI
 vvZiRiU0ZLF5E7lyXH1MHGRYmBz1Dmm3yMOKQCk6dQabKVI7P9VwH3xD/nI2pGT3PeIA
 I+6xIIZpJHh2nfQaGWSdOYEqHgNgK6R1jXWhwiNOUGEbnBwOE2otfFRi1j9gazF/1Qnc
 pWIcgfQuU1vd4temjJTBCLvBIpBew8kWOf6qHNiAwlyPkQ2TTVjPSzw9N3hE7c0eTwn0 Sg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3twxn41daq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 09:54:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39O9s2gP024070
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 09:54:02 GMT
Received: from [10.239.132.245] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 24 Oct
 2023 02:53:57 -0700
Message-ID: <0578d070-e41b-bd22-72ca-e366ea9a5ed2@quicinc.com>
Date:   Tue, 24 Oct 2023 17:53:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 0/5] soc/arm64: qcom: add initial version of memory
 dump
Content-Language: en-US
To:     Caleb Connolly <caleb.connolly@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        <quic_tingweiz@quicinc.com>
References: <1698052857-6918-1-git-send-email-quic_zhenhuah@quicinc.com>
 <092c7a54-edb9-4ff5-8c35-a936461111df@linaro.org>
From:   Zhenhua Huang <quic_zhenhuah@quicinc.com>
In-Reply-To: <092c7a54-edb9-4ff5-8c35-a936461111df@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Kyb_eYZVwD-UAeDKlEI9qKMn5vq9IoCs
X-Proofpoint-ORIG-GUID: Kyb_eYZVwD-UAeDKlEI9qKMn5vq9IoCs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_09,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1011 spamscore=0 mlxlogscore=536 lowpriorityscore=0 phishscore=0
 mlxscore=0 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310240083
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/10/23 22:31, Caleb Connolly wrote:
> 
> 
> On 23/10/2023 10:20, Zhenhua Huang wrote:
>> Qualcomm memory dump driver is to cooperate with firmware, providing the
>> hints(id and size) of storing useful debugging information into pre-allocated
>> memory. Firmware then does the real data capture. The debugging information
>> includes cache contents, internal memory, registers.
>>
>> The driver dynamically reserves memory and provides the hints(dump id and size)
>> following specified protocols with firmware. After crash and warm reboot,
>> firmware scans these information and stores contents into reserved memory
>> accordingly. Firmware then enters into full dump mode which dumps whole DDR
>> to host through USB.
>>
>> User then get full dump using PCAT and can parse out these informations.
> 
> PCAT is a proprietary tool that requires signing up to qualcomm.com and
> installing the Qualcomm Package Manager to access. It also relies on
> another tool (QUTS) to actually interact with the board.
> 

Oh.. I saw PCAT is introduced in doc of RB5 development kit so tried 
with it as well. I will investigate more on this. Thanks.

> Shouldn't we have a FOSS (or at the very least OSS) tool that can be
> used to interact with these memory dumps?
>>
>> Dump id and size are provided by bootconfig. The expected format of a
>> bootconfig file is as follows:-
>> memory_dump_config {
>> 	<node name> {
>> 		id = <id of HW component>
>> 		size = <dump size of HW component>
>> 	}
>> }
>>
>> for example:
>> memory_dump_config {
>>          c0_context_dump {
>> 		id = 0
>> 		size = 0x800
>>          }
>> }
>>
>> Test based on 6.6-rc1.
>>
>> Zhenhua Huang (5):
>>    dt-bindings: soc: qcom: Add memory_dump driver bindings
>>    dt-bindings: sram: qcom,imem: document sm8250
>>    soc: qcom: memory_dump: Add memory dump driver
>>    arm64: defconfig: enable Qcom Memory Dump driver
>>    arm64: dts: qcom: sm8250: Add memory dump node
>>
>>   .../bindings/soc/qcom/qcom,mem-dump.yaml           |  42 ++
>>   .../devicetree/bindings/sram/qcom,imem.yaml        |  45 ++
>>   MAINTAINERS                                        |   7 +
>>   arch/arm64/boot/dts/qcom/sm8250.dtsi               |  31 ++
>>   arch/arm64/configs/defconfig                       |   1 +
>>   drivers/soc/qcom/Kconfig                           |  11 +
>>   drivers/soc/qcom/Makefile                          |   1 +
>>   drivers/soc/qcom/memory_dump.c                     | 540 +++++++++++++++++++++
>>   8 files changed, 678 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,mem-dump.yaml
>>   create mode 100644 drivers/soc/qcom/memory_dump.c
>>
> 
