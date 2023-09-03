Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0581790C04
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 15:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237345AbjICNLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 09:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjICNLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 09:11:34 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2105.outbound.protection.outlook.com [40.92.52.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D7C11D;
        Sun,  3 Sep 2023 06:11:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NsgvL0FWiGv2jU0XVtaB21asLbPEXndeQUIauwrAlhFDySOGJAsN3CvUWcxTei44G7yeFTpkIn0dIXtKlVguA4DboqTH/FgPV++mF90Bj4hGh+ZW27BHMUMrK47sgRHsXZVri3JakUOH91Rnz2CnnUFk8E/fLvobAGSziamKM6UrHjMbfoTR+9M2gOxB+RVG2XzKHg2BoLODW/FcLxyQsOYvvkdRBLbD8s9olNNPVRI1QSreFUcDcX5YKG0DUWj7LxH6hEqSj2893zf3jCdclwNvGUztD5qtKKIQ7YNZaQ+GjefIYyUSwvlQ8B1INouZ9jz/T4Mj+5+69SFQ7PRyCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7DsD/nBNP+K3X/WFudyYr9ykpCh69AdlRv8hl/5sec=;
 b=T83j9bZR83c8EWjh+ozAfkASrB2Y53f/JmJ2i/K3fMPl7BaJ9wSsnx55MLKWReOfW7MGE63GjWXowy7EXG3MyxXY9U2ULMnWWejRr+fvnNMuWOnfKwzFHPb1VUrPSLBABy7hic1TLqVxNKrUQZ5dqBlTZfgtwIHP9jo0gxPYiSdV1l2rywKlhE9HrJCd+Q5IHJhIKMDVRpFGnOMxtNitZjpZFLD+o44ZaYXaQ4DojMxIhiTc/wJI3c9nH9RDPDpfN+aql7EBqRuqzf93Ig9ReiPZk+vmj8sJG64E1dL7KdyMSq8DM5w998p74VfxHOR577fIKM74QqYhXcoK9TyGAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7DsD/nBNP+K3X/WFudyYr9ykpCh69AdlRv8hl/5sec=;
 b=YdIdoQH8S5BGHgTzxi1qfQqvjjRE1PgAT4jVI8vOrGLanW4ixyQRdx3s1acwGtjWnZe5UBg3lgtVdqzpD+SaXjYq/MBovzZWEBMrP6FLjN4uUJ+iimLfSDnwUk8oYdLSAkQxfDHAzAtkbqTPkq7awbhGooXs2AJbP9iPlnNkF7osRV2tUxiMm4CkqUFXgbEoG9ED1Wler2x+bd3UgGaScO5lh92srDQKmBuE0NnCZfq/u0aCshZtH8Es/PTew6pD4IKwGOb8/ATP8ZGZKrZUBb+uTN0c+9o2PFrZfn8hD/c1kaCnrl5ZgigSnt8ayqnDSldpK5FUcmcI9e/ItDSU4w==
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9) by SG2PR01MB4292.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1cf::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Sun, 3 Sep
 2023 13:11:25 +0000
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::a40d:d453:3c29:577c]) by TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::a40d:d453:3c29:577c%4]) with mapi id 15.20.6745.030; Sun, 3 Sep 2023
 13:11:25 +0000
Message-ID: <TYZPR01MB5556EB1FEA752CE30FC6F64DC9EAA@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Date:   Sun, 3 Sep 2023 21:11:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3] arm64: dts: ipq5018: Correct uart1_pins pinconf
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        quic_gokulsri@quicinc.com, quic_srichara@quicinc.com,
        quic_varada@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <TYZPR01MB5556D24A77DAFA013F93B551C9E4A@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <295f0c31-3612-428c-849b-9469a6136f47@linaro.org>
From:   Ziyang Huang <hzyitc@outlook.com>
In-Reply-To: <295f0c31-3612-428c-849b-9469a6136f47@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [z1ff1/bhe1hl3Z0pFthfETBi4I96JpMy]
X-ClientProxiedBy: TYWPR01CA0007.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::12) To TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9)
X-Microsoft-Original-Message-ID: <b4248b65-24f1-29d8-6077-79c8c46ac6c7@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB5556:EE_|SG2PR01MB4292:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f6a9e77-191d-4053-bf62-08dbac7f46db
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Sk9cMrw9757DZzpIdnEsOPacYzoktaDS6EBHV18W+Nb9wYeda3SN3/MWI0nXYqP3k6vKCkG1E1cFY/ChfhONZ2LKDboSBP/NhwRDqmLgg3t5Sp/sFu9BNRq3quMBwbFBC2bYUv1NyAprTVfuXkIRs7sWpaQmrwZHo4yfAE/bvTADn+ihLZE8eJ6W45tfaR/RgRLi3JjshugrrTs0Xk6WT+CGbBc2Y3/BDEY6LeTJLhPwq4xHGaXiOGvKCo22b9StOjAWY/u9fSAo+Vx85w7xRVJD3S9B8uTPgkaTMURZDuvVeyRrsjYoM9r3sJcAqyXKCCJPFMitI3G5BRFEC02BWf5812Bnri0R9yZtkUmEKoDBxpuN9SoNjAI+96yfKKEqUfCQa3Jh2pGdxCrDYv2mGqIk3XaDI+g6P/1q2WTbGEQOAW3wXPjtjWs+AjDMRmqdbrCPQqx8ARSKiyNhEVWUe9/HMAS9Jx0FmHwmdzkZBNfsIYGldRuqfAMRmDDFM3O+T04Gt1Zv531BEBKwsFQLiYlRgOMntnynWCU4Zgxj+EvbvrnvdhkyEnrI0UtOEJX
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0tnWGFVMk5wTUFyUkxMMU1tOU5zczQ0Zjl1dllMU3ZXcEpwQnF4NjlVWGEv?=
 =?utf-8?B?MjdrOFpjbnZTcC9QdFdjdjFaTnFON2ZSMkJIV3p0azMyRG5LTmp0aW1SK3pm?=
 =?utf-8?B?cVRmUDhyaG9FaEVBTG9uakNsTHo1MHFMVmFlM0t2dWJOY2xTSzN6MmlRNnJl?=
 =?utf-8?B?UkRDc0dLOGN1SGtTbnJTNnhOc0ZnNDFxV3dhOWord0dZQ2hQQmJQZmhFTFVM?=
 =?utf-8?B?QWltc0c0RmxkZzFOODdGMmtmSTNhWnpXVkVyM0c4NkRZVDNVQUFRTFJBbDJx?=
 =?utf-8?B?MjZPeGp4WVBkQkFaUW1BZXM2MmRsRkZnRlcxVnV3UElmbldMRC9hM0E5N3Jv?=
 =?utf-8?B?a05rQTRTZkR1cWx1aStBQmNlUFZ2V2dsR0trMmNVV2hkM3c2bEVZS29OOE53?=
 =?utf-8?B?dTl3YTZxTFZva0VtOXRIbTcvMUFBakQwM2RXTnRZem0rakowc3ZBby94Ni82?=
 =?utf-8?B?OEtPL1JIOS9PUWQ1bU1QVXYzWWF3a1N1T1RZUzk1ckpvbnFGSnF5U3NWQTNO?=
 =?utf-8?B?dFhXM2x1RTc5bXFqbmgvRWdoS1hEN1MxcmZPd3NpckRRMHBZZy9RNi8yYUVh?=
 =?utf-8?B?TWdwdFlnZUtEMTZHRUE4YWFPMys4dnNuZzVNc2U5SDMvMDZ0am4wVHA4Ukh1?=
 =?utf-8?B?VEY2aEJMMDJhcDNOR3ZWV3c1aGcyTXozZGZtWEkrd3h6T3N2a3BzOVJPODVU?=
 =?utf-8?B?SS9aU0R5V0EwYUhEWTZEWjVUQ3Rvdk1BUHZrVGtNcXdIbTFyTmFJTHZES25G?=
 =?utf-8?B?UFhwamdoOUdaY0d2b2N5SXR2ZGEwWnlWeHZjQmwrbnZqN0FuUUxBUzhBblZ5?=
 =?utf-8?B?eEJuYnRIZGI1bWZ4VnIwWXZ4QWpVWVNRQUx1c2lCSUtGc0VWUGEwdGFlZHZY?=
 =?utf-8?B?UGhmK3lLSVQ0WUcveGdmanJ0UEc2T1hqa1JnQXlGb3RJZmg4TGVKVThlb0VQ?=
 =?utf-8?B?cVVFZlpuZ0UwT3BvYllXa1hQZmQ5d3dERG5jSDFDa0VTV2hzTXhOK3NNSlVn?=
 =?utf-8?B?TTVMTHl5cFM2NHh5b3ZDL1hvOVZ1ZDRONFM1SVJKRmUySnowdVRtZEFabFBa?=
 =?utf-8?B?cHRBMStPOXR6YkFRQjg5N1BkK214M3NQTGxRL3k0MEtFQ1pBdnYzOWVyck5m?=
 =?utf-8?B?MUcwdWppVDQ3VUI2dVdKR0dCMEsrM0RNY3FmRWFFUEl4MWozRlYrVVUyL2RE?=
 =?utf-8?B?TGMzSGpKOEwrcms4YndsZG03MFpmb0dNRXdRSkhsckViVUd6VE9KMUpMU1hy?=
 =?utf-8?B?TWJWYW45cC9BMENsKzJsM2FhV0I4aW9RdDNEQy9ZWm5zNnZxOGkwb1JsOXd3?=
 =?utf-8?B?bFhBZnB5aXp0aTN2cWVNb3dheDFuL2tJdEJxbnIraDJxY2IrODgrRDE0SGI3?=
 =?utf-8?B?VDNhVUZjNW5NdVNUNnJFMDI0SU1DU3VSa1FsbDhGb2lGdVNOY3d4czZVQmdn?=
 =?utf-8?B?UFN5Y2NScUM0azRVRml3bmxjUlRkR2pCWVVQT3NrdHhPdFF5N2NpNlFrV3JL?=
 =?utf-8?B?NHphUGxwL0FiUS9SeWhNQ2RQL1RXenZ4RjViZlpGcWkzbk5pbUYxSStTN3pZ?=
 =?utf-8?B?TVJNWFhKTTllSHc0YmJwYVNiWllrZUhoWldBVTVqZmR3dTFnK0xOcllWUmZZ?=
 =?utf-8?B?OTR4NnI0b01CRm1YNUtCdHpsMWlJSGc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f6a9e77-191d-4053-bf62-08dbac7f46db
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB5556.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2023 13:11:25.5141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB4292
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2023/9/2 20:22, Konrad Dybcio 写道:
> On 1.09.2023 16:10, Ziyang Huang wrote:
>> In pinctrl, the pinconfigs for uart are named "blspX_uartY".
>>    X is the UART ID. Starts from 1.
>>      1-6 are in BLSP Block 1.
>>      7-12 are in BLSP Block 2.
>>    Y is the index of mux config. Starts from 0.
>>
>> In dts, the serials are also named "blspX_uartY", but with different logic.
>>    X is the BLSP Block ID. Starts from 1.
>>    Y is the uart id inside block.
>>      In "ipq6018.dtsi" and "ipq8074.dtsi", it starts from 1.
>>      But in "ipq5332.dtsi" and "ipq9574.dtsi", it starts from 0.
>>
>> +-----------------+-----------------+-------------+-----------------+
>> |     Block ID    | ID inside Block |  dts name   | pinconfig name  |
>> | (Starts from 1) | (Starts from 1) |             |                 |
>> +-----------------+-----------------+-------------+-----------------+
>> |        1        |        1        | blsp1_uart1 |   blsp0_uartY   |
>> |        1        |        2        | blsp1_uart2 |   blsp1_uartY   |
>> |        1        |        6        | blsp1_uart6 |   blsp5_uartY   |
>> |        2        |        1        | blsp2_uart1 |   blsp6_uartY   |
>> |        2        |        6        | blsp2_uart6 |   blsp12_uartY  |
>> +-----------------+-----------------+-------------+-----------------+
>>
>> In "ipq5018.dts", "blsp1_uart1" (dts name) is the first serial (confimed
>> by the address), So its pinconfig should be "blsp0_uart0" (pinconfig name,
>> use GPIO 20 and 21) or "blsp0_uart1" (pinconfig name, use GPIO 28 and 29).
> Surely only one pair of wires is connected? Why is there an "OR"?
> 
> Konrad

Because it is configurable. Please read my previous email.

And these two groups can be connected at same time. This is what u-boot 
does. It just like the parallel circuit. So there can be "or/and". lol...

