Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45867B46B5
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 12:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbjJAKWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 06:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbjJAKWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 06:22:09 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2082.outbound.protection.outlook.com [40.107.14.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F67FBF;
        Sun,  1 Oct 2023 03:22:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZY+GDIBEs8HcmGgtyPge5aw4/bg0FGBl3Q0GLbPBOr2eGUJ9uc+tebhrTYNbjWh7qEGvch464sf/5Zr/EKrjwEg9rqdSYt0KFA7pcYf2WvuZVr4YHQmHBqMJfog9M3YnEbnUAkkwBU5Q3sz2AOoB/Cfj8zr2DxynPQpP/0DQCY2MfA3ChAN8ADM0ooQTgn5bYMj7D+2ZcgSSYh3jlTXjfhzIM9IFnNC1Y02tN2odXeNvfzm40BZwzdiDMSLsNzBGATUDwZQgAdMPvnrRvuTdiXffKNBBvQ6izRxRhZ3neYpDE6XNWKwkmii1AWOo2/N1xQe9UVVjt34yka3ESap+7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8I3Wm1gCpmAOcloO1vKTDi9TUAO5nwN474Xs835CPi4=;
 b=HrYG7tAV9jkty+y4JnszwnYTVuYN2Xb/UuMVVoeSd+e0d1oqqeUy2/TZVBrIrw0f1hNJHHMhePrZmYhlzYoCAHncgwPLT99ukPugjYtw/T235MTae/6FvlMo3RvQajewuZzFRq8A/JdPxs6cGSeVX2lDL2EVpDzcLk8mC8ReyeLrzRyHqRqAUqkW4kTy5EHnA8Dzj93xhSTRQAomn9TBAOwQ7d9G4CtXiyvZBDyaPbTgezsGMwO2FVdxprxfc/VGCTdYT0z+/CFajTnPjxJ790WtOHnAC4arFMmVYe1tETHUz0Je9zoj09LnfqACBFJmgsVvhrPgDjacEXINZxdRMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8I3Wm1gCpmAOcloO1vKTDi9TUAO5nwN474Xs835CPi4=;
 b=ocdvQykNDI65Albq/FA9oXSlpqqf7Pc9gW6XgmNIfZVujEG6qQo++2KxCXoBtszXT2SDA99QiZeeoAnyqn0WTybh46i4Oc/OrBvMmp78gIAkh5auYwudgYFMBVZJ8SuCGdlfvN6nyHt8ZWXoJqT6NyXrQK/A30nmRI2TjB349gw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by AM9PR04MB8714.eurprd04.prod.outlook.com (2603:10a6:20b:43d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Sun, 1 Oct
 2023 10:22:03 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::cc84:fc7a:cffe:985a]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::cc84:fc7a:cffe:985a%7]) with mapi id 15.20.6838.024; Sun, 1 Oct 2023
 10:22:02 +0000
Message-ID: <15d382c5-ad09-4532-ab30-7b19e8786d00@solid-run.com>
Date:   Sun, 1 Oct 2023 12:21:57 +0200
User-Agent: Mozilla Thunderbird
From:   Josua Mayer <josua@solid-run.com>
Subject: Re: [PATCH v5 4/4] arm64: dts: freescale: Add support for LX2162 SoM
 & Clearfog Board
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <festevam@denx.de>,
        Aishwarya Kothari <aishwarya.kothari@toradex.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Tim Harvey <tharvey@gateworks.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Marek Vasut <marex@denx.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>
References: <20230818111016.11271-1-josua@solid-run.com>
 <20230818111016.11271-5-josua@solid-run.com> <20230924135111.GJ7231@dragon>
Content-Language: en-US
In-Reply-To: <20230924135111.GJ7231@dragon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::12) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|AM9PR04MB8714:EE_
X-MS-Office365-Filtering-Correlation-Id: da8e6d47-1fe7-415b-1cd3-08dbc26840f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mKapZFd1LCclHLMb0ZOjUIGgAVpYa4rIcF/m1JKPvA2BQKQr7wLHW6c/Iv5aJ24DpKPSZ541F0110AtzjhVnE8i1Icua6rB0x8iA7JXR2O3bSE/o2tT0CVvtnrQ8pJv+zEhGup8yG47yB6ESYoP0MMfenn0anrcvMOs8xKqPhvIiBSCLyXQy2bG/2oxEi1RiD4bkumezKzDjKdh7ZPJlGfwL4K1SqF4s3SX+I1ZOL0O4AISaapVAeKjjStnFfj8iTHTd4EDiTuV2neU/vOYYQ+350We6sSkrSK0Wh6YEuZbv3DwzSz1hB6WROmluW/ZvxI+VVVfcmVzl6vOj2wFQdMqZx0ZHtQCnrPs68GeLw5vV1EfnHxwe9xOpYG9IrNBK+bSYsAPADFzVjVvdn96JzhRR1bEU/MIyUJbzoWDwQ+qEHBKEG/hZbv5vR9Y6hPVc5ykShErvwYSsO4tPemeEgvxahmOAPRAaVo/5Yu2Q2uK7xHC6w5jcQMxYJbHsaXiszOMG3IYoTwIN0+UHxt93lNjzxtOf2ID6Bziv85dFFteZLfJdsQWgp+olIsu335ukoP+FVflkx4vz/5XOmWCHnJabCzi5T1ftqsJ58WgIPBuEo3uZec5H/uQEvSxTCXo+GTZzWxFTLvxxAzP+I5cvaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(366004)(376002)(39840400004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(31686004)(36756003)(41300700001)(5660300002)(31696002)(8676002)(4326008)(8936002)(83380400001)(26005)(2616005)(6512007)(6666004)(6506007)(6486002)(86362001)(66556008)(7416002)(2906002)(66946007)(38100700002)(66476007)(54906003)(316002)(478600001)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEJpN3pJWWp1UkZXTjE4ZzFKblY0TSt0ajhqQ2VzejlpUUpYM2o4Y0Vzd0pp?=
 =?utf-8?B?dGtaQVVpTzlXbEg1VVk4OUxZSEx0aEhtSVRaa2EwZUwyc1k4V24vMHVOdktW?=
 =?utf-8?B?UUZaeWpBYUNoZEQ5T29WTDNxZXlhbWc3d1JzeDc4SGo5M3F4VW1lVFdsQXhQ?=
 =?utf-8?B?NjB6ZXdIb0dPY3F2bUtqazJ5MHJUeUk0OFJaRGUyRGNrcXovT1FrbFJ2ZDRj?=
 =?utf-8?B?UVRZai9Odi92MlF1K3djZHZJeEdnS1BCR0t5dkFJc2VaY0RWNzVOUnBHdVVB?=
 =?utf-8?B?SFZPazVjOTNoT08wV3Y3MFVlTmc1ZlBuSFViY0VneDRwU0VpQ05TbVFLekpz?=
 =?utf-8?B?MlFFNUNoVUNxcHVMY3JtS01EWUhvaEhCU3JmT0lUUEd0alVNclBRNmFCWkVE?=
 =?utf-8?B?b21TVTRSSVduZ1h0Vk1XejNaa2l2SS9EaUc5Z3BLSkF5TVlYNzJKcWlZZElz?=
 =?utf-8?B?Slp6VG9panRKelZicXdCa2dSZXNaZ0tEV3lNdVdjMTFwU2RPNFh0L3YwUnh5?=
 =?utf-8?B?K2V6MzBpU09Fb1F1L0d5S00rRVJpbWFqV1U4N0dhRVNBNmxabkpPbmlhODZj?=
 =?utf-8?B?OW9KQzBTVGEzZDlBZnk2YjhGRzlxR2ljOWVkN1dlQXgxVTdrUUtaSXNEVnRL?=
 =?utf-8?B?eU51RE1IVzlwN1g0dk5iQml6RzlUUUFoS1MwM0MvZFdZUzk4N2N3ZXViUlI2?=
 =?utf-8?B?WU9hbU9UdHQ2NjlaNmtTMGNpb3ErcEhZeWQ2RDh1ZUdwVk9DSVJiazVmWjVZ?=
 =?utf-8?B?SEtQRXRCdmpxL0N5REFwSSs3RXBzaUlKWVg0c0IxZEI2ZUN4MmlVaGJOQzhp?=
 =?utf-8?B?R3Z3Rlo2YVAzMk9RWDJ1MUVjVXJWSmNRZVNVMmdsZzhhSFUzRDBZc2pHbmxh?=
 =?utf-8?B?Q1pRU2x0MlJiTHZPRXVOem9vME9yNVIzdzhGSld0UE5rWDIwcENBc1RYRTZF?=
 =?utf-8?B?cldGQmY1Mi9rYUI4aXVnMXBudytmUW9NVDZVVTZmeDhMNWVnUXJJS2gySDNV?=
 =?utf-8?B?M0JBR0IrUFFiMUlnSW84Rnc5NnV6YWZ2ZkJSQnFpUm5aTiszRGR1WGhvSzFP?=
 =?utf-8?B?S1MwRnNvNjNaeFRQVTd6R3FnZVhFc1hiYlhWV1o3ZW5DS0U0eFJyQXFFYVln?=
 =?utf-8?B?ZEFkc1cwM2tPL0h0VkpKTnd5VUhHWWlvVnhId2tLT0xEem1obnRwMTJFVTVm?=
 =?utf-8?B?V3NyOWpUeUcvTFo3c2ViMFE2ZDBONnBIR2k2MzVkcXNXNXRjbVJVQzllcklv?=
 =?utf-8?B?UlNTdW9DZmM5MEhCbEEvdFdML2hTdVQzT3dnL1gwdEFrWHkrZUMvQi81OXZ1?=
 =?utf-8?B?UjE0bHNlMUtzZG1yL1UydGJ3c1JuSXcyQllxb0ozTzlnUmlaaHBEUGh1Tjht?=
 =?utf-8?B?aEdDeU41bXgzUVJna0RrYzVrWU52QXUwNy8yaXh1dWpmS0plSXpnOE9lODBi?=
 =?utf-8?B?ZVFQcnY3Z2VFUGZoYXVuOEN6OUMxSFRUZmtSREJSNk9SZW5iRCtsQlhwTW12?=
 =?utf-8?B?MkZzcGJmMTZmdGdad0dLaysxdStjeXdkV28wczM4b0Z3cHphVkp1L1NMVGtI?=
 =?utf-8?B?cHR0TDVETW56OHh0M2M4d3FvcUxFdWtkWVpBZlREV0tIOFl2WERFZy9DYTVV?=
 =?utf-8?B?YXdXK0liNXgrY1BKZHlONXFzYlhmWHA0c0FDMis0Ujl2WXhCSHhBUlRWb3NH?=
 =?utf-8?B?a0JMcjRPSW16U0RuL1U3cGxGYS9jMkI1dEw0YW54YVhMTTluUHBrNFNDWWhF?=
 =?utf-8?B?ZDlzQlRqR2NyZTVjU1VtbGdwd0xaZmxrUXovd3dUajU2aW0zOGZhYkR4SUZJ?=
 =?utf-8?B?V3dKNTJGL0l0amI0TVJIeWt5a0poREV3czFaTDVidmJQWEtDNElLR01kRWx6?=
 =?utf-8?B?VSsxKzNkQm9paVNkV3B3MEdUV1hzRFNoQmk0SXdmOURveHpEMjJvazQwbmtu?=
 =?utf-8?B?eHppUGRsM2dBcEJQOXE1VmV2SGlJQlVGVmlweDREUVNtRHJIQXlqRldjb3dI?=
 =?utf-8?B?MXdHcFV4KzVsV2dJQWxEV3MzSE9ZbXFzUnVuUnlxVnVtNUZNWVJZbHBweGdv?=
 =?utf-8?B?ZEE0VldSMWxuYkZ6ZHF3b29mdVRIa3h5RFFRVGhIeG9XYURjN3ZSbHBmWk5m?=
 =?utf-8?Q?m6qh63bLsWXbipqATCccIBLbO?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da8e6d47-1fe7-415b-1cd3-08dbc26840f5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 10:22:02.8310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NABt0csFRWVY87Z0e5g6/AaDye+CT4McywH8+lRD7T5myNyBEr7hSlYFX//Jd0j0tzxIsSbYWTws780oDem+pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8714
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

Thank you for the review.

@all - some of you have received this email including HTML,
this is attempted resend as plain text ...

Am 24.09.23 um 15:51 schrieb Shawn Guo:
> On Fri, Aug 18, 2023 at 01:10:16PM +0200, Josua Mayer wrote:
>> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
>> index a750be13ace8..9448d2effd8a 100644
>> --- a/arch/arm64/boot/dts/freescale/Makefile
>> +++ b/arch/arm64/boot/dts/freescale/Makefile
>> @@ -34,6 +34,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-honeycomb.dtb
>>   dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-qds.dtb
>>   dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
>>   dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2162a-qds.dtb
>> +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2162a-clearfog.dtb
> Out of alphabetical order.
Ack.
>> +
>> +		led_sfp_at: led-sfp-at {
>> +			gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>; /* PROC_IRQ5 */
>> +			default-state = "off";
>> +		};
> Have a newline between nodes.
Ack.
>> +&i2c2 {
> This label node seems out of alphabetical order.
Ack.
>> +&esdhc1 {
>> +	status = "okay";
>> +	bus-width = <8>;
>> +	mmc-hs200-1_8v;
>> +	mmc-hs400-1_8v;
> We usually have 'status' be the last property.

You are not the first to notice this, but somehow in each version I 
forgot about changing it :(.
v6 will for sure put this status property in last place!

> Shawn

sincerely
Josua Mayer

