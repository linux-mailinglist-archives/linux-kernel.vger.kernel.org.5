Return-Path: <linux-kernel+bounces-148672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 286418A85EB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47A38B2284D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497331411FF;
	Wed, 17 Apr 2024 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBhg6BOC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898ED14037F;
	Wed, 17 Apr 2024 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364031; cv=none; b=C6go9xEpwkQ3dh1crD90M2mz6e/WyagBwKe1nOa62Pcbzf02CnHAgUZIckN6dW96Q2LQkpNBixgHegk7xi/9GOXgpmmMgaHMI46IqqVVnH+rvVnpeiShng/hnZn+Cgk+vPPUO9w3ulqgFnY/Y895tAI8DZytQMcelt+b7nPKl+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364031; c=relaxed/simple;
	bh=tfYWaw2Pa+tky697wv72LhqAvV2DQdIG4P8eLYh3vng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6WyF7Vj+mDoNqrVu1xFgkkjWLNKpIlcPZv/6Xnbv61YXIs/J1Z7wlsNmWTZ/dE9u6lshLZN2YX5i8WEOBGyZT2GfxKQH+g4eV0UKSR9V5bgHwisz71/kYjxMtwdg6kuvocsPbtnUtXtRp4uSSxfe8D+Ms1gWCGyseW+8xCJpbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBhg6BOC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E29BC32781;
	Wed, 17 Apr 2024 14:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713364031;
	bh=tfYWaw2Pa+tky697wv72LhqAvV2DQdIG4P8eLYh3vng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SBhg6BOCwvMj2SlAde+4h5wM84YNqRoO7++DuN+4f3bQGJse/i/SrogCqfv3rmq9t
	 fDpcx4eGhgdU7m0VTQ1rxxdO7XC4Gdltub9vonnbMN4qcJKfu7bHKHhnEAgNIbFY8k
	 ISwdCcwY65ifCHtlqHZU2KCPwBl7faXVBzZbLUYHPYUyc8od5X52sr5tqoc7aGA3QT
	 7ETrslJV6iwgrvsIuvtEC8xOdkKkeMSKyzBocUY+r778pNMhuk97mnjYj1voI1iWlo
	 Bg0Kw+qCGzLpR0DZCvFst+Ht+6Lpte/7BsQV/ltYUeO1ra7B0Rta6+Xbo3k5J7RBV/
	 BXHryz1jx4a3g==
Date: Wed, 17 Apr 2024 19:57:06 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Herman van Hazendonk <github.com@herrie.org>
Cc: benwolsieffer@gmail.com, chris.chapuis@gmail.com,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: phy: qcom,usb-hs-phy: Add compatible
Message-ID: <Zh_cOgt3yaHhhH8J@matsya>
References: <20240417065020.3599755-1-github.com@herrie.org>
 <20240417065454.3599824-1-github.com@herrie.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417065454.3599824-1-github.com@herrie.org>

On 17-04-24, 08:54, Herman van Hazendonk wrote:
> Adds qcom,usb-hs-phy-msm8660 compatible
> 
> Used by HP Touchpad (tenderloin) for example.

This lgtm, where is the dts for this, would like to check that before I
pick this

> 
> Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
> index f042d6af1594..e03b516c698c 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
> @@ -15,6 +15,7 @@ if:
>        contains:
>          enum:
>            - qcom,usb-hs-phy-apq8064
> +          - qcom,usb-hs-phy-msm8660
>            - qcom,usb-hs-phy-msm8960
>  then:
>    properties:
> @@ -41,6 +42,7 @@ properties:
>        - enum:
>            - qcom,usb-hs-phy-apq8064
>            - qcom,usb-hs-phy-msm8226
> +          - qcom,usb-hs-phy-msm8660
>            - qcom,usb-hs-phy-msm8916
>            - qcom,usb-hs-phy-msm8960
>            - qcom,usb-hs-phy-msm8974
> 
> -- 
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy

-- 
~Vinod

