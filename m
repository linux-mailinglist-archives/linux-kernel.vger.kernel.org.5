Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1667F67A5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 20:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjKWTjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 14:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbjKWTiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 14:38:51 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2075.outbound.protection.outlook.com [40.107.7.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F54324A;
        Thu, 23 Nov 2023 11:36:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1Xhs1/1X3PFM1gBgvI6g8pYVenlzkvfUDYhxr+/b9tivgH0hMXiC80heSzNC9a07ztLNwDhgvxZK/ih8e0bt42LczUclqPAAf6p1sXjptleIo/8wreCiIDR7thDGedI2jlfNrbcWpZokqhvP05FLxi88a0At03J2qGSImGEdJBKKu04MJEsTaEWW6eHaDE/4aftvcpmNvijt9VejPKovSu3Lm4U/z8SSfEuLnPnLYBLAa5DfRoNxiZeIB3zSCEXtEh5Q0N2YphSCo1TRy9oupuxzuU7J/g0bzF2mW9jzfnMJCIxnRvJZXorIxwQxAw3WkDEwxUMRXLLfBhWq1Q67g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUFemMy0jq1PZnvmiVYxjR8QqLsKUIrdgo/AIXFP1MU=;
 b=G0LiGdevnHeqVQx4vtjYuWE6OpqojIPGn2ul7eKyGkid9MhibRL5JkVYyfadyB8EGKYJWoRyc7C9WVt5/K4AnwV3G+vojKcit4a1od2T5Nzv3C1lxDmpb7yWuI/IFVhzy2Ypsb04Q5tBu7L0raSFmHcjeE+HQKOx5l1LJ+YGe4ueRNOcB05q+/o2AJlTbnAa0h0jvrV8U4wi4FG31GdQ7yhPlkmc6ijyrFWOUsx6odtOX+Qt+/yhJZ19t/IrpkUQyKTCtfGP6FrJvKUgyAK/qRLXJ4IaG4LIl0DzN/DodzpSaEApOCZF/9pDngpRugtg6Tt7vXqUhWYEuN4+s8E7EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUFemMy0jq1PZnvmiVYxjR8QqLsKUIrdgo/AIXFP1MU=;
 b=2TNfr99hFN9YhNBhtEjbigyiNr4eWBkmZx/owVRBAZR0kArFVJ2ujrzu8VvkGnMAAkOZtaKR1RAYOi79Kpq4VdxgyAPRGZ7IGg1Sl6zRWLpjwP1NOE1TyUYeLK6N6X3fwbUy1LN1dNv5wFf8ZrmspzPrXhBZUM7nVDl7yBUGSQ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by GV2PR08MB9422.eurprd08.prod.outlook.com (2603:10a6:150:dd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Thu, 23 Nov
 2023 19:36:16 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc%4]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 19:36:16 +0000
Message-ID: <73080fc7-d655-48f2-bd59-a5e171d12e19@wolfvision.net>
Date:   Thu, 23 Nov 2023 20:36:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC WIP 1/2] dt-bindings: net: rockchip-dwmac: add
 rockchip,phy-wol property
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        David Wu <david.wu@rock-chips.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20231123-dwmac-rk_phy_wol-v1-0-bf4e718081b9@wolfvision.net>
 <20231123-dwmac-rk_phy_wol-v1-1-bf4e718081b9@wolfvision.net>
 <20231123-operable-frustrate-6c71ab0dafbf@spud>
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <20231123-operable-frustrate-6c71ab0dafbf@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::7) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|GV2PR08MB9422:EE_
X-MS-Office365-Filtering-Correlation-Id: 56da3080-315b-403d-300f-08dbec5b7589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Snpto0yvacscpiPNwGdZ3uRjOzwJ/UEuywh6z3UcbfvzIA780ZQJPeDEYzEcqXCiaVdYd3EeoCGx240P6N5JAn6+jcf/KDVdu2CgGai7kYDU/A42TGP/2IsABAH7uBz3MQ2C06n667GlbmHEPiclPoG1gUqd/8NfBN1Mq+qXkfykcz2nO7eCWblH3VbEU/8e8IAb5EnJBl9YMjNlEvyDwDOfgC5PumSE6ponexX9Zbk/8ywpxQoRlVDeaCaREyalF9/O3PmSY7UfcQixM6rrwb3GOW8Q9WVdqTBmsnidqGJaOB3TFX7xSh6BvcxmQxK3FXpzBKrZ8FPK/9AXszGJjtsOdHP4vKMpsFgJe4qKiYBvgfvhuHhHmwEjAKQZqE8pEWoonwyvbtzi+qDbSG4YKeE4O44jp42Yod8XROYe/naJowHzXG3EZdoej4z7LXRzJMUwtfoVro7ACwz+bl+C93JuRjZxLfVkxozABbnXON32fLGqktIYRIjWZjcZeXz/I3HTm8aYAoImviiP8ki9PZK3/ja5p9CFJouTwfvCjwRONJjnrBa1GMBw2BbmR7WUv9lkgFJsj9E/snGvvwvqTMwWpcXh94BE5ELHtaCmpnlmS1o1bpQtuDvswa64ToHftx7958NRnbcN413D6uZFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(136003)(396003)(39850400004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(38100700002)(478600001)(5660300002)(7416002)(31696002)(36756003)(86362001)(6486002)(2906002)(6666004)(4326008)(8676002)(2616005)(6512007)(8936002)(6506007)(53546011)(31686004)(316002)(6916009)(66476007)(66556008)(66946007)(54906003)(83380400001)(44832011)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmFPemxrRzYycFNwS0pETDQ0a1dJOGxEY1Q2b3FHeGRPNURSR0d4RXJ0VUNJ?=
 =?utf-8?B?U05IbnMwYWk4Mkduc0xJYXB5TjBKaDVYN3VMa29DZ0oyS0owbzY5MkFNNDBC?=
 =?utf-8?B?bDZtMVdyYXYrM2dtNHJ5TkFGUUtjM2ZDbVFIVGYxS1Q4OVVoTnlDdG8xQnFF?=
 =?utf-8?B?VkRubWYyRXNGQkhRNkhiUU8vYjZCbjlmOXVoWm0wOUpzQnl5aUFQajRGek9x?=
 =?utf-8?B?WlFpa2g2RU96Y1dXeDA4SHB1ayt1ZnM5YUFEcEluQUFFOHVrdS9JMm5qWkxp?=
 =?utf-8?B?VDU5dnJ5dFlicUNpQzQ1T2UzUGYzVnBseWFuSysrTWlaSkRIdlMzdXRJWkVK?=
 =?utf-8?B?NWZjODg5SHNZVW1aOWt1U0RFQ3pBR3JpME5yUzhLMkpzOHF4TzEzdXlhRmov?=
 =?utf-8?B?eGtXc3dIRnRObXFPNkpCVmNNRWFJQzNpL1VhMDVIemEyQzVURENxTExLMkxF?=
 =?utf-8?B?UmZCelAxcDJWM0pYOFR0bGdOdUtwMEFMa01ZQ0pKNTFqaFc3RUR6ekU5Nlg4?=
 =?utf-8?B?NzJ2cVhHa2IzWmRqcmJKZ1l3cC9tcUZZSFo0eGhDUmFmTW5nc2NQN2MwSDRj?=
 =?utf-8?B?dVhaOC80ZjJ1d3JmbVczYVZuZGliR3YzQ29VUVpFYjVYdEl5aTNRYnVNZUVF?=
 =?utf-8?B?UHBMNHpLaGNEZGtXZ01DYzU5Ymt1V3czT2o2a0U3MThQM3EzVXFCbWRMTEtF?=
 =?utf-8?B?YzAydHErWUJwSlgwcWNsdXdDMno0UmFBbEVMVDBlYU03cHQxNlhodWgrbnRy?=
 =?utf-8?B?bmtEV2lRTlo0K3YweHE2cnd2TkNXZThhRkpja08vRzEwQVpVWlpOcDk3REt1?=
 =?utf-8?B?SWhBSEFXcDN0cWVrQjVwTDBERDZENXlGSGpZdmhacVdZTjhuaXhuRnNLcTE1?=
 =?utf-8?B?cHNTTmUxT2ZrSkRyaTdVZ25kSWZMNS9ONTNLNTREWE1YZXppTHhnaktCK0Yr?=
 =?utf-8?B?MWpHT2tBY0tiRHkrVFNYVVI1VDQvZFRYR25wdTFhay9wT1hWOEZaQVlYK21G?=
 =?utf-8?B?eDY5dkN2Ui9jZWdBcXVZdzgyU3JVa2VmWmRPTU1Hd0I2Vk8vVGk3ZS9jNGZL?=
 =?utf-8?B?SVM5Wnd4cytnOURsTEROQkNqamozaVNWckJmT0ttUFBETG1oUStGTTFOd1Jt?=
 =?utf-8?B?SEVhc2VmRDlEcEZqaVlVZVNjRGNmYWpXSlJjWE50WDFic05oUGVYQXpQMVJT?=
 =?utf-8?B?RzRqdDN2VERLZmtueGZFKzhHL0R1L2NRZUhDNitMekdlVGZ2c0FTNmlGVG9n?=
 =?utf-8?B?NHdJaFdaVVVyd3lDNjdKSnRGcVRCeDBscWpoYk50a05qckp0ckRhakVnbWI5?=
 =?utf-8?B?RXc2OG4vc01qVU9wS0dRTlJKb204SHVoTFJWYlpZdFdyM1F2M1dkcXpvZEk1?=
 =?utf-8?B?eE5jeEpjYTNseE05emdmTVQrZDkyQXhSdEl6M3VkYmZhUVJIU1NUb3NsekFU?=
 =?utf-8?B?YytNelZsV1d1YkhXY0szY3kvUG5UaVVXeFBWTzBnYTlsMFVaZjFCeG1BRHp4?=
 =?utf-8?B?a1V0ZGNsZ1E3cFBnUGpxR0pqQ0lvSTBpRlRpSENVVmdlWXBZRVNuN0dzNEFJ?=
 =?utf-8?B?TFF2ZnBjUnFqclJSZXhtRUIwcmwyODlkQTBsZllxVFFUVE1Mb1FjK0p4ZFJk?=
 =?utf-8?B?Q1JYZnZpZzN6bjl6eW5Ua3lwS1k3a0g3R2gyTkFYV2xXaS90MEpKTDN2STVH?=
 =?utf-8?B?TmF0QXJJRUp4KytVQ2RhUTZJUkVzbmx2TCtxa0lVUWtpdXhQamg5dUU3U1JB?=
 =?utf-8?B?cFJDdVk4YlRVcG1rRExveXBneXVESlYwU2ZjQzBJcXIwSGJlenpSK2sySzhF?=
 =?utf-8?B?bTVVZHRzSEdwNDBJVmJOMmdCL2NRbzdMTGlxSkFPcHE2QTU4QWdwZkNLbVE3?=
 =?utf-8?B?NHcyVWc3dGhHTUc4ZTBFbHUraU5MSUt6K0VLME1oemhQMEVZWDdYQXlsKzVB?=
 =?utf-8?B?TXF3L0trcjVWanNlbk9wRFhBS0xZODlkT0FBY2ozQ29aTk5keXFwV0ErRnlY?=
 =?utf-8?B?QVdSOTBueDI1akRCcFRLZzFWVk9tbTBCQThjNCtvWG9tcFAvWkliQi9tVmtw?=
 =?utf-8?B?ZHlyelBwY2M1WU8wYmtNNjdRNGM2aHJyWkJwSDBZcjhmTjA3eUwrY3ZVZWl0?=
 =?utf-8?B?MjE4d3U4Ny94TTB4MXZScC9BcGlXTmZCQnY3dlFNYUcxQlljbDBmNG1lY3Nq?=
 =?utf-8?B?N3hxNm9GT3ZtNVF1TTJkc3dMQjlmdGZ3T1RwdHhRMEtsZzZzMk5yQUpBc3Vx?=
 =?utf-8?Q?IJQyPP2GFMNhBKzmEEIS/x83Af4w1+Z1jqn67SI+RA=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 56da3080-315b-403d-300f-08dbec5b7589
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 19:36:16.2540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UyJBuijMjf2h01cpPM3Arf6PHbf9pdf0GsQXfo8Qa73ViZCO6JEUnQOJFZEtoa5toSNTUV/ZhGf5RUJIawwBmqYZVzKpYrYeirynvqDebws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9422
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.11.23 18:20, Conor Dooley wrote:
> On Thu, Nov 23, 2023 at 01:14:13PM +0100, Javier Carrasco wrote:
>> This property defines if PHY WOL is preferred. If it is not defined, MAC
>> WOL will be preferred instead.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
>> ---
>>  Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
>> index 70bbc4220e2a..fc4b02a5a375 100644
>> --- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
>> +++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
>> @@ -91,6 +91,12 @@ properties:
>>        The phandle of the syscon node for the peripheral general register file.
>>      $ref: /schemas/types.yaml#/definitions/phandle
>>  
>> +  rockchip,phy-wol:
>> +    type: boolean
>> +    description:
>> +      If present, indicates that PHY WOL is preferred. MAC WOL is preferred
>> +      otherwise.
> 
> Although I suspect this isn't, it sounds like software policy. What
> attribute of the hardware determines which is preferred?

Maybe the word "preferred" set off a red flag. The description is taken
from the mediatek,mac-wol, which is used to set the same flag with
inverted logic (I could invert my logic to call mine rockchip,mac-wol
and use a description without "preferences").

This property is used to enable the PHY WOL in case the MAC is powered
off in suspend mode, so it cannot provide WOL. This is done by a PMIC as
defined in the device tree and that should not be something the software
could tweak.

Best regards,
Javier Carrasco
