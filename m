Return-Path: <linux-kernel+bounces-106928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC4987F58F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C4DD1F220CF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173917BAF3;
	Tue, 19 Mar 2024 02:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IG5zdsIZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2BE2F5B;
	Tue, 19 Mar 2024 02:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710816533; cv=none; b=X3F++CTKihYSveJkOOb4+sHnLXyQ+/CtBzDTjVvgvcgZSIZkI0PUaGue3Uxfv6lQhIUwOci2+cPYkuA5u+GLc+5letHaP/7c+d1N0AMIjTakG3b4w2JIM3ByBukX5rEh1OegDQHtHrkL1LH2MnRamXm9wi0dUOnR56/GIwBLWg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710816533; c=relaxed/simple;
	bh=4rp6U6D3ReHZ7lag5OzPj59vocZIj1ntskliq0WLj+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/NNiZu3F0juGH6JBUEXCjD1Z+q2MO9/nS0/a/b8Mp19TkpOQewH4kIpBYLx4TEfTHov106y6ZaUhVmf9xZK/OcOFyar53mO7i4ukdkHgTU7q85v53LY1ilweprKvmpfG/H7KYK1YMaz+xpUJ7iFg3UO22TstWaGSL5dIiwfBSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IG5zdsIZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185DDC433F1;
	Tue, 19 Mar 2024 02:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710816532;
	bh=4rp6U6D3ReHZ7lag5OzPj59vocZIj1ntskliq0WLj+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IG5zdsIZt4dTjSh58ACohiPqUyUjGaf2Ykv9IrbIkTpsf71gCztr7DtR61n8M85UO
	 vEmc9uJIgR0ObJ6k71WCIwHWqRFwuma+BrbLrZeKu7HJDbTRt0/u6Vft1HTIN2fNon
	 GaIZnLpjuEvD5/d0/7is+LQmTkzf21LSkW4Z+hiihLQIKqgx5pgdtam2HWMbTpE4od
	 caJJjK6ubUL7sgOixy92TtaI0nUPc/hJ/0IKbUrFR1tKe7JWJoSk7KWxSQG4q+Dfcl
	 nZh45svrRp7NMbdQcTMczmI68OSfEZl8mh52EVXBdyocJ038K5PPujLGkZDz0ib1XB
	 Yypibz/nRxYRQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] arm64: dts: qcom: x1e80100: Add support for eUSB2 repeaters
Date: Mon, 18 Mar 2024 21:48:25 -0500
Message-ID: <171081652654.198276.11595014135787145536.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222-x1e80100-dts-smb2360-v3-0-85a691d4f68a@linaro.org>
References: <20240222-x1e80100-dts-smb2360-v3-0-85a691d4f68a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 22 Feb 2024 16:19:18 +0200, Abel Vesa wrote:
> The X1E80100 platform comes with a v7 SPMI arbiter, which means it
> implements two separate buses. The boards using this platform come with
> 3 instances of SMB2360 PMIC which implement a eUSB2 repeater.
> 
> This patchset relies on the support added by this patchset:
> https://lore.kernel.org/all/20240222-spmi-multi-master-support-v6-0-bc34ea9561da@linaro.org/
> 
> [...]

Applied, thanks!

[1/4] arm64: dts: qcom: x1e80100: Add SPMI support
      commit: 53fdae5e086b699a66c6927395fa66c0116ec7ac
[2/4] arm64: dts: qcom: x1e80100: Add dedicated pmic dtsi
      commit: 3298d47894b0f30a42a4f93c36dae4838f638dba
[3/4] arm64: dts: qcom: x1e80100-crd: Add repeater nodes
      commit: 3930056f30d374967746876e01e8dca10fbc7ff9
[4/4] arm64: dts: qcom: x1e80100-qcp: Add repeater nodes
      commit: 04124220d8ce77409a5fa8cdea75dc2be999c932

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

