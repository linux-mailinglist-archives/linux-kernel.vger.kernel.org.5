Return-Path: <linux-kernel+bounces-160267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E5F8B3B1D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EC4D28132F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD893149C6D;
	Fri, 26 Apr 2024 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQIH5DTT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB3B149C7B;
	Fri, 26 Apr 2024 15:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144685; cv=none; b=GNJAX9HolNpb3x0HJWSoJLmcgyIu/RGEEisEhGDJvKlfRhIXhika1OW0tIp8M497PYGJ/KlGSmIMvKNOLpoWvBCq+af/IAR9ErDoLGH1dsRDd01VJHb+M/f4yUJznLiq8DPG06pBWZSh6ZZ1DId1FnmAfK7279DLVeocprYdm9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144685; c=relaxed/simple;
	bh=LfOA2c2QLAdCatBZXkgxmyPzXVFOaCuDlDuSUa1019g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enBmBi20sJ1H/28tMbmU59+ebzauhplBfT3klnHQWms/5dKjEEtYsGTnrUNvQio3HyBtYBp1COhk4fg2z/PJkwz0bWLaPj28LKzeNqmLFmBbTyTSBwfp2sUYRk7YVaREhI6ZEl3sfY1T8zIKniDuAGiDP/vVrfb3Y0WCqgYTJoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQIH5DTT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770DEC113CD;
	Fri, 26 Apr 2024 15:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714144684;
	bh=LfOA2c2QLAdCatBZXkgxmyPzXVFOaCuDlDuSUa1019g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DQIH5DTTDjblAlcBgPQbv+kxpSbtPy7l0ar0qHdD6WF1wvbAdtMGcGkXpZfvLf0in
	 5XXu8e4wnfs/0C/huZNNLgcFjrmL5wz5m5I6IYvKAX2FzCXiDAJHclJjr3g2xGcxMl
	 ewtKpYWTiFCeP4HYS6bEOWzIq5Zi8MeyfY59VTEpp0m6GuRlehqCWPZzJIUPMBp5MR
	 +DtHp2BpNDH37b6UojvweFf751zOWeao5hhj38kAnwMzCg0a7R2uLzKGUT2hJftUnn
	 nPdX1Yh61buPnzdBNR9m4yXDWkp2VEh2Ke5hSYLgEsS9KJUMa0c2iTXySLsJLsR3tl
	 jDmqMazxpV2vw==
Date: Fri, 26 Apr 2024 10:18:01 -0500
From: Rob Herring <robh@kernel.org>
To: Anjelique Melendez <quic_amelende@quicinc.com>
Cc: conor+dt@kernel.org, linux-gpio@vger.kernel.org,
	konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	andersson@kernel.org, linus.walleij@linaro.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom,pmic-gpio: Fix "comptaible"
 typo for PMIH0108
Message-ID: <171414466009.1868325.4338247786369623294.robh@kernel.org>
References: <20240425185603.3295450-1-quic_amelende@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425185603.3295450-1-quic_amelende@quicinc.com>


On Thu, 25 Apr 2024 11:56:03 -0700, Anjelique Melendez wrote:
> Fix "comptaible" typo in if schema for qcom,pmih0108-gpio.
> 
> Fixes: 6acc46f8c065 ("dt-bindings: pinctrl: qcom,pmic-gpio: Add PMIH0108 and PMD8028 support")
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> ---
>  Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

