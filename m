Return-Path: <linux-kernel+bounces-25053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF4F82C6F0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44FC5B230D4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 22:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976E41772F;
	Fri, 12 Jan 2024 22:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hefring-com.20230601.gappssmtp.com header.i=@hefring-com.20230601.gappssmtp.com header.b="MltP2E0w"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C96717725
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 22:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hefring.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hefring.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dbe69afb431so6171771276.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 14:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1705096807; x=1705701607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0hhVOcFdh1HTKD3eGnDrrPjtYobkiYS23JtQg/2eggU=;
        b=MltP2E0wHB66G1e+RUw5daU0x9C0fvyB/NMYNtcbhGnKt8aVHsw42ZckMLOY1BuYJj
         +r5Qm+NR0EaqihUhhPyT2e/3TX8VCQbZCwybMBl3chpeMqFxRv5LuU3yJdCPVSYy21WV
         BqRVNXl2JU3ctNwuFBUauDJI2jHmrfwxqG8z37ytKYtFuLWGYvr5bXRrRndaJWJG1uHU
         xUIBxby97F96nIvreeC4v/NRo1eyIyzanJjx/CP9f4+aeyDJupqbSlFfYuJqVBwm+Z/o
         dHk3VNmGpu7ipTQCU9RTRkouOtBzWX4GUGgZEz1TNrnj/vc3YgLlqiZvGD++lH1YP+5R
         7WmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705096807; x=1705701607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hhVOcFdh1HTKD3eGnDrrPjtYobkiYS23JtQg/2eggU=;
        b=NsDAtZMmXp5dNSXzbuTLKE1G9ENiHxFEu/W/ZEto84GksuKOpeqEGEDh/eDj8UuQ93
         BRloyTe/+JHBrvcQyj/l0WNsaWUir2URYWYkZWrxCj9PavX+YpzZgB+iGCqOuBjChcrz
         L8CkjgUHB6NHy4hV6TySMtcTth+VGoSkc2boxEqfQjEjwBNnSBTxy9Xl+WHd84PRywNk
         UrOHEw5xE5xXAXtokut6H8fTefOD4vKVA0og8cqNajDll6zox+oqc6GE532bpPwNzzWZ
         0xOnXZTZnSe1foIopy+l/l/VmmK32KmcVcSy7h0WWkKH3FXxuEv/Fx7iygSX34CqhJbv
         /hmQ==
X-Gm-Message-State: AOJu0Yz9AAbGYFomiKeWILF80a45zG8Qwolh4pxSb/q1m07wqa425IS1
	bZC9pTBR+BBuHkNZYpbCAA6QJLEQoJ3xpQ==
X-Google-Smtp-Source: AGHT+IHbrYRi12cOjI23zBiUfiGMMjgGZ1WdMjYT+UYdd79zzlNQgTtNbGfGpkVNdrhDuqR5cHrh/g==
X-Received: by 2002:a05:6902:2182:b0:dbd:5be1:1768 with SMTP id dl2-20020a056902218200b00dbd5be11768mr1339723ybb.73.1705096807499;
        Fri, 12 Jan 2024 14:00:07 -0800 (PST)
Received: from dell-precision-5540 ([50.212.55.90])
        by smtp.gmail.com with ESMTPSA id en12-20020a05622a540c00b00427e36e21d9sm1688262qtb.64.2024.01.12.14.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 14:00:06 -0800 (PST)
Date: Fri, 12 Jan 2024 17:00:04 -0500
From: Ben Wolsieffer <ben.wolsieffer@hefring.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH 1/2] clk: stm32: initialize syscon after clocks are
 registered
Message-ID: <ZaG2ZDCLP34jcI6Y@dell-precision-5540>
References: <20231002180854.1603452-1-ben.wolsieffer@hefring.com>
 <20231002180854.1603452-2-ben.wolsieffer@hefring.com>
 <883a61872f94c972cc410da84eaf7b97.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <883a61872f94c972cc410da84eaf7b97.sboyd@kernel.org>

On Sun, Dec 17, 2023 at 03:05:01PM -0800, Stephen Boyd wrote:
> Quoting Ben Wolsieffer (2023-10-02 11:08:53)
> > The stm32-power-config syscon (PWR peripheral) is used in this driver
> > and the STM32 RTC driver to enable write access to backup domain
> > registers. The syscon's clock has a gate controlled by this clock
> > driver, but this clock is currently not registered in the device tree.
> > This only happens to work currently because all relevant clock setup and
> > RTC initialization happens before clk_disabled_unused(). After this
> > point, all syscon register writes are ignored.
> 
> Seems like we should mark those clks as CLK_IGNORE_UNUSED and add a
> comment to that fact.

That seems like a worse solution than specifying the clock dependency in
the device tree.

> 
> > 
> > If we simply add the syscon clock in the device tree, we end up with a
> > circular dependency because the clock has not been registered at the
> > point this driver requests the syscon.
> > 
> > This patch avoids this circular dependency by moving the syscon lookup
> > after the clocks are registered. This does appear to create a possible
> > race condition where someone could attempt to perform an operation on a
> > backup domain clock before the syscon has been initialized. This would
> > result in the operation having no effect because backup domain writes
> > could not be enabled. I'm not sure if this is a problem or if there is
> > a way to avoid it.
> 
> There's no comment in the code that says the regmap must be set there
> instead of earlier. What's to stop someone from tripping over this
> problem later? At the least, please add a comment.

Yeah, I'll fix that. Do you have any thoughts on the race condition I
described? Should I add some kind of locking to block
enable/disable_power_domain_write_protection() until stm32f4_rcc_init()
attempts to initialize the syscon?

Thank you, Ben

