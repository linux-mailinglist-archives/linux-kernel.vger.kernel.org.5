Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74307EEA63
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 01:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345598AbjKQAef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 19:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKQAed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 19:34:33 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2097.outbound.protection.outlook.com [40.92.103.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91D7129;
        Thu, 16 Nov 2023 16:34:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJA93s8w71eQ1W5YXYpuzG6diywWWI5RnLQioFMiCfLzVabdX9VdEdr96r4tmfMh/wlWPyEibBzO0nh3ArHVNCmiCldYcSn1cY965qqb3XUreInkzzmAm4kYFvqxUZXRGg68qeLU0PTUGbciHY+1ypZwBq3MTHjXlIQO7X+lH/RJOe87VoE6qIXKdHEP4W8q/NuDmDpzkwVG13s9nDxqQnyE/XablatUl3FCvDMI0Ueq943c33ItVPWcMaYGGzmq586UsWlA89k0JNvv7uYj1i4w1d9vuTvqXVlDX7q+Zvkbmja508Ra+HJTLpcx3c2eRm8Xs80yUlpKLZq+tYuTZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6ym7RrgI+PlKRERFlZ52zoThX+zqoa5OVYAcBrMVFI=;
 b=nJZaKiHF0ZC+eFo3vfrDIhfUFp79s6USBGpkEPEwMhzpCBjqmx947s247GXr3c9qoTQdyZK7rE4TsUkOCw9gz19q3yG4jNdIAsaxLhr0vQEH0Q3ZcyYHL2O+SRUq15OOgQA5tmwzpAHy6ZGQLBnEexhpNZgm0cgEtOhlqV0/NJMBcS2dCiMilSqJd6J0WZ79Dm7/wJ72blTStKCmPYbBamuhSr0/YUCTBO2HCwnwMXxpz+eQxiRj0PzKgAC0ElfKktbu+6pnI7+zJD3AFU7jwqLxUcLfFCSYLx7ne//cjgknIevrjg2suhcqY2s2SmqMDbtB+E8gv05tWvItXC3Jew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6ym7RrgI+PlKRERFlZ52zoThX+zqoa5OVYAcBrMVFI=;
 b=JJBFYG400phBYXjARsbMmovwRCi8blEcGoZ8a82kVNFGoWO8GDel2wBvB0w9DQflkQFSru8DReYKLQHnx/SinoT14xK8Jv25QQDEr+zifCJRophn7g4RY2kDGsNo8nWX0qTCx1kouDe9IsyZ27YVllJ49r9ZOSAWJYcfET/JwJSThN2xAF+6N71sPpFSdy5Tg/hBor2SMsegxTCBeJUHXeSrFfRVZjmACwV74Vr3EhwmzZ+0lrIL2css0Vvb5F87+fX97jCahwPs4dCbqJk01LtldaVAnEwgWwMhF82CRE49nKr17rg+LdZ6Zo+2KYB1LiEzAa7dKYZMYt+HPKX+nQ==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 PN0P287MB0489.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:11c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.23; Fri, 17 Nov 2023 00:34:21 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b1a7:eee7:e903:9ef3]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b1a7:eee7:e903:9ef3%7]) with mapi id 15.20.7002.022; Fri, 17 Nov 2023
 00:34:21 +0000
Message-ID: <MA0P287MB033225C00657712137176D22FEB7A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Fri, 17 Nov 2023 08:34:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] dt-bindings: clock: sophgo: Add SG2042 bindings
To:     Rob Herring <robh@kernel.org>, Chen Wang <unicornxw@gmail.com>
Cc:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        richardcochran@gmail.com, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com
References: <cover.1699879741.git.unicorn_wang@outlook.com>
 <1e5836360485b63e15bdf58da59e83139666b290.1699879741.git.unicorn_wang@outlook.com>
 <20231116181847.GA2659392-robh@kernel.org>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20231116181847.GA2659392-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [n49AXS2Fpo7PXFEQtktXhPmMqLhxdCJm]
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <e62fc333-da64-4b2f-ab65-cba3c30347e5@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|PN0P287MB0489:EE_
X-MS-Office365-Filtering-Correlation-Id: b62d2489-af08-44ab-34f1-08dbe704f0a9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v0jtMvDW/NEUo46jA2lsbhnRGTsu8fO/RJ65VSA3bu4HygCqXR3NO+6O4y8oO05JqjHlepNHTsJuZz2iCLk5jfM0gOB3Pu0iY1ZFSnePMiEsQuc3mw5j23WEhUlTan5vG416mhKts+hxD3TmFWJBZ/QG0j5EI5iwjzGSFJulSG2aiZhtMvsz2nWnBN6zPkJ132UNEdWOhNKRs3feKQS6352OlnNFcaw1miHnKJV57iR9cqgmNYZ2J++fmYH7C9kZ/bvWoARHE29xhy0iQDk6Y+K7jT+QvDTCjdlvAndIpf5nqU9gQDSQjzlMfwbYqbGD9gasse4fdOfhUQ08zEcv1LLIaNj5suGUpA1FUYmKcV7HletwQ9WYGBlR1ytT8esQKsHdH/XwIvGRNnLShdLkJ+AJRQDxc0NiYNx8RfP4Cp1UpPTt6LFwS2T1SRcQ08PGJiQ9j5CTJxDRZdLRCN0TuWhLg9IU1lhGIMomaJJpq9svaNSWNIgYpQAfqqMUPDIoHFEFscA7vZOmPHvNnxzQEFQTirtOMEg2peXYgWZFMtoLaTHrvvduBEsyZHldUIawUTdu5vj/NFB1p/oR3I5KVv1DCbmHoteVkae7okP1RNk=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1VpUDNYSS9GeUc5TjJLQU9BTnpDcnY5cVVEcVVMa0w2WmM5ajV4MDVXR1VT?=
 =?utf-8?B?elkvQ3hybWxCeGVyL3AwcE9xTkNYYVA3LzdvSHZodTBTNGFqaXpuNUQyaFlC?=
 =?utf-8?B?VndoUG56azNJSmwxN0hvejlPdjlyeGdIT0tvcmdZZzNaSUtHN2tWNjNZRUVC?=
 =?utf-8?B?RkxyQVVKVGdPK205bXBLUlpKRVFvMDZlRmh3U2dsZnZmb3orc1hiMVl2elYz?=
 =?utf-8?B?UEVWVXNqdUwyTHJwT3BBV1hJdDVWQUJOMmhMK2RpcVYzWDkvTGVqaTFlTWRp?=
 =?utf-8?B?Rk0xcTVQeHpaY08wZU5hMHlLR1RRSkZwNnhrdG1XaEFudlZESFBhaUYwdGNB?=
 =?utf-8?B?RWVkcGVGZjJOSUZFNFRUeEZkRE9vdnpZTWc3R3Z4dWlkS2ptbXJ6R1NzWmVi?=
 =?utf-8?B?V1pjQWdITGZHaklWTThhVjdzK3poL1V1QnZoQXN2OE8wV0EwdldOK0htamdp?=
 =?utf-8?B?cm9WcW9ZSFFNUkRKTy9HbFNrQTdGYnYrbjl3SFFtNUdJVXpSLzlhWkc2ZWMv?=
 =?utf-8?B?YWNlVk92TnZjWE9xaG94MVZrSDZMVEpwUFNkRGpJQWh6K3hEVWhnQ1FvUDJM?=
 =?utf-8?B?ZTg0VVdrUm10emJuTEhnL1NMMWNJdlRya285cHJzSERsTHp5SFpiVXNkS3NG?=
 =?utf-8?B?eGdQanlxQzN2Y05OaGRvV1ZjOU4xK0EyUDcxcFRYczVRMXBrdVFtZU9PYlhi?=
 =?utf-8?B?STBMc3lqOGRoUzdVR3ZGSkN0RTRPV2hIZjZiSENJMUN5dHNRK2Y0OVJlQ3hL?=
 =?utf-8?B?TXhuM0Z3UkN5SEJ3Q1pwaC94eFBSUDVrUXNoRFdwR0pwYUJHL3gwNFJBRWJn?=
 =?utf-8?B?b0w1ajBucHlmUmdKaHNGc3pIcy9aaHZGNm5lUVByRlVQYm82WXdwRFpRbUVB?=
 =?utf-8?B?ays4anN2VnZmL2hGaXZ3dWVLSDltdk5hOWlhd2dqczQ3Sk1TYVRUKy9MMjFT?=
 =?utf-8?B?ekNydEFFaUtHMUJOVFdpK1lBUk9XeFJmcFN1alVRL3dINlBWTS9PYkV4Q3Q5?=
 =?utf-8?B?Qmo5aTUvZmZFSjZqTkVoN0ZsQXk2VnZ6VmpPL2lzaU1LL0hOdWxKemhNd2tu?=
 =?utf-8?B?Vjg5UjRwRStEOHd0L0lZNC9aTUZaTW8relJkMHdlVmxuNEE1cGxqR2ZieUJI?=
 =?utf-8?B?WUl4MkthZDc5Y2ttanNseGNGOHVKaFFFNVRwUGMxRm9SSEpta0ZTenZwdWdV?=
 =?utf-8?B?T1B1cW5ZbjVzSDJ4cmIxQVhENFQ1ZjBScW9RNHpBOXc3dWlhZ3pqNVowa2Mz?=
 =?utf-8?B?a1dDS0YzZHlSYi9tYVhqbzVyWXdRcWxXNGFON3pDNEtPZjY5VE5Rem9od1Nl?=
 =?utf-8?B?SlkzbWgwRlJONlloVlFQeTJCYVY2cTltR3BvYnVZVWhRaUloSCthblY4alNC?=
 =?utf-8?B?dDRSczVDMTYvMTFLd1pET2ZiajA1RE5va1BSUDlaVU5xSmZhOHlyR2UvOHBt?=
 =?utf-8?B?MkVvY09Pb2lvS3loVDdMRCtQNWtGWTBoeHdHZ3FTUEEza2hxL1RYYVpOelpL?=
 =?utf-8?B?bE55OUh4dy9ndlg1Y2hwMFI0U2lUOWxoTzdiMVk4a3lJbVNtSXJETDdvQXdO?=
 =?utf-8?B?NTRhekF3a1NNYVNqdWhyVDZNSnJQVloxTU42YUxGa0dtNU1kLzVXZVYrTHhO?=
 =?utf-8?Q?Ucf3y9wU6iF7XP05wZf7r+6AtIsgKLuYkCC+uD5IUqPk=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b62d2489-af08-44ab-34f1-08dbe704f0a9
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 00:34:21.1860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB0489
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/11/17 2:18, Rob Herring wrote:
> On Mon, Nov 13, 2023 at 09:19:31PM +0800, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> Add bindings for the clock generator on the SG2042 RISC-V SoC.
>>
>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>> ---
>>   .../clock/sophgo/sophgo,sg2042-clkgen.yaml    | 48 +++++++++++++++++++
>>   1 file changed, 48 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/sophgo/sophgo,sg2042-clkgen.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/clock/sophgo/sophgo,sg2042-clkgen.yaml b/Documentation/devicetree/bindings/clock/sophgo/sophgo,sg2042-clkgen.yaml
>> new file mode 100644
>> index 000000000000..e372d5dca5b9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/sophgo/sophgo,sg2042-clkgen.yaml
>> @@ -0,0 +1,48 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/sophgo/sophgo,sg2042-clkgen.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Sophgo SG2042 Clock Generator
>> +
>> +maintainers:
>> +  - Chen Wang <unicorn_wang@outlook.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: sophgo,sg2042-clkgen
>> +
>> +  system-ctrl:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    items:
>> +      - items:
>> +          - description: phandle to System Register Controller syscon node.
>> +    description:
>> +      The phandle to System Register Controller syscon node.
> Forget what I just said about syscon.yaml...
>
> You don't need a phandle here. Just make this node a child of the
> syscon.
Yes, making this node a child of syscon is a better solution and then we 
need not a phandle here.
> However, why do you need a child at all? Just add 'clocks' and
> '#clock-cells' to the parent directly. You don't need a child node when
> there's only 1 child node. Maybe there's other functions, but I have no
> visibility into that. IOW, define what all the functions are so we can
> provide better guidance.

The syscon is a module in SG2042 that provides multipile functions, and 
clock control is just one of them. I will add more other functions's 
nodes later under the syscon in coming patches, such as reset, pinctrl etc.

>
> Rob
