Return-Path: <linux-kernel+bounces-132151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFBA89904E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 283F11C22F3F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0539013D606;
	Thu,  4 Apr 2024 21:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WE73n81a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479E413D52B;
	Thu,  4 Apr 2024 21:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712265822; cv=none; b=lxou034vr12S6Yw6KkctkXrKR7V42hi0pGyQGpNoOaP4+9RTy1W6JQdWt/p3DM0pctG54vnJ4NDFhgrZbpByqVyjDf4fGkKEiLR/AYBh2kDwfEpodIEPT2FSLjfzHAOTyB+9rh+1ykV2b+wK6UEQ3gteosYuNJZD44fYhH4o9Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712265822; c=relaxed/simple;
	bh=pKx5pEl7lbJZzVFbLbwYKUyOTmfXWn6rEDtp+m1OFEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m7LW335Q/GOgS+CVk411gRvvlNNjWt0q2yiia2/eO134F8NtJX4C3jFA7is6D7Uip5lykOMj6EUGHGpHhK0Z7Dnkm9ahbHnjzKb3F+nP56I+sZDWxggiFh6McB0FlozIS16F7n5YZinwtLws5k3a0OvecLf70/fZXbPgWaE3xyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WE73n81a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BEDC433C7;
	Thu,  4 Apr 2024 21:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712265822;
	bh=pKx5pEl7lbJZzVFbLbwYKUyOTmfXWn6rEDtp+m1OFEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WE73n81aTQx5Tsg02WQy6mU9DiwEIS+5eOzWReHJQHlr0ML/IxSabjoC4Addy9f1+
	 xM85Tb2ODlI4qo0cLdi/UcT35xy4+3/38pTfhZOUBZpCwTJ7hBJrCYB9+JzzXQM2kM
	 GRbraJDXd3+TqN0n8azsTZ0N6spdoHIGeQ36xiWuReZs7R9UdP9Q7BybtpJZ6QwTi5
	 QlJtt/AmOgJtA/I9GbzNnB03QFOOa/p9Wbb1Wbbxv7QhQjW2rlgYC5SKMga2f0gaT2
	 kw4PKOiiAOtT7nakq+xZ6rS6JTgpkZa0mX3wA081l6QVqd8uCQCtN2mQ/6Z4nR9eYc
	 gwwjVS+ycbXyg==
From: Bjorn Andersson <andersson@kernel.org>
To: linux-kernel@vger.kernel.org,
	Raymond Hackley <raymondhackley@protonmail.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephan Gerhold <stephan@gerhold.net>,
	Nikita Travkin <nikita@trvn.ru>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Joe Mason <buddyjojo06@outlook.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: msm8916-samsung-fortuna: Add touchscreen
Date: Thu,  4 Apr 2024 16:23:07 -0500
Message-ID: <171226578674.615813.17206217904604051160.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240312074536.62964-1-raymondhackley@protonmail.com>
References: <20240312074536.62964-1-raymondhackley@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 12 Mar 2024 07:45:42 +0000, Raymond Hackley wrote:
> Like msm8916-samsung-a3u-eur, the Grand Prime uses a Zinitix BT541
> touchscreen. Add it together with the necessary fixed-regulator to the
> device tree.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: msm8916-samsung-fortuna: Add touchscreen
      commit: f8dddefcb90eaa339c77b2cb3f5a87dec8b1e3b5

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

