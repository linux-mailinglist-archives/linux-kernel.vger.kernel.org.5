Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B89F7FED44
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 11:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345019AbjK3KsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 05:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjK3KsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 05:48:20 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01olkn2028.outbound.protection.outlook.com [40.92.64.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBE2D40
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:48:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8RTKxW3YIXfb2MR663LNg3gV+2Ol8akFKTgbJ+tHTQpGMJIILwvF5o6ZjTM2uqDTcpQY94AuiyHh3kcPF8J/cjvsfQJaKS75jVoJdWtBcsD6RTcoa+7fmsfJDqyrcQLHJFfx0qjyQi5OWIeW89F0rTmlYqzqsfLYZBSt2PBa5rYQ7w1Kb4Ke2dId60blQvaF2kc5EP7iZEb4MqMOnztesgzTzjwMQGZZxu9Cj4mIt/SSB33UA+Lu93zjLZYQ1Q7SV0x8fIVgNTt8jkFQMg993SssYbhAABK041ZTl5/y63xMZi24VkOjVGdPmYmOvPWzm8kdg7ixs9fSF4xxhPfLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GKqQV3n5/7RzV43zYuPOpy6qISCTYTBkmG6+37bnDU=;
 b=W4kHcw8eiC0h8C51QvSzwyCBsxHDHqhTmMAiJQfvCHCK91E2fwhrDrDMkyXRiSxRgjTkdvbPX7WncIpACfOLF4xT303F8XsrRNK8qjmbxyon7uJNtnuUILE+rtbDrSDEpRumel0qz+V9lYHuJU0nwBlyQtLghK7K3S4cTtMZHGLHVFYRumC4TmcqqMeIp7tlJSzDPKt1GDpBxiXCr09sVSfvyDLGbcc+U/jEIuZO5ug0qmJt7lvek7imXj/0MS5TFD949BNDd4kbt+z1MnAnxNIclQwiReZST+SpzTO3rvAcWnZkpw+zdXn78JVjYWd5jYq2TXhK9reHhFflcBdacg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GKqQV3n5/7RzV43zYuPOpy6qISCTYTBkmG6+37bnDU=;
 b=iGdeJvRFNTgPAwJtNZEKsayw7t08JXj+0d5UKHwRQ4L31RwGGuKKzsec2Z6mGqvnAiOSVxwGEuxbeBU8zg9BDovwuUbvnvi12O3j3AYSX8jS7AN33xcNW/jrIETFMO7iUpxerpPi8quXHRV251f6p1Veqj8J7qxYdRpk6HgdJ0FN8zo5qVPzln1SlhWr2D2fYreNs04+bm2vOv2NxfxPkzRqRkd6nmFOhxaA2smrcuHZRYuQ+T57b1AOCdUhruzgTRKOmcDzi7y6JsQiBw/fEh6VtmYc6yOs0iuyf2uKnyMPfBlnbL3G4lQRJ3edZJ9cG9GP3VjPcKiYoNf9txIR/A==
Received: from AM7PR10MB3923.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:172::24)
 by DB8PR10MB3546.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 10:48:24 +0000
Received: from AM7PR10MB3923.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1fc4:7df9:3d95:eb28]) by AM7PR10MB3923.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1fc4:7df9:3d95:eb28%6]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 10:48:24 +0000
Message-ID: <AM7PR10MB3923E07D6024434077E95EBA8E82A@AM7PR10MB3923.EURPRD10.PROD.OUTLOOK.COM>
Date:   Thu, 30 Nov 2023 11:48:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Kernel problem with multiseat on one card
Content-Language: en-US
References: <AM7PR10MB39235DD53D163910E88FDB938E82A@AM7PR10MB3923.EURPRD10.PROD.OUTLOOK.COM>
To:     linux-kernel@vger.kernel.org
From:   Gert Vanhaerents <gert.vanhaerents@hotmail.com>
In-Reply-To: <AM7PR10MB39235DD53D163910E88FDB938E82A@AM7PR10MB3923.EURPRD10.PROD.OUTLOOK.COM>
X-Forwarded-Message-Id: <AM7PR10MB39235DD53D163910E88FDB938E82A@AM7PR10MB3923.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [/2RKK60Z46pYF787PFpVagTDKcWqPc7H]
X-ClientProxiedBy: AM8P191CA0001.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::6) To AM7PR10MB3923.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:172::24)
X-Microsoft-Original-Message-ID: <1bd953bc-b935-411a-adac-8dfc2aa7993c@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR10MB3923:EE_|DB8PR10MB3546:EE_
X-MS-Office365-Filtering-Correlation-Id: 8582187f-b8e1-4fde-4bce-08dbf191e0b0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zfO2gZddN4mOpWpyho6ZfhXlDnxy/KjduwhjKsdLhgAqWooOQktblQqMJ1vy0XKv4lz1c1xrmecNoPSjSEWJXap+TSNjQ9NVCqxLHDqs8ywyT96CJOlujUlF/U93CQOUKzQZIcAU2UXED3KefO7QDzT6rg9J7ILjxjxQ0oNAtaO76JZkln5zrihe0GYvW/t9fHUesKPS2cDuwcf2MGkhpIkniMTZQLRqaujHs0ZsOOk65yNjyf0BoRBkVt/dFYwGUhO8DYaMsOIllgOlaNQrQs+mCsPJEMa9MieIVlz0XyNn0pIm0do5jQWlsP9Fm1Xob5e71HKP3xCUi0VZAejs6EFGkvcdtdNNbFlai2DCVQQ+7dlsg4CufxBVzDQwlcJSal3WhdIDoOuK1ZTXUSEcOCTiaWvfQYRQHc8/df24qr/23m47vayXcFqGKVktGRmerJnyHavTecGRVhx5kG7Rj3FJYnoALpMJfq0d5zZpo+kIJFFgUiLUJ6HhlDgKBYs6dGG5bYR0t65Xjf9oX0WcP7cFu4QYNSw4rgWliBi2OH9oleKge+fTHzYF9KwVsYDh
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2Q2U0ZvUEYwbjYwc3dpMDd1cEVYNEpwMGp0YlZpR2oxd09KWlJHSkJBQlR3?=
 =?utf-8?B?T0ROZjlHMHNFTDc2V1JHSWdwZmthdERCQlJOSGsrTTE0QUdJeFRjcUdzZi96?=
 =?utf-8?B?RFMzeDNoYnV6OVRUQ2xvV0tOd014UGJWSFIwV1U4Q1B5cFF5cDRDQ25BVWdC?=
 =?utf-8?B?WnNlbVFuclluOXI1djBSUTYrZGE1MHVURUFWNTNSOWVBMHh1MXE1Z3ppRUUx?=
 =?utf-8?B?WUJEYy9LQXZlcy9tQk5yR3FHbk10WmZmK3F6ZEpKUUNhT280L3lHM3JJRTha?=
 =?utf-8?B?bTVKYm9EWWVhcTRxTm1hWFlQY1NoVFZnSyswbk5iTjNncDRyYXRob3QzUUt1?=
 =?utf-8?B?dmJRR1NDeGpzZys4MEg4Z2hKRkZIOEtHK3hwSVV1MFVkaGdhVFFwcitlNmpu?=
 =?utf-8?B?bUcvS2tpbVlJWUNCYW4wNTRyK0dRY0ZzMXVrTjB3Rm5LUWlvVEF0cm4yMTIy?=
 =?utf-8?B?Mll5bEF3WEtZdEJOSVhlUU9xc25QUG1mU1ltUlRqMFV5QXNiU1QwaVRxSEFj?=
 =?utf-8?B?N1lXUktsRjUwaXM4VW51SjZVcW5UK2JtSDdtK2U0SS9LMWxDRE1XRklyL2lr?=
 =?utf-8?B?WS9rejlIcHo2eG0xMSsvMlhsazlkR05QcmoxOE51YWZrVDdSNkdSTlUzZng2?=
 =?utf-8?B?YmhlS2xGN0V5clg4bi9IL3FFYmNOS2dZam44QWJxK0c3TlZ2UXQxYytReUlQ?=
 =?utf-8?B?VHc1WHBPbmpVamF2Y0J5UGFuV0dYZElER2E2WTBSMHNPZGw5bTBaeWhoRGZl?=
 =?utf-8?B?M0cxYWdueXhUdWxFWmljcTBkalJXTVpaTkFubXdwcVFaTjMxbEFSRHdWLy9W?=
 =?utf-8?B?YnVrN3MvWktRL0VORllHN1dzcFpMRWtod1lvakZsNDU0bys4TGRCRS94dSt6?=
 =?utf-8?B?M1lzVnVlRGZBdXhnTXZ0endTWndtS0tEbG1RbGI0bFlZTWU1VmJPaFRjeUVs?=
 =?utf-8?B?ZVpHeC93dk9rSjJCaFVqQWFKY1lKYk1POFVPdTlSbWpmeXk5b2JuYjhCQklo?=
 =?utf-8?B?OUVPdnEzZ1BERS9GQmllVUFvTGRaUWNzVVlldDVwWXV2VUJoWDcvaUxwSHhm?=
 =?utf-8?B?Y0doOVRPNGNNT3Bkc3Fqb1N5UmNIK0tJUGhQMFJpcldmeitESDkzWXJtK2tV?=
 =?utf-8?B?Zk1Mb1F3SkdaeUdSeFI0c2R5S2l3bWFReThGQklFcTdhbHhuYlFZRXJFZzN3?=
 =?utf-8?B?TTRtTzhXaDQ4dWJRMFFwS25GNWE5Yzc0K2xYbUFucVZNVG1CM0tPdzNlSVVk?=
 =?utf-8?B?V25LbS9vWEY5ZkR0L1pzWmtDVkk3eE91UCtrOUdQODNwSVlydVFaajhBcnRH?=
 =?utf-8?B?eGNTRkliQzlLWjJMRWFlZmQvU0xVeDMrSUZvNU43TnFXSG5ESWVYenhLcStR?=
 =?utf-8?B?bTFBcjJwdnNZQTl3MkFxZFgzYWw2ZzZXbkdlcVgrZy8rcEhNM0lqNGRvRGNx?=
 =?utf-8?B?RDV3dkFXcGV4aEU0RmZDdDgxUU1iNlp4RmkzK0pZTTNtZlRka1UzbFk4VThK?=
 =?utf-8?B?YUNOeWlnOWJ1Q0RObmNMZFFsQnhmVWcrTWNSRXhxU2NOc2x4ZWU2UUgxaXpO?=
 =?utf-8?B?dlFPc0p4S1JQNDQ0YjV1dmR2MVdmcVJlWWxHbG5wVnlGWnpXKzB2MUI2cHBV?=
 =?utf-8?Q?od9OD1kBY/4Acj1mBfgztIxoPgjbGETXdqSvKAILbQeo=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8582187f-b8e1-4fde-4bce-08dbf191e0b0
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3923.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 10:48:24.7425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3546
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kernel list,
I'm the IT person of a school, earlier we used multiseatcomputers for 
the school, i have maded with a XGL implementation and it works fine but 
not so fantastic. The school wants that i build new computers but the 
XGL project is too outdated so i can't use it anymore.

How can i make a multiseatcomputer with more then one user on one card 
with systemd? I have asked already to the makers of systemd but they 
said it's a kernel problem.

With Systemd loginctl and the nouveau drivers you have this:

─/sys/devices/pci0000:00/0000:00:03.1/0000:08:00.0/drm/card0
           │ [MASTER] drm:card0
           │ 
├─/sys/devices/pci0000:00/0000:00:03.1/0000:08:00.0/drm/card0/card0-DVI-D-1
           │ │ [MASTER] drm:card0-DVI-D-1
           │ 
├─/sys/devices/pci0000:00/0000:00:03.1/0000:08:00.0/drm/card0/card0-HDMI-A-1
           │ │ [MASTER] drm:card0-HDMI-A-1
           │ 
└─/sys/devices/pci0000:00/0000:00:03.1/0000:08:00.0/drm/card0/card0-VGA-1
           │   [MASTER] drm:card0-VGA-1
├─/sys/devices/pci0000:00/0000:00:03.1/0000:08:00.0/drm/renderD128
           │ drm:renderD128
├─/sys/devices/pci0000:00/0000:00:03.1/0000:08:00.0/graphics/fb0
           │ graphics:fb0 "nouveaudrmfb"

So it will be:

loginctl attach seat1 /sys/devices/pci0000:00/0000:00:03.1/0000:08:00.0/drm/card0/card0-VGA-1

For the seat1 (the VGA d-sub output for seat1 and the other HDMI output 
for seat0) and of course the mouse and keyboard.

When you do this, all the graphics outputs are on the second seat 
(seat1) and not anymore on the first seat. So i need to move only the 
VGA output to seat1 and not all the outputs.


When i install the proprietary Nvidia drivers, i have the following:

[MASTER] pci:0000:08:00.0
           │ ├─/sys/devices/pci0000:00/0000:00:03.1/0000:08:00.0/drm/card0
           │ │ [MASTER] drm:card0
           │ 
└─/sys/devices/pci0000:00/0000:00:03.1/0000:08:00.0/drm/renderD128
           │   drm:renderD128

─/sys/devices/platform/efi-framebuffer.0/graphics/fb0
           │ graphics:fb0 "EFI VGA"

So no VGA, DVI or HDMI items.

Linux is a very good multi-user system, so it is frustrating that it 
does not work. It does work under Windows without any problem, so it is 
certainly possible.Can you please check this or give me a tip somewhere 
so that I can continue looking for a solution? According to systemd this 
is a kernel problem, can you please solve this.


Hopefully someone can help, the children and school will always thank you!
Thanks in advance,
Gert


