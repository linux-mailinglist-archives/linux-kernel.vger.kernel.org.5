Return-Path: <linux-kernel+bounces-69474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04043858A12
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36F801C20E78
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7932D1487E6;
	Fri, 16 Feb 2024 23:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUJHhpa+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9E917BC4;
	Fri, 16 Feb 2024 23:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708125583; cv=none; b=Iu16qJc3ALbFOx+6GL5lKkwk2/u5s+a0ebxjFkT+2gQTOCBdR24DAvoggrsI4p1D2ZdC5E36loMgskmefXqCO8wakPlwjoBGv3qCzlIjVTZm0O9L3DUvN9dsd1EFrLyrnZXShZMcHI31BXzE1Zz2FnQvapwTU56ip+4TmLFsdFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708125583; c=relaxed/simple;
	bh=fjIU+zlerVHYuBNajmsFB5i5JeZP6npjq7DiluzmWi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VLHe3dCJ1EOMMYxr0v/tmQ7ILc4c/NdilP/zsoW1P77Tz91kXhncc1dA7JBiUVOWa3R3MGJtcv0dHm7o2rN41hukawzRCuyiLJoYoW1JdvCWRX4uqWVj2WSifnOPLOevs9O0+8zRNqbI6iF+zrdnmWWpfWscRFmlf0dPmFhPu1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUJHhpa+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24CA6C433C7;
	Fri, 16 Feb 2024 23:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708125583;
	bh=fjIU+zlerVHYuBNajmsFB5i5JeZP6npjq7DiluzmWi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HUJHhpa+/5ES23IPLNXuLICqnvj24ym/TrQipfIMGXStHNyDmpPkSipqhDBaHQRJI
	 f33NT1pWQtJSSFCphWV2AtQlGhoDQ1x6FRTno6jFWS3/M6K2ttLhSXDFDS2o8nXcWT
	 mC+3gB7ix6M6GyXPXInd6D31MEsg3D+rCSHRdNSLDkTTOWpyHliy/JOVQ1upCMz7v5
	 Idm8Add7cZKe6sRT8EEX24lM5rDUl/WdHlC0A7chzs88Un1xgm6ocbAEhIwJ6odOEP
	 dOKFGw6CHgEtJjznqgUN9TWHHd3Rbnb69nsK25x4QqjhZe2mquzoQasC/9c16FgI7J
	 7KW+BCEhOBgrA==
From: Bjorn Andersson <andersson@kernel.org>
To: konrad.dybcio@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-arm-sm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc: quic_msavaliy@quicinc.com,
	quic_vtanuku@quicinc.com,
	quic_cchiluve@quicinc.com,
	quic_anupkulk@quicinc.com
Subject: Re: [PATCH v3] arm64: dts: qcom: sc7280: add slimbus DT node
Date: Fri, 16 Feb 2024 17:19:40 -0600
Message-ID: <170812557757.19212.2528185580656595315.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215090910.30021-1-quic_vdadhani@quicinc.com>
References: <20240215090910.30021-1-quic_vdadhani@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 15 Feb 2024 14:39:10 +0530, Viken Dadhaniya wrote:
> Populate the DTSI node for slimbus instance to be
> used by bluetooth FM audio case.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc7280: add slimbus DT node
      commit: 498006fd49c2d8b09c1eb55120667812d3b8f313

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

