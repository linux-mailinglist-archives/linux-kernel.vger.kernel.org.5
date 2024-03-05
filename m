Return-Path: <linux-kernel+bounces-92556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E5987221C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 280B81F21C9D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279261272AF;
	Tue,  5 Mar 2024 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vf3JfgX+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D830126F07;
	Tue,  5 Mar 2024 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709650561; cv=none; b=bShhxNPh4A6ggZJQuxusFQk3vhQUq1dgkRP/GeU5EE1RA9uCD/5ebT0+NEB4PuddLv2BIJv1NISyuOpYvDhD1p3hU2DLccT+aAr1HZFgNflSFkmehOjycAe472ZUAqFaMf1Tgbz3aluVwB8AdmJcQkz3lJH9G+p7SF/ToSejffo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709650561; c=relaxed/simple;
	bh=HziwUH5sW0NWbkfvO4gvMNkhVHphWUEl9FgSM+AIM/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFuTzuW+WUtfwTJQUXzZLLVXz5Jf3fVjz4BnV6iYG7r/y4qk10mnLpEVwoNwtnaQBEQyfp9KRehHvb0wbPxRZJqRZnOgQRkE7PBnWGaZqN/1b2G7ec/wwiU0vbIZ5TKWtKMaUJaJtZAl1M8xwhPWvRWbi7+NMmkJUiZ+YJA4T0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vf3JfgX+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C5FC433C7;
	Tue,  5 Mar 2024 14:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709650561;
	bh=HziwUH5sW0NWbkfvO4gvMNkhVHphWUEl9FgSM+AIM/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vf3JfgX+5vuDM/TQz5RfdFAJ8XIQE/47D7O5EC4bSsewRcUA1qrpRQELmpFNQHDID
	 8IUU4mvdqCdAZnKc8H7x+L6HzvR11P+E8J4GM6+euTCUD5bB1ccvzfRwT4rCUeLLu2
	 YqWntEK0/7RuPzULk4zIknYyGy58JO7nsErrYTSG/3If6PWos9q/57wRjw2EjNXig9
	 M1Smsl3TeZSho0Ldxkra9hIS8N46r+FWgf9dvZ9i1/yiquz7cujdOu5bIYDAMuWTMO
	 vxEkvvHnEOmSK3biusXbFykVfPPT7J6+OlzUdJBgBhFKsxLZRSZjQ14qW/udm+SMu9
	 RvK3S2Nq3UPLg==
Date: Tue, 5 Mar 2024 08:55:58 -0600
From: Rob Herring <robh@kernel.org>
To: Yang Xiwen <forbidden405@outlook.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jiancheng Xue <xuejiancheng@hisilicon.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kishon Vijay Abraham I <kishon@ti.com>,
	David Yang <mmyangfl@gmail.com>
Subject: Re: [PATCH v4 2/5] dt-bindings: phy: hisi-inno-usb2: convert to YAML
Message-ID: <20240305145558.GA3339636-robh@kernel.org>
References: <20240305-inno-phy-v4-0-a03204c9cf1c@outlook.com>
 <20240305-inno-phy-v4-2-a03204c9cf1c@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305-inno-phy-v4-2-a03204c9cf1c@outlook.com>

On Tue, Mar 05, 2024 at 10:19:47AM +0800, Yang Xiwen wrote:
> convert the legacy text binding to YAML. While at it, remove
> "hisilicon,inno-usb2-phy" fallback compatible.
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  .../bindings/phy/hisilicon,inno-usb2-phy.yaml      | 91 ++++++++++++++++++++++
>  .../devicetree/bindings/phy/phy-hisi-inno-usb2.txt | 71 -----------------
>  2 files changed, 91 insertions(+), 71 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
> new file mode 100644
> index 000000000000..ba82405ddf51
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
> @@ -0,0 +1,91 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/hisilicon,inno-usb2-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HiSilicon HiSTB SoCs INNO USB2 PHY device
> +
> +maintainers:
> +  - Yang Xiwen <forbidden405@outlook.com>
> +
> +properties:
> +  compatible:
> +    items:

If there's another version, you can drop 'items' (and its '-' below).

> +      - enum:
> +          - hisilicon,hi3798cv200-usb2-phy

