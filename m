Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BCA773DFF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbjHHQYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbjHHQX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:23:27 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2048.outbound.protection.outlook.com [40.107.14.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3592A5D1;
        Tue,  8 Aug 2023 08:49:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UaOtF4C8fnqQgFQfQEUfJkm3JAIHM9nF9uCOyI0MjoMpx346/SSGpij8r1IcPqxXqjYK9fYhCHAFmsuNJsYQQ8HPnEEftEfdJfVEIc5SFOhW0F9WoiuQRWcKaMaVXl4vIxE3bMcqgBm914DVwiAU5tmwlj1MfmxWQKEU/pmWETSSkeMFCeAEXNvDyyKFoiuOYYSyo7Sv73buBxWIqExr8q73N5ROZiYp4mtg3ZEyDXygHL66kUznNYoJKudlxbd3YLRximWGHbba7ld/OyOIOwYXyBvhrZmYy4si4GvZLpr7OTL7MhS0FFkFisMYuD4VW3y8PJSi5dnL5mYYP6WKzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abnbn52zjsWiR2WnD3Ou6spo2IBlBZEb7kFUWdYr5eY=;
 b=agU82+e9SG9g4R4Fz0JAoLaOjWJqeFsJUgCOn9Q+t2iBoAwxHkVCOUdTc17BjYCC7w1q+pFO5pMuhOTXRSKZr24oe9RHvkaVkRGXd5+isMp2yHgwxllssuuZ8ALoVQ0LnNbz7QS/0eyxcDdJYr+BKJ+WbjESVIYea6+c5wC/dwlAWmYwVVy5p72PFo3/2GIOwexu1v2eA29soZ3p/67FjTiZBRaEVgmlgxFdH9nNM8htvkdzhpNqsP3MLm4DMSfp4kMia3gQEjGXMp/g9IHsEotgy0CxxLLTeJPq5bTmFVaf3lrCYqSQzpk5NbDepe4HSGeSoSqAxJiokVKub9YWwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abnbn52zjsWiR2WnD3Ou6spo2IBlBZEb7kFUWdYr5eY=;
 b=U7yvizPUS7AWCDEg0vjvvM7x9j/VVV3hBs+h5zHvZEd+267dNy85noKeJUWz6Kl1b1+Lmj7OuZ+fsuYeIEoWHPHbqgA6sEpXBvc0KaV1dEMsVtJtqctYrnICfLu1rvc4LNNmG+up/HZnAwMb2lEbJmaDynpbl72Rq052z6IJCCD0A16+dKiyv30HoNQ0zKdmKGZK3C1RmKMdxD5TMCOF824XPCJFMlut6hpJf2SjudVTuCGbpdbkiwWe+9FM7eHvBvXrVriwkCTgKku53rLmq5gHtVzkp95S42HWzI53Xx4yTANvnKd77FUXvcvtaZwua3hASX4tigCtl0CiyiOV9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AS2PR10MB6711.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 05:27:22 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9a7a:31ac:7fd:e106]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9a7a:31ac:7fd:e106%3]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 05:27:22 +0000
Message-ID: <a274dabf-3987-0885-54f5-3bd7e7f2d1d5@siemens.com>
Date:   Tue, 8 Aug 2023 07:27:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] arm64: dts: ti: k3-am65: Enable OSPI nodes at the
 board level
Content-Language: en-US
To:     Andrew Davis <afd@ti.com>, Dhruva Gole <d-gole@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230802205309.257392-1-afd@ti.com>
 <20230802205309.257392-5-afd@ti.com>
 <bb87effc-00c3-7d97-08c9-68408f9c514c@ti.com>
 <627ed411-a6f7-cbc9-d48f-2678bf63c609@ti.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <627ed411-a6f7-cbc9-d48f-2678bf63c609@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0074.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::12) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AS2PR10MB6711:EE_
X-MS-Office365-Filtering-Correlation-Id: aedbee04-2bd6-4b06-d840-08db97d02421
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zz8go6kEuOAoHHotbZQVKbWkoL0vbyWz4/tRMv9nbze9lD2Tpo9cpoSSbNrG9MytRZEVG0GaB75Zqb5/PisPSc2lyYdtzRMZCR9lk36l6NSaG2w/VS9VjiwVTsNyZanzHMLTX0jxdVjgKVtL/Hwyd+Y9vYBe3Rv+BcXmKI/jHWFIaGwZ1kamRagobOgmtHFoA6btYV19GQdJyqup1CfGSZM45gUZdO1Mm8G/xBXyeEGt/8Z1XJiAU4PrxMeKektyfsRy6XtAgh0CXjFmoN16ieOde+oorfYPT5kd7yuCrBXZ0OTcbisxrYuYIhQgb2vDpcx4A3NQciaZEcKIhSe6PBtKC4SsAgOr8WqSVhNrbKqWGI0iRRJ0u/QxhyWRSKMOkDApTHGuevoPhHcSxqt0pHD7t7dBGjVH2grXkzJqjJBK5izdihLJDVvCUOCdD75R0++eHccAaVlJ+86GfnQrxZZ7Awhb0vA0QXq/PUDW4TqIoyh+71zJ7zlnXZOKYwtUhdBsqFsyv4VBwCY60W/yiIZUu0PghDl5r/ZwgGpaw/+WVHc3Koy16OF4pGHbLDWTTsfujWMmCnZh94jPFNSJnNs3SjhBmB1RI5DlE/l1amfbjN1d6t8VM+4BfoS/itQ6vDpbNtJ4clIofaSDc26/ZVpdh395prrOpJ1V1z7A5FEi9WolLlrt/NUj9pDhn7+gyOM9vo4a5YFZOPjTmQ/1wg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(451199021)(1800799003)(186006)(90011799007)(90021799007)(36756003)(2906002)(83380400001)(5660300002)(2616005)(110136005)(6666004)(38100700002)(6486002)(66556008)(66476007)(66946007)(6512007)(82960400001)(4326008)(316002)(31686004)(41300700001)(31696002)(86362001)(44832011)(8676002)(8936002)(26005)(7416002)(6506007)(478600001)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXFkY3AxS1Z2ZVBkTEJuOEsrNEdOTzlqc1M2d0RXYU9tTVBoT2tOcnIvUWNS?=
 =?utf-8?B?Lzc1VTkyRjdsSmhjSG5iNEN4YklxODNoQVdtV1hCRGNYZTZLMXVtdi8zdFM5?=
 =?utf-8?B?VS9sdU9jR2hDaFZrQjB6UXZ1c0xzU0l2enpJOXdqM2g3ODhUQlRsQXpKbWpt?=
 =?utf-8?B?blFuVjZUa2IxWGJ2dm5yVytBQ3NUVVptWnpwWkYxcy9FTlFUdjlub2xxNUtZ?=
 =?utf-8?B?andRTEFPOTgrWSttalJLU0J0eGU3dEhPekNTYzNvUk9iNmxTNW5MZHZkU0dQ?=
 =?utf-8?B?SWZNSlBhMk14TVIvWCt5ejVwN3hVaDdlU1JnVnNhUnNJTkRwN2RhT3MyTDZr?=
 =?utf-8?B?dWZ2TGM2YUx4YjZLdGs5Z2J4REltNVZ2UXFJTWppTzIzTlh1dklMY256aVJO?=
 =?utf-8?B?WXRtUTNxOXl0aGhpbFJOb1BKMGppU1UxLy9BeXh6U0Q5Qk1abTVOL3d0MFNZ?=
 =?utf-8?B?MXY4aTBTWGVDNi90RnZVMXZ6K0VtUU9MMzFsUG0zZU1VMGd2eTJwNElTMmJE?=
 =?utf-8?B?V2FqQ3M3TU9OSDJRNXB6TXNLS0tVZ0RlUSthUmxBRE5kdkkvTUpIQ1FKSzFC?=
 =?utf-8?B?VFBqQURtOFAyalJDL0piWHVrVU54Y0VKaWhWVy9xWVhabVo4UjFZVCs4ZEQy?=
 =?utf-8?B?T3FQaW9EQy92VitvVGxYZHh1ZW1NNXJFTWE2WG5NSFNZdlArYzdMUk04cDYr?=
 =?utf-8?B?MkJVaWNQd3ZRSlJaNHI0YnhhelJta1lOWjg4ZE8yeDRNa3hjMTRkSjRrUGVF?=
 =?utf-8?B?MXhBMkI4eFl3RXpyWmdNZmNWRnB2V3FYRzZsc2dPaWFudndkZmtiWTRZM3Jn?=
 =?utf-8?B?UEhuVk1CbWFnUk8wRXRNVFF1Y0UxZkNPMWlVUGJlQTFXNGFwQnpvcTdaZlNp?=
 =?utf-8?B?Nmh2NTk4WGdZclRsR3ZUUzhuMGU3Z2poS1BoRTBwY08yaSsrUTFkclBnQmZn?=
 =?utf-8?B?dFY0eVVxclE4Q1JsaUNvaFp5Mjk2eVhaSFAydDY5aEVpYm9aNEdUd210SVhZ?=
 =?utf-8?B?MFBPWDcrVTBEcUxva2JKSnFqVGZxODBTc1hSbjgxTEJYMzk3NElDajJVSVZr?=
 =?utf-8?B?WDZDYTNLdlNrbElaUjlnOW1seXNrNDBqd3A2ZklTa096elFJL3duL1VHZ3B4?=
 =?utf-8?B?NXB4eFBQQWVTNjU2VXAwclhseGhCeGZ6WW1kMWI2MmhyQktBS3dQQndid0Vs?=
 =?utf-8?B?ZElCQVo1SjNueG1zSW41dzZzd0tiM0pJRk5IeWJOYStXV3dpc0d1K29rZ0ky?=
 =?utf-8?B?SEJHNnZRd2FFRVdIWDk3Vk93NW45VmI0WS9kYUk4REo1dXB6ZE1FZjR2OXhL?=
 =?utf-8?B?Y3BoekdKR1FuSHNBZDhlNktVVitoSTlQUnlNbTl1aWFwQ2NoYkduV2ZUc1J5?=
 =?utf-8?B?RUY3Z1VLcU9yRWIrbmpnK0NlUXVzc0IrY25CS2ZFTm90T1NId0xTK211cnFu?=
 =?utf-8?B?eUd0YWs0WVU3QmNOVXVFRmtZRnBkN1pRelFWdkNsYm9Vb25FTGNKY2duOXBo?=
 =?utf-8?B?REJBQ1J4R3YvQm1jMFJQOUhaUWhXTHZrWVNiVktnazdUVy92K2lYZmlmb2dE?=
 =?utf-8?B?Sm9OdmJldFVwVUNoWXNrc2V5SDh4eHM2Zk1DWUp0dFdXck1CMVBXZmszdWV3?=
 =?utf-8?B?dEpGdHA1WHNnV3hTNXVKT2xhYjNRNHBRR05ua0ppbEp4TWtnZjJsRlVsRDhS?=
 =?utf-8?B?TVBlN0xrMHVCMC9YSHlyeGZEaDdaY1VsYlgvY3lIOGdaekR4amVxcS9nU2Zk?=
 =?utf-8?B?SFFWNmpYMGJZdFpzWHdYaHc1RjZtQkxkQ25ubWlPTTYxNTd6eG50MGRpRGhw?=
 =?utf-8?B?ZU5oaHd0SStsL25FNzRwMThjc0ZWekRBeXFQaDBTS3BkeHJOdjA2TkpwYlFN?=
 =?utf-8?B?WGxlc2crcksxRmVlZCtVcmNTMTVsUDNmMjFKdlBpUUxPekpSUk5YSDBKOVhi?=
 =?utf-8?B?V2ZEbTRlOHlmcml3eThwVHVrcEhIVjBTS1crNDdHU2lJdDVOM2JRYTFwUUt0?=
 =?utf-8?B?ZnkvaUVxei9MTG5SZlIzOTZQZnBSbE5SaDZ0Q05aUjJMRTRHQm5NaEZpbmRi?=
 =?utf-8?B?blM5cGplMC8yaWpsVnA1UHREdDlDRFhkTGNsQmdJL0ZueklXSGFqNnlXUWZw?=
 =?utf-8?Q?zocovIaWBWvntVG4B+RXhWnDM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aedbee04-2bd6-4b06-d840-08db97d02421
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 05:27:22.0596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f06lAuFgBK7uKJU2+pTlYeD6THzNqmRgGX+3uVHPKNOES+VTc/8GV58OhbQ14aSXM9iOdI8etLC7NNrmwBAy9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6711
X-OriginatorOrg: siemens.com
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.08.23 17:18, Andrew Davis wrote:
> On 8/7/23 1:16 AM, Dhruva Gole wrote:
>> Hi Andrew,
>>
>> On 03/08/23 02:23, Andrew Davis wrote:
>>> OSPI nodes defined in the top-level AM65x SoC dtsi files are incomplete
>>> and may not be functional unless they are extended with pinmux and
>>> device information.
>>>
>>> As the attached OSPI device is only known about at the board integration
>>> level, these nodes should only be enabled when provided with this
>>> information.
>>>
>>> Disable the OSPI nodes in the dtsi files and only enable the ones that
>>> are actually pinned out on a given board.
>>>
>>> Signed-off-by: Andrew Davis <afd@ti.com>
>>> ---
>>>   arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 1 +
>>>   arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi            | 2 ++
>>>   arch/arm64/boot/dts/ti/k3-am654-base-board.dts     | 1 +
>>>   3 files changed, 4 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
>>> b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
>>> index e26bd988e5224..6041862d5aa75 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
>>> @@ -593,6 +593,7 @@ adc {
>>>   };
>>>   &ospi0 {
>>> +    status = "okay";
>>
>> Ok, so this k3-am65-iot2050 series of DT files seem to be structured in
>> a bit different manner than our SKs and EVMs?
>>
>> The terminologies like advanced, advanced-m2, basic, etc. are a little
>> confusing to me. However, I am wondering if we don't do any status = ..
>> here, and rather make ospi status okays from the iot2050 dts files?
>>
>> Pardon me if I am making an invalid suggestion, I don't have much
>> background on these boards.
>>
> 
> This is a valid question, and yes the IOT2050 DTS organization is
> slightly different than the one we use with our SK/EVMs.
> 
> The way these DT files tend to work is layering more functionality
> or information in each file, starting with the core/most common
> in the base .dtsi, and ending with .dts that is specific to a given
> board. (In that way I would consider instances of "/delete-node/"
> to be an indicator of bad layering, but that is a different topic..)
> 
> Any node that is only partially defined in a layer should be marked
> disabled, and then only enabled in the layer that finally completes
> the node. That is often the pinmux info at the board level.
> 
> In this case, the OSPI nodes are complete after this point, there
> is no additional information given in the DTS files, so we can
> enable it here in this .dtsi file.
> 

Ack, this file is the right place to enable OSPI because all our boards
have OSPI in use, and therefore it is configured at this common level
already.

And the reasons for delete-node is obviously that there is no dtsi file
that describes the AM6528 with its two cores only. If you consider that
bad layering, you should change your dtsi files ;). But I see no real
problem here, that pattern is not uncommon.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

