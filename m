Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA46179370A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbjIFIUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjIFIUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:20:39 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2077.outbound.protection.outlook.com [40.107.15.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75B7CE4;
        Wed,  6 Sep 2023 01:20:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CwWPDsfYfCGFfI7b+MZ2rNI5ExHaYSifqEAryZmPOqKaqDVlVAOyQfIkjfAJ/bMURIk+UJC+nNlhXjvsWg08AT+veJ5VnsIBfI/l7Y6JAmDtGmLhtEwDFxSftE4rxFT5DS8XjXykBmjQxeNcBF+SFn+LzKKPu9lxHvIPEjaJ2catMP3AdU0sYNeSaoxoHSrSdvTLrS9SeRsBJIkN8KeR3FtK7QEbUi/iYHB/V+ZMy21in/vFx2snZk5v4gKg9d7VQbwobFsLS6HjgI1Y+paHPh+OxPF5uXNqQK6V1HpEso+ZZ4wincYTzSyxdPYa/smOS5HDaYJj/33bbJ91nrNG6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WW376MCurHW1qI39VCF/XEShUx/xRMVmmj6Ob2azx4c=;
 b=bxPxNAg0aKAXyzAEUHWfPtU+m1Wj6/7tQtrmCeG90Kf7Ztgzni1zOV1Cllvp0y5GEfZgWUzvoJ/d6mnplTJ8gZq8m6z1qOL9CWU/nY6Ol+TocvtD6La8mZ/7LL3i7iPLaC9s+wiaVCofrgzOCdlXQ4OCp4fR39pmsZf1eHTD3xYeNa//xtZmgulZPvNVPM/V6LlM3bKEo+rlTMPJkjnaq7CXuzTaA+ZLpPvkZ7Tx6FWip1CYzA5Kvyf0kgGu90+VJun3YAotnjUt2+A36xK4QAAGciNaixmfYA0XpbizmNrkaS2/ZuFQiiTAiXyp79qtboPpij8sRkRUeLYtdpBAWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WW376MCurHW1qI39VCF/XEShUx/xRMVmmj6Ob2azx4c=;
 b=ajL+tTxvebTgepLcYbVuHdiVE2QdOTK6RuF0agVknPi8dvLgtVXSg+qODfrzRLMvRRffTyf04826iAXpMpmXU2azoUU/WR2ej81nQ6p/EQ/77vQOg5blc3WolJf1wbgMRYdL27E0h9I2QGXFkyodIPLLcnw5jH8viJfzybLXp5S8j+lqdrHfr0coJgA3Nk27O4B48tAszlMAesuApFeIyeSkX88MW4NRm/mj0WD0GlLDjUQC7Qm40s7nAbXH6GrSKhUKm41C/UtF6hIK/pvx8AuLjjvS3oMlRhgah0VDJD+vurGbCIzOVYaBRJn4gBJWRGg4lbYNTi7637/XR7BuVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by PAXPR04MB9376.eurprd04.prod.outlook.com (2603:10a6:102:2b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 08:20:29 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::5c00:6152:6ce:72b6]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::5c00:6152:6ce:72b6%6]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 08:20:29 +0000
Message-ID: <5166ca75-5454-8f64-4f61-fcc0f7a4c235@theobroma-systems.com>
Date:   Wed, 6 Sep 2023 10:20:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] dt-bindings: pinctrl: rockchip: Add io domain
 properties
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-rockchip@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20230904115816.1237684-1-s.hauer@pengutronix.de>
 <20230904115816.1237684-3-s.hauer@pengutronix.de>
 <b4017947-9e16-7d97-a7b1-3e6964a1f7a9@arm.com>
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <b4017947-9e16-7d97-a7b1-3e6964a1f7a9@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::12) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|PAXPR04MB9376:EE_
X-MS-Office365-Filtering-Correlation-Id: 8facc75c-293d-4773-b037-08dbaeb2216e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9u2xZv/+HDFMNhnJBHvgJ6NSZ/ZX5lgkwzRpYWT0t8cn0KAE3VGfGXVEG804LxqbJYdHWf/7uPAu0cvqWCmEec8Gq67lwvqsMh9sXT5C7FeHs5/KTnHeUGMnGjxemYi6RrRwT8I+SlwDBUama26+mQZQ/boxSK3i6r/EZe9DsPoKi9YmXjfLMY1p8YA++5tjOqMReLgveVjAq/hmRbpf1uShvams81IL4eOiQzYnKC0k/PMnDP0ZPQ/cBRqdlAmiJBN5pZwGMDyTF3KG1YSwrfY1gqeZD50/A8JmEGlxbWLAOofNY4VY5D4tNIAerKX7P+ONh5atcqGtDtN3fkR0rVyU1+A5UbqMfE4vcdAQZurdMtnRfCFwRpOJHgbFDY5a5XErAHEfIn6ty6GvZ3s8q1qS95tTDWdfFt5mJekanQvLa0RC2he876jzC9m6G4k5mU8W5ZVqfEm3XGUa8NFiYXeht8DSS53ExJoKy0p79AS6tJNCnD+6HZKJVX7W6XRCIcGI1srvYh4WIKsVh/RDMD1isA0uc5FuxeqjKIFDTM1EVFNYU0X/Vy9Dyh4E0mH9i4N+lungEbAfqEki50IbszzShk4MI5N/TgwyXTOtD8qRMVcRCYsmiNmF9tk0Nf6m2M4v4IZKGyjQpzu8gNJkWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(396003)(366004)(376002)(346002)(136003)(451199024)(186009)(1800799009)(6486002)(6506007)(6666004)(53546011)(6512007)(966005)(478600001)(83380400001)(2616005)(26005)(2906002)(7416002)(44832011)(54906003)(66476007)(66556008)(66946007)(316002)(41300700001)(110136005)(5660300002)(4326008)(8676002)(8936002)(36756003)(31696002)(86362001)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVZHNi9vV21ZNDdrNHVJcE0vTjZOM0pWZnFyZW1RMWZNMmw3QWNjWU9wcENp?=
 =?utf-8?B?WWNneGRtZnRFMm8vbERvZkdvSVBvRUFoS1lmcGIwdWNheVovN0dBZzVKRUE3?=
 =?utf-8?B?ODVrditCdTE2aVR6TnQwK2RvU1JSZENHd25vTzZzZXlrWUNKWVhsNzl3Zml6?=
 =?utf-8?B?RXBRWWVVb0QxTGtxQXRFcngxaEVnaElQdS9uNEtxUjAvdTh4dGwwVE9iUDU0?=
 =?utf-8?B?aC92TFc2UHR5b21zQmIxcU5PQndpbkdhWmZhbFZORThoRThGWTV4WUJUNU9H?=
 =?utf-8?B?ZUgySUE2Q2NrZVJRblNOdllLR25oQ29KTGNPWjJsNi8rU1FRZGRpbVZhVTVx?=
 =?utf-8?B?bURDa3lFT0JBaXpCR3ZKeE9MdlFkYUtRSjhTQ0h6SnlLU1p6eFhwTE5VYTRJ?=
 =?utf-8?B?N3NoZ0pULzcvaC9wMWNTSU9vLzFRaGVuc0ZsRTZ0djNpODhLVmROakdIY3Nq?=
 =?utf-8?B?R29ZaTM0aDFpdDhKODRpczRtazMrSUlCaGxQWC9ZaERCSjBSdGR0b0RjMU9s?=
 =?utf-8?B?WVJCbU9Qa0VMVklHa09jWVZQYndpN2poYm9RVWNvZ2NxeWlEWmVVVEhoVzEy?=
 =?utf-8?B?SE9KaU81YnZaVGRBMno1aGxGOEw1WE5YY1RpOXhOdEY4RVErMVp4dFJNV1NK?=
 =?utf-8?B?Uk9WY3ljYTFMVVBPZTZITHNUNHd6ZTZ1Vm9PUXp4VTU0akJwVVhqTXN6SmdT?=
 =?utf-8?B?TWoxYnYzeXJETG94SFFad2JrWWtWRTJndmNQN0FVTmtSK0U0QmpuL1hFWCs1?=
 =?utf-8?B?MEVpS0Izd1BPTTVDdVF5WGVwY3M3ZnhvaEpDWGdSc1ZkaTJmZXE2YW13SVZh?=
 =?utf-8?B?RCs3clRjUUhuOFk3a0xpRjVOUnVGWnFqT2JyNE9wc1VKaU5qZWJ3MXkrRU85?=
 =?utf-8?B?aXBnNzBCY2xQTlhXKzJsTFVGKzdYSmNOWVNEUlEybmF5cFU1bHYxckkyd2Nt?=
 =?utf-8?B?WU8zbGhvTGJ0L04rcFRKQ21UZVpHL29HVTFYMk9zYnNHZnJ6OHdMN3pGeXlZ?=
 =?utf-8?B?ZkFjSGVma0lNTWpuV2hyNnZJUlNGcVlOQlJ3NjJJK0NTdzJJUmZzTVNWdWFx?=
 =?utf-8?B?K0FhTW9kZkhSWmh5VDBPU3o1TnkwZUFnYzNwMzFvL1R2RGtVMXZESUlNRWdn?=
 =?utf-8?B?VXpzcit3cEtJcjdPbStWbW1qKzhWNS9taSt5U09VU2txcUJ1RDNUb0dhMEFI?=
 =?utf-8?B?TUZCNHVyaktSdW9FWVd4MUM0b2NpWkJ4OHhnZXQ4MkxveTQ4TUNVMy8xaVBq?=
 =?utf-8?B?QXRrbUxVWGNMSDh4NDFDMGgrcUFUeDJ0Z0FKdFhMY1M3aWhOYXJHNzZFMUc2?=
 =?utf-8?B?VnJnUFJHaTN1VmNxL3BHRlh1a0FUVk5sS1JPOVNGZ0FMckpkWGpUV0ZibU5X?=
 =?utf-8?B?c2JGb1B3T1ROS21uY2xxa2RFZHRsZFd3em1KTEQybEtGUHZyenRwbmpXeTkw?=
 =?utf-8?B?QW1MeVIxbkZJZlhKNjdaS2hhN2lrakZUcVk4Mzd4L0ZuQk8zSjVFNWxoM1pE?=
 =?utf-8?B?NVZ6dTR2a2g2WFUvSGw4cnE1QVhlZUhzRzl0ZEhRbXE0dUh1UzVqNDVKenpB?=
 =?utf-8?B?ZEc1Z3BJTlp1dHM5UnhpYnZmK0R3dWZ5SXgydXp4Z1BXbFhZS21LZmIvNWIx?=
 =?utf-8?B?RXFwQUJQUGZTakEyV3Y5SVZTNTVFa3dtYWtmbXp3RWpqN08zemV6N0FNYVlB?=
 =?utf-8?B?NDVwajc2QjZBRUFySnB2Uy9KMituaE5pK0tDR01vVjRvQjl5dm5tS0t2aHIy?=
 =?utf-8?B?SlhwaE9mUDVNay9tRFJ5b0R5Z01SK1RVcFhIaDBmQ3FSMTNqbGRabXNMRE9T?=
 =?utf-8?B?dEs0aXVUamFLWjVzVm1uZUkyMFo1UXF6UmQvMEFBQ3o4cU5pRnNOQVc5UHJS?=
 =?utf-8?B?T1YxNmNrL2J4d1NwSEE5R2xzdmpZblk5MEhSWmhaT01rZ2NveThwTmVNdnR6?=
 =?utf-8?B?RFlDUngrYmNoS2RCblBUOCsybG42anJ0WkN3OUZ3U1RuWk1VM2RDekFXSVBs?=
 =?utf-8?B?SzNDUXh3ZE9mOFV4RS9TQVorUUdjZk04cWdpYTRNQ0pPc0E2cVBRNkUyRjBZ?=
 =?utf-8?B?cE5TR1lUeTRoTGV0MVpXdjRhdHBYbTNadHluL01xNkFmclcvOG5MRnZlaWxQ?=
 =?utf-8?B?MldncTBuTXFFLzJ0ZitGSGdDMGxjSmN6anYwSGJqVHZTdFBYVHhjblBLcFhB?=
 =?utf-8?Q?imzGnBPzpC41e/KOZjWlvmM=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8facc75c-293d-4773-b037-08dbaeb2216e
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 08:20:29.5624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rnMl7CCGrnLopdJA4d/mOrY83jLeTTGI5MlyIvGzOAesqd3lj6aZCgByxjI6EQ/G+obDZ0MvnwwfN/GWjY5UANdSBfjFWFEuenGGbL6ymPcibOICEjrSb8Ex8YdyGIkS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9376
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sascha, Robin,

On 9/5/23 11:03, Robin Murphy wrote:
> [You don't often get email from robin.murphy@arm.com. Learn why this is 
> important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On 2023-09-04 12:58, Sascha Hauer wrote:
>> Add rockchip,io-domains property to the Rockchip pinctrl driver. This
>> list of phandles points to the IO domain device(s) the pins of the
>> pinctrl driver are supplied from.
>>
>> Also a rockchip,io-domain-boot-on property is added to pin groups
>> which can be used for pin groups which themselves are needed to access
>> the regulators an IO domain is driven from.
>>
>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>> ---
>>   .../bindings/pinctrl/rockchip,pinctrl.yaml          | 13 ++++++++++++-
>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml 
>> b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
>> index 10c335efe619e..92075419d29cf 100644
>> --- a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
>> +++ b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
>> @@ -62,6 +62,11 @@ properties:
>>         Required for at least rk3188 and rk3288. On the rk3368 this 
>> should
>>         point to the PMUGRF syscon.
>>
>> +  rockchip,io-domains:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description:
>> +      Phandles to io domains
>> +
>>     "#address-cells":
>>       enum: [1, 2]
>>
>> @@ -137,7 +142,13 @@ additionalProperties:
>>               - description:
>>                   The phandle of a node contains the generic pinconfig 
>> options
>>                   to use as described in pinctrl-bindings.txt.
>> -
>> +      rockchip,io-domain-boot-on:
> 
> I don't think "on" is a particularly descriptive or useful property name
> for something that has no "off" state. Furthermore it's no help at all
> if the DT consumer *is* the bootloader that's expected to configure this
> in the first place. IMO it would seem a lot more sensible to have an
> integer (or enum) property which describes the actual value for the
> initial I/O domain setting. Then Linux can choose to assume the presence
> of the property at all implies that the bootloader should have set it up
> already, but also has the option of actively enforcing it as well if we
> want to.
> 

This is actually highly misleading. Whether the bootloader handles IO 
domains for pinctrl or not absolutely doesn't matter to the kernel since 
the kernel is required to handle IO domain for pinctrl as well. They're 
not exclusive, they are not complementary.

The point is that the voltage of the IO domain **can** change at 
runtime, at any point in time. We could theoretically have the 
bootloader require the regulator to be running at 1.8V and then the 
kernel at 3.3V, both should work (can't think of anything that would 
work like that but why not, the kernel IO domain driver is supposed to 
handle that within the kernel runtime even).

The issue here is that we want to avoid a cyclic dependency, where the 
pinctrl is needed for the IO domain regulator that we're trying to add 
as a dependency of the same pinctrl. There needs to be either some smart 
detection or a property to specify that the IO domain dependency needs 
to be ignored. This seems unfortunately to be for working around how 
Linux handles dependencies between devices and doesn't allow cyclic 
dependencies. At the same time, I do not know if there's anyway to not 
work around it?

>> +        type: boolean
>> +        description:
>> +          If true assume that the io domain needed for this pin group 
>> has been
>> +          configured correctly by the bootloader. This is needed to 
>> break cyclic
>> +          dependencies introduced when a io domain needs a regulator 
>> that can be
>> +          accessed through pins configured here.
> 
> This is describing a Linux implementation detail, not the binding
> itself. There's no technical reason a DT consumer couldn't already
> figure this much out from the existing topology (by observing that the
> pinctrl consumer is a grandparent of the I/O domain's supply).
> 

I am guessing you're suggesting to have some complex handling in the 
driver to detect those cyclic dependencies and ignore the IO domain 
dependency for the pinctrl pins where this happens?

This can actually be quite difficult to detect reliably:
We need to go through the phandle in pinctrl to the IO domain DT node, 
then check all phandles there to other DT node (likely regulators), then 
we need to look into the pinctrl-0 (actually, the one for "default" 
maybe, but what about the other states of pinctrl?) phandles and then 
parse the pinctrt DT nodes to see if they're pointing to the same DT 
node as the one we're trying to use. Here, we also do not know if the 
regulator DT node has other dependencies that needs to be accounted for.

I haven't put too much thoughts into it so maybe it's easier/harder than 
what I'm saying here (or maybe I'm completely off too...).

One of the issues we're having here too is that we lose granularity. 
There are multiple domains inside an IO domain device and here we make 
the whole pinctrl device depend on all domains from one IO domain device 
(there can be multiple ones) while it is factually (on the HW level) 
only dependent on one domain. Considering (if I remember correctly) 
Heiko highly suggested we think about adding child nodes to the IO 
domain devices to have a DT node per domain in the IO domain device, how 
would this work with the suggested DT binding?

Cheers,
Quentin
