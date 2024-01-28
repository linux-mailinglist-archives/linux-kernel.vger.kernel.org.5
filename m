Return-Path: <linux-kernel+bounces-41508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB25783F2F7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 03:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19D8C1C21373
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 02:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C842374A;
	Sun, 28 Jan 2024 02:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYOYEw02"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33AC208B4;
	Sun, 28 Jan 2024 02:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706408259; cv=none; b=cz/FFBTSbjuT7y8kjk96o8S4D6YKNFY19gEWTsW57v0ygvMogEiGX8n1tbTmfXaSoZdO3f7LzKTz3X1y34u2W28UqktX48iDd7FJNRI9VoZA9d5T8ip1/nEXAzuuLpcpZuc5TnMP+JNv/HLfhsfkctpx3v9uUlP/+jXRsxconV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706408259; c=relaxed/simple;
	bh=tyirgeL4YgXprswp9IxEESN0RSu5SoIzumMdB6GmTrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xr8wBs6pGKvrFbaWUg8a4f9W9NWXqoDhBFk5+02CXMDlN1SqiGCHOuh6QGOhRscvwweN0Hb6WJyVYrNE564JHUpMWIQCs8UrNfwiw1zHL42yCF0drBb16IpSXZxrD8lXD6RsRyNG69IwIBNZy5KfZBravWgajUjJK4WyuJVwuIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYOYEw02; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FC5C433B2;
	Sun, 28 Jan 2024 02:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706408259;
	bh=tyirgeL4YgXprswp9IxEESN0RSu5SoIzumMdB6GmTrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PYOYEw02jDR4ge09BjLvw4SLHL1GFnRtDEu9Ojx3j+VA3opgBKpcjjpj0yoR03yrh
	 qZivpVHyvp3YzdrwU0uElsRoWZ3mUGvLxOM8+m2CAnERvMAP3ro6uh3xxGeipYlXS4
	 kZ/BdBp50HILb8OuaLijVUQFJPCR/JyKEHMsD92g228wABZkwKjBm0zHTSjes94AD1
	 jJqw+kZrGo4nKI7Jp5bInhesjyFPPJvkVsEuvY69lFnQaxvq8xdDJZdEkWTC+WPyin
	 PP23RWkxQJYXrCwznWPZ+wwcLa6n2hLfm4Zrnqd1uOHlGMJkMTSHJgNwe9NZzLdh0t
	 OI8+Q70cRDzfg==
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
	~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v3 0/3] arm64: dts: qcom: msm8916-samsung-fortuna: Add initial device trees
Date: Sat, 27 Jan 2024 20:17:25 -0600
Message-ID: <170640822845.30820.4228813434034188940.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240120095715.13689-1-raymondhackley@protonmail.com>
References: <20240120095715.13689-1-raymondhackley@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 20 Jan 2024 09:57:27 +0000, Raymond Hackley wrote:
> Samsung Galaxy Core Prime and Grand Prime are phones based on MSM8916.
> They are similar to the other Samsung devices based on MSM8916 with only a
> few minor differences.
> 
> This initial commit adds support for:
>  - fortuna3g (SM-G530H)
>  - gprimeltecan (SM-G530W)
>  - grandprimelte (SM-G530FZ)
>  - rossa (SM-G360G)
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: qcom: Document new msm8916-samsung devices
      commit: 80daa2fa2ff2ce01550713956a6f7e18bbbd3f7f
[2/2] arm64: dts: qcom: msm8916-samsung-fortuna: Add initial device trees
      (no commit info)

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

