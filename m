Return-Path: <linux-kernel+bounces-63915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEF5853657
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E6271C20A65
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDE75FB86;
	Tue, 13 Feb 2024 16:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvl7/Rd9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFB12919;
	Tue, 13 Feb 2024 16:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842524; cv=none; b=YA4ldBJnOkTDWQtcM8gL2FiaHBDUAYXdbTSuaEguk2E1FvYVHz5PdoGEHGAKFExchd63ap2j//cDBn4gZHjI4BSZ81vfLk5YBvx6qL81B5iGj2mTeWQ3J2YJTvtiKLlulsA2I+aQYWeUtAhD1hs1TmhTMsVzJKcRwB1iWqB0YmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842524; c=relaxed/simple;
	bh=xbvPqK9JRSwLRR2qAODE8w5KCwA2ZAi76JUCkpeivY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=omG8YlXAoyziWsS3XDi7rPTtkdrvMryPk6kXKWATmo5Fo+9DvIdFesvHvIkOQ2Uuju4TQZPVfm5G8IOzsnv6+0HaIrTIwKIyWZsYafxdqydLiys37vVvF/u0m5Tl2GRAbFxEC1zOsteHMH8iKwZ3F20pUMZ2uP2DK/ARyNC00KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvl7/Rd9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACCDAC433F1;
	Tue, 13 Feb 2024 16:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707842524;
	bh=xbvPqK9JRSwLRR2qAODE8w5KCwA2ZAi76JUCkpeivY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nvl7/Rd9f/dgNSSy+oG73mLbWVb2Ca3G0/HlNI1cGGJzOWyouYpt3VJ418xqkFInY
	 nlXUH6ppypCPTn1dz3P9n7UuUEHCtxuJPRBYyx/60TPMxffYbcPw0RYzZuA0K5GYIE
	 vzd7V4QYMCs00FAiFRZ+wUnvF9OOSgp/FcZHWG5xZIxHecSrkPLOv2UtsXtUF/p8ms
	 1G0/YnOQX2CiFly1rXUeKMji5SqJfx6qhs3rVFxJonxDSml7SeAFc1f4atputWNAgU
	 kfj8cQHu10I42ss1EqlqkSHidYSFVUJyYAKTPeyax/pde48MqMWxez5znMo76dvu8w
	 ZjrV0uORvUl+A==
From: Conor Dooley <conor@kernel.org>
To: Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH] riscv: dts: starfive: replace underscores in node names
Date: Tue, 13 Feb 2024 16:41:55 +0000
Message-ID: <20240213-commodore-egging-baf7ad19ec56@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213144638.341509-1-krzysztof.kozlowski@linaro.org>
References: <20240213144638.341509-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=359; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=HRBHjd47TJfW8gNCG2QlfEZlC+TxUvJev6JfcO10PXI=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKmnZ18KmROe9t5Bcd+Ur8c37okpOZBe8vBSieTp/vgzM zg7zv5K6ihlYRDjYJAVU2RJvN3XIrX+j8sO5563MHNYmUCGMHBxCsBEAlQZGS5+2jL73DlHHYeW a+83Lnkcw1hvEvbgQN+HjKWmEYu8+5UZ/mf/tTq7915zS1r2vf6Fwos7/x2RlLzwxmrNF22DqtR 8Ww4A
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Tue, 13 Feb 2024 15:46:38 +0100, Krzysztof Kozlowski wrote:
> Underscores should not be used in node names (dtc with W=2 warns about
> them), so replace them with hyphens.
> 
> 

Applied to riscv-dt-fixes, thanks!

[1/1] riscv: dts: starfive: replace underscores in node names
      https://git.kernel.org/conor/c/f03606470886

Thanks,
Conor.

