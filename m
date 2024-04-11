Return-Path: <linux-kernel+bounces-140470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B888A1512
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A19171C21828
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB273146A72;
	Thu, 11 Apr 2024 12:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWJVvaqo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263044683;
	Thu, 11 Apr 2024 12:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712839812; cv=none; b=BvcRV+Jg7z1Ox6As28dGJUpJkeaOiPtuF6a4CZOc8phAe1PmMXvsqSlchJ2QjKY84kx3NlJCHJtmV//9rizXJhBUGBJDI2onxamsU+3wNfSa8i52ED3Oe7YMRlj1jcb3rot2vzX3wMAP27l5oGvFSh1coce2Knhoq1yu4g8tzrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712839812; c=relaxed/simple;
	bh=ghhbkHFttaYEjJHVjRr/ilnDerHWeK7MUzrODyMNXmw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IuDlSJDQPwdx+/7LXGvgdLYI7JTNSVbm5RTy6WDolsPM+KjZJz55Zg0ccH0cEgNJ5leRaFQaljKKiEdAV+TMNkTol5sGIIGMpkk5ISKZlxpedvexusg+sweWml1yhKgZFBklScg2VYQsZ+Ny75Wt+u82ccZiC4WdjdQB9X7+dBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWJVvaqo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0254BC433C7;
	Thu, 11 Apr 2024 12:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712839811;
	bh=ghhbkHFttaYEjJHVjRr/ilnDerHWeK7MUzrODyMNXmw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OWJVvaqorSRZngp3/okydGojUSKq7iNPdBU/NUvWv8FKs4nmabOoTJJ65LHS4wIFJ
	 Qx3Mz8bTlYROaapLliXHHCAEptuzPViL4pjfkhrWb/+EQHUYuulW3a8Mu1+T2yTGlq
	 0D40Ib9M8YZDnveIp06UTsnK1iwxTSB5mkUfKCQBBPkB472mWq93mzfrAut858RKLM
	 Wk5z3aAPSw0FvMeR+VilnJeLz9vgeQ/aK8SAeITlEYazeQZpnKtM06iJ0PW+7Ql3Iy
	 l3xN23NUXSHJ4uTy5K4U+1VS8MfIgFmKKvaC8MMVwtB3DUm0osm8pKQhc8Bsi706Qh
	 e39b0255P8VbA==
From: Lee Jones <lee@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Lee Jones <lee@kernel.org>, Ray Jui <rjui@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20240402202413.757283-1-robh@kernel.org>
References: <20240402202413.757283-1-robh@kernel.org>
Subject: Re: (subset) [PATCH] dt-bindings: mfd: syscon: Add missing simple
 syscon compatibles
Message-Id: <171283980874.2354899.3662943965972729204.b4-ty@kernel.org>
Date: Thu, 11 Apr 2024 13:50:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Tue, 02 Apr 2024 15:24:11 -0500, Rob Herring wrote:
> Add various "simple" syscon compatibles which were undocumented or
> still documented with old text bindings.
> 
> apm,xgene-csw, apm,xgene-efuse, apm,xgene-mcb, apm,xgene-rb,
> fsl,ls1088a-reset, marvell,armada-3700-cpu-misc,
> mediatek,mt2712-pctl-a-syscfg, mediatek,mt6397-pctl-pmic-syscfg, and
> mediatek,mt8173-pctl-a-syscfg were all undocumented, but are in use
> already. Remove the old text binding docs for the others.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: mfd: syscon: Add missing simple syscon compatibles
      commit: 9f43ae67db2a3d85cf2b5eebc3b54c8891200b5c

--
Lee Jones [李琼斯]


