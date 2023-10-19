Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9D57CEDB5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 03:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjJSBtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 21:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJSBtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 21:49:41 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85242EA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 18:49:39 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1caa7597af9so9719275ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 18:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697680179; x=1698284979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zV9Bywdc3aRFDA88z0jrbXAuFyFMIbOS+orYblKsymI=;
        b=h/WmKoyQ5pbfHmxA7xcjYMQLz/IhvoYYtmS2E9zKAepNKZT/QHRCULBBlCtIg4+8Zu
         W6W+QfzA3ahpvg0nycIZdymeKnmcTh9XwjuACTIwnvyJEECKCG3VPUxEgtetseK+gnj1
         egSM+LZxB+XqLrK6StjwzXUqQIE71Vt6vJVGPvmJp9kCwoGou8rDBKSKlX00K/Oah2sF
         I7c35oRicJXr3Rf+kbSub0OPJYBkh/Mn6K6SKbpCsUjzSSf1QHyOUUx+tiVXVzyOoLao
         FVo33Agc3LzP24ihGptTASDosXueLPQZwFQN38UbODv9h/o2pKu/QU/1kQZGwxn29CDZ
         9kWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697680179; x=1698284979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zV9Bywdc3aRFDA88z0jrbXAuFyFMIbOS+orYblKsymI=;
        b=jbExwqPMfFW0Dc0yoHlkYFEqc4sAeugm7CUGpZjX2sMvHlUejVKFsi+J+ngRJEZiQ/
         yYreB7GrMdg3DSpGZ6G6HIVHjzi+U3/hz/dTsNOPWAiu01NbBQ7QfPZo+Dn7f98VEt3h
         2G3Vb9aAOgCceVpX+c4sKDISWsOqqtTJUxpqUF+7bn6M7lwINImKUV2MKZyNJoqiWV/m
         KYTqqjjvbtVsdd50wiqAdXK4aByWX8x44fKHEi3swSbEpSl20BdEkhA31DaDSiQDPNxv
         ErlqgTDTGcLF/FTbPJEkNTNDq85/oKIh4VvQhPNy56NYTrxiHwV+HkOM9CvOVXYwSKuH
         J2yg==
X-Gm-Message-State: AOJu0YxWcijuAGw6SF46QyeEV1srL+B1vZyFYKR0ixqVCmEplFKm+6/q
        VjoD9ZAnrqPMZtCy9jWS1qz1J6+wgXY=
X-Google-Smtp-Source: AGHT+IF4mXeJTKOYwwb36BKBwYbkSCmIIJz8Rp/Or5XNOFOpj0scYIf8hCHFxlp31CCwQCJwCQK46Q==
X-Received: by 2002:a17:902:cec8:b0:1c3:2ee6:3802 with SMTP id d8-20020a170902cec800b001c32ee63802mr1112862plg.47.1697680178801;
        Wed, 18 Oct 2023 18:49:38 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id q24-20020a170902789800b001c0cb2aa2easm578974pll.121.2023.10.18.18.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 18:49:38 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id A8B748A3D5BC; Thu, 19 Oct 2023 08:49:34 +0700 (WIB)
Date:   Thu, 19 Oct 2023 08:49:34 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     James Dutton <james.dutton@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Justin Stitt <justinstitt@google.com>,
        Calvince Otieno <calvncce@gmail.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>
Subject: Re: Is strncpy really less secure than strscpy ?
Message-ID: <ZTCLLinnaqIILXsJ@debian.me>
References: <CAAMvbhG40h6pqSf91BurDHQqeoKfP30bwnpvSDRHBN4Hoygqew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tKwvtRMdeA05vy2V"
Content-Disposition: inline
In-Reply-To: <CAAMvbhG40h6pqSf91BurDHQqeoKfP30bwnpvSDRHBN4Hoygqew@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tKwvtRMdeA05vy2V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Disclaimer: I have little to no knowledge of C, so things may be wrong.
 Please correct me if it is the case. Also Cc: recent people who work on
 strscpy() conversion.]

On Thu, Oct 19, 2023 at 12:22:33AM +0100, James Dutton wrote:
> Is strncpy really less secure than strscpy ?
>=20
> If one uses strncpy and thus put a limit on the buffer size during the
> copy, it is safe. There are no writes outside of the buffer.
> If one uses strscpy and thus put a limit on the buffer size during the
> copy, it is safe. There are no writes outside of the buffer.

Well, assuming that the string is NUL-terminated, the end result should
be the same.

> But, one can fit more characters in strncpy than strscpy because
> strscpy enforces the final \0 on the end.
> One could argue that strncpy is better because it might save the space
> of one char at the end of a string array.
> There are cases where strncpy might be unsafe. For example copying
> between arrays of different sizes, and that is a case where strscpy
> might be safer, but strncpy can be made safe if one ensures that the
> size used in strncpy is the smallest of the two different array sizes.

Code example on both cases?

>=20
> If one blindly replaces strncpy with strscpy across all uses, one
> could unintentionally be truncating the results and introduce new
> bugs.
>=20
> The real insecurity surely comes when one tries to use the string.
> For example:
>=20
> #include <stdio.h>
> #include <string.h>
>=20
> int main() {
>         char a[10] =3D "HelloThere";
>         char b[10];
>         char c[10] =3D "Overflow";
>         strncpy(b, a, 10);
>         /* This overflows and so in unsafe */
>         printf("a is  %s\n", a);
>         /* This overflows and so in unsafe */
>         printf("b is  %s\n", b);
>         /* This is safe */
>         printf("b is  %.*s\n", 10, a);
>         /* This is safe */
>         printf("b is  %.*s\n", 4, a);
>         return 0;
> }

What if printf("a is  %.*s\n", a);?

>=20
>=20
> So, why isn't the printk format specifier "%.*s" used more instead of
> "%s" in the kernel?

Since basically strings are pointers.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--tKwvtRMdeA05vy2V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZTCLKgAKCRD2uYlJVVFO
o9/jAQDxz8zc/tgvMo6cWqte0hMIsNfZEoiluRsauKgj8HXQtAEAmY6JIt5OKSZH
EhJ0mAM4hbMXWaYEBQCjwwU045aB5wo=
=Frs5
-----END PGP SIGNATURE-----

--tKwvtRMdeA05vy2V--
