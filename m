Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1636B813861
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443902AbjLNRWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLNRWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:22:37 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B06593;
        Thu, 14 Dec 2023 09:22:44 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a1db99cd1b2so1081911866b.2;
        Thu, 14 Dec 2023 09:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702574562; x=1703179362; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gskL73SYt1estiCHnemg6J9wLZhlZpDGrDz26SfS1rQ=;
        b=bVz2mOWmIgWd5ohLw8NSZr2rUlVFgTVLLAR16FpoC8aN0mDQAepwpmkahsJofjDPWO
         tfCwIhyqfch5H6k10wRfk/UCDyIOla2Jen9wiFQZM6NTWS1HiJekexwhTIwWxa/4ODXJ
         ZVJ6JNggqVNW7CgDgJBZBQ69RhbTMk5IfLBF+sB3kTnMBTW6jFLb8XRDt1cfIo9Lw2ic
         blWjxHVv/IFrbUxsYSUQ3I1UeyA5e4aMLB5+fYLyqX4sncb2PrVjc9v0M8yfHHNbXPoL
         vsNvKIjkLG3hJbaUMaZRgHhfzmiDEBcgxMJ1ok4c5lJYileoJDWZPJq4VN2yNBYU7Jo0
         vlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702574562; x=1703179362;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gskL73SYt1estiCHnemg6J9wLZhlZpDGrDz26SfS1rQ=;
        b=NLYjDMspGZ4x89WCmP+eqK3/6kOjdvjGQqGXFd48m0/Ga9VZ4qiGsTyqWSKCP/DVzv
         nm+2mufsjZ8p2WvfWbbWZAt2VkY9deW9UZpT565lsAIm4waZASLEvx83lv7WJ5b0bYcR
         ttAlaFizbnLhXg+oCzxgUEVCy76x2u0KnpPMAFSXWXAVzINCiFlvbKyC7QwrPi/yYfML
         0HC3MkouJ3v/2ZJpPL74+i5SNOQIakcvD/UMZCPsHf8PBwo6t/BoS5D88RGduXOzhCqp
         ZXODXnzNJL2GTN9jelG4om3hUXGOFPSHCU4BO0PwQsleXYyVAfCZa6L/9zE0Mr1hkn9y
         tcEQ==
X-Gm-Message-State: AOJu0Yz0yJGo7hpC2L4rz3gJAZs7V/n7KS/nTJck5+Q04QI6BQNYWry7
        wP5kdvhCbftOyc4Q343iCBI=
X-Google-Smtp-Source: AGHT+IF+KLQnvjnbzXoYI+R/38f0suL8s24t04G0woQjI91W/htsUbhCdf6FFQDWE5tozKz9e60COA==
X-Received: by 2002:a17:907:ca2a:b0:a19:9b79:8b44 with SMTP id uk42-20020a170907ca2a00b00a199b798b44mr3290310ejc.85.1702574562332;
        Thu, 14 Dec 2023 09:22:42 -0800 (PST)
Received: from orome.fritz.box (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ty14-20020a170907c70e00b00a1d70804ac9sm9616950ejc.33.2023.12.14.09.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 09:22:41 -0800 (PST)
Date:   Thu, 14 Dec 2023 18:22:40 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Chen Ni <nichen@iscas.ac.cn>
Cc:     mperttunen@nvidia.com, airlied@gmail.com, daniel@ffwll.ch,
        jonathanh@nvidia.com, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/tegra: dsi: Add missing check for
 of_find_device_by_node
Message-ID: <ZXs54BYDq5Xjw3rL@orome.fritz.box>
References: <20231024080738.825553-1-nichen@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YoXO4vJu2jzRymw/"
Content-Disposition: inline
In-Reply-To: <20231024080738.825553-1-nichen@iscas.ac.cn>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YoXO4vJu2jzRymw/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 08:07:38AM +0000, Chen Ni wrote:
> Add check for the return value of of_find_device_by_node() and return
> the error if it fails in order to avoid NULL pointer dereference.
>=20
> Fixes: e94236cde4d5 ("drm/tegra: dsi: Add ganged mode support")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/gpu/drm/tegra/dsi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied, thanks.

Thierry

--YoXO4vJu2jzRymw/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmV7Od0ACgkQ3SOs138+
s6E9Sw/+K7E1zQycMWDojVUC/8INCGH/PyVX/VF6pPdrQBBeiV1SWW7eJZN8zBKA
oyjwunugLBII8F2zmdLelaSzmEOY+eFJPEBJG5/y0vCFi9qFaTOyktzbmp3qNehl
eM3oSKzIdxonwO7AH0HmwaTQNd4tZqg7A3jTWfzLv7iiCFMsniHpMcenz7pRHw5c
ogfDv6sSXVgvnFE/GSpytejr1sdb5lQKhv/LoqQZd2C1v/itwteZkzYn71CiQX80
BiwAvgWYlc+3A4WktF+i/Ybcrh9tPtmONMZg/OOriK3fQEE7sFwJ14CEIBxUlBhj
dwoFjqX9G/yu0WPgpNVTQvpCL5DuX4LR2i9nfDADbzMup5H8PXy7Z+fxX8jgFRko
XuuX0Vz72x5x8nQhSnLWoDqutW+XHzWfFFi8iLvnjoBZVXfnxjUroizZIvBRBIOy
BN2/bteLLMDffAMAJt80h5yI/iKidxoGs9SxfCzV7d3sNHl3aNwHSL3DOSDjsoYh
dp9VWzU9XUWE7mNMM39w3G2k1ARB9Dhm17qpNQPycWqrTmEhPNA5+u9aabYAeP8s
6YX5RHjUvpgmLZeOaMAULsJjJb75qvBmK6m5/MBVV6XfxUJgerELHZQ66lLXoRL6
SQ3DnmMzuriqg227ol9sE5qd1ve+DEKTPsSKcI3+uiW3NXn6u7k=
=NmLP
-----END PGP SIGNATURE-----

--YoXO4vJu2jzRymw/--
