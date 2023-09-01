Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD53078F8DE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 09:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348446AbjIAHDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 03:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjIAHDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 03:03:02 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C78510D2;
        Fri,  1 Sep 2023 00:03:00 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68c0cb00fb3so1418127b3a.2;
        Fri, 01 Sep 2023 00:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693551779; x=1694156579; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g8wr24to/gtJqJwr7CdrwRS9mfHBCNBSTGsrr1PkE30=;
        b=Avh+46pFYIpSDZqKE9qT1yn/OoLmY6YVZRSi/1BoU+WLD/1kJOqcTzevLhy6Gkd9DT
         UZ2dnT91L6/iMpnGw7CdOZhoR8jYxPZ1hUMi6fURRdBZZ9RVGOz6+u5arQpPj/3oP779
         Zu0zga144I9t08se7ZGOsP+UPc51v4SPP54bn/LXAbWkA8a6ZiBC406RxH1qeLQj/BRS
         fJZC3QcTKwx7OwxAUdnj9uYb66vLuyoTrOlWUhUVCAHO8hDQddlJC/DWRDBRV7I2AP/8
         KLpssmMHcT2BK50DTYA7aJy7mJBmNary+WAVXbRg5LihzSC93siK+UEe73hfYiYoAsO5
         Gu2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693551779; x=1694156579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8wr24to/gtJqJwr7CdrwRS9mfHBCNBSTGsrr1PkE30=;
        b=HtXNilnkcaAjDCjUbOyIw9QHw8ZRVEAXIUkVsDDw1x23Qj0nILo3rNk0j2arYpVEDg
         uOkbiVkXa45GtS8VJpIWYr9i/6EEjiW00Ym+lClBYaZSYWCzO3HJV0pavACXnQINZ1KT
         BqSPpdyn0GvlW1NLyq5EFG2/jn5rzLdzPRJXDRHolfwl9SB/mShDL4ciuZUWRJHylh4B
         hUDUeliUripqG/mbUcykJaZLciX1bQTucJIAotkhjvSduhIhAVjK6rD4PrpB8xJ69AI1
         W9VGRPuChA59qRC/Iuhq0vHVwduVBaY75pDCuy8a1nqs0mqICpZdi2v2jlAezVZeIUGU
         Obcw==
X-Gm-Message-State: AOJu0YwJylGkwE8neW6EjtredgDN/OFtk/9RU9uAHnB8AR1i8nDZUFCk
        oPHA+B1EdYlrohA7baAwY4I=
X-Google-Smtp-Source: AGHT+IFH62BQFrdwj6BomF4htUKGs5yvT3G/DWOQ60wYI1H0qhLDmCweZYjyFwA9jl5MEse1SfZ63g==
X-Received: by 2002:a05:6a00:189e:b0:68a:61a9:7e43 with SMTP id x30-20020a056a00189e00b0068a61a97e43mr2047516pfh.29.1693551779208;
        Fri, 01 Sep 2023 00:02:59 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id c5-20020aa781c5000000b0068a3dd6c1dasm2378796pfn.142.2023.09.01.00.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 00:02:58 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id C2EF18F03D47; Fri,  1 Sep 2023 14:02:50 +0700 (WIB)
Date:   Fri, 1 Sep 2023 14:02:50 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.4 0/9] 6.4.14-rc1 review
Message-ID: <ZPGMmjfiMKt1jMAL@debian.me>
References: <20230831111127.667900990@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="L55yot6n5WpZHRsh"
Content-Disposition: inline
In-Reply-To: <20230831111127.667900990@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--L55yot6n5WpZHRsh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 31, 2023 at 01:11:27PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.14 release.
> There are 9 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--L55yot6n5WpZHRsh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZPGMlAAKCRD2uYlJVVFO
o7nKAQDCT2WUu7n/CoP/jDSM6zFSNP5PklxV3TlWaCgqiYdftQD8CvqE67J686xO
TKeWBGHuncY0L57Qi+O1X8LR73IUUgw=
=7eRH
-----END PGP SIGNATURE-----

--L55yot6n5WpZHRsh--
