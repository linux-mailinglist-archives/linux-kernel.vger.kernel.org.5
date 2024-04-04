Return-Path: <linux-kernel+bounces-132145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A71789903D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E82928138E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B4613CFB8;
	Thu,  4 Apr 2024 21:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPyfRvdP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284E513CF89;
	Thu,  4 Apr 2024 21:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712265815; cv=none; b=H7GA5it6Zu8XW7yUlDdBa/ODAIpNNMhQDls59n+AtrDyhcutJv2f/Nvs2LCiSOEwphXJtY7B5v03NObXOg4+5eS2BBkpLOV3ojpyii5oZGL16vKnYCN+DAED+2n4OvHVBbl0Nh8ohiiQqsSDgBjAA4RSODUoGvSkvOjmnSBL4Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712265815; c=relaxed/simple;
	bh=T1v9rRNf+wSRQI9F8X7P3y+HMEB37C+4yTnppFx1rFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KGXuYJieGlqn/Ub7n45ma4sKHFoU7Uer8w8qdeD8ROww/7/83AahiMLmGeuAd79yDZ6HllJHKW6UgoTydDnb3QBRqoL1SYIQ5yWkDRCP16rDwIT5LL0MVcsdDyxG6kRzp/5hYrVu0c0Y04PZm7tR4vWRp9NNmHGMYFbjxpdV6RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPyfRvdP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8FBC43394;
	Thu,  4 Apr 2024 21:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712265815;
	bh=T1v9rRNf+wSRQI9F8X7P3y+HMEB37C+4yTnppFx1rFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YPyfRvdPxU1xMgcrS/0FAyxSbXppAwuP09+yjePa1reahzycrJFwzdHJLpW6Ood+F
	 Z8D0ljKbO2rRnzrYIkz3N6Kz1soTSuDk/3XW8abelwQFTDhl1N94YfsHgADsnmz26R
	 tYUnpCQYis84eFU6ComEvfMn8/D3TL0hntDwCFNOkZ+pi8yyru1YjSd19CuQPLYbWh
	 pQRd+hs2K/yieu8sGoLYqnbteJZPjZDWsdhINbxlyDyZuWiqY5D3TV461Ig3UpzPUv
	 TyYk8nYmblscZGrRcm/qZNFWlttUwy/sLjUQXx8dTyeTKvuV8AFKeDVzNWZXp5R6CZ
	 eQfh4YmBaEPoQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Luca Weiss <luca.weiss@fairphone.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/2] Add Inline Crypto Engine for SC7280 UFS
Date: Thu,  4 Apr 2024 16:23:01 -0500
Message-ID: <171226578679.615813.10247143708079822717.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313-sc7280-ice-v1-0-3fa089fb7a27@fairphone.com>
References: <20240313-sc7280-ice-v1-0-3fa089fb7a27@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 13 Mar 2024 13:53:13 +0100, Luca Weiss wrote:
> Add the required bits to support Inline Crypto Engine on SC7280 SoC with
> UFS.
> 
> 

Applied, thanks!

[2/2] arm64: dts: qcom: sc7280: Add inline crypto engine
      commit: dfd5ee7b34bb7611d4d2f4f3cb37152baeaae96d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

