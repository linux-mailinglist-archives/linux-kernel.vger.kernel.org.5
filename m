Return-Path: <linux-kernel+bounces-11168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC7D81E263
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 22:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90416281C1F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 21:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F4153E17;
	Mon, 25 Dec 2023 21:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gN7wWk/4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3885380C;
	Mon, 25 Dec 2023 21:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7810c332a2cso345713585a.1;
        Mon, 25 Dec 2023 13:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703538410; x=1704143210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGDVYoNIIWyiCkgdSSFbUJbJwyQv1O09fglEbTWCQV4=;
        b=gN7wWk/4RUXrGdt/U5Fbk00GIf5sNVzWWlyXeqE1jRUaS0bKxszuTFEn+VDuAKAQLb
         y/z5glY2jk2QZN0okLSdarHigqJWWY0IHVOc/O/wCqnyYjPJiwev8PI/0khIWuQqvrMJ
         EgXRoa2zXHWOeD/AJ8HlGUhltTpmLYkM8mwnc21BPrONgix9GbHNibgqAMu5TyghBm4S
         TQJgRNmWmdTWe5gd3DMFJpMvQHyhSNDT9R/EynpdqDT7osG1drfK0QZl/gv3yZ16pTJ1
         JcAwPZWANEWuoc/NrGcFXtvis2FSmjHrfzWPR8WqJU0e/UYKk83EesK/knEh68wD3Twu
         hMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703538410; x=1704143210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGDVYoNIIWyiCkgdSSFbUJbJwyQv1O09fglEbTWCQV4=;
        b=aGNhLUS7wor02lZfcxgkY2PS0N/MlTq7o5qqpN5xy2w1y8n4ppeTYBGdoDImUInxeI
         7xtoEbriVUVzbaqbV5fZooHB4NPojJu24VziMyrSe2MDZA2kicycbRf4KKvJaR1hHDcx
         epTwvxdsbykBXjpWJP1na3vtyiv3ybKEn4EI50ble7XKiCGUpjalAjuEwxB2BeqhiQ7d
         uQ9X8c7dhD3pCT9QovmmMtK17TmGVNN5qAnKbnZdOOvhp3NnzA7J0v9NqMWSv9O2e5cc
         YPjJNcJJkoSS+XmI1OPa61YGSz+F0lQpEpF/dYCe6DAtMXvoBARREVX5iSNir4fwnkSv
         FLxA==
X-Gm-Message-State: AOJu0YzkNuKwk1QxaR398WFeATQ0RaVQQ2SpEb/2oqJ9SyH9F/GjVONg
	ke3Sjvk7S2ur60GD16RLd5W8WVcOOp1ysUbD4gQ=
X-Google-Smtp-Source: AGHT+IHTfC4IvI32xoqINCBSsocRoTKNzkLjTfpAEtn6LgG4kDC6m58rQ0mR6tMnU/vPvukNQS74BZgTSh6h+p/YqWY=
X-Received: by 2002:a05:620a:14a9:b0:77f:8c54:da15 with SMTP id
 x9-20020a05620a14a900b0077f8c54da15mr7742403qkj.40.1703538409803; Mon, 25 Dec
 2023 13:06:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231225103308.1557548-1-peterlin@andestech.com>
In-Reply-To: <20231225103308.1557548-1-peterlin@andestech.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 25 Dec 2023 21:06:04 +0000
Message-ID: <CA+V-a8t7g8ctPQrwdB9tgtmgtGfqQ-k2N-1sSwnjB-b1F71-AQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/16] Support Andes PMU extension
To: Yu Chien Peter Lin <peterlin@andestech.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	alexander.shishkin@linux.intel.com, andre.przywara@arm.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, atishp@atishpatra.org, 
	conor+dt@kernel.org, conor.dooley@microchip.com, conor@kernel.org, 
	devicetree@vger.kernel.org, dminus@andestech.com, evan@rivosinc.com, 
	geert+renesas@glider.be, guoren@kernel.org, heiko@sntech.de, 
	irogers@google.com, jernej.skrabec@gmail.com, jolsa@kernel.org, 
	jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	locus84@andestech.com, magnus.damm@gmail.com, mark.rutland@arm.com, 
	mingo@redhat.com, n.shubin@yadro.com, namhyung@kernel.org, palmer@dabbelt.com, 
	paul.walmsley@sifive.com, peterz@infradead.org, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, rdunlap@infradead.org, 
	robh+dt@kernel.org, samuel@sholland.org, sunilvl@ventanamicro.com, 
	tglx@linutronix.de, tim609@andestech.com, uwu@icenowy.me, wens@csie.org, 
	will@kernel.org, ycliang@andestech.com, inochiama@outlook.com, 
	chao.wei@sophgo.com, unicorn_wang@outlook.com, wefu@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lin-san,

On Mon, Dec 25, 2023 at 10:37=E2=80=AFAM Yu Chien Peter Lin
<peterlin@andestech.com> wrote:
>
> Hi All,
>
> This patch series introduces the Andes PMU extension, which serves
> the same purpose as Sscofpmf. To use FDT-based probing for hardware
> support of the PMU extensions, we first convert T-Head's PMU to CPU
> feature alternative, then add Andes PMU alternatives.
>
> Its non-standard local interrupt is assigned to bit 18 in the
> custom S-mode local interrupt enable/pending registers (slie/slip),
> while the interrupt cause is (256 + 18).
>
> Mainline OpenSBI has supported Andes PMU extension:
> - https://github.com/riscv-software-src/opensbi/tree/master
> Linux patches (based on v6.7-rc7) can be found on Andes Technology GitHub
> - https://github.com/andestech/linux/commits/andes-pmu-support-v6
>
> The PMU device tree node used on AX45MP:
> - https://github.com/riscv-software-src/opensbi/blob/master/docs/pmu_supp=
ort.md#example-3
>
> Locus Wei-Han Chen (1):
>   riscv: andes: Support specifying symbolic firmware and hardware raw
>     events
>
> Yu Chien Peter Lin (15):
>   riscv: errata: Rename defines for Andes
>   irqchip/riscv-intc: Allow large non-standard interrupt number
>   irqchip/riscv-intc: Introduce Andes hart-level interrupt controller
>   dt-bindings: riscv: Add Andes interrupt controller compatible string
>   riscv: dts: renesas: r9a07g043f: Update compatible string to use Andes
>     INTC
>   perf: RISC-V: Eliminate redundant interrupt enable/disable operations
>   RISC-V: Move T-Head PMU to CPU feature alternative framework
>   perf: RISC-V: Introduce Andes PMU for perf event sampling
>   dt-bindings: riscv: Add T-Head PMU extension description
>   dt-bindings: riscv: Add Andes PMU extension description
>   riscv: dts: allwinner: Add T-Head PMU extension for sun20i-d1s
>   riscv: dts: sophgo: Add T-Head PMU extension for cv1800b
>   riscv: dts: sophgo: Add T-Head PMU extension for sg2042
>   riscv: dts: thead: Add T-Head PMU extension for th1520
>   riscv: dts: renesas: Add Andes PMU extension for r9a07g043f
>
The above patches dont apply cleanly on top of below branches. Can you
please rebase and re-send.

https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/log/?h=3Df=
ixes
https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/log/?h=3Df=
or-next
https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git/log=
/?h=3Drenesas-dts-for-v6.8

Cheers,
Prabhakar

>  .../devicetree/bindings/riscv/cpus.yaml       |   6 +-
>  .../devicetree/bindings/riscv/extensions.yaml |  13 ++
>  arch/riscv/Kconfig.errata                     |  13 --
>  arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi |   2 +-
>  arch/riscv/boot/dts/renesas/r9a07g043f.dtsi   |   4 +-
>  arch/riscv/boot/dts/sophgo/cv1800b.dtsi       |   2 +-
>  arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi   | 128 +++++++++---------
>  arch/riscv/boot/dts/thead/th1520.dtsi         |   8 +-
>  arch/riscv/errata/andes/errata.c              |  10 +-
>  arch/riscv/errata/thead/errata.c              |  19 ---
>  arch/riscv/include/asm/errata_list.h          |  19 +--
>  arch/riscv/include/asm/hwcap.h                |   2 +
>  arch/riscv/include/asm/vendorid_list.h        |   2 +-
>  arch/riscv/kernel/alternative.c               |   2 +-
>  arch/riscv/kernel/cpufeature.c                |   2 +
>  drivers/irqchip/irq-riscv-intc.c              |  89 ++++++++++--
>  drivers/perf/Kconfig                          |  27 ++++
>  drivers/perf/riscv_pmu_sbi.c                  |  47 +++++--
>  include/linux/soc/andes/irq.h                 |  18 +++
>  .../arch/riscv/andes/ax45/firmware.json       |  68 ++++++++++
>  .../arch/riscv/andes/ax45/instructions.json   | 127 +++++++++++++++++
>  .../arch/riscv/andes/ax45/memory.json         |  57 ++++++++
>  .../arch/riscv/andes/ax45/microarch.json      |  77 +++++++++++
>  tools/perf/pmu-events/arch/riscv/mapfile.csv  |   1 +
>  24 files changed, 592 insertions(+), 151 deletions(-)
>  create mode 100644 include/linux/soc/andes/irq.h
>  create mode 100644 tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.=
json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/andes/ax45/instructi=
ons.json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/andes/ax45/memory.js=
on
>  create mode 100644 tools/perf/pmu-events/arch/riscv/andes/ax45/microarch=
.json
>
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

