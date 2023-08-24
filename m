Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014B6786ABF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236594AbjHXIwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240647AbjHXIwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:52:40 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2130.outbound.protection.outlook.com [40.107.255.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB47E68;
        Thu, 24 Aug 2023 01:51:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RK3h+xXn5rXQRmqw3gOwq2RLp+dW4pfvwirIMf92MTiXtvQdHsYBKPULOo7KsNmlP3WjPWCzLo+K/frpuplV1X8oDFPkskxr4ocYLVxZRFX86eB5iN44j0XahgUxhx6nM6F5qft2yLY9PpZF5N+sivl6qKjHDHT2kSGkY/OsZeM+TXMFz3NkV2hE4ndKcz9cprZVnmCiMzPDe+AbukyUfB5S2XvMWwBkEJFuBOidIKjOpR553btdQGe+i+GSJjrOR0+/hSmrIMv8F21Ho/Qq/oMO9jQlGq2mky5dJUdbeJ+8TQtPcd5Q1YTpjq9rB20PiV6/QZVSRl7WxymiQXPaPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cn6/24uAgbXT4P8/ZpxJ9rKcyIVb1kS51oNGxHcZr0g=;
 b=aAyjFizcCwgx9drHscBTICC5G5dllnzb6NbFmrqIbfUtII13SzYcKpl0NuFCjLE2rQBh+o+Nqj2GaQE4po+bhpt9X9UcNGGztol5jBwgjua+lT8d43fQO5Wkutzw5iknTjmvjTJZLqBAJsrRfHtDZ/X0KpGMFyj0npREgeS5vsduiAvr9DirotE3l7EZ1AeCRP8KFjsfzfO5ApnQtzDg0N0TwpKtf3RROZjnuOYfHbE1yduH1bUBwSBQ241OlnVWyJNweAzkwBxiyeMj5v4wgXSkKINKwEwJKlvtiMqbaDtKXtEHz0kWXBqlHOjIcK0PYDk1lgI3X+8h2oC0/Yno5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cn6/24uAgbXT4P8/ZpxJ9rKcyIVb1kS51oNGxHcZr0g=;
 b=hxvL6RDmGH3aDM0v257rJ210yzqMMysfSUuKBQdkzJtvg3HB/McNkFCJ3Kl+y/jzpwcD2frOoKXLgGc7DreeJMbTLWlMJHkX4qDfcbGSBfHVo6xqpuvbf2CoF4+8nTLqmSKGDOUiz/+NwQsRHQFOTQb+0rlZYz48CACNz6hVikedrH61lKsOPocgNzJTG61gbURVvLE7jWpqnHQcuwrG45zb1YNB3tStbPRv2P41HjPlsrv9RwjCDm8K5TVZ+8P9NPa5oKuMQZCT8bpfLkAZR5NfCj3b5THDj0jtXfzNMd4BBR23BpRPsc8m3yEyoFPi1uShrcIX9jRMfGAU+WZinA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by KL1PR03MB7527.apcprd03.prod.outlook.com (2603:1096:820:ea::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Thu, 24 Aug
 2023 08:51:46 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::f065:6e23:803b:2a75]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::f065:6e23:803b:2a75%7]) with mapi id 15.20.6699.025; Thu, 24 Aug 2023
 08:51:46 +0000
Message-ID: <56c0b78a-b9dd-de6d-7d7e-654fc5dd8e1b@amlogic.com>
Date:   Thu, 24 Aug 2023 16:51:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V2 6/6] arm64: dts: add support for T7 power domain
 controller
Content-Language: en-US
To:     neil.armstrong@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
References: <20230824055930.2576849-1-xianwei.zhao@amlogic.com>
 <20230824055930.2576849-7-xianwei.zhao@amlogic.com>
 <27e55b16-065b-4a16-ab05-dded04f2c705@linaro.org>
From:   Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <27e55b16-065b-4a16-ab05-dded04f2c705@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0195.apcprd06.prod.outlook.com (2603:1096:4:1::27)
 To TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|KL1PR03MB7527:EE_
X-MS-Office365-Filtering-Correlation-Id: e775d35f-8823-4677-30a1-08dba47f58b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LVZ5aYneh8lGqJ2UbODrUCXX8ESr8Gp9PBCiawBWgtgrd6XhTFA70buO3BAdKjX/SKynlmO7AaoT7rvjJETvnNnGbmQeHU3rwm+jORGQFuLOULnefQqiCtZzGypCxaQu6S+CnoiwyvPyxv4we5FHWamAMNVTIvWvRto/6Ez449SNfaJ8SQhoUApKnhftMSiSpZtxsAY0VwEp5+RctVjiQ7Nk1VYvO7Vl0VW8R8SW8TpVdEOMlPgMpiRNxsRr7/Xt4XGTybHLDs/C0hlA8/8EiLB/qzAwEbv17jJDEt/wE6AGEJobWR9zDhA8RoYEaMgOfrpid6M5U+gzmtKREezgXOyfi/L54pG+XVCr2y3wqz29RFtaOLuimZTwhtAYf/KSnPnYBB152IU8oUEgBm7dnv5xksb8JFQEIAKVszu4WIJgW9g/CG/0qV96P8V3mpYFPd72h7PYb7uQQsJqlEsbpHTdXZBQsXE33tX3Q8yFL4u7/JloBsYkRn9En7uIV1x4fEU44pETTvm+gxKb8nSVBBD47gr0DXVEHyVCEuVxcXeyYQtCwry0tpcxJ2TMiIa4k+dY7tXbuU9GdE65KOgyvxDMyKWy+MQgS2iBq38Z93R/0v0CxGl2zZTQdIydkZF8T5wiV1gOFSjVHbvoxctT9408v0FVLiLRL+QiXndljhWr4eKPgtpuAUhmMF4yB8n9p0zetrx/ULnF0xvEBDebaMs/0H8skAIK8Iiha23jBq0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(376002)(366004)(346002)(396003)(136003)(451199024)(186009)(1800799009)(2616005)(6506007)(6486002)(53546011)(316002)(12101799020)(8936002)(8676002)(4326008)(54906003)(66946007)(66476007)(66556008)(41300700001)(6512007)(26005)(5660300002)(44832011)(6666004)(31686004)(478600001)(36756003)(86362001)(31696002)(2906002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WG1nSy9Cdi91VlBLMUlYTWM1eHhXMElCSFh4ZjNaZVpjYXFCdC9ZSlIzZExx?=
 =?utf-8?B?Vm1SQnRyalJ3MEgrd2UzaWhmdFlaUUNxcTVnSEVyUWgra2ZOMzRJU1N2d09l?=
 =?utf-8?B?RndTRnRralN6TmJEem11TCtxMWFoc2t6QmsyZHFEUzJoZVhsWG5RZ0RUOUlq?=
 =?utf-8?B?amx3bG85QW1PaU1zRXY5c0xnb0d6dnkrQVVuK2lMVVRaSjV1UkF5RWFzOGJF?=
 =?utf-8?B?OU5iZFkvUS80ejBJTUVNMlRTaUpGU2xLNDRudzVjSGJndjlaQ2RtYWZ5TGl1?=
 =?utf-8?B?UW5UazFObThya0pTeC9Ya0FBMk9YTlRNWWVreVpMMEI1SGc5Yzd6RTlFelJF?=
 =?utf-8?B?NVpSazU5YnR0VmV3V3dWd01pT0pibm0rV1ZQZzg5RmlzRVRyRG84QUFHUElR?=
 =?utf-8?B?SGtYZUY0d0lKc1ZsNkt2UmluNmpFait4VVV0NGN4TmZCMG81STdzSXU2Q2Nr?=
 =?utf-8?B?Yk1LaTd1Z25oeVJGVEQ3YnNwVVc5cjdINFpGSGc1SXgwRTM5cmRGZkhXU2JQ?=
 =?utf-8?B?Z281M0Q5MXNZYVB4clQvSHdFY0RTbGdEek1hK1hDWmVyMlhRYnE0K0l1OFU0?=
 =?utf-8?B?NDNzeFRjYXZJdGV0MlJkTGowdlY4cHNuSGxWek80M3pQQWd5dmNyc21wLytZ?=
 =?utf-8?B?MkpxV2NibEJBWFZDZ0d4OUxzeS92ZG5RV3dGVXlnYTFjV05RM3BpYmtscVhL?=
 =?utf-8?B?NjVseXM0QUtWSVZHMkY3ZVY3VW9XZlBjanVxajZ5SXFLdHQzcDVqSmYrR0Na?=
 =?utf-8?B?MC82d29OWVNCbXBkK3A1OTk5cUJhYVQweFU2RXRTSVFLcjRFaHJLa3JDZThq?=
 =?utf-8?B?cFBzU0ZIdkg0NlRPQkJFL0hqc1FjcW84YmRJVTBFZ21UTkZhbU9WaHRrQ01W?=
 =?utf-8?B?eEVYL1VreVNlMUhkNW81cWJWdVZyQzErV21kOTJDREhiWk5WNWc5R3dQMWJx?=
 =?utf-8?B?am94NERKUC9uQzFySWM0RCs0UkRyb24xbURxOVV5cEg5bnkzdFNFZWgzYlUr?=
 =?utf-8?B?anB4eExMNnMxd0VPSXJ5SWV0bHhQc3pWamFqNXV3ZDA0cUVlNnZCMkJoVWQ5?=
 =?utf-8?B?WWJQc2FzWEQxMVpnK25zdENYWUllS1FPbVpPMGk3Mi9OV0RjMEh1MEtGMjJY?=
 =?utf-8?B?UDdOVDNIbHk5d1JZVHFTdzhDS1diZERsRGZ1YlRDZXFjTTIrTkttYU1YWmhZ?=
 =?utf-8?B?d1dOVDgzOHNOR1FGTUozbW1JaWZFNUxmYThnNDkvek1yZ0lTR2V0NURtUVJU?=
 =?utf-8?B?MGhIVXNaa1ZWRlpyN3kwa3Ura01SdGcvZ3o2ZXBTQ080Uk9XbG83UitFL0VN?=
 =?utf-8?B?VndNaTlRTkhPRDdIMGVYZmpMb0twWkRkVHNKTjJEZ1YxdU1DNmlzNFJ1TzBn?=
 =?utf-8?B?VW5leFFIelhhRHdCV0taOHF6RFMwbm83eWN6ZUV4b1J3QUZMWktuRWgyUnAr?=
 =?utf-8?B?ZEFjUVdFUFhxaHRWQmlpSE1aSGFqS252RXRpQng0a05SbG1SSE95MmV2TlF2?=
 =?utf-8?B?YUpSajYvWmFZQkhMK1dISmlXbEZvRlJQRi8zS2tsTDJSN285T1Q3dGZlQWN0?=
 =?utf-8?B?ZGRwaFQvS0pHc0hBVHpwQWVPenpVRzhIQW84c3M4dXVUeGdnQlV1NmpNdm8x?=
 =?utf-8?B?cUovemFneGx1dU9FelFOYllrd1JRSmlNWEZsVGVMWk1lcTVoOWtpa1orc09t?=
 =?utf-8?B?eEg5SEN2eGR3UW1ybEtsa3hKdm5IL3pmMW5KV05jVGNTc1hMem1yeGtET00v?=
 =?utf-8?B?dHBmNDQybGx2VE1RcDg4QUU1WVJmTzhJMXpDc3dFR1lFQStuTWlVVVpmNE9P?=
 =?utf-8?B?NktFOVY4cFM3SU1rM1RtZHdhbVNqL2k2eXZFdTNaLzh3VXcwUGZpNEpjdkJH?=
 =?utf-8?B?cHJXUkhPNUhBaXpzWWVUY21JdG5ydGhmRXduRkt1WktTMTFGU294eTNBdUdT?=
 =?utf-8?B?eStWOGI2YWpublkzWFlkQnlxeXFNaklXNjkrY2pzU3pyWVp6K0wyOTQ3MExN?=
 =?utf-8?B?d3ZJK0ZYdmhFQ0dsQVZOd09mdDlKaGFkSXVpVTNmTUFUSGZlSVM2ak0wcjFM?=
 =?utf-8?B?b0MyZmh2VHBHQzMvamlCelU0bkdIaGlvdGdXTnZmcnNpMFBCZVoyd1V4L3VZ?=
 =?utf-8?B?NUhFWTFqZ2w2UC9ISUlQNUNhZlEydzVVMjA2cnRaNlRNU01wK2RtT1hSaU9F?=
 =?utf-8?B?Y3c9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e775d35f-8823-4677-30a1-08dba47f58b1
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 08:51:46.0240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OLD6gKImlkmtT3cFY92G4cWKrnwTsHowiK+0XrGHDh2U7Q2IplpSOMT7GllcqUE6smb1E+pmYoqX3Ncgdujem1Gn0XxzXvWKrikkqOaQF44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7527
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,
     Thanks for your reply.

On 2023/8/24 16:32, Neil Armstrong wrote:
> [ EXTERNAL EMAIL ]
> 
> On 24/08/2023 07:59, Xianwei Zhao wrote:
>> From: "xianwei.zhao" <xianwei.zhao@amlogic.com>
>>
>> Enable power domain controller for Amlogic T7 SoC
>>
>> Signed-off-by: xianwei.zhao <xianwei.zhao@amlogic.com>
>> ---
>> V1 -> V2: None
>> ---
>>   arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi 
>> b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
>> index 1423d4a79156..23cdad1b425b 100644
>> --- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
>> @@ -4,6 +4,7 @@
>>    */
>>
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/power/amlogic,t7-pwrc.h>
>>
>>   / {
>>       interrupt-parent = <&gic>;
>> @@ -118,6 +119,11 @@ psci {
>>
>>       sm: secure-monitor {
>>               compatible = "amlogic,meson-gxbb-sm";
>> +
>> +             pwrc: power-controller {
>> +                     compatible = "amlogic,t7-pwrc";
>> +                     #power-domain-cells = <1>;
>> +             };
>>       };
>>
>>       soc {
> 
> Please change the subject to:
> arm64: dts: amlogic: t7: add power domain controller node
> 
Will do.
> With that:
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
