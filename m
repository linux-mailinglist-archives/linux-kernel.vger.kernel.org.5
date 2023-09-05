Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94ADD792A9D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244398AbjIEQkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348511AbjIEEnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 00:43:39 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2521B9;
        Mon,  4 Sep 2023 21:43:36 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-563f8e8a53dso917479a12.3;
        Mon, 04 Sep 2023 21:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693889015; x=1694493815; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J0V2FgytkL6qM48rXQ4oVsdXH0Mo9LDUYeEyaMnuyp8=;
        b=PSz090PlTguY8CdCTjFVbe+kRuf3TKPKoiG/6wml6O2Vxqq34n6n6QdR8XRB2eXLJT
         6mkQ8FXnKZyJhgX8lo3xavk0nEl6ZupAI8EGvAENEI2t6goxBI4i6JsAqHONRN9kAX1q
         IwU2OJ9Ch5hdm4JL6RFK4aDZfwd9l7dn7gaf2lJeOwaFFZ0quK89ADQEutwu9ZhxWH2K
         djg8jq64gIl53Upi+7XtFFCnM4Q7JKovvYj3eWx9VJxOarYy9mm+g1vO7JwNS9BQYcMC
         BBMpQAPYWB97XXawoQyUOVLEngsGIBJByKY+hkBMYCG3ZZWNpXFsLpvJ7ZacmrW/P2zt
         ZVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693889015; x=1694493815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0V2FgytkL6qM48rXQ4oVsdXH0Mo9LDUYeEyaMnuyp8=;
        b=S8fL597HjtpVtQxm7TCBu1E0MURl34IqK3rX6x5z8yeZAXC7XSbHv4ZZoIzdevSLGK
         HCGcXNs7LTE0I731iUdX/qmmZi+Nxp2nUIRf4DNL3qAPRBLdq9u4tAYngbsvj9xd+1Cc
         9iXWOBuNxffdCA96nUMnwowMZpldvf8BrtWuGkh8sN8q4pB9BmKbNP7XYbQdNy4pn4c7
         cLX5DaIWLIA4ChbxasYUWK79H1m7dFNwc/HS/DBNUwfkfx2WPzkIlyQUbmAvfhlGy10M
         36zjl17Axj6jnVfOmFe/mHMmnCiXrFV92rX+2P0xSG6fGnaHaqLufxherDAkIfBXUkvI
         AwDg==
X-Gm-Message-State: AOJu0Yxab9n/cBiN3MoI3FMS96ZRUld4k50PXcGHgJL2j9g+eiNDxPRr
        v9l89Pq2em9PFA6CpHxs9CA=
X-Google-Smtp-Source: AGHT+IEnU+MIeffFTI+Kg7b5FgdzaHIO67u2BytPQHqVVH4istZfGmO7HzXkoOlBjNODUrLKv9bTZw==
X-Received: by 2002:a05:6a20:9183:b0:13d:bf07:7444 with SMTP id v3-20020a056a20918300b0013dbf077444mr11402794pzd.0.1693889015324;
        Mon, 04 Sep 2023 21:43:35 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id jd5-20020a170903260500b001bb8895848bsm8343417plb.71.2023.09.04.21.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 21:43:34 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id AE2B180E14C8; Tue,  5 Sep 2023 11:43:31 +0700 (WIB)
Date:   Tue, 5 Sep 2023 11:43:31 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.5 00/34] 6.5.2-rc1 review
Message-ID: <ZPax8-wQGxLMxvoE@debian.me>
References: <20230904182948.594404081@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qNCG87IULPT+hZbQ"
Content-Disposition: inline
In-Reply-To: <20230904182948.594404081@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qNCG87IULPT+hZbQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 04, 2023 at 07:29:47PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.2 release.
> There are 34 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--qNCG87IULPT+hZbQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZPax7QAKCRD2uYlJVVFO
oybNAP9b3aeerA2Jw6GE3bfYmmvJe3AZQr3cxuCDeO2GjA3oogEAlqQ+B3O+QO7L
PZQSgZb1Syhhsw2JsbO4jDiA9ry2RwU=
=pT0D
-----END PGP SIGNATURE-----

--qNCG87IULPT+hZbQ--
