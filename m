Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD1E7525E5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjGMPBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjGMPBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:01:10 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F25B4;
        Thu, 13 Jul 2023 08:01:10 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51e48e1f6d1so989721a12.1;
        Thu, 13 Jul 2023 08:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689260468; x=1691852468;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1vO4HyX+dM3nnt0QQhUfusx4FETmmoiGwrCI9gpUQk=;
        b=AdROyq8PWx5I33HhVwj6cQSeVa4kusq9Drklx7invVq8fZ+RQ2CgYN0yhL65E+ezU7
         8DAhqClYqnsrIdhtq6959J3N/C5bqRQBYVd2MM2iyKWEYOGRGHvUaOUx+lA2LoqynFn+
         1aI3IiauyGDJvwfnCyOuYMHSQWefYYF9UfGKH+fHB5JdOt3Y/IJNoaM/ope3yD0cpqqv
         M7MUOZs+Kstgkzd2HdE6FfoHZ/ZLYtXy0afVHUyLGD/w3QpRKIrDwPi0PDN/rmYKN+U+
         Mz6YRuZUHrvkNOh/aHirwbIDBoYIsLISJ+BeRL+lirkESy9e5aPW3niiProKASLun/p+
         c5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689260468; x=1691852468;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1vO4HyX+dM3nnt0QQhUfusx4FETmmoiGwrCI9gpUQk=;
        b=BsWh2YfSQFsy0td0QxB1QqC3FWwQIZr3kn1RTdFGWJuRi9q8iidP34vdQ1O261IN1P
         AVvTxaLIffX7HbtbiLDsfxTaYcBNul7Ztj2r+Y8m8PZls2p5XHszFcIjYpwzlwL2Q0z+
         32/S8BUKz39jAgfeD7D74jIzS4HdKLqgV+fMRI7N4sCja6rulxCiLFTvZ84tgwfzusD5
         zDPhddmRaS5C21Zetmfni8LZK0kDgQ0ETK+2w4p6n/uVFZQ5vXgCy8kmtbZIKY4MXxIO
         NgHhg1ol+HZAmk6kCwOYIKrQ4m0XX7JoQEQuwWbq4RsakHKvfoCcdHMhcYSvGJRZQZiJ
         LZlw==
X-Gm-Message-State: ABy/qLaHjONWNHQ2pTiVAxb5mGXTFR/G3ZqIOzMlS7kJbUVO3U64y1zV
        T4A8gwjyK7ul9tXd9RUfxW0iruEQVmA=
X-Google-Smtp-Source: APBJJlGKhezTxxMVg06X7T7JInUDq51n8yxXTqPFludajuUp5XpLio81sYZgrIUjaiiE4JGzHd6grg==
X-Received: by 2002:aa7:c3d8:0:b0:51f:f1a4:edc6 with SMTP id l24-20020aa7c3d8000000b0051ff1a4edc6mr1459117edr.37.1689260468233;
        Thu, 13 Jul 2023 08:01:08 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id r18-20020aa7c152000000b0051a5cf5fcaasm4297446edp.23.2023.07.13.08.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 08:01:07 -0700 (PDT)
Date:   Thu, 13 Jul 2023 17:01:06 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     krzysztof.kozlowski@linaro.org, treding@nvidia.com,
        jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, bbasu@nvidia.com, talho@nvidia.com,
        Johnny Liu <johnliu@nvidia.com>
Subject: Re: [Patch RESEND 2/4] memory: tegra: Add clients used by DRM in
 Tegra234
Message-ID: <ZLARsuP9bVFsHtFW@orome>
References: <20230621134400.23070-1-sumitg@nvidia.com>
 <20230621134400.23070-3-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Dfwuwz9HQNADQ4kE"
Content-Disposition: inline
In-Reply-To: <20230621134400.23070-3-sumitg@nvidia.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Dfwuwz9HQNADQ4kE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2023 at 07:13:58PM +0530, Sumit Gupta wrote:
> Add entries for VIC, NVDEC, NVENC, NVJPG memory controller
> clients into the 'tegra_234_mc_clients' table.
>=20
> Signed-off-by: Johnny Liu <johnliu@nvidia.com>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/memory/tegra/tegra234.c | 120 ++++++++++++++++++++++++++++++++
>  1 file changed, 120 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--Dfwuwz9HQNADQ4kE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmSwEbIACgkQ3SOs138+
s6GLGg/6AsiRyBX+973/d8nscIozRRU1qZAH7Cr2fhgWuZfgDk7KP1UfZmlq7AgR
gZrBTCriTROq9NWr22EZcv75LyxCSzBOKsPlkC4u4fR2Ee1vm+xkb2qvJrJubTtu
/7xmYekUr0vfO5Ko3f/MIAUaOmQp280oa9O/gxVI6ym/ELe28/ZEjGLcdkTNv4tA
bg02a5Ii+e9tl2Mj6aoYDyy747nlltqLEPNLaYdzlrnVOPI1zC2NKY2rhOIQWtHY
4LFQLbu5U2hqJl0w89wodyin+52xzmj9Z1qktCT10ClMssTzltYJvXrI9kcGicNA
Yzr1lwgYn/xFK3MalM/0o9DP8KaMagmi4hj28FCeebd8V/hUn97WCPudCwgATXs3
1s4IDXCAqBk2GIXz7I8ok9BAyj74jEvtMMKGuTzayVhfXbyDYLfoDFceU0NXwlr7
4WykxU7/vZzuwADp4Vj3lESmSRviIPUYHN3K4XlHAqUlj6+vmGAqY7Dsf0zZXU8J
lPDA3OELeOzqcTyZhbu522Q7/TY4XmWoLqTgDoZOXu6cimBAJUIKlgNX11ETtVVV
3pbl6X+O70jfJPbqd5jopEJ+LLy2vlz4eTWfEdsQa/4R8+1RyDknsLA1uAVYGNFW
3Hxw1qLnW0BH3mBaWkrZO4iTW1KV7mplMkgPjWqBc++/Xm/VHE8=
=r80B
-----END PGP SIGNATURE-----

--Dfwuwz9HQNADQ4kE--
