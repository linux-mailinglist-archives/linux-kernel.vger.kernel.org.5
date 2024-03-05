Return-Path: <linux-kernel+bounces-92571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEAA87225E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BD08B227E2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E23E126F08;
	Tue,  5 Mar 2024 15:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzskPTw7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56867126F02;
	Tue,  5 Mar 2024 15:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709651027; cv=none; b=ap6R4HEtRC7+7kAOmjTUQDKf4fSsLqlsHYMQX0c0GYHGKV6BCZ4Wwo+dNaKt+Qr6Ya/8C/G1OasriD4pY+BJOT6apnWZhzknsHzrEHchu6K1Eh1LsL6lQovFOdLO23WhSG/M7URp2vyV+Z22+LLCdw4nAlVt069imA3Gb9LWmJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709651027; c=relaxed/simple;
	bh=7K1Q62MNa2I2tcivs5UpDzs/Q6BDZTp7gt5DMjXX6LA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uT213AL3l48rSnYtc0rwlnRcrsNrQdk00OPwJbECHnPuR8luM7HdGRV5yHonb7C4nPL4JZmGpctOcP+lz97tmncJ7BaOzfwREbJvTnJvivZlGy0iOYnnwPbnt5z6KeAmNl8vWEiYxgeeVMt972bhQ7HReB8JT2hutXlkN/Bj7xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzskPTw7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 908F3C43394;
	Tue,  5 Mar 2024 15:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709651026;
	bh=7K1Q62MNa2I2tcivs5UpDzs/Q6BDZTp7gt5DMjXX6LA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SzskPTw7LNMKes+5ala2+bPQLigTb/r1OPUxYscE2ahpKI1c0LygtEMrM7f83VcGY
	 pf30SFCjSRsIyfu5Ip4N5zKEKDUKu6FFZWaLaVi3v26LhpQryO5IqXJA0cHCBwmiw9
	 G/1DThwGzxpDW8kJqZ0VghYylzbyQCGbeA4aDHsaxEuVl/d62JCPerGXX8Wm5t/642
	 /8YOv2u2zrvtOE6rQ7zbxc6qPY7GmlsZMIKdoRU6TApAr6AcV9lCQDJnKVoIGegC6p
	 9QbTXmlND1+RWCLSpvvi7KyalLRUPEQDMZw6nKk3oGEsqXSJW884EPxsSA0OiC6duD
	 sC8p/nDgcVj/A==
Date: Tue, 5 Mar 2024 09:03:44 -0600
From: Rob Herring <robh@kernel.org>
To: Shreeya Patel <shreeya.patel@collabora.com>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	nelson.costa@synopsys.com, hverkuil-cisco@xs4all.nl,
	hverkuil@xs4all.nl, mturquette@baylibre.com,
	krzysztof.kozlowski+dt@linaro.org, sboyd@kernel.org,
	sebastian.reichel@collabora.com, conor+dt@kernel.org,
	heiko@sntech.de, dmitry.osipenko@collabora.com,
	kernel@collabora.com, linux-kernel@vger.kernel.org,
	mchehab@kernel.org, p.zabel@pengutronix.de,
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-media@vger.kernel.org, linux-arm@lists.infradead.org,
	jose.abreu@synopsys.com, shawn.wen@rock-chips.com,
	nicolas.dufresne@collabora.com
Subject: Re: [PATCH v2 3/6] dt-bindings: media: Document HDMI RX Controller
Message-ID: <170965102379.3357317.10195104621246588504.robh@kernel.org>
References: <20240305123648.8847-1-shreeya.patel@collabora.com>
 <20240305123648.8847-4-shreeya.patel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305123648.8847-4-shreeya.patel@collabora.com>


On Tue, 05 Mar 2024 18:06:45 +0530, Shreeya Patel wrote:
> Document bindings for the Synopsys DesignWare HDMI RX Controller.
> 
> Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> ---
> Changes in v2 :-
>   - Add a description for the hardware
>   - Rename resets, vo1 grf and HPD properties
>   - Add a proper description for grf and vo1-grf phandles
>   - Rename the HDMI Input node name to hdmi-receiver
>   - Improve the subject line
>   - Include gpio header file in example to fix dt_binding_check failure
> 
>  .../bindings/media/snps,dw-hdmi-rx.yaml       | 132 ++++++++++++++++++
>  1 file changed, 132 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/snps,dw-hdmi-rx.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>


