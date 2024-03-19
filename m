Return-Path: <linux-kernel+bounces-106942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA03E87F5C6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 254081C2186A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B7B7FBBA;
	Tue, 19 Mar 2024 02:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyOcU66H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30CC7FBA0;
	Tue, 19 Mar 2024 02:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710816550; cv=none; b=jdkrmjqkQNZWvVQS/DpnK39MDFYupA8S/gyR5W3DWZBpsoxZQdwCttJR52JzY2hlgMDlZiy9pgrqOMArIdTgGa0UbmefXdoi4Y5CgWPhCkqhw8YUy2X+k5RI5pgg+D8z27yfSe7xwip5ifxHGmKHK0a6sl/YcKEeQk6MEzS2zbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710816550; c=relaxed/simple;
	bh=CWfhtDXwapArzpS2/ShuQxMZtfvWQfLsKurMqVDkLCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GLa+CWzTCs/XmUOFnFW7cU382pC6V34+yCqCbAoBsk0eNpNcc8TdKQhH41E5qv1F7rhCn1yzIvzFTpX2cqkQ+TS9cwLhL3P577LnmyDA6PjAKz/NCfCg9Ww3JobC356loDH0ZNjYz6XTYo0j0j5qApAPH2WgjlbpMub51IS1Cmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyOcU66H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1A4C43390;
	Tue, 19 Mar 2024 02:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710816549;
	bh=CWfhtDXwapArzpS2/ShuQxMZtfvWQfLsKurMqVDkLCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gyOcU66H3km7F66bQFvWdPdygrrvv7zuxKXrua1kVS0IPzRNUTTpMVt1oE9ATdDYl
	 LF/qIi+B1gbBFqVICEw1A+JNxOYy+Gb+deKa35zcQfTOJZgEZhadBySF/a8qLNK4Gj
	 XxUkl9eP+esNZjIoEjnglfF0vjCeKLWuIxwFHu8Se0tBiwNHdYwZfuKI/pi3SMoPTw
	 VElyIPwsd34mnn0eQiDrlTgqCpbJedlljSIotBptAcIrQ8awvcl3zK00B6px3tuI7A
	 c7pkB1vRLVCbu70iOyZ9pvt+Eo5WJUrxqtbsg4jPurC/C79jJAdb9nfv9b5TXxMyG5
	 4nuAuT6jhuGKg==
From: Bjorn Andersson <andersson@kernel.org>
To: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Gross <andy.gross@linaro.org>,
	Luca Weiss <luca@z3ntu.xyz>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Some devicetree cleanup for MSM8974 Sony Xperia Z2 Tablet
Date: Mon, 18 Mar 2024 21:48:39 -0500
Message-ID: <171081652657.198276.9729045181357785741.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240306-castor-changes-v1-0-2286eaf85fff@z3ntu.xyz>
References: <20240306-castor-changes-v1-0-2286eaf85fff@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 06 Mar 2024 00:18:03 +0100, Luca Weiss wrote:
> The sony-castor dts has been around for a while, clean up some things to
> prepare for further changes including the introduction of the
> shinano-based Sony Xperia Z3.
> 
> 

Applied, thanks!

[1/5] ARM: dts: qcom: msm8974pro-castor: Clean up formatting
      commit: c0b9c616e881a1ea6b158dcad73e2198c483a56a
[2/5] ARM: dts: qcom: msm8974pro-castor: Add mmc aliases
      commit: 0268bfec8ae06bc1091c2b9058287391872f8853
[3/5] ARM: dts: qcom: msm8974pro-castor: Remove camera button definitions
      commit: 26b950f2af40bd6cc36c3ac8ee6643ff3e905753
[4/5] ARM: dts: qcom: msm8974pro-castor: Add debounce-interval for keys
      commit: ead56f2e68b874c3549a67c6ae0c6186f780bf2f
[5/5] ARM: dts: qcom: msm8974pro-castor: Rename wifi node name
      commit: b756001175b1145a4855c8cfa77ceec78350c36a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

