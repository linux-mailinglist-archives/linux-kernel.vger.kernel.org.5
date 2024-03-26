Return-Path: <linux-kernel+bounces-119169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3234088C50D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5A7A303135
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2327812D778;
	Tue, 26 Mar 2024 14:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhvD/Eqp"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33767535AB;
	Tue, 26 Mar 2024 14:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711463024; cv=none; b=S+KKEsBgxVZPOUPyC33rZOgOVIM5e2D6GQaigSTMOonGgQeVPaCaJhJyrRo04bojzeIjWeJ3+zx2a58RhRfvv6BAjc7+HTes1np19L8JhM6PU+GKuo+EdXWsAlkD4XWoijQN4aStCzpianvJnViU2AwJ+OpzS8twsFHMtdss4kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711463024; c=relaxed/simple;
	bh=nfADaqXf2mRows+WqcUk8dPuz3pddfwkSwgruDyBZBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qGqF76tGSNy+uPSeeZxxezGKRI1d5N355UDgkBUIUeVnwbm11Ee7/76f6laK3IJra1QpN5QWpfUcEJgvtynrHOH2e7tgzDRC/n82XKDIGOiF3Ny2G3CKyU77BOkrG5P5DJj+xEKPSrNB/MyXxF54QrtJcwh0t9uodC/QoiywKHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhvD/Eqp; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-69670267e87so23947746d6.3;
        Tue, 26 Mar 2024 07:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711463021; x=1712067821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WlEltbtsC/qC59Bc8P175TSd5LTY6D+FLI0/UyRfBQ=;
        b=FhvD/EqpwcEgRfK0qCsY+A3SeGWJMD+MxF2ro9aaCZvbrTfbl+3MdHDpPYMgnMM6EO
         kQT/BreDhGVGlx0DX27sDjMEV3bjNKTqFL0YGxpNegfIR2SHGgCAjSgUnT6YFe8yfh36
         o4Ivw5tWnweLddCQW2LqY3o/Ssr80qok6KlYClAp5e4fjSJx53+Sr9tEX0S+yoVfxA37
         HvYW0y0Urdq/TvAbAT/SS7MaG2MVMtDsKJlNQxhWPJUN9s28DBJZx2KttACpXvoweEUv
         O1qdOZEjwM6I9QoFhOCObPaI0X2YpUjNTKtOST1QCZO/gfcPektKCqlvER3AxhdGboDE
         9m/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711463021; x=1712067821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5WlEltbtsC/qC59Bc8P175TSd5LTY6D+FLI0/UyRfBQ=;
        b=dKzC/wjV0oOIYvGIYJi9tilqWYNuMFe6zOVad7Te345Hr/1aE5fTIN/1PJAgxi9r8S
         ULcl7cFuCjfMlxyrQtX+IhPn1iOn2zdgbzCV2LuhRIzTDi8vzwOCPALfyg8vVmbK8xj+
         3mZrnQFUO+hMdFOPyYZfDHd/k2DEcIJasYumgehH6pNe7pGGH9nNzlVZFJDTa8NPXdOx
         nDHy4vnDW7rvqDHUvhcVDd2GVzB9ItmGg5dK4okqjIm3kw9cmSpl9gZtHYS8cjhgvgKu
         YhWdOp4ysY+lCc+hBa63H4S9dC5eFVOu6Fgu0fbQz5wwtaMWVVJsKEG1TJxBen5hPBFj
         cMiw==
X-Forwarded-Encrypted: i=1; AJvYcCVFTrflgfxk5znPooHDuo3XF9tr8GtGj6bTVbWvEVXaC0x5d767GBlmqj8UE0TDJLtoFdH9dbiucsWh9myOOrYn1ymSXko/X7Ui111W7SKCikZnseFsTp/90OVKGqQHmH+x9LiTdWxUvg==
X-Gm-Message-State: AOJu0YwnXweoYxuNksDj0zf+sikIoDaEOnEJZyxcfIwVT1c+J6z2wPA1
	ZmMRyaH5AqKdUb98SsEwA5yT8hnqdbLNWy/CeRc0HaQjxW4zVoZ5tU8J4w1Pf/2gEXh9+Hg8MIL
	T3+b1zKuWfVWOU7yEPHqRkkx7r8s=
X-Google-Smtp-Source: AGHT+IHr56kV7LD9oxJmOW0qZMuMob/X0HygPstUJ04N4UdDTgVfZcW/IbbKZ7LbbBreDxz1UiopPy61BvvE+aU7sps=
X-Received: by 2002:a05:6214:2522:b0:696:76b9:5faa with SMTP id
 gg2-20020a056214252200b0069676b95faamr10833171qvb.3.1711463020999; Tue, 26
 Mar 2024 07:23:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325143511.2144768-1-nm@ti.com>
In-Reply-To: <20240325143511.2144768-1-nm@ti.com>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Tue, 26 Mar 2024 09:23:14 -0500
Message-ID: <CAOCHtYj5gRkTrWiURtnP8o6gW1MVxs2H2gd7Kz4Y8-8_4rNyrA@mail.gmail.com>
Subject: Re: [PATCH V2] arm64: dts: ti: k3-am625-beagleplay: Use mmc-pwrseq
 for wl18xx enable
To: Nishanth Menon <nm@ti.com>
Cc: Tero Kristo <kristo@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh@kernel.org>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Shengyu Qu <wiagn233@outlook.com>, 
	Sukrut Bellary <sukrut.bellary@linux.com>, Javier Martinez Canillas <javierm@redhat.com>, 
	Bill Mills <bill.mills@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 9:35=E2=80=AFAM Nishanth Menon <nm@ti.com> wrote:
>
> From: Sukrut Bellary <sukrut.bellary@linux.com>
>
> BeaglePlay SBC[1] has Texas Instrument's WL18xx WiFi chipset[2].
>
> Currently, WLAN_EN is configured as regulator and regulator-always-on.
> However, the timing and wlan_en sequencing is not correctly modelled.
>
> This causes the sdio access to fail during runtime-pm power operations
> saving or during system suspend/resume/hibernation/freeze operations.
> This is because the WLAN_EN line is not deasserted to low '0' to power
> down the WiFi. So during restore, the WiFi driver tries to load the FW
> without following correct power sequence. WLAN_EN =3D> '1'/assert (high)
> to power-up the chipset.
>
> Use mmc-pwrseq-simple to drive TI's WiFi (WL18xx) chipset enable
> 'WLAN_EN'. mmc-pwrseq-simple provides power sequence flexibility with
> support for post power-on and power-off delays.
>
> Typical log signature that indicates this bug is:
> wl1271_sdio mmc2:0001:2: sdio write failed (-110)
>
> Followed by possibly a kernel warning (depending on firmware present):
> WARNING: CPU: 1 PID: 45 at drivers/net/wireless/ti/wlcore/sdio.c:123 wl12=
xx_sdio_raw_write+0xe4/0x168 [wlcore_sdio]
>
> [1] https://www.beagleboard.org/boards/beagleplay
> [2] https://www.ti.com/lit/ds/symlink/wl1807mod.pdf
>
> Fixes: f5a731f0787f ("arm64: dts: ti: Add k3-am625-beagleplay")
> Suggested-by: Shengyu Qu <wiagn233@outlook.com>
> Signed-off-by: Sukrut Bellary <sukrut.bellary@linux.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Tested-by: Robert Nelson <robertcnelson@gmail.com>

With v6.9.0-rc1 on BeaglePlay..

debian@BeaglePlay-57:~$ uname -r
6.9.0-rc1-dirty
debian@BeaglePlay-57:~$ dmesg | grep wl
[   12.621555] wlcore: wl18xx HW: 183x or 180x, PG 2.2 (ROM 0x11)
[   12.623215] wlcore: WARNING Detected unconfigured mac address in
nvs, derive from fuse instead.
[   12.623253] wlcore: WARNING This default nvs file can be removed
from the file system
[   12.630813] wlcore: loaded
[   13.061833] wlcore: using inverted interrupt logic: 2
[   13.120366] wlcore: PHY firmware version: Rev 8.2.0.0.243
[   13.218832] wlcore: firmware booted (Rev 8.9.0.0.83)
[   13.795189] wlan0: no VHT support on 5 GHz, limiting to HT
[   13.795232] wlan0: determined local STA to be HT, BW limited to 40 MHz
[   13.795303] wlan0: determined AP ba:fb:e4:f5:7b:d2 to be HT
[   13.799461] wlan0: connecting with HT mode, max bandwidth 40 MHz
[   13.802189] wlan0: authenticate with ba:fb:e4:f5:7b:d2 (local
address=3D6c:30:2a:2a:84:f0)
[   13.802246] wlan0: send auth to ba:fb:e4:f5:7b:d2 (try 1/3)
[   13.873457] wlan0: authenticated
[   13.873746] wlan0: no VHT support on 5 GHz, limiting to HT
[   13.873764] wlan0: determined local STA to be HT, BW limited to 40 MHz
[   13.875500] wlan0: associate with ba:fb:e4:f5:7b:d2 (try 1/3)
[   13.881981] wlan0: RX AssocResp from ba:fb:e4:f5:7b:d2
(capab=3D0x1511 status=3D0 aid=3D3)
[   13.889436] wlan0: associated
[   13.889660] wlan0: Limiting TX power to 30 (30 - 0) dBm as
advertised by ba:fb:e4:f5:7b:d2
[   13.990788] wlcore: Association completed.

--=20
Robert Nelson
https://rcn-ee.com/

