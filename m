Return-Path: <linux-kernel+bounces-131448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 805058987FA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35491282C64
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299B584FD4;
	Thu,  4 Apr 2024 12:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="PDLeRexL"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326216CDA3
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712234244; cv=none; b=tH1ZtD+5CcNwt0YbTtoTta70Iv5kquUed6I0wb6ctxR0JV0aL0O+Bu09nzenYQ6dWxcbI3xO4M3hsc4Ua0L1kI810QNo1cMbyBURbgDLnIFXNsDEuleIy6LKqpPwXTtf8HV1RtZf/zFitQydFj2e11MRPAw1r5CTHOOYsmeunVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712234244; c=relaxed/simple;
	bh=CUxcuKgANrcZ2HOGF9dd7fxzE3pNCDVQpcR5PSLo51o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=iuD7HgYlYITeJedIyidqGfPaeVs9NQxSdqCFJaiBqcKTrXi/uffsiYBbIwj2w6+f6OWVA7b45QhJpqq8coPIKL6M1d53Lalca1fbZWv0BaBQrnIX08Gjus/6EJ4DfXg0/d5BoSOK1LBL+Tivm39ULvlUSRHV3qcLpL/4OmHtnkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=PDLeRexL; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a4715991c32so143374266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 05:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1712234240; x=1712839040; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAzVcsvooEghxXt7B4g+snAG6X7O0gFVG7to2PBHpSc=;
        b=PDLeRexLemVtCLHtl0o8+0OsTv5W0UZPTiVqnEsQN8MZQfNyf30X+vBWYomDQj292C
         rrGZcoAFIP38QXTKr7Vdqw4j6IFkapUVX5fY/8vNkDxqGj5XKNGA+rzJNOoXHOWtufik
         riuPfATqL9wkUCgKO8zvaN2i9n7c4UH5YytP8bPL+sYTBm86admc5TJhfqSLso71iqpe
         35sg03IDH/0GW5VMwUAiW8VMoWiz0bd5LjHqeVInzE5wreS3EPM/dgXVxOm86Wscis4N
         LY3a2xRR9RPJaQIh90Wn/VRdv6S+T2XJ5XCTRfZaWe60CZlWHJzClaGgW8I/adsjSSS3
         aHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712234240; x=1712839040;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MAzVcsvooEghxXt7B4g+snAG6X7O0gFVG7to2PBHpSc=;
        b=DaQYqJxgt6XL+NAeqn0Y/Yd1vrX8WiHqmMuEZ4UZPiJDUnCgwgonbx6o4UuXaQpZMR
         JVKnQfluKvDt5ClN865wAJJPnVRcUNNcikAlHWHlOtoVHN95pLjETu0ymyT0K1/PgEY2
         /SGjw3ulCQ4qxBJkR/DpJ62s59SnDqHZDft3QEFckb27+s2zMPkcO1DiwVkm2XVFQAUc
         8a1gtn2q3QRlaj9QVZ5hux8KCe22dyksMZXj/3/xEKhHKDKmMcdH5FMn6ggbEAeDqLI1
         BVrE2xzjlCVV4B3Co35hx8yJH0Ox7/Kxn0W1ns0+E8mqVQ2oeBfYwA2Lg8BIlpZvJjOZ
         ZsvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoNrvi0ecsDHw6L3Ty1gls2rGATdahurh4jpzJsfKR6ushJf+sQFCfz3DYmUfrU7C12eZ81eUbGgeEKaVaZJXqtCoBZzAzF2Ce8M9c
X-Gm-Message-State: AOJu0YwtTE8FlVxPYAwju77lZVDdbdCk6jA7KOP9pge99rm0NzNhCDsa
	qF3M2EmTRWO+ziG+TdM6/JF140qIeghmu0nuyHpWx49lH5ZlK2lrglHITo+42f8=
X-Google-Smtp-Source: AGHT+IEBspPNVRi8BXITeVuqoYLQjpcXAbdjFKD2zXgiPUoHbd8zyMEWeZo29D1atJiMc8XolXuvag==
X-Received: by 2002:a17:906:bc96:b0:a4e:15f9:f167 with SMTP id lv22-20020a170906bc9600b00a4e15f9f167mr1504129ejb.11.1712234240443;
        Thu, 04 Apr 2024 05:37:20 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id b22-20020a170906d11600b00a46f95f5849sm8997106ejz.106.2024.04.04.05.37.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 05:37:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Apr 2024 14:37:19 +0200
Message-Id: <D0BCDQS6LNJM.3IOKUKU7G06SI@fairphone.com>
Cc: "Arnd Bergmann" <arnd@arndb.de>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Nathan Chancellor" <nathan@kernel.org>,
 "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>,
 <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: typec: ptn36502: fix CONFIG_OF dependency
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Arnd Bergmann" <arnd@kernel.org>, "Heikki Krogerus"
 <heikki.krogerus@linux.intel.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Dmitry Baryshkov"
 <dmitry.baryshkov@linaro.org>
X-Mailer: aerc 0.15.2
References: <20240404123534.2708591-1-arnd@kernel.org>
In-Reply-To: <20240404123534.2708591-1-arnd@kernel.org>

On Thu Apr 4, 2024 at 2:35 PM CEST, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> When CONFIG_OF is disabled, TYPEC_MUX_PTN36502 causes a Kconfig warning:
>
> WARNING: unmet direct dependencies detected for DRM_AUX_BRIDGE
>   Depends on [n]: HAS_IOMEM [=3Dy] && DRM_BRIDGE [=3Dy] && OF [=3Dn]
>   Selected by [y]:
>   - TYPEC_MUX_PTN36502 [=3Dy] && USB_SUPPORT [=3Dy] && TYPEC [=3Dy] && I2=
C [=3Dy] && (DRM [=3Dy] || DRM [=3Dy]=3Dn) && DRM_BRIDGE [=3Dy]
>
> It doesn't actually seem to be required here, so just avoid the warning
> with a narrower select statement and use the same condition that Nathan
> added for NB7VPQ904M.

Hi,

This has already been sent by Nathan, just hasn't been picked up yet I
guess.

https://lore.kernel.org/linux-patches/20240328-fix-ptn36502-drm_aux_bridge-=
select-v1-1-85552117e26e@kernel.org/

Regards
Luca

>
> Fixes: 9dc28ea21eb4 ("usb: typec: ptn36502: switch to DRM_AUX_BRIDGE")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/usb/typec/mux/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/typec/mux/Kconfig b/drivers/usb/typec/mux/Kconfi=
g
> index 4827e86fed6d..ce7db6ad3057 100644
> --- a/drivers/usb/typec/mux/Kconfig
> +++ b/drivers/usb/typec/mux/Kconfig
> @@ -60,7 +60,7 @@ config TYPEC_MUX_PTN36502
>  	tristate "NXP PTN36502 Type-C redriver driver"
>  	depends on I2C
>  	depends on DRM || DRM=3Dn
> -	select DRM_AUX_BRIDGE if DRM_BRIDGE
> +	select DRM_AUX_BRIDGE if DRM_BRIDGE && OF
>  	select REGMAP_I2C
>  	help
>  	  Say Y or M if your system has a NXP PTN36502 Type-C redriver chip


