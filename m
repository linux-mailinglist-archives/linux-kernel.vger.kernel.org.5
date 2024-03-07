Return-Path: <linux-kernel+bounces-96310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5135875A07
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DCF7283C6F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C514713E7C9;
	Thu,  7 Mar 2024 22:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJPgzA6b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEE213BAEF;
	Thu,  7 Mar 2024 22:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709849519; cv=none; b=TYJXmu5YgbpgapZeu8ZRWjbi/d0y09KotYkJgSiH9KctacIppOjp8PBY5I1d1KH2GsnvIZfx75BFfJvKWMO5WKFdDDLoB0ef2uBnIaPspMSVQcdL4I2TcEw+jO35/sJmMWId+YzeYMtacEotpJHBJEbC/e0App38/xhEpLEFxzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709849519; c=relaxed/simple;
	bh=+zneG3FdnzfKBUdqPSkS788CmRqblVmKTJwqyQBZWXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbVyzaa0DqNSiiXkGBwE0RIkoKiaCq0jYYBrGjAkO49og2fmhWYeB4n13QAG+qSL6Zt3ZOQVJ5MZhQnYISlwLw2peSKZkX7CRWOcyd2FSPteQkDnGY3aMEObxrr0KIoTRY9bE06tMriVb2B5VV8y9bVnSiMd2lEx1jtnzH/Kx4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJPgzA6b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083FAC433F1;
	Thu,  7 Mar 2024 22:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709849518;
	bh=+zneG3FdnzfKBUdqPSkS788CmRqblVmKTJwqyQBZWXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bJPgzA6bfy0LRKBXEx1fGBxpNda0m3pbKJa2Gc/5s1kBIW61PX4+g12a5xuLR+01m
	 HFRHp+4gmjCJVSVjc4GP6QAvAjQ+mmVXiFNnRAN+ik/qbgqfjp48a8J9UnYkJIpezC
	 t+aPnQhiE39w2LDTBr1k/ctMq6pSqZF3OcTy5/2MzoON94LwF7YA7CfsgH4vchGNx2
	 j7XbS2W1NIvOd9i8vlWVoAfUETyZX9Qt4oDcMzwdyuKlVLbHKLGLpBLRIiUO/FgxFd
	 oYCGLoC+IEyMcuaZ2nIiIsKxX6UrEIr5nKhja4Dqcg7Kd8RcylHWYdWAfTDBueoj9D
	 Qxc1IkT67hKKg==
Date: Thu, 7 Mar 2024 16:11:53 -0600
From: Rob Herring <robh@kernel.org>
To: Yang Xiwen <forbidden405@outlook.com>
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v9 6/9] dt-bindings: net: hisi-femac: add
 binding for Hi3798MV200 FEMAC core
Message-ID: <20240307221153.GA3185290-robh@kernel.org>
References: <20240307-net-v9-0-6e0cf3e6584d@outlook.com>
 <20240307-net-v9-6-6e0cf3e6584d@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307-net-v9-6-6e0cf3e6584d@outlook.com>

On Thu, Mar 07, 2024 at 07:34:52PM +0800, Yang Xiwen wrote:
> HiSilicon FEMAC core is also found on Hi3798MV200 SoC. Document it in
> binding.
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> 
> # Conflicts:
> #	Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml

Need to drop this.

> ---
>  Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
> index 5cd2331668bc..4f8a07864eb4 100644
> --- a/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
> +++ b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
> @@ -16,6 +16,7 @@ properties:
>    compatible:
>      enum:
>        - hisilicon,hi3516cv300-femac
> +      - hisilicon,hi3798mv200-femac
>  
>    reg:
>      items:
> 
> -- 
> 2.43.0
> 

