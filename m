Return-Path: <linux-kernel+bounces-106931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFC987F59F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BB4E1F2207B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0E37D071;
	Tue, 19 Mar 2024 02:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kzgx90QV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5337A7CF1F;
	Tue, 19 Mar 2024 02:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710816537; cv=none; b=Xkr3EYNsEkjttn8c6l5otVudxLob1wb2m7dkKYRwM3BFzNFlivaGhl26+YYtMGamk9xP583I3pFMGIjlFjiR6oUVcDF32jYJDwZ339WgbLr3j5dnOC4vf5h+0PISeQkUqs1CSE0qXy9izFn6kA2uHozCC31wS9hjkkK9pHBV38Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710816537; c=relaxed/simple;
	bh=oJ6uGdMVZBppDLXBFc2HsKKjmGyAyAKoLUm3MpHWMdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kawGb/eilQmmKRC7BlcX8rySxTgPRDqP+iPnKfupNu/C4VM0aF0wbFQiZV8YzjpalkSLe1WgtEUqYWwizmhz03C+ipLufwbmLPOQpkWrmBrtRS6PtMijNFrZQzBQBg25y6g2MJGxobYFCnjikgr6oev0S19GK16H9Vih4XmhXDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kzgx90QV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89CA6C43390;
	Tue, 19 Mar 2024 02:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710816537;
	bh=oJ6uGdMVZBppDLXBFc2HsKKjmGyAyAKoLUm3MpHWMdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kzgx90QVL2SdQ8zxLheshhZQEjQRhD17sSWcuFg0vuyJ5gfA2+f6Ay1nhGM4jeLAG
	 Ewpj/GypGxTbencCgJgFRGB2WVeBBSuwzfker/wGYFvuFvj5oAtnzFASwHCebVoeUe
	 2pWaWCY++a32BrI6AH0M82A9gdjOOB1C3KkO7v54aJLlNYsLaH+JZhNQbcM9JLqDlR
	 /DAJ8wA5rIsuD+OxK0SQXQiTT5Ale0bC+N10wkNZSVImi3ZPpI8lbGaqP6PiDmN+dF
	 K3FP8uZGbieE2r0AH7tzBfxekjy9luMBeKXD89xBPUfjnYSpHuSqtu7Y0ORz09B1eK
	 iRrZKRgBZB6uA==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Anton Bambura <jenneron@postmarketos.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/6] Device-tree improvements for Lenovo Flex/Yoga 5G laptop
Date: Mon, 18 Mar 2024 21:48:29 -0500
Message-ID: <171081652648.198276.14923741889446549517.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203191200.99185-1-jenneron@postmarketos.org>
References: <20240203191200.99185-1-jenneron@postmarketos.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 03 Feb 2024 21:11:54 +0200, Anton Bambura wrote:
> This improves device-tree of Lenovo Flex/Yoga 5G laptop with these changes:
> - fix GPU firmware path (make it use device-specific firmware directory);
> - set names for i2c hid nodes (so it is clear which node corresponds to
> which device);
> - add touchscreen support;
> - fix touchpad issue when it gets stuck on right or middle click;
> - allow UFS regulators load/mode setting;
> - move some pinctrl properties to appropriate nodes.
> 
> [...]

Applied, thanks!

[1/6] arm64: dts: qcom: sc8180x-lenovo-flex-5g: fix GPU firmware path
      commit: 4aa609a922e3ce387d18d8e7327d3912f0a85653
[2/6] arm64: dts: qcom: sc8180x-lenovo-flex-5g: set names for i2c hid nodes
      commit: 8c28575a4aba092feb5a5ca0b446eb8a0fa39396
[3/6] arm64: dts: qcom: sc8180x-lenovo-flex-5g: move pinctrl to appropriate nodes
      commit: 0d76ffe33e5eb5b0a7bd09e4fa8a72f7f4cfbc0d
[5/6] arm64: dts: qcom: sc8180x-lenovo-flex-5g: set touchpad i2c frequency to 1 MHz
      commit: 46c2f36e76a018c269d236ec1a1cca03fe5bb47b
[6/6] arm64: dts: qcom: sc8180x-lenovo-flex-5g: Allow UFS regulators load/mode setting
      commit: 42ee55cb2e27d8bf3d26b8c4199727df029a5878

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

