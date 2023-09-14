Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280E079FCA6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 09:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbjINHCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 03:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235836AbjINHCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 03:02:19 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2093.outbound.protection.outlook.com [40.107.117.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29611BEA;
        Thu, 14 Sep 2023 00:01:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0CeFKcOQkJwYvGYN1fw2GMxHUL5dHsORL2X876QjOrfN2mtXRUsRLEmUDvaucl69POhL0ZGIBfxlSDzGPj8WAvyxXrUz8QWmlYaz+Nhdni5PPhirT1GuOJtzaCDoO46QcR2wuWJchBsO9zQ3vdRfOfw7fGe6/mAuymmYAsZ0m2UZzGMuv7xYrXDbi/0O/YD15tUutPAySatb+6P1jbJwsNQaXk/flFcuaCGPSTYgrTxFRfj8ndlwHjajgII5Ukn0epYgp+IPYVmgTVfbC4EtGLnYVFFU9ino6UxY9Fy/ESTngTmNJ6fX940NXgMm0zEMb5ogRk5JqA27WvyhggJBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWfFvILeu1l3+OvStnvOaR/sfZGwF6KXqSHdM018NYE=;
 b=GHwVj12eguTqHLD4qZhp/QFn0Yqv/u7z82neQdGPFrzYUhz1R8/TwDB2eBV36PA7bSxx5EpAunoGMdkxtzhskjIM1SD2/yQQHXgMpeuWL+HxGKluFXrtgjHj2LfZaBIJB115gOKSZ1n2kDeQypSRMPMmhksP/2a1Pp9E5n46LOBYvjyWqlFq7YrBrP1Xaeb+IOT0p+VWzTCEAoIDd52ZA/1jVIcz3p2i2JQ+14BLmw/fYw4J1a3kPfOvvEu+ql2W0qgUG6FARtkEq20Ie0kHBhE5fOm9+1nECzB8DTdoU5GsBhc+Z07aywcpo8Pxq0TfqrasOXybdzVElwP2ezalOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWfFvILeu1l3+OvStnvOaR/sfZGwF6KXqSHdM018NYE=;
 b=Z3WoKJ331EXE+JOq1CymX9u9/udOT/kVrVyz/WGQOD8maLUglYajY9U7D7fShsggJPkNvUHmCqJYgCOe0TFxnhYm3fdPfnLguuJP4r1if9KroCeCORz9oo3bLY4upVS+QcWDBbm4T4FDlHXoGDDT2po3hbskTzwhrD7RhxshCVHo09OeWnyvqiw+GXLHv5Mm2FrvtY2ABGWGZ+wpAXSz4yClGMdflmOcGTkP33kK/LN5EPua9N1T/2XUXNy/Q48udhYWUzKK7RZoXZdhXwledH71wT1qhTYLnrkbwoeCJTZK8SD3gDHrL/wyXk/N89BkznBofgMYdU1OpDb+vnDQWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB7221.apcprd03.prod.outlook.com (2603:1096:820:cb::11)
 by TYZPR03MB5295.apcprd03.prod.outlook.com (2603:1096:400:34::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 07:01:31 +0000
Received: from KL1PR03MB7221.apcprd03.prod.outlook.com
 ([fe80::3f14:c67:12ac:af39]) by KL1PR03MB7221.apcprd03.prod.outlook.com
 ([fe80::3f14:c67:12ac:af39%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 07:01:19 +0000
Message-ID: <cde944c4-acfe-b3fb-32b8-072740475e35@amlogic.com>
Date:   Thu, 14 Sep 2023 15:00:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/3] dt-bindings: pinctrl: Add compatibles for Amlogic T7
 SoCs
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        brgl@bgdev.pl, andy@kernel.org
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230914054525.1180595-1-huqiang.qin@amlogic.com>
 <20230914054525.1180595-2-huqiang.qin@amlogic.com>
 <45637012-0972-fc7b-1276-163da363b962@linaro.org>
From:   Huqiang Qin <huqiang.qin@amlogic.com>
In-Reply-To: <45637012-0972-fc7b-1276-163da363b962@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYWPR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::7) To KL1PR03MB7221.apcprd03.prod.outlook.com
 (2603:1096:820:cb::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB7221:EE_|TYZPR03MB5295:EE_
X-MS-Office365-Filtering-Correlation-Id: 58bf06da-03ca-4de7-339e-08dbb4f0649c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0QNiWsaCNzYNA+7iYXVGyYp9ZIRUKyku/bdFYvexkHHmaM70nfWFVnScYH6mTE5PGgF7mx7wcHN1nsWVuXURFEmc8O59Ul6VH8r3QdGD1keOVMPGHWJv1LZpCEvMdQlnQcSW0/NlLrwXyM4xwsT79MNvb8Ay+pm1qt4Qf6sJoiPNj8dJ6ed2SIdflVC6YTsiQwvK6adNveEVWScSuLsKUw2mGDJO0ywcSSMDY8k17+/lDu0UzPmN+GTWAWfGWHp7vxAxCOKs6fPy8YTZSCyuirY2qs63Ez9c/S4IOA82sH63EddJbqXXbu7Op6TL07PSq7z8opc0c0sNmtak1+rw49tpxRTJXXHzrewMDJQvfrKV7ydPd2jrZrQRXlzf15nDiXwmDovFzytj77/6YkkvQPybDNQtfjzUXhn2BiooO2M3i/8D1fn85ldgzpSZ5lyiVbbpqwvJnzoiGZOqzK67AbqJ9TR1qF9/m6toUPvrv3chI2GqIjuY1HUWtcZh+cj6K2pQdnfiQ1dLm2k3+kri1Ntquy4KnFDq1YUa3Ls1XMr6+6YPFvTI5DOjB+IZ1unljWz7ef2YVTlzFUfGfnzw3Ca7Hbva44XfH6hl79ulDQqE5p2FQ8/vAzUlEwa0GwldSsxXSjlCF3i3kqjJaBcp+TkF2JJwaW/vW3iH+qqI7y8eYnGjJitQP2u4DOw4046AKwD/5Fbm2cQN8AggwyvTEug5WQq0erXZZcPjYpM6GsYLU64890zpSewL7e7EogVc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7221.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(6029001)(346002)(136003)(396003)(39850400004)(376002)(366004)(1800799009)(451199024)(186009)(31686004)(921005)(38350700002)(478600001)(38100700002)(2616005)(6506007)(7416002)(26005)(6512007)(6486002)(6666004)(53546011)(52116002)(86362001)(2906002)(31696002)(4744005)(8676002)(4326008)(5660300002)(316002)(66946007)(66556008)(66476007)(8936002)(36756003)(41300700001)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHZTS1JGUHZLdmdUdDNjSDE5ckZrWmtjZ0lhQWNDR3lKU1ppWlQxeGlKY0ZR?=
 =?utf-8?B?NlgrWGlyZkFTOTl2SDBtR0Z1U2FZalViaXNOeEM2dnFtTG9wYWhubDVRNC93?=
 =?utf-8?B?amxubVljRnk2WU0xek16WDMxS2ZYNmFGdHpCei9KdXNYZWlVT0Q1dnRyU043?=
 =?utf-8?B?MW5UVU0ydm1UYnkxb1dMQXhYUVc0U0RlUEovb3N0c1QvNFlwSE8rRXlkL01q?=
 =?utf-8?B?UCtsc1MwOVowV1VtczBUdHlrV0RZL09IS1ozMGpweE9YUFhIYnlYdFFmNytU?=
 =?utf-8?B?a0JjaFduVVI1QjhHeEszSXVEUVpmMm45YUVQMEpHZnlQWkF3b2cvSS9YOGVG?=
 =?utf-8?B?WkxjYkpGMTU1YVd3bEFFbEcvdFA2NFdwMmZiMUlDWFBWZjRWWU9XbDhFYVpR?=
 =?utf-8?B?OEVSVURsV2Y2TW8wQWI1NTZvR1oybHVpaCsvOEI0SEJvWkVNS3RueVlvYXRK?=
 =?utf-8?B?b2Z3cUZ3OU1zRjRvd1E2clVKTjY4OHBWMjdvWk5zdnUyenVEVmhlTUpsR0RD?=
 =?utf-8?B?ek1vL2FNNGhwL2UzZzQ3MWVuZWhiait0eWJaR0lVSk93eGJQYS8yWXkraHlx?=
 =?utf-8?B?MnRTVGpJT2p0dFcyV1lmbHllR1VGVUkyUFNpdlhUSU5DYzdLL0ZIbE1sdGU2?=
 =?utf-8?B?cVlUd0dpVTdja3hHV2lpUHZJUzNwT1c3YjFIQ1F3WXdyUm9NbzVKL1UzeHM2?=
 =?utf-8?B?UFNmbUltQUZucnpvVDBIa1RsY2pOdGlqMDY4MCtpdTRDSzRwcEZPSDdVa0lZ?=
 =?utf-8?B?cjVVWmY4TTBIYk5OK1RrSWlzZEMrV203bGZZOWlNN2FIUStNbUZLVkFkZ1E2?=
 =?utf-8?B?SHlJcTMvTC9rcThNRllCNnZ1T0JqalZxV3RVZWM4OWc0elVxL0ZRa29JZ0hr?=
 =?utf-8?B?K3NDcTBxZVcxM2pKaE1JYUxpV2tpeHgrOGIwaXRDRjRvWWw3RjJ4RlM3TzRO?=
 =?utf-8?B?OFBtdmZHb0RUYTJObFRkeC9QRTArWTQvQm9VZEovRkRXZWdxYm9GWSs4MDVy?=
 =?utf-8?B?OVF2U2p3R0QwS1RpcmQvSFZKMWQ2T2xsWXRsZzI1OUxWeGNDU1UxdFJLVVF0?=
 =?utf-8?B?WkRnYStCMUZuT3kyM2JtMk5zOCszQ1pwbGNPUEt0djlsRWQ5MXJIak1Oajho?=
 =?utf-8?B?NTA0bE1Ya05mMUZucUpWY0Q1ek9DMXgwLzV5V3hoKzk2eThCaWJpcHNkaHB6?=
 =?utf-8?B?WngraXRndGVHaEV0WWRQZ1dTV3lwMVU1bzdYNHV2WW1IVzdTT1F4QzBTZVRQ?=
 =?utf-8?B?UGV5M3FiWTU0MFc2YW1XdHIxV2ZDUmgyQWI1d29EeXp5emlJNFZJdTFqbFJ4?=
 =?utf-8?B?OWNFZWlYbE9iVWNSL3F0ZmlWUXU2a2JYZjkvQVhqaWM0RnpkUFZkYktMZ2tB?=
 =?utf-8?B?UncvOXJlVFBRL0o2RFN0WDVhUnRMenk3UWxsNGp0M2NkZ3NvdktBR2dKbTJy?=
 =?utf-8?B?SEVVcGVwclBiZGcwYlowd01vUlJPMmx5SmJwR25wd3p3OXdEOXhhQWFicksy?=
 =?utf-8?B?TllVeHVCM0tNMms3RnRuQ20vVSsveXB6VkIxSWttMU9FTjBvcFJXTEJwODF0?=
 =?utf-8?B?RFpEaDFTKzRUNHo5QUdlemhldTltNzZvVWhPVWdTdFlBWWR6NkN6bnlkWFds?=
 =?utf-8?B?L05pT3U0UmdpNjBlZklhYTEwVHk4cU1vUkhodFplZVd1dUw1MFN0UUZvd1ZV?=
 =?utf-8?B?RVU4TEkrM0RYTXlKMGNSNTFRQXhjZUxPdVNJakhXNjI4dFEyREhGd3VSOWU5?=
 =?utf-8?B?Y2NIWjVtVTAvMUMzeGcvN3FmWEtkWXk3RWlzQytmdm45RHc5ZjEzQ2hLVGxa?=
 =?utf-8?B?aEQ3NEFKRnJwdTVMMlM3L3NrZTdVV0tDTzViYy92M0ovUUU2ZUVpRGhIdC9K?=
 =?utf-8?B?aW1UWXlucEMxVk85NWp5bG5MZk5TS2EyTVlDTHRlampxdWxta0ZiVWRpSEp1?=
 =?utf-8?B?aUZiSUVlWWwzWmtBcFNrbm5xTFN2b3duU3FKWXBUVFkwMGZaR25FWHdrbHVn?=
 =?utf-8?B?bHIyaTkzV09Ca2Y3ZUlyY0pNL25iRzd6d1R3Vk1jYitVTy9TQnlJUS81bVd0?=
 =?utf-8?B?WVExcVR4RUFheXcxbmJwQm1ZMHhQekdEcENwd1lSQ211TFd2UlF2MjJQSHBv?=
 =?utf-8?B?L0k5YlNOV2wvUytxUUZSUG9ValZWb05uNEJQdTFYN2QwRTVYR3A5a3l6Y0t5?=
 =?utf-8?B?Ymc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58bf06da-03ca-4de7-339e-08dbb4f0649c
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 07:01:18.9562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLBY1AC9Pbr5xpVVLixxNJX6efRwzGfKRKrkfy8T06BOJ9FX3vCWxtLIEl167y+aoO/DbBrFb6rJXVy0IeJedw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5295
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2023/9/14 14:16, Krzysztof Kozlowski wrote:
...
>> diff --git a/include/dt-bindings/gpio/amlogic-t7-gpio.h b/include/dt-bindings/gpio/amlogic-t7-gpio.h
>> new file mode 100644
>> index 000000000000..2bab9a99501a
>> --- /dev/null
>> +++ b/include/dt-bindings/gpio/amlogic-t7-gpio.h
> 
> Use compatible syntax.

The amlogic-t7-gpio.h is not a file in the dt-bindings/pinctrl/ directory.
Does it also need to be named according to the compatible name of pinctrl?

> 
>> @@ -0,0 +1,179 @@
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
>> +/*
>> + * Copyright (c) 2023 Amlogic, Inc. All rights reserved.
>> + * Author: Huqiang Qin <huqiang.qin@amlogic.com>
>> + */
>> +
>> +#ifndef _DT_BINDINGS_AMLOGIC_T7_GPIO_H
>> +#define _DT_BINDINGS_AMLOGIC_T7_GPIO_H
>> +
>> +#define      GPIOB_0         0
> 
> Why weird indentation?

Okay, I didn't observe it, thanks for pointing it out.

...


Best regards,
Huqiang Qin
