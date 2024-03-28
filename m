Return-Path: <linux-kernel+bounces-122738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A0888FC46
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C14E528BC6C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84FC657D4;
	Thu, 28 Mar 2024 09:58:51 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FA455769;
	Thu, 28 Mar 2024 09:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711619931; cv=none; b=KGpgJngumfby/KwJw8gcwfGhCvmJeptadQqqmfzisQvxAYLgi1kbK7SNz1l0JByth15I4dCNTRFzrzQpK4hrldknd6JfFNFq12wMYuN/MLURAW26JatmaNVoYYSj+wRbW2GqYQDp8F6ZT9OfVh7x1AgT5oKa8dyCifpB7bc7PBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711619931; c=relaxed/simple;
	bh=LR01KxWnPZWOqIcA1p8pdeTLxQFRQRqlaLiwBVcMWjY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GpFZ+gOZiL3HulnNbXkJavSkFLTG3vM8NoiZgYsTzx97qlH2YLSW3RHoD7w2vpqx8q5Hjx5F9Ft2nmLGSsdTXgSRYi7do/RNJwjbtvA6gEFEIWCzWfZT3PZIgZcbDPvbeIBoOoZ9QnYRJvQyLvARpAB7ZTuwsReSyyxN29Rprak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D925C433F1;
	Thu, 28 Mar 2024 09:58:46 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: peter.griffin@linaro.org, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: alim.akhtar@samsung.com, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, andre.draszik@linaro.org, 
 willmcvicker@google.com, kernel-team@android.com
In-Reply-To: <20240326151301.348932-1-tudor.ambarus@linaro.org>
References: <20240326151301.348932-1-tudor.ambarus@linaro.org>
Subject: Re: [PATCH v3 0/5] arm64: dts: exynos: gs101: define all PERIC USI
 nodes
Message-Id: <171161992678.13192.16312850568393488957.b4-ty@linaro.org>
Date: Thu, 28 Mar 2024 10:58:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 26 Mar 2024 15:12:56 +0000, Tudor Ambarus wrote:
> The series starts with some trivial cosmetics patches, then defines all
> the PERIC USI nodes.
> 
> v3:
> - seems that Andre' already reordered the pinctrl properties, take his
>   patch (first in the series) and rebase my series on top.
> - small updates on commit messages
> - collect R-b tags
> 
> [...]

Applied, thanks!

[1/5] arm64: dts: exynos: gs101: reorder pinctrl-* properties
      https://git.kernel.org/krzk/linux/c/7d7df014617ba8df7fbdacac54cafe0d13573dcb
[2/5] arm64: dts: exynos: gs101: move serial_0 pinctrl-0/names to dtsi
      https://git.kernel.org/krzk/linux/c/73618dfa705dc8f993a6829c895eaf5af8402ceb
[3/5] arm64: dts: exynos: gs101: move pinctrl-* properties after clocks
      https://git.kernel.org/krzk/linux/c/d978c70e8d4775c62db21f85947d12b4f874104a
[4/5] arm64: dts: exynos: gs101: join lines close to 80 chars
      https://git.kernel.org/krzk/linux/c/028a87e91fcd8c485afcf8bd0d26ae34a0872438
[5/5] arm64: dts: exynos: gs101: define all PERIC USI nodes
      https://git.kernel.org/krzk/linux/c/a45c3a9b1ef9571741d40bf10f22ce3c60bc5111

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


