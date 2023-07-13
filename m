Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC82751BBB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjGMIgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234558AbjGMIgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:36:15 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2089.outbound.protection.outlook.com [40.107.7.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5938C2D5F;
        Thu, 13 Jul 2023 01:29:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eEBJ+COmYrgzhBY8oyYbo0GRgoy57weUAsFJp30SLsXZg4w8OdyftCm5tM10aiwVkWSFseUf9JC81IZRa0ENLhuOdmQ0HhM42El5aEpsgFRAOZ0gXOY2PHwZAI2xlvw9zZCxgoaWYkdluNsfZG+FG3Po+Mt7Hj1Ksilehbvm5nhdxy/m85dpFnmgT0/S2Xnfjyd41Zx912wA2qbThMc+4m0ap0JEzIfC4wp6NPj7YObCJepXoNsd7ERi+wWXSCWiqBu9tEHlglGlRfEYCh5ar8oCinIVwxVcNpIeuRg7QBiP+jArbIO9oysD3FwnqGJGzz0g6NYitdLVgT/+V1KMuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNzcHvxcQKFYiHbWdI/1ORPATWiaXKyuRDt9ZI3rnA8=;
 b=UbxzjlsnGExJ3haqsZVHyhcOvKBZ4HE/geOcL8QE6GO3mEOjApRlYqO8fC0AjmtcDHrha4eAakeuqI1BEACaRW3PFYxtcBtqGaWAK6vVJhyi4lv6gDJzSFb5V9rsbvgAw2vMXFfrmU5LHxHC0/2MPDVUEfnrAKqcKgECN+xPPKi1OUxNEOLeaL9ITWnGfeZI/YX4iD8qxuOJYHTea3gwrqVFZJFlB4UxHJfn55m7i4dboziGpbLYCuY7l2lVoREh/i84WY7n5ZA8nPFJLDKinUl2SbmIIZSEbzlomR54+cx/io7gYX/uZFyPoTx2lAfmA3mNV83CYmPrDK1IKk8TtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNzcHvxcQKFYiHbWdI/1ORPATWiaXKyuRDt9ZI3rnA8=;
 b=qn/5N4hAmvKlnhABAuvUvQG2kNKQo/1NlYblmpBwDj2XNQpjjJikPORHFttUmmquSJLpfxvOltOIwwyzW7JqvbM1nS3rwdHXscYJPV8yeAtxROwhoq4pZ1RuAIBBctfXGAL6UEI4q0D9HXGV2zWJZZ6uX+TXjGZG+qGCeSd5L2OvTMVj8VjIUQ4Mib18n0NlxVR7MrmWhuzZzrlbAxVHeS2ZS9TIqefFbhAAwenFYibVq2MF1Uu9W2KTl5Pi0lQXP+40d+bEh8/ozZxBNYb0xJuYlUY/k+lAOFNnC4dbaS3hemkZlA5sHgxb4GEeme4zHao0EpiHkNKkT/rwfz53IQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from HE1PR0602MB3241.eurprd06.prod.outlook.com (2603:10a6:7:17::28)
 by DBAPR06MB6598.eurprd06.prod.outlook.com (2603:10a6:10:18a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 08:29:27 +0000
Received: from HE1PR0602MB3241.eurprd06.prod.outlook.com
 ([fe80::8413:b7d5:15ac:63a3]) by HE1PR0602MB3241.eurprd06.prod.outlook.com
 ([fe80::8413:b7d5:15ac:63a3%3]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 08:29:26 +0000
Message-ID: <49bf4392-299f-cb4b-ef4b-f920faa65866@vaisala.com>
Date:   Thu, 13 Jul 2023 11:29:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] dt-bindings: net: fsl,fec: Add TX clock controls
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230711150808.18714-1-vesa.jaaskelainen@vaisala.com>
 <20230711150808.18714-2-vesa.jaaskelainen@vaisala.com>
 <006f9599-6aa4-52ac-068a-831893ec6bf8@linaro.org>
From:   =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= 
        <vesa.jaaskelainen@vaisala.com>
In-Reply-To: <006f9599-6aa4-52ac-068a-831893ec6bf8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVYP280CA0046.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:f9::16) To HE1PR0602MB3241.eurprd06.prod.outlook.com
 (2603:10a6:7:17::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0602MB3241:EE_|DBAPR06MB6598:EE_
X-MS-Office365-Filtering-Correlation-Id: 94106579-9251-4ae7-9bd0-08db837b44f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q+6hhINA69tcmatCyKVNup1WYIrjV8fZDCnZgCXFvSyhY65LQgptp7gZiLoctaaVhUQkZPIiRFDB8Dzdo1MPbkqAq6exrqgbjosem1uPgwLFmkmGcNoSZD64/S3GWYFJudHCv0awgt9lAE/NdFVn3ntku39YxT8Mq6ibPC7BDg3ztKoFOHbH35A2N/ZF5hBaVoncpMeQKguEO+3AhnTXKUJb4TFNvWlwtOZIvzlFmdyJcPOUt1dZg5DWKUqA0DZGyhfTdz04LRrr5VTEOXvYWEruo1Jj9XTzq7YD9Nd6BOKOFiaPGATbzSDS7RI0mtwX4Kjq1+EFQTrLC0qdM5n6WivAigOwcWHiv4cGPWLuUKgMPglGxfXUQff03OJQtE/awaKleoI8tDjZ4TxzWvY286eZGgZKBy5Og1jk5RMcZjkUoZJqp4ka0m90PKIC6uRRBbUx8ObqPAl5V4LvfDdATNGs5Ef3mIwP4kRNeIaMhsqrdiBwEbmks1CPdRVLu49lmgy7Mk/CFSN2KaFvfIDAGvUjFGHApRyQe1I2gQeI/DDKgwEtyd+C0W/isOMRUYROwMLr8Bu3M2fU84IgyvPiXzk/tBdg2fyGlrd2KbJap98STjtkh9ednZ/iKx8aYtpkVjvElNSw1wK4QwGSmZGR3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3241.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39850400004)(376002)(396003)(346002)(451199021)(26005)(6486002)(53546011)(6506007)(6512007)(36756003)(85182001)(66574015)(2616005)(83380400001)(85202003)(31696002)(86362001)(38100700002)(186003)(5660300002)(316002)(2906002)(31686004)(478600001)(4326008)(6916009)(54906003)(66946007)(7416002)(66476007)(41300700001)(8676002)(66556008)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dG9JTmM0ZFJyanc4OWNucUdXNXM5dXpFV01kNW1ITWp1a3JuSnl1K09YY24x?=
 =?utf-8?B?cTNQVHlieFo2Qlp1WVpobWs1akFKY2labkUyOXlBSGUvajRFaWdmSldBQmEz?=
 =?utf-8?B?NFdLQ3JkaENucEdxd1RZTHRrRUM2ZnNjbW5oMlZTQVlVQWllQ1FNMzhuczlz?=
 =?utf-8?B?U1h3RnZ0Q0hFYUF5Znc2QWRjc3Q0am81OTVhNnAwY3ZoTEk1dWNTazN2MkpO?=
 =?utf-8?B?RkZjdWNlcjFGTVNiSGR3WHVzTisxNmxpVzFtSEdXSUJjUXNsWFdBUDQrTXAx?=
 =?utf-8?B?b2RaOGtoblFEV3VtbTI0RHROYTFrajdtL1V3T0FBa0dTdnQxTXFaOVFJOFhG?=
 =?utf-8?B?aTBYaWF3VHExNWZreTdac3dVTzFWNVFVWXVLYUxBaGIzVE1tRmNUSTFoc2wr?=
 =?utf-8?B?WEluZ1pobWlPaVQyZ2oxLzNzNXJQQ2hLU0xzRDBmNVBVek5UZUx4R1Urek1R?=
 =?utf-8?B?ZFQwWjB2STBvbTk1QUpJZW5mTVVNMEZjM2N1aENtc0Y1NldhMndZSElMTFgx?=
 =?utf-8?B?UjhzelVub1VIRUl4NjkxKzBFdmd6alN3eWFHVXREbzFtWmxaTDRzM0hFYW1S?=
 =?utf-8?B?Z3FEZlp5bzQxV05MZDU2VkMydHRMcVhCUXFoQk51OThZaW9XQ2x0ZFZBMEFF?=
 =?utf-8?B?L2kyOUNQVWEwdDF3amw4WGttL0JpQ0hRRmt5SnNxbnVNTkRpN0FGWFlNVkFO?=
 =?utf-8?B?Y0JkRkhlMGdHUFJtWGtzU29pcms1R0k4a1dTZmRwOVR1TzBLWjNveVcyb1JH?=
 =?utf-8?B?RlVUWmczVXJwUGg2VWQvZ1dJTG1VUElQVjJ2bXNTR0lYbHhudWVjWXVpRFV3?=
 =?utf-8?B?NVlKb1NrL1FlNHBpM3JhdVBBNFEzNnpMdjRBZUV0ajlUeUdjQ0IreEF1UGRH?=
 =?utf-8?B?eXZUdllPNXM5YWNmWXFYMzJnUSt3MkIrdDZrOGFVeDl6ZjhsckNsNjNaL2FC?=
 =?utf-8?B?UktMUlRQbFZ1S3B2aVB4YUYweTdkSUh1WTZBUXg5dDVzWFQ2Z1owenZiU3c3?=
 =?utf-8?B?U1ZXSHF1cHNubFhnNVpQd3VWazE1VGFoMTdKNzlqK1ZkQ1JrL0RrMmY1QWQ0?=
 =?utf-8?B?Ujg5NGc4T2F0UnVUYWo4RmRpTHFZL2hmQkJjTXpiNjE2QVMwQ3FJQStDYXBl?=
 =?utf-8?B?T0lKbldDdVF6Zy8xcUZldklTUzI1UWJLNm5pNGFLNUxYVnVnRXNCR3hTdzZx?=
 =?utf-8?B?aWw5TzRjcE1yWVlkakc0bW9MMEhSWTdxc091NnlLR2NMUHFHRDUvVDJhWk1o?=
 =?utf-8?B?V0ZZNGlpT01lKzQxVWMzM1JJNzR1NGxuWlZMWnV6aElpQUFWYTNNQVVkMDZk?=
 =?utf-8?B?NTFzbnJSZnI2TGNjL0I4S1phOGM3TGFoRURUUGdWcDErcStrSm9vTytOcTFC?=
 =?utf-8?B?WDZscklFWUowOS9RcnhBQTNMQ3duQy9naFBUMU1CTDdVa1RSendVRDE3aDdI?=
 =?utf-8?B?OXlGOWszcExhcndiTmd0eHRkRi9wV1FobnFBNCthNlhkSXkva3NXbW5zZ1ov?=
 =?utf-8?B?Y2RKZFhNUlphY283MXluOW9NM3FEczJxVXpIZ1ozMng0ZUU1RWd6UDVxR0Jx?=
 =?utf-8?B?OHRDNEJPbGtQTHhxTWJlZmlhY1Bqby93RkJqNFM3Mi9aN2NBUDk3M083TlBv?=
 =?utf-8?B?TGExaG03ejlGRzFPQ3gxcXkxYmUvUWQ0WnVLemVXOWpjT2tSd04rVVY3cHRu?=
 =?utf-8?B?TEdyOGVlcFpqTzhHc3hMNUp0Y2x4RFE5VHIxNFFtRUpTQjB5dVFsTTZHeXo1?=
 =?utf-8?B?YTcwVlo2czl6Z0RiUGRKNUFKd1dpaGZuNk1rWm81TGpkZlhSdkFYR1Zjdkhj?=
 =?utf-8?B?K2JXeXgyRG5WWCt5UC8rYmxjR1ZtSDJ1eENmVGpMYWcrTElXZlI3S0lBMFBJ?=
 =?utf-8?B?ajMzd3pYSlZHK2VEdHlJR3hGR2JSVkRxKzF5bi9BM1IrdDI0WTlZM012blZ1?=
 =?utf-8?B?WTBaL0Ezc0NwcWtEZmZsZjErbmVUOGwvMDFmV2pEQVc2amFYSTlHMDBlNHd2?=
 =?utf-8?B?NmxTd1daNTZST0dSTmJyWnR5d3pONCtqTWhkSm10ajJmMEpIOWF4Z1lBYVhq?=
 =?utf-8?B?N0ZqZGtmcmVJcXpKQmtVMXJzUWY0d1JubzB3SG1PcDVUMjhMamZWbG5tb0sz?=
 =?utf-8?B?cis0S0FublkxVE1QSXpmQlRTeUlLTWFhVk0xNXFZVEtUbmxjalZFSVZJeDEw?=
 =?utf-8?B?OWc9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94106579-9251-4ae7-9bd0-08db837b44f7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3241.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:29:26.6743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4jikQMC/AkVYUQ9EsZ0Dd7G15groYhOYjwt2hHHnCSINnnm0NnX9F9/Wz7chLiwJJoDnM/B+dXcLPhoQbFEwo+KlarEORUiI+IwdBDEVwh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR06MB6598
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 12.7.2023 23.36, Krzysztof Kozlowski wrote:
> On 11/07/2023 17:08, Vesa Jääskeläinen wrote:
>> With fsl,fec-tx-clock-output one can control if TX clock is routed outside
>> of the chip.
>>
>> With fsl,fec-tx-clk-as-ref-clock one can select if external TX clock is as
>> reference clock.
>>
>> Signed-off-by: Vesa Jääskeläinen <vesa.jaaskelainen@vaisala.com>
>> ---
>>   .../devicetree/bindings/net/fsl,fec.yaml          | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/fsl,fec.yaml b/Documentation/devicetree/bindings/net/fsl,fec.yaml
>> index b494e009326e..c09105878bc6 100644
>> --- a/Documentation/devicetree/bindings/net/fsl,fec.yaml
>> +++ b/Documentation/devicetree/bindings/net/fsl,fec.yaml
>> @@ -166,6 +166,21 @@ properties:
>>       description:
>>         If present, indicates that the hardware supports waking up via magic packet.
>>   
>> +  fsl,fec-tx-clock-output:
>> +    $ref: /schemas/types.yaml#/definitions/flag
>> +    description:
>> +      If present, ENETx_TX_CLK output driver is enabled.
>> +      If not present, ENETx_TX_CLK output driver is disabled.
> Here...
>
>> +
>> +  fsl,fec-tx-clk-as-ref-clock:
>> +    $ref: /schemas/types.yaml#/definitions/flag
>> +    description:
>> +      If present, gets ENETx TX reference clk from the ENETx_TX_CLK pin. In
>> +      this use case, an external OSC provides the clock for both the external
>> +      PHY and the internal controller.
>> +      If not present, ENETx TX reference clock is driven by ref_enetpllx. This
>> +      clock is also output to pins via the IOMUX.ENET_REF_CLKx function.
> and here:
> In general, Common Clock Framework and its bindings should be used for
> handling clock providers and consumers. Why it cannot be used for these
> two cases?

Did you have something specific in mind on how it could be modeled?

I tried to look at:
Documentation/devicetree/bindings/clock/

But didn't spot anything for this.

In net bindings:
Documentation/devicetree/bindings/net

We have some similarities:

- adi,phy-output-clock
- adi,phy-output-reference-clock
- nxp,rmii-refclk-in
- clock_in_out
- ti,clk-output-sel
- ti,sgmii-ref-clock-output-enable

In here clock output generator would be the i.MX not the PHY as what was 
in ADI's.

xMII variants are close but very specific for specific MII interface type.

clock_in_out seems a bit out of place.

Thanks,
Vesa Jääskeläinen

