Return-Path: <linux-kernel+bounces-42927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 545308408B5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D75CB1F22266
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA37C152DF2;
	Mon, 29 Jan 2024 14:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="El8Q78qb"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF1C151CE0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706539078; cv=none; b=Xzfg5NtRBeUv3fSqxE4KITOOWX14kagoDcB8AOMMeSkK13MGPR4yWp1dIORAkY3w8c2cRNvZzuX78OOn55pZhTz18XE/GJC5lt6ffgd5LE3DBiOFzXTGBSIuMb9OXKrCr3lRb594EEJGanyTrdpPVvKvcIOxOWZRmA/FcMC+8S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706539078; c=relaxed/simple;
	bh=SmWaA/jXBIlPgwAcnJn6HDF5NUaZECMDSYWUbzda9r8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a+zydCwsTBQ4HfV9/vjXianpukHPcAoavr2iFiBXGTDpH5HG7DoxdDDnyLMGYIiAJeY1uUB/9z45sJPsfN/wYrQZLOyYWbX/XSnxKemNqxD3DQGeNL1Rb5TEYlIltPXxBi9stxSgssq8G57U1LDr6nsQ8ELcrccSDOjlPJl4DqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=El8Q78qb; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e60e135a7so26356355e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 06:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706539074; x=1707143874; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SmWaA/jXBIlPgwAcnJn6HDF5NUaZECMDSYWUbzda9r8=;
        b=El8Q78qbjmyOVCC4xkZZ4quoatMRN7ejL0miRg2KVswoomaRcJu0qW3x6LaeCr0+iT
         mAIqA9ZOf845bjZ5SeKtzbjGjeyQV0ee3indEK2UH3jVVJewTRI8MrywK9uCtc82bc91
         B6vJLp1kswzhewyq2YHV6SBj938Ol5B/QQHL+2RQnQUf31OhQCAJfvIjl6m4ylfl7ta7
         q2PyJeefcHwJaSwXs6wK53vI9U8jZv0mhjXAEK3clOFgmdVHf2Aewx/wWoLfz33mChKI
         ZwTUsFtLYhki/xJmi/JmgOMKW4IUERXll87J/0+RFsWpzN+kqIJS1FXHJgKRAdppGfmb
         IyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706539074; x=1707143874;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SmWaA/jXBIlPgwAcnJn6HDF5NUaZECMDSYWUbzda9r8=;
        b=lLaqNyK2S9jG9QWx3H56spAFMbzi07plsbl1F6WxBo7IoK8x2E/QkeaKZtiMfOJrBb
         smHkZrvUc5r/vGteEtQ2zbXJ+52KggVo0fyl1yc+27DU8lS+jikIfKYMcswta22gZWM/
         2oQbBLaCjNtF3Rekd98+VSBbL83LCfjbJV26Y77Zg/D3kbKE2vxc5Yplfx5Vhv/93gO6
         CWS9WWigDtuAhNeV57fhiOirrqAiyGbLHP27E1UchbxHgiBjVqTtkHt9am4IEBH7oGhJ
         HT6xmo7LyXFpju8l+xXZPtQjaEThLLY7h7MihUW1kE9R0xFh20Wbh6vO374NijNF7IsU
         dKng==
X-Gm-Message-State: AOJu0YzyRzDq6JkEVg4HZ6WYeZxfmGXtn4ZaGfN87PJuKbXyQAEosm7m
	+cWVK+ZK0VcksDNpP6iydwB7bb6QfiLozCumfBNU4IAXZcEC8dnXrSpK4Q9XRcM=
X-Google-Smtp-Source: AGHT+IFlhYu+Wi9LgAtOmfbOEKRnmv6zUQNGWbIWu5r4mGku1fc+uQFrXI3/gxZ2Vg9uB2zaQSX1sA==
X-Received: by 2002:a05:600c:20d3:b0:40e:ac8f:e6c with SMTP id y19-20020a05600c20d300b0040eac8f0e6cmr6041047wmm.30.1706539074163;
        Mon, 29 Jan 2024 06:37:54 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id cl10-20020a5d5f0a000000b0033aeb20f5b8sm3906577wrb.13.2024.01.29.06.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 06:37:53 -0800 (PST)
Message-ID: <d45de3b2bb6b48653842cf1f74e58889ed6783ae.camel@linaro.org>
Subject: Re: [PATCH 5/5] clk: samsung: gs101: don't mark non-essential
 clocks as critical
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: peter.griffin@linaro.org, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@android.com,
 tudor.ambarus@linaro.org,  willmcvicker@google.com,
 alim.akhtar@samsung.com, s.nawrocki@samsung.com,  tomasz.figa@gmail.com,
 cw00.choi@samsung.com, mturquette@baylibre.com,  sboyd@kernel.org,
 linux-arm-kernel@lists.infradead.org,  linux-samsung-soc@vger.kernel.org,
 linux-clk@vger.kernel.org,  devicetree@vger.kernel.org
Date: Mon, 29 Jan 2024 14:37:52 +0000
In-Reply-To: <CAPLW+4mL1gb_R8PhKaMhwOUTa0GDqat_9W=348ScYj+hBarQJg@mail.gmail.com>
References: <20240127003607.501086-1-andre.draszik@linaro.org>
	 <20240127003607.501086-6-andre.draszik@linaro.org>
	 <CAPLW+4mL1gb_R8PhKaMhwOUTa0GDqat_9W=348ScYj+hBarQJg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Sam,

On Fri, 2024-01-26 at 21:30 -0600, Sam Protsenko wrote:
> On Fri, Jan 26, 2024 at 6:37=E2=80=AFPM Andr=C3=A9 Draszik <andre.draszik=
@linaro.org> wrote:
>=20
> >=20
> > Note that this commit has the side-effect of causing earlycon to stop
> > to work sometime into the boot for two reasons:
> > =C2=A0=C2=A0=C2=A0 * peric0_top1_ipclk_0 requires its parent gout_cmu_p=
eric0_ip to be
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 running, but because earlycon doesn't de=
al with clocks that
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 parent will be disabled when none of the=
 other drivers that
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 actually deal with clocks correctly requ=
ire it to be running and
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the real serial driver (which does deal =
with clocks) hasn't taken
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 over yet
>=20
> That's weird. Doesn't your bootloader setup serial clocks properly?
> AFAIU, earlycon should rely on everything already configured in
> bootloader.

I tried to explain that above, but let me try again...

The console UART, and I2C bus 8 are on the same cmu_peric0 controller, and
that cmu_peric0 has two clocks coming from cmu_top, ip and bus. For I2C8 & =
UART
to work, both of these clocks from cmu_top need to to be on as they are the
parent of the i2c8-(ip|pclk) and uart-(ip|pclk) each.

The bootloader leaves those clocks running, yes. So earlycon works (for a
while).

At some point into the boot, one of two things happens:
1) Linux will load the i2c driver. That driver does clock handling
(correctly), it will initialise and then it has nothing to do, therefore it
disables cmu_peric0's i2c8 ip and pclk clocks. Because at that stage nothin=
g
appears to be using the cmu_peric0's ip clock (the real serial driver hasn'=
t
initialised yet), Linux decides to also disable the parent ip clock coming
from cmu_top.

At this stage, the earlycon driver stops working, as the parent ip clock of
the uart ip clock is not running any more. No serial output can be observed
from this stage onwards. I think what is probably happening is that the
console uart FIFO doesn't get emptied anymore, and earlycon will simply wai=
t
forever for space to become available in the FIFO (but I didn't debug this)=
.

Anyway, the boot doesn't progress, the system appears to hang. In any case =
it's
not usable as we have no other means of using it at this stage (network /
usb / display etc.).

2) Alternatively, the UART driver will load at this stage. Again, it will
tweak the clocks and after probe it will leave its clocks disabled. The
serial console driver hasn't taken over at this stage and earlycon is still
active. Again, the system will hang, because IP and PCLK have been disabled
by the UART driver. Once the serial console is enabled, clocks are being
enabled again, but because earlycon is still waiting for progress, the
boot doesn't progress past disabling ip and pclk. It never gets to enabling
the serial console (re-enabling the clocks).

So in both cases we get some output from earlycon, but the system hangs onc=
e
the first consumer driver of an IP attached to cmu_peric0 has completed
probing.



> > =C2=A0=C2=A0=C2=A0 * hand-over between earlycon and serial driver appea=
rs to be
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fragile and clocks get enabled and disab=
led a few times, which
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 also causes register access to hang whil=
e earlycon is still
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 active
> > Nonetheless we shouldn't keep these clocks running unconditionally just
> > for earlycon. Clocks should be disabled where possible. If earlycon is
> > required in the future, e.g. for debug, this commit can simply be
> > reverted (locally!).
>=20
> That sounds... not ideal. The ability to enable earlycon just by
> adding some string to bootargs can be very useful for developers.
> Maybe just make those clocks CLK_IGNORE_UNUSED, if that keeps earlycon
> functional? With corresponding comments of course.

CLK_IGNORE_UNUSED doesn't help in this case, the i2c and uart drivers will =
load
and probe before earlycon gets disabled and as part of their probing disabl=
e
the cmu_top ip clock going to cmu_peric0

If earlycon is not enabled in kernel command line, everything works fine, t=
he
kernel buffers its messages and once the real serial console driver starts,
all messages since boot are being printed.

Other than keeping it as CLK_IS_CRITICAL, there is no way that I can see to
way to make the hand-over from earlycon to the real serial driver work in
all cases.

They are not critical clocks for the system, though, so it's wrong to alway=
s
keep them running unconditionally.

We are past a stage where earlycon is generally required.

If it's required for some local development, people can revert this patch l=
ocally.


BTW, downstream doesn't suffer from this problem because downstream uses AC=
G
throughout and clocks are enabled automatically in hardware as required.


Cheers,
Andre'


