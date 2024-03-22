Return-Path: <linux-kernel+bounces-111638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28438886EE0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87D342865A2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5AC4AEE4;
	Fri, 22 Mar 2024 14:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjPVXYXO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6FD47F7F;
	Fri, 22 Mar 2024 14:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711118701; cv=none; b=G5LLB4QlW7KtNWIth73QMYwXHA9lQ6OvvUMxlhISLlOX9iPTLXPlYheCHePYJ2JtrtXa+jIeH8XEESwkwtGYt4HsoQN2rDCh1QlxC9DtEEpZJCFRsoXOpAxRY3qxEueTEVr4IWuc79LtsFLUlgQGITDy82lKK1qUr09KMdeU2pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711118701; c=relaxed/simple;
	bh=oJOb22wO4m+N/5n0eP9Z0CpvUQn2sWpgpr9DVZAQk+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cx+bC34pmDYMH+GkAfGfkubPZkQ5xk1oQOuCDpbMaNiDJ6oJWCk+VzHwUj7M7V7W5urC8durhMpVTkgQC9sPK6M7JW9HWaSYFuzlQBT9z784EnfrZsVJyeOkhv3VP5j4XtP0u60N7PCcip5KBUXDK/95K/HxynRATEcEHX+5swA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjPVXYXO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E37C433F1;
	Fri, 22 Mar 2024 14:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711118700;
	bh=oJOb22wO4m+N/5n0eP9Z0CpvUQn2sWpgpr9DVZAQk+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WjPVXYXOBygNVlQYfGKlpPu601j+i0avVfAeryoYW6+156u+jIoWgruPO6EFERoAj
	 x79IJUs2tykeelwIHNxl3+pIoO0/O2eumqYSvFpQhlisKihvn8pWO+e/12vYMhqO4k
	 zye4r+l1JMOda7Iss6U8lxDSuTyyUP6lh97RD61hzndqIQfZNYy9++yYbSoVIu6jDA
	 yGdlGYx5oOPMEZQ1EpjNdu8H4s7/8L98HLD1kY6fRfw0+k4AANax1HNpGaTi811UTE
	 /ynR2igcSH3qdIU4zhwR/j+DXh5/Y6J0/WrsYYCBn6ueJe2UAaHjLJ7nf2AVQn2B+x
	 QFvu/CgFTINkw==
Date: Fri, 22 Mar 2024 09:44:57 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
	Matthias Kaehlcke <mka@chromium.org>, Douglas Anderson <dianders@chromium.org>, 
	Rocky Liao <quic_rjliao@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Rob Clark <robdclark@chromium.org>
Subject: Re: [PATCH v4 2/4] arm64: dts: qcom: sc7180-trogdor: mark bluetooth
 address as broken
Message-ID: <hcpgho3xrkxas55c5isxi7mwusdjbxkyxlt74r72gfxuunzikx@jxiyumioezb6>
References: <20240320075554.8178-1-johan+linaro@kernel.org>
 <20240320075554.8178-3-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320075554.8178-3-johan+linaro@kernel.org>

On Wed, Mar 20, 2024 at 08:55:52AM +0100, Johan Hovold wrote:
> Several Qualcomm Bluetooth controllers lack persistent storage for the
> device address and instead one can be provided by the boot firmware
> using the 'local-bd-address' devicetree property.
> 
> The Bluetooth bindings clearly states that the address should be
> specified in little-endian order, but due to a long-standing bug in the
> Qualcomm driver which reversed the address some boot firmware has been
> providing the address in big-endian order instead.
> 
> The boot firmware in SC7180 Trogdor Chromebooks is known to be affected
> so mark the 'local-bd-address' property as broken to maintain backwards
> compatibility with older firmware when fixing the underlying driver bug.
> 
> Note that ChromeOS always updates the kernel and devicetree in lockstep
> so that there is no need to handle backwards compatibility with older
> devicetrees.
> 
> Fixes: 7ec3e67307f8 ("arm64: dts: qcom: sc7180-trogdor: add initial trogdor and lazor dt")
> Cc: stable@vger.kernel.org      # 5.10
> Cc: Rob Clark <robdclark@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Acked-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Please merge this through the BT tree, together with the other patches.

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> index 46aaeba28604..ebe37678102f 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> @@ -943,6 +943,8 @@ bluetooth: bluetooth {
>  		vddrf-supply = <&pp1300_l2c>;
>  		vddch0-supply = <&pp3300_l10c>;
>  		max-speed = <3200000>;
> +
> +		qcom,local-bd-address-broken;
>  	};
>  };
>  
> -- 
> 2.43.2
> 

