Return-Path: <linux-kernel+bounces-30515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E68A5831FB9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ACB4B20DD5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7F22E407;
	Thu, 18 Jan 2024 19:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dionne-riel-com.20230601.gappssmtp.com header.i=@dionne-riel-com.20230601.gappssmtp.com header.b="K20sqeVp"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59DC2D796
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 19:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705606070; cv=none; b=awYsBbiMqzlsVwmE3aKqIRVcENqjbAA4FKdpKnPqNCsGWQxQ6ogz4qBy+Lt1QherxI3AS7pr2yMd+LmEkhSbmF8Oi6u9aLU96NmrFvmtP6WQNeiWxKCXjIEIqkcngJSNMu9Vh0dK1sSp2QfuRgLK5fwYV0IoOfPWYryJx4StCSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705606070; c=relaxed/simple;
	bh=Yar1XVZ/VjR4FynzD3NM+MEkkvT0jCBMyW/eO9pNfwg=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=is251v4iPTMUgiPeDJg3L0J8ViXpNFBvz/h21Fn8gB+t5t6j8TzyAYwoYPvwuxqidr0aRDVjrLmnz/sxvs6tt5RH8d1U4NLPlSHA+Wnu0y95kWCFJux/NNxn5KJ1krOarFgDG9mrT5GCtdTAEYjdN8Jayk4BsVVIPP+calMWhuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dionne-riel.com; spf=pass smtp.mailfrom=dionne-riel.com; dkim=pass (2048-bit key) header.d=dionne-riel-com.20230601.gappssmtp.com header.i=@dionne-riel-com.20230601.gappssmtp.com header.b=K20sqeVp; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dionne-riel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dionne-riel.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-78324e302d4so2345985a.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dionne-riel-com.20230601.gappssmtp.com; s=20230601; t=1705606068; x=1706210868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cl86MxNlP9JU8mn4QxWW8Z1SEI1toh78ROznChJ2Mp8=;
        b=K20sqeVp4YjiXIYolUoyHDdnC+WYvk/wNP+KP2cubureHXGEuweV3zq8JwP3S80wHU
         F8e43s8EwhhBu9M+Res/Q2zZ68n4GAz5WTG7Rk1CP1NF2Uo9yH0uDv7URtbURbQ5nyDi
         ACFmKRH1aFgZfyAgVoURzumSG7dnVc/2kqfBiKXxpR2toBqKDWgHEJTJR9cag9NROaYy
         KfLMpWZItfYfw4UNyrKN+5wQAXn8PW1uXFLtJv/RRvTiyvUYI9iw9IZyoVK+8AHmT+r0
         BmpU0EOI+Ry0TtRpir5VjAAfF3cTJVNI3pdjY91pl1IbyvUGulYUOwzHc51Aeww8Xam0
         Yq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705606068; x=1706210868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cl86MxNlP9JU8mn4QxWW8Z1SEI1toh78ROznChJ2Mp8=;
        b=FnYsdwUrUmL1HBMDRyW7BDF6nIj0v5Mr2iS6/pn0VxvnogWj9OuUQ3XNSe2Y8qASKW
         9lR2L3G7TQtxhgq2i44pixpENtjdQl0M5JRS5kOvRaKXTMhuc4YwzSilVVW42+gJ6gfU
         +DE79jZPWYNbU0gbge96M6BRnZpTJBzcIInDrfPHB6+oIBERew6mzTjufjRDSnKKESaW
         HaXHoUOz6mnUbLHbHF1li9cPhXrUONydiwq7Yr0Zjpk7AajYNT8525JI2RHpBK5m2l8o
         zr3Avx4CdNrC0xV4azA+nulJBU4e4TWFMKGm03vaPgWw1k7A6PVpoRwqarpku/10uarN
         hNBg==
X-Gm-Message-State: AOJu0YzIer2KGpma9uEZAylBDfKzQ35rvAaX7hSBnES+0KjnFCPZIYuQ
	66PNwBhiU+PKviqftxUryT31eqL43WLDft7qMxDQqjlvMFKGacGntScT8IM/MBz6mAkRZW36hoY
	GxQ==
X-Google-Smtp-Source: AGHT+IHSOe1LtWuDt9eb1xAJjqjUVCk+Ml5NMxnoOGGVWM65IW19VJdnN3QsYNsy62zdIQZtdfVgAw==
X-Received: by 2002:ae9:e105:0:b0:783:47e2:41ff with SMTP id g5-20020ae9e105000000b0078347e241ffmr144690qkm.43.1705606067572;
        Thu, 18 Jan 2024 11:27:47 -0800 (PST)
Received: from frankgrimes (135-23-195-66.cpe.pppoe.ca. [135.23.195.66])
        by smtp.gmail.com with ESMTPSA id h7-20020a05620a10a700b007836647671fsm2631952qkk.89.2024.01.18.11.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 11:27:47 -0800 (PST)
Date: Thu, 18 Jan 2024 14:27:45 -0500
From: Samuel Dionne-Riel <samuel@dionne-riel.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm: panel-orientation-quirks: Add quirk for GPD Win
 Mini
Message-ID: <20240118142745.1b52585a.samuel@dionne-riel.com>
In-Reply-To: <20231222030149.3740815-2-samuel@dionne-riel.com>
References: <20231222030149.3740815-2-samuel@dionne-riel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Dec 2023 22:01:50 -0500
Samuel Dionne-Riel <samuel@dionne-riel.com> wrote:

Hi,

Can I request a small share of your attention to review, and apply this patch?

Thank you all,

> Signed-off-by: Samuel Dionne-Riel <samuel@dionne-riel.com>
> ---
> 
> Changes since v1:
> 
>  - Add 1080p right-side up panel data
>  - Use the correct panel orientation
> 
>  drivers/gpu/drm/drm_panel_orientation_quirks.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> index 3d92f66e550c3..aa93129c3397e 100644
> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> @@ -117,6 +117,12 @@ static const struct drm_dmi_panel_orientation_data lcd1080x1920_leftside_up = {
>  	.orientation = DRM_MODE_PANEL_ORIENTATION_LEFT_UP,
>  };
>  
> +static const struct drm_dmi_panel_orientation_data lcd1080x1920_rightside_up = {
> +	.width = 1080,
> +	.height = 1920,
> +	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
> +};
> +
>  static const struct drm_dmi_panel_orientation_data lcd1200x1920_rightside_up = {
>  	.width = 1200,
>  	.height = 1920,
> @@ -279,6 +285,12 @@ static const struct dmi_system_id orientation_data[] = {
>  		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "G1618-03")
>  		},
>  		.driver_data = (void *)&lcd720x1280_rightside_up,
> +	}, {	/* GPD Win Mini */
> +		.matches = {
> +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "GPD"),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "G1617-01")
> +		},
> +		.driver_data = (void *)&lcd1080x1920_rightside_up,
>  	}, {	/* I.T.Works TW891 */
>  		.matches = {
>  		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "To be filled by O.E.M."),


