Return-Path: <linux-kernel+bounces-36495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A06B83A1B0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D9881C22F9F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4D2F51E;
	Wed, 24 Jan 2024 06:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRWbiON3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F16E56D;
	Wed, 24 Jan 2024 06:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706076047; cv=none; b=g/yZcb7RvHvfm+WsYgWSisFLlakiM/Jl3JQfDwCgscSlXR6fxj2JiPRFVCkVw77UzTDmMPZyOwV4qK2aEih/xzDK9f4LrP5q5qOZ8hFjtazWzjtd+UtLs9L+CkjHVR00ArOhtt7jtPDxwFzuMzsiJJYOYgA0XQwxqSyg3B8Asig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706076047; c=relaxed/simple;
	bh=sGPsHgIicvARarqZWoXKFE09WA+6IAdaZJzFgorlCaU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TyK8h0+GgVLv2/m6tmxXl26QEtSKr+Rf7dRogugkyYdEeqUBSX6od39BDQZOmSPaoEseUnXtX41AcP2KDKVRvRH1YytsSQWG5qTop8euD5q14E2ea1inNNEIzR9YmQ6fitE28F6r/YBnWsht0nmchcsPRKeIutjaav+OndAG4B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRWbiON3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F988C433C7;
	Wed, 24 Jan 2024 06:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706076047;
	bh=sGPsHgIicvARarqZWoXKFE09WA+6IAdaZJzFgorlCaU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=QRWbiON3CPD+UjQymdOhQSseuYx33qGb2+ocPP5HbLo5fD3SyV3abVf8Trmnt1VsR
	 pQcMiyaUcUZK77QahhC8IIvFLfXUY9VpPUcuQwJzVxl+TLTyn8ECkbss5dG+b18TpZ
	 JyZg5ThL9Y78WYxLrusFuVrHE2dhFCU6gVOZxNunZoAcadfBg79Dm3xz2w+B6NV/U8
	 C0RhkUK6Xon3tm5GQ9QJxzEe5b2XcDgLTze3/S3aQmiaLldbLLNom2Z6fW6OXlteYR
	 ihJXkJaOhij0PBNT7FjUVp9iS01ahz9YRykqQIOnt/Guy0TiDP3jz8ghsjvfKsNX2p
	 w9YtZxU1fXxoQ==
From: Vinod Koul <vkoul@kernel.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Abel Vesa <abel.vesa@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231223-x1e80100-phy-pcie-v2-0-223c0556908a@linaro.org>
References: <20231223-x1e80100-phy-pcie-v2-0-223c0556908a@linaro.org>
Subject: Re: [PATCH v2 0/3] phy: qcom: qmp-pcie: Add support for G3/G4 PCIe
 PHY for X1E80100
Message-Id: <170607604322.409477.15738588939361741186.b4-ty@kernel.org>
Date: Wed, 24 Jan 2024 11:30:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Sat, 23 Dec 2023 13:55:20 +0200, Abel Vesa wrote:
> This patchset adds the G4 tables and G4/G3 compatibles for X1E80100
> platforms. Also adds the pciphy_v6_regs_layout to be used by the G4x2
> phy and switches all the old QMP v6 PHYs to use the new regs layout.
> 
> 

Applied, thanks!

[1/3] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document the X1E80100 QMP PCIe PHYs
      commit: e94b29f2bd73db149ce7fee9a41a7b6ca17f7918
[2/3] phy: qcom: qmp-pcie: Add QMP v6 registers layout
      commit: 70e0af37e81e8a19e207ccf14953109d793087cb
[3/3] phy: qcom-qmp-pcie: Add support for X1E80100 g3x2 and g4x2 PCIE
      commit: 606060ce8fd09891d97358e35fb2d2c00c787449

Best regards,
-- 
~Vinod



