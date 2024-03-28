Return-Path: <linux-kernel+bounces-123463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 777E88908FB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17DD81F24CBB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E169D137C37;
	Thu, 28 Mar 2024 19:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TX/TPPK/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EB2136E13;
	Thu, 28 Mar 2024 19:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711653554; cv=none; b=gmvVAeEoNVm1W2ErNyvyMcxhxiQ7TGXzydI1NNQQcF4caCsiXH9+W1iELLbZgxf1i2C2fxASq3g5UvnWcTyq+cX08HX1JOtHyc2ralh3JMQR9drH44w4KQ5fVI7ky68d3d9dSqhJRaPAEnwSVC89TH/11cC1z1nznaKu8+Tb5Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711653554; c=relaxed/simple;
	bh=iSmXMTfJak8gxA9ioiFk1xWqNqgnFX4tNdouyFOFKzU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GJC/lOoBnMUnrbc4V4WxrGyZEiqAw6Qz7MDimPaYdhuEHwCdcBqKwl6FJiCvwAedYWv0ybESgd7wpKJo5YMA7NfY/B8biln9Xf0o7yZKJLHUjaNr7HJFBuMcRPsR34j4RnZBmQEPh+3iBtZkRxLlO0V6jebflA/1y0UQrxy9APQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TX/TPPK/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76F6C433C7;
	Thu, 28 Mar 2024 19:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711653553;
	bh=iSmXMTfJak8gxA9ioiFk1xWqNqgnFX4tNdouyFOFKzU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TX/TPPK/XYJzzO1pwCUb26poWrm2a/lS7wwJ7llDMUc/EuBapf9fqGcDrhGHjCw9n
	 plST4hgyhv4Zov7gosFoJG/QvYT871e/R9w5iNxREXpufEFN63qHMW9S/OBcaFmov/
	 +RSPIX34qNS84ArOZw53H+LaycdJtiO3yEM2HcJ83zb/rmocUC4hmANtTTHZIPXK1y
	 sgbV56KSpI5LhIl/TicLck10mIjAH0dyTgo//Zucn1mSxzAen9oXTcWW7Gr1aVysM1
	 NeP4sZnb+KeI6Ex/EaLgd0X4L1885xGZGa/lvALogFoQIcPCbNZO9K1tdfu1efddeI
	 KztvTwCdhlUNA==
From: Vinod Koul <vkoul@kernel.org>
To: linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org, 
 Adam Ford <aford173@gmail.com>
Cc: aford@beaconembedded.com, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Lucas Stach <l.stach@pengutronix.de>, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20240227220444.77566-1-aford173@gmail.com>
References: <20240227220444.77566-1-aford173@gmail.com>
Subject: Re: (subset) [PATCH V7 0/6] soc: imx8mp: Finish support for HDMI
Message-Id: <171165354734.152390.12386757633951091803.b4-ty@kernel.org>
Date: Fri, 29 Mar 2024 00:49:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Tue, 27 Feb 2024 16:04:34 -0600, Adam Ford wrote:
> The i.MX8M Plus has an HDMI controller, which depends on several
> other systems.  The Parallel Video Interface (PVI) and the
> HDMI-TX are already in the Linux-Next staging area 20240209, but
> the HDMI PHY driver and several device trees updates are still needed.
> 
> This series is adapted from multiple series from Lucas Stach with
> edits and suggestions from feedback from various attempts, but it
> since it's difficult to use and test them independently,
> I merged them into on unified series.  The version history is a
> bit ambiguous since different components were submitted at different
> times and had different amount of attempts.
> 
> [...]

Applied, thanks!

[1/6] dt-bindings: phy: add binding for the i.MX8MP HDMI PHY
      commit: d0f4b70eb9a9ed05a37d963655698906cd4dac9a
[2/6] phy: freescale: add Samsung HDMI PHY
      commit: 6ad082bee9025fa8e0ef8ee478c5a614b9db9e3d

Best regards,
-- 
~Vinod



