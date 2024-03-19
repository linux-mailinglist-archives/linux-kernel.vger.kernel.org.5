Return-Path: <linux-kernel+bounces-106934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD02F87F5A9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60A741F220CC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D417E10D;
	Tue, 19 Mar 2024 02:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASep/F0f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B737D41F;
	Tue, 19 Mar 2024 02:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710816540; cv=none; b=p7bin9mGrSy8vjCQ6+Ey97x787F2mTeYZToDm/gCW/OcNtEdfjn1UE4VD0zX3whhv7Z3qROSoqnmx+Iexu63vMzztpky4mzTVUxfuxezmy8DL3jAYAtAfeNhmaN3NnKsMGdsZU/QeOc95vKCc9RTLZoPICYv8grkde5+Vg8T7/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710816540; c=relaxed/simple;
	bh=EY1fgTPPEDsIeMTmbeo7eC3kLGOhELMwlv6jobQWIxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bnWksBYw9D53zKwW1TKOaTJFkZnUs0kezMtZAb/Fz1WxcBosOFo34YVEVI+UgLsDoeP9P/SmpzhV7AWknoV7fp9aSq5Qh8ziqcXmwne2l77YpWPYecQ4dOoh/hB6rcX2JoOeGwk6oq89Zibn7WlLU4BsooxLd7xs0FdearYACEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASep/F0f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBDDC43394;
	Tue, 19 Mar 2024 02:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710816540;
	bh=EY1fgTPPEDsIeMTmbeo7eC3kLGOhELMwlv6jobQWIxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ASep/F0fhv4+m89ZLVCUcxsBBKQ3VV2KnO7dQ5hnZ87ck68dxUl7jDU2UEZUxKpfg
	 9a2W6irRs10JU7wOOuIIUnE7c6REDBYbLYtQdZD2T4cZR1sG2dzcrpnNY1LXnDI1fm
	 IRmjUBwRAPz60Iw4YtDJwXcDXuHsrQQVCp6IjhbPH6TmkNfHNqgNrDPZ2//oYXx235
	 Bs4lPgH70EE5CVrYI76kh7uISKF08isY3oETYLDHi3rgxcvdBcnWIRCJrJhe8Otsrd
	 d1CRm17JCWfGSqkHw9iizgf6rhS9eu4LGnw/YtATGoftUaxJwzh/3q8fv0nszOTCGM
	 d7SlkHDZ+pcnA==
From: Bjorn Andersson <andersson@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: Add missing LMH interrupts
Date: Mon, 18 Mar 2024 21:48:32 -0500
Message-ID: <171081652632.198276.18157797702954533884.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240217-topic-8280_lmh-v1-1-d72dd4fedfb8@linaro.org>
References: <20240217-topic-8280_lmh-v1-1-d72dd4fedfb8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 17 Feb 2024 14:00:07 +0100, Konrad Dybcio wrote:
> Hook up the interrupts that signal the Limits Management Hardware has
> started some sort of throttling action.
> 
> In testing, you may notice the A78C cluster throttle IRQ fire count stays
> at zero. After an hour of painful experiments on an X13s, I was able to
> get that cluster to heat up near 90 degC, after which the IRQ has indeed
> fired. So it stands to reason that the heat output difference between the
> A78C and X1C clusters is so massive that LMH rarely decides to throttle
> the "little" one based on its power metrics.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sc8280xp: Add missing LMH interrupts
      commit: 9fa6a0bad7077cac60ba98d801e13a74581ec46a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

