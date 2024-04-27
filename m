Return-Path: <linux-kernel+bounces-161150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21ED48B47AB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 21:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BC161C20C4E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 19:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705BD158DDB;
	Sat, 27 Apr 2024 19:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/bCRnOu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97AC1586F6;
	Sat, 27 Apr 2024 19:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714246473; cv=none; b=hqrn0xEwO4EuNTRl79aoG/SAQthdqy1DhOOoXvdixS/hqnfCfHtPGj4O+bp8r/tx4zGk4kUGqM/muM7J4WCGHXJG9G2xGs6fVWZg47qNdU8YQDDbA621U3Jj2e03+Xj8NHDi5wVC/bKjkAGgJod56JzCzPgTKpRGUFl8ZhffLM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714246473; c=relaxed/simple;
	bh=BFiPTRnM/ZfB8nTkKaHdiqWyaKB82M6Ojbe8Uut7t20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h4SP1helVYyh2B0Sbc7oK/Bzgh0YNK0HRGsWyEkKhJ/lQ9xi4dCx2RLnprHgoPHabvBKfJSf22QbNA4URnudxNjMckCt/PT8K9Ii8bXyQErY+GqoQQ3iuMkHRAIO14lXwj6+OfnDzLuapu0BVyp3gpnF4U8j6cYvXrIUTwA4wJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/bCRnOu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C5BC4AF10;
	Sat, 27 Apr 2024 19:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714246473;
	bh=BFiPTRnM/ZfB8nTkKaHdiqWyaKB82M6Ojbe8Uut7t20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e/bCRnOu7OJfSV4pHHbeLVdefdNkT2mQe73oUGX2Db+RqN71AfCCqtRsnnlcs/nO/
	 Tom6rhQeXnpTy1tzbVbWER3s/qBeSSvCw9C57HfWGZR5cBkFOz31Ds+lFWpd8q0b3p
	 FCe01qhQr5NSOX1kIVDC9efAImpVrQDQ+53iX3DeEK4eomME0QoUsWiLWzw44dkxXW
	 Gy9/Lm9/9mhJ2pjipbDapvNQyXhs8tBD6vyIFxcRvEpBsBm/jr8UYgSIqJPnBRB8zu
	 FO3HdzD5SEOjEqy4Td/HJjSNYWTLBjAYVZGb3J1YU4TcOxZU8xXhac/0F43aVO4xbk
	 j3Y0agE5yLSyQ==
From: Bjorn Andersson <andersson@kernel.org>
To: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Luca Weiss <luca@z3ntu.xyz>
Cc: linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/3] Convert qcom,hfpll documentation to yaml + related changes
Date: Sat, 27 Apr 2024 14:34:22 -0500
Message-ID: <171424646115.1448451.2799860165107688219.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240218-hfpll-yaml-v2-0-31543e0d6261@z3ntu.xyz>
References: <20240218-hfpll-yaml-v2-0-31543e0d6261@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 18 Feb 2024 21:57:24 +0100, Luca Weiss wrote:
> Finally touch the hfpll doc and convert it to yaml, and do some related
> changes along the way.
> 
> 

Applied, thanks!

[1/3] dt-bindings: clock: qcom,hfpll: Convert to YAML
      commit: 849ed9d414d04e369bccc2278d75becde9e40e0f
[2/3] clk: qcom: hfpll: Add QCS404-specific compatible
      commit: 3db0f3b9ff5adb6a5e8564a32fadb2af1216810d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

