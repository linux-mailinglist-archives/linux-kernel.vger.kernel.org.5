Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E849779331F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 03:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbjIFBCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 21:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjIFBCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 21:02:02 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A7A1A2;
        Tue,  5 Sep 2023 18:01:56 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68bed2c786eso2151986b3a.0;
        Tue, 05 Sep 2023 18:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693962116; x=1694566916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fwjOextC4o2E3xgdiq4cQxhzdLA0veFCKTQAeNbsF4Q=;
        b=kKpI7DFZmfepJaqf4TfEluUSXGzn3TsXpaJoIwlsYR0lGYOIdGaXorOu62HxjZKTR0
         KlPP9AMpiltI6HP7tbE1922JazNR5vux3xCVZ1D5UtihkxH2VJR4jr9CUEuR0uHUKptD
         GLiSVkUDxPhyn14SFtJF9r5D2Gy7j+v6gfYUsBZsBGT0hUfCLfA3W/LcwsemFYAOEOuw
         etqV4XIURLjYuRKZWYnbFh32q0++8jlzNcGZ1xh4cUwWA9l1JLtoF1i+2++iprWX/zx0
         SrhCQbJRRdbDE0/caJPJ/DqX4/ZcDwDXOKPTkXb6ksRxtzAknb+WNw0YnaAZqob6/xLl
         0gQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693962116; x=1694566916;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fwjOextC4o2E3xgdiq4cQxhzdLA0veFCKTQAeNbsF4Q=;
        b=itVE35J2oI/+BM0PpIqo2eKyGCvit7nZP9C325sQ3KdgtqtOkcmZ9OF6TOjhZJ0bV3
         8XVQzpo6qfa58nHIS5+bOyAu+dO7yytvoEI0vKt6PbwQABEKiFwN8KnJIHdDRshj39wc
         6JRjzZ/YhwLMwEw0vL/aIc4UqFONL9Fa2a1lEFMRm/nRTB7C6CvcpL9YAYJC2YkaHzZF
         a5tInYNKfND4Hhf98p2OLX9o3PwDbNpS5aZoDOdj7ISIyCoqSDldk6wz97LAcN7+GvL2
         rA8n8gxbnoCRLJnF3f4M4X6yD5UFc/qJY+DWNHdgCfCq1EN4Mir2DI47um2uqnXKDyyS
         LQDw==
X-Gm-Message-State: AOJu0YycU+wCi2Ivwpr1gE1DqxseBsd+yF2TCQ2YwmIlTwaiTLbcpZYv
        1il+9eLqIcTBN/3ienT4v3pdtEXs2AU=
X-Google-Smtp-Source: AGHT+IGRnRlHz9ycOwplwkvnFbkqexspTRxCaYtSS6ST+LLd9YaU8M7qGFIoU8ZkEvIigFIKIA6K1w==
X-Received: by 2002:a05:6a20:1448:b0:132:cd2d:16fd with SMTP id a8-20020a056a20144800b00132cd2d16fdmr15406140pzi.38.1693962115871;
        Tue, 05 Sep 2023 18:01:55 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id c22-20020aa78816000000b006883561b421sm9628358pfo.162.2023.09.05.18.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 18:01:55 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 3B2ED81A82C1; Wed,  6 Sep 2023 08:01:52 +0700 (WIB)
Date:   Wed, 6 Sep 2023 08:01:51 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Brian Pardy <brian.pardy@gmail.com>,
        Linux CIFS <linux-cifs@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Steve French <sfrench@samba.org>
Subject: Re: Possible bug report: kernel 6.5.0/6.5.1 high load when CIFS
 share is mounted (cifsd-cfid-laundromat in"D" state)
Message-ID: <ZPfPfyIoVxw5L6El@debian.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4rKL3SGhEKB4JeVE"
Content-Disposition: inline
In-Reply-To: <CAO+kfxTwOvaxYV0ZRESxZB-4LHsF9b_VBjAKahhwUm5a1_c4ug@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4rKL3SGhEKB4JeVE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 05, 2023 at 01:09:05PM -0400, Brian Pardy wrote:
> My apologies if I do not have the bug report protocol correct in posting =
here.
>=20
> I've noticed an issue with the CIFS client in kernel 6.5.0/6.5.1 that
> does not exist in 6.4.12 or other previous kernels (I have not tested
> 6.4.13). Almost immediately after mounting a CIFS share, the reported
> load average on my system goes up by 2. At the time this occurs I see
> two [cifsd-cfid-laundromat] kernel threads running the "D" state,
> where they remain for the entire time the CIFS share is mounted. The
> load will remain stable at 2 (otherwise idle) until the share is
> unmounted, at which point the [cifsd-cfid-laundromat] threads
> disappear and load drops back down to 0. This is easily reproducible
> on my system, but I am not sure what to do to retrieve more useful
> debugging information. If I mount two shares from this server, I get
> four laundromat threads in "D" state and a sustained load average of
> 4.
>=20
> The client is running Gentoo Linux, the server is a Seagate Personal
> Cloud NAS running Samba 4.6.5. Mount options used are
> "noperm,guest,vers=3D3.02". The CPUs do not actually appear to be
> spinning, the reported load average appears incorrect as far as actual
> CPU use is concerned.
>=20
> I am happy to follow any instructions provided to gather more details
> if I can help to track this down. Nothing that appears relevant
> appears in syslog or dmesg output.

Thanks for the regression report. But if you want to get it fixed,
you have to do your part: perform bisection. See Documentation/admin-guide/=
bug-bisect.rst in the kernel sources for how to do that.

Anyway, I'm adding it to regzbot:

#regzbot ^introduced: v6.4..v6.5
#regzbot title: incorrect CPU utilization report (multiplied) when mounting=
 CIFS

Bye!

--=20
An old man doll... just what I always wanted! - Clara

--4rKL3SGhEKB4JeVE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZPfPegAKCRD2uYlJVVFO
o4xSAP9MTEw9rpwNO2GX2ldlyf6tZs7LUFf/8V5oQauTdsPQoQEA7E5sLnGg02jT
O2+azRU4Z7PkAoBG++gly3dnBnx2ggo=
=cr2w
-----END PGP SIGNATURE-----

--4rKL3SGhEKB4JeVE--
