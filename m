Return-Path: <linux-kernel+bounces-19936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA7A827711
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCE1C284975
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0C255E70;
	Mon,  8 Jan 2024 18:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqa5JyBj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6958555E5A;
	Mon,  8 Jan 2024 18:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cd0f4f306fso24236581fa.0;
        Mon, 08 Jan 2024 10:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704737114; x=1705341914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3UVrTC07ELqxg07etwEf6qXVGPgDZ/12FKTrGxeD48=;
        b=iqa5JyBj/NyspgcXT0prOt6utH2AET+vn/GX9dWhQbQlZ49J5Nzb8pjLGsCjW0flo/
         2VlGiLqiLUuqDU8KoyrXFKWpmzifK1vijJB/DTlhyctwWpMe+VrkO4Yp6MQsmOy59s+h
         o2TeI7xNSvSDSOPzk6F6pu3sCe2TxYi/P0xoHqk05x/Ci27iF8LVu8kaBP8z2Y1OhZnF
         56YD0NkRBm02Rs5oGvFq8jxi+6ctU/FB2iCGKtubCcx6IujxHj2V1RLk4W6BQSX1H5+p
         V7cMG1Li7KvdmtXqrDL44OBJDmuuR9xAf62vgmidYJWEmdy4R7V0VtZHDMcBdg6dRTPt
         MjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704737114; x=1705341914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3UVrTC07ELqxg07etwEf6qXVGPgDZ/12FKTrGxeD48=;
        b=IOaTt3vLPIX//reiFZSzAjiR9Md/zzEuPwmeAehDw61vX3g/r6gBjAsWmxTSF6DeTD
         xogqvDYto+CHSLj+yror4vddRJ9oP48VuEgtm6OgLIBTA3mkEQuyXihL2004Qhm3CJ7r
         2KbVSweq0/w68Ze2NoeCMzsLkFy4YX5eg0lbdvigRnX4Yl8uudAmrWquPmE7ZA2pFgV6
         rGkscY6wjsA2XAlJl99tqumP2jz3qppyFV+aSk84XfLgB1NUuSpw8YB7eAI7aPif6awn
         Z0V+1FTj23fSIyJ4+ofiRxWFz8Ih92RnJseQRRUAVu6zsxk8jVKPRhMkHQXlAfmmXJFY
         AQTQ==
X-Gm-Message-State: AOJu0YynxOUkauT3V4Z5gihy0wHotc1AyptmeZyrl0R7i2TZwIDcxv7L
	yEfGJ+omENYLKaRwck5q1qirMh9yOZ8ajbpek60=
X-Google-Smtp-Source: AGHT+IErJFChwpJeDSy4snncmEsk8rrbMMy7EVL/VN0pAXMi36cdPn2kfH83cxAhZU2KXGm06wd2Xo52ajIW0EozX3A=
X-Received: by 2002:a2e:b7d5:0:b0:2cc:e68b:ee5e with SMTP id
 p21-20020a2eb7d5000000b002cce68bee5emr1708726ljo.1.1704737114025; Mon, 08 Jan
 2024 10:05:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240107180252.73436-1-verdre@v0yd.nl>
In-Reply-To: <20240107180252.73436-1-verdre@v0yd.nl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 8 Jan 2024 13:05:01 -0500
Message-ID: <CABBYNZ+rDo6ftN1+HdeWm6gij14YF_19WGRP7LM4Vjw-UWOTng@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Disconnect devices before rfkilling adapter
To: =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, asahi@lists.linux.dev, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On Sun, Jan 7, 2024 at 1:03=E2=80=AFPM Jonas Dre=C3=9Fler <verdre@v0yd.nl> =
wrote:
>
> Apparently the firmware is supposed to power off the bluetooth card
> properly, including disconnecting devices, when we use rfkill to block
> bluetooth. This doesn't work on a lot of laptops though, leading to weird
> issues after turning off bluetooth, like the connection timing out on the
> peripherals which were connected, and bluetooth not connecting properly
> when the adapter is turned on again after rfkilling.
>
> This series uses the rfkill hook in the bluetooth subsystem
> to execute a few more shutdown commands and make sure that all
> devices get disconnected before we close the HCI connection to the adapte=
r.
>
> ---
>
> v1: https://lore.kernel.org/linux-bluetooth/20240102133311.6712-1-verdre@=
v0yd.nl/
> v2: https://lore.kernel.org/linux-bluetooth/20240102181946.57288-1-verdre=
@v0yd.nl/
> v3:
>  - Update commit message titles to reflect what's actually happening
>    (disconnecting devices, not sending a power-off command).
>  - Doing the shutdown sequence synchronously instead of async now.
>  - Move HCI_RFKILLED flag back again to be set before shutdown.
>  - Added a "fallback" hci_dev_do_close() to the error path because
>    hci_set_powered_sync() might bail-out early on error.
>
> Jonas Dre=C3=9Fler (4):
>   Bluetooth: Remove HCI_POWER_OFF_TIMEOUT
>   Bluetooth: mgmt: Remove leftover queuing of power_off work
>   Bluetooth: Add new state HCI_POWERING_DOWN
>   Bluetooth: Disconnect connected devices before rfkilling adapter
>
>  include/net/bluetooth/hci.h |  2 +-
>  net/bluetooth/hci_core.c    | 35 +++++++++++++++++++++++++++++++++--
>  net/bluetooth/hci_sync.c    | 16 +++++++++++-----
>  net/bluetooth/mgmt.c        | 30 ++++++++++++++----------------
>  4 files changed, 59 insertions(+), 24 deletions(-)
>
> --
> 2.43.0

I will probably be applying this sortly, but let's try to add tests to
mgmt-tester just to make sure we don't introduce regressions later,
btw it seems there are a few suspend test that do connect, for
example:

Suspend - Success 5 (Pairing - Legacy) - waiting 1 seconds
random: crng init done
  New connection with handle 0x002a
  Test condition complete, 1 left
Suspend - Success 5 (Pairing - Legacy) - waiting done
  Set the system into Suspend via force_suspend
  New Controller Suspend event received
  Test condition complete, 0 left

--=20
Luiz Augusto von Dentz

