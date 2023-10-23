Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A92D7D3647
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 14:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbjJWMTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 08:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbjJWMTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 08:19:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F75FD;
        Mon, 23 Oct 2023 05:19:49 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39NCJkV9013225;
        Mon, 23 Oct 2023 12:19:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6Vh6tIspITarSOm3ojfMImIkGB++8w5DHKrNpdHIc6c=;
 b=DDTpblGk8PrNhRHaGxETWGlIeJ0DtitF1Xhr0xHwVESLhgwVjTS+3vMew9eMTWPiKtnh
 vAEiupq+W7c4QsxdCwOJ4g2P2ft9+iw9hBN3NJCGem0vmCnOj7LMop4dEPn+CWKkJvgZ
 HKZjBdXAiAcREo1ttCWiW5BjnqsDevSbCF311q0rh2axXuszT46EiTpm2MSrN8HQAy9T
 CTp3hViZ2cUyvgXDEQeT4xTA7qR4vG0RK80gxH5hOlojnetkYe+WOvctNuo+ijqhQNB2
 N9+LDW3CLfEKH+2WjxhKgBe/UL0sX3cc0LyJdWR7uhNEulZMyrS/tiCpfzt0ZmrggAWk Dg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tv6v8ve15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 12:19:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39NCJ5jv032423
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 12:19:05 GMT
Received: from [10.239.132.245] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 23 Oct
 2023 05:19:00 -0700
Message-ID: <10848e69-b994-b562-d5d3-25a7ca40cb97@quicinc.com>
Date:   Mon, 23 Oct 2023 20:18:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 0/5] soc/arm64: qcom: add initial version of memory
 dump
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        <quic_tingweiz@quicinc.com>
References: <1698052857-6918-1-git-send-email-quic_zhenhuah@quicinc.com>
 <70072874-6fa8-46ba-bf26-c35aa6ec7bb6@linaro.org>
From:   Zhenhua Huang <quic_zhenhuah@quicinc.com>
In-Reply-To: <70072874-6fa8-46ba-bf26-c35aa6ec7bb6@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9RoYCXResJIlj9C7uClwCt_KiZaj4zbY
X-Proofpoint-ORIG-GUID: 9RoYCXResJIlj9C7uClwCt_KiZaj4zbY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=231 mlxscore=0 phishscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310170001 definitions=main-2310230108
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/10/23 17:25, Krzysztof Kozlowski wrote:
> On 23/10/2023 11:20, Zhenhua Huang wrote:
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
> 
> How does it relate to minidump?

Minidump is used for dumping *software* related data/information. While 
the memory dump is used to communicate with firmware to dump *hardware* 
related information.

> 
>>
>> User then get full dump using PCAT and can parse out these informations.
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
> 
> I don't think so (or you miss yamllint).
> 
> $ git checkout v6.6-rc1
> $ b4 am...
> $ dt_binding_chec

Apologize for this. I actually run it but seems some mistakes here, will 
be more careful next time.

> 
> qcom,mem-dump.yaml:5:10: [error] string value is redundantly quoted with
> any quotes (quoted-strings)
> 
> 
> Best regards,
> Krzysztof
> 

Thanks,
Zhenhua
