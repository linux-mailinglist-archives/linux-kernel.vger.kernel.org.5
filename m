Return-Path: <linux-kernel+bounces-119528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C69488CA4E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01B6DB23C05
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA4913CF84;
	Tue, 26 Mar 2024 16:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUmah7Wj"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DC013CC6E;
	Tue, 26 Mar 2024 16:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472226; cv=none; b=c4O4kQuATXK74qtVsqEYJNYgTdiEkgFfiDq3/C9m4W21ytMtJJGf27hlfnhLAu5MqPI+7lB8dxLmUbMSjNnYJHGaTfMmZeUgmB4f/K/WJQmKVeqbJMBiuuVxYXUK2J5HSktSPK4xOZvGnqcbibsItLZom9rjucPXlyYa/44lGtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472226; c=relaxed/simple;
	bh=2qeRp3NpCuiDAJ/3gyrJI5txbBbOCmyfgeNGwUJ34QM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IeXg1uaGseb1Pp1ZlAIDk27kRWKZJBf9fWxNT8l/WxVJGTo8tcFIDUmIDI5V+g8uLPq5C5U4wTKnmspeft3Yew8Oax3X5ENGvdCNX/xEtYg2Zvu5LT5UTNxtzIH0vue1EEnohBdI9hP9zwv1RqQzmAy+EadInUQnZEDfP1ls988=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUmah7Wj; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d4a8bddc21so77179501fa.0;
        Tue, 26 Mar 2024 09:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711472223; x=1712077023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IU22RLww3/XOivsSv4VG6tutKJTJKSIdnxTJz7w+A7w=;
        b=HUmah7WjkPthCGovK7uX3sqd34N05gU2mlDf7HGgBtoknB48xqyAnLyVvmMfJo3MAO
         q+BheaODd55QOjq6D/kuq6HjFsXZIYuRl7QGZGaIYREf7itqFrdQNOvlMO5vvW2Lck1v
         8dDbNm3wiyOZQ+PGwCCxL//PVx66knjqcXznJy5hPWRUqt7s+s+NWVA4sa68mI5K45ZP
         0V9ptv0cZ/LmAmBBdl7QNJxCrfrkO3aLWpFe756hTIY+1/91IlEUitAvtfujGrjWRPHg
         DkBZEZEOJ8v37ZHmRTbz0Pjo8DvryK/Pd9P/taIiLS64+4pzzsEZ6fEWcVp77w+VoSmD
         X53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711472223; x=1712077023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IU22RLww3/XOivsSv4VG6tutKJTJKSIdnxTJz7w+A7w=;
        b=jfTIOkq7oh+4neD1K6WgzXmcOR3/q3O4p0YXiGXEsdro1rxxkBIuYMPwXZ18X3ClRV
         zJREihTa19G9Zvg0hNE06GQoMsbZMs8E2I3UhEx02UqXdvjH6SZYwHLjRb2UwSQu5SQH
         i71asi9zdYrSMBMOMBaueNgVafiZ1OG14Rr/fjjXpccOmY5SltWnyJ3e1cpzqYwWbi0D
         sqKt5pMjJYb/IwIScEQEUsj7Wv7eUO/MA23/sVD4UiZxECOL8HxmK7yj2OaUQfLVfceJ
         u7eiuL3Oq94o57VtsfANMONhULfQscvJurUSgXc99ZfArjw32xgOlKrBIyRAfws6S4vx
         nPMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWkxQv/G48hyzhWY/XwriG075YVHO8r3hXMO7jhcCVacdSkUJW21gCXFQ8vI6canEfnl64YOCNZ00AshoYfiflveS7ZHkp1kT291AhHq6W7yWRvwikW0vb0jg6VBJOzPtlyIPU1tFiZxK8NVeJ
X-Gm-Message-State: AOJu0YxPvNAMv9ReoBwELDWHTU4NiDPJDAqRJ0XVuCrGLoN6Vsj1crZi
	RpAenAY2eQjhgYLvbFuwPwhGEOAbnH4rzxKmLHD2u6+fALQYiNBekhHH3uvt4UUmzoEo/mHwNRG
	6ZuWwSGPkDrkrqDnepbw0NC76KX7b/CbZ09k=
X-Google-Smtp-Source: AGHT+IG1ZbFTx/MVVy6KI+dZ/kXiCyWDzCYWscY6etooM2mCnGEIMPlRg7hdSoLTGuQbmIXPG1EoR/a1KhikHD0w/O4=
X-Received: by 2002:a2e:b8cb:0:b0:2d2:dac3:90f with SMTP id
 s11-20020a2eb8cb000000b002d2dac3090fmr157304ljp.52.1711472222756; Tue, 26 Mar
 2024 09:57:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <08275279-7462-4f4a-a0ee-8aa015f829bc@leemhuis.info>
In-Reply-To: <08275279-7462-4f4a-a0ee-8aa015f829bc@leemhuis.info>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 26 Mar 2024 12:56:50 -0400
Message-ID: <CABBYNZKDa9KR8A_4TbpPyiLWFFH22T=Z9jk7N=o6U+z1oB+7vg@mail.gmail.com>
Subject: Re: [REGRESSION] Oops during init in btintel_read_debug_features with
 today's mainline
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
	Linux kernel regressions list <regressions@lists.linux.dev>, 
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thorsten,

On Tue, Mar 26, 2024 at 4:44=E2=80=AFAM Thorsten Leemhuis <linux@leemhuis.i=
nfo> wrote:
>
> Lo! Just booted 6.9 for the first time and noticed the Bluetooth code
> causes an Oops (see below) during boot that did not happen with 6.8 and
> earlier. This is on Fedora 40 with a vanilla kernel on a Lenovo Thinkpad
> T14s Gen1 AMD.
>
> Do I need to bisect this? Or is this known already? Or does anyone by
> chance an idea what might cause this? Or is there some other way to get
> down to the problem?
>
> Ciao, Thorsten
>
> [Full dmesg: https://www.leemhuis.info/files/misc/dmesg-6.9-btprob]
>
> [   19.903869] Bluetooth: hci0: Found device firmware: intel/ibt-20-1-3.s=
fi
> [   19.903908] Bluetooth: hci0: Boot Address: 0x24800
> [   19.903913] Bluetooth: hci0: Firmware Version: 255-255.255
> [   19.906245] usb 6-4: USB disconnect, device number 3
> [   19.906364] usb 2-2: Found UVC 1.50 device Integrated Camera (04f2:b6c=
b)
> [   19.906583] Bluetooth: hci0: FW download error recovery failed (-19)
> [   19.906649] Bluetooth: hci0: sending frame failed (-19)
> [   19.906666] BUG: kernel NULL pointer dereference, address: 00000000000=
00070
> [   19.906672] #PF: supervisor read access in kernel mode
> [   19.906677] #PF: error_code(0x0000) - not-present page
> [   19.906681] PGD 0 P4D 0
> [   19.906688] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [   19.906701] Hardware name: LENOVO 20UH001HGE/20UH001HGE, BIOS R1CET77W=
(1.46 ) 10/26/2023
> [   19.906706] Workqueue: hci0 hci_power_on [bluetooth]
> [   19.906775] RIP: 0010:btintel_read_debug_features (/usr/src/debug/[...=
]/drivers/bluetooth/btintel.c:1306) btintel

Seem like the following could be reason:

https://patchwork.kernel.org/project/bluetooth/patch/20240326164317.1460864=
-1-luiz.dentz@gmail.com/

