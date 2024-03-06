Return-Path: <linux-kernel+bounces-93156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C102A872BA2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2ADE1C216C6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A2033EE;
	Wed,  6 Mar 2024 00:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtQ+bhiX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEDA817;
	Wed,  6 Mar 2024 00:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709683768; cv=none; b=KGodbiE1ivLeWFSpHEH+8sB2DnUb5wzLmKRE0YvtFwPv84r09nkMFwFrXagHyAEEUUVu0FG7mfyRJVdaNSc4SL5MHIfIC8JauddAwBq9JZ7XiMppNLxtKCw0r83QJugSa+CU9fwy5cvQkiT5tx7t/Ia/3eAAlpfzXLsdofr6CS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709683768; c=relaxed/simple;
	bh=2fa03Fx+MikuXDNEGUr3zWcS95fwkTs88Gg/2cdTurE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MTmgUXyr4hSH5oI0xt7m8lzWWnJpJCiLWlw/zfH30G+HgueTFBwKvurGqPnbZrOMaaF66C0KJ/v5MZpcWHzcmFUGaNSSk0qtEGdOY6059dwFwT8HgSOWSLBcFeXXRIBh0/MraaJycBqDjXkol7CzVvk0Y4rXlfygeFMv+4sTN+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtQ+bhiX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA51FC433F1;
	Wed,  6 Mar 2024 00:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709683768;
	bh=2fa03Fx+MikuXDNEGUr3zWcS95fwkTs88Gg/2cdTurE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YtQ+bhiXVoEHKwIYSWA1+tfojkSFU+2ViRWsMEekRaUsZ3tJ/JaglwUq5yc1oACYe
	 tzqC1M6SZqn2XgParwIU3ZqG0a+F1V2GtTg4y5BNThNuxqEV0eo/Ii5LLaLDK3/esT
	 wcj7/ZuK6RfvKibeDIbOWszBjaKDpV2IPbZ4vhM6uSYxQGQTQ+OVMYyE8XF0KqiZYq
	 mqDDT5br2zA40qtqM1wAkVKUDmu4ObPQtczwlZTWfr791U0Pk6mK/1AaOjz+a2i71N
	 aRbAsMnxDCDjR0nsH1mS8+Nz9HTlakoj4KcR/cCmWvuRjBU9boqf69xg8NqQ4K2qsR
	 xPC8rBknV+1+w==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org,
	Yangyu Chen <cyy@cyyself.name>
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3] riscv: dts: Move BUILTIN_DTB_SOURCE to common Kconfig
Date: Wed,  6 Mar 2024 00:09:19 +0000
Message-ID: <20240306-daringly-exemplary-defc8d51f0b6@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_88FEE0A2C5E0852436A2F1A1087E6803380A@qq.com>
References: <tencent_88FEE0A2C5E0852436A2F1A1087E6803380A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=908; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=NlED+MmuKp0K0tdEJC4UOM/foaT2Vdyi4yXugOQ8erg=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKnPtxhcONulHshobbr6nGnuZ7V1T/QXNiXWzjcsiJT7v 6T+3fXvHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZjISQGG/7nXVpxIzfvravsx +47UCZkbMx7w7exZVHavZOLZn9dNWD4wMhx5/P+U4KtHjpwH5lQxBYos2vnkfcelMFUBwyUbXf+ 2d/ACAA==
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Wed, 28 Feb 2024 16:52:54 +0800, Yangyu Chen wrote:
> The BUILTIN_DTB_SOURCE was only configured for K210 before. Since
> SOC_BUILTIN_DTB_DECLARE was removed at commit d5805af9fe9f ("riscv: Fix
> builtin DTB handling") from patch [1], the kernel cannot choose one of the
> dtbs from then on and always take the first one dtb to use. Then, another
> commit 0ddd7eaffa64 ("riscv: Fix BUILTIN_DTB for sifive and microchip soc")
> from patch [2] supports BUILTIN_DTB_SOURCE for other SoCs. However, this
> feature will only work if the Kconfig we use links the dtb we expected in
> the first place as mentioned in the thread [3]. Thus, a config
> BUILTIN_DTB_SOURCE is needed for all SoCs to choose one dtb to use.
> 
> [...]

Applied to riscv-dt-fixes, thanks!

[1/1] riscv: dts: Move BUILTIN_DTB_SOURCE to common Kconfig
      https://git.kernel.org/conor/c/2672031b20f6

Thanks,
Conor.

