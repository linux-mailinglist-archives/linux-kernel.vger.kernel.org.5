Return-Path: <linux-kernel+bounces-152643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5548AC1E7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 00:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D37E4B20A0F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 22:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0F15674B;
	Sun, 21 Apr 2024 22:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTxkiMvg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391BE55C2A;
	Sun, 21 Apr 2024 22:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713738595; cv=none; b=VOZquTdw6wP5VEw3Ftgqo2XJSWD362ROz7B6K0bZ6fKg/N/H3gm9lkBQoWsFB0K680IfnLY6tWS5EnIPXwLTMbRyYFHp3iKBF2dkDF149lvWo5rKh+tixWlreCOsi5PbZNch7z3NNbuKx25fA51qClW0FWmDWh5xqQusWxM/ZMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713738595; c=relaxed/simple;
	bh=ZNcVCgkTDmea8oQrpyd3U5Fq6udRJz+qUfv0POZHRJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rFmYYziofNiEu4U8HR2ehdYB30De3A9JDsiEkZ1i/TcPj+eAj9JeWDuJ2QQ8F9i/ilWmRqj1+3fOyn59Xs0fo5IIKLiXwWpQJjAifTAQOBjz2f8R2if1VApl9RHq3sUpsV9c0iCHTUdnY1+fyY9gtx6cSMZk9M4vFIUuiKCerDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTxkiMvg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CCCC2BD10;
	Sun, 21 Apr 2024 22:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713738595;
	bh=ZNcVCgkTDmea8oQrpyd3U5Fq6udRJz+qUfv0POZHRJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TTxkiMvg3k41QvHkq+AzQNBgt1WvJ2YMEg8fj3vub7eqgpCnCsAd1aZN6XVzZbH9+
	 Gk6Xr0V+95TufGURp6G/eSeZaUhAID8QZFJr2fE/Ey4ec/iJHpZgGrIIWhmEDRKNcl
	 mcxDJcNf7ea2H5l9Qq2RXSATntZzvTsxBWNyoKWX0uNHqID24d/zREab//1hNQwKZ9
	 yNBHiA9cdCARNB2C+8UOag86xQiFwe68NtdFhRhuNznugyCEq8ecZRS4aP1ZhBXDEn
	 YtsUcRygsfQRVmG/pdwszmcuoNHPnpCzcHm74TSXpF+g2qaB0oFvEw9hsPpTAgFBXP
	 8nUKEroi+6JVg==
From: Bjorn Andersson <andersson@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Udipto Goswami <quic_ugoswami@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sm8450: Update SNPS Phy parameters for QRD platform
Date: Sun, 21 Apr 2024 17:29:29 -0500
Message-ID: <171373856769.1196479.5641842041872427674.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240321062834.21510-1-quic_ugoswami@quicinc.com>
References: <20240321062834.21510-1-quic_ugoswami@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 21 Mar 2024 11:58:34 +0530, Udipto Goswami wrote:
> Update SNPS Phy tuning parameters for sm8450 QRD platform to fix
> electrical compliance failures.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8450: Update SNPS Phy parameters for QRD platform
      commit: 17a188d927f772663f8929bd5f2a990004af5917

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

