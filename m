Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4904479C72C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjILGtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 02:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjILGtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:49:03 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884259B;
        Mon, 11 Sep 2023 23:48:59 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68fb79ef55eso1979235b3a.0;
        Mon, 11 Sep 2023 23:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694501339; x=1695106139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=egRuiJfDe5zsNnCMEhNXnPwEU9c3Rzgfd0yVAigNkTE=;
        b=nCAjlzpPLpgkhIqMNztNlA4qYYt7GLxF9pVxgRbgyNhXr/aRTLNKUi2Lkkkxmew0W3
         ymzfF5okutB4lG4RXsClopM1G9kzBfeq4jB27C5bU8S066SLdxQ93AmN8t0UJT3KCOPG
         GRakq0XaqC3o6uga6AtJ2S17xL4myhRV8l030E8LLXoQ94HoBderotAVhJcsnWbtuZOI
         ywMK5iHxKebCaYbhIX+WAowpXNVNSnQbB7aF9fki9b/AlgfdePuOdezqmqXw91uNd8+n
         t730xWGH6EfFzWNhT9fTVyO8BofUbf8dTI51mOcVvCwktRZ8nr8TkpFuQLmq80Qg15Mb
         9Gvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694501339; x=1695106139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egRuiJfDe5zsNnCMEhNXnPwEU9c3Rzgfd0yVAigNkTE=;
        b=Q0LUaaujHoCbbco8kuImZT/ix0dtXoXQvMYH0fZ1umaJtOp7gPiIsDPvm9y3xqtiow
         TPZHkuIUE88ADCFcnNaWLrVt0SFtB7Lx+IPSupa2mCKPFigjDfb8DLWRTIYqrZlXTeSf
         M2Wu5oJTsn+Cgbg62MsEaJoCCnliegHqsOYTQvOkAI0IzFFK+IQMgslhX+X+ufGFWGCl
         Vvi/RmUOIjNQh6pdayJr8jh9ucAF0428K3vlPKf1Ye+H6IMUkV2JORtmz0b8gPnm/wOg
         ZMd1fZNc/OyS48dxvk5jHXP6rQ3sad0WglEsHNZvehIfPIwl6pZ+BizQl2evOycSRjCN
         hHwQ==
X-Gm-Message-State: AOJu0Yyv5NWaBI7pDYarQDXdidA3Y1jHR8AZwRTSE2EYsYDEyy9IzZ3V
        OrvTtOYdC75XBr06cTdEV34=
X-Google-Smtp-Source: AGHT+IHZNXXxz10UjN3OUcZ+rCkFGK2zC8NbdO7rAjwlTdOsnVuBO5qXRddf4ZQi6qTUBxZti6JieQ==
X-Received: by 2002:a05:6a20:748b:b0:12e:73bb:cbb6 with SMTP id p11-20020a056a20748b00b0012e73bbcbb6mr14299423pzd.14.1694501338925;
        Mon, 11 Sep 2023 23:48:58 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id f18-20020a17090ace1200b0025c1cfdb93esm6743862pju.13.2023.09.11.23.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 23:48:58 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 6F5BF821F337; Tue, 12 Sep 2023 13:48:53 +0700 (WIB)
Date:   Tue, 12 Sep 2023 13:48:52 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.4 000/737] 6.4.16-rc1 review
Message-ID: <ZQAJ1OF9rSj0pOmi@debian.me>
References: <20230911134650.286315610@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q8v7qVMLKC2EtWDZ"
Content-Disposition: inline
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q8v7qVMLKC2EtWDZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2023 at 03:37:39PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.16 release.
> There are 737 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--Q8v7qVMLKC2EtWDZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZQAJ0AAKCRD2uYlJVVFO
o1ptAP91vlwlzGp1gJEW3a6+TgTXjvtkwHSzi8htGS859bRTAwD8DsqodWS4uRt9
hBTd1d+GoVYgxZp7d8CBkbyuoi6dfQ4=
=PNBF
-----END PGP SIGNATURE-----

--Q8v7qVMLKC2EtWDZ--
