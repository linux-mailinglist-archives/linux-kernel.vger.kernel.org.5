Return-Path: <linux-kernel+bounces-142594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B128C8A2D97
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6861B1F22014
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452BD5787F;
	Fri, 12 Apr 2024 11:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8OS9AFx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887C157864;
	Fri, 12 Apr 2024 11:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712921766; cv=none; b=GWbQanCSFHnYT0Ua8dSt81j5DDuUCUwQBYtHN+TydyqEZ+3h2oAsGy8IxoqDi3lah1Rd2/ktzpwAcmNlB7Ol/DHf6MbVnSWR7C1Am5wT9x5GDjlgx0KrnwQeObPNpDJ9XhdkfN3536RWLehFTbY/xnhMyA+/kerNITqAWsVusKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712921766; c=relaxed/simple;
	bh=chGlz5FfpucQrwEEUPSG8z86IzC4ekByV1HkK79lBGE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XPX2/2Jfk+YtjZyyi4NJb3FDSC3L0aOwF3FX2al9JtudJ9xG1dmKJKfEEJ1nVgHCxLTNYDNZQ5MO+Y6vwiHJmoz0+Sc84cviO3LYuKNOosWj/ZyEDNW6On38K+ZcbaTxfwOdqkWzGqdKPliywkzAzRR0h69svrDmocWR8pfgt7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8OS9AFx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06522C2BD11;
	Fri, 12 Apr 2024 11:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712921766;
	bh=chGlz5FfpucQrwEEUPSG8z86IzC4ekByV1HkK79lBGE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=S8OS9AFxp18uOIlZJSphFOPKqagir8s5qpP7inChMTomDCiUFKyxKh/RUPMx22xQs
	 pvsYkdLS0IOeGflS2cw+5GRx0dtqo4nV0secC+cZ7BCln7qfC2EDRVY0YTjO3JhSM8
	 Fic9tA0s6b/PF7zkbGDq7QL22xGvpsqNpwJs1HCH/CMYIDnExgnNMJSMn1LLGgSr2u
	 iIkGspMCQolAjAx00h4m1GZURijX4+DqxIU0x1ZyTujkGmL9vQyU1XVZOMMuyB2WMK
	 a1UGeptY1/CGMFMzn3JeN9B+Zm0xQryJl1BTuaxZ0+kh9XLM5PAYFzRkKJElqXH3+w
	 97yg+h+fSFfew==
From: Vinod Koul <vkoul@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240410-topic-sm8650-upstream-ufs-g5-v1-1-5527c44b37e6@linaro.org>
References: <20240410-topic-sm8650-upstream-ufs-g5-v1-1-5527c44b37e6@linaro.org>
Subject: Re: [PATCH] phy: qcom: qmp-ufs: update SM8650 tables for Gear 4 &
 5
Message-Id: <171292176265.599803.1266564123422138265.b4-ty@kernel.org>
Date: Fri, 12 Apr 2024 17:06:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Wed, 10 Apr 2024 17:39:40 +0200, Neil Armstrong wrote:
> Update the SM8650 UFS PHY init tables to support Gear 4 and Gear 5
> using the overlays setup (only supported Gear 5 before), and sync
> back with the latest Qualcomm recommended values.
> 
> The new recommended values allow a solid 50% bump in sequential
> read/write benchmarks on the SM8650 QRD & HDK reference boards.
> 
> [...]

Applied, thanks!

[1/1] phy: qcom: qmp-ufs: update SM8650 tables for Gear 4 & 5
      commit: b9251e64a96f87441694d41dbe98ee9349950fe7

Best regards,
-- 
~Vinod



