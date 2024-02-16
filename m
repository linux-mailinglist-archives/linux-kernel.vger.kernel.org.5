Return-Path: <linux-kernel+bounces-69196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE6E858597
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDC43B24015
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB0C135401;
	Fri, 16 Feb 2024 18:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="GENisHwI"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34FC5823A
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 18:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708109014; cv=none; b=nDCi7hUI9z1m/3bTiwbgl8dLRzkvrqQ+Pq+xfspOxKXmO/fLDVpRweJklttg6OTL7H38+hWzRUxOv235Jhq4k0XwPEtcmcQlcNNRh1fgXoDashfa8XRmaPTjOzN4Qq9FwkS6honu2S+ndChqdnqc1Zvy6257x12ok+oRILNkCHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708109014; c=relaxed/simple;
	bh=oFfIkxFU/0VlChWZuyRwQ/q0umiifb4Fv0AIMjZ07QQ=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=L90spCdOZ2rrD2JBpTcHsWWHHacveRaTizzCHphyWlr9U+4qQI7TLG0DKacSWtbySQy4EX/4aG3E0q5gj7sJqETPqL35XMryQJHGoKBzc3f6LwYt1OXLuniyi2MJu/w0trlgAixWhvXiybhMAi5BtHAVY8CdRbPCP+A3fDPSkm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=GENisHwI; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so1946099a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1708109012; x=1708713812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eJHBmKqDgQLAotj8Y1RBzz34tisc7RXots8Wfd3qOQk=;
        b=GENisHwIGuiA2qHGvybeI/EbUDzm9AQp/6aex8Fhm+0DtFTeC+ZpsmH25/vuqjtl8Z
         2Q4pPjroUvthMda+mK2C8KiplSL7OKPjKUcnJ1aULrYzNbR7LfS3+bXDETc4hZhl3swd
         r4P4GsVv1TptyQTiMSsxyFUe89UCFG8t77UHyb6nWzom5rGKPzE9cbB4vpqExctawavd
         6oiBNnsCFWxC5nnqE8Ct/tcP72KKBZDnLNBjWal4x5Oy8emKQb+Xo3b/FaOpZBmTsV2r
         QvFa5VXfDpwF0ImmKToNeslSFPBCmuvsgUaCNsYTxAnW9hu9qnN+leHm4Vr3w184VWFS
         Glhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708109012; x=1708713812;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJHBmKqDgQLAotj8Y1RBzz34tisc7RXots8Wfd3qOQk=;
        b=jQjkoNbD0YrgU0zKPMdU/Vcqva2KSdiF2lf6E1zEuqkBV037106fmmEv1pjPdtDZRK
         3eAGPYfgAG3UM/3oCFAIogcgdAEgSaXHAaw6HLeBe1t4um2KDoyM41wkHYpNiEDZzIPp
         r1FGzP5UCTZpk7DtcMJwaRFVHTNICdGWIeLSV9WfmPAyAvVapEIWVCX4ZSbbyvMMgxcY
         VvfSLgZwUB7IbHytQUYnIyCPBdDPILQy30Sl20K+5eYpVSaYVFci9MYl6X3eMtDnfcI2
         jIruReG+po30Xhlvl/rbYyPbibA0QZaIWo4DYskhZ2xMqxvn0rd9QZxsJVCwM7lAt7TO
         kwpA==
X-Forwarded-Encrypted: i=1; AJvYcCXhEUEFyRBxfCuy/AOK0pOklwRsoNBHj/x2BQunWndjE8zYq0vR85QwdxD78AVkCVvkAYe/TSh4z22Yh3UTqlTOTNfZJLIRKX2pmEVU
X-Gm-Message-State: AOJu0Yxoj2G04b/C/XjLudYrxMrp+8WN6t/f8lanj546MbGjEi4ZczD/
	55ZT5DQk2AA4X3svqH4svHA7ai1XfyG0qQGMUTAJ4dMG6ZkxzEMLeTakj/XpuC4=
X-Google-Smtp-Source: AGHT+IHupLOFRaXioovxDw1rwELdzfrPAACvtmznYDJzzO50HaIDsrCgoi1SlLUvhe4Vma9+UYI6BA==
X-Received: by 2002:a05:6a20:8043:b0:19e:cae4:7c15 with SMTP id f3-20020a056a20804300b0019ecae47c15mr4841321pza.24.1708109011834;
        Fri, 16 Feb 2024 10:43:31 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id dq3-20020a056a020f8300b005b7dd356f75sm194808pgb.32.2024.02.16.10.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 10:43:31 -0800 (PST)
Date: Fri, 16 Feb 2024 10:43:31 -0800 (PST)
X-Google-Original-Date: Fri, 16 Feb 2024 10:43:28 PST (-0800)
Subject:     Re: [PATCH] MAINTAINERS: Update SiFive driver maintainers
In-Reply-To: <20240215234941.1663791-1-samuel.holland@sifive.com>
CC: Conor Dooley <conor@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
  greentime.hu@sifive.com, linux-riscv@lists.infradead.org, green.wan@sifive.com,
  samuel.holland@sifive.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: samuel.holland@sifive.com
Message-ID: <mhng-a672acb9-4e32-4a63-898d-08b10d09d8b8@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Thu, 15 Feb 2024 15:49:11 PST (-0800), samuel.holland@sifive.com wrote:
> Add myself as a maintainer for the various SiFive drivers, since I have
> been performing cleanup activity on these drivers and reviewing patches
> to them for a while now. Remove Palmer as a maintainer, as he is focused
> on overall RISC-V architecture support.
>
> Collapse some duplicate entries into the main SiFive drivers entry:
>  - Conor is already maintainer of standalone cache drivers as a whole,
>    and these files are also covered by the "sifive" file name regex.
>  - Paul's git tree has not been updated since 2018, and all file names
>    matching the "fu540" pattern also match the "sifive" pattern.
>  - Green has not been active on the LKML for a couple of years.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
>  MAINTAINERS | 29 +++++------------------------
>  1 file changed, 5 insertions(+), 24 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 73d898383e51..f1bbb0f82664 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1395,6 +1395,7 @@ F:	drivers/hwmon/max31760.c
>
>  ANALOGBITS PLL LIBRARIES
>  M:	Paul Walmsley <paul.walmsley@sifive.com>
> +M:	Samuel Holland <samuel.holland@sifive.com>
>  S:	Supported
>  F:	drivers/clk/analogbits/*
>  F:	include/linux/clk/analogbits*
> @@ -16725,6 +16726,7 @@ F:	drivers/pci/controller/dwc/*layerscape*
>  PCI DRIVER FOR FU740
>  M:	Paul Walmsley <paul.walmsley@sifive.com>
>  M:	Greentime Hu <greentime.hu@sifive.com>
> +M:	Samuel Holland <samuel.holland@sifive.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
> @@ -19968,36 +19970,15 @@ S:	Maintained
>  F:	drivers/watchdog/simatic-ipc-wdt.c
>
>  SIFIVE DRIVERS
> -M:	Palmer Dabbelt <palmer@dabbelt.com>
>  M:	Paul Walmsley <paul.walmsley@sifive.com>
> +M:	Samuel Holland <samuel.holland@sifive.com>
>  L:	linux-riscv@lists.infradead.org
>  S:	Supported
> +F:	drivers/dma/sf-pdma/
>  N:	sifive
> +K:	fu[57]40
>  K:	[^@]sifive
>
> -SIFIVE CACHE DRIVER
> -M:	Conor Dooley <conor@kernel.org>
> -L:	linux-riscv@lists.infradead.org
> -S:	Maintained
> -F:	Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
> -F:	drivers/cache/sifive_ccache.c
> -
> -SIFIVE FU540 SYSTEM-ON-CHIP
> -M:	Paul Walmsley <paul.walmsley@sifive.com>
> -M:	Palmer Dabbelt <palmer@dabbelt.com>
> -L:	linux-riscv@lists.infradead.org
> -S:	Supported
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pjw/sifive.git
> -N:	fu540
> -K:	fu540
> -
> -SIFIVE PDMA DRIVER
> -M:	Green Wan <green.wan@sifive.com>
> -S:	Maintained
> -F:	Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> -F:	drivers/dma/sf-pdma/
> -
> -
>  SILEAD TOUCHSCREEN DRIVER
>  M:	Hans de Goede <hdegoede@redhat.com>
>  L:	linux-input@vger.kernel.org

I'm fine not having to maintain the SiFive drivers, the SOC stuff was 
never really my thing anyway so that's all a bit easier on my end.  So

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

I do end up picking up some random patches though, mostly because stuff 
seems to slip through the cracks.  Are you going to have an SOC subtree 
and send stuff over there?  That seems more manageable on my end, as 
it's a bit scattered today.

