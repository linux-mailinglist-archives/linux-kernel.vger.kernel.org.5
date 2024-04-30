Return-Path: <linux-kernel+bounces-164733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFE48B81D7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 580091C21E9B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8B61A38F4;
	Tue, 30 Apr 2024 21:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1fzzgaG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCA3179B2;
	Tue, 30 Apr 2024 21:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714512123; cv=none; b=ozjZNBGSEfqGtK0fF0YgrwaShxGOYVbXHP/78j6vumk99MNJbhS1Bm3MH4sw8x+idwEyiIevoV+P9nDvA36bPU/SQELT3dnBR+SQ+JghL/CgSwsWqUKswKfzok6D3triS7xKM/X8xI5u1OfcpYtMwAbrA3ZFZNQHeTjznXPi974=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714512123; c=relaxed/simple;
	bh=SA4lSmJZlpSQQBaz8MKF3TBO91TlafTkr2Codb//v3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XTu99RjvKzrna1z9iT84y2KbO2PCnGtYW8DPxQt7wEWvlHmGBbhBr+DO02LwpdDTyHf5hQSy28vm4e14/TgvB9iUBa0vxn5BcOARzlyNQxoizf6SOsPgjXZoUu+OBitAnBOAiCwdIyfoh1pejmKYNAJdkm6+fuT/mPeF53xfB7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1fzzgaG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB05C2BBFC;
	Tue, 30 Apr 2024 21:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714512122;
	bh=SA4lSmJZlpSQQBaz8MKF3TBO91TlafTkr2Codb//v3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S1fzzgaGOrgBkdnkUVqvvKluWHwt/VQQrJoCcOf0iI/xjQpzGA80ZhNA4QxC95E/0
	 VcNmpNK84bumleutblj8i+7bR81PqsbjQrujk2UZb1QTq+L1qDgHkyOtS+qcnQFsFs
	 msrqqEL2x5xvrCPlZVTTWjGhTxuk+QnPBQYXEhTXFwfKq4SM76QEHRIHSyPJRb07x0
	 zRSS4bYMNWhBU1yuUH5QqDMyhmEsVpGo7642wJADZoTChcyx3rVwH5yQ+aVsH8ZQAi
	 xDbB97wZwJfieEPW/ykl+2P7qYONvF0Uui3OEnOyHu5kb3IgZJ/cfDhmaWyUTJcEmS
	 cObp6xHJM5b/g==
From: Conor Dooley <conor@kernel.org>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Jisheng Zhang <jszhang@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/8] riscv: dts: starfive: add Milkv Mars board device tree
Date: Tue, 30 Apr 2024 22:20:22 +0100
Message-ID: <20240430-jailbird-stallion-590c4959ce32@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240429001317.432-1-jszhang@kernel.org>
References: <20240429001317.432-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1525; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=zZkBCon8/K1UdknQ9fZSRya8iFPQEnHbO+SPf4TXRI0=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGmGCVPzcxibteWtZWYZ7bvU/+dgwkP5+wmqkVsu3lmjo bNt34mqjlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEyEV5Phn4Hi/DqZV+eYPLp5 OoMdDnz7dO/PSbel5m13gllW7Ph1ZQLD/8yQ3Gezn55x/cYU8K13xWL2r1M/PpU82uq/0Pfc3Kq oVywA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Mon, 29 Apr 2024 08:13:09 +0800, Jisheng Zhang wrote:
> The Milkv Mars is a development board based on the Starfive JH7110 SoC.
> The board features:
> 
> - JH7110 SoC
> - 1/2/4/8 GiB LPDDR4 DRAM
> - AXP15060 PMIC
> - 40 pin GPIO header
> - 3x USB 3.0 host port
> - 1x USB 2.0 host port
> - 1x M.2 E-Key
> - 1x eMMC slot
> - 1x MicroSD slot
> - 1x QSPI Flash
> - 1x 1Gbps Ethernet port
> - 1x HDMI port
> - 1x 2-lane DSI and 1x 4-lane DSI
> - 1x 2-lane CSI
> 
> [...]

Applied to riscv-dt-for-next, thanks! I fixed up the nits of Emil's in
the merge commit.

[1/8] riscv: dts: starfive: add 'cpus' label to jh7110 and jh7100 soc dtsi
      https://git.kernel.org/conor/c/5e7922abddd4
[2/8] dt-bindings: riscv: starfive: add Milkv Mars board
      https://git.kernel.org/conor/c/4c536aa462f1
[3/8] riscv: dts: starfive: visionfive 2: update sound and codec dt node name
      https://git.kernel.org/conor/c/b9a1481f259c
[4/8] riscv: dts: starfive: visionfive 2: use cpus label for timebase freq
      https://git.kernel.org/conor/c/ffddddf4aa8d
[5/8] riscv: dts: starfive: visionfive 2: add tf cd-gpios
      https://git.kernel.org/conor/c/0ffce9d49abd
[6/8] riscv: dts: starfive: visionfive 2: add "disable-wp" for tfcard
      https://git.kernel.org/conor/c/07da6ddf510b
[7/8] riscv: dts: starfive: introduce a common board dtsi for jh7110 based boards
      https://git.kernel.org/conor/c/ac9a37e2d6b6
[8/8] riscv: dts: starfive: add Milkv Mars board device tree
      https://git.kernel.org/conor/c/9276badd9d03

Thanks,
Conor.

