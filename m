Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E318578F983
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 10:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240430AbjIAIHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 04:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbjIAIHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 04:07:09 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on20606.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1b::606])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1105EE56;
        Fri,  1 Sep 2023 01:07:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEaKLusM1IoUjmVHEEkGg0nd5llCoEjJVq80R8h5SQgDXb8AQ+K5PHRDjU0oyudPjo/lXZAGEn7A/ooJaQAWbr/hknL9ipv54I1oJ1hIvTazH/raFF1AzJiGJ8ey7f1Zex6KC1l1xv1iFoeuZWD77Vq7F0v9U39LFjcW1C0T4aRIg5LZ0Cq7GPkNKfCgbsh6h4paWT5XX3C2wnjXMBvIBfjx1WQbW4w3T1gkQlNScb6bzg73cAlnRxlw86FJnR+1HNSpiBQkSyUngwIMIDZt7I+O00Zc4dwdwy7gF9TsdScnFBL36WUIG3I0dvNDQcmxPW7WV4w5RFqIIpyS+fLIvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oe+vtAUFYpMrbi0UqZ4qLF/+JgTaY0QlXWQiDo1UQ+I=;
 b=iB4YJivp6umXRj0rmwaWjd7IMHNSE+ZGTIVLIX1xDfkhu7gdhPWNxAqKI9RgX4DvJqic9RjYu8FJiwtK3igRsclvseJPVsqhc0w4nBIFG4e2tf/+tnqgJlDU/eYALWki6sAMPS0555e9i2OQTRCS79Y+3sWILnL1adHJOXqjAB8tKjAeLfzir6hnwKblpUA6wUIAEtAweM0zoUVxI5sW/fsWoPliXrD0xmIuCTCcqwM7uKHwL2ZKbNw0ZfY93KrHu5XPH0YDfbGXji5P94oDnQ0ZrXlOxDw0qbRyY13uDXcLxqNbX0968AKruVgC1xPuro1Tv4XmAdnyR3ivsIHHAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oe+vtAUFYpMrbi0UqZ4qLF/+JgTaY0QlXWQiDo1UQ+I=;
 b=FlFMZbj/+/qJSRs5y+l/j6ai8SU7+sZfGw16T+otXDADUqsuetsbqrC0iAfCs44WTEJN/sObi1euuyfeUg5hsZSFzf7FpiHy8LoRcwL0wvS3Bfi4LUMNUH+sdaWp59P7IPka5NiVK1jHTBmJYo4RZt2MvTo6V799SmK31+kchWXCjqJBOL390StUKv3DKQzKrB0DkIJN6/3WNMp70KJLYhxoFZGezVS4nAs5vZYwSCkPu7aIqAwF/b/VwN+hq6v9JkepZpmve79zC4oBN37kt6FDU/SCrO6vEH53udFPv3LaOpAyrV6y+Ad/eGUYdA886x8/jMIQcRT+mYhRxCQHGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by DUZPR04MB9793.eurprd04.prod.outlook.com (2603:10a6:10:4b0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Fri, 1 Sep
 2023 08:07:01 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::5c00:6152:6ce:72b6]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::5c00:6152:6ce:72b6%6]) with mapi id 15.20.6745.026; Fri, 1 Sep 2023
 08:07:01 +0000
Message-ID: <051ceb69-2f6b-4944-4fbe-0ced66f0b669@theobroma-systems.com>
Date:   Fri, 1 Sep 2023 10:06:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   quentin.schulz@theobroma-systems.com
To:     Jakob Unterwurzacher <jakobunt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        jakob.unterwurzacher@theobroma-systems.com,
        Ermin Sunj <ermin.sunj@theobroma-systems.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm64: dts: rockchip: use codec as clock master on
 px30-ringneck-haikou
References: <20230823131651.586934-1-jakob.unterwurzacher@theobroma-systems.com>
In-Reply-To: <20230823131651.586934-1-jakob.unterwurzacher@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0220.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::15) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|DUZPR04MB9793:EE_
X-MS-Office365-Filtering-Correlation-Id: f047807a-8a7f-43f7-7b0e-08dbaac26bd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F/NK6fdriluauRq3QeiVK2SJy8BRz0Ob4e+IM7q4ARQGDKhxQBiNOgJZxGZ9b4TauHC+dB8sK+biy+fc+Psa/qxLBViDQqLUEV0loRqUA92Xj60qh4z/2SLovjfg78F1XcEt4T9vp3QKjW468PZ5UobkrSgdzfyFnywZ9A5S3mNDFO1Z2qMBDvZCV0yMewaxUobUoa+mWAM2S5NblG1BFnd/CSq2Hro6dQaund8/eipM1uCdYNbpKqrq33xcSzLKbF8/Jx6ghMrTWUveEIlWdrHHOY+pXmzOexq4+Hf5CqTe/c6cTAAi/8Ol3/HfP0La1DYxo78NwpMQtLVTjFg4ngDOGTKUjMlml7bftQN8NHe5lWSLDVxdfNbF+V9kPP/lGM5b09aHYkMqJeu02e8XYdfDliuEDIpZPSBKx1vb2fuML90Bx/F9EJUX+T4PU3MEz3EBZVQr996bTxg5fzGyPoDj2llSYc1BfxPqcMdcBcYG5ydxx3+06DOafv4BYjMBOemrOHxoO04inPzNKQzDWz7SWBl3LgIHmy1pm/iOl0280wbE2DoRawO57AySXchpqHIesrl7hRy0oV6NTEb8Li2mrxBeQcL2/mSzVgr1cN4YDSMS7T5hheAzs80RuTy/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39850400004)(366004)(396003)(346002)(136003)(186009)(451199024)(1800799009)(31686004)(6486002)(6506007)(6512007)(9686003)(31696002)(36756003)(86362001)(38100700002)(921005)(2616005)(2906002)(53546011)(26005)(966005)(83380400001)(478600001)(41300700001)(8676002)(66946007)(66556008)(8936002)(110136005)(5660300002)(66476007)(316002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkxZR0M5Zzc1ZVU4ZkV6cHBqUDlhRFhNNTcxTU1VZmRqaGE5MU5TNWkveXhY?=
 =?utf-8?B?eDNZTHJaQytBTTI1SHBxRG9UUnJUc3Q1elQ5ZE5PaVMwak9NUytSbjdXMStY?=
 =?utf-8?B?N0lKNFpCN0xDcndoZHBhT2RUL0RLZlhFM0VIbFBySXBHazlFS3RsSm9sK25p?=
 =?utf-8?B?TzJla0RHemxCeVhwNzhNREdwNTZHa0lZMmtndDU2bEduTThWbVJ1dkJqdmxt?=
 =?utf-8?B?Y0NLQ0ZyY2lJeHlPa0I4Y2hnbkxqZXkxNzk3Q3pUYW8yM1d3eE5jNnptWW43?=
 =?utf-8?B?ZTJUbzFUWDl1ZWxPeGhlbkI1R01HS0VWTDA5OVNRWnk1akpwL1puUGMwOHZq?=
 =?utf-8?B?ajIrUTFWRUoyeDJtcXdSMWxtTXF1UkIybmlQY0hKZFJTRCtlMjB4REk0K3ZR?=
 =?utf-8?B?Q3V4dWtlZUFsdVpaRFdwbTJ5V3VzdGMxa3VPSE1NNmdBQjFWNE5PNWtMLzVV?=
 =?utf-8?B?TFJmelRPeVhHdU53U1kzVGZwUnFLOFFEVmxDQVRiN0c3Y05BVXBiaDBoa2lZ?=
 =?utf-8?B?Zy96VXFSckxFSnFIZEdFRG5uckNNWWcxUlZPa0l3eEI4dXFwSS9ic3ozeEJl?=
 =?utf-8?B?Tjh4cTBmay9YbTZpNWxPSk5WK2FrTXRiZ0M0SERWRkZZYWh4WmIrbDF1SmNn?=
 =?utf-8?B?L1Izd0I3UXF0aml1VkRDcC94eTRRaDN2MHRqQThnTTlJeFhyUHdkM3c4bmcr?=
 =?utf-8?B?VGc2WXlCQXhFYzRmWUx4d2pxcjlPb1Nibmp5cTBwcWVTZ01vZTNLK0pkQnFV?=
 =?utf-8?B?Rmg4MzFHK0JBc3g3Vkg0ei9YWWE1dTRSWEc4dGlKRHZKRWtmVzN4SGtsWVor?=
 =?utf-8?B?czBRb1BBNUE2cmI0cXNNYzhyR3BSVFhwY2Vuaks0RjVPR21sS2lBV29TUU0y?=
 =?utf-8?B?QkhkeldSV0FKMFlMUUdKalZDNmFaQ2x1V3pqM1BzaHBYd01oSHZlb1JJMmpS?=
 =?utf-8?B?T3BMN3pCNXUvYm9QVHFmbkhlYUZNRlloZVFCbkNCN3pnZ1lWNWlybFF1R1pN?=
 =?utf-8?B?cUxDN0pFWDE2Zm02RGx0VG54RzBPdXp2OWVpZ3N6andJYVl6WHI2Y3ZVMjND?=
 =?utf-8?B?OWNuRFJnODRjR1ByM3lZbkJLWU9RbzFVZHVaMStobVZubnVJU0pvMFZxanI3?=
 =?utf-8?B?TkdRTHhzeHc2R2VBcVZYQ2Z5TkJMdVh4TE5ueFJyMHhPRS9JR1pVVlkvdkQ0?=
 =?utf-8?B?cmxQNVc0a1pkNU14QlRmeHNCeFQrK1NQbHNpd04raTZuTW9uQUlORVJjUGQ5?=
 =?utf-8?B?b1h0RmV0TitiM3hQdVlzdFlGaVlWRCt1cVM4WVNrWUVmNm9adUZKU2VGSEVJ?=
 =?utf-8?B?eHFIQ1NJQ2dpWlhYbGZVaDdQUkRSNnFhbExUelp3SFkwQm5JNTY5VjN6ekFQ?=
 =?utf-8?B?QzY2Z0dvMkJaU0tVZ0ZQdXM3ZHBpRE9CLzVjVDQyWmtuT0lYdFhyaWQ0eExC?=
 =?utf-8?B?SHJpbFJCeXRLQWY0U0NVNlNIdzBUM1NVaGFTU2M0Vy8xZHB3N3FacE9wZFpm?=
 =?utf-8?B?VlhGOGlOYk1uQzR1RkFqWGozckNWK2hJd1pLWkZkT1BEaHJqOWlMdjRhejdl?=
 =?utf-8?B?SXROQU1rR1JoYWM2L2Y3a3czT2JxRjNrNitDbHVFUDIvNkkrUFIyTzR2Nllk?=
 =?utf-8?B?Y0VPaThLZTZ5b0ErcVFJbmpCRHJiTGFCNUV2NTVTdmgrTlFMU2dHT1YvZHNj?=
 =?utf-8?B?Q2RPWUxTQWRLWUk2azV3VTd1bVkwaWNIaG9UeENYcW5tVEN3TERLQlo5c1FY?=
 =?utf-8?B?Y0JWSDFjRkszcU40WFlFR3Q3LzhtL3BLeGtGS1prVEZZVzJPeG5EdVNwZ3Fj?=
 =?utf-8?B?R0FMcTRwcUluK2NaNUw0cnhVVGZtR0pXTHgzWlVVS0ZxTEVYR3VzMVBNQVB5?=
 =?utf-8?B?QWdHbGJrTU9KWWxJaHZiMzNNTFd5NUpIc0hNRk92TEdKYXFydXNJaDdONFNl?=
 =?utf-8?B?MVM2MHRGazloZEFEZVdlZFlmcVdqM2V2eXJra3FWbnlGTFR1dFBMRXBXeTZZ?=
 =?utf-8?B?bzVITTZOVjZhU0N2WDhwR25ER0Q0TlR4U3pvU0pKK2dEUFBPTmpsb2FHV0Ux?=
 =?utf-8?B?Y2hoQU5WUVgra1NXMHRzMnBZVnkxY2oyVlgyblM4bEVkTTF3TXliTkEwUmx1?=
 =?utf-8?B?VENKTC9GazdWUUFuc0NpRC9ESjRpVFdoWTluaThBRHNyMDRPRTBKZU03eTAv?=
 =?utf-8?Q?cHsZ1dd8vruv+4la0bIRMhs=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f047807a-8a7f-43f7-7b0e-08dbaac26bd3
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 08:07:01.6551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KYBeXWrwaCWqCfRMj8Bcrd8MZhf0O4YpRMM9ggGncL88EMLhtSi2VKQpzkqa/eFfJRCjonxggZxG/EavBSYSv34U9C4MkpI8yh/YxrHf5ErKz7uZx/cnlmRowHzhwpzv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9793
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakob,

On 8/23/23 3:16 PM, Jakob Unterwurzacher <jakobunt@gmail.com> wrote:
> From: Ermin Sunj <ermin.sunj@theobroma-systems.com>
> 
> If the codec is not the clock master, the MCLK needs to be
> synchronous to both I2S_SCL ans I2S_LRCLK. We do not have that
> on Haikou, causing distorted audio.
> 
> Before:
> 
>   Running an audio test script on Ringneck, 1kHz
>   output sine wave is not stable and shows distortion.
> 
> After:
> 
>   10h audio test script loop failed only one time.
>   That is 0.00014% failure rate.
> 
> Signed-off-by: Ermin Sunj <ermin.sunj@theobroma-systems.com>
> Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
> ---
>   arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
> index 3a447d03e2a8..dafeef0c2dab 100644
> --- a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
> +++ b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
> @@ -68,8 +68,10 @@ i2s0-sound {
>   		simple-audio-card,format = "i2s";
>   		simple-audio-card,name = "Haikou,I2S-codec";
>   		simple-audio-card,mclk-fs = <512>;
> +		simple-audio-card,frame-master = <&sgtl5000_codec>;
> +		simple-audio-card,bitclock-master = <&sgtl5000_codec>;
>   
> -		simple-audio-card,codec {
> +		sgtl5000_codec: simple-audio-card,codec {
>   			clocks = <&sgtl5000_clk>;
>   			sound-dai = <&sgtl5000>;
>   		};
> 

It isn't actually shown in the diff here but we now have two different bitclock and frame masters, specified differently, c.f.:

https://gitlab.com/linux-kernel/linux/-/blob/master/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts?ref_type=heads#L78-L79

So I very much assume we should also delete those two lines in the simple-audio-card,cpu node?

Cheers,
Quentin
