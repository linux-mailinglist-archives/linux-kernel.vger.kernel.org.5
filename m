Return-Path: <linux-kernel+bounces-112464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9F6887A2F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 20:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24B5928202E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 19:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B781D5A0ED;
	Sat, 23 Mar 2024 19:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ht+b5B02"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544F15491E;
	Sat, 23 Mar 2024 19:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711221562; cv=none; b=IIpjJk5KaCGIV932r+6WcZIb7UsmfpM0XbTFcfsxPuXlKaTcHCs9fnPvQxysda6DRb15ADexbkGjDWML8mYEIK4sr+1CsKkwPVmSPZB3eoXTn8b1ZZaUEADu80gLDWCuMhhkJoOUMF/ibesFgUcCmBL8aKjqgtpBdCszXRKniAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711221562; c=relaxed/simple;
	bh=B5H1PblavKAzgnphm3RFVMD2i0BJwgN0qdA5tEYgrE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NAYDJdVKf+S2mwGGI3fEdl5kb6IZQnQZ84SBFdH2upv/VW44A8zbjP65KIXy5xMWOLS8gJVH1n7Lqj0obmzjOjjPngQVDXuegYdaVjJ/mYn9XDbvZ2GgjrK+T0sWVr922xNNpTlTpDd3XUmMgBCjKu2rWKfq96VweMm0cKzSNdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ht+b5B02; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-34175878e30so1992384f8f.3;
        Sat, 23 Mar 2024 12:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711221558; x=1711826358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yixKxMyJp9zitpdKye9pLVcWEHJONLO0fUVkk9RNx2Q=;
        b=ht+b5B022yADnDN4bBtI8hIFZg6LP/qjoqSbPdqEGKF3W77asD0frBQ5Kw3XdZwQYK
         nHavVdO5CaNHbr8HvQPLIr5wFr78x4bHiCFsqkhk+M7N1DWJOtVp243RPanS0rHQNNYZ
         rHkE7EkevI0Vns01+SQfErkfW17U8hplCAa5EyFjWolpmpVY70Ckdcp7m0/7Z0nY2aEl
         0abQz6lAEitw4cPUS0gxZWRg2ejgBs5IBx9WtwdWGQd1hzcn7hWfofuzWMwohwLKMgOA
         tfV8/DZhFvhbzs13+TzljnOhT90p4dvBHvRbwu5UFoRHzUl4dHlGNOi/8zH0HqtO9vbM
         aYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711221558; x=1711826358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yixKxMyJp9zitpdKye9pLVcWEHJONLO0fUVkk9RNx2Q=;
        b=F2dUdakindcc5Y8sDzuBkNt9i5lxawf6f0qHqE6tnttZdk4sIHwBiuNRWY2sJd7CBy
         CFMDPi9tfbNBYSWIsK9Ve6Qc6k532MWnkKlvAmWWbXJ8C8/opMzsZYUkcurS2z4IzLEF
         YeDF9GI5RXQOlwoO5IxHWYSi8ToXMjhk98UCugV9JKzMgaAFtI3DzvA8ozo1DfbXHDs2
         ZZknxxhcTZubitQwxZ7qzMLP5JIiQT7cYYa5v6HGm+RRCdIVuiJN55RU8JZCp5xgriF3
         /oTNrGUTM4LM2TNfByOt6UW/TuR0ViSjP1tug+DiJKV2QGenSvY/sF/xLigl+/HBvW7u
         wWhA==
X-Forwarded-Encrypted: i=1; AJvYcCWIeaQ/yiBpH2/hsPlo1ilbVrmGWbW1/Q/mj/lYUpLY0mNt9n+PMhtL1TwavvqIOG/JF4WlslG8qKucixGp+ulx+9Ej+OZsA3Uc30xeXt974R4DuKvjyStaBnI1QMrx9Bdc1XtgcDTzxMG2ijeNLuU+ozIdYh1pNbMfa3Fj0oPzOE4qLKz+sub0QqtOv3wrCcBUurTs5GF9dyTu4eEbpsHOcteP88UhdDEXpVBZ2vsoD1uht87SBw==
X-Gm-Message-State: AOJu0YwIAcN4l75cdLzOXsAwgQs/J5QMQVzKbRZiIRYnXK7mmjuTvy9F
	fEWYgQ2l8OtkYV3cNvaupghGRqHYDGAVVgsqE5Cv1Qgp5wwyzrzDyNuLvlhFvb5pZRI/Z3DCvPX
	A0Tbi7m9tlRh5OUdEq0THSn/jme8=
X-Google-Smtp-Source: AGHT+IHc7Rh/6RhzPxJ4eOoWSDDR7HLjhbFFeaswIwMDe7FN91r00me6FYQkMfPJGtPtWcjqOEHpzi5SqTmnbXU+fPk=
X-Received: by 2002:a5d:5cc6:0:b0:33e:c522:a071 with SMTP id
 cg6-20020a5d5cc6000000b0033ec522a071mr1942577wrb.51.1711221558546; Sat, 23
 Mar 2024 12:19:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1711113657.git.hodges.daniel.scott@gmail.com> <ac8e77881212e18d117059a698affd6afc2607af.1711113657.git.hodges.daniel.scott@gmail.com>
In-Reply-To: <ac8e77881212e18d117059a698affd6afc2607af.1711113657.git.hodges.daniel.scott@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 23 Mar 2024 12:19:07 -0700
Message-ID: <CAADnVQ+BsBcp5osqiG46gjtLViQjHStVnPsySffHsybaz7OYEw@mail.gmail.com>
Subject: Re: [PATCH 1/3] leds: trigger: legtrig-bpf: Add ledtrig-bpf module
To: Daniel Hodges <hodges.daniel.scott@gmail.com>, 
	netfilter-devel <netfilter-devel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
	linux-leds@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 7:08=E2=80=AFAM Daniel Hodges
<hodges.daniel.scott@gmail.com> wrote:
>
> This patch adds a led trigger that interfaces with the bpf subsystem. It
> allows for BPF programs to control LED activity through calling bpf
> kfuncs. This functionality is useful in giving users a physical
> indication that a BPF program has performed an operation such as
> handling a packet or probe point.
>
> Signed-off-by: Daniel Hodges <hodges.daniel.scott@gmail.com>
> ---
>  drivers/leds/trigger/Kconfig       | 10 +++++
>  drivers/leds/trigger/Makefile      |  1 +
>  drivers/leds/trigger/ledtrig-bpf.c | 72 ++++++++++++++++++++++++++++++
>  3 files changed, 83 insertions(+)
>  create mode 100644 drivers/leds/trigger/ledtrig-bpf.c
>
> diff --git a/drivers/leds/trigger/Kconfig b/drivers/leds/trigger/Kconfig
> index d11d80176fc0..30b0fd3847be 100644
> --- a/drivers/leds/trigger/Kconfig
> +++ b/drivers/leds/trigger/Kconfig
> @@ -152,4 +152,14 @@ config LEDS_TRIGGER_TTY
>
>           When build as a module this driver will be called ledtrig-tty.
>
> +config LEDS_TRIGGER_BPF
> +       tristate "LED BPF Trigger"
> +       depends on BPF
> +       depends on BPF_SYSCALL
> +       help
> +         This allows LEDs to be controlled by the BPF subsystem. This tr=
igger
> +         must be used with a loaded BPF program in order to control LED =
state.
> +         BPF programs can control LED state with kfuncs.
> +         If unsure, say N.
> +
>  endif # LEDS_TRIGGERS
> diff --git a/drivers/leds/trigger/Makefile b/drivers/leds/trigger/Makefil=
e
> index 25c4db97cdd4..ac47128d406c 100644
> --- a/drivers/leds/trigger/Makefile
> +++ b/drivers/leds/trigger/Makefile
> @@ -16,3 +16,4 @@ obj-$(CONFIG_LEDS_TRIGGER_NETDEV)     +=3D ledtrig-netd=
ev.o
>  obj-$(CONFIG_LEDS_TRIGGER_PATTERN)     +=3D ledtrig-pattern.o
>  obj-$(CONFIG_LEDS_TRIGGER_AUDIO)       +=3D ledtrig-audio.o
>  obj-$(CONFIG_LEDS_TRIGGER_TTY)         +=3D ledtrig-tty.o
> +obj-$(CONFIG_LEDS_TRIGGER_BPF)         +=3D ledtrig-bpf.o
> diff --git a/drivers/leds/trigger/ledtrig-bpf.c b/drivers/leds/trigger/le=
dtrig-bpf.c
> new file mode 100644
> index 000000000000..e3b0b8281b70
> --- /dev/null
> +++ b/drivers/leds/trigger/ledtrig-bpf.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * LED BPF Trigger
> + *
> + * Author: Daniel Hodges <hodges.daniel.scott@gmail.com>
> + */
> +
> +#include <linux/bpf.h>
> +#include <linux/btf.h>
> +#include <linux/btf_ids.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/leds.h>
> +
> +
> +DEFINE_LED_TRIGGER(ledtrig_bpf);
> +
> +__bpf_hook_start()
> +
> +__bpf_kfunc void bpf_ledtrig_blink(unsigned long delay_on, unsigned long=
 delay_off, int invert)
> +{
> +       led_trigger_blink_oneshot(ledtrig_bpf, delay_on, delay_off, inver=
t);

A new kernel module just to call this helper?
Feels like overkill. Can it be a part of generic led bits?
btw, have you looked at net/netfilter/xt_LED.c ?
netfilter had the ability to blink led for a long time.
I'm curious whether folks found it useful.
It can also do led_trigger_event().
Should that be another kfunc?

