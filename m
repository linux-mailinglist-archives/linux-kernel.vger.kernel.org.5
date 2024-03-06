Return-Path: <linux-kernel+bounces-93520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 498E28730F2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3C5A1F29E10
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F85F5D8E9;
	Wed,  6 Mar 2024 08:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hlErZmx6"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6001A9470
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 08:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709714444; cv=none; b=OPU+hSwfxzbuFVksVahU3b9kCtpYMflyIVvMaKcLLdZHsyZ3Hk14yoFt4DXrjfsUbtOhKo5szASx/k4B8/yskVZAKx3J2HxqEIgpKaSMzpX9BZCLlW2J6MqhaYIrFJYYEOPpxewgzwefgEHC1jormaDuUUF8QvDf+QVsdTUc2CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709714444; c=relaxed/simple;
	bh=fTpCsu/6ZU8FqxRTRu6JSkKCSAuqJJxd7/aHe9Dj+Hs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nkEpWXKQIwZu+HH8tUyr76KySR07l72bADIdX3TM8EFq9FQ7prZaCd9ZBiHuk5a26Trg+DlUz5d5033faji7taEkGAYwGfaq0meoYL0V76C8+wFPGXO/ChSdJpkCLWY7NY4lrrHnuNtFPd9Qu8KcD0U6bjZrGWwTn4CL7XXEljg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hlErZmx6; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dcc6fc978ddso515250276.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 00:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709714442; x=1710319242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTpCsu/6ZU8FqxRTRu6JSkKCSAuqJJxd7/aHe9Dj+Hs=;
        b=hlErZmx6J6GPQEvmUMXt1edFiYBzJOqKoxvbhs7jlQBisypnmwbWqDtLNWh2JF2lyN
         57127EPzsCZyZ1tKRQARit7+AL9lT4kUAItNBvUKn0kUVazoie9VfNKwtJsAOReb37Pg
         iFlTvNA+cQblELGsFJjdxrqaMfNBafammmBTBu+tUMquFrmZaqwfN74ihj+Zv099zncz
         nyh81as2fCXzUq7d4bZ5EeXK9117Q7IQ1Es0HFucB2few7Cu+8eRNtZ4zhOq2JmfgCAc
         Wn7c56u9ULxxYOkJ0Mno0+4DciFeQxP8pLXarw0P5fehrHBY64bX2FnbmHHLQ4b3bVW3
         mHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709714442; x=1710319242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fTpCsu/6ZU8FqxRTRu6JSkKCSAuqJJxd7/aHe9Dj+Hs=;
        b=DrVTExaoprHEHiRIrrhuyzKi4v1DLNM8TzZBV0P5QLWMGBS0xMTP/BSUPS/4ZUdXI5
         Z1VbX05Pi4sxFkHTFSuTRkkfY0NcPhJtoRScKqYFtx15e922/N4xy84HJG3/vReaOxIW
         bauOyK3rwayUsXiVjsVxh9jphMs81AvvxwQKp7870UgFXVYbmYoH3yQmsQhzg16EW2C6
         BYrKATFtNM2iokbFl9CfqI/i59xpjIpi2Lc27SHRx1prWe6tnxkb8u9/1S4CFuwpKVfy
         U7g1DsQHKop/ItsDT5k08ZMvrr6x8P4YQriELkHSeRW9GBIlkJdmTCGc59FPGjQyor8F
         5hJw==
X-Forwarded-Encrypted: i=1; AJvYcCXvrg6hJ7Sn2dNFjpK0M8sm4bgXtmU8SRlLGqq0SXFiAxZwExwFxcS4BQHeq6giCcxQ4mlUWWTAMcEroP4C5Cu99kJq92GbzRd3ju0n
X-Gm-Message-State: AOJu0YwrNFdcCO0NfJi9eHMWKzJIDsQdcvVdPVU8tp9AQVxRXA57zqN9
	H21Y2PoWx2e1YNcLpPnTieZWJC1IcAJSxXttxfT7zHXdc4rsOZgT65j/1Fll0zz2VI40gFOfn/p
	IjUgta42xylN0G0DPsBZE4gFhdZq0SunavtVCRw==
X-Google-Smtp-Source: AGHT+IH2IIOi4/G0T0oMvBWo97Egq4HVaVZ0DhuUsr7rB6Y6OQ2qfSF+eTVGsPw3Ib6o6D5CqXl9NLJGpCn+DMkI6UE=
X-Received: by 2002:a5b:10f:0:b0:dc7:4265:1e92 with SMTP id
 15-20020a5b010f000000b00dc742651e92mr3968571ybx.23.1709714442391; Wed, 06 Mar
 2024 00:40:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301221641.159542-1-paweldembicki@gmail.com> <20240301221641.159542-3-paweldembicki@gmail.com>
In-Reply-To: <20240301221641.159542-3-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 6 Mar 2024 09:40:31 +0100
Message-ID: <CACRpkdbFxS_f1z=N-zZyxV_Y9kLDqHSGwwibV8kF8RgmjNLSkA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 02/16] net: dsa: vsc73xx: convert to PHYLINK
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Claudiu Manoil <claudiu.manoil@nxp.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 11:17=E2=80=AFPM Pawel Dembicki <paweldembicki@gmail=
com> wrote:

> This patch replaces the adjust_link api with the phylink apis that provid=
e
> equivalent functionality.
>
> The remaining functionality from the adjust_link is now covered in the
> phylink_mac_link_* and phylink_mac_config.
>
> Removes:
> .adjust_link
> Adds:
> .phylink_mac_config
> .phylink_mac_link_up
> .phylink_mac_link_down
>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

