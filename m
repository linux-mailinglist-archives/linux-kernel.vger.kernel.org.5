Return-Path: <linux-kernel+bounces-73482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9740185C334
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8C951C21DB6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391127995E;
	Tue, 20 Feb 2024 17:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGVobPUq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650FA79946;
	Tue, 20 Feb 2024 17:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708451875; cv=none; b=p3YR6UNBhq2AbWs2OgpFOLXW7zzwCY++arKUnwxXqTe6OkB5mX+rtDeHnTJWuN/vVklo1N2YZVHYMLkqIx8fphSnMXbafs8cBRccoHBLpeb4R+KIY3T40KF9ZKKmRqhrNzqKANWMP2OYVQvL0rOVNVWhwwV1y6Lj8xhVDDTdT9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708451875; c=relaxed/simple;
	bh=uKy3sTr5g9ci0vwBtcTYLrTdctL2mlAjDUwRWGepWO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=meN1b6mGEoWokLnVg3VdhIYk3mhfOoYGyW0Y8bISPGL+Am7mtq++DzULffwXCsTyBmFtOClMIzTOBWlsFcNg3exDkSNbMzUAjZAPLcFfWhsHWvaLpiXk6TjtTsyu92Cl9SPKPaaDUj9J6w9LacqAZaKMVztEudzBxYvvcVUKFds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGVobPUq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5EA4C43142;
	Tue, 20 Feb 2024 17:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708451874;
	bh=uKy3sTr5g9ci0vwBtcTYLrTdctL2mlAjDUwRWGepWO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uGVobPUqpbH/UKS/B93+yIQwYG8jwEyF+fbuguNEJPZMBYoHeJxubmbolOhHIKEAL
	 K126ElOemlEzJjfGeZaE0xIgu3TtJzk9e12yFqJiWyKdvBFKv/3w8ek+t4MiOtcRyL
	 SD1jO8gyStEDlb/Wct5ckqYNIHUE5eP/NEoqq7O4iEGtlUxHueAD67XznYcNRnGB3X
	 mQOjzG9U9dMq5DO6U6y66jp7R8YctzgCIsCGgDEr1BPZKZ7NM+r7ny7Vxf4nZtuP0q
	 LmuAs8GCPvc5HNDJ1P8J9Q68apm6HO4jOfwsgDK/RsrQFAEgjxyeOdEjU4ftDEYAIC
	 hlshxB54dqOxA==
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Hansson <newbyte@postmarketos.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org
Subject: Re: [PATCH v5 0/4] Add samsung-matisselte and common matisse dtsi
Date: Tue, 20 Feb 2024 11:57:43 -0600
Message-ID: <170845186082.159943.18098881377160683439.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231031140337.49291-1-newbyte@postmarketos.org>
References: <20231031140337.49291-1-newbyte@postmarketos.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 31 Oct 2023 15:00:54 +0100, Stefan Hansson wrote:
> This series adds a common samsung-matisse dtsi and reworks
> samsung-matisse-wifi to use it, and introduces samsung-matisselte. I
> choose matisselte over matisse-lte as this is how most other devices
> (klte, s3ve3g) do it and it is the codename that Samsung gave the
> device. See individual commits for more information.
> 

Applied, thanks!

[1/4] ARM: dts: qcom: samsung-matisse-common: Add initial common device tree
      (no commit info)
[2/4] dt-bindings: arm: qcom: Add Samsung Galaxy Tab 4 10.1 LTE
      commit: 2a478a521876d9daea016be3e9513a67871169b5
[3/4] ARM: dts: qcom: Add support for Samsung Galaxy Tab 4 10.1 LTE (SM-T535)
      (no commit info)
[4/4] ARM: dts: qcom: samsung-matisse-common: Add UART
      (no commit info)

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

