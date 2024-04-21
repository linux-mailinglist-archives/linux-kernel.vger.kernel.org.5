Return-Path: <linux-kernel+bounces-152629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B1A8AC1BD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 00:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 151431F21004
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 22:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B024CE09;
	Sun, 21 Apr 2024 22:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiGz2npN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0767F4AEDF;
	Sun, 21 Apr 2024 22:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713738580; cv=none; b=CoUYiyoTL9N4p7tvJyh988FAnLa2ed5IPKUym4MyMaa8coomwXbkPAA+pOUeaMYNLrdLPNIu+RcbA/tChJhtktGNgRROOLXKapLyWetxTVcaYuapWsPViRbxUk1I2a7XhcX35VswyDA79GvKJ0RY7kOKEl2jTnvBue2FE+Xwtpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713738580; c=relaxed/simple;
	bh=KT4Zr8XakFQd+cvqM2qj2rWx1AuzeHfgNWVDm8VCpgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MLb2hgM4jzeipcV2B9ZFsUCQ6ET0Sf1P+Qmdt72gYtvjxm0Xvzwg346ve84og2GS6XPhVhGilXxgGekHOk9Xo/mec3gvM+N+xbxSdR47+ssxH8ABow1UwH5pMejHC3Uv1989m4mjzaCCN9bpTuKuryBU9w+OJkQhbSPLOhvSPU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SiGz2npN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32EB7C4AF0C;
	Sun, 21 Apr 2024 22:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713738579;
	bh=KT4Zr8XakFQd+cvqM2qj2rWx1AuzeHfgNWVDm8VCpgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SiGz2npN0YobmOjsxd7pB/3Nbiq6G6Ak3+xo6j1MVUKGugKAp23IbGPAvgN7+4bmD
	 w97lc/AcBavYNURAlV3DYa4U6cqGiSEhWjxVNezUHbPnX/Fz0AuU6tTa7+UWJp5MCI
	 FkMTXSlYcw1Gd5Pw86bcIRyTicyOh4JBejIBmGiLzWCDBW4NGluSvAMcxUjSbEIiNW
	 +Pi8j4O4LZZiBP+5vyGt/TNCiz5INGuOXkHyJqP038GCj7BBokWjIEr+qrPsINECB9
	 XBHDBreX9oRUhMTe4mFja3uuH2jEWximZ7UiBTky2LoYkmBRWcOR3SMtep41eaiAbm
	 mkpwyysj5dqdA==
From: Bjorn Andersson <andersson@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: Fill in EAS properties
Date: Sun, 21 Apr 2024 17:29:14 -0500
Message-ID: <171373856768.1196479.18038444368463734568.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240319-topic-8280_eas-v1-1-c605b4ea063d@linaro.org>
References: <20240319-topic-8280_eas-v1-1-c605b4ea063d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 19 Mar 2024 16:23:33 +0100, Konrad Dybcio wrote:
> Replace the bogus capacity-dmips-mhz values and add the measured
> dynamic-power-coefficient values.
> 
> The power numbers were measured by matters much more precise than the
> laggy and cache-y pmic_glink battery data, though the reported values
> were only accurate to 10mA. But that shouldn't be an issue, especially
> for the fat and power-hungry X1Cs and given that *each SoC unit* has
> somewhat different frequency-voltage maps.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sc8280xp: Fill in EAS properties
      commit: 365e19c466a57ff17093cf6e9f8ad362dd122602

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

