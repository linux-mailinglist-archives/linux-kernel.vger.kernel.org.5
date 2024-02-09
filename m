Return-Path: <linux-kernel+bounces-59351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A7A84F5B6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8F24285058
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1EB381AB;
	Fri,  9 Feb 2024 13:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X24qYcl2"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DA72E630
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707484834; cv=none; b=SB/uO5LrNaoUdhrvRwch6sgA2ptkVzGZqbG7HiWzauIATtSfOo8+2EjExR8HHIe0WmGxHov3f8R+a1aCoDl1zAEZF8G7ZPJ+jHbvSzqLDHPqHVDGLXGIMEVPuY7+C15Mo13Ew5fS+b9hD0xWg4DoJm5ZXvfd+PVYrhiNifBt+rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707484834; c=relaxed/simple;
	bh=yHV4xD6vA5uk0R6Dh4WYIT0pSu9+jAt1mKXfWSKM2do=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GFuV1tx61y5W3XE2ObV65qJIqavCmzHdOROGARpNrKZ1hXqvTIrI7qxLTwud6J5hX8QUYEALqw6GLxuULgvg6d8pHAxIdYPKx0OweFQFKWpok1oXShmc/HmzQrOE75wUhucuzln4WWl+lOS+lUSgBhFzNF4X1ODaPUrPhhI5tFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X24qYcl2; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6002317a427so9150287b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 05:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707484832; x=1708089632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHV4xD6vA5uk0R6Dh4WYIT0pSu9+jAt1mKXfWSKM2do=;
        b=X24qYcl2NWLm9SXvPG0vqETFeGHM+OCT82MbulmC+FlrmY2aFDqt7dpsOn2qNuh0jf
         AciIwr+HvE7Y4h6t+6hC4PhrclT1qcTw5dBUWmOwafy7hrNX/gs4LOX/Ged0tqm8YQgJ
         PVrSYHlCtJR6SlryCMDZSFVVEqAX43V+l7QjSSPu5gtkh2y1t2uU/0T00LiTTVwAK7mL
         zruJ/BjAbyP8KeSwPgvmaang5PZpJNot5ANKAv4bFyOTtj2fsFYOTqOJpnSg7zQxPWmX
         4Qo51Eq0lgS/2LveK61oSgknetek/RkniZNys4F2m1oz+4MLB/+e6YNoRhANuZbcgKdc
         ZLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707484832; x=1708089632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHV4xD6vA5uk0R6Dh4WYIT0pSu9+jAt1mKXfWSKM2do=;
        b=BDDq1RbGBJsQSR1EF6Ukseq7c/xF1ONZy1UAqJ6w/poRrfpwm79drkfbPz2aOOaAlQ
         o9tHe11MTCzmVN5FmjMz7TaBCMWry4KVIPwNHDFe2SgAcGJ8NrtSvL9FsTkvET6Yn6Ha
         tLuboRsWgghGOLbZgJU20d5RP05aS5NhO9Gv/+UNd9eeRzFABy4sqBZNp7+Z+01X8tlJ
         3jmnsRJCnjuMR9TBR6zZE+NYr3IF+uWZMMssDZwgV/n0y8W3Ufj4PcHHk2kFpqFxtfy1
         u0mEAQemypoCNkSuRkSOMWeC0ZJm6vSyXlHqXkL6i9g+az0+N0X1P0c3xLh4almnDf6a
         3Z4g==
X-Forwarded-Encrypted: i=1; AJvYcCVSfD+JI5VFUp+HclCNa0qTyNWP+ylJr/FMzsryfpKoxcaMTIvLov+M7/mIpyhLNYrxU+DeYaXSVdMBYWuCxhMQm1YQuOlD0fA8k4PE
X-Gm-Message-State: AOJu0Yz4ElMzrbPTrjQs85BmJf5Xjslko0U+2y7oEny5FXOk1vsuqvfK
	uIMPnGFmU4NHSrXy6gqah9XeC5/vdAT1IXmn3TMkxhaYet0Icop9Loa+OgZV3oEI2Ug9yTI19eX
	bjqOpu78SPpPyK2JtmN3Pjk3OTLbFxyQNnIobvw==
X-Google-Smtp-Source: AGHT+IHzXhEAUvFgEV7wiolwPKaeO/ClVjbm4bCy3evX9EHgeTDtdwoxMk++CSmO+UGJKh1jRTy9lxWRLSFBSBxcRTs=
X-Received: by 2002:a0d:ccc3:0:b0:600:34b6:6bc8 with SMTP id
 o186-20020a0dccc3000000b0060034b66bc8mr1289933ywd.33.1707484832203; Fri, 09
 Feb 2024 05:20:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209-realtek_reverse-v6-0-0662f8cbc7b5@gmail.com> <20240209-realtek_reverse-v6-5-0662f8cbc7b5@gmail.com>
In-Reply-To: <20240209-realtek_reverse-v6-5-0662f8cbc7b5@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 9 Feb 2024 14:20:21 +0100
Message-ID: <CACRpkda-D_K=A5yxJnLJdQ1URpUWpmXUTgwECYV+_=sjE430EA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 05/11] net: dsa: realtek: common rtl83xx module
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 6:04=E2=80=AFAM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> Some code can be shared between both interface modules (MDIO and SMI)
> and among variants. These interface functions migrated to a common
> module:
>
> - rtl83xx_lock
> - rtl83xx_unlock
> - rtl83xx_probe
> - rtl83xx_register_switch
> - rtl83xx_unregister_switch
> - rtl83xx_shutdown
> - rtl83xx_remove
>
> The reset during probe was moved to the end of the common probe. This way=
,
> we avoid a reset if anything else fails.
>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

Sweet!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

