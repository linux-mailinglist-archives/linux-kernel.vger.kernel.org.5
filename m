Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B517AE30A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 02:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjIZApV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 20:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjIZApT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 20:45:19 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4751109
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 17:45:12 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3a76d882052so4756428b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 17:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695689112; x=1696293912; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZTYZb1O/8biIsQ+eMZWKznGrdbrF4IydOkWiCWQs/k=;
        b=Ytdhjt2fzT5VBEa8J7mzc4sTm0vYz+4xKPvesa035LfQLXDdy+MSdx1hnU4YefH87R
         vcWY0qzQZe3wNC/9f7kbh4YnbJmCn21rgy+JF2X2JdTJ/f8dy74ZnJFY9YZvmmvBlZ3A
         RnTUaJei4LWb8yVcd4xjzLt7hIM2SmxbI8Xgdg3sYCvdcK83UP3U2NPKE2yp0keaICg1
         Qj5nxyDMR+s9nDZjdRiuZjQPTuTx3c7LNvd7fZ1LLjqa2IsubV4wtrd7g2sHtOxFd/mH
         BvUrGcWbZPxE9FOOKfY7xzLS7NwQgV7+pq0/ezA4Sv/dESq2mUS/Wh4yj+pzxYONfqZ0
         W5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695689112; x=1696293912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZTYZb1O/8biIsQ+eMZWKznGrdbrF4IydOkWiCWQs/k=;
        b=iZiqsj18AX3j42/L80RhU0PbrT8NE54Eg7u/gcvIJBv8Esov/1oIZR6mGPKuQxYvMK
         xK4ugvenB6DM/4nrFzLnpW7UYmxPgi/v8A4C6y+sQ/8suwWC/5yvGbt5OGgd0CQ37c2A
         iC1n3oT9y7Yecko6z+THftyEbd1R4upE3PC/ZRtqilPB6CanQAmZy/UArA1DrxZaMuki
         QRjRw7u3ywGc7/iR+JKKB1HWr0vSeEm7U5IbRdgqcLMFxklP8NpIp5TRioKk+T994DmP
         lw+Gz5ALE41GvFOM4tM1pUjLzA33rclkFo7xALtteCGcp6T9Nhl28qeqU6voh61beUbh
         rK/w==
X-Gm-Message-State: AOJu0YyQ77rNAw0XdPUu1ePe94YrTbYt7p4rGb5LvmAGSLaa6RwhB+1R
        DaMVi8sGwN3GN/hU+oVYP4A=
X-Google-Smtp-Source: AGHT+IF8AN+UF9heZkKmaDjpUjAZWoVU+YSjuCe5tseNHNGpYZF4qRiB7SjjovLAdUiD9ZpsCrrWzw==
X-Received: by 2002:aca:1b1a:0:b0:3a7:2524:6d3b with SMTP id b26-20020aca1b1a000000b003a725246d3bmr9240534oib.12.1695689112150;
        Mon, 25 Sep 2023 17:45:12 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id b2-20020a63a102000000b00565eb4fa8d1sm8249080pgf.16.2023.09.25.17.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 17:45:11 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id D2B848DBA76C; Tue, 26 Sep 2023 07:45:08 +0700 (WIB)
Date:   Tue, 26 Sep 2023 07:45:08 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Andres Salomon <dilinger@queued.net>,
        "Timur I. Davletshin" <timur.davletshin@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux AMD GEODE <linux-geode@lists.infradead.org>
Subject: Re: Fwd: AMD Geode LX hardware RNG driver produces regular patterns
 (geode-rng.c)
Message-ID: <ZRIplFgg0ZnzGzre@debian.me>
References: <9a28c2fc-d769-4802-a1f2-77ba2cb34d25@gmail.com>
 <ZP2ERFydER7pJprL@debian.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oAxHbzBYWu0jpnr5"
Content-Disposition: inline
In-Reply-To: <ZP2ERFydER7pJprL@debian.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oAxHbzBYWu0jpnr5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 10, 2023 at 03:54:28PM +0700, Bagas Sanjaya wrote:
> On Thu, Sep 07, 2023 at 06:37:00PM +0700, Bagas Sanjaya wrote:
> > #regzbot ^introduced: v4.14.267..v5.15.127
> > #regzbot title: predictable urandom output on Alix 2d13
> >=20
>=20
> #regzbot fix: https://lore.kernel.org/lkml/20230910083418.8990-1-jonas.go=
rski@gmail.com/
>=20

Fix up:

#regzbot fix: hwrng: geode: fix accessing registers

--=20
An old man doll... just what I always wanted! - Clara

--oAxHbzBYWu0jpnr5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZRIpkAAKCRD2uYlJVVFO
o9hIAPkBcPsGbXpzy8vEY+n8oazqVd8MEixSApC3y9+Ysyio3wEA9WY8fXAXeXa/
WDJ/grKG9ytZm+3Ucl8J8bIvE4pcUwU=
=rke0
-----END PGP SIGNATURE-----

--oAxHbzBYWu0jpnr5--
