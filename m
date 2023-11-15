Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4327EC357
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343890AbjKONLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343871AbjKONLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:11:12 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B36311F;
        Wed, 15 Nov 2023 05:11:08 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5b9a456798eso4266334a12.3;
        Wed, 15 Nov 2023 05:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700053868; x=1700658668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EhfVaGER9sTAd2B+qVaDfxqJSQ9hYyt4DuktjBuV3bs=;
        b=lDPxzKBioboqkoosHxSvQhzSIdgzhOKvDgY7jpy3NRdxG8bzHnZjoSdTnJvHRFw0P+
         mGCYk+9vtiGxoRMH/jPQWEbT/EQa11j3ykjn3LgdH9kKclu/ZA0lERC2ughjNva1AJJz
         9N+441W+pc+x30q2f5+wuMHZ4mJKK3UXYSaliiJxg909YyIXyrcwIoB1kpfSrn0vfEk8
         lQ2Rx3l1sCk90XEVAAZNzbvvGaK11rbDr8+uSdIzgVylKBFnfIAk/4ToKwiPF/d19dUc
         uAZCUG5v42SWlqjGVOzkNuBzBbh+VelEX8EH1I102pQwCBG0JFcj+GHPoXWPnbBrJ2nX
         4XZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700053868; x=1700658668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhfVaGER9sTAd2B+qVaDfxqJSQ9hYyt4DuktjBuV3bs=;
        b=LpQCMY1skXmSbFgIu7Tz+Ko4W9671W0dfDCvahg46msDdRGfyobrzFHzLcqtVG1G7M
         8tEltmeAB4yst8tcPpCkrsJd9I1PfVTXLgLMS2WhROi+XDBeTXWho9trBBmH72gDi/11
         qqRlJWV98FK7Q6HzFRGZeGUk4Q0HX+l+9Tz61DL5YroWhEYL0LK89fO0e/FBu5DF6e+s
         tc0AUGTR9IPa60LrNSYABHu7df7J4xpVJ7YVKRJPrKt/SYpBjjqh6jjPP29xi2KR6XMj
         tqD1PKsHJJLvVbpRpWIJ2DbJVoUlJ3oqHrc2sdXRYqGgBtNlJiOgxEskAoUblyGZumCS
         h4Cw==
X-Gm-Message-State: AOJu0Ywui/3cugu6JmiX0YTk1KArU4inbXplYQjaflUUJzfUAVJHjZ3F
        HGQWEkNSvEMC52aXK0WGNPo=
X-Google-Smtp-Source: AGHT+IF+Tp/0plK9/VgBp5NpeKL0shngz+o/5+5GbHwpQgFqtAF/n2vwDB9t8Qvx+i5meirX7aUHMw==
X-Received: by 2002:a17:90b:3149:b0:27d:4901:b0b7 with SMTP id ip9-20020a17090b314900b0027d4901b0b7mr11047462pjb.30.1700053867647;
        Wed, 15 Nov 2023 05:11:07 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id f6-20020a17090a8e8600b0027df6ff00eesm6757051pjo.19.2023.11.15.05.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 05:11:07 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id CA40910D2CF4C; Wed, 15 Nov 2023 20:11:04 +0700 (WIB)
Date:   Wed, 15 Nov 2023 20:11:04 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Anil Choudhary <anilchabba@gmail.com>,
        Linux Regressions <regressions@lists.linux.dev>
Cc:     Jay Vosburgh <jay.vosburgh@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
        Andy Gospodarek <andy@greyhouse.net>,
        Ivan Vecera <ivecera@redhat.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: sr-iov related bonding regression (two regressions in one report)
Message-ID: <ZVTDaJOtjxEOPbNq@archie.me>
References: <986716ed-f898-4a02-a8f6-94f85b355a05@gmail.com>
 <32716.1700009673@famine>
 <0f97acf9-012d-4bb2-a766-0c2737e32b2c@leemhuis.info>
 <CC024511-980A-4508-8ABF-659A04367C2B@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5OAjmnZvSGI+Kva2"
Content-Disposition: inline
In-Reply-To: <CC024511-980A-4508-8ABF-659A04367C2B@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5OAjmnZvSGI+Kva2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 10:19:25PM -0800, Anil Choudhary wrote:

>=20
>=20
>=20
> Following error error scribing to said is also new
>=20

Please don't top-post; reply inline with appropriate context instead.

What error? Can you reply with logs pasted (with error you mentioned)?

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--5OAjmnZvSGI+Kva2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZVTDaAAKCRD2uYlJVVFO
o+HWAQCGEf3FzxnS66Tm5OsffefCiiLmkMPkFzFUGydECWnqQgEAuTWunm1ReBNR
PWiCRjKLt7pQpv6KX8OQt1zipha9ngI=
=PeMO
-----END PGP SIGNATURE-----

--5OAjmnZvSGI+Kva2--
