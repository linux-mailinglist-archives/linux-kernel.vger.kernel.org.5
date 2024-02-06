Return-Path: <linux-kernel+bounces-55254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8623484B9DB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51447B2F9F6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA18513398A;
	Tue,  6 Feb 2024 15:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EabWkIzz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D37C133417;
	Tue,  6 Feb 2024 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707233800; cv=none; b=gtcYDCFEAco0d2OYefk2zlniLiMYC3xyghRZhp5skFnAPM9bqvlWEQm0+sZfjbgvQQ+K8dunHpAHmur4bVJ+4Oc2AqCEFzkeO3zzi83PWSqHtONLp9XXUdwy0oN+3+wZwq/FncSo63hqmUk43GhFCMbjKWXWakRe/M2OePLfrOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707233800; c=relaxed/simple;
	bh=j9C+lBswAShvcb5jDe8vo+UB5P1oAGzctN0185Tf1GM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ahAAYyZVClZQR0BkD4JcPfY0ZeCm1g8bQvU+XJAUcJOmNnyulTE4T24pSYhgb1jFm/eLAZb/m9cQS0KIQbKuidZNLJNGqAC9d9qs8fEHhIlVWU3ac/l40XAOY3Rlg0RjV1BKqlIyolKy21MtFXiKgqNhs3ihu8u45A3kEaqxGKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EabWkIzz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46CD6C433C7;
	Tue,  6 Feb 2024 15:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707233799;
	bh=j9C+lBswAShvcb5jDe8vo+UB5P1oAGzctN0185Tf1GM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EabWkIzzJ1ejuCSKuR7Tu4rv3kKcfeaK1x/Y5wysz33fjtha9SzsGdfB7//PYSnHh
	 xw18kDhot9J49SfviCYLfpQP6ZvmKylpf8eZKnmARq+lUaSci/dOHlOwYeWQy3ERIP
	 s3Zj+FGKjrIZQ+iHZT+M8Oo59xkiYWMUSYJxGhSWl7USlFdE9kJnPvzSJBxqRHtX+g
	 OCBwSAbL8Zn4lzePfhwwNYQ0qxM+7NuEkuU4U692NbN+1kHoT0zpxyr1nIRe85oajt
	 bbLcZhphGWvnBcDvlUxbjau5IQyLpd2S6aNZwjo/0N1aK8oRTVGM3DuGlXPRzTcA1Z
	 1ajhiD2cdt5dw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Anup Patel <apatel@ventanamicro.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Thomas
 Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand
 <frowand.list@gmail.com>, Conor Dooley <conor+dt@kernel.org>
Cc: Anup Patel <apatel@ventanamicro.com>, devicetree@vger.kernel.org,
 Saravana Kannan <saravanak@google.com>, Marc Zyngier <maz@kernel.org>,
 Anup Patel <anup@brainfault.org>, linux-kernel@vger.kernel.org, Atish
 Patra <atishp@atishpatra.org>, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Andrew Jones
 <ajones@ventanamicro.com>
Subject: Re: [PATCH v12 19/25] irqchip/riscv-imsic: Add device MSI domain
 support for platform devices
In-Reply-To: <20240127161753.114685-20-apatel@ventanamicro.com>
References: <20240127161753.114685-1-apatel@ventanamicro.com>
 <20240127161753.114685-20-apatel@ventanamicro.com>
Date: Tue, 06 Feb 2024 16:36:36 +0100
Message-ID: <87le7xy58b.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Anup Patel <apatel@ventanamicro.com> writes:

> The Linux platform MSI support allows per-device MSI domains so let
> us add a platform irqchip driver for RISC-V IMSIC which provides a
> base IRQ domain with MSI parent support for platform device domains.
>
> This driver assumes that the IMSIC state is already initialized by
> the IMSIC early driver.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>

[...]

> diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
> new file mode 100644
> index 000000000000..65791a6b0727
> --- /dev/null
> +++ b/drivers/irqchip/irq-riscv-imsic-platform.c
> @@ -0,0 +1,371 @@

[...]

> +static int imsic_irq_retrigger(struct irq_data *d)
> +{
> +	struct imsic_vector *vec = irq_data_get_irq_chip_data(d);
> +	struct imsic_local_config *local;
> +
> +	if (WARN_ON(vec == NULL))
> +		return -ENOENT;
> +
> +	local = per_cpu_ptr(imsic->global.local, vec->cpu);
> +	writel(vec->local_id, local->msi_va);

Change to writel_relaxed().


