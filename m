Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A67E7E45A3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbjKGQQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235451AbjKGQQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:16:13 -0500
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2165.outbound.protection.outlook.com [40.92.62.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E5E6E9F;
        Tue,  7 Nov 2023 08:08:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KtUHDfVovlUBceDWGD3M0vUTPIJDN5iekvTSyfdyuL2z7uODza+b3SukKGUpG9iUOYpCmxRvbLV0BcImz9nDrF/e6fNwQTE4P66S2RYooGBpli+TVxNQTjmagXx6YiA7ZWEAV+hmWxLYc0nT/ZOcqZsGyQvHl2zbw4t/EicxQOMNWhEC7vNTl0MmrZg1P5oDruH64hksioZsRaA8T0uRBsu6TQz2K5oNpFQhR05BvDwRCcvtNJ8yAd+IOSFjePENpn0oP6FApBKAEdQ192V3LEMMVyCXmEz6GJOSC9RLJ8FtnNaWfVikJ2LCfR6njRBUGwW7QcLcEtiH7QYRZbqskA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3OzNCXNVozzfZZ1+JylcAjKsf8EY4qln4KFYL6qPbw=;
 b=NduJ89353GFmepP6nDivHtmgCAnalU+T3rXitT6UzIIRzaHumnuJfy38Mzn43V83z6tB9aVrd/4wHg8BzCCGzM7xYd366Q/+MZdT6yD1nSlI1mN/4yL7zyZYVm2amK/nsbGwfaQPKu/LXAoQxPzEYkHVUfRGFVeDbz+vrLOMkmoHkQcMGer0NZhG3PyjIRGkOHfcWIeF/H5htQ5BCRzOtOhYI5e6FPRRfzTPY+yeLTRY7zKYr79llUiWNjgPxyiJ2WfFaEM5poxCngjZYu3PHas1CdJb+gE2OenwkdfGIeRa4Y1HLPlYuWv+HaIHYX9m2UHksed81Q+Fw9jKzl3QvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3OzNCXNVozzfZZ1+JylcAjKsf8EY4qln4KFYL6qPbw=;
 b=tqKPQtlUXNELrDue5UEyZnS9MxPSHVNlYMYzsGNpXKvsrurR9CfryVlKO8X0/TIwgw1mpa3HrcRdNjhMk74mcQDQoJzzgrnmJGn0qJwreDjKWjDhNxXI7ohCST1Sh8XsctSLqdnQZxId6zWY2O3bY0ZIiBoJo8gIsYQu/oBCnZ9ByqLBls97wuySW6KVPvfUBRpb6UYtDeutK8t46XcdUujQTnL+sfZfzHuGI62ZrQsrzjYhSA20u+nAulkAhc9ZOHMO1avi/Rn5FU7Clyc45ZtMy2hVYmYZtQ0iBg/HRKUNFADTh3RPW1O7OhUmJch6GIul6UfBWcwU5v+KozK6Hg==
Received: from MEYP282MB2103.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:bd::16)
 by ME0P282MB4288.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:227::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.25; Tue, 7 Nov
 2023 16:08:36 +0000
Received: from MEYP282MB2103.AUSP282.PROD.OUTLOOK.COM
 ([fe80::ebc:6803:865c:451f]) by MEYP282MB2103.AUSP282.PROD.OUTLOOK.COM
 ([fe80::ebc:6803:865c:451f%7]) with mapi id 15.20.6954.025; Tue, 7 Nov 2023
 16:08:36 +0000
Date:   Wed, 8 Nov 2023 00:08:31 +0800
From:   Yihong Cao <caoyihong4@outlook.com>
To:     Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: apple: add Jamesdonkey and A3R to non-apple
 keyboards list
Message-ID: <MEYP282MB210374CF33FEABA6231FACB19BA9A@MEYP282MB2103.AUSP282.PROD.OUTLOOK.COM>
References: <SYYP282MB2110B4E87983EAFEDC8741E49BA2A@SYYP282MB2110.AUSP282.PROD.OUTLOOK.COM>
 <87a5rr1sqf.fsf@protonmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5rr1sqf.fsf@protonmail.com>
X-TMN:  [V95fD1Z95ZPz+G2sSa8WuU9MtnEJ95tT]
X-ClientProxiedBy: SGXP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::34)
 To MEYP282MB2103.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:bd::16)
X-Microsoft-Original-Message-ID: <ZUpg_1pE892KF_tG@cao-Rog>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2103:EE_|ME0P282MB4288:EE_
X-MS-Office365-Filtering-Correlation-Id: a462a09c-c234-490c-05c8-08dbdfabcc28
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yg8OmiBiiEImldOqznRfxTFZWCyWoxU3AvyL/QExawZQlSOz3QV7v5zOMggqhlzr1QuXIVnOMJ/TrIsPLHuXYy7UxXXJeKTDHsrJQSUW0++lsw80fQ6StjNbuIu/vyOYYfmB97Gf7VN7Mhp8uhK8zihLPiwf4eidfISv6sGCK3Ym2EnTdGDofVuWQ7i84iFpzOVjtW5AykGcE9g2lTTOQzlAXQL08QekJzBGwd0bnNX8yI19QqgZ2fMNtL871e2pOuvqEJuzHQ1Dofiu6M9b+6w+EvWCkyTLoSRVElOtfw2IuQKv1+WsaS0jNfR+PcHZd7Z0q7gdyx1VJSzXmYmHIX48xSWIs293cMqOrgzYN5GMnI11Pr7iyRMJYyTJVkQRPbiOlczIXHlrdwiHf1Nc6KqbnDtwkYQ6esPBUbPgkvEBmHmz8Izv55uEzdCZjarNULtJGzQa1kMIR682G0F3xNy/wFhfoLorSAJSWmTIOZCSRNIqE8b+zsaSM+NAht1rzHupMSUEncISYCYiuzHsZ2ZvYWQxMR0Hch/81Y23tnpE6xqP++Iu4vUtLytffqrT
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a47ZQPznrCz47rUpyPKqKqc+wlzezZ5k+wNbLJHTfMC5XDzfIowS40+OifXx?=
 =?us-ascii?Q?03U0GwAcdKVBBK3OEULIns8+P/PUp1fPx43UmIe5nEM5x1XYBN9Afk/bBSd0?=
 =?us-ascii?Q?alSBqs/wbB1xTvVLOS3SIlmnuj2Lh61Uih0xDZQ8vIJsfzehsYZh9indjdh4?=
 =?us-ascii?Q?oUaQupKiT92Ty3PBgzCNgB2CKMse5iYDouI3IkSSn6pxMjQTLvc2XMWZqrvJ?=
 =?us-ascii?Q?rSYiG/0nYPeHLcwwIUbVAsJCt4ri4tUNJZ9Md68NeE2AgSKh2J5KCUXPZN50?=
 =?us-ascii?Q?aPCz5JHCAYeq7t9G7Zf0/OK7B+3JwDz4cSe6Gv6O/kCMbLaL28lDO6fJrucz?=
 =?us-ascii?Q?RCF6O/odvo3V7mjsLrgjiSdCrQDnBSOaEvNdHwSXs2zeaXgugqWQgtws8iL0?=
 =?us-ascii?Q?f8evF5kjZV/HozI85xCzjwyuJYsbQN1b1e3gby8p9sPnBzgijFu77ml8OUiC?=
 =?us-ascii?Q?5Hl6CH7ZLUJN1gFIWTQ5artn5jMCWc5NqVjrOWqAPBvfqPGP2skLYROQJPpc?=
 =?us-ascii?Q?ieOjoz3jX1hLrqxTDnKinAW0jijnGUxaL4/IQG8Zp920IBcAsB+QsTU2wrbv?=
 =?us-ascii?Q?47awRNgdHI8kUxgy0ne7DjIJZr54ESuSRE5AF08yel2spQB7eM9NUAriERJ1?=
 =?us-ascii?Q?85n0Pd1IydLHd3K/b8BI0sEWYP+Rk1HBJObHiOZdwTBCLLdo/HeNH6kELXfG?=
 =?us-ascii?Q?78PQLU2Igvsp942j6N04qdhxDo1nbfJl/uxD2IgdH8PaZzwvfwZwlsx4bGxG?=
 =?us-ascii?Q?i2ppWLRwRmXY7m4ifpwtuOCWlKewsCZrbpzhaGmZf1m5kLOCZN/gz2m9qQ4k?=
 =?us-ascii?Q?uW4jwrxfNxjEyQ/CaBnhmDWF7gslRc50BugCx2mvpoF4pvga+cwqjlgT3csr?=
 =?us-ascii?Q?rxOX0MAnIXK4IEsD7daav2+x+OQuiTLCIH72cCtw3Qz6nBbC8DFHUImkNFUD?=
 =?us-ascii?Q?iWXx27bLt02sMF9hUWO+z+An9fNxIkiiWF0dYkGhRMA0SRumxhhHy3ULzqid?=
 =?us-ascii?Q?iGb+ctTvcypbCnuKaKOhzrSzmBixQgS8jBe8tRDy17NR2Qj58HYEIQV16GOG?=
 =?us-ascii?Q?gHNI6LqeZswrZErCZWg3aBC2/UlYA+BoHXpsG/U+lwD0Bu0aPQPZG2DU1SvY?=
 =?us-ascii?Q?E9DC/wNNjJAXUFjV0ZvBE1tmNfWaJhzdPGH/jPYcxVYeZv9eItFtLkCPZSpX?=
 =?us-ascii?Q?HHJR9TZKaldJqYKIOk27sTs+wC9ztILM6TzC+w=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a462a09c-c234-490c-05c8-08dbdfabcc28
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2103.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 16:08:36.4472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P282MB4288
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 03:11:09AM +0000, Rahul Rameshbabu wrote:
> On Mon, 30 Oct, 2023 01:05:38 +0800 "Yihong Cao" <caoyihong4@outlook.com> wrote:
> > Jamesdonkey A3R keyboard is identified as "Jamesdonkey A3R" in wired
> > mode, "A3R-U" in wireless mode and "A3R" in bluetooth mode. Adding them
> > to non-apple keyboards fixes function key.
> >
> > Signed-off-by: Yihong Cao <caoyihong4@outlook.com>
> > ---
> >  drivers/hid/hid-apple.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
> > index 3ca45975c686..d9e9829b2200 100644
> > --- a/drivers/hid/hid-apple.c
> > +++ b/drivers/hid/hid-apple.c
> > @@ -345,6 +345,8 @@ static const struct apple_non_apple_keyboard non_apple_keyboards[] = {
> >  	{ "AONE" },
> >  	{ "GANSS" },
> >  	{ "Hailuck" },
> > +	{ "Jamesdonkey" },
> 
> Sorry, maybe I misunderstood the commit message. In wired mode, if the
> keyboard is identified as "Jamesdonkey A3R", shouldn't this value be
> "Jamesdonkey A3R" instead of "Jamesdonkey"?
> 

Hi!

"Jamesdonkey" is the manufacturer and "A3R" is the model. I think adding
manufacturer to non-apple list is suggested, just like commit
c4444d8749f696384947192b602718fa310c1caf,
20afcc462579c0bd79a59ab2b87b82ffa833d118, and
a0a05054583fed17f522172e101594f1ff265463 did.

However, my keyboard's hardware is buggy, in wireless and wired mode, the
manufacturer is empty, only model name exists. For your reference, the
result of `lsusb -v` is pasted below.

In wired mode, `lsusb -v` shows:

Bus 003 Device 002: ID 05ac:024f Apple, Inc. Aluminium Keyboard (ANSI)
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x05ac Apple, Inc.
  idProduct          0x024f Aluminium Keyboard (ANSI)
  bcdDevice            1.26
  iManufacturer           1 Jamesdonkey
  iProduct                2 A3R
  iSerial                 0
  bNumConfigurations      1

In wireless mode:

Bus 001 Device 003: ID 05ac:024f Apple, Inc. Aluminium Keyboard (ANSI)
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x05ac Apple, Inc.
  idProduct          0x024f Aluminium Keyboard (ANSI)
  bcdDevice            2.00
  iManufacturer           0
  iProduct                1 A3R-U

And `dmesg` shows:

[ 1779.692121] input: A3R-U as /devices/pci0000:00/0000:00:08.1/0000:06:00.3/usb1/1-2/1-2:1.0/0003:05AC:024F.0008/input/input35
[ 1779.749037] apple 0003:05AC:024F.0008: input,hidraw2: USB HID v1.10 Keyboard [A3R-U] on usb-0000:06:00.3-2/input0

In bluetooth mode, the iProduct is "A3R".

Adding "A3R" to non-apple list makes keyboard to work in both wireless
and bluetooth mode.

Best wishes,

Yihong Cao

> > +	{ "A3R" },
> >  };
> >
> >  static bool apple_is_non_apple_keyboard(struct hid_device *hdev)
> 
> --
> Thanks,
> 
> Rahul Rameshbabu
> 
