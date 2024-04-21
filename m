Return-Path: <linux-kernel+bounces-152530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB568AC00F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 18:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51E6C1C20CAD
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 16:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9ABF1BC37;
	Sun, 21 Apr 2024 16:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z23EH1Ym"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD66D3D0A9;
	Sun, 21 Apr 2024 16:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713715635; cv=none; b=Uqk6pcsjtsmLQZxbJ1gl7U5/mvrcm7P2RW6VxsuKuighRKf7Ot5pPzuwM2EW6RWEWVOh5xQxMu55K3c/YbxSRSxYFU5nlKTFbeod+r6kJbNX9e9bhLz5taVidQ7QxsEvjpd1fVOrM5LFqyLphjdiU8GxvlynkAOoylyCAK2nmNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713715635; c=relaxed/simple;
	bh=Ojlf6w+DNnffwb5FTx/AE7JpxPt85S+wbS1nfNq/BnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rP7jVlN9aOR+5kRXUulvRnN3UgXzb2eS9q0a7qe0YIiaVyWbRAx9bM2SVPplUhGMuxzcIZ+XpLgtoSNmH8T/eMyDjbXfQSchK8hny3e7dWMTwamzun3MuG7yAwj+CFvwAyp3sbr9DFR/KTyvOMJ27Za+7ypxJ5L0rQ43bfOivwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z23EH1Ym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD423C4AF08;
	Sun, 21 Apr 2024 16:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713715634;
	bh=Ojlf6w+DNnffwb5FTx/AE7JpxPt85S+wbS1nfNq/BnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z23EH1YmwPqgtnOtY+o0r2uwS8zZ7GJXGWPw++RuKlk5Ux+51DoZMebAUK1p91Ve/
	 wJTmPhM0sDbrFbuXVHjUHANTOs6HeNcDSjJEMdVLM+8PR7e8XnKAhBRzqIzdcpE8VN
	 s8vdcbqDo6BhdxWUf1qpFLgNdrP+FJqDsr15pSgCTElbzZkVG214rRKTSZOYcNDFuV
	 hxzVF6R1pjqS6GTS2hf6VPb8+eHDtBTGV1jxB7q3wup4Mn5HgB1XfGURbD3STv8nNF
	 Oy3uo1EQF6Q4UPzhwfFqNT+2f9dzkt36I9RAi2fvMprtoT0/BwrAtvo5aGQv1hI5om
	 ST0RIv5D2XMzw==
From: Bjorn Andersson <andersson@kernel.org>
To: linux-arm-msm@vger.kernel.org,
	Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: Stephan Gerhold <stephan@gerhold.net>,
	stable@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v3 1/2] arm64: dts: qcom: sa8155p-adp: fix SDHC2 CD pin configuration
Date: Sun, 21 Apr 2024 11:07:07 -0500
Message-ID: <171371562479.1174524.1759377045286837190.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240412190310.1647893-1-volodymyr_babchuk@epam.com>
References: <20240412190310.1647893-1-volodymyr_babchuk@epam.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 12 Apr 2024 19:03:25 +0000, Volodymyr Babchuk wrote:
> There are two issues with SDHC2 configuration for SA8155P-ADP,
> which prevent use of SDHC2 and causes issues with ethernet:
> 
> - Card Detect pin for SHDC2 on SA8155P-ADP is connected to gpio4 of
>   PMM8155AU_1, not to SoC itself. SoC's gpio4 is used for DWMAC
>   TX. If sdhc driver probes after dwmac driver, it reconfigures
>   gpio4 and this breaks Ethernet MAC.
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: qcom: sa8155p-adp: lower min volt for L13C regulator
      commit: 5927bc586a3f2a81abcf8134fda5f7639abeeefd

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

