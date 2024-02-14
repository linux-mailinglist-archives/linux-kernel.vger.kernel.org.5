Return-Path: <linux-kernel+bounces-65744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B8B855195
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D4CCB28E32
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8A712B162;
	Wed, 14 Feb 2024 17:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjRQKQPg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A152112AAD1;
	Wed, 14 Feb 2024 17:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933471; cv=none; b=IA4NPcn6cWhLMG630Uu39uehWWw2KMwqG+G0nBOwCvUo/E8SkW2Y9JwMAoWdH37m8/m80Np3ycoBEgTh7zTLb49+cYzPvx7q4JHgapwBiRZINN2sAwQj0ihH/Mnm9hNypf7OVnwE7i4liMckVLBXokvRdvtq69+PSd6AvwYpX2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933471; c=relaxed/simple;
	bh=YFU+Ds8M53iZQg2SyYpOVSCKzY2zxmL4C/jaoOq3w3c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0yWQc1t3e8Myt0vJAWmQWqXMOkdRGvewpZHKEdu5SJGXHeOgE0fKDvrlcRKJYNJks6vVA2kqxMuEKs6CtaP9ujncMl+G8JmQE/3cuLFV849cB2S4NCcngRhXwWAWW1zCgPzTCfZKt/XN1UZfNGbuBszmkz+S4+S3kmD0F1D6AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjRQKQPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF68C433C7;
	Wed, 14 Feb 2024 17:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707933471;
	bh=YFU+Ds8M53iZQg2SyYpOVSCKzY2zxmL4C/jaoOq3w3c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AjRQKQPg2Br//eL6KJ/uKXmefnh82H0TtN5wmrYlR8A2wkG25TR8BC1J1THmd3m3V
	 fxKxVujOpDH5+KEibnTUocBIYDLyGW7Mg+XuSvYVb2pYEciOJsIUpWSPXKigYyWxZs
	 QNgQAkwzHqOrP0ibfovjEGEcuCE0aXRodM0avdr9xo+64VwrFi4jqJnhSFOZyYALmT
	 SQTxNfRY5Ggvps6mGu4b9S0i815s8hJUD56ki4TiW+Sb3hN7XZPvjLhfXj5lAfoQfl
	 LSFZzti51YBBLyZAAh2NxhY4b+cJqk9KNxlKb08iLcJRZhP8zF4Hkysf7FjaHKldwr
	 H6MUL14IHxMcA==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH 1/5] arm64: dts: sc8280xp: correct DMIC2 and DMIC3 pin config node names
Date: Wed, 14 Feb 2024 11:57:25 -0600
Message-ID: <170793345833.27225.8898510891460575893.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212172335.124845-1-krzysztof.kozlowski@linaro.org>
References: <20240212172335.124845-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 12 Feb 2024 18:23:31 +0100, Krzysztof Kozlowski wrote:
> Correct the TLMM pin configuration and muxing node names used for DMIC2
> and DMIC3 (dmic01 -> dmic23).  This has no functional impact, but
> improves code readability and avoids any confusion when reading the DTS.
> 
> 

Applied, thanks!

[1/5] arm64: dts: sc8280xp: correct DMIC2 and DMIC3 pin config node names
      commit: 61474b18e762671a69b2df9665f3cec5c87a38af
[2/5] arm64: dts: sm8450: correct DMIC2 and DMIC3 pin config node names
      commit: 0d3eb7ff1f3a994a5b3e49a9bd48f0c2f3c80ef5
[3/5] arm64: dts: sm8550: correct DMIC2 and DMIC3 pin config node names
      commit: c6e5bf9278749eaa094dc944add747f10a15dceb
[4/5] arm64: dts: sm8650: correct DMIC2 and DMIC3 pin config node names
      commit: 94c312767160f0d527da035b9080ff5675d17f4c
[5/5] arm64: dts: x1e80100: correct DMIC2 and DMIC3 pin config node names
      commit: 8794916799d61f3593b87e946ed58338baebd097

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

