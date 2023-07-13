Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD6E751CBB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbjGMJHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjGMJHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:07:24 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2086.outbound.protection.outlook.com [40.107.22.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DEAB4;
        Thu, 13 Jul 2023 02:07:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBUucLMflSLWNklZLJZITqbKKa+tgOsLOuNsH4GYLsq8mwDYekPfXmVSYMcySX2Cwqpey43jTOuuw7BrRZCXvbggcfYv43z2Ox7ymH5KYWfNg2htzVeHNd0yz/GRiOMnFEPPGUYh93O07sr8mT0PCUsnJq1lJ40dX/W4LdqQaoiVRFJX68X11qRcNDW4F3WphRoAGU0zaTNxXNVyIVygiuNum1bcVH2vQ2CiSUeDEijqQII/mKTlFi/Z/mw6H0ju9wfFcuOlx9oYjJPQz9ZESjesXLh2IFyFgoVZRb788eXMDNP7pHJreW0LCefpfTDf6pLdztmQ+6xcaWfQp8IIdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmCtY+4gzxNDiXZErN4AgFPXnQOrjhJFUCtU01QvHBc=;
 b=Xw8cT6HhtiKPAQ3kioxut3ni2Z2kfyYFOi5i2tmp9HYW++a06WFkMd4pRAlz8v7+oappAQAKEtmL5geNsWsq2vx6bkYYOhpPiUxAnMjUViHURNcIVu2iggZRj9bKUJiE5C9L9cyfKGkySvjT+AaF1CAjjZk4H43IzOCl6IxYn0Ma+mtgSUkwxvyTUH3kV1BReicKWd00V5CxBTI8xiN0188tIDbR+Q5SdefSwYD2LbNWuWbMbmBOMZxjTA4f7f7J++zz3KHxlJCMSVScM31Q8XB3GlwEuptHLZ1sVyvWjbkPoc2ehSQMFUFy73nmEoqun17vhnf5UiZ84Vwd3oe5Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmCtY+4gzxNDiXZErN4AgFPXnQOrjhJFUCtU01QvHBc=;
 b=ihcXBhzVjDJaTdRqo7YqniFbQ+eYNlW8hczCQciGylnTD21F3qwwXhPhK8ogRBFsbSNUqTvYhUCjW+EyG7tX1wfyUs4IeZ5YOBEjWUscZP9ERDRB20erqJIuiSambPhzhZk4n6JcJAZxc6pbbEhKFPliS/onLyRSr/GVz01UTYS0PQY+Zsymbm76nbAbtwNaq7C9qq00CPGc4ms1xZNE5llFEd8LlZM58s3xrHznNEONi6FeF42mkIPeEr46GXIM+RVh9D5T4lCoYqiQLn//KrKgHO4tpXqatWB77qiCdwbVpHbLN2qfu35fMF2bgwMA2lRr6QAvtZ97+CCEmsSa0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from HE1PR0602MB3241.eurprd06.prod.outlook.com (2603:10a6:7:17::28)
 by AS5PR06MB8600.eurprd06.prod.outlook.com (2603:10a6:20b:677::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Thu, 13 Jul
 2023 09:07:19 +0000
Received: from HE1PR0602MB3241.eurprd06.prod.outlook.com
 ([fe80::8413:b7d5:15ac:63a3]) by HE1PR0602MB3241.eurprd06.prod.outlook.com
 ([fe80::8413:b7d5:15ac:63a3%3]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 09:07:19 +0000
Message-ID: <0e75c874-1d3b-7ccb-b201-2387e09e8516@vaisala.com>
Date:   Thu, 13 Jul 2023 12:07:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] dt-bindings: net: fsl,fec: Add TX clock controls
Content-Language: en-US
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>, Wei Fang <wei.fang@nxp.com>,
        netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org
References: <20230711150808.18714-1-vesa.jaaskelainen@vaisala.com>
 <20230711150808.18714-2-vesa.jaaskelainen@vaisala.com>
 <006f9599-6aa4-52ac-068a-831893ec6bf8@linaro.org>
 <49bf4392-299f-cb4b-ef4b-f920faa65866@vaisala.com>
 <d72b2806-c4b0-50ef-98ea-7f06c47b1c6a@pengutronix.de>
From:   =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= 
        <vesa.jaaskelainen@vaisala.com>
In-Reply-To: <d72b2806-c4b0-50ef-98ea-7f06c47b1c6a@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3P280CA0007.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::10) To HE1PR0602MB3241.eurprd06.prod.outlook.com
 (2603:10a6:7:17::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0602MB3241:EE_|AS5PR06MB8600:EE_
X-MS-Office365-Filtering-Correlation-Id: a36bbbc9-1653-4efc-2004-08db83808f75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: in7c9II52GnjacCw/iTRg3iJCo/SAp3qTFC8mOE/moIIRA9B1qKoRWybYOgHfMkvelBvmq/b4+/m2dEKqgTp2e14tE4o6dgCjrr84OlzVPXfGTgfZX7UVSDCMBeW1FCg2FjjDnhVJnCNDtTdl0Ll8oknd+2uMn7VbsnDW4lbQTmWtj1hcFQTkbS5k+ozBD20F8DtFQ6AZEm3nviuINZapk5fciVkMv/rjfxMpIAap866M7PXWDoeSXBUtlHG4HSmHUpOFxl7TCfcR+0hBal8Fp86/M0MLdbK3XlDdVVLkFOTAXwZhSCtQYkkX6ihIdiE+gC/Fzy1HmCYBWQk25+wnfeBBaxCMhbS1gK7vPjmRfAMc++AW8eozby4nT1zUGGbNEjHEcOyNAsUd5YcJBrO7yTqOPHQAgBEjBJhYofd2po5x6v2t3OA+stV74QK9yIK3IvBwotgK5+bawYoeKza11yp1+bW3TcFQsitNAQ4P/2YLc5JQYQR/zUJ6QRBO9UocD28/ytqjNMlth850q927OfqfIemJSCMGJTEh2qzAVskEy27G4wX24N05FYxhKHvxyO4874eUXiavAHL7r8VaceZ+abFMZSxivi87KWSVJz43rFQxnj4Lw+MyYlib8GfJw4zDUfzH5S4jt8hkPTIuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3241.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199021)(26005)(31686004)(41300700001)(83380400001)(4326008)(66476007)(66574015)(316002)(31696002)(8936002)(8676002)(5660300002)(36756003)(85202003)(85182001)(7416002)(478600001)(38100700002)(54906003)(66556008)(110136005)(6486002)(6512007)(45080400002)(6666004)(966005)(2616005)(6506007)(86362001)(2906002)(53546011)(186003)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHlNMk9hRHRVQU9TaDBmVVdyMzd5QXRNNGRoOUhHRmc4bGVqeHB5M1M3QkQv?=
 =?utf-8?B?MkY4WjRCSmI3M3lWZWNPbnkrL29qdVFsQkFVN2s0QWpMakxLNkdld1JGR0FO?=
 =?utf-8?B?NjQwYVpPMjZteHRTV1VUcVN3RHc3S1FwYyt1ZUlVS0NVNjRGR1RYNERreUor?=
 =?utf-8?B?RUZ2cDJFbzdWcmNZbStBZWU1eFBDdHV6dzUzaVlHVkZnY0U3Nngxak5NQjlE?=
 =?utf-8?B?ak5hRndZc1M2TFh6TGlETG5WSnRtQzZNVzAzMllHbVczTkN6RHliYWk5QWRJ?=
 =?utf-8?B?Vm1PUkFJZ28rYm1LWDNTWnpIdEdDc2ZnRXNqNnVUdEpMOGNCTmRqZmNQUDJs?=
 =?utf-8?B?U3NUYzZFQ0dKbzRLbnJDZ2xrNFVBK0ZDMERwWEtiMEd1SU9FeWg0QlE4WjZv?=
 =?utf-8?B?cTY0ekVWM0xzZ21KNUpwVHZzcVVmeWdUUEtDVWxYQlRTaHVtL2lYQ1UwL2Vx?=
 =?utf-8?B?eG80UDA0bldGQWdSM2sxRnB3THR0RUhPajd5eGlNcFc1bHlBWCtwMkRuOG1o?=
 =?utf-8?B?cUt1RUFrazdPMGJucmQ0MUVkVlJ2SDdyQ1NhdjFJRkZCNXh1SzhobkRNUGx2?=
 =?utf-8?B?bDdJRnE4UmhHSUZiTW10eSswWmZLRzlsQXZhY1pEVS94anM0RExHOVB6eWJ2?=
 =?utf-8?B?am9tdktOQUlhUE1sUjZoWkgrVjhJdmVNZFVkdnp6MTAxU2xLVUxRZEE4S0Z4?=
 =?utf-8?B?bHAvR2RzZi9tQUVKUEt0Z3JyRnRhLzFrR0hWT08zdGExVGpyaUgyZmN2ZS9M?=
 =?utf-8?B?ZWNjbG0wOG1GazZiZmh1VjUyVnY0dU5mUXlhME1xRTh0eTA0OUNPQ2F1RzNo?=
 =?utf-8?B?S2hPRUVFbVJBRFYrWmxjYnFUcDJoc2ZKTHJFRHdkUndrMEQwK0dvZW05cFNs?=
 =?utf-8?B?SXphbnZDa3BNOFExQmRKTWF3MDNNSm1wWEcwUnFTSFMyL1VVNHpkSEFyVjNV?=
 =?utf-8?B?cVA2K3luT2lGN2VDeXc0NXRJMEs5SFN5MjVJbmNYMVVlbjdxYmhVY3pWYUJR?=
 =?utf-8?B?bjdTeHhyODFGMDh1R2RuYW16VFo4NEpXcWsxV0dmbURaYUJaem5TVjJKNk1h?=
 =?utf-8?B?MkRLV2hJajAyQy9sK2RIZXJ4SVY3TGJFQUQvNGQxUWtIaytGWFRFeThrZFo1?=
 =?utf-8?B?dzNuTFVvRjdxSkY3c3FoOTJLSldLTjlCUFdQeDZRYng2UmF3L2N5ZVFMWG9z?=
 =?utf-8?B?Ymdxa2F4dXZiQ2pCNk1PUVk3TE1BT1hzbWcvejZGU3JvaDBIOURqM0N2YzNw?=
 =?utf-8?B?M3pSMEUwV0krN0RZaGsrVzV1T2FINlhqc0Q0Ym8rbDhXazJ1eXBUSlRGUUho?=
 =?utf-8?B?eXZ1RzBINHdrTWx1TC8ybWE3WHFQVjlpOGFIcFhHUnlhYnpYYU9GTU9XY0Zr?=
 =?utf-8?B?SnlGREhQcEJBZ05qZmxtYlVMQ3hpNE5EL0hUUTl2SUR6WnlQeDBaUWJxWWpJ?=
 =?utf-8?B?NlNIaWFXUWJKYUVMbVFsU3gxZ2tUNWhDcERKRGZ6YWFCUk1hdUhvRXA3TnhN?=
 =?utf-8?B?dGFudE1GcGMrMnBXRFhWWEdScGlvb2FMNXZwcGszK3YzOUdHdXM3ZVRZSjV6?=
 =?utf-8?B?aFRsYkVqUS9DZi80Y2o2ZG1nRWEwd2M0azF2MmRXajQ2MUt4U3pWRy8vbHJj?=
 =?utf-8?B?V3F1QU8rLy9GR3UwNnpNNTROY1Rrb3hkZ2tNVmgwRVZzb0o0RmFabEY5aDNK?=
 =?utf-8?B?ZGFOdFRzM29DY01yNUMzMFZCMWhaczRIelR3dXVtRkl2Q1pMZTkvbkt0eUJt?=
 =?utf-8?B?ejc1eEtRZXJEc25MUGNwYmpzeVY1NUZxemI3T3FMUWRlMVFZdGkzbUVCaGl6?=
 =?utf-8?B?NDlHTlBtTm5HU25mNlB3Z0ZMN0Fta2ZYZ3NESlV0NVlxM0Q3WmVhTHZ2ZURS?=
 =?utf-8?B?U1RBRUx2WmtSc1pQcmkvSGw1Y0ZiWEpGZW5ZVEd1Y2xpdnJxQnZtanhsS0pV?=
 =?utf-8?B?bHBIMlVpbEFLSXk5aERncm9uREdzdDFCYS9HZXkySGVPV2RiNnNCd1o2a09N?=
 =?utf-8?B?cHNncWFxSTBlaU4rUDFhRDJ0SThYRGNPai9kZklpQjNGMW50dXV6azhieUZh?=
 =?utf-8?B?ejJwQWRyM1NZMCtDaE15N1VZZ2hRNWtuK3dkSEdmQ29VdnNsanJ1eTBTZUxD?=
 =?utf-8?B?R2dIMkh4Y2wrbFh1SVRZYUFQQnhPaGlTSnBIMDZmUmNJVzI1VDlpbFZraHYz?=
 =?utf-8?B?emc9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a36bbbc9-1653-4efc-2004-08db83808f75
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3241.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 09:07:19.0153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: McnwSwYl91Secn8hAdXhn7F4twGFCti4t/P9cAkdZ6DsPIUJB66wXg0QDKV1YXbCiSALfh5TBQDpoCEscVtxu5HINUnbc+B1RBrRroVW90c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR06MB8600
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ahmad,

On 13.7.2023 11.47, Ahmad Fatoum wrote:
> Hello Vesa,
>
> On 13.07.23 10:29, Vesa Jääskeläinen wrote:
>> Hi Krzysztof,
>>
>> On 12.7.2023 23.36, Krzysztof Kozlowski wrote:
>>> On 11/07/2023 17:08, Vesa Jääskeläinen wrote:
>>>> With fsl,fec-tx-clock-output one can control if TX clock is routed outside
>>>> of the chip.
>>>>
>>>> With fsl,fec-tx-clk-as-ref-clock one can select if external TX clock is as
>>>> reference clock.
>>>>
>>>> Signed-off-by: Vesa Jääskeläinen <vesa.jaaskelainen@vaisala.com>
>>>> ---
>>>>    .../devicetree/bindings/net/fsl,fec.yaml          | 15 +++++++++++++++
>>>>    1 file changed, 15 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/net/fsl,fec.yaml b/Documentation/devicetree/bindings/net/fsl,fec.yaml
>>>> index b494e009326e..c09105878bc6 100644
>>>> --- a/Documentation/devicetree/bindings/net/fsl,fec.yaml
>>>> +++ b/Documentation/devicetree/bindings/net/fsl,fec.yaml
>>>> @@ -166,6 +166,21 @@ properties:
>>>>        description:
>>>>          If present, indicates that the hardware supports waking up via magic packet.
>>>>    +  fsl,fec-tx-clock-output:
>>>> +    $ref: /schemas/types.yaml#/definitions/flag
>>>> +    description:
>>>> +      If present, ENETx_TX_CLK output driver is enabled.
>>>> +      If not present, ENETx_TX_CLK output driver is disabled.
>>> Here...
>>>
>>>> +
>>>> +  fsl,fec-tx-clk-as-ref-clock:
>>>> +    $ref: /schemas/types.yaml#/definitions/flag
>>>> +    description:
>>>> +      If present, gets ENETx TX reference clk from the ENETx_TX_CLK pin. In
>>>> +      this use case, an external OSC provides the clock for both the external
>>>> +      PHY and the internal controller.
>>>> +      If not present, ENETx TX reference clock is driven by ref_enetpllx. This
>>>> +      clock is also output to pins via the IOMUX.ENET_REF_CLKx function.
>>> and here:
>>> In general, Common Clock Framework and its bindings should be used for
>>> handling clock providers and consumers. Why it cannot be used for these
>>> two cases?
>> Did you have something specific in mind on how it could be modeled?
>>
>> I tried to look at:
>> Documentation/devicetree/bindings/clock/
>>
>> But didn't spot anything for this.
> This has been implemented for i.MX6Q/DL using CCF. Please follow suit
> for SoloX. See series at:
> https://lore.kernel.org/all/20230131084642.709385-1-o.rempel@pengutronix.de/
>
> Thanks,
> Ahmad

Thanks for the reference. This looks promising.

Let me try it out.

Thanks,
Vesa Jääskeläinen

