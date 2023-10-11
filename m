Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C3C7C5E4F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 22:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376326AbjJKUYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 16:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbjJKUYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 16:24:44 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE0891;
        Wed, 11 Oct 2023 13:24:43 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso38372366b.1;
        Wed, 11 Oct 2023 13:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697055881; x=1697660681; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzvkbhkLaMUPqU7HMTRyBjb4pmEB3My0Qu8sb0+YfiQ=;
        b=RnomGxJ3ysZqyBOEQ8DbLeXEJaLOvy3pQaObqvM0J/UwOgZoP/KujThEwd2QlBie1w
         XhTsFHyN6bk6Q7PRSxsqTMJX4qDb9T0ppdYjiPk8+O9oVapFKST9e5WvYiFvVTrnpnYh
         da2rCsthDyJP39X16ElauiJuXuWxbhAxbOWqe5r77NAxts01GPJK0DuLoUl9nGDiQc5U
         M5rl+qhKvfRPbMBRaTcgPj+CFXZsFFrBfZiE4tZ7LeN3EchCwk3vLdQJK/0H1olEOeQL
         6ymN6bXsZeThwckyjjXTz3AT2yGBdpLXmQDN5DOpa6nzH+EETesFZpjeFGZKQAbhZKdO
         /r2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697055881; x=1697660681;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uzvkbhkLaMUPqU7HMTRyBjb4pmEB3My0Qu8sb0+YfiQ=;
        b=t+Scl7bHeD/9nGTAEfLll34SLc7YNl5MulEiUuH+beM0ILoJF4PKUky1U+yk9G0Sjq
         /iOSEal2NdO/Iv+9Tx76D9l+6bxOkAIuzY/n8VtQjT3Fpi+MdSaiGDaUbaVt4lLfJZs3
         nCriWCwWFkYHC3IffBndpzU7k1iGrlZz31ayNpjfVATeLToMatAse9YfZD52vZ/NDrRg
         93WC3aRwe9b9Hh849Q2IkBJn6dv9GF1EflwzftqX2WDFKQEhpJKYeX52klLENmPwh2Rg
         pWeWMF9xxhu2DZdecphkvwN6EoWKq/oTln1wzTpgwBDWIMk2/yTdpsvvHfEdGXjEL+uD
         fQMQ==
X-Gm-Message-State: AOJu0YzWxZzhgjf0+CPKHjGIpBux+vbWO9fKiHHM2br7oXiKC1gSaD8F
        TZYrP7EYiQyQHUH7HBHe5PI=
X-Google-Smtp-Source: AGHT+IGygcDlYEvQCHkHqj9FwQIkNeS15ycoNc0YrqsIvUTmjvBthYTots46Xd0hRCc9tkEJT5LYaQ==
X-Received: by 2002:a17:906:53c6:b0:9ae:6ad0:f6cd with SMTP id p6-20020a17090653c600b009ae6ad0f6cdmr19804679ejo.24.1697055881232;
        Wed, 11 Oct 2023 13:24:41 -0700 (PDT)
Received: from orome.fritz.box (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id lf8-20020a170906ae4800b009b27d4153c0sm10326077ejb.178.2023.10.11.13.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 13:24:40 -0700 (PDT)
Date:   Wed, 11 Oct 2023 22:24:39 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-input@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: tegra: Use device_get_match_data()
Message-ID: <ZScEh0j0SlOZFcWv@orome.fritz.box>
References: <20231006224432.442709-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EpZWWdJP6+/QOGEM"
Content-Disposition: inline
In-Reply-To: <20231006224432.442709-1-robh@kernel.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EpZWWdJP6+/QOGEM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2023 at 05:44:32PM -0500, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/input/keyboard/tegra-kbc.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--EpZWWdJP6+/QOGEM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmUnBIcACgkQ3SOs138+
s6HPEQ//WdVN2OUKGkF3D1pmcNQrs+kbsWE+RlouD5B/2En6FyPJuCy4nTBaWJhU
4PvIIpCvEm7YD+vaO/D01a8cw/pC4bHTgsgsiGvRaJPnaX9ypzldeWjS8FW5hIgc
zLaUbk0pDfw85Nix0Ru0/ApueorU4PkpNc93LrTwsggpDAuqjTMXZuzHtr9z6Bqb
82IDUE5qEl8dE4kDdoX4oGWMZEKIrCSvGDUOPwNsLtF8nV2EUXRkW9PdNQAcj3Ty
e+zk3mje2GDpsy38aXfOZcSXNWt2Jk6sVppa8T0PE9e/BNY6Vp4eo6fLJh3RJdjZ
601g6oX+It3yBhm+4OrORgMuDu0IniMlABX636LYVS+oopQr9VXG6+QDTHkjcgE+
1lU8HxlJ+/V+/Tk6aEwztHl42i3BcbNqGlwpiAc6ZtCHXOGcoYklfvVjMPY9kKzN
JZevK8qnzDdG9xiwOwWBGhBsiY0jfaKeOyrRVdR4/aHFC4JtITrLyhbYVxG4u0uI
vCLe/VQbrztt21lLz4lm4yekglOvupPH3NNPBf5aXdycRuZRrkFetf2I2aU9NpB3
weiM8Pb0sHqYdwRCNxwKHrTh3vquAPiqe3ZZD9uKI93Bv0FTcu4iw1W/dq1A/NIH
DWiop4xR28fsqhxZw+MUxpKXwA2vmeInmRz+FOTtPUuGLbNFejE=
=LrBo
-----END PGP SIGNATURE-----

--EpZWWdJP6+/QOGEM--
