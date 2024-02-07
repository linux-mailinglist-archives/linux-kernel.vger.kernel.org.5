Return-Path: <linux-kernel+bounces-56770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C319384CEF0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38E40B25133
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E81981ADB;
	Wed,  7 Feb 2024 16:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huCXfLWQ"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA0A610B;
	Wed,  7 Feb 2024 16:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707323655; cv=none; b=jgBZUlBw3kkavPfoiw/QiVPwbJwBveaTWtH6RMkGOvcqr768LVSKhFIshklHoo1Qq60c88nGmCaYYdkQfnS/QyrI/dquUh3O+ZCqTbEpRdr/74Tx+xeV+0CkGCLjXQ2nz/v5XbdwBAVpxYMbcj/O2I/xl/2wfFob7jUKCsLacro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707323655; c=relaxed/simple;
	bh=1KmexGjyy3Rb9e+8hKvUS8Tyik0iJdqTgZcCXMDSJsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GzzLpXmmhL2HGWRRdl3r6hGgGwjFw8I4QXXyJch8LSgLF03dEzEKKCHOZm/kUgMxOeTqHm3iY+Nhsp0AaZtcMNvPHMaWEs4XcMT905WzKk/SJVPPaZCH7TFZSjveZQwI1usWZ72xhKcUxbFmCFZI9p3HzKd2WEgc3y/xCftKoBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=huCXfLWQ; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5116063585aso992575e87.1;
        Wed, 07 Feb 2024 08:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707323652; x=1707928452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/01Ta/FgtGQKqXggzl01PlQ4TYNsQiYYdgsvvx6IqHo=;
        b=huCXfLWQsBNS7KnGSpGCv5HZizKLos1wGrJ2oryXP2AbE4akdOAgkX0K2/nXdf+1bp
         r+gKavet4huAr03mQsHWThw0KnD6C/m6wPCbp0FAn0gJ0Q9t/IC71nl82C9XQsRIwr2j
         i+I6wrv6zPVxrjMGvwz5Xcij/Cw67geur1lHKAmHEzu34RJVESzG+H7JqEIFusNyoBbC
         93oscACxyaQh99TH20g1EElJrsuoRfHhL/9Yk6xJGP62BU/BVgWsj6mcBkMeq3+aL7DE
         yRwrBEgEi88tDLstl2p+ELPROon8C2emSGZfFjsG5MyomXTZchnfHmYbfg9s9fRIx3GY
         bCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707323652; x=1707928452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/01Ta/FgtGQKqXggzl01PlQ4TYNsQiYYdgsvvx6IqHo=;
        b=MXXzLep7jarUttYJQsaHyC3/eR5Ri6FEFvV1B5u/T50AFvY17j5aOmgXEx11eXLdsK
         mOFpszVN+6JPtYdQPVJG/ZFMPktX6n3bDlK6One39ntjALqw2vo5LVG3dN1o75TAQY4S
         KwZgHa7wiEAlFH1C8B1WeJ8PfUGfV9TrYRitJz0yQuOG0lxmmG68AElEm5KBZXXdhyW+
         WCeF29izR+c+pQjoja122HOr79ASf/MGegKQrnM9DtrydbQStrj5Zu0+3AEu2rFIzwWb
         kwfjBG5L1O75hk3U//FsTl2U4q7xCUbL6PdZDAZj+IRIVews40LKJgDZDRCByLJOE6fx
         Qs5w==
X-Gm-Message-State: AOJu0YwCOgW0Kh4cPtOQAH4qKHBZEpJwyXo7VaT1EMANj6/vUuz7pkSk
	vhXaWNt25Dfk4/nDxVz+DUbm7k+pfh18Uy40utzwxAoUn4Gwi1DxSqtvY9u6EYdPmsjMnmqjt3b
	5378o4YkQYLlcU6L1m4UxfXbzXXmJIQVu20Y=
X-Google-Smtp-Source: AGHT+IFbtBRdRjdgnF47BaPIdc8LarwlW0BzEOe7itqtCRh2ZsqDkxBon3ndtMaIBv0Rj2NssIbH2OpTb0r3qovX+wc=
X-Received: by 2002:a2e:9b1a:0:b0:2d0:b2ce:a90f with SMTP id
 u26-20020a2e9b1a000000b002d0b2cea90fmr4592043lji.43.1707323651658; Wed, 07
 Feb 2024 08:34:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206110816.74995-1-verdre@v0yd.nl> <170732222621.9598.18285805408891036019.git-patchwork-notify@kernel.org>
In-Reply-To: <170732222621.9598.18285805408891036019.git-patchwork-notify@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 7 Feb 2024 11:33:59 -0500
Message-ID: <CABBYNZLtbEnU3wfnym0P8gamh1_5GcUHKvAnxh4GpcBC3G56uQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Bluetooth: Improve retrying of connection attempts
To: patchwork-bot+bluetooth@kernel.org
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On Wed, Feb 7, 2024 at 11:10=E2=80=AFAM <patchwork-bot+bluetooth@kernel.org=
> wrote:
>
> Hello:
>
> This series was applied to bluetooth/bluetooth-next.git (master)
> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
>
> On Tue,  6 Feb 2024 12:08:12 +0100 you wrote:
> > Since commit 4c67bc74f016 ("[Bluetooth] Support concurrent connect
> > requests"), the kernel supports trying to connect again in case the
> > bluetooth card is busy and fails to connect.
> >
> > The logic that should handle this became a bit spotty over time, and al=
so
> > cards these days appear to fail with more errors than just "Command
> > Disallowed".
> >
> > [...]
>
> Here is the summary with links:
>   - [v4,1/2] Bluetooth: hci_conn: Only do ACL connections sequentially
>     https://git.kernel.org/bluetooth/bluetooth-next/c/456561ba8e49
>   - [v4,2/2] Bluetooth: Remove pending ACL connection attempts
>     https://git.kernel.org/bluetooth/bluetooth-next/c/8e14d581d125
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html

Something is not quite right with these changes:

L2CAP BR/EDR Client - Timeout - test passed
L2CAP BR/EDR Client - Timeout - teardown
Bluetooth: hci0: command 0x0408 tx timeout
  Index Removed callback
    Index: 0x0000
L2CAP BR/EDR Client - Timeout - teardown complete
L2CAP BR/EDR Client - Timeout - done
L2CAP BR/EDR Client - Timeout                        Passed      22.329 sec=
onds

The test seems to be blocked on teardown then the command times out,
0x0408 is HCI_OP_CREATE_CONN_CANCEL so I wonder why it would be timing
out. Anyway the test uses SO_SNDTIMEO to set a timeout at the socket
level but it doesn't seem it is used while creating the connection so
it probably needs to be passed down or something.


--=20
Luiz Augusto von Dentz

