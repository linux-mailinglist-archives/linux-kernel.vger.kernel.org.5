Return-Path: <linux-kernel+bounces-104393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 903FF87CD32
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A753282733
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F26B1CA9E;
	Fri, 15 Mar 2024 12:22:48 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6E41C692;
	Fri, 15 Mar 2024 12:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710505367; cv=none; b=dSdzeGDw6K9rc6lBQA1spARoutjNfU546KTwcv0IYIpLFELBUp4F7+fypH4E14shedFfEhhLW+x4teTc4qFEhP6abzMqUH1kdCoPoyoiYARCdjgnpOw9v8awbGpB0afDM10xzgodH3uFMK9u3XP16IFazDABhm6DGWWkS9YLCWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710505367; c=relaxed/simple;
	bh=DN0kuGMMIWqvC+2KXvdlZoq9OKvpT+42t63G3rdXcUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RYvEBQm2zQ5lfh3veBfXhCYCbm6LU/VP+LGww5Uk7IhmthNKpFCt5qORqP6YUS/v0Rx9e8yBn4XqzI67JFGR3iiWYiL4cWOqcMvzpqhgNnctghy2DPvdpkPkiUe73Xl9YfkPDd4zZzF5/fjCtx4nEoe5h4PWcxvxPJ8+ARnPCTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875a9e.versanet.de ([83.135.90.158] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rl6Zn-0000H4-Sa; Fri, 15 Mar 2024 13:22:19 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
 mchehab@kernel.org, Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: sfr@canb.auug.org.au, liujianfeng1994@gmail.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, sigmaris@gmail.com, knaerzche@gmail.com
Subject:
 Re: [PATCH v3 2/2] dt-bindings: media: rockchip-vpu: Add rk3588 vpu
 compatible string
Date: Fri, 15 Mar 2024 13:22:18 +0100
Message-ID: <9414316.4vTCxPXJkl@diego>
In-Reply-To: <20231231151112.3994194-3-liujianfeng1994@gmail.com>
References:
 <20231231151112.3994194-1-liujianfeng1994@gmail.com>
 <20231231151112.3994194-3-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Sonntag, 31. Dezember 2023, 16:11:12 CET schrieb Jianfeng Liu:
> Add Hantro G1 VPU compatible string for RK3588.
> RK3588 has the same Hantro G1 ip as RK3568, which are both
> known as VDPU121 in TRM of RK3568 and RK3588.
> 
> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
> ---
>  Documentation/devicetree/bindings/media/rockchip-vpu.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
> index c57e1f488..16886bccf 100644
> --- a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
> +++ b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
> @@ -31,6 +31,9 @@ properties:
>        - items:
>            - const: rockchip,rk3228-vpu
>            - const: rockchip,rk3399-vpu
> +      - items:
> +          - const: rockchip,rk3588-vpu
> +          - const: rockchip,rk3568-vpu

at least the rk3588 has multiple v{d/e{.}pu blocks, so this compatible
is very misleading. As you mention in the commit description already,
this describes the vdpu121, so can we please use that in the compatible
as well to distinguish this one from the others that hopefully will come
later?

Thanks
Heiko



