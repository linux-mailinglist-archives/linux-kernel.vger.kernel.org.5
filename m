Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA4B79DD35
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 02:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237959AbjIMAj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 20:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjIMAjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 20:39:55 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2025.outbound.protection.outlook.com [40.92.53.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349E2CF3;
        Tue, 12 Sep 2023 17:39:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGYFZT//BKYZGyj/NtCBrDxpNEe6an+bKKoVCKgAbe4ee23YdFQXAM1CVR8SnvNudlMOzPusHAVl4Q1ZZDN/L5LFSDacCGnuAYfMeL3d8u4GCI8NVQUgJM70c7ozM+kcpgrdYCYUZSYJhIQ7Db9ptnVto6RScctHSMog9/2MNkuTbCPcA7b4UClIdqJDUZfUCpFZf+xRLQnG8u0zbXI59u2g0qz00S3iDv0EfDjRPJblbaFi3LzpL83pQ3gTyiQhdshURIy0vH8kCKacixNAVcJPGpFmoU91ZasOJDUjq5q1j/MCNLvQYctSs3u/K3v5zfxoSJgahAU+EpgNS1Cz7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1tJRu2bHZ+4Yu98W+ji0CraQ6DPHuAIPpD7bRNbEaA=;
 b=Z0ypnTeGz2mSbg2ZcWcugz6lDhLKfXQUo32O+yZfCq3LRUnaB4av2ikLWm/5zFsHnOoxB6yvYkiwSJDNxzflrNIu5Lv+3o+KkGrgvkF8brW56nq60YbLLYdAs8aJ+ZLw0E20nDG5wWlV6y+IDWkWIRHBakNJRHX5FuBA0542v6XpYNsYAi34pYZn4yd279TSyHukqe2e8PQ+zXQgOb097imGKz9SXkPtYYcgKTmYGz2lKn5cRkM5ZSVH2OZbB81uMGK9saGksfORYE67+xtiPDAi7rwGA+CnbIkHLiFiEZhDRY6cTrkdLGS6rmNdFhahF/Ro1xqrWezynYL+P0NRFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1tJRu2bHZ+4Yu98W+ji0CraQ6DPHuAIPpD7bRNbEaA=;
 b=Gh+zcbrUk3w5N+/2EjtAHFimmRzhkJJ9BOBJTXh5OQFTjkdkb1pivInT3GB/a4ezjbdBn77wHbesma4zUs9OZPi5kg+xsylMZFxfzMCsfrSaYFJixLMC5phHJp6OblIRyW5vUOXbBaE8TzUPpv8uQVSUBLOwtk2bDKqZj2YNaSQRMUJyF1HF+dIe0imj9GwiAJD//RHMsIiOyzLj6DtIM+iPO5Nq/bE7A53BMfzmtuS6VEf5ZF7QnETF8gcTvtHuHXoDDK9QKziXo4Y9qrtIs7Csm+PznYLfQ7P4izA0Zdm44ZVtVDIWpCgofqU/B0ksQXnBPqXcGvpkTCVzfm4R3g==
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9) by SEYPR01MB5741.apcprd01.prod.exchangelabs.com
 (2603:1096:101:1ad::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Wed, 13 Sep
 2023 00:39:45 +0000
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::3ac0:a6a4:2d8b:7fb9]) by TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::3ac0:a6a4:2d8b:7fb9%4]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 00:39:45 +0000
Message-ID: <TYZPR01MB5556F34E093267B5A04EF43EC9F0A@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Date:   Wed, 13 Sep 2023 08:39:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3] arm64: dts: ipq5018: Correct uart1_pins pinconf
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, quic_gokulsri@quicinc.com,
        quic_srichara@quicinc.com, quic_varada@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <TYZPR01MB5556D24A77DAFA013F93B551C9E4A@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <b6fa8337-a5c0-172a-a41b-ab18de3f4f72@linaro.org>
 <TYZPR01MB555673C1E12A27DA8109DBEAC9EAA@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <c6f4b93c-aa80-e250-d06b-6b3bdfbfc64b@linaro.org>
From:   Ziyang Huang <hzyitc@outlook.com>
In-Reply-To: <c6f4b93c-aa80-e250-d06b-6b3bdfbfc64b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [gQqJWKRZUG7KE7dvpbBbU2KpN4iMQFen]
X-ClientProxiedBy: SG2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:3:18::30) To TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9)
X-Microsoft-Original-Message-ID: <04c833a5-3fd1-79e1-faae-72f34ce6f681@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB5556:EE_|SEYPR01MB5741:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dd46b71-6992-4c5a-29e7-08dbb3f1ea01
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TVBjIjieCI1+REU7HrL5wuRUpdulWB8+Q0FgiFYoZ9zG8LI8921Dga86MTtXCrneHzxRAISZeotDGxUQcuDsl7WxS/Lh+QVgHEAiNklY9cUN+NrYMWg1AWijyPwLjqcYJse2gyXJWmuKCJRWVP1doEWkALj0JfsuIlGGRx29AAE3JPAO0JeL0rryyv69BiRrlb3dhSsF07a4qJ18foDmUTT+mRtrNXqAurg4+LZuZUz1U8+lt+kGmJ8zIKj8hUgOzm1zGqvVHUXUY+XqEBq0me+es1ptFG12WaE2vaXjph68IvbDqSktslHXDnRngtQ0T1H7cDV9/pwhQT7OOyuK3iSKZajFhHE7nBqr143rgC31RLBsOzkywytZmWEKTtJ0VHRJAABJCRCPtWKMeOPFDJJ6P0BOAj+7qzESOJng/HzT/ETECWvE5Y5s7oAw/L7qqzu0y78F9toQdKtsw0kN4uTTRf1tMKnH2ELze1q2Ec5bCnUD8pIH5dTDrZc7qymEq/ZFEZ+9YQAPt0HJ2RkayvoMkvqkZUr6bOAipoERvxqkquFz5PXjLNYSikoYtZwu
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXgwZGExbEN0MXVBSFg3aWtiVnlrYnZoM0duWitRYzlvemdmQ1dnQ3o2TXZm?=
 =?utf-8?B?M2liNnJwLzNkSG1ZdmdZTTV5MEhzV2xDMENQVjhZYmJZQ1FsdHNmRUJITnNO?=
 =?utf-8?B?NnJ1YkhzL0czb00yRnV3dEdVanlXTzQ2ajh4Rlg5ektGWTA4U1NMZUx2eU80?=
 =?utf-8?B?V0pwS241UzRaM05FRDQyM2t6YXJPc3NIT0gza0t5ejgwaDNKSUo0ZStuRENS?=
 =?utf-8?B?ai82cTh6U3JKTGpQVXdYckNvYTRPUTZLOU0xQzlZcW9EQkVNdG1KWTdTUlFD?=
 =?utf-8?B?ckl6N2JaOWlqNnFRYWRoNy9uMlVLQ3ZJT3phUkQvQUFuTkZBVHdWRmNCODF2?=
 =?utf-8?B?Sy9YM084a2JTNEVmNmZjYVVZYVhhNm5LNjN3RFJ5alYxQmdNOGFzdW5yUWhU?=
 =?utf-8?B?TU0wUmtGWUcvOXJWSC91ejlMTFJmYlJaSlhnOENLZXk4RTlKUzN1c003ZE5L?=
 =?utf-8?B?dXRxSmZsRDNhMTR1d0NGQVlHWXh1aVRIOTIrM0YxNnI0eUs0OUFKdXZpd3E3?=
 =?utf-8?B?L0xNeEdZYjMzOUc5VDdnaWhsSlBPWkVGWXpSOWt3eG5DRXlUVGRsTTR6NEZq?=
 =?utf-8?B?UURVaFFtcXFnaE1DRnJOV1E4SXFpSHY3dDAxL2ErN1IyaHQyU0h5bjBZTUFN?=
 =?utf-8?B?THhabENjUFpTU0Nsb0UzQm41UExMbTFLNVJhQ25aT3I4V0RzSlYvdkk4R3dL?=
 =?utf-8?B?RkFRNTZwUFBiQU9CSUd6N2RCeGFSWitWZTh0NmlJQ0FQQmExTXY1cEo2Z2hw?=
 =?utf-8?B?OUZFVmg2QWV1c3R5VlZCWml2cUlmcmU3RXlGWDFvZ09rZWJ3QlUxQXl0VFNw?=
 =?utf-8?B?V3YzSFg1YXFNMWdpYVEwZGs5anBEMkNQNnJxMnpDM2ZiK2hYNkxvSENFQnRo?=
 =?utf-8?B?WUxPblp4REs4dUJtVUZpQ043d0poT2dVTUMyZkJXNGRNeTdQWmY5WmFyQ0Yv?=
 =?utf-8?B?RXkrS201dHA5YmNaeVBrRVpiVXBCajIydEthbXpCUlJ3N3AvTWY1SnkyQS9j?=
 =?utf-8?B?L1Z0VDM3VmhiWlFaZmtycC9rNElHcnoycXRQZEtEejBsYjl1MUI3dDJJRk1X?=
 =?utf-8?B?ODQyTys0MkgrUmQzSGJ2cFF0ZkdCQXVYczk0VmpLWDl2VFcrQXM4NDgrNWRa?=
 =?utf-8?B?WXZQUDFjM1M5QmJnaGJoT284RUhWcndxc2I5RnUrcVBUVVp2SXFRbEkyeEJy?=
 =?utf-8?B?RE10cUhwZzJKdkxvOWN3eUtCSzFCYU5pLzhCMTlIWVEzYWYvNVhlZ0Z4YVpE?=
 =?utf-8?B?cEJyWHUrZ3FKdmlCSDM5N1V1eE4vR2xyUUs0WDcxdXhnaDAzMFQ0UmJzSG1U?=
 =?utf-8?B?d2VURmh1ZThJMEluckgxM1ExUjBCUmkxWDBmUDU1VFVhMklQQTdTYW94dWFh?=
 =?utf-8?B?WlQ1TTgxZ1I2NDlJdmNwQ1pvT0lad1JJVmt0NEJadk92ZVgrRXhIaW9CQUpO?=
 =?utf-8?B?ZGNLZS80alVmRHBBblJTU3duMjNjNEdveE9CaFNHYzdZeE9ETW1jVmFLcGxC?=
 =?utf-8?B?VWFUcWlnOW13bUVGSVZjNUZOOVVRc3lTN0FJTnJEYjMzUkhIZ2s5Zlpsc25H?=
 =?utf-8?B?K0ZjQ1lOR0ZycHJTeGVzOGxEOHFYM3lFSFJ0UnRzalhpU2NVZTNPQVM1WG9h?=
 =?utf-8?B?VVlOOFhWSG9mWXcwK2NFUW56MHVlalE9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd46b71-6992-4c5a-29e7-08dbb3f1ea01
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB5556.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 00:39:45.6242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB5741
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2023/9/4 8:57, Bryan O'Donoghue 写道:
> <...>
> 
> I've checked the documentation for this chip.
> 
> gpio20, gpio21 = blsp0_uart0
> gpio28, gpio29 = blsp0_uart0
> 
> These pins are muxed to UART0, I agree, the u-boot dts also indicates 
> this also.
> 
> If we open the documentation further we see
> 
> 0x78AF000 = BLSP1_BLSP_UART0
> 0x79b0000 = BLSP1_BLSP_UART1
> 
> So for starters the dtsi has the _wrong_ label.
> 
> Here/anseo
> 
> grep uart0: arch/arm64/boot/dts/qcom/*
> arch/arm64/boot/dts/qcom/ipq5332.dtsi:        blsp1_uart0: serial@78af000 {
> arch/arm64/boot/dts/qcom/ipq9574.dtsi:        blsp1_uart0: serial@78af000 {
> 
> That's how that label ought to be the main hint something is askance is 
> assigning a pin named "blsp0_uart0" to a dts entry named "blsp1_uart1".
> 
> Please update the label in your next revision.
> 
> ---
> bod

I think the root cause is the confused name in pinctrl. I will update 
the mux index to alphabetical order in next patch.

By the way, can you find out the documents about the pinmux map. For 
example, the code of pinctrl only show that GPIO20,21 are for UART0. But 
which pin is TX and which is RX? And yes, because of UART, it's easy to 
find out.

But what I want to known is "blsp2_spi". It has 3 pinmux configs - 
"blsp2_spi" (GPIO27), "blsp2_spi0" (GPIO31,32,33,34) and "blsp2_spi1" 
(GPIO23,24,25,26). What "blsp2_spi" (GPIO27) for?

