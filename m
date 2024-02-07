Return-Path: <linux-kernel+bounces-56592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1749B84CC48
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C829629019A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E567E56B;
	Wed,  7 Feb 2024 14:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPiMSH/+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C8F7CF01;
	Wed,  7 Feb 2024 14:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707314489; cv=none; b=RfkDO9ZhqHy30ILqshHCQdmMbsnRNhCNQufFPPMF7qbUAPS+mMQvJsMyVwlXI10VHreHWxk/zNeYE6nSUlH3Vb6wtJo9SRW3Y0T7K1Z2s6GYr59cQy+epMJK4tFj084Da9hA6VG3rxFZ3cUAlqP9bz0axzaPNu1Np0M7DoIexo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707314489; c=relaxed/simple;
	bh=TYC7LtO/XIK1krUNB6/WrT2Hlv8JIjGH22j96FIBAHg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jZh23/Zb4Oer2bon+STaWfPPCnr3tFIKwUonh/n1idsT+3ZqIuTfiBqxCHYdibo+LqGJUAxTm5ia06oqG64um6Jf6q6q6tdCVyzx3r4rzGhlLq2NaA4Zx8+6AjJmUOK6G/MgDRyUM5t+1Gf1SkLhq0nK0nDFSH8fGlMCxKQ0h8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPiMSH/+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791CBC43390;
	Wed,  7 Feb 2024 14:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707314488;
	bh=TYC7LtO/XIK1krUNB6/WrT2Hlv8JIjGH22j96FIBAHg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=vPiMSH/+kG/4evxruFjzpabbUkRNc2FGNcTScr0OPo7yOgTZoq6vmPg4VqHjnNOdS
	 2L1m5oKc/afW66wqRsLAdtiWepK5ttZN6AHzm8l2MXoW+c/26hzNInWsl63cd23vQh
	 oC1gqtOmoFdoaxhaS21pu0M2YGUY6NlorN0XqDTtt5RtrHpsLYvB9XYhUDPjRLnkwD
	 DyHZvOaD51YqSVI3NDNki0/Y+JlU7apa/pb0eF9Pz+TvUkMdu6cL+f5wsMF3JeFTwR
	 nU1Mi7R72xRpLHoZv3wLvOJFX04w3wWSN6qyAi12w9W7YPj1Q88F5WrglWc0cAfJ8E
	 I4Ra43zEbPhNw==
From: Vinod Koul <vkoul@kernel.org>
To: kishon@kernel.org, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Swapnil Jakhade <sjakhade@cadence.com>
Cc: mparab@cadence.com, rogerq@kernel.org, s-vadapalli@ti.com
In-Reply-To: <20240104133013.2911035-1-sjakhade@cadence.com>
References: <20240104133013.2911035-1-sjakhade@cadence.com>
Subject: Re: [PATCH v4 0/5] PHY: Add support for dual refclk configurations
 in Cadence Torrent PHY driver
Message-Id: <170731448623.147119.2432224542045768043.b4-ty@kernel.org>
Date: Wed, 07 Feb 2024 15:01:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Thu, 04 Jan 2024 14:30:08 +0100, Swapnil Jakhade wrote:
> This patch series extends Torrent PHY driver functionality to support
> dual input reference clocks.
> 
> It also adds support for following multilink configurations:
> - PCIe(100MHz) + USXGMII(156.25MHz)
> - USXGMII(156.25MHz) + SGMII/QSGMII(100MHz)
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: phy: cadence-torrent: Add optional input reference clock for PLL1
      commit: 8499d84894faa8e83f2aa2b064ad9c81296db162
[2/5] phy: cadence-torrent: Add PCIe(100MHz) + USXGMII(156.25MHz) multilink configuration
      commit: 8163ae426c8a4a0cbffd7fd81711892679d5a416
[3/5] phy: cadence-torrent: Add USXGMII(156.25MHz) + SGMII/QSGMII(100MHz) multilink configuration
      commit: 8c827d87ed3f77d1fcb0b43f1ff25550f187fb5c
[4/5] dt-bindings: phy: cadence-torrent: Add a separate compatible for TI J7200
      commit: 97f5aea36c593bd9ab4b735c8a3632fe5782ed88
[5/5] phy: cadence-torrent: Add USXGMII(156.25MHz) + SGMII/QSGMII(100MHz) multilink config for TI J7200
      commit: 39fbf1074264d33d66effdce5e5a887a28de13ec

Best regards,
-- 
~Vinod



