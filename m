Return-Path: <linux-kernel+bounces-41429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B6583F0D2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 908591C24C5C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 22:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAA11F922;
	Sat, 27 Jan 2024 22:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QH+dooaY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487ED1E87D;
	Sat, 27 Jan 2024 22:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706394892; cv=none; b=EZ0DDhvkYEkvyaCR5Hrw0k3E0Ru3YSVQJMbsj+zJGIPPCKkcffidDBd+XnYWnz97sfrc4UARUWroGDB2QgV8MlkujGHaMLd6wel/c/XgQNP1EGVZqaBKoadhlQqwh1sgVpKd/Orso3hWLH0XZf2rYs0bqgTri3c1h0bX6hr8sjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706394892; c=relaxed/simple;
	bh=QwVGyBOyyQm5ng8xorMzhmC6WNJpBKU91L9mLbugc2o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J5pvH3pdVbcMbg+EqgVD2mB1Durt8CkGhO/H+/6db1++xj2jWl1D4IILwurkL/L3SMNELID5nJ9loW2VNvLZP2nOyvlHEHeqtHMxgfcy4Mz5xMVB762uI3/3QF7I8qoPP3lT9cK3v1E3uvlDVJJNdUT16SdgmnbVpY7PfjNWIQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QH+dooaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60328C43390;
	Sat, 27 Jan 2024 22:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706394892;
	bh=QwVGyBOyyQm5ng8xorMzhmC6WNJpBKU91L9mLbugc2o=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QH+dooaYlabZGEIcoSJVwl2wQfAQp1/7QW4lCR2fpJ9Gh8vdNvXubknlnQQDXG0Sh
	 fFB1l0ozIi5CVaEUaQHzgEfR4meSwCSVi9yyZedp4k9Yg+klErcz5j4LAVNDwEA4w0
	 DuY6HV6vp6OKF4htlT28NSmSfcwhDnaDeQMFaRNF4dAERGkkU2pDc9/SQwvj5G8Czc
	 n2iJLz3nFIVyqwagEgtgPamzGOYaW8GuDmxNS1Bb558xzt6HT2+rQGX4oiP80lqsLf
	 r653BWZsbG1CILjqFbpt2axMPEY+Y7haA5iwfaVsWZBgJZwYg5xVcsFzF2nKp44DP4
	 r0oWJQSO7rKAw==
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH 1/3] ARM: dts: qcom: ipq8064: drop unused reset-names from DWC3 node
Date: Sat, 27 Jan 2024 16:34:43 -0600
Message-ID: <170639487714.21016.17473117727051258489.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231112080136.12518-1-krzysztof.kozlowski@linaro.org>
References: <20231112080136.12518-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 12 Nov 2023 09:01:34 +0100, Krzysztof Kozlowski wrote:
> The Qualcomm DWC3 USB controller bindings do not allow "reset-names" and
> Linux driver does no use it.  This fixes dtbs_check warning:
> 
>   qcom-ipq8064-ap148.dtb: usb@100f8800: 'reset-names' does not match any of the regexes: '^usb@[0-9a-f]+$', 'pinctrl-[0-9]+'
> 
> 

Applied, thanks!

[1/3] ARM: dts: qcom: ipq8064: drop unused reset-names from DWC3 node
      commit: a78a95b98dc5b4dda925b2e9981abf815a46b0de
[2/3] ARM: dts: qcom: sdx65: correct clock order in DWC3 node
      commit: 7d912adff5c6484be16b3081aa5ef716b88a682e
[3/3] ARM: dts: qcom: ipq4019: correct clock order in DWC3 node
      commit: 71ae7237cd31948b3414aaa07dc594a9fdb8d654

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

