Return-Path: <linux-kernel+bounces-14162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30054821899
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 993A2282C15
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 08:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA78F5697;
	Tue,  2 Jan 2024 08:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTXOfP7S"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC67B5663
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 08:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3373bc6d625so1409331f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 00:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704185645; x=1704790445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NNmcx7TBPLi2ciP9FevoCv9jZLtaLUY+av30BElAeo=;
        b=WTXOfP7SXG15/yW5ctbnUP+99ZqMQlyZrTxBp4vUdf6DF/phT4UnjyStZqUaNZYxQy
         E72HDdi/buDpvpoCpWI5kZZ3gmzSaJk6UiIqASei2U5NQI5cSJNMRmzUdobQ4SYl4Z38
         yVFuPDFzGF3LnU7ulOQ6mrn0+L8DzbFK4pmqMIcjVOLnRybvZ8Bcv3EcEodXH01DCSkF
         kF8wRhmP2A40IfBpscTt2wAPuhZKAjEQgjAgXh4nxd/Xe6+bWrwTCsjSBabKeKyavFnJ
         B3PEzdRbygL06nIkiWxeMOS3TvmjYyt3mUkW8imkOdMgOEv95Two3Wl9dBW6FOZ4XUt8
         Z9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704185645; x=1704790445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5NNmcx7TBPLi2ciP9FevoCv9jZLtaLUY+av30BElAeo=;
        b=Tc9TLFDqetDOdGUVidX6zZW6K1J2iyDTVgb3PGYnq4t3cSvTjMAoVLYUwyvLsB/m0T
         WaeHr/G57lRnkSUebqryenzUG9AUC5PS6N9zrI1CKi7E8Ct3pdP4zsgPw52IhJM5vUEh
         nJufR0qnLG1hCE3697yyy1mw1ZxMyrek7y8OS96D8pf8MNNWxKOYCD8djraby4WwRgV+
         UnQmfkvxuoUawYZaBZiZOutAbwnLQzd7ATY7cpDKtTQICRmjSYCb2mo/LXzx+YxtRKPf
         Zi9GXTKWFmtid5V0JF2/ZynLZ5+A6KzAB7fe4k6GYs+Ylv5Co+cD5DzMj0Nw4xeXx8Bc
         Shtg==
X-Gm-Message-State: AOJu0YxlkqhTNk4xcnMT/Bi886kGs3QoP1Lit/Sz90Jk75xB3sJDm6Zu
	5IZSx4C/t9Hy0Dj0l9Yb4Z4XUk0HCZ8wq4c9uUI=
X-Google-Smtp-Source: AGHT+IGmEBVC6QmLkr2u/DGR4Z8YeQsIxHel3kxMKQ31by4vS1Rjc60Y1hpKAbNYu9WycFhjQJ0/GOzjopDGz/X6bag=
X-Received: by 2002:adf:f248:0:b0:336:7d12:fe4 with SMTP id
 b8-20020adff248000000b003367d120fe4mr9673406wrp.137.1704185644797; Tue, 02
 Jan 2024 00:54:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJNi4rO+Dw5qYDtyJVbuo0OqAoXpGq_Qq6xjH9cvMCAUnW+77g@mail.gmail.com>
In-Reply-To: <CAJNi4rO+Dw5qYDtyJVbuo0OqAoXpGq_Qq6xjH9cvMCAUnW+77g@mail.gmail.com>
From: richard clark <richard.xnu.clark@gmail.com>
Date: Tue, 2 Jan 2024 16:53:53 +0800
Message-ID: <CAJNi4rMHtM=39jzkzwqt++kVpSp0=XfDrVdY94WoW6B34oKwDA@mail.gmail.com>
Subject: Re: undefined reference to `__aarch64_cas4_sync' error on arm64
 native build
To: gcc-help@gcc.gnu.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ah, the driver is trying to use the native gcc built atomic ops like:
__sync_val_compare_and_swap, but it seems the native aarch64 doesn't
provide these builtin atomic primitives while they are in the cross
compile toolchain.
The issue can be resolved by replacing the
**__sync_val_compare_and_swap** with **atomic_cmpxchg**.
But don't know why the native aarch64 toolchain doesn't have those
builtin atomic functions...

On Tue, Jan 2, 2024 at 11:29=E2=80=AFAM richard clark
<richard.xnu.clark@gmail.com> wrote:
>
> Hi,
>
> I have a strong power arm64 box, and the linux distro is ubuntu 22.04,
> the native gcc version is:
>
> $ gcc --version
> gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0
> Copyright (C) 2021 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is N=
O
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOS=
E.
>
> It will abort the kernel build with the complaint by 'make Image':
> ld: Unexpected GOT/PLT entries detected!
> ld: Unexpected run-time procedure linkages detected!
> ld: ID map text too big or misaligned
> ld: drivers/net/nvidia_eth.o: in function `osi_lock_irq_enabled':
> osi_hal.c:(.text+0x3cc): undefined reference to `__aarch64_cas4_sync'
> ...
>
> But the cross-compile with aarch64-linux-gnu-gcc on the x86 box
> doesn't show the above error message.
> Any comments/suggestions? Thanks very much!
>
> Richard

