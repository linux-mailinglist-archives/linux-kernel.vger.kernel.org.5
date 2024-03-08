Return-Path: <linux-kernel+bounces-96902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5AA8762C9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B6B3B214CF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827FC55E55;
	Fri,  8 Mar 2024 11:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/WC80qG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D8C55C20;
	Fri,  8 Mar 2024 11:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709896307; cv=none; b=Ia+4eW5iG+ZqLnP63HyrlLxx1GoYbf7vj7k4ehgr00ELdmdloCHL9Sn+/Cz/QAsx9di+dXlHik/4CgvSVNE97OFNdhRwBNzZWsW52ArEXdjZiwM0ufh2QWaNLCvmfiRxvWs24gEYFQOGeLxnks27kaoPmZqW0I01CklSqoMjhFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709896307; c=relaxed/simple;
	bh=VObxaL0t5qKtJJ8GQluFyj0qWx/502F8HOOdmlaZLOg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WPKRkrBe5PLNGb80h5wouuIX8H71Ym5hhgHUmySrOIWXaZ6lK5sJ+Os8cFvdmbF/7DLbWXrQfHHK9Mg+HZ35P2XyocH75nNtQkFxeF8YR79U0RMNtJo1tUBPAnYyEYRYvq6toi6R+q1TRe9s6u2RvG1DqzGj8brU72Gf+qIMZZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/WC80qG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4968C433C7;
	Fri,  8 Mar 2024 11:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709896307;
	bh=VObxaL0t5qKtJJ8GQluFyj0qWx/502F8HOOdmlaZLOg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=O/WC80qGQcYPK/zi3+6WT1dlOUKe/lBgfWzU6gkZf78kgo2cMet4Z9crddF8q4OXo
	 CKHOnqrUWNNF3XAO/0zpfcfxLDqrPpZiApNa7b6+jyP8T4MJxkK5BdvuwLDNtsPshG
	 Xay2Td2slg9EIjXIAL6jVmsRuFHU08LPInXAs8BIMU3PCzKsMWJKCdim0vrKeE6zIu
	 FC9sHJzcCDRnhVICUyo/FwFwpWcvL85AISByTVzTsfjh0eER1pgBooNNrHQRfI3RJA
	 clacMvW8NKi3YJIc2pxDT/R03w8a6lgNWXmDX9gmND3HuDYFzw/QpiThl0/AvK0bKv
	 JgtaeLe6Lzy4A==
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
Subject: Re: [PATCH v16 0/9] Linux RISC-V AIA Support
In-Reply-To: <20240307140307.646078-1-apatel@ventanamicro.com>
References: <20240307140307.646078-1-apatel@ventanamicro.com>
Date: Fri, 08 Mar 2024 12:11:44 +0100
Message-ID: <87edclou4v.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Anup Patel <apatel@ventanamicro.com> writes:

> The RISC-V AIA specification is ratified as-per the RISC-V international
> process. The latest ratified AIA specifcation can be found at:
> https://github.com/riscv/riscv-aia/releases/download/1.0/riscv-interrupts=
-1.0.pdf

It's been a been a long ride, and I got in late (v10)... Thanks for the
hard work, Anup!

Note that Alex' text-patching/IPI series [1] needs to go into the RV
tree at roughly the same time as AIA.

I've not caught any regressions for kselftests on qemu for this version
(with Alex' series applied). I have not run it on real hardware.

For the series:

Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

