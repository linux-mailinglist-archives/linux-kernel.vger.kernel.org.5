Return-Path: <linux-kernel+bounces-138360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DABC89F01C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08FB2B238A0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768E815958A;
	Wed, 10 Apr 2024 10:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7YDymAQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD34213DB9F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 10:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712745866; cv=none; b=KULeEb1slMp9LYHoOSAc5SkPddeBsMBABdsZXkYn1jtjeMUKhj7XsERZ5LcH50ZldRy4K3eEqAxhraOke7e+sTQVwiFi2HtZZSzivsN4rLFPb/6XKLFykUEazJOUhtE2L1tv4mAwMq1LZk8f3xYzSJpHac7SNk8HgQsBKHml4sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712745866; c=relaxed/simple;
	bh=fYk3nBBGlFBQJPElvPTH64JaR+If9kx9CukBMxWQFGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WTdslWF6/0oKHTg9jy7RxLEKrH/9MF2x8eUWw2D/Y3xN059eHQGlXM4D72xs59EaKBAo2mNw3tJbNqds+cBbATUIvmth5hxJT7fizakwWjoz5WWqd8cZ66XIXYxDr/lvJz9DW47x6qm4PZeHlB7EhUoJ+CJXQfVUN7iU9t4Hj+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7YDymAQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2755C433C7;
	Wed, 10 Apr 2024 10:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712745866;
	bh=fYk3nBBGlFBQJPElvPTH64JaR+If9kx9CukBMxWQFGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q7YDymAQJVozwyQzPzc9SZxfU/W9u3a7s8WiiV6mZiu3zXuqOoE/3ara3RdQ5peMM
	 C2EGfoCI7fuXbW3RiacPSSDVFwQYjnYoPOUfgVVx71PfNpo3nx+lsZPdtDMvx3XuMs
	 b9VlyBJvUVioJKv4eG0FEJW7cYrXtsGA2GCCAWcXgSaN9CCNvB2XAVoj8YxtICxol4
	 OKwJYvk2Pr0mZbYFr4w2s5uBs3y7fefvN1hJ3chssnzXmAQHhDNhmJl+8j/qghkiCU
	 2HybU8SSrz3xoQfzo3F9d0HTmJw0D7v7Q84IpPXGNgquiWF2PDTgjrxcYjJ426N7gr
	 nn1wROlWURCIA==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org,
	Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] RISC-V: drop SOC_MICROCHIP_POLARFIRE for ARCH_MICROCHIP
Date: Wed, 10 Apr 2024 11:44:16 +0100
Message-ID: <20240410-ungreased-boxlike-0320ceca8b75@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240305-fled-undrilled-41dc0c46bb29@spud>
References: <20240305-fled-undrilled-41dc0c46bb29@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=626; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=yZUChBQdk1aSe2qT7yxOp2VJrbn9RBukfIadlOPY69Y=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGliuQ05u3wXfjF8OfvbrbTDOX7S50t1szbenLDdW9Srq 27xu4kWHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZjIhjkMf/jvXZm0Q8M+piX8 7YFY2asPvC4dPHfEdL3qwofz7ohnBf1l+CuT8kxHZSE7c9I7yz28vC2JJUt0Dy00+nPD6Z7xrfs X2DgA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Tue, 05 Mar 2024 19:20:28 +0000, Conor Dooley wrote:
> SOC_MICROCHIP_POLARFIRE doesn't have any remaining in-kernel users, so
> time has come to remove it. Foolish auld me left the "POLARFIRE" in the
> new, hidden, config option when I renamed it and changed all of the
> users however. As HPSC has been announced, and is not a PolarFire,
> drop mention of that specific FPGA family from the new user-visible
> config option.
> 
> [...]

Applied to riscv-soc-for-next, thanks!

[1/1] RISC-V: drop SOC_MICROCHIP_POLARFIRE for ARCH_MICROCHIP
      https://git.kernel.org/conor/c/37c09ed41925

Thanks,
Conor.

