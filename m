Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133267761D6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjHIN5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjHIN5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:57:19 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D4998;
        Wed,  9 Aug 2023 06:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1691589438;
  x=1723125438;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pGhoi9CnrUQDz4w7zPHrJrIA8Tm/XClaj+RjQPMV0tE=;
  b=MjGF2ey474AFfQOv7LKTP7tvc1eCgdt2E2RDfEeIXn7NOWCTIb6NSjUd
   c3bBJYuLpByKEekIo3JwzCXYBAaQd88Qn5RNjRhWmIrxTr3OiRWYvPq3F
   EZVYWdZ2l+hSqTHFFjEYwVEwOKsGX4pfIua/8G1EP5HwC3iBD2uwIUCiC
   Kq+Mh7UvnLLi6n9YAWrng47OQZOoA3n3e39SN1atVtmUVGqf5SvwSWFY0
   ZJvfy84v85eUMXWwzMfSIzVdL4fP7wp6zWiwwNJcnf+CEVdjxumU8Os20
   i4mYHTVtPaJb404+0XCO8xDML3r3kRJbWGgEQLXUzdxTeYn6glRafyBT/
   g==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bP042yidy7wfbu+NXcK5kBZWKv64DhBIu+8I7+FJfYh4ep4mFB7Y4cB6LWBHlOgNS1wlw2ZbixV44Qwbraf5djJUrmYXVn2tm2dnaiW/I/SsHvvwSjwONgdy62NAOrgWLTPMZa99R714SYqwtwdjSnUNAe/SvFGqdr2TiS9snqnawI1JUjqmWEGmlHMg4OEyRuBjBJlaPaxLRCv5g4zwBs2AigXHMQSgNIIlcsygK7dNacHOIeDFyLfnaaM9eYYkB9u/WM3QQtueiKp5JUYGXpRxIThGc17DfhhOaXS+PbQ8ORr5Ja7QWYmg52GwOjArepEeGU9cRPoL+W9jsYadpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGhoi9CnrUQDz4w7zPHrJrIA8Tm/XClaj+RjQPMV0tE=;
 b=giNvYqM7Tqs9qd0z8kwHQJ6TdPFMl2QyEMezOI0G/d4RXrETo+EjlnWIGgPtXPZVm5PTB7ChDgk7jz/CQurcQjANyM5I9xggYWVRu5WDyCeYYlnyPJC8Gqh7VEJiWW2AP5fQpZAu1bSgYhXukydR32QYRMnWm6C+25hPqDChkIio5fYTqVMY6PUqqpZA9aV6cK5nwX8Bx5wi63ddvaleE7QS9oesrSIZtlrW8u3i8YsmXzilEXQUmsFXb0d/w9fli0SUxjZw1rcDG1BNPK0TUwPGQSe/2wiz73n3CqHkm6uOjEuDGV70BcmKSj8lXaCyYVdNMkcrgt7sXcxGX0cMog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGhoi9CnrUQDz4w7zPHrJrIA8Tm/XClaj+RjQPMV0tE=;
 b=O7/wtqKML6ZpY5Cpg//F8IITEtCmijCu4R+z7jIlioNbdFYye+i+TqXVyJRojGyHdXLla0Amwj0a66v4HMLLTtcr1Syn/AV06yjd+LXXuzrratB9gxYEZ+iZvMoP/jUfYmcG41J2c0eVO5mTyVMdnSPdA5ovpJEnKUFN7CIO4os=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <47611b1a-8cea-acba-dbc3-bbbba9470d34@axis.com>
Date:   Wed, 9 Aug 2023 15:57:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] tty: serial: samsung: Set missing PM ops for hibernation
 support
Content-Language: en-GB
To:     Andi Shyti <andi.shyti@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>
References: <20230803-samsung_tty_pm_ops-v1-1-1ea7be72194d@axis.com>
 <20230805213824.ol7sr3b52rwrsfs6@intel.intel>
 <1dbc24c4-b057-0e71-432a-a7d0ce2df2dc@axis.com>
 <20230807213452.aev2ubalxvydmxjv@intel.intel>
From:   Anton Eliasson <anton.eliasson@axis.com>
In-Reply-To: <20230807213452.aev2ubalxvydmxjv@intel.intel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0040.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::11) To AS1PR02MB10348.eurprd02.prod.outlook.com
 (2603:10a6:20b:473::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR02MB10348:EE_|GV2PR02MB9638:EE_
X-MS-Office365-Filtering-Correlation-Id: f32e4116-ad64-47bb-4879-08db98e08676
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n98+fFm8y3BlR51CvNWVV19MFxiFKTJ6/+oK3VWm0ZS9+aIY13KZH/TxNyvdV+waFbyiXafgVDOfgF0xU+/UWd4QHm0NWm11eR/jLaZCXOUvL/fEEP8icQgdYTQ/nKyKCYsfl8uZwXevv/W77IJATQVJ0BBI1pI3SOD9V0YXIPjDeGbYvYOfcfo4r67HHdbh4jIuIZXycW3ruu3OTiZ3QXGbD7+64OYzGe6tGMN7ipHoXPClxYh8EMh6U9XYG2FI95Szu/3ft2j4c4wNxm3v9Dt6ILQ3b3a14pRf7DkL1iKj02Rb1p0zgDivr6W59jseqZZ4ZsLZ0Tw8om8yppqP0wpBhrQE9HmRdQTJMfKLG7C/OY/Wg0sHk9Ef+3VeWPJQKiRVXBWMSiQhb9fVzXMRpZQH5fB4D0r6tpKUqf2K2gS0kgLLJVaX5Lo3rVRsuYruVUjx7wL7p7o2X5AEy5e81i2nMuKb0QzAXQjPkvq1WSJKWKUT9nRfFacoQKkxDGlGI35V1wXLuytOprBDwcpOZKcXuAm/VIopp0iO98JtTAsAyb7eAsdmVcO/cLVDe/FIFgfqyDEhVi3gEY6MhEoEDKGTJZ3L1JnLh1ZVzIHAp5QTpn/lwi2muw0J1ZppjhTF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR02MB10348.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199021)(1800799006)(186006)(316002)(6916009)(4326008)(83380400001)(41300700001)(54906003)(966005)(6512007)(478600001)(6486002)(2616005)(66946007)(66556008)(66476007)(6506007)(26005)(107886003)(2906002)(36756003)(31696002)(86362001)(5660300002)(38100700002)(8936002)(8676002)(44832011)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVNFVmoyK1h2cS85NnliYnNROXRRK0c3SnBlQW1sSGdXYzA3aHcvc0Z5VE9j?=
 =?utf-8?B?OXFuVWFzSE5kQWNPQW80VisrN0FTU1FRS0N3TlRrdU1zVXdkblVPZTIrYVUy?=
 =?utf-8?B?bUo4Z0VCV0R4VHdEY054SXdUalJpS2E1THNzdkpqaDcycWIrdkNTaTF3V25m?=
 =?utf-8?B?N3hLU0NiTUZhU0tudmowQURtSUQ4VHI0QjVSd1J6aXdpekszZVAxczZGT1Qy?=
 =?utf-8?B?bkZrWDVFZHk0MmFTV0FoaEY3M1lwMDlabzk3ZUphM29nUW8vVWNuSzFJbU5C?=
 =?utf-8?B?Mi8zVy9zeGIrVzE0RTJ2bVgyS05HNUVkMGxYMDNjVkRVY1hyMTdqcUx5WEll?=
 =?utf-8?B?MzhKOHAySkZDOEM1U1ZaRTlFK3JuVHpoZ0xOb3pNSG1sWjlKN0ZVWlFxOEhJ?=
 =?utf-8?B?YmM4b1NqQWFvRHVQekhSZ2oxb3czcjd6aWdjWDFxMG5pcU9BWDVLMG9zQjNl?=
 =?utf-8?B?ak9yUXhWZkRnT0N1eDhWTlpyNVNscUVYZFpDVlVWczJUYk9za0J2UE1kQk5J?=
 =?utf-8?B?OEIwRTRwU21nUmwvVEM2Q0c3YmxoM2VPRVJLd1JHOG0wWDRrOGlPRzFCMmJN?=
 =?utf-8?B?VW1UMmF4Q3lkMEVnWEN5NWhqUktIV09BTjZvZWxOa0EzazQyVXNQRVdqTUV1?=
 =?utf-8?B?b2JpRTZTTHp5dWdpN2NLMGlPNG5SZTQ4ODN6dHlmV0FKbVRJZy9XNG14cWgx?=
 =?utf-8?B?NkdRL1NvOXhVVHpvYkU5NG9jR2NkTUwzc2VQbU9NUjQyMnpDbVQ1djkvaHp2?=
 =?utf-8?B?TXNJWVFWMytlMjhYZWZVczlZeXEvRDYwc1FPTytiWHQycGNDdzg2MmsrcVhk?=
 =?utf-8?B?WXkyNzJJM285a0RIelF5K0k0ZWFUNUpJWTRDVVlqdU9tYmMyUTNKVUJQN2do?=
 =?utf-8?B?V2swZzVWT3BLR1h0bjB0UEFpK2hPR2c4anVXZWtBdTk1aVBSQzZmcGZQc0JQ?=
 =?utf-8?B?UU1TY0o3MWlFL0tmMDdoRlpoWDE1Yy85ck5BUExoRTlKMFZ4Rjkzbk5mT2ls?=
 =?utf-8?B?eFBxajljb1NTUlRSQ1ZBdzVGYlRPbmZzUThrSUpBc0w1N1Zjam9qeFlsYytU?=
 =?utf-8?B?RFdDcGhWTk5YdXMzQmJSUnZyaDVkZGhUdFYxUEQ0aGNSZk52ZTFveFlqWkxt?=
 =?utf-8?B?STRBd3ZDSVdWV3VtQUx3aHBlZ2tKN1dvb1B1WUZZbFMxZUJKQVV6MlhCZnQx?=
 =?utf-8?B?MnRTZ1U0OUxiSHJVZjJHc2g2dUIwN1d2SWlYZXFtOVcwODZDVTJsTWkrTnBD?=
 =?utf-8?B?UGxBTVZFUXU4UlVCUGtyajJqT3N0bzA1WXlLOTRyR1JSNXM5dk1XZmJMZjgz?=
 =?utf-8?B?MWU0a3d3cUtQeXBzYlBQbGxRMlFxblFXMm5UY2tOWllIYmEzL3ZWaVFOTzFB?=
 =?utf-8?B?bFh3TjVrVC9pNlNjT1IxWDdIS1FhcG1Ib25Wcmg5SG9rSCtTSnRHUWd5cEZu?=
 =?utf-8?B?NDEvcHJjMVVpVHR4OWhPUzRmYnFUMlNERkNKRFdZM1praFhUdlNxWXlxQkxG?=
 =?utf-8?B?UDJFRzRoTkxUUDc4Z0xyc2FLSERCOWRNbXI4NWZHc0VZaXlXbXNWSWlJVkNV?=
 =?utf-8?B?Vytlc2xSTFJCaUZ1em9FNjMwd09HZjJVejAxZUd1b1laNlo5Y0F6Y0cyc2pC?=
 =?utf-8?B?emhQN3lTR3k4bzNJSC9HaGROQmFNL2oyNlQ4dkVDTlpEZjlaNVRnU2dCdkJm?=
 =?utf-8?B?ZVRFU0hQc1BWeVFaQlJ3ZGdnT0RKSzFVT0ZTdHdpeWFPR2taVDFuKzlDK1pt?=
 =?utf-8?B?ZmdtQnMzU1lhcGJGbnBMVytkdVgreXVrVkd3cnRUc240aWxnOUdiUDU2YThr?=
 =?utf-8?B?WHNKMFNqd3VPYWZPK2U4YVgzUURqdFJmY0ZIZXgrazhzNjA4cFJwOVRIV1l6?=
 =?utf-8?B?MHdXSDlpOW90aXNLMzQ1WStkZk9TUlVKdFdUS0tmYW9sbS8rbnZqZnRxRnFj?=
 =?utf-8?B?anpDQ0ZhdllQMHNOSk4rRkF5bXhOeUVETkViUmh3THRLRnZyYy9wVXVOTzVT?=
 =?utf-8?B?b2twSjVqSFYydXpxeXplaHFaRGwySHZhRDllaVIwNDhMZFIxa0FWRitVbmx4?=
 =?utf-8?B?OUw2Y0ZGK2tvQXNQTFpNVTdxaW9POGtoTEZIK2d4RlU3djVBMG5TRHB6a1A0?=
 =?utf-8?Q?5VXU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f32e4116-ad64-47bb-4879-08db98e08676
X-MS-Exchange-CrossTenant-AuthSource: AS1PR02MB10348.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 13:57:10.0829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IJimeNqoNIvQvHSWHwjjOAqoRJ6hFG80hOZSb6OtdE84IcqgcOjHedbtYo6pCkW5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB9638
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2023 23.34, Andi Shyti wrote:
> Hi Anton,
>
> On Mon, Aug 07, 2023 at 11:57:04AM +0200, Anton Eliasson wrote:
>> On 05/08/2023 23.38, Andi Shyti wrote:
>>> Hi Anton,
>>>
>>> On Thu, Aug 03, 2023 at 01:26:42PM +0200, Anton Eliasson wrote:
>>>> At least freeze, restore and thaw need to be set in order for the driver
>>>> to support system hibernation. The existing suspend/resume functions can
>>>> be reused since those functions don't touch the device's power state or
>>>> wakeup capability. Use the helper macros SET_SYSTEM_SLEEP_PM_OPS and
>>>> SET_NOIRQ_SYSTEM_SLEEP_PM_OPS for symmetry with similar drivers.
>>> and why do we need hibernation in this device?
>>>
>>> Andi
>> Hi!
>>
>> I wanted to test whether hibernation is possible on our SoC, even though it
>> is not a common feature on embedded ARM systems. This is the only mainline
>> driver that I found that needed modification, for my proof-of-concept
>> anyway, and I couldn't see any harm in the change.
> Thanks, makes sense, mine was just curiosity, can I know which
> SoC you are testing that is using the samsung serial device?
>
> You can add my r-b, anyway:
>
> Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
>
> Thanks,
> Andi

It's the Axis Communications ARTPEC-8, an SoC for surveillance cameras: 
https://www.axis.com/solutions/system-on-chip

Thanks for the review!

Anton Eliasson

