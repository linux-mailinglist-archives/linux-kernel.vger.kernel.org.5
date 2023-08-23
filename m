Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71CB784EB7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 04:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjHWC3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 22:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjHWC3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 22:29:19 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2100.outbound.protection.outlook.com [40.107.215.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7562AE4B;
        Tue, 22 Aug 2023 19:29:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BY9bYonvRYNBX0++FgbKcKXhkimvni8aaCMIaOv51TB8KFW+1xHsRNWzZbz2NKBm7RyJGiqOkm10p+IF7YkOduy7FrZY8nsbTTz1uH09lQ99z67OLS8gyxKsZ1KxCnW+4a2UMGQ+GzC4QPWBqsQwN/tecsYf7DHenEIipeulvNVtMmDb+kSaJaylAxySPSWyj+69+moWsWLyg7oMvlb+SJQtKN/ZWKxX7hq2Qw1MykyiXDjqd18ey5zPnOmReDVWYF6yXh8P5QPLF9evjYfzJiCDQBvO9F8nG39qu3+85+03HCbm++bfUwV5ov98O0q+QLUwnw0w/f5RJ/9IoyfxbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kuyjiJ7n53vF9hVrw/jjZvYzu5t9/X/HRikchDwsqKk=;
 b=b+NeKam4BU/JPyZP5tobeA6KTB2iRjztZcOz89VIfx+I6S/JlNeNa25pOttabRF2CVwB3rbCMF85xRyFrBt91FUWlM95G4kxdXo0JqBHuqhhBUXhO5H3i5TMn81AirwoRhZH/o5f4i/iH9+Gk6dDBC/VJjbAkbQWgHa0DE6FtBpJ8MvABJQpyux7+MLwPKzy8BL1VUC1XPbxxpk+jF4EoqIu2YVN7nfhn9e2L4nAq8jx4qmzgGaFuSuGmCq0ECWYeTNmXNIskMP/EiKsDG8FG5Ep0GxvWcWFPGtpuXL9/3YQ/wIsGFZKgm45LTePOf+R+vuJgTWlgg5X1bRxNQd81w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kuyjiJ7n53vF9hVrw/jjZvYzu5t9/X/HRikchDwsqKk=;
 b=oCZmMMYOLY68+m7K7nFN2CbLuNa+R8aeU+mqigDfe/+eoxrQxM2My/nRSsXaj6PBdIcEAkJGxDphGCIwn34r1xgBbKOBqZVby6ZdZR7kVeAWS5KJHxHrEbBriCYKxb+TbYcp5DA7iMRM1UjUg1DRpqQNZsXZCCxKBynq/5XtL/+aHnuo7dWmej+ZWTXgTFOSsgGmoOySsSGwyg7JEIiOIAxmStm+sFTRp9SPQSn+874R+P2WIIcyK000XSaSKurRF5YtJ6iLxNEvqM+Bq6nO78r8QvXfs9N7hPL2sHT1CG5JT1RKwp78PzD4u3pM0SVNmavoUveRmM265EEm4Agejg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com (2603:1096:4:1d5::9) by
 TYZPR03MB7026.apcprd03.prod.outlook.com (2603:1096:400:338::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.20; Wed, 23 Aug 2023 02:29:13 +0000
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::6f04:4b62:1127:59ed]) by SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::6f04:4b62:1127:59ed%4]) with mapi id 15.20.6678.029; Wed, 23 Aug 2023
 02:29:13 +0000
Message-ID: <63012649-db25-5ba4-1628-c5ebd2d6107b@amlogic.com>
Date:   Wed, 23 Aug 2023 10:29:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V10 2/4] dt-bindings: clock: document Amlogic S4 SoC
 peripherals clock controller
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     kelvin.zhang@amlogic.com, qi.duan@amlogic.com
References: <20230822082750.27633-1-yu.tu@amlogic.com>
 <20230822082750.27633-3-yu.tu@amlogic.com>
 <1c812715-731e-18fe-e431-311f18af1bb5@linaro.org>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <1c812715-731e-18fe-e431-311f18af1bb5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To SG2PR03MB6730.apcprd03.prod.outlook.com
 (2603:1096:4:1d5::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR03MB6730:EE_|TYZPR03MB7026:EE_
X-MS-Office365-Filtering-Correlation-Id: 94712e5e-1c5c-44b0-80b7-08dba380bd99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1qWU8NbJrUUsb0ekOmiv73q5Sz9Sj3yIlSlKvcFYYsQVq/BgApQnWjFh0XkVQdeeVUYYPBcjTqDaw4iPNrfQ9ng9mr5eYhF/6UhNnUNM6eyjIUUvMPqJZ66n1yLffrKZ4Twjv2laTmupnDEKMNQ/tg/XRdmGrWtLDH/5YIQ7rInhwx8iDJaCa1Na64bdB2n1uIB051cNQw2XAnPpzwLQWCUI2loCTeTUP0FK4MTpZioBLSrpJodVFU14D6TTKxgX/CKQZE+Hrt1MVmEDlV4jTIgkHL5NeNdnGAFG4MQsMvBW/Wq5NfxdiaZ1v0k6b6e7cI7bJuiZ2jTumP8tk3TItGSIab5D+o268Rhxj0XaRzsyPT7N2X/+gZwFfU5fTNzD60ATp+y7E6JnfB9mNFMG5oK6itL1lxwygfEpKyK+0oUkyj6umJsBKnXwYJTX/+fGNgeyzT65OSO+Ye6oyz9plZYaXSW1nmnaQ4GML6uewu7Pc2LrKA3tom1wOaGlOLyeNRiQnu+4BsfCzT3+RRQNLqA+h1mlQYH6l5LM9Ag2cGe/X9lzBVU+LYCANkg5G4+m9I7qB7T7elXBlR4XzdDGsJkVbJyEsXkA07p5jNMWIpCSayewaXZfduA+UNfed28/pog7ZVw9S84yzzOnGGoK8Hqaa99FSRQfCJQsPshAH9VpY24dcA6i0hhrLMYwSd4rZh6Sp6ussOuWfqBoHRc1mqJ9qNEVbrDtG7+N79ElN0OQiZCXj3zQ/YyBhhV9S2Nc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6730.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(366004)(376002)(136003)(346002)(396003)(186009)(1800799009)(451199024)(107886003)(2616005)(12101799020)(6506007)(53546011)(6486002)(6512007)(26005)(83380400001)(4326008)(8676002)(8936002)(36756003)(4744005)(921005)(41300700001)(316002)(31686004)(7416002)(31696002)(2906002)(86362001)(5660300002)(44832011)(38100700002)(478600001)(6666004)(110136005)(66946007)(66556008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVRDYWlqN3NuYUZ2L0l2WXptV2J4RzA3WXh0cUpwZDJ2a2owM0psUzZ4NkJk?=
 =?utf-8?B?dUI5UU8wd05PYUF0YklCbFhsZU9PZ2xaYTlBbzNPUzVWejJQNEVxLzg4K3hk?=
 =?utf-8?B?R1g2UUdKb2pxTTY2NzlIQWU2aTVHRm5aV0FuL3doS3NDSHdBbk0yWHpyWlVx?=
 =?utf-8?B?Zm5ic1VkU2pWcXRoOUFRcUdUSVVCeCtmVnYzOVpvMU5keFkyMk5UM25hdjNK?=
 =?utf-8?B?UHdUc2NNTlBZQ3ZFVWJOVEVhSUI5cnBZUHJaWDJVOVZGd0ZZQ3c1YlFoOVZr?=
 =?utf-8?B?clRvTVErT2VtRGh5Y09YT21SSUptc1c4amVSM2tCUTgvN1BaMUlSM2pXei9X?=
 =?utf-8?B?bjVxRTlHYXErVEFTZC9rRFRYRFRPNm96dTBybVR1QWt5WElmT2JvYlBGU3VK?=
 =?utf-8?B?bHhaTXd5MVE4YWVUMzlEYXFWTUdrYldxN0c3Z2Vnai9mODljOWxXMTN1azB0?=
 =?utf-8?B?aUsrdmpVTGgweXNBcVFOd0c5OENudEljQXJjQ0ZaS2pQaFYvYzYydGtEUzZI?=
 =?utf-8?B?ZkJLMCt3UWZtL1dmSzQzRkhDditaRHYwUmZZMVB5SGhWT2NZUkRGdzl6Q0gy?=
 =?utf-8?B?dmNFR05TYzltNklndTlzMXZvc3MyZFIwMDJYSXMzL2JKanVzYmZXbkpKa2k3?=
 =?utf-8?B?dzJ6NjFaMnF4TFIvUC9na2tnUzR3QWlGVVRKT2I5UkRYY1I1eWRlZXNWclR6?=
 =?utf-8?B?SmkyTTJ1WEhoSmRjeWwvRjdqSWExM3ZGQVU4OXFKbC9WK3pWSWYxVW9KSTFn?=
 =?utf-8?B?VUtMc2U2OHAwbkQ0VXkvVElNMmduTkdqMGNuR0l3WWxzdXAvZGpkbEQ4SFF0?=
 =?utf-8?B?UWwzcVE4SHRJd2NvcmptOURnUkdEQ0srZXVJQTcrd3VRVnJZY01uKzRQblcw?=
 =?utf-8?B?cG1MZXRCV0NSMnJhclE4UjhpZzVpbTBRRzNrZlFGUS84MkpSeFRtMWF3TGRH?=
 =?utf-8?B?T0xuMTZKdTQweTA0S3hRZVBNYmoySDFtdVNHTXpERmpXcUswWHJSRm5oU1po?=
 =?utf-8?B?UG5CblBib0tCL0ZYV3o5ZVR6L2Z0ak44Q1Z6V0YzRjNVSHRVQU9Ca043N3F5?=
 =?utf-8?B?bitKN3l2eUV2S1FmZWNsZlBIc0JEbkdKemFZaWVBWkhWQnpmOUx4dExtN0lB?=
 =?utf-8?B?NlpxWE0rUENjc211NDFya2JBdlJHcWdOU3U0UUdMR2VpVEIySnJaL2h4TktV?=
 =?utf-8?B?dkNCbVBvRnRqRGhCRXplcW9FMW5laWlWak00Y29ZaTIyeU1udDZFcEVhY3pn?=
 =?utf-8?B?YXZvWWZMT0pZTkZnV09ObEtGQ29BZzJRWktvR003UXNxOVNvOWdPWHFsQlF5?=
 =?utf-8?B?SHhwL0FvL0J2V0pYVnFFbVRXRW9GRS9Xa250TlJNZ0prZWRHZkZrWHZJNkZn?=
 =?utf-8?B?NjBSVVp3dlM1UkpSYkttenMwWjBZZnJSbU1pcW9Mb2pzbnpVd3lwbTkvcHB2?=
 =?utf-8?B?Slh0S0cxb0NaS0twbFFIakdhTUY2bDV5WmpkaTZJR0gxUGVMVGlGeWI1OHBD?=
 =?utf-8?B?MzBXMnM2MzNqaTdiUEJ5aE5SdVlMSGlhMS92WHRQS0hQczZJWER2RFNRaCtV?=
 =?utf-8?B?YTlIck5oMUNFTVFrVkwwSVRCY2FlTysvejh1cDkwMmJMbXA5Y1J6Zk5WQ2M5?=
 =?utf-8?B?TVlrZHU5ZkFGVUl6dkhkc0pjenBxMUt3dFF2anZyQzdOY01OZ2NWTGJ3b0Zu?=
 =?utf-8?B?Q3NLOXJKNjlocnNJUTVOY2c5NXg5a2YwdHk4UlNmUkNnejZPS3NWZ1dsUWZx?=
 =?utf-8?B?Z1E3d3U1dVNvWkZFOEFTcjlranNuVG1jVGdXU3pHNDZuZi9KektLblVjMjMv?=
 =?utf-8?B?WHc1aTF2bTR5Nm0ydnViTG9LQjNHQ2JZM1NBb2NvbnRpZXdGUE9jS0sxdFlt?=
 =?utf-8?B?SzFEVUlmVDJmZU5kWm5XYnNxREdEOWFIbDY4T2VzOVN6Z0x4WmlHUkdCQXpn?=
 =?utf-8?B?TU9DZVNUNGpkMkFHeUZGOWEwV3pCQjkzUXZXRStRMVh2bG03T21TMkhVdjNC?=
 =?utf-8?B?ZlRlbXJUdU1kM2VPUC9CMU1CdlZHU2JTcGs4MlVQczVDMlB5TzFIWEVEY0Fk?=
 =?utf-8?B?ZUZIUUtzSGovdks2SkdnN2JJNldsdVFhRkxIN2JNWmNMZUg5SlRTb1paN2xH?=
 =?utf-8?Q?P4BWn7eFpkXa46F/nzm+YSJk8?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94712e5e-1c5c-44b0-80b7-08dba380bd99
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6730.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 02:29:13.7058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pMytH+dxRCFO6aHfXhF/y6k8af/2gwVJRCjdysgszecr0rkHozC1iJlWhi8BqzYlHeiEE39RpDNHDuwwi2hwRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7026
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/23 0:33, Krzysztof Kozlowski wrote:
> 
> [ EXTERNAL EMAIL ]
> 
> On 22/08/2023 10:27, Yu Tu wrote:
>> Add the S4 peripherals clock controller dt-bindings in the S4 SoC
>> family.
>>
>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>> ---
> 
> As well ignored email from v8 and v7 and earlier versions.

Sorry. I did not forget the friendly reminder in v8, I consulted you for 
this at the time, so I re-sent V9 after adding the tag. Because it was 
just "meson" that was removed. But V10 is based on Neil's patch, which I 
think is a bit of a change. So I didn't dare add it. Instead of 
forgetting your reminder.

So here's what to do, and I'll follow your advice to the letter.

> 
> Best regards,
> Krzysztof
> 
