Return-Path: <linux-kernel+bounces-54671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4818084B246
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAA6028A11D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB2C12EBC8;
	Tue,  6 Feb 2024 10:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGVr0WG9"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9196712E1EA;
	Tue,  6 Feb 2024 10:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707214536; cv=none; b=SMu05PZksFvnAQ2sCf0yg5fFwkRkS04ztS6X9K8iif7Ymmz7GfKp+mayLQoSAxDgNkMq45fOBhcNlRatMMWzW3ifdDu2txAuBG4F7dTo7NXXc+hCyA+qwuNPHkgWlXtTltZ4sTH91UZfVGpQvygJ3navAmB2WmkNVeDRL9kDNlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707214536; c=relaxed/simple;
	bh=NU0wUOtLvFHwfzDoj0jCdIm6HZiUzmqQsNqRBeYEo+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UWKoldcjF8G/T09qgOyDz0SVwtdmRy1VcTKKVHqycVoADq1//ONoOhGYW/j9Dt+We/4xJOcdEn1Sa6/2KNhMq678WgZCAtGnPpFxmDLjpX0jqM8Ja2dXk4/iN7Qd61M4nqDNxdiH/GFXVmkPZJO6tpJ/EpQ50XtvK/BVv6lyd00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGVr0WG9; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-219108b8e9cso2738627fac.2;
        Tue, 06 Feb 2024 02:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707214533; x=1707819333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBS8Yh5YqiclAyOZKBpe4qOml9BTzdnh4IdKzV2sbVc=;
        b=IGVr0WG9UzFPMUCSCkP4IgYd0zVcy0RTOYZDlxMam/dbfAIvUNQCeOxEKTg+/ideMi
         izlTNqlrVnGDjv8EplI236H384qpck7S5CaHie6J3vwSiR+RcrvLcNeOJgt37CULdVsQ
         H7ZOw11fD7bKLnXMZGwnzb+hHRc4YDhwTdh4PB6Kv3tmOvhgm/KbsDGzPZfJ4cdkZu1N
         +HHrUEIYJR6UukpZ2Yy0AHJXvGnXhGWqLKMPS2Vr/dyEC3oDiibBCbxgfaMDRSvtUoh7
         rtREDbNN43qr2liZ1PVei3PLx3lsFzP/Bd6dHsEwwZ+2vwCp30b93Mn8aAUExsO26K3b
         OQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707214533; x=1707819333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBS8Yh5YqiclAyOZKBpe4qOml9BTzdnh4IdKzV2sbVc=;
        b=qzTTMMZz+/OO2iOqbMH4f2arMI4G5sSgaGwqI+Hd3U6CbZvNkWNdtqIJLPEqo1MQfR
         KO7iF6vou0Q8Mn082I063NiGzOUdpZKs/2cNIUxjYoGMXmZ2TxQ0+WU1On3OCc8SQTuz
         0I86EWeMWvfRJe48Uwhl86KSvRK+XlWvlH0qCOZrZlB7A4/p2Z1EiTl3zVsa0hblk4q0
         yIGgHXKZhbM1oRt9RwpwU8fenUrmiPlHGzVpKyLCPLCY8Fd1HDjdTQb+H18rcoKgocex
         CP0qo7Nqw54dY2JwSgPBW8+50dPynVfGzLN5WXhOgUpPeYhyyDkvaJGWh6W3B7XjgQPo
         eoYA==
X-Gm-Message-State: AOJu0YwZIvr8k0GzkLh4A9xKmb2wQYz4Yr0emem4KcYncj1gdYYqGTpg
	5kzQhWoQAoih5sdcqKG6R5VtOrqPgWyL1F/R2nSIAM93MX0gw2/iCLg5Z0Jwu0IuhY5+k1cgk1P
	impQYcH/mAkF9ELMcXueTrocV5Rs=
X-Google-Smtp-Source: AGHT+IE2mLfhffrLED1DRY8tjKQ/AgIN/G3/DIWH2lVHcsiGstLeRE6hmixzegb6IcejtvpnmYFgTvWKMC1JvdIueL0=
X-Received: by 2002:a05:6870:80d3:b0:219:5696:235b with SMTP id
 r19-20020a05687080d300b002195696235bmr2118073oab.27.1707214533547; Tue, 06
 Feb 2024 02:15:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205171930.968-1-linux.amoon@gmail.com> <20240205171930.968-5-linux.amoon@gmail.com>
 <cf47b82c-6307-475b-af3a-eab7f09715f0@linaro.org>
In-Reply-To: <cf47b82c-6307-475b-af3a-eab7f09715f0@linaro.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 6 Feb 2024 15:45:16 +0530
Message-ID: <CANAwSgTOpDmZGR33veBWrzr75=xEZ-28iu=GeCzqa0ZPXxDchw@mail.gmail.com>
Subject: Re: [PATCHv1 4/5] arm64: dts: amlogic: Add cache information to the
 Amlogic S922X SoC
To: neil.armstrong@linaro.org
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Neil,

On Tue, 6 Feb 2024 at 14:30, Neil Armstrong <neil.armstrong@linaro.org> wro=
te:
>
> On 05/02/2024 18:19, Anand Moon wrote:
> > As per S922X datasheet add missing cache information to the Amlogic
> > S922X SoC.
> >
> > - Each Cortex-A53 core has 32 KB of instruction cache and
> >       32 KB of L1 data cache available.
> > - Each Cortex-A73 core has 64 KB of L1 instruction cache and
> >       64 KB of L1 data cache available.
> > - The little (A53) cluster has 512 KB of unified L2 cache available.
> > - The big (A73) cluster has 1 MB of unified L2 cache available.
>
> Datasheet says:
> The quad core Cortex=E2=84=A2-A73 processor is paired with A53 processor =
in a big.Little configuration, with each
> core has L1 instruction and data chaches, together with a single shared L=
2 unified cache with A53
>
Ok,

Since all the Cortex=E2=84=A2-A73 and Cortex=E2=84=A2-A53 share some improv=
ements in
the architecture with some improvements in cache features
hence I update the changes accordingly.
Also, I checked this in the ARM documentation earlier on this.

> And there's no indication of the L1 or L2 cache sizes.

What I feel is in general all the Cortex=E2=84=A2-A73 and Cortex=E2=84=A2-A=
53 supports
L1 and L2 cache size since it is part of the core features.
but I opted for these size values from a Wikipedia article.

On my Odroid N2+, I observe the following.

I have also done some testing on the stress-ng to verify this.

alarm@archl-on2:~$ lscpu
Architecture:           aarch64
  CPU op-mode(s):       32-bit, 64-bit
  Byte Order:           Little Endian
CPU(s):                 6
  On-line CPU(s) list:  0-5
Vendor ID:              ARM
  Model name:           Cortex-A53
    Model:              4
    Thread(s) per core: 1
    Core(s) per socket: 2
    Socket(s):          1
    Stepping:           r0p4
    CPU(s) scaling MHz: 100%
    CPU max MHz:        1800.0000
    CPU min MHz:        1000.0000
    BogoMIPS:           48.00
    Flags:              fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
  Model name:           Cortex-A73
    Model:              2
    Thread(s) per core: 1
    Core(s) per socket: 4
    Socket(s):          1
    Stepping:           r0p2
    CPU(s) scaling MHz: 63%
    CPU max MHz:        2208.0000
    CPU min MHz:        1000.0000
    BogoMIPS:           48.00
    Flags:              fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
Caches (sum of all):
  L1d:                  320 KiB (6 instances)
  L1i:                  320 KiB (6 instances)
  L2:                   1.5 MiB (2 instances)
NUMA:
  NUMA node(s):         1
  NUMA node0 CPU(s):    0-5
Vulnerabilities:
  Gather data sampling: Not affected
  Itlb multihit:        Not affected
  L1tf:                 Not affected
  Mds:                  Not affected
  Meltdown:             Not affected
  Mmio stale data:      Not affected
  Retbleed:             Not affected
  Spec rstack overflow: Not affected
  Spec store bypass:    Vulnerable
  Spectre v1:           Mitigation; __user pointer sanitization
  Spectre v2:           Vulnerable
  Srbds:                Not affected
  Tsx async abort:      Not affected
alarm@archl-on2:~$

alarm@archl-on2:~$ lstopo-no-graphics
Machine (3659MB total)
  Package L#0
    NUMANode L#0 (P#0 3659MB)
    L2 L#0 (512KB)
      L1d L#0 (32KB) + L1i L#0 (32KB) + Core L#0 + PU L#0 (P#0)
      L1d L#1 (32KB) + L1i L#1 (32KB) + Core L#1 + PU L#1 (P#1)
    L2 L#1 (1024KB)
      L1d L#2 (64KB) + L1i L#2 (64KB) + Core L#2 + PU L#2 (P#2)
      L1d L#3 (64KB) + L1i L#3 (64KB) + Core L#3 + PU L#3 (P#3)
      L1d L#4 (64KB) + L1i L#4 (64KB) + Core L#4 + PU L#4 (P#4)
      L1d L#5 (64KB) + L1i L#5 (64KB) + Core L#5 + PU L#5 (P#5)
  Block "mmcblk1boot0"
  Block "mmcblk1boot1"
  Block "mmcblk1"
  Net "eth0"

 >
> Neil
>

Thanks
-Anand

