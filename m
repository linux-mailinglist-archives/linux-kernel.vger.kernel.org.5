Return-Path: <linux-kernel+bounces-55946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2EF84C3E9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDD891C2592F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C9C1F934;
	Wed,  7 Feb 2024 04:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jw3qbxO0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F421EB3B;
	Wed,  7 Feb 2024 04:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707281218; cv=none; b=kORTA7e2CZipLufNxFKv12N2SE5SdLUgpkyJQ2gReREhmpIbeFkQRqVfKeMcTvkToutZL6JNue46PiirubuxRKJPAAXpWsA3rYtpN5bmHXyqnnhgBH7kFB48uwsTcaf6sXK6Qk1M5N9blZgYpQS6X0qBgl3luWKzlHbq9bY2mA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707281218; c=relaxed/simple;
	bh=jn7NKyy+JbYJae8CSyIvCz/hvmFATL3LAmTO5MmZnCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mRPIMsbDQnFPft/ObpkfE0alEKT36XswDm4N6ZXQzxfK91l1nhRRcHXrKFtjp20Lajwd8/f6owa50OYx0I7lnaQEr1bSEcmVa0DkNbx5/Zzm19Q5H9AtLWHw+VQHPwwW+F0Pjq1KC5OccG9aY3ew1QX1Yy9cA7Oq8F12j4ZRWmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jw3qbxO0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87550C433B1;
	Wed,  7 Feb 2024 04:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707281218;
	bh=jn7NKyy+JbYJae8CSyIvCz/hvmFATL3LAmTO5MmZnCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jw3qbxO0xts9mRCW3wUtcTZXPMPX4fxZSwJZ9XZKT++5MBSE703Fi/Vohpo9jHKKG
	 NGNX82AUlraAYj8mHKF+UvbZA63iT8Dgs476uckjhEvtkCboR0HuMR72oTs1homQ3F
	 GaaguA6ibxwcbqFrbGGSoRgd0TgsfS9WthgXc9ULTNrHrVYPl/QR08QCs6ecAS+Reb
	 xn3+X8aaavcGrFw03JCZJp3cmStVxOEe4Nu8VxtSq35y3gcyWg3F25P11MBFH3nacX
	 sEFuWhsJpqI0/Lm4mpObQLx+k9g+UXh7TgyOg1i2o/ttt6pYy4Ch7CcmTdHUdvs8da
	 Tvq/1AVA3Pbjw==
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
Cc: Abel Vesa <abel.vesa@linaro.org>
Subject: Re: [PATCH 0/2] arm64: dts: qcom: x1e80100: add ADSP pieces
Date: Tue,  6 Feb 2024 22:46:21 -0600
Message-ID: <170728117670.479358.14018064010020173967.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231212125632.54021-1-krzysztof.kozlowski@linaro.org>
References: <20231212125632.54021-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 12 Dec 2023 13:56:30 +0100, Krzysztof Kozlowski wrote:
> Depends on:
> https://lore.kernel.org/all/20231212-x1e80100-dts-missing-nodes-v1-0-1472efec2b08@linaro.org/
> 
> Bindings were already applied.
> 
> Best regards,
> Krzysztof
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: x1e80100: add ADSP GPR
      commit: 99f63aea9149e09239872a7315415f2d4be8ac86
[2/2] arm64: dts: qcom: x1e80100: add LPASS LPI pin controller
      commit: 060df4cbfe111d9034866f9e9757d191a22719fe

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

