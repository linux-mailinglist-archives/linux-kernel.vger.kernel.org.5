Return-Path: <linux-kernel+bounces-72952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 245C285BB05
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57E451C237BA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FBF67C62;
	Tue, 20 Feb 2024 11:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eW/YQDDM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76265679E4;
	Tue, 20 Feb 2024 11:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708429999; cv=none; b=r+ncbPlmwxy0zCmQP6N8vwhDtbEAX9PTaXUi4lFBCNi3t2GslOyXqq3UFli3/61rzyqWKhi6Ox/svzJSF74Uc6sGbKYjuzeEP5zPDc+c1cJ3DtJGhdZOjUokaKdr+dVMq1DyMH+V90e4/Ht5qec367mu1W5WteESJfKs4nNLUTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708429999; c=relaxed/simple;
	bh=mDkSHpxdu2cA5WP+9/oozWeX576UlNHK6vE8pXxzyWc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Eill+V48zmBWSu4vUsLH4VW+gCZEm1c+YBBbLl6zJBaRD+5tkZoDjHCwC1MOgoqFHTB+L5c1OQNXtFijYbWJLh/1lvj+CFmwLzrWosQQdZ5ivkiNqmrQPOYK4q+FQ+gUnRTjQ5r9jzSHfB4Atf+/OJP0o54l1oYvF9y8ZSRYhgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eW/YQDDM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83DC2C433F1;
	Tue, 20 Feb 2024 11:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708429998;
	bh=mDkSHpxdu2cA5WP+9/oozWeX576UlNHK6vE8pXxzyWc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=eW/YQDDMY7IcgbQTXrZnI/rlEAieTspyc0S0pDPKjiIn2ZLmvjubztc+7ot/94/KT
	 HXapqcAGQuakJ3AdQkMhdhNnnzYUBgE3pu75mXEHbgwVNbc6aVNBfPytHp1DYBMKqR
	 uPa3F4M2+cbRGptaY+MUChgm4AUWQ67f9S+fkNLRgxyP3Qj9F3HPrNLHBGAU3YwjoK
	 Vmn7wJKaUanuIBA4uwwx1S5NP2s/jFDTZBMVD3IuaKZMjzDypIK12zm/62uSPhfwtw
	 p3Yj9wav9c8Glv8iIDusjL52dyDKS7rel4xurJO9gDrvqjQabBdlFdx1kzPnDGmEUc
	 jgJo9m+VnlUsg==
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
Subject: Re: [PATCH v13 06/13] irqchip: Add RISC-V incoming MSI controller
 early driver
In-Reply-To: <20240220060718.823229-7-apatel@ventanamicro.com>
References: <20240220060718.823229-1-apatel@ventanamicro.com>
 <20240220060718.823229-7-apatel@ventanamicro.com>
Date: Tue, 20 Feb 2024 12:53:15 +0100
Message-ID: <87a5nvfj2s.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Anup Patel <apatel@ventanamicro.com> writes:

> The RISC-V advanced interrupt architecture (AIA) specification
> defines a new MSI controller called incoming message signalled
> interrupt controller (IMSIC) which manages MSI on per-HART (or
> per-CPU) basis. It also supports IPIs as software injected MSIs.
> (For more details refer https://github.com/riscv/riscv-aia)
>
> Let us add an early irqchip driver for RISC-V IMSIC which sets
> up the IMSIC state and provide IPIs.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>

This patch has a couple of checkpatch issues:

CHECK: Alignment should match open parenthesis
CHECK: Please don't use multiple blank lines
CHECK: Please use a blank line after function/struct/union/enum declarations
CHECK: Unnecessary parentheses around 'global->nr_guest_ids < IMSIC_MIN_ID'
CHECK: Unnecessary parentheses around 'global->nr_guest_ids >=3D IMSIC_MAX_=
ID'
CHECK: Unnecessary parentheses around 'global->nr_ids < IMSIC_MIN_ID'
CHECK: Unnecessary parentheses around 'global->nr_ids >=3D IMSIC_MAX_ID'
CHECK: Unnecessary parentheses around global->local
CHECK: Unnecessary parentheses around imsic->lpriv
CHECK: extern prototypes should be avoided in .h files

Bj=C3=B6rn

