Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D107F3A68
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 00:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbjKUXnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 18:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjKUXnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 18:43:32 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170C6D1;
        Tue, 21 Nov 2023 15:43:29 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b83d2981b5so170102b6e.0;
        Tue, 21 Nov 2023 15:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700610208; x=1701215008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nBS+DVGQWY8oXSxEgPe4ez0bnbZp4j8xClzB0D/ObR8=;
        b=OGYnISL+5IdS+qh2pYoRA1IaUeTCUIRBb962wa2nj8tKI/woDSwkbhtu20BarwOLJm
         4IcZ9bgh05vXm2/o8m6UYlhmpYmu2ZCiJLx3H/rUFiAR6/5Vn7lDbZxxHlViGITunYXp
         +cYz0JahbAOmDwk3u7QNLWdNbUslOaLwtuYoThJiPAeRg2V5796w0M8scgnrj1zew8uk
         85qXnqmDOaOCC7wm1raux1kUUKYRClZDc4u9mDQvfCMkWRFJUK5d6D1E6KzRjUAnqGvL
         DTH1sn5rYAzy0qWR/uhqJOsl7Xa5lQZEafv0RcA8SjPNTOOJ+ppxasgZvJF6ikEDSWMz
         Y6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700610208; x=1701215008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBS+DVGQWY8oXSxEgPe4ez0bnbZp4j8xClzB0D/ObR8=;
        b=gz9iXtJHUXjwCyAPD3hqrPFo20ggjkFvuGocliCoPD7IvgpWjczo/wtCelxYixalwl
         zEM6grODO/625H3tEQI1r+aCW2EnTljFUNyEW4qCGiHNcyL6NclPj57JJzPqXSd2ItNf
         zNn63Pgv59LAGEUpVTON5e/rxljJBzqED2Z8YoDh/rB/l+6/OLbxhpKaOIs0/qrSlFXe
         N/wDF9bScuNW+H29vr6MZCyDdJv0hFN8QzKNbryEc6tBFHtYBTzy9zxFbPiwJlLU7dPK
         fJiK3vr2kz0XWGDXZtUDqcs7KWfEWOzhZgLfdMEehMYObJo6W1KW7GRkI7fVQpqPN9qw
         o3UA==
X-Gm-Message-State: AOJu0YzsCjK9WZLF8mDJTmBPdnV0ODPFyrtBUqLsnfqA1149MM27YXnI
        npjtJ1hNyqWGy8Qo53DyZB46RWtjEcgfnA==
X-Google-Smtp-Source: AGHT+IHZ6/VS/djvTTtSjXXmpmFyVh1llZ04rQQ0TgJw5/LQzTx02CtBWjROC9dZrUGxzj3LMx4Y1w==
X-Received: by 2002:a05:6808:1407:b0:3b2:dcff:9e54 with SMTP id w7-20020a056808140700b003b2dcff9e54mr1108746oiv.24.1700610208258;
        Tue, 21 Nov 2023 15:43:28 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id bw1-20020a056a02048100b005c216d903bdsm5980436pgb.89.2023.11.21.15.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 15:43:27 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id DB697102106EA; Wed, 22 Nov 2023 06:43:24 +0700 (WIB)
Date:   Wed, 22 Nov 2023 06:43:24 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Hector Martin <marcan@marcan.st>,
        Linux perf Profiling <linux-perf-users@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Asahi Linux Mailing List <asahi@lists.linux.dev>,
        Ian Rogers <irogers@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [REGRESSION] Perf (userspace) broken on big.LITTLE systems since
 v6.5
Message-ID: <ZV1AnNB2CSbAUFVg@archie.me>
References: <08f1f185-e259-4014-9ca4-6411d5c1bc65@marcan.st>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fu/8SvnJ7Xc8DEer"
Content-Disposition: inline
In-Reply-To: <08f1f185-e259-4014-9ca4-6411d5c1bc65@marcan.st>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fu/8SvnJ7Xc8DEer
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 09:08:48PM +0900, Hector Martin wrote:
> Perf broke on all Apple ARM64 systems (tested almost everything), and
> according to maz also on Juno (so, probably all big.LITTLE) since v6.5.
>=20
> Test command:
>=20
> sudo taskset -c 0 ./perf stat -e apple_icestorm_pmu/cycles/ -e
> apple_firestorm_pmu/cycles/ -e cycles ls
>=20
> Since this is taskset to CPU #0 (LITTLE core, icestorm), only events for
> icestorm are expected.
>=20
> I bisected the breakage to two distinct points:
>=20
> 5ea8f2ccffb is the first bad commit. With its parent, the output is as
> expected (same as v6.4):
>=20
>          3,297,462      apple_icestorm_pmu/cycles/
>=20
>      <not counted>      apple_firestorm_pmu/cycles/
>                        (0.00%)
>      <not counted>      cycles
>                        (0.00%)
>=20
> With 5ea8f2ccffb everything breaks:
>=20
>    <not supported>      apple_icestorm_pmu/cycles/
>=20
>    <not supported>      apple_firestorm_pmu/cycles/
>=20
>      <not counted>      cycles
>                        (0.00%)
>=20
> Somewhere along the way to 82fe2e45cdb00 things get even worse (didn't
> bother bisecting this range). With its parent:
>=20
>    <not supported>      apple_icestorm_pmu/cycles/
>=20
>    <not supported>      apple_firestorm_pmu/cycles/
>=20
>    <not supported>      apple_icestorm_pmu/cycles/
>=20
>    <not supported>      apple_firestorm_pmu/cycles/
>=20
> Then 82fe2e45cdb00 leads to the current v6.5 behavior:
>=20
>      <not counted>      apple_icestorm_pmu/cycles/
>                        (0.00%)
>      <not counted>      apple_firestorm_pmu/cycles/
>                        (0.00%)
>      <not counted>      cycles
>                        (0.00%)
>=20
> If I taskset the task to CPU#2 (big core, firestorm), I get events:
>=20
>          1,454,858      apple_icestorm_pmu/cycles/
>=20
>          1,454,760      apple_firestorm_pmu/cycles/
>=20
>          1,454,384      cycles
>=20
>=20
> So the current behavior is that all output seems to come from the
> firestorm PMU event counter, regardless of requested event.
>=20
> This is all unchanged and still broken in v6.7-rc2.
>=20

Thanks for the regression report (and it has been handled well already).
I'm adding it to regzbot for tracking:

#regzbot ^introduced: 5ea8f2ccffb239

--=20
An old man doll... just what I always wanted! - Clara

--fu/8SvnJ7Xc8DEer
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZV1AlwAKCRD2uYlJVVFO
o8aCAP9VLRaP2SCBxEoyHuPgsn0Q5WQW3SmEqOCX6a8pq9iEYAD9FltPgjVA6zjk
h9C6hLjE6H67lgw50GnDhziUTCtluAY=
=9D7c
-----END PGP SIGNATURE-----

--fu/8SvnJ7Xc8DEer--
