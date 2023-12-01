Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79168005FF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377880AbjLAIlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjLAIlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:41:04 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2091.outbound.protection.outlook.com [40.107.215.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81F710D7;
        Fri,  1 Dec 2023 00:41:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1xpC1otytEVjta4RwrvYY/qje+gmHyPIeeiDhh5UVrOb4w2LDySmkJ7I9VQzdhyl86pwVZ5uuRyatqbIPhaEBU5nnCIqB38a0pWw/cD06MYbnhG8xOrWroNMK5dBs5UxqCxNzzzVFOfkMCkn1Fb/2j2cjTEQSs6yDXU46b1w3dKmkcVHIimlqfzn5l8cbe6S2rfwipAE0iHhO13YitGnOPHUxE+z5sIEL0fSdRzBF+XcCw143OynSd/qmqkTBzzv9AfWJzSDfxx6hlV2nQmTq5C8naCWtRmK/qjIF10SE3a4qNEHK55IKpGV9vrIFKSaVA8lf/JRktm6ZUbNTzTeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xSt/vzukGAa7hvpbl7bJlDhgHdOU7un7BfiSScPBhw=;
 b=CrKm4LYchOgDNidWR0vyo9gX/Y10mOi8qryZJg8shSCpcINqRMxMbJxxeebP2xWxpMZErYBr7tWjIian+2WyvGxQsAwVMgWKZ3QoNHfNumVf1Pf3V+FpzMYkBV7jJuBg2mV8TWx67SWjCUetrhqVSHFNwO7MRIDv+bKQ2Ki5ybonuDhMepcpHfUEgGOupxk5GkxXpjP9rIowLKhWVTNDj6uyDCtG4G3+pysCDB5IMMFNQKj9hDWJ0RFj09o1yn3UxenX0wMORGl038eRtPRs9BB1wma7wKqRvozcDIHOVaOngEObL1o7v1pkgwq9qXNY/wILyGBoncJtRR5sDs7Suw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yunjingtech.com; dmarc=pass action=none
 header.from=yunjingtech.com; dkim=pass header.d=yunjingtech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yunjingtech.com;
Received: from SEYPR06MB6507.apcprd06.prod.outlook.com (2603:1096:101:177::9)
 by PSAPR06MB4517.apcprd06.prod.outlook.com (2603:1096:301:8f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 08:41:01 +0000
Received: from SEYPR06MB6507.apcprd06.prod.outlook.com
 ([fe80::605a:d113:7ca9:8572]) by SEYPR06MB6507.apcprd06.prod.outlook.com
 ([fe80::605a:d113:7ca9:8572%4]) with mapi id 15.20.7046.024; Fri, 1 Dec 2023
 08:41:01 +0000
Message-ID: <e21cbadf-84a9-93b0-ea07-924c17df8eb4@yunjingtech.com>
Date:   Fri, 1 Dec 2023 16:40:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V7 2/3] pinctrl: Add support pin control for UP board
 CPLD/FPGA
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     lee@kernel.org, linus.walleij@linaro.org, pavel@ucw.cz,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, jack.chang@yunjingtech.com,
        noah.hung@yunjingtech.com
References: <20231031015119.29756-1-larry.lai@yunjingtech.com>
 <20231031015119.29756-3-larry.lai@yunjingtech.com>
 <ZVOBz8-tahhrVmO-@smile.fi.intel.com>
From:   larry <larry.lai@yunjingtech.com>
In-Reply-To: <ZVOBz8-tahhrVmO-@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:404:42::30) To SEYPR06MB6507.apcprd06.prod.outlook.com
 (2603:1096:101:177::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB6507:EE_|PSAPR06MB4517:EE_
X-MS-Office365-Filtering-Correlation-Id: 39ef334a-586b-47f8-522e-08dbf2493f24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nh+s/PFcARtG9IX/R3ZHVeVudOLpd9PqUiDMEfxGCOlH6F6itugE9M+O7yrE8e7Np0UgFi6WCj3GPzJjegopJTLw3DUsF4Y756z3WHl12IVrdyTEaFVShWEYLywNUQfyjMjLZZHzuaSgUFpwycqsbAcYOu309hxTStus+9gbDWl0h6b9/h99ORbmT0AwKGf4T43OGOyyvsqLWXO75UvSIFOAhP8sv3e1UmnHDsyOrhIESmCsBBhtsLNiJwZBMp14/NZiXnWFdjVDWwxW7sZf4SppzRMZksSOnsALaYcLqIRH9dJBVS/8qnOR2XwXlGjDFf862f7OuXAjZBY1D68dNY5aDVrTv6EyMBp/1UyNrcBQJpecCup5bKwPbQsDt4wIjAVKluB71Mc6Cs4mIFHD85sVWuHHQF6LE8cPmtvBItq0oIpIaaKJqOoERGkHAVsBjR14rmlKEtJZHx9XZv2PeZ3sPtCPm/NqntLH0NPa63oPBQA7q8l6DuAjTuYKHw4naa/fEQiM7jLetlkuLfG9aLpgVkjJLK2lN+Nc0f7+TDc1o0ziSV7762shopOtYh4xqCGefsLbI30zVmG+KyTWfKdZcQQjzKmBtlO3qxcquw9vBbFCSxpwZsh/GeiR+Obwj4KNqKAujdaGlVe0JOkK1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB6507.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39830400003)(396003)(376002)(136003)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(31686004)(5660300002)(86362001)(2906002)(6512007)(53546011)(83380400001)(38100700002)(6506007)(107886003)(6666004)(2616005)(26005)(478600001)(6486002)(36756003)(41300700001)(66476007)(66556008)(66946007)(4326008)(316002)(8676002)(6916009)(8936002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUZUajFzSk1HMEJCL2tKV3RtWHorZExFOTVMM0dUSGlqVjRNVGovdHFGbTZM?=
 =?utf-8?B?bXZ0QzA1QmpUREt6VXd1VmhMSnVrUXR2ckZYZXdQd3hCY2NybEVVbDFKZWJl?=
 =?utf-8?B?aDBVRmVzMCtqRS9adk9Fcys4ZFJaMVJuRGluZ0pma3llbnNKcGZIa3ZKb3Vk?=
 =?utf-8?B?SC9kWFZFSmxwQlNkTzdtWk92TkpydXRFd1Rra09zcVJCZ2RFanJISTdCc1BM?=
 =?utf-8?B?VkpGdDhXbjQ2RG5MM1RSdzRPeUE5OHg2Z1ZqMkNvM25UYXFSUDFsZkZ5VFVi?=
 =?utf-8?B?OUtlN1RnaGZJODljU1ZzeVROckJTMm95b3FoOEtnYTBVblpUUWtxNXRqaDQw?=
 =?utf-8?B?VmpyaVFucFNuemZ5UWZLNGllT09mVklyLzdOQ05tS08yaDBVWDV5UXNSaHEr?=
 =?utf-8?B?THk2NFVCOFUvcFB1d0lrZGN3Z1h2RjJIYTBaaHhLd2gvS05HbXZNUUFuRStq?=
 =?utf-8?B?NWZsSTQ5M3pEMW5MVWpYc2NuWjhvemVjTklSRDFFMzc0T0J0QzFVTGtUbUJH?=
 =?utf-8?B?STZkUWFsZHpTQ1Q5VDkvdUJTSGluUktlbkpud01jZzREQk5WK1ZnUkZSbXBo?=
 =?utf-8?B?OFlZUlBka3ROaGhBWlB2bU4wTFM2WUtic1FKZG9LTWtnekJEWXIxQWk0bDRU?=
 =?utf-8?B?QzZpR2JBUUx4d2JjcUlrOFVYTDdKalFrblFZMXpFVWJod1kyRlg5ZzVXNW16?=
 =?utf-8?B?b3EzQVB0ZTlJSlhoL3JoWEZqL3JWOEdWTU1tcytkMU5GbWRzcFgzNzlGMlln?=
 =?utf-8?B?UTYyTDJBYzN3REtLOWJYMDFqdTZTK2NiNlFQNjUzbGc0ZlZ3VE5DVm9kSFhr?=
 =?utf-8?B?S2FvNm1icHVSNFdGUGNDK1hUcHdJdEdJdE5Lc2ZwUmcrekxsV2d2TnhkWC9h?=
 =?utf-8?B?OEdEdGJGNFBJMkh3cFNWS0Zxdk5OMWVFZTE3LzZnZXM3VHJaNW1UYzhCcHNa?=
 =?utf-8?B?UG1jUUduaTlxOHFCcjI2S2VzK2VXYjFjWEd2YWhCTEw0OVpUeGlESW1WT2NV?=
 =?utf-8?B?MVlYMWxpUjNBMk9VTDN3c1F5V3M4T25UbVF2bVd1ckpxVjExWkpQQjJ0ZHo3?=
 =?utf-8?B?VTlMdmJ0bDBUTmhVbHE1dWJSemRtU2pWQVVEZ20zQWNCTTZaUDdGSHlLZzdQ?=
 =?utf-8?B?eXlpK0Q1cC9QY1VwQXlHdmQ0VUxUVDBscENLdzBHR0JGNlRjdmFnOTZXU1FJ?=
 =?utf-8?B?czFYeXZFUFVMV3h4WWlaRDI0VVZBdkRHaHdadlBlWFVsVy9qZ3RWUU1YWTZ4?=
 =?utf-8?B?eDZCM1NiOXZWaWV5dllDZXB1cTgzaVNtME1tQ1dSQTMycmxmTzNuUmVjVkl3?=
 =?utf-8?B?dW5SQ2FGcC8rb3ZxbHZKTWwyQXR4RjdNL2JUbDk2dmJVZHZ3alZXQUVycmZH?=
 =?utf-8?B?Y1h3dU1ncCtScVJzeFZIMEkyOUlPcjgxVktMeTMzTWFKVDk0TmpuNVFVd1lM?=
 =?utf-8?B?QllLM2tKMklucFVoVTgwenFiQm5xMEVKa09pUllVeXpHYmxPRm5ReEx6ZUVL?=
 =?utf-8?B?T05rQmpFWUFnOGkvWDlEcjAvOFUzeFpwcUxma2ZodTJobFZ5WVVIaGtpMGMr?=
 =?utf-8?B?Q3lYdHJvbXcyRWx1MUpmazV0SmVoYVd4dnE1M08wTnU4b1d3Q0pWNkpBZUtY?=
 =?utf-8?B?OE5pQlFmbnV1dzhWUkl1b1gwbGhkckpvUlJMZjc4REI3WGpOSkhlWjU5OVZ4?=
 =?utf-8?B?aHVhOFc4VU5BR0dSd0RHS2k4bWxHVnhxWWIxbFpiNmtsdHpSNHZlU3pnSHpr?=
 =?utf-8?B?QUtvL3AxeDVvckwrYkk1OFB2cmZIeWllQnBEbThJRkE3R3R0K3dyc2dITzBp?=
 =?utf-8?B?TUtWRVdSMzdXWFNweHo3aGNaYk9WUXluWUM2NXBVVmNYWmZndTQzbVFydWZB?=
 =?utf-8?B?WXBpQ3RoL0dPQ2FYdUtGSi9TOXV5d1ZHeDQrU0NNSkQxTjRvZkt3SjhyNU56?=
 =?utf-8?B?QnF6SnkxTXlQTVkzSXlpVnpNc1NMVkJNWDUvTEp4NmRJdVpDTzN5VzZ2RDRG?=
 =?utf-8?B?SmhmY09ieDkzSVFnN1Btdy9RNFpiUzNua04xQ09jbTJkcitPSG1MMTIwTWZH?=
 =?utf-8?B?VnViRWxiQTZQYzNRZEFqSS9Va0VVNzVGOE5YSmZxMW1QSDQrMFJ2a2Q2MCto?=
 =?utf-8?B?S3RUdzI2dWRBSEFWeGRzdmtiVllRaHA2V2NuSEMzSk9yOEFsMmJZN01xS1dU?=
 =?utf-8?B?U0E9PQ==?=
X-OriginatorOrg: yunjingtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ef334a-586b-47f8-522e-08dbf2493f24
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6507.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 08:41:01.0385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: be2d5505-f7e6-4600-bbe2-b3201c91b344
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zBsi9UUAJoXFqVJWasxS2EkszlFLswdKK03I7X3WKdAostyqdLyuGhfrvi1PKQ/CZyx/1wIzeq64yrY3jTKgPdVBupmookACc/QC6RwlM94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4517
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,
   Sorry, replied Gary's mail again for plain text format & mail client
as Jones's suggestion.

On 14/11/2023 22:18, Andy Shevchenko wrote:
> On Tue, Oct 31, 2023 at 09:51:18AM +0800, larry.lai wrote:
>> The UP Squared board <http://www.upboard.com> implements certain
>> features (pin control) through an on-board FPGA.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Gary Wang <garywang@aaeon.com.tw>
>> Signed-off-by: larry.lai <larry.lai@yunjingtech.com>
> 
> Same comments as per previous patch.
> 
> ...
> 
>> +	help
>> +	  Pin controller for the FPGA GPIO lines on UP boards. Due to the
>> +	  hardware layout, these are meant to be controlled in tandem with their
>> +	  corresponding Intel SoC GPIOs.
> 
> + blank line here.
> 
>> +	  To compile this driver as a module, choose M here: the module
>> +	  will be called pinctrl-upboard.
> 
> ...
> 
>> + * UP Board HAT pin controller driver
>> + * remapping native pin to RPI pin and set CPLD pin dir
> 
> Same comment to all the comments as per previous patch.
> 
> ...
> 
> + Missing bits.h, types.h and maybe others.
> 
>> +#include <linux/dmi.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/gpio/driver.h>
> 
>> +#include <linux/kernel.h>
> 
> array_size.h ?

will remove.

> 
>> +#include <linux/mfd/upboard-fpga.h>
>> +#include <linux/module.h>
> 
>> +#include <linux/pinctrl/pinctrl.h>
>> +#include <linux/pinctrl/pinmux.h>
> 
> Move this...
> 
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/seq_file.h>
>> +#include <linux/string.h>
> 
> ...here to be a group of pinctrl headers.

will do.

> 
> 
>> +#include "core.h"
> 
> ...
> 
> 
>> +#include "intel/pinctrl-intel.h"
> 
> I do not think it's correct use of the header.

see below with pad regs define.

> 
> ...
> 
>> +/* for older kernel lost DIRECTION_IN/OUT definition */
>> +#ifndef GPIO_LINE_DIRECTION_IN
>> +#define GPIO_LINE_DIRECTION_IN		1
>> +#define GPIO_LINE_DIRECTION_OUT		0
>> +#endif
> 
> Are you submitting this to older kernel here? No. Then why this?

used in our dkms driver, will remove for upstream.

> 
> ...
> 
>> +/* Offset from regs */
>> +#define REVID						0x000
>> +#define REVID_SHIFT					16
>> +#define REVID_MASK					GENMASK(31, 16)
>> +#define PADBAR						0x00c
>> +
>> +/* Offset from pad_regs */
>> +#define PADCFG0						0x000
>> +#define PADCFG0_RXEVCFG_SHIFT		25
>> +#define PADCFG0_RXEVCFG_MASK		GENMASK(26, 25)
>> +#define PADCFG0_RXEVCFG_LEVEL		0
>> +#define PADCFG0_RXEVCFG_EDGE		1
>> +#define PADCFG0_RXEVCFG_DISABLED	2
>> +#define PADCFG0_RXEVCFG_EDGE_BOTH	3
>> +#define PADCFG0_PREGFRXSEL			BIT(24)
>> +#define PADCFG0_RXINV				BIT(23)
>> +#define PADCFG0_GPIROUTIOXAPIC		BIT(20)
>> +#define PADCFG0_GPIROUTSCI			BIT(19)
>> +#define PADCFG0_GPIROUTSMI			BIT(18)
>> +#define PADCFG0_GPIROUTNMI			BIT(17)
>> +#define PADCFG0_PMODE_SHIFT			10
>> +#define PADCFG0_PMODE_MASK			GENMASK(13, 10)
>> +#define PADCFG0_PMODE_GPIO			0
>> +#define PADCFG0_GPIORXDIS			BIT(9)
>> +#define PADCFG0_GPIOTXDIS			BIT(8)
>> +#define PADCFG0_GPIORXSTATE			BIT(1)
>> +#define PADCFG0_GPIOTXSTATE			BIT(0)
>> +
>> +#define PADCFG1						0x004
>> +#define PADCFG1_TERM_UP				BIT(13)
>> +#define PADCFG1_TERM_SHIFT			10
>> +#define PADCFG1_TERM_MASK			GENMASK(12, 10)
>> +#define PADCFG1_TERM_20K			BIT(2)
>> +#define PADCFG1_TERM_5K				BIT(1)
>> +#define PADCFG1_TERM_1K				BIT(0)
>> +#define PADCFG1_TERM_833			(BIT(1) | BIT(0))
>> +
>> +#define PADCFG2						0x008
>> +#define PADCFG2_DEBEN				BIT(0)
>> +#define PADCFG2_DEBOUNCE_SHIFT		1
>> +#define PADCFG2_DEBOUNCE_MASK		GENMASK(4, 1)
>> +
>> +#define DEBOUNCE_PERIOD_NSEC		31250
>> +
>> +/* Additional features supported by the hardware */
>> +#define PINCTRL_FEATURE_DEBOUNCE	BIT(0)
>> +#define PINCTRL_FEATURE_1K_PD		BIT(1)
> 
> Huh?! No way it should be here in _any_ form!

will remove, but we need set pad mode at runtime for HAP pins GPIO,
it's not a good way but get register offset from intel_pinctrl structure
can reduce data for each boards.

> 
> ...
> 
> I'm done with review as design wise this one is broken. Please, redesign and
> reimplement. Also split this per platform addition (as suggested for MFD),
> it will be easier to review.

will try to modify as your suggestion.

>
Best Regards,
Larry

