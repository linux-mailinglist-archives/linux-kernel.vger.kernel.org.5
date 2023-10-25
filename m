Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7461C7D77FA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 00:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjJYWbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 18:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYWbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 18:31:04 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830568F;
        Wed, 25 Oct 2023 15:30:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYRjFXh6HIEPfEh5tLPoCt+kgSjz7FVVhHLQAcQsw37zQGZnnPjHWYY/kO1p39dTcxguM5ZqW5EkS5R/KQ18eWTrvmfovB4T3Q3oXje0UI8gOlRunLh2IcYkdmeWscWAtEAlxdueKqSsah+t6baineIYhQLwvYCSAbPmJHSTzhmtuakAetbwZP3otOzcgRczS0PaZtZWKhwQ8mAziiN9v/nCgurkSSuDL2AKDiqUeKIFE21OusDowu3BuUkQ6cQwCSoIFVbsoTiXMOoZjZYUM3EqMBmWFE18MdgJg+/UULTchBiTyrK4nTDhneAEv+y6eL+5PYTCPFa19tAYR4LPHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJvd1ODqfyOnWtgF+ffY8M14XQV6Nl3RX0Xaa5TvI28=;
 b=M4dUi8mosl2OgP4Rhj62v/D+Q25X4G0d/kFrlWJwizqWE911CEg5RUrO4WIIatZltAEe1qea1FM8xikh2sKRTPQDQsXgBkN9UK8xtpSoWURPZteVLYVbr49f8dxXE8wDUcMcsTwjsT6cJ8lGQvCnCPgdBml07Wlh6Ni39K7G+SLTxLAiDO7BpJJ6AjFqtPyWM+izeGwSHT5ZIDtnr2KL8eY4m01xYfQUAKPar5lGuWcr3R4vosW1OJNA1a31N+De1TdujJQwuCh8ifIOIYOr6oiLamYLVDdyH233JVKy8ULC/jVFy+YIr+XsIL2ruMny3HbhT16slkFvuYj8KFTVnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJvd1ODqfyOnWtgF+ffY8M14XQV6Nl3RX0Xaa5TvI28=;
 b=AzQ2JdYld040/oCw5A7XM+ppRYvybVo3oYz2fhrZtw9X8Ev1cvatbho1ATb1sFISXC/fPmKKRSa6WTh2hK8MTtsjGah3ApogYY913MD4kSQfLoH2M3azBLMv45+0KWtdXJCRCh8bcSezKP5dtVtecrEK/TSK6WuJAqZ2+CrdvOo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AS8PR08MB5942.eurprd08.prod.outlook.com (2603:10a6:20b:29f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Wed, 25 Oct
 2023 22:30:54 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::a309:1d65:f5fb:436b]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::a309:1d65:f5fb:436b%6]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 22:30:54 +0000
Message-ID: <2f17c031-30f6-4242-b2a1-1628402b3091@wolfvision.net>
Date:   Thu, 26 Oct 2023 00:30:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: rtc: nxp,pcf8563: add hiz-output
 property
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20231024-topic-pcf85363_hiz_output-v1-0-50908aff0e52@wolfvision.net>
 <20231024-topic-pcf85363_hiz_output-v1-2-50908aff0e52@wolfvision.net>
 <20231025222327c0b5d460@mail.local>
Content-Language: en-US
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <20231025222327c0b5d460@mail.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0012.eurprd08.prod.outlook.com
 (2603:10a6:803:104::25) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AS8PR08MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: c10a664f-128d-475d-b218-08dbd5aa0c7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SpfVHxFvVsUQuIOI4/9rVFIE0DMgQIZQl5GsDSsS7hgshZbpYOGbVsKuerO+/lfF7LF922/TE5w/Px12j/eUT5THF9qqt2OzICzAMKMg419RrClCFooq/qFVXnyi7F0oDuXicE26TuWMY1nHR+/FzvF51LP/1NinVnmfykvklUH5OuQ6QteA2fM0ieg1aGqUTDQXhR7BVtey/j9xXEPvMWIqUZCmGUOKycnO7v4xwiX/hTJhz+ASfAbuqsKT1UXweSjgQjanmitgCgF0uuvTrT8Q5aVzmPs1gYv8Zlm0ZVVntxIUwSrdqtA9KqpNeH87EbsTwJPSbYQrUOk3BYsyEtlDhFP8SS0P1b/h0pizDngha01StnZrTEnhCeWcjWYKfHG+EyCY1P5fXoLdSTEOoXbSuafgZgUbDGIxgVKOgPDcgnSOgHfI4B9UQdDLMjkYSwkWC2Nj3bJACZFkBN9ouWr+nZ23Ad9r4wLWJ5iDYEbBG849w13uMQJ8W7tM157H76FShgldc0Ae57N3kJNTH0TsLBCY2u1nYmyzCGu2xxsunQpaVJBWPSVE4hO02SE+uSwRz6CBsS2YorDAbVMxzrZtHhmGNgfzfU5t8/0mEQRZNykedZr4SqDZIyzNQnE5M/UgtBkLjaNfpPBGLpatmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(39840400004)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(6486002)(53546011)(83380400001)(478600001)(66476007)(66946007)(6916009)(54906003)(66556008)(316002)(2616005)(6506007)(31686004)(6666004)(6512007)(41300700001)(4326008)(38100700002)(31696002)(36756003)(86362001)(5660300002)(2906002)(8936002)(8676002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXBYdVJuQmhDRWZRWExwZEt6QXRFN2d6OVpBNVJsS2VGSVlGVEZIV1lndnFk?=
 =?utf-8?B?RW15MFd6TDJWRHZMZm82WUY0NGRHWmF2SkUvLzJoQmV1N3dXU3ZudG9ZUDFj?=
 =?utf-8?B?dDZUVGViOWozU01xL1F4NWpXWUU0Z3ljNVExY1lOdjY1WXFNdnFZdzBTNTQ0?=
 =?utf-8?B?K1lVL3IrNFV6UjV3TUNqbDdOSFBJL2hPTVJhTzJQMkZpSXJOSm9TS29xRG1X?=
 =?utf-8?B?Nmxrd0hObUFwalkxa1hlZUIwcnBicXQ1bzJ3SEZrazk4c0FYZG1FMW5rVXhE?=
 =?utf-8?B?SzVMMFViV1pEdmxzRGdOYlZKZ0Y1TkVhTENZQ2QyZTVSK0hjd0VHeHcxbExL?=
 =?utf-8?B?YzJ0ekJjTkV5dUVyZVpCL3hqSDEzZGo5cHp3Q05LN2NBTHAwRkloMWZZNk0r?=
 =?utf-8?B?UFZjdldFaEtDYzdqOXlUc24xSUVtZHM5L2lrQUt4U0RabHZ6bmJHcmUzRkR4?=
 =?utf-8?B?QTBsK1h1K2VuR0g3eUIwMjBGN1NOWjA0aGpXVVR4ZEhQcUptcEtYU0J6bklp?=
 =?utf-8?B?L2xPQURKMzBFUGRhS2RCdlpZR0N0dmxQU0tNTUtaaDRtMXJaN1lQcjFudVJs?=
 =?utf-8?B?dTArcUo0NDgxL3E1OUtndWZuRzYrREpQU3UzTmcwNnprQlpJVXZSRU5QUE43?=
 =?utf-8?B?b3FHdEFmSnFDc3RPNE80QWUwOVYzd3hJendFSDMxRTgvMkFHa0JRWGpqVGNY?=
 =?utf-8?B?QjF2N3UwUjRlTGpnNVJ3a1NjTjh4bEw2NWVDYTNWMzAxMndyOG5Calo2Uldp?=
 =?utf-8?B?aDYxYklLdTVaTlVVR2JsUlhVWUtyb0VlN1YwN2lCRFJXOTFtQTdSRWM0SVVG?=
 =?utf-8?B?UmZHd3FSbWtOYVhaQWRjR3lGOGU0MmhINHhJNXdKSHppS1ZYc1VqaVpXWVRa?=
 =?utf-8?B?QUUzVTZ3TVpldGVBRFY4TWZQbC9iczlKVGxMUUIxK25zczZ0Tk5TeDlEQjNZ?=
 =?utf-8?B?SVcxQkZPTlpkdnc1YVR2a2JnMDFkYzY1ZlFOeTVxUFZhSE1PMmZxNklmRk1h?=
 =?utf-8?B?NW1YZFFKdzZnT21YL2xGT0ZBQ2l6VFJ4OHFjMStvTHZJMkVHVlo2c2ZnZHBW?=
 =?utf-8?B?QWxVdTJEQ1hVbXBGRDNPbXA2MFJwSDY2VStXVGdTeXF3c0NHSFMrTDkzRHU1?=
 =?utf-8?B?MXNrc25wcUxZV1IvZnNzaEtYcnlXV3UvOEY4c1lnYVdSaGpmWFdKL0FzUERV?=
 =?utf-8?B?bFpRelBTZWpoaXV1RWdxNE9OZDdzekJ2cUtFZHBVU2kzaTVNNUxTSUUwYnRx?=
 =?utf-8?B?QXZUcFZodFlJUU50eVlweGlLTkhzOWNXZDBoRzl5VUs3ZngrOWM0alovR05T?=
 =?utf-8?B?TGZscERzbG5PcWhGcGRIRVVhanA3MEJRSUVhdFRZc3RSRzVsenBOK2RwOEpk?=
 =?utf-8?B?eTRpdXRPNExGZkhCMjE5dEFOcFo4aDJDOUpDM25ZWWVNVkJvZzFOV3BqWnZG?=
 =?utf-8?B?ZWdyanhmTTZxWklqOFpZRTNKZWlCUWs1KzZacmp6bFlHVDZDNk5pTzVPZHEx?=
 =?utf-8?B?YXJ6M2xmSklmY2ZxVWVZQjVoZjQ4b3RINmovbVZId1ZSZlZiUG1EQ0dCWERy?=
 =?utf-8?B?ZEsrZG82WkhIVmZ2YkZoQXJCSEp0UktEeEdnN3g0T1ZnK3lHcFN0eTFScXEx?=
 =?utf-8?B?LzZxazd1RmduQ0RlTE1TU08xVGw1UFFnM0xlY2RNV2kwbDRzMFVXRFkrcWFw?=
 =?utf-8?B?S0RhSEMvS2hsSzVZQUcreGN3WWdVQm93ay9udzR1RVg4MkNKQzhKK0VxdHJJ?=
 =?utf-8?B?T1J4SEc4NzFSRVA4ZHRkTjFDVlNuN203eWRyeWhiK2dGNFczbE55dDJDNXAy?=
 =?utf-8?B?RklXR1VTWGpyMCsxbCtGSzI2elNpTkV6THBGNkZtSkZncGNKT21OSVc5SmtF?=
 =?utf-8?B?aHZIVFJBY3NGZ09FNWNrUDZERkVyMHhXTXlWSko0SlVYNVBBS0hWSHRDMGlt?=
 =?utf-8?B?Q3Bra21RUDZSMHcwMXVyN0dlb1MxY1ZYajVJbVFwNVhUUWI3M0syYVpBY0dB?=
 =?utf-8?B?cTBmcEsveE11REJjblFicjE0M25LaW9KTUprOXVWTzBoYlltcUI1cU42NlR5?=
 =?utf-8?B?Rk54Ym5JZXFmNFNRa215ZURnajVTRkxWRHZRRFVhOHJQN1JMVkpYOG9pem15?=
 =?utf-8?B?S0IrbXlEeWFDM3ZBTVZ2a1dTd1d4SHMyTDZ6MUVhSlNKYjM1UHZxbTQzRnh1?=
 =?utf-8?B?MHJBK3FjWFl5MGVXUjVUQ0RNdmwwYXpPcTduUnBRbVVpdE1waWhaRm9vRVVT?=
 =?utf-8?Q?67X0FMydvGY+eyTeHiL3eIQqLmDNNY4hzfUD93WQMg=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c10a664f-128d-475d-b218-08dbd5aa0c7d
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 22:30:53.7868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ohDbkoMagqKUbZCAvFNQuptkmrteQS8p4pabs6mLgQ3tXVZHtXUWukdGhG83UZsCELgz1MxM/4/E4ggQlAw0Oz8RO9ATdWypMVb+ALI368Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5942
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On 26.10.23 00:23, Alexandre Belloni wrote:
> Hello,
> 
> I'm sorry I never replied to your previous thread...
> 
> On 25/10/2023 18:21:55+0200, Javier Carrasco wrote:
>> The "hiz-output" property models the RTC output as a high-impedance
>> (hi-Z) output.
>>
>> This property is optional and if it is not defined, the output will
>> either act as an output clock (default mode) or as an interrupt
>> depending on the configuration set by other properties.
>>
>> Two modes are defined in case the high-impedance is used: "enabled" and
>> "sleep". The former disables the RTC output completely while the latter
>> keeps the RTC output disabled until the system enters in sleep mode.
>> This option is especially relevant if the output clock is used to feed a
>> PMU, a PMIC or any other device required to run when the rest of the
>> system is down. For the sake of completeness, a "disabled" mode has been
>> added, which acts as if the property was not defined.
>>
>> Document "hiz-output" as a non-required property.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
>> ---
>>  Documentation/devicetree/bindings/rtc/nxp,pcf85363.yaml | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf85363.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf85363.yaml
>> index 52aa3e2091e9..4b27a9154191 100644
>> --- a/Documentation/devicetree/bindings/rtc/nxp,pcf85363.yaml
>> +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf85363.yaml
>> @@ -36,6 +36,19 @@ properties:
>>      enum: [6000, 7000, 12500]
>>      default: 7000
>>  
>> +  hiz-output:
>> +    description:
>> +      Use enabled if the output should stay in high-impedance. This
>> +      mode will mask the output as an interrupt source.
>> +      Use sleep if the otuput should be only active in sleep mode.
>> +      This mode is compatible with any other output configuration.
>> +      The disabled value acts as if the property was not defined.
>> +    enum:
>> +      - enabled
>> +      - sleep
>> +      - disabled
>> +    default: disabled
>> +
> 
> If instead of using a custom property, you consider this as what it
> actually is: pinmuxing, then everything else comes for free. With
> pinctrl, you can define different states for runtime and sleep and they
> will get applied automatically instead of open coding in the driver.
> 
> Also, how you define this property means that everyone currently using
> this RTC is going to have a new warning that they should just ignore.
> 
> 
Thanks for your reply. The warning can only be triggered if the property
is defined, so in principle no one could have that warning yet. Only the
ones who actually define it and use an invalid value would get the warning.

On the other hand I did not consider your approach, which might make
this patch irrelevant. So I will have a look at it to make sure that it
achieves the same results.

Thanks again and best regards,
Javier Carrasco
