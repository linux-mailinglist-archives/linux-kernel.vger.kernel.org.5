Return-Path: <linux-kernel+bounces-19016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C79D8266CB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 00:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C809F1F214C7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 23:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B902213AE3;
	Sun,  7 Jan 2024 23:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsl+Je/H"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A024125A8;
	Sun,  7 Jan 2024 23:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cd1eac006eso11730751fa.3;
        Sun, 07 Jan 2024 15:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704671369; x=1705276169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQWucGX8i5M7geCueH7j+J5ARbbBVLCsirvzYyDvJyI=;
        b=jsl+Je/HcPCh6EpXtzzkpmDxO7Ji6KmGd02u6/S9qXJ2EoD77Z5oi6PMRqq5maejie
         eMFrae+8qh0lgn0tPm+A65lKDZVaZgZ3FEazgL9bGv7Gr+CyDXq8KFTEhcPrNWuEswPh
         fEtLFSw8g9zZpndY7LzAEDEXWywIuztc9SlI6SV54rnTXkpBbJmq+NYm5vsi8rENpu7/
         m1Nj7IObzWTS9u0AYE8owtzmT79Qj7rgCP/GiWZHFU4kNrGLAu3H6NiRQ1Rf9I9MOcKK
         Knp7G0RjRQKnzMF6TASn8dBavF61xSN5VZN+Cn2T+K0c4lvapAb2K9IhBjjUXJSBiK8e
         /Ylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704671369; x=1705276169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQWucGX8i5M7geCueH7j+J5ARbbBVLCsirvzYyDvJyI=;
        b=lLp68MWdCkpz4YeGQvFSQjM+8VxY6eDQgwpnFRwALX0ES6fBBu64V3Lc908WHBiDkL
         g0hYDoh+dYnKNfadfNivPJjWC9CjFjNICz50LrScMxrDwFjh2zV3qArbwuBw38PN7547
         0uSSWOwQXxTreXHXqXFLshn6DTIXYfr6hsI3Z4ydXRerrN85OTDspPwRYW4rNQ0pml/Z
         zMHMEL70FJiDuJWuE+BStXuc5usogDhdghyTMEp2Qoqft4x/SqQWt/wzLlRYkAfF+yfP
         OaQijzmKGTil5DDmozZgl9z3rnjX1mEPxfuYJnL56p6UDFWwlxoFrOw4IgwYf8V63CjY
         F1zg==
X-Gm-Message-State: AOJu0YypS+CNrNZKwaBQyPR8YZ2eQq7+pcFDLePk454oyILe9n5IrVe9
	RaB8lCdv0Ps72j7JJYKa7aZcMXnj2B00iuQpZtg=
X-Google-Smtp-Source: AGHT+IFPJH2xLFCsPjV21ID/GJ6Pvx6zTs1vWa5/cqBc0W02pC6fpCI21nVgsaIBLdUbwZdjhdcNtRr3RbwaTRpQ4HQ=
X-Received: by 2002:a2e:720d:0:b0:2cd:3141:5d43 with SMTP id
 n13-20020a2e720d000000b002cd31415d43mr671051ljc.0.1704671368815; Sun, 07 Jan
 2024 15:49:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102181946.57288-1-verdre@v0yd.nl> <CABBYNZ+sTko6reoJO43W2LHGW58f0kK_8Zgc3mep7xki355=iA@mail.gmail.com>
 <548fb407-ef57-4108-aa26-52deafdca55c@v0yd.nl> <f9f638bf-676e-43bf-8d83-256cae8f7bfe@v0yd.nl>
In-Reply-To: <f9f638bf-676e-43bf-8d83-256cae8f7bfe@v0yd.nl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Sun, 7 Jan 2024 18:49:15 -0500
Message-ID: <CABBYNZL26agc8mDaWZhSpWO1uzhZ78QY96n3OEQW3GJw9+UPYQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Power off HCI devices before rfkilling them
To: =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, asahi@lists.linux.dev, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On Sun, Jan 7, 2024 at 1:11=E2=80=AFPM Jonas Dre=C3=9Fler <verdre@v0yd.nl> =
wrote:
>
> On 1/3/24 13:15, Jonas Dre=C3=9Fler wrote:
> > Hi Luiz,
> >
> > On 1/2/24 19:39, Luiz Augusto von Dentz wrote:
> >> Hi Jonas,
> >>
> >> On Tue, Jan 2, 2024 at 1:19=E2=80=AFPM Jonas Dre=C3=9Fler <verdre@v0yd=
.nl> wrote:
> >>>
> >>> In theory the firmware is supposed to power off the bluetooth card
> >>> when we use rfkill to block it. This doesn't work on a lot of laptops
> >>> though, leading to weird issues after turning off bluetooth, like the
> >>> connection timing out on the peripherals which were connected, and
> >>> bluetooth not connecting properly when the adapter is turned on again
> >>> quickly after rfkilling.
> >>>
> >>> This series hooks into the rfkill driver from the bluetooth subsystem
> >>> to send a HCI_POWER_OFF command to the adapter before actually
> >>> submitting
> >>> the rfkill to the firmware and killing the HCI connection.
> >>>
> >>> ---
> >>>
> >>> v1 -> v2: Fixed commit message title to make CI happy
> >>>
> >>> Jonas Dre=C3=9Fler (4):
> >>>    Bluetooth: Remove HCI_POWER_OFF_TIMEOUT
> >>>    Bluetooth: mgmt: Remove leftover queuing of power_off work
> >>>    Bluetooth: Add new state HCI_POWERING_DOWN
> >>>    Bluetooth: Queue a HCI power-off command before rfkilling adapters
> >>
> >> Apart from the assumption of RFKILL actually killing the RF
> >> immediately or not, I'm fine with these changes, that said it would be
> >> great if we can have some proper way to test the behavior of rfkill,
> >> perhaps via mgmt-tester, since it should behave like the
> >> MGMT_OP_SET_POWERED.
> >
> > Testing this sounds like a good idea, I guess we'd have to teach
> > mgmt-tester to write to rfkill. The bigger problem seems to be that
> > there's no MGMT event for power changes and also no MGMT_OP_GET_POWERED=
,
> > so that's a bit concerning, could userspace even be notified about
> > changes to adapter power?
>
> Sent v3 of the patchset now, I didn't add a test to mgmt-tester because
> it's actually quite tricky to notice the full shutdown sequence happened
> rather than just closing the device. As long as no devices are
> connected, the difference is mostly in a few (faily random) events:
>
> btmon without the patch:
>
> @ MGMT Event: Class Of Device Changed (0x0007) plen 3
>
>         {0x0001} [hci0] 169.101804
>          Class: 0x000000
>            Major class: Miscellaneous
>            Minor class: 0x00
> @ MGMT Event: New Settings (0x0006) plen 4
>
>         {0x0001} [hci0] 169.101820
>          Current settings: 0x00000ac0
>            Secure Simple Pairing
>            BR/EDR
>            Low Energy
>            Secure Connections
>
> btmon with the patch:
>
> < HCI Command: Write Scan Enable (0x03|0x001a) plen 1
>
>               #109 [hci0] 7.031852
>          Scan enable: No Scans (0x00)
>  > HCI Event: Command Complete (0x0e) plen 4
>
>                #110 [hci0] 7.033026
>        Write Scan Enable (0x03|0x001a) ncmd 1
>          Status: Success (0x00)
> < HCI Command: LE Set Extended Advertising Enable (0x08|0x0039) plen 2
>
>               #111 [hci0] 7.033055
>          Extended advertising: Disabled (0x00)
>          Number of sets: Disable all sets (0x00)
>  > HCI Event: Command Complete (0x0e) plen 4
>
>                #112 [hci0] 7.034202
>        LE Set Extended Advertising Enable (0x08|0x0039) ncmd 1
>          Status: Success (0x00)
> < HCI Command: LE Clear Advertising Sets (0x08|0x003d) plen 0
>
>               #113 [hci0] 7.034233
>  > HCI Event: Command Complete (0x0e) plen 4
>
>                #114 [hci0] 7.035527
>        LE Clear Advertising Sets (0x08|0x003d) ncmd 1
>          Status: Success (0x00)
> @ MGMT Event: Class Of Device Changed (0x0007) plen 3
>
>           {0x0001} [hci0] 7.035554
>          Class: 0x000000
>            Major class: Miscellaneous
>            Minor class: 0x00
> @ MGMT Event: New Settings (0x0006) plen 4
>
>           {0x0001} [hci0] 7.035568
>          Current settings: 0x00000ac0
>            Secure Simple Pairing
>            BR/EDR
>            Low Energy
>            Secure Connections
>
> Maybe we could add a fake connection and check whether that is
> disconnected on the rfkill, but I don't think mgmt-tester supports that..
>
> Fwiw, I don't think having a test for this is super important, this is a
> regression a lot of people would notice very quickly I think.

Afaik we did something similar to suspend to test its sequence when
suspending while connected, I will look it up tomorrow since I
responding from my phone.

> >
> > Another thing I'm thinking about now is that queuing the HCI command
> > using hci_cmd_sync_queue() might not be enough: The command is still
> > executed async in a thread, and we won't actually block until it has
> > been sent, so this might be introducing a race (rfkill could kill the
> > adapter before we actually send the HCI command). The proper way might
> > be to use a completion and wait until the
> > set_powered_off_sync_complete() callback is invoked?
> >
> >>
> >>>   include/net/bluetooth/hci.h |  2 +-
> >>>   net/bluetooth/hci_core.c    | 33 ++++++++++++++++++++++++++++++---
> >>>   net/bluetooth/hci_sync.c    | 16 +++++++++++-----
> >>>   net/bluetooth/mgmt.c        | 30 ++++++++++++++----------------
> >>>   4 files changed, 56 insertions(+), 25 deletions(-)
> >>>
> >>> --
> >>> 2.43.0
> >>>
> >>
> >>
> >
> > Cheers,
> > Jonas
>
> Cheers,
> Jonas



--=20
Luiz Augusto von Dentz

