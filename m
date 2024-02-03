Return-Path: <linux-kernel+bounces-51207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FF68487C5
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 18:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55DE81F23224
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 17:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D0A5F86D;
	Sat,  3 Feb 2024 17:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTWaUKqU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F695F846;
	Sat,  3 Feb 2024 17:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706979985; cv=none; b=t9+zyLx6nbvRk7Nnmg7FTS/pDKhyGTr87o6IIvTB2pGY+1dRBM32/bhQBAhyaTfxhFaYSRrFbk+t7aIbHt1tkirrc6JYsImydMB1jfe5gm7WoWjBQDZc8tLimDXXb8A6YxNri84qdwR4janj+VOjYpeJ89Oc7NM+/AnfPonjYOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706979985; c=relaxed/simple;
	bh=AzeeOc32zJ/Suu+Od6+0GzHYg8o0x3w9QC1mZYd3hp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bd/9JvTTWTsy53LEjo06h39B/ev6ZkYUG1o27jIsbTy+X7jQL7KCkOtbSrdYOzgw0l8SdUA41tm5vkThKwfw+jjRoYNdC/W2V7p9fiT1vtiRTprjTl9JxMMCy3gJzUQcBP6bzoFpS/lJyifBSg/70TcDjTpkJiEk6Xit6QNcxDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTWaUKqU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8A4C433F1;
	Sat,  3 Feb 2024 17:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706979985;
	bh=AzeeOc32zJ/Suu+Od6+0GzHYg8o0x3w9QC1mZYd3hp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YTWaUKqUDdzfLaSuihslOWwTRf25uWK67AcuLqXF5D7n17p6vCZvvJHq7LecnQ6xu
	 WO/bsLUWGB+NYGG0HNNPTaZH301XxmFvsW4NNVwpxTpQvj/QjNMMg7lShtYjlzZZ/p
	 OkWpmmuVWVG2JetjTFMv1FVN4ocnUAtEhaZTqbmIPEY3AMdLHjUzvu4otuDkUjthp3
	 gPTQ+4rzH/hIMYwPLxDOiIT2jNOl7JhOpZQF4FhvSYG1QLjBknBb+yvw8ysvbUxX3g
	 T+qNYzRnBa+By6SakiGyTTvfKC22cMGy/dl6vyA5ynbQUkH6GAqkjF34LOxYX1w0Qq
	 uUQmwzhssBEkQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8550-qrd: enable Touchscreen
Date: Sat,  3 Feb 2024 11:06:16 -0600
Message-ID: <170697997760.332807.17033644849592136009.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131-topic-sm8550-upstream-qrd8550-touch-v1-1-007f61158aa8@linaro.org>
References: <20240131-topic-sm8550-upstream-qrd8550-touch-v1-1-007f61158aa8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 31 Jan 2024 12:58:34 +0100, Neil Armstrong wrote:
> Add Goodix Berlin touchscreen controller node for the SM8550 QRD
> connected to the SPI4 controller.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8550-qrd: enable Touchscreen
      commit: f6afb821e06b6fae7d970b5ed976ba8902167cdf

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

