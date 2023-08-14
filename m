Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3405F77B0B0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 07:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbjHNFLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 01:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbjHNFLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 01:11:40 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B551CE5B;
        Sun, 13 Aug 2023 22:11:39 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-686bc261111so2567034b3a.3;
        Sun, 13 Aug 2023 22:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691989899; x=1692594699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iS5ujCecDFIUzxz+IV8xt2xrQ12GiB8yH1eSZVE6mVM=;
        b=MV4Rx3q3FZw5Y31Gqgt1YqD7oaqBWve/q/nsuNvWSuAwD5pRkTKDu2+irZmBtvHGZk
         8zFlwhxyf5Tn48LsDqEappWQ9h/W0L+/KkxqrFOnjULJHkEhPsKWPU1oSBuguVNS+DlG
         R5vXmIrZMRfKN6sNy5Q+1f5dNNkzGZBpXn6tXS75v9KXW1MyXVtBNzQqXLGa9BhVIWny
         M/cd+8YM5gIIFR0Yr3tlHhgBGTZYx8MmpxpRyjz0ZSg2VN8ilHC1Ndzzkg2hI2fQs5KS
         MH0X0hd8OQ/cqeSpZgmpWFb8KASLYrhs15AhfbFzl9D3GsmwW2UySaBGKRcg1is7wpR5
         3j+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691989899; x=1692594699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iS5ujCecDFIUzxz+IV8xt2xrQ12GiB8yH1eSZVE6mVM=;
        b=jZaJxEhxMrH/mmOeLAHnMGacbuEbm4M6JmiGlpWTWJ6ev/mwAayS0oV8AQcc+iL8ZP
         jWDjXF+vs/A+zag+K2UocfcX8iPCjOYKbsUru7xT7hhSVS8QZ8bHyQvdGeM7AzDHI5aq
         cyuMCFmg0NInaP4+wn6smiSfXVycNE6CrG8kbq3RWwa4gH81vBhNeak85RNVMAIVNH1W
         IeQkZxwF7dVzITpQMNlnEQx/BixeFQfyKnAj00kpj42RkjmzFOjZCmu1MtjUHFJ4Z9kA
         RC3zV1Tez9Uh/5AjHKjIFjaQahvO3s+rFOk1iAb9w8UpjDkrFkjsRB1yFyOTiymjVpwP
         tPVQ==
X-Gm-Message-State: AOJu0Yy4EzTYPBQN9xKgKhqkfbT+D3GIu3Fm5NFpILzkS22brIhC6Mw8
        YpsLU5mNA9xdtldLskPQU3U=
X-Google-Smtp-Source: AGHT+IGsV1EisACfbNAqFykmulwHZC9mkdmV9etuV8GwaWRVwxbtOMJ0mGI37JzXbUISqLCsbsvOcQ==
X-Received: by 2002:a05:6a21:81af:b0:140:694:cd99 with SMTP id pd47-20020a056a2181af00b001400694cd99mr8052967pzb.44.1691989899205;
        Sun, 13 Aug 2023 22:11:39 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id l5-20020a170903120500b001b891259eddsm8259959plh.197.2023.08.13.22.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 22:11:38 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 0733E81A9BC3; Mon, 14 Aug 2023 12:11:35 +0700 (WIB)
Date:   Mon, 14 Aug 2023 12:11:35 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/149] 6.1.46-rc1 review
Message-ID: <ZNm3h5qz32YLJ40u@debian.me>
References: <20230813211718.757428827@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eLTOEWlQlkcoI9Lt"
Content-Disposition: inline
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eLTOEWlQlkcoI9Lt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 13, 2023 at 11:17:25PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.46 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--eLTOEWlQlkcoI9Lt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZNm3hwAKCRD2uYlJVVFO
ow3aAQDfCOHbAbZSjuJzkC3HZXW+HOIAwSXOJcuS6yknJ/+0GgD/RN2BDhB5xIe0
CTS5azA3dSd399oNCDhH1pgQ7usCNgs=
=sDjn
-----END PGP SIGNATURE-----

--eLTOEWlQlkcoI9Lt--
