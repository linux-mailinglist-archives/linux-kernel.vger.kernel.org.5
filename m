Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C607CF171
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 09:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbjJSHi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 03:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235109AbjJSHit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 03:38:49 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2070.outbound.protection.outlook.com [40.107.15.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E6012D;
        Thu, 19 Oct 2023 00:38:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTMNqvMCEauLgdBMXScCsQD90anXBs/nFETCMH6GBtKJeZvWd3jIZkzAUmPH0SrkAv7CQFAIO1t+t/WaYaYOJjlGsTcoPCaxdbndfeevhT5FSqZU70JyMdaWzgVsjcnVT290cdsJqTtNGNdLELISAcxRKkuby7laZ+5hqwIGUVXf8NL6cr3Aiv/DhcmdxGuAxN9Qq+kMELmgT3gDYwBy/tVpB4ZEskMrMYn9RzZr4WwATGOBzDNwmH9NSBIU+ChYlfRtr7vw1pXPXyHXjsn0hdd2KwLzMzNxkF639qOfJ7NQwBxCZLJmLpEwxJyhRRVOU7n8IRect3BvYLE5UWWk7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3BCI3lym728kYCpT5flP3/OJRYBcYoaUjBTv32zM34=;
 b=Ci27fctoX7HiJLUCN93Sv3LW9cBKJ6Au9ou2u5TOAY0jrKMFTK9y4Uf0yT+i7yaMJiV/FYQ34cSA/YOilj8wiZ8mfKXWvmO9oDe98WS+h4rlSTuWrmdz+6iIAcCNW4mJAGC9+1bTQ80sy/sE5nlkJFX2aYNS2IQbeCpFnxhnQWP1TiGUcfH148praPtDXpRRBkOnJG8+K7lmJi6fPPXxBWFBPWw4ieF8jOALRPXdXJTNo08jsEjvI/2XJ2HkuGsihDhRimjLpO9UbDgv3WZITAqnVIL39H3MfJBEweNaTaKWDZxGYipRfu/nG37lrSzAAAETPXnGMbPzafkzPdpI/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3BCI3lym728kYCpT5flP3/OJRYBcYoaUjBTv32zM34=;
 b=iDPwcJNJi2VfOaBKH+9Bn/0Iyn8nPFzAR7coeds1jEnZPCvdS/6ZjMPkzlkoQ37hVCIv3oXd2PJchaLmb87PZvM/BtZZrOu9DKDJKtABN/R98WTDgF8ltwqinDb0OrNYZAH3idt8W4r/UNsmkgbcVZqgTpMj/vbytsOUngHaoJ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM8PR04MB7795.eurprd04.prod.outlook.com (2603:10a6:20b:24f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.7; Thu, 19 Oct
 2023 07:38:43 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::6e53:39fc:f010:30d5]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::6e53:39fc:f010:30d5%4]) with mapi id 15.20.6907.021; Thu, 19 Oct 2023
 07:38:43 +0000
Message-ID: <41efe9cd-7574-4827-85c3-845cb3dd3d65@oss.nxp.com>
Date:   Thu, 19 Oct 2023 15:41:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] media: imx-jpeg: Add vendor prefix in slot
 property
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        mirela.rabulea@oss.nxp.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        ming.qian@nxp.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1697597713.git.ming.qian@nxp.com>
 <be1f8907582ea344f8826f7888b277534859e0c4.1697597713.git.ming.qian@nxp.com>
 <9b853b5f-b3e6-4aea-b99a-51a490a29f9d@linaro.org>
From:   ming qian <ming.qian@oss.nxp.com>
In-Reply-To: <9b853b5f-b3e6-4aea-b99a-51a490a29f9d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::16)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AM8PR04MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: 32296594-c707-47bd-6253-08dbd0766baa
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R1G8DtsVet/dVZ+Q8cpWd6BG96ch4wEpE/EyLVWuzBVx70RkRiSDu/VCMgzZjuszNkAHVCxcRhwcyY3oJDpfk0qOAlAUIDlP6sTWjmaeL+R+G5OfBglfER9bnwyMZC1Jnot6ebG5WRvTePH52bvAceAe20t3rEBDHVYxfHwjRaiRl1b2xtjiZt1aNRxR+heKTQdnl32qHLNmP2ajG6aCemcDaAj4cGWreKHvA/9bWyTANItsFhKtsqyqYTxFHooBNF1aBULJ0TVUncN9qndHKPuozgufcTW5WSKd7MKN69i7W4lGzsHZv5LXaQE2dsuJdYSgbtKkc4pmolbheW+30b4UlBiKJcPe+W88cX17mPtHIx63NKUNmLNmc52T+r1jrakjRJMYWbLXWdkVpQBmQlhHUqbb51yr9XHl/GiSXSweErfrXjFVylIycU7SQy67m/5YoZEpvnxPZr/F0xl/0ANg6E5VqwooTkSQ8z2n/PsnPKSjpwuSx1kr7/CHa7VmMV9L75yoZ6knVojEBNY4Or+Tb312K19Qe2eVWrCu2HVf2Fxg4OBF6iHUbcJOVxUhX2gTsnLK+py87oJi6DI0wNpiSrtM7NuBnfkHnwmZG+9uCjKoC/hCT2Sn7jy2P00C1laIp935ztxQaJRDkrX8aQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(396003)(136003)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(31686004)(66946007)(66556008)(86362001)(38100700002)(31696002)(26005)(2616005)(83380400001)(6666004)(6506007)(6512007)(6486002)(2906002)(478600001)(66476007)(316002)(4326008)(41300700001)(7416002)(5660300002)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clRQQVl6WVVnU2loZjRjeHZ0Yml5RUo4Ym83eW9CNStrTS8zNVgrOHlUU1lV?=
 =?utf-8?B?NUlhdnRKNUNnVk1hR3VaTTl4OUk1Si91WU03VFh6UDVQcllTaXBzdUliTk9F?=
 =?utf-8?B?Q2NHZEtuU282cG5uQTdOZnJvbjh2aUhlczl0Qk5nZFRoR0dpQUMyeXlFUmcy?=
 =?utf-8?B?b1RJeXRsZFFSVHJhRFRBOUd6YXV5MkhuZGNWUnl3QlFGcXA1b0xjMkU0d0Y3?=
 =?utf-8?B?ckx2OGUrMDBDOFBVWDVPWElvWDdKbmNYNmJGcmVzVGV6ZnBLRm9DRWpIM24r?=
 =?utf-8?B?NlM3OHNIYjZ1SkRCR2xwSk5uR3BEZXYybmhaNW1KVDloT1lOWmpCTjZYYTBV?=
 =?utf-8?B?UWpmRi9wSlA2bmdoS0dGNzZwRmRFbkJoeWh4RnRxb0Y4LzY0QzNCUDk2TS91?=
 =?utf-8?B?RWorbnA1d1lNbzlBMGh4bVhCUXlGRHIzMXBNc1h6QW8zc2c1ODdabDFwZlZr?=
 =?utf-8?B?ZHdBRVl5azRRTldWOE1XbEpvWmlQZ00wYjJLYWtLZDZPbVQ2K2ljdmpkS1RM?=
 =?utf-8?B?QXFHQ2w0aGQ1S0x0U2hzeXJSMGp3a1BJNENzRU9uVC9WVXpFZkIxeUxpcWhI?=
 =?utf-8?B?b010QjlSUTVsUitidFZPaU5YVEdLU2VmRzZnV3BkaEdHZk5WYStDNE9ISmV3?=
 =?utf-8?B?RW90NGxVSFQ0OFVQRTFiZzVwa0Q4ZU8zWUxlY0lEMCtjWGpLaTRmVS9FT0lG?=
 =?utf-8?B?NUpmSk43cldZOGJBVmQwd1NlTmRuV1FxYWU0M21FRDZoejVBS1RBUFBDZWl1?=
 =?utf-8?B?WlF5ejVsbWtHbnplaVdRMzhmdW9KeXpOSG9Lb0JKWnpETVU2Q3UrS2grc1Nt?=
 =?utf-8?B?NC8vNUg5bkF0N3BBNVhzUzdLdzRwMEcrRHFUTUdpOEZiUUpqUEhyNURSdk9j?=
 =?utf-8?B?U2x5NUtkZ1pSUFFTeVJ3dEFBQUxXK2VaQUlCbjRQaExNUlN0Nk1oWk1FUmVy?=
 =?utf-8?B?MzJNN0c0am03cFV5bGFnbVExMlNDOVF2RGh3TExJWXY4ODh2aU5sdVRhbzZm?=
 =?utf-8?B?SFFYYTJUeUxlbnJ2UmsrdXNVbXIrUU1Ccm1jdW90dTREZnZyL1FGY2JaVUNp?=
 =?utf-8?B?RzVYak1GUzFpKzR1Qk9QRnhnbVRwOXR1cVB1d25xNFN6dVdSdnNzZ2tkSlIy?=
 =?utf-8?B?c3FCbm5lcmJVcitzS1JZRVovTTdDaFA4UzdhLzEyblErVXdNYi9qQ042MEVt?=
 =?utf-8?B?eXRieUVTUDRuVlZrbDlOUmorUnpuUzFSbEozWjhROGI0ZU9reXlVSDZyRG5Q?=
 =?utf-8?B?ZUtlRmx0bWlQK0NPV0lSM0dRTUFUaGdPODNpV0JYWUt5NTRhVXVSd1Y1dFQ5?=
 =?utf-8?B?ODd0eDBsek5kd3hHRHlMTlVYNldMNkFuajJjQmsvcHF5NHV0QitSajhHNVVy?=
 =?utf-8?B?WGcrZ2JoNHFKTFdWZ2d6T2hTd0xoNzVCaFQxL00vRUM3Uy95VGwrQVRyeDZn?=
 =?utf-8?B?YS9aU1k1aUM2SGxleDlqbkZkTmYrSmVIcHZaY3JzK2FRR01ZSDhEcHB5aTg4?=
 =?utf-8?B?Mzk4cm9aQUJ2TzdBcVZrczV0cElxb3h3MWhLS1pkQm5Ob25YYktqbVoyRGpi?=
 =?utf-8?B?U1lkelBQODFMMDFBMW9GREJWRFlCVmcvUkU3dTg4VjZ1cllCeXJXVGk0ZUFZ?=
 =?utf-8?B?Yis1eGlQTnZ6K1FKTUJEYzlDVW9Rejd5SmRlUEh3MEsrVWlWaytUZkVqa29N?=
 =?utf-8?B?SkdGK2VONmJGTlYwZTRlWURsLzlCVy9VZWhnb1Y4c054MGxxTC9TdG50TEpQ?=
 =?utf-8?B?MnZYVDA1cDNTNnRxQm02OHVxZ0NScEJkdUUyaW1ESjhkUUhjV2w3dnhIeFpk?=
 =?utf-8?B?MEk0bVMxMEYrbkw3R3p6WEk2T2RWVEpLTThxM1YwVktwQ1VTMTU3RTUyejZa?=
 =?utf-8?B?YjBIQUUyUDJ4bVBQdXFqbkRnMGloZ0dhR05Ed1M3aHZ0Y3ZRWTJSbkczMDFH?=
 =?utf-8?B?ZFBnSi9CSDg3V3EyOGI3WTJKWjJGdElKVUI4MWV3WTEvMElUQzdtMS9FVzlM?=
 =?utf-8?B?a0pRUmlSRGJkMHJiWFlmRW9iNWNpdzVYWWVyeG1hRGM0ODZobjdoUDlxYlEr?=
 =?utf-8?B?OUQ1RG94ZzNtY0VHMDNMVTluS0pUdVlLRTQ3YVdIbUlGUEcxSHFXMEJDeER3?=
 =?utf-8?Q?kdYJGn6buRBzZPW+y6OrzKShu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32296594-c707-47bd-6253-08dbd0766baa
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 07:38:43.6729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CvbDfiSIkRVHjfWg0qZ5bVfp+9eZLQJivFvmGGjUi0SXZncRprRU2BbDREDPQMOUxVqW5WJzMlRapr0gbMs1QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7795
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

>> From: Ming Qian <ming.qian@nxp.com>
>>
>> The slot property isn't generic property, add vendor prefix. Change the
>> property name to nxp,slot.
>>
>> Fixes: 53ebeea50599 ("media: imx-jpeg: Support to assign slot for encoder/decoder")
>> Signed-off-by: Ming Qian <ming.qian@nxp.com>
>> ---
>> v5
>> - add vender prefix, change property slot to nxp,slot
>>
>> v4
>> - nothing changed here, just modify the bindings and dts
>>
>> v3
>> - nothing changed here, just modify the bindings and dts
>>
>> v2
>> - nothing changed here, just modify the bindings and dts
>>
>>   drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
>> index 64112b63298c..f8b99a292ad1 100644
>> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
>> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
>> @@ -2762,7 +2762,7 @@ static int mxc_jpeg_probe(struct platform_device *pdev)
>>   	if (IS_ERR(jpeg->base_reg))
>>   		return PTR_ERR(jpeg->base_reg);
>>   
>> -	ret = of_property_read_u32_index(pdev->dev.of_node, "slot", 0, &jpeg->slot_data.slot);
> 
> How did it appear in the code and in the DTS without bindings...
> 
> Best regards,
> Krzysztof
> 

In the beginning, I only made the patch set of code and dts, the code
patch can work without dts patch due to the default value. The code
patch is merged to media_tree, but mark the dts patch as ´Not
Applicable´. After that, I sent the dts patch again, but maintainer
reminds me that I need to change the binding too. So I made this patch
set. And I guess the dts patch was merged by mistake.

best regards,
Ming
