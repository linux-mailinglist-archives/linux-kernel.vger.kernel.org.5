Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C0A7C8069
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjJMIfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjJMIf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:35:27 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2080.outbound.protection.outlook.com [40.107.8.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D99EBF;
        Fri, 13 Oct 2023 01:35:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YB5WyyHXk8ozcWdZcq1es442EI5yiw/hn1BMErWlKebfzVpAP+2k9xw7r8GW/OIfrSwzCL61eeQNpZEW4bu/KYzAhJpmZHJV2cgD0Lp9H7fSvfgzD7CNewsJCNzTarkV2UTAA7LelPfh/hbtoyF7B63SWUiYLHwDBDLfUrFiW5Dzfc+uslh5I0c0rgfKrGuV8uKrcbOKf5Q6baVBb3EhPARKh5cHv8BwCbXIFIsxqkYgBkYn6YGYy5Yuw9SqwL0y9P/iS8/ZdIoQxjoeDkmNKe8Ix54Fl7+GLsT2n026y32Nx3O2ialO1XnBQgwb34OiNc60MQJ8ASH8/QC+7j3xng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AuUP94naGobgFn9SQF063tw7la/NGO5cR7AdtE9flYs=;
 b=OebQl5dKm5Y+88W0IbHlBaJ8gux7O9tFdX8Ip8w0XEaavZPR+2sjaPi0HH03x5iZzDm7L2bSUXlVdk2HhIGW9jIoNDSoiGNtAG+0vnjFi75fvWTa+90I/HXaJQtKAQagbyYibiRoLWnR2+2AwKcwOF4jnbsEaeFlyPwhdpko99vEDVAU103x/WW5IoMECWeRWKy8UBrtLLx1JWFPwqhbJQy7UVcWnFX6YagPL7lzm4c8eOdiHBEQV3kG9lpN7+8LJeVFC1ueT/pMuL0Z0kP3B9GpFMkV35G/dlsZ78SGIN1Rz890dmqK5cyF3z+LHSAN5mYmPNu+rImqz7VVAGKdhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AuUP94naGobgFn9SQF063tw7la/NGO5cR7AdtE9flYs=;
 b=Cflkhsf7IaWA8KjMRZ2FE7bJyFhAlRhd3Wv1bnXKyGpVkC4+YTWtNO6KAga6GLHWw5/iE2Aa3UKIWmwnjj/9FxKTR6ThVk5IhVrWVOHLfu6hSiX/v89b5XvY2AuqOy4OotcIJnXe8/UF1Y/NlQSuyxAN+4Pfyx+VZ1FuaZEo4h8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 08:35:21 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::ad2:49f8:14b:25c7]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::ad2:49f8:14b:25c7%7]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 08:35:21 +0000
Message-ID: <80a6a56b-4a12-99bb-acb3-94a5753b2de4@nxp.com>
Date:   Fri, 13 Oct 2023 11:35:17 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 2/2] arm64: dts: imx8mp: add reserve-memory nodes for
 DSP
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mpuaudiosw <Mpuaudiosw@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        LnxRevLi <LnxRevLi@nxp.com>,
        "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>
References: <20231010090929.4371-1-iuliana.prodan@oss.nxp.com>
 <20231010090929.4371-3-iuliana.prodan@oss.nxp.com>
 <2301291.ElGaqSPkdT@steina-w>
Content-Language: en-US
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
In-Reply-To: <2301291.ElGaqSPkdT@steina-w>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0202.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::9) To DU2PR04MB8774.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8774:EE_|DU0PR04MB9496:EE_
X-MS-Office365-Filtering-Correlation-Id: cc7fc941-82c6-498c-ea75-08dbcbc7566e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AmCt9/Rr/tossMS5Xo1yPjcW2y5Cs4H8CAw1NE0PBN83Zrf8LgJGdFdqRmZdjYbH9cT6KF6xjaOkdTeM77sL+Ys0XlBqf1XSclbRwLCyuoVKR0keSxnl2CFCT21pxSqWanXnCJK6BYIrQxz8D0Fz4RFq4xFEJUpOpPB2rUpbJmo+tR5fGONBejKEh+j4D0s45x+QYIzCa9tbg2rlnx60S+5kdmth+1tIO8XTZJ/GCYLjUAU3y23QisCvWS34581eJv3ybM2Cked7aFjFA6fVTrjH5ckiIXHSBmdjvVxiZRnJpJEv58KSnwV50Si4CS9PfDEF169Xjt2T2Ym6Ee492/MUsvKa+AA9Y1QpreSz5UQoXgNaUrwJ0w3IX0G5a1MS1XlHjan6/JAgFMprVq91Eo7V1jAv7ZzdV0Ph3O4QVN6LCXiHk2gcucLBh0S7YfH7+H+o5QpiHvl5ihL9B+JuS0yKhVnPjtJ46a7jsdyFkftdQz6utVNnFgrkGl58HkT3UFLyV03sapxta0WUrQmY43ES1Y0ZgJaWYK34SXI8/J2/rjdc/HS/yehmkiTU+shlWQK0RCyfCSOS31CtYyYZ4G6SF/rWymUJ0VKdunEtlq1YImE42xNdyYV5ZjWNngAGnDw0nCz/a6tgqye2CoPcMVdQJ9lqEHXgMd6LrNWgyT4jGIxhVOokcGy4OSiR2L6l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(39860400002)(136003)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(7416002)(6506007)(2906002)(31696002)(6666004)(478600001)(6486002)(8676002)(4326008)(8936002)(41300700001)(44832011)(110136005)(5660300002)(66946007)(54906003)(66556008)(316002)(66476007)(38100700002)(36756003)(26005)(31686004)(86362001)(6512007)(2616005)(53546011)(921005)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTk4aXBIeWdFVnluU0JFSGdPQW5wNWk3aHVDOWZ2SVF4eEhNbmhtbnlRQko4?=
 =?utf-8?B?ZTVBZTNrMkllbjNMV3BKYzAyNGtWY1JxaEczMUw0QjJMNjcwaHdVUzdHcG0r?=
 =?utf-8?B?ekFDbG90R2h1eGZSbnIyekNRb01MSnhScFNmN2ljRnNOQ0ZRZlQvRTlVWHBj?=
 =?utf-8?B?QldPeXhNcTlBbnltL2k4OU0rcUlzckUwY2V2YmpER080M1FFQzFjZU1kUnFB?=
 =?utf-8?B?VndWZDhiTWlNb3J2SFVBRVRPVVo5RlFXNWhqTUFFbG9FOVhvQ3FtWncvMFl5?=
 =?utf-8?B?OUpDMnFvREtwaU5zdXRXNDQvM0xINk8wSEtCQmUvc3Z2bWVjMjRoRFBwUEND?=
 =?utf-8?B?UGpIVU1WYk9Cdmo0Wjd6ZXdGNkpsR0hvUW9DTlJyaHIxNGg5WDR5K05XazdX?=
 =?utf-8?B?M3JhZXcrSlBlM1JTUFoxN2ZUaVRJbVBadjlPczZFMkRFVU14RStwWWJJTitH?=
 =?utf-8?B?eXEzUm0yQmNJb2MyVmxwbis2VzhDNTVSMEx4U1RqaURiSWFzbEFkdWd4QmJJ?=
 =?utf-8?B?aEs4bnJaaWN4V0lBaHFQdFhTa0ExejVYLzVFalNWMEF4Y3VleUUvWkRBWlhv?=
 =?utf-8?B?NDJYOVVYMWZIeGtOUTVWK0tpU2MxMitmbG81VTN4VEJSclNGQmE2SVBXektQ?=
 =?utf-8?B?U0NqblhmUVBvc0FrT0NWSWhhRzQvdU1mT3FHK1ZjUnROcU5mdncrU2oxTXlz?=
 =?utf-8?B?NWxKZGJpRmx3d1k3ZWIzQi9BTWh1NytwVXRZNnRCRXk0ZXUwb21PUkVVWkZ3?=
 =?utf-8?B?bHMyOXJxdnV1b2M3Q2pDY0VtRjhzeXJTbmg3TkNRZ1VkSk5OODhzSXdNT3dl?=
 =?utf-8?B?dElZTXcySW9la0t5azZrMFlkZFJuWEtnRk5hS1ZVMjZCZ1V0N0tiUUk1bmhW?=
 =?utf-8?B?ZHgzRTFaRlpPUUVaQ280MjVvUWQ5UlcyREZQVE4rSHFNVVI3YUF5NXF2bWZV?=
 =?utf-8?B?bXpRK2FYMTJiS2JBZmNWTEtCeGNFOEg2RFk3TVBlOXJ3L1BsMTZycVQwWThC?=
 =?utf-8?B?UnFFT0RoK0ZRSE0zdCsxRDIyK09ySGpxN0RPb0xLeGVJTGdOMHhmdzFlUGdu?=
 =?utf-8?B?RGkwTUN2UnlyemI4SDJ1d21wYTJSNzNNVGl3MXlhc3lKUkpocFdxTUIxZjkv?=
 =?utf-8?B?TXc0QVIyeDdXdUF0RGhUUThnUTE3Uk9UZEdjUHVWTnVFdm9qTWZ3dHpkYXUy?=
 =?utf-8?B?Q3NwZDZMcS9KeEt1ZVJrT05BSDVVaXRYMFB1OG9MMmtJcTVtNzdxL2xQNVlk?=
 =?utf-8?B?bFFlMU8rWDJBN3ZFM3JoR01mK1JaWkhTNDU4OGVoSk56eGQrUFJNUGJxVnFm?=
 =?utf-8?B?M3FKaDJXMWlqN2RHcnpUWDV6TmFzcmVTTEw1SW80emtrQVJvclo3VHgycUFn?=
 =?utf-8?B?aEl4UFlHMzRsS2JhcVgwMlI2VDBldEtpNDZaazdRQTlvM0xlVHgrZW5ySjZh?=
 =?utf-8?B?clcvUWdpWWJueWV1cUxoMWdyWnM0Mk16ZGQ0Qm94dmNsN2ovb2xzVkRuRWlw?=
 =?utf-8?B?Vm5Ea3lWM0lIYjN1THFOSnRoWFBKeFFyYXc5OERsSVlRd2VUOWRqWHRSams5?=
 =?utf-8?B?eFI4dGxOSlNDZHowa0wwQTR0WWMyc2lvLy9sZmRRcmhuSnhhZWVBdkVrVDJv?=
 =?utf-8?B?NHQzWWtKUDZCbVIxRXFkdDg0Tms5c2hhcmZ5MDVZc0ZNS3dSOW9LdVRXZ2RL?=
 =?utf-8?B?ekE2ZEd3OTcxclFhLzF5YkZaNktHc25BN3FCUU9YcVd5b1k4Wmw0ZWQ3N2xw?=
 =?utf-8?B?a3ZkQ3hIQ05qakJaMnhQdFdVdFdKbWswZlZ6QW0rWDBFcXRMOXlZMStSZ29v?=
 =?utf-8?B?c2xOK0NXOFhoVzc3alA0RXdZb015RnFabi9kanV5L3VTb3pJZ0RyRjRBTllr?=
 =?utf-8?B?TW9SdzBPUkpUNFRJS3p5S3lCbjZmSWg2YUJxdEdDN25RemgrY1k4VmJTcCtM?=
 =?utf-8?B?cGd0a2tjMk92UTlLNkRVR05GUDBTcGJtY2NQY2U2dzExY21FTW1vZWpDZTIv?=
 =?utf-8?B?MXZxM3ZmMGhBSFc5VUEwNTUrYU5yQ2tYTFdaZFRKbmZLazJNZWRrSTFnUC9o?=
 =?utf-8?B?Zm9ITXVLdDZRYnovYWdTd1NMTEUrRi93WUQyQVBsaGJZTFQzT01HTWd3OUhJ?=
 =?utf-8?Q?p/F2njr6FGVcgp8ZcRxVDivoi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc7fc941-82c6-498c-ea75-08dbcbc7566e
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 08:35:21.4729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uNzCT8cgQiARErIrwnVbaMqtPRW9ptGJyb/TJdmKswpEyAl2MNzq6foWR9nLHNfW31IHGhMMJ+UpzALVkm2Xzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9496
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

On 10/11/2023 8:37 AM, Alexander Stein wrote:
> Hi Iuliana,
>
> Am Dienstag, 10. Oktober 2023, 11:09:29 CEST schrieb Iuliana Prodan (OSS):
>> From: Iuliana Prodan <iuliana.prodan@nxp.com>
>>
>> Add the reserve-memory nodes used by DSP when the rpmsg
>> feature is enabled.
>>
>> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
>> ---
>>   arch/arm64/boot/dts/freescale/imx8mp.dtsi | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>> b/arch/arm64/boot/dts/freescale/imx8mp.dtsi index
>> cc406bb338fe..22815b3ea890 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>> @@ -211,6 +211,22 @@
>>   			reg = <0 0x92400000 0 0x2000000>;
>>   			no-map;
>>   		};
>> +
>> +		dsp_vdev0vring0: vdev0vring0@942f0000 {
>> +			reg = <0 0x942f0000 0 0x8000>;
>> +			no-map;
>> +		};
>> +
>> +		dsp_vdev0vring1: vdev0vring1@942f8000 {
>> +			reg = <0 0x942f8000 0 0x8000>;
>> +			no-map;
>> +		};
>> +
>> +		dsp_vdev0buffer: vdev0buffer@94300000 {
>> +			compatible = "shared-dma-pool";
>> +			reg = <0 0x94300000 0 0x100000>;
>> +			no-map;
>> +		};
> Please configure these reserved memories on board level. Not every i.MX8MP
> based board uses this DSP or has these memory addresses available.

Will it be ok in imx8mp-evk.dts?

Thanks,
Iulia

> Best regards,
> Alexander
>
>>   	};
>>
>>   	pmu {
>
