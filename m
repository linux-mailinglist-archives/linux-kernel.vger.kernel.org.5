Return-Path: <linux-kernel+bounces-90928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACADC8706EA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EB30281710
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4794C635;
	Mon,  4 Mar 2024 16:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1CLLwLd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E9F8828;
	Mon,  4 Mar 2024 16:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709569332; cv=none; b=hZ6WgZcMaUAczrvlKaddDjKK5evABBYispQ28hvUZ0RXrxaHZCpwt4y7M7cJb9liPrV7Pf2avLc8u8qd+N3sHjq+fKNvqzHhqYy9LgxZPLQojD0vjooHa0wFUcqounnYxaXO3HZxUCxqUe65XKxLu1Xx1nm3kJLWXymrPZFpzgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709569332; c=relaxed/simple;
	bh=5GtQDIrUrxIsf2wt+vj62jwD5dGLz3Z9gt06aDoswXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAueULoszyoEEAEoZ3MAFRW44UhtZuc9okiH5c/dEuk6UywyLwhBDLqu6w8ifOVNjZeDBNEHzHQHMjBzr6mCJNBFIR3O8k0kD7fRg4Cv1CyB77umjwCll8RpK9wK1D1L0P9wI9jpoSqHhYlq9wOfzbKYOiXjrlYr5kuB/ML4qsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1CLLwLd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C82C433F1;
	Mon,  4 Mar 2024 16:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709569331;
	bh=5GtQDIrUrxIsf2wt+vj62jwD5dGLz3Z9gt06aDoswXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q1CLLwLdF2wB+bofcls+9RVbRYQjh9p+gNuxXBUkikSV1cijv4XYaOgX/pyWSsJi7
	 6wD0NnwdF6u2k4Aq56xmiTb78EkBgcjC4lU4mGta7dAb7a/5T45hbhWOLk6iu21GHo
	 SFRgWRfdt2bhE9ZaBZ26yBpnbgnAsW2za8c/LWAbPQXV5gOXFNS7pJwdqL1k6q8Nps
	 5nK6vh6QRsR2JPhLzGbEFFLg58SM61SS59wFhyUSauUED6lsGsgvkzeaBBWPbwedrk
	 YaNHrpei4TyQfNyeBkOsiaEgMAv5dPRgzmGHfkn6T+EbXigmWzhqRsP7t6cLWKwBmv
	 fWoqdW2MqZ5Rg==
Date: Mon, 4 Mar 2024 10:22:09 -0600
From: Rob Herring <robh@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFT 1/7] dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp: Add
 mode-switch
Message-ID: <20240304162209.GA343498-robh@kernel.org>
References: <20240229-topic-sm8x50-upstream-phy-combo-typec-mux-v1-0-07e24a231840@linaro.org>
 <20240229-topic-sm8x50-upstream-phy-combo-typec-mux-v1-1-07e24a231840@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229-topic-sm8x50-upstream-phy-combo-typec-mux-v1-1-07e24a231840@linaro.org>

On Thu, Feb 29, 2024 at 02:07:01PM +0100, Neil Armstrong wrote:
> The QMP USB3/DP Combo PHY can work in 3 modes:
> - DisplayPort Only
> - USB3 Only
> - USB3 + DisplayPort Combo mode
> 
> In order to switch between those modes, the PHY needs to receive
> Type-C events, allow marking to the phy with the mode-switch
> property in order to allow the PHY to Type-C events.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml       | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> index 2d0d7e9e6431..49c6539b9df0 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> @@ -71,6 +71,11 @@ properties:
>      description:
>        See include/dt-bindings/phy/phy-qcom-qmp.h
>  
> +  mode-switch:
> +    description:
> +      Flag the PHY as possible handler of USB Type-C altmode switching
> +    type: boolean
> +

Perhaps you should be including the usb-switch.yaml schema that's in 
next.

>    orientation-switch:
>      description:
>        Flag the PHY as possible handler of USB Type-C orientation switching
> 
> -- 
> 2.34.1
> 

