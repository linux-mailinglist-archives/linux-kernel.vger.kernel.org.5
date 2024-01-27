Return-Path: <linux-kernel+bounces-41426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A55C83F0C7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC71B1F257D3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 22:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52174208A9;
	Sat, 27 Jan 2024 22:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8QUYXkU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B9B1F94D;
	Sat, 27 Jan 2024 22:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706394870; cv=none; b=qqer17MMD2IM9BN24vGOPT5ImnLj2qTwv4ufEQcBZbbQZVNdP1JaoHmQPk+4yLUeGQK87MS3p3OBCByZw1R8cUvouGXKS21Iw8hK9f/4Kk+Q3e+lmlgxhZoMdob/qAiYE/C8ZhwVOEttPgym1g2db61R7Kmv/6sTCwQc80HKAL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706394870; c=relaxed/simple;
	bh=rOHsI3/hTHy0/lhB+ocr3FkC9si7oqS0XAQhDG8dA10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=svgUcAN4MRWpS9wNvcaX39m3NH2AosnX7mvfnyz5TZI/d3WOcYFfaL13D8ABQMZW7tM9Fp/kcegLlIKKEvHR61pwZECoKpih/5q+fNl8sEGgp9rYILoAHbJg49EcxLrKSSZKSwQ5oXOO0oZ80VFL0z8q8lkckVA5MduYdD7ETC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8QUYXkU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B4AC43390;
	Sat, 27 Jan 2024 22:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706394870;
	bh=rOHsI3/hTHy0/lhB+ocr3FkC9si7oqS0XAQhDG8dA10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i8QUYXkUMnGRJIS59k5CpPaBdHgQKe0oLbLkO+rtrv+hwDZGxPN9dyDz+3T9eyjxA
	 +D/mKk7670vXtYXcgp3uhqEdWi3o8Jq3Qv9XxRGjRSfmlcpUEhFqWl/Iqwjmr8tGaE
	 LPtH05VkJncIwXUsCilQwTgOF5vlS+CtYa+zU0HNcKhYkRrQav71w9K4+XoA8LaOCO
	 vnLuj4KgjIDxF4mGk0EPhkH1IxHLX6OWaykUC1/Bb2ZcjGCEtgHLYOckpMqdoTuUKt
	 3imFBzjlBGQfgG+ptReQ/d7V16fkLm4Dc9V7IK3o6dRtChxlA8sUKkBLOSPdpL1aOv
	 K5BE6sZkXVQFA==
From: Bjorn Andersson <andersson@kernel.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Luca Weiss <luca.weiss@fairphone.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v3 0/3] Enable venus on Fairphone 5 / non-ChromeOS sc7280 venus support
Date: Sat, 27 Jan 2024 16:34:22 -0600
Message-ID: <170639483108.20773.17416894843010809891.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231201-sc7280-venus-pas-v3-0-bc132dc5fc30@fairphone.com>
References: <20231201-sc7280-venus-pas-v3-0-bc132dc5fc30@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 01 Dec 2023 10:33:17 +0100, Luca Weiss wrote:
> Devices with Qualcomm firmware (compared to ChromeOS firmware) need some
> changes in the venus driver and dts layout so that venus can initialize.
> 
> Do these changes, similar to sc7180.
> 
> 

Applied, thanks!

[2/3] arm64: dts: qcom: sc7280: Move video-firmware to chrome-common
      commit: 82066cdb17608abc95192632fd5c702be8e57ab5
[3/3] arm64: dts: qcom: qcm6490-fairphone-fp5: Enable venus node
      commit: 2aa72de2fc9230c54048e3555d04e945ec4f8891

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

