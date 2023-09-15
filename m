Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F130F7A17D9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjIOH4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjIOH4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:56:49 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F0AAC;
        Fri, 15 Sep 2023 00:56:43 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c328b53aeaso15808435ad.2;
        Fri, 15 Sep 2023 00:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694764602; x=1695369402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sa23m9Sh+czmtoCmVFBbzydEhVvJnPH9LtopoO7enGk=;
        b=JwhuK8y+7iv0ypni46TXh0EjHgRtvPEYOv1T5HePZESIWfe0SBo7Z0SOwpVT5O+BDZ
         r1iZCoxYRr+HoLtrt1ZWtXImxVrmZv4SFyThU/W7VJhwREoVt38LCv3MiNPD0CaM5hJv
         IiY9dIH2qGeyaP+nAYicC6VWZLU37C9C0KFNPW3nLPYGBISWnIcSvIluhC2Zy/sA6DEi
         ufczMxgKub+Kq0S4s4YGdcPZik1TwVtT2gd2gOg7Xx59xbWU6qqK42LhZ/wPY6moLi6l
         JitjGzYj+vapQCHLG/SZG6bLgek2/w6AyktzAynU5mmLfuE3g8mfiodA8XYvnCONQ/wU
         v6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694764602; x=1695369402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sa23m9Sh+czmtoCmVFBbzydEhVvJnPH9LtopoO7enGk=;
        b=FFf8vDC4m8P7o7Tj4ZUpEorNzplyObM7poTj70/ikXxg90a6MoMaAUbEsRhwcx25rE
         VhkdklLqE3z8ijNPMTcThLVfOwehIgocoT/4AEfLXhxCN/3J0c8VKMePT/7CDalkYtI+
         54zxOzBQHgS/YYKFflKMFrH9zRcpRgcVzQ7H+yW0qBgSOM/Ixpgw848h9f2DfkhJfgm+
         ziZBSfJ/UVR7Ty3xLzhohm+hSHSh6hjqnkiBoakReRU907r3OX2nHA8ifI3G+M1ho4b+
         Acz37ND4pyGsBYTORN1fDRfTF9fk8vvTUyfu6O7RbOI8uFV/lrzqsKPZgGkJxMXR49Vq
         VLUg==
X-Gm-Message-State: AOJu0YyF4KcVk4WUONeB02P7ueIDCjklt3h+XQXHKmcyN/MV8eowhJGl
        /klzt/F1g6kyOPjx17WfbcY=
X-Google-Smtp-Source: AGHT+IE9RcRJ910CnL7JvJNrqjoaC0IFvFSCZdBwD31Y9Swflcx2melRR4bsTZgiId84hdnlKqufcA==
X-Received: by 2002:a17:903:1210:b0:1bb:7f71:df43 with SMTP id l16-20020a170903121000b001bb7f71df43mr1107314plh.34.1694764602592;
        Fri, 15 Sep 2023 00:56:42 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902b28500b001bb750189desm2836147plr.255.2023.09.15.00.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 00:56:42 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 88F408AA8414; Fri, 15 Sep 2023 14:56:38 +0700 (WIB)
Date:   Fri, 15 Sep 2023 14:56:38 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     angus gardner <angusg778@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: Removed unnecessary parenthesis around
 conditions to comply with the checkpatch coding style.
Message-ID: <ZQQONo8biMWlCiG3@debian.me>
References: <ZQEKFR1OPoXGI2lO@midnight>
 <ZQERJIGOOeYxgX3E@debian.me>
 <CAC5tM5u8L50fAhReAmP0dqexSmv-PdZJKa_ES2hxZMp41MJjGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jzeagO5P9A3kQsYx"
Content-Disposition: inline
In-Reply-To: <CAC5tM5u8L50fAhReAmP0dqexSmv-PdZJKa_ES2hxZMp41MJjGQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jzeagO5P9A3kQsYx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2023 at 11:58:47AM +1000, angus gardner wrote:
> Thanks for the feedback Bagas,
>=20
> "Then checkpatch is wrong, " lol
>=20
> Ill double check my SoB.
>=20

tl;dr:

> A: http://en.wikipedia.org/wiki/Top_post
> Q: Were do I find info about this thing called top-posting?
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
>=20
> A: No.
> Q: Should I include quotations after my reply?
>=20
> http://daringfireball.net/2007/07/on_top

Also, don't send HTML emails as mailing lists reject them away.

Last but not least, this is the third time you do parentheses fixup, for
which Greg's bot said:

>   You sent a patch that has been sent multiple times in the past few
>   days, and is identical to ones that has been recently rejected.
>   Please always look at the mailing list traffic to determine if you are
>   duplicating other people's work.

Again, read all Documentation/process/*.rst docs so that you won't make
mistakes again as kernel developer.

Bye!

--=20
An old man doll... just what I always wanted! - Clara

--jzeagO5P9A3kQsYx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZQQOMQAKCRD2uYlJVVFO
ozABAP9f4cJ4x4CFW0UEkBJrggxsKLo1ON0XZG0LmZPzzQI2JQD/fEkTFsH2KkSP
z0qFevhjEpUHaH2/N4WS6Tya9TaUdwo=
=iIZ2
-----END PGP SIGNATURE-----

--jzeagO5P9A3kQsYx--
