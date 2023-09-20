Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4091B7A7A55
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 13:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbjITLYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 07:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234383AbjITLYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 07:24:41 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2033.outbound.protection.outlook.com [40.92.19.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6642A3;
        Wed, 20 Sep 2023 04:24:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EefV4i/Acs1YuierCZy9U8ufiXGmT+TceokHOrVhGhsvNa+Iho5KPXc/TXvjaBOKRKozcqolrtZAjNfTE2SFQJWdWIIVFJ1Edf9Zp+fmR/Vbg5m3WzeBv2+wn173egVWgghmbheVaHFDlRqF7d7m7SniKDV+LypumV0hFzhmHF//Em0wkZeYrkoKxZjIVyej0h4nhBgrpGH1StM4waMZXGA04VoHeX9ySaMgNlNdGuagqCx/hhyKSuMsVcjYKZ0iOcdvres+yNx9dCGg8rd+RT0tPuwjA4CXuZt/BhEPlvOs3FP7WS0vpVyKwNx4mEwEBJ7zB2ntjT7kFAzY9LAk/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6ZJdLxR1H7mp9DO6da84uSOMx4PBILUVb91fxC0wcs=;
 b=MYR8oGD5iSxn7k5nVh/qqF0fxOyPMvt2eVx0qSKg55ERwl90UlNAZq4nsZWr17T8onGralllOb3tmLl2uKdO7zP6Hv8uGfkaeckGJulmkqbJMBWRKFJ8Fu69fFoi34SVNl1XcYa7dGqZURTJTWXZQDaV/qJbY77kEYKeuMzweG1gA4AFG+TKHTUcFuT7TVQkfbUTkkzV4QdM/jWn9V19IzSCdA8DfwpKcCwVEVJSnJeOzIWgbFBU3SsQUS50vgkOBiqUvU1kdMIZH8gwcdYYVj5z/ZfDOVIt9/E97lF7uaq66WZ+uTh5An37y4orPPFrWUUnY+qvszyHRFRjpaK64w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6ZJdLxR1H7mp9DO6da84uSOMx4PBILUVb91fxC0wcs=;
 b=S8DPvWF4OhX+/LuadwYZ9btCuxuPox424a/DDNxFgwvxlsv1rg2VD/6KhTVjy25PTinoBKplXF8Inoe/9hySPQvSf8h0zgYu3IIZJmtwwqzFAtrEDTjQkvh8BTNAADGiZxfUQXAmZ4U2SyukSN7mYnA+ZNeg38JFu4U1It1JXb8HHH5i8ecmKqVwi1VCXZbYmaDu2h0+uzbjS9L90H4ajzOllBvUDk2I6nNIElDEL9kVdImRMD0jAg9yVzWlDqH+MUDzutL/TysDBWnkNRmbeKx07R2sHlgGhHW3WvVahxG+Ejz6FoR3Mze2ejeNKuyAOAF2DaIIT9R46mvsBsyCfA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by IA1PR20MB6247.namprd20.prod.outlook.com (2603:10b6:208:3f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Wed, 20 Sep
 2023 11:24:32 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263%4]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 11:24:32 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <apatel@ventanamicro.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        evicetree@vger.kernel.org, emil.renner.berthing@canonical.com,
        guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, Chen Wang <wangchen20@iscas.ac.cn>,
        Inochi Amaoto <inochiama@outlook.com>
Subject: Re: [PATCH v2 06/11] dt-bindings: timer: Add Sophgo sg2042 clint
Date:   Wed, 20 Sep 2023 19:24:21 +0800
Message-ID: <IA1PR20MB495313B7E9B2FC529BE0BB2ABBF9A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920-untimely-untagged-12b75e247afb@wendy>
References: <20230920-untimely-untagged-12b75e247afb@wendy>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [PGHK3GkX3E2lZkkVf4psTFId/0H1pkdTuOJvwZm9eKg=]
X-ClientProxiedBy: SJ0PR03CA0101.namprd03.prod.outlook.com
 (2603:10b6:a03:333::16) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20230920112421.170713-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|IA1PR20MB6247:EE_
X-MS-Office365-Filtering-Correlation-Id: febcae9d-2131-40a0-ade7-08dbb9cc2955
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kfdP4ZKdjZa7Q1bmpByxvvX6KXiH7qc3ARLSrzswXDzeLBEe//o1Y5SIPmog3xsXv04zXAG6eqU9gZFWsPy+I+VtVXAlbyHRZFn8+ZzfEmq28ERJpl/tec1InCIZuliROAOC6Bw9ytICgQYuvUAkd4DnFYqNsYPlvIlTcAqcXVP4ZWEORA0JOx72Jll3aI8mWAUl8/uqAWPpg/jbc2WeX/kjoixAG7piNJv3IJG6isTjjca4IQw0IRVoKekelxQL4eS/mpTEoc3+fLKHBy7Iia3w9CysLkzYLkepjBrV73LnBT9kQ20ZWLkUmRdubh7IYK7AbAkXqsmR0eBv1AQP/XR0SDVjECV9udL/3Uri0rbzkMIJ6Uea2PRDr6Ju4rMQEAGbFhoqcOXHpUgGPApcF56Nb6wzyPtUBDvWSyc3jhvzTocYVhcSfXWhjC+wpFV9/ko4EiRtwGnPOoAYan6PD8e5eBGLHc2M0S3KUmLnGc57KE59XQbtxosCVkTTkbN/kI4B+rImMsxMXSEAOA7GX9OM92x1rk9Ett4pdfDc1fowpw9Sv1R/6rJLmN3ZU5gy4L1OmlY5ilH5AcU4ny40JKe9ng7aLGTa5KkTdD6VnkgQGkT5mABf9KsuYT4t4oKC
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CUx3CNpZXmQPY2kwvPgyzfTA4VxNFHJJ8zJeGvwWQev/bclyo+R34mj8+wON?=
 =?us-ascii?Q?CXl8BhfvznotN4Asz3KGnxjqYphSeBqzWpoFfQZNRH6/UrkjxrADVTlCEVys?=
 =?us-ascii?Q?O5//jNnFjhu/njuLbMY15fcKyMqKKpJiOJm3OGgezaIJ672evpXpqauXbMzW?=
 =?us-ascii?Q?afROG5P6L8DerEIDKg2gS9mwZ+dPynG/fXCkcTNDLnQ8JxMPG7kXbvkL9BCk?=
 =?us-ascii?Q?IEBdQNjDyOLD4aGTyDIudAbTfA/hzsbsBPJu5qUNM6+HJ0wPNOg5xPkjEySJ?=
 =?us-ascii?Q?IeRRf+Fi3Im33xZSh3lsdX9aH9BwJates31Jy0Bt+BRfIvQ57bFMf5rRwBGD?=
 =?us-ascii?Q?s0XTcZWq9LTogbtxh64YEdlbCUpCvZK02W6QVaKNCFedEpA3i1veY8UNvfZ4?=
 =?us-ascii?Q?3PAnlBKbWytgT3TNftXIDjSaC0BcI2TUY+uMg8n02MkIc4Nzl+7gzDQtyusC?=
 =?us-ascii?Q?WkYp2U8XBcfRVKl6LVSnZF5XBtygjD+8B8ZbIOrHnyXENZxb0zvxJGMj41dC?=
 =?us-ascii?Q?2ZXAN/EJ1VzPCuaAg6vHtxO0UmqaRmBZJpUBscv5v5ku/bNbK//dSOahVu1k?=
 =?us-ascii?Q?y5Y/FJPFcOSwEi4iq+bCOwqiBz8dyN1koHA2Q/iBi/ywrBFJC8ekQrm/OAF2?=
 =?us-ascii?Q?fVV4vHAkFovpz9gwUZwNdtFhZKufY9Pw5GhY/6S04+bp9Buse2cRTevm5SeD?=
 =?us-ascii?Q?9R0JeOf98tAE0lGKNbgFl1Um6FqQQexJQ0Jdhk7kV3k43noMwPA3n7ydy/uo?=
 =?us-ascii?Q?avAo3+Sr7/Y/as70nx1XJGmD5HdUXrfd6G1PSKpZv8O0P7rw8VkbQcL9fnZk?=
 =?us-ascii?Q?VK0tU5IHPTP/915dGGpMo+2oNhVzzHTVk3Uw02cBrAumnYRHUUEF15DUM7M+?=
 =?us-ascii?Q?zzIKV3BvhhOjkMNqt/36/iSAROe0krph/MqUCwJj/g6y9OlmRrwLX1UwToXR?=
 =?us-ascii?Q?HlMmlxhD+Q55kYtEAio+71SpXq3nguUP5jsSyR8QrKnUM5vdv++tGzC9D9M3?=
 =?us-ascii?Q?RDvXPxCNngBhoXODRcGDN7UJKOIVnPRevGGskzO0291LW2nVYTpX47Ac08N1?=
 =?us-ascii?Q?bk1/aJOBbEuaOPRWOkuGhdsgqKQr/2DIWbOJmUY6hbNnLu5cixE4SL4p6x03?=
 =?us-ascii?Q?AoONoW+5M1I6g8F3xBBruYWGavObMlszYg6fEt+jRsVUlIktI/+OET3tQi6F?=
 =?us-ascii?Q?v65iwL6wafeWBEbvwHWr7BSlyns5r4gH3CvC5QsN5UyOMM55cKKRDr4NyLk?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: febcae9d-2131-40a0-ade7-08dbb9cc2955
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 11:24:32.4835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR20MB6247
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Yo,
>
>On Wed, Sep 20, 2023 at 05:08:41PM +0800, Inochi Amaoto wrote:
>>> On Wed, Sep 20, 2023 at 02:39:39PM +0800, Chen Wang wrote:
>>>> From: Inochi Amaoto <inochiama@outlook.com>
>>>>
>>>> Add two new compatible string formatted like `C9xx-clint-xxx` to identify
>>>> the timer and ipi device separately, and do not allow c900-clint as the
>>>> fallback to avoid conflict.
>>>>
>>>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>>>> Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
>>>
>>> Have you ignored Krzysztof's comments on this? I don't see a response or
>>> a reaction to his comments about the compatibles on the last version.
>>> Additionally, where is the user for these? I don't see any drivers that
>>> actually make use of these.
>>>
>>
>> Sorry for late reply and wrong message-id.
>>
>> The clint is parsed by sbi.
>
>That needs to go in the commit message.

Yes, it will.

>
>> As use the same compatible, the opensbi will
>> parse the device twice. This will cause a fault.
>
>Then only have one compatible with 2 register ranges? Then your SBI
>implementation can use those two register ranges to find out the base
>address for the mtimer bits and for the mswi bits.
>I don't understand why this cannot be done, could you please explain.

That is a good idea, but now SBI use the second register ranges as
mtimecmp address for aclint. And there is a aclint-mswi in the SBI.
Maybe a change is needed?

>I also don't see anything in the opensbi repo right now that is using
>these (nor could I easily see any patches for opensbi adding this).
>Is there another SBI implementation that you are using that I can take
>a look at to try and understand this better?
>

This will be sumbit in a short time.
Now we only use it is sophgo vendor SBI, which url is [1].

[1] https://github.com/sophgo/opensbi

>>> Why do you need to have 2 compatibles (and therefore 2 devices) for the
>>> clint? I thought the clint was a single device, of which the mtimer and
>>> mswi bits were just "features"? Having split register ranges isn't a
>>> reason to have two compatibles, so I must be missing something here...
>
>> Sorry for late reply, The clint consists of mtimer and ipi devices, which
>> is defined in [1].
>
>Yes, I have looked at the spec. I went to check it again before replying
>here in case there was something immediately obvious that I was missing.
>

I think nothing missed.

>> This standard shows clint(or the aclint) has two device,
>
>The wording used here doesn't really matter. It's one interrupt
>controller that does mtimer and mswi.
>
>> but not one. In another word, there is no need to defined mtimer and ipi
>> device on the same base address.
>
>There's also no need to have two compatibles for the same interrupt
>controller, so I do not get this reasoning. What actually _requires_
>them to be split?
>

Yes, it is one, but can be mapped into different address. So I think we
need two.

>> So we need two compatibles to allow sbi to identify them correctly.
>
>Why is it not sufficient to identify the individual memory regions?
>

FYI, Anup. As I have no idea for aclint implementation.

>Thanks,
>Conor.
>
