Return-Path: <linux-kernel+bounces-82667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB06D8687FF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95B2628B92C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2200B4DA11;
	Tue, 27 Feb 2024 03:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwqLrluQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5109E4DA1D;
	Tue, 27 Feb 2024 03:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709005632; cv=none; b=RqYJOVSehkjmtoynKLBbdPjY1xPM89XnZ9Vd2JNpKnT5QhMcUbZxzktG6ac13IOkVKTdEKCWRoLU1Sa8598bCwkZFiIfsdq+Qq4zRLB8ht4z6Jz65jCULoHHshH0AQBiQKG+om8rKWW5zdRQ2GLBg0PKiN4c2xZJZfvxZa+NmNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709005632; c=relaxed/simple;
	bh=zrXBt5lL6EwMGN8mDIZQ61Wa4PA8RtPZfGIjy/myyL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgz+apBz13kWKsotujQYrb50V1dI5nX7k3XQZ7Uw7M22MRocEymHcRW9C2EUanLZI5JUlhLNTP2rCCaIRgjT1yNItLo2zhl0qPZA8wS56o+m3/A5H1XmFBvxL2FUgZfqgWobNQ9YoCAmitd3nVsQBBvv0Nb/0nCWHcTy3n2wa2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwqLrluQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B14AC433F1;
	Tue, 27 Feb 2024 03:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709005631;
	bh=zrXBt5lL6EwMGN8mDIZQ61Wa4PA8RtPZfGIjy/myyL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rwqLrluQ/QliNMO/MJ9xorO94p0GqCPrxeLJ6oBwkuunCl3JlMgVVphXu8X+fMoYG
	 2Ipx3cmaOoNpGGZ7WIbPxhs4MsYDs2/9LIkLv+HYfPOkOlm/E4UFHqAnWF5AaZ5tCP
	 RbZ6Cjh/tvYjanh4EMya8TELCNK9ULwWGsIiJTRb0MBpCENzS+VTB0nKLvASQorOoS
	 2R3bh03Laa29dQDMRpEf1KoTwctqEcC/Ou/wyDLOkWumGS00ChOAwqiELL1MxwrN3L
	 Tukf8xEYguP07/8Bft2h+yjcY1/URAmJItoSFfh7k9Rz3VDwzpT86MiePVZbVR+3m8
	 AcOfe0g1zHHrA==
Date: Mon, 26 Feb 2024 21:47:09 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
	Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: leds: qcom-lpg: Drop redundant
 qcom,pm8550-pwm in if:then:
Message-ID: <170900562863.2661587.9832631833175571218.robh@kernel.org>
References: <20240226073713.19045-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226073713.19045-1-krzysztof.kozlowski@linaro.org>


On Mon, 26 Feb 2024 08:37:12 +0100, Krzysztof Kozlowski wrote:
> "qcom,pm8550-pwm" is compatible with "qcom,pm8350c-pwm" (latter used as
> fallback), thus it is enough for the "if:then:" clause to check for the
> presence of the fallback "qcom,pm8350c-pwm".
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


