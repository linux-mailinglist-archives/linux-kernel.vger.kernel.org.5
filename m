Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0ADB789308
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 03:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjHZBYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 21:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjHZBXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 21:23:46 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D59E77;
        Fri, 25 Aug 2023 18:23:44 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bc8a2f71eeso11561465ad.0;
        Fri, 25 Aug 2023 18:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693013023; x=1693617823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=acKCK1DDVsUgCwVPQW4+BV+8s2HfSsnrUrjpFkgd9wk=;
        b=qZzFJ5Q5ESQ/8whIlhrjVp3nDjACHbnMZsluegvq6Ojinxc/067Osp2qbIlyw9OjoC
         GrRln/+N7K+EJ6CyNvvc+wOUkgfi4l1q64Ul9uSGNiBBZAVF8RivtDyeN7Ha+sTyJOaS
         LD/odcRNwB6O+gi1HjaHmDlF86++rjIJKEQ75ax2Mt4my1mA8ngmS7J7CH7ueAo62NGh
         rmJDnzO84abFyXgzrzbSc0TZ8HkmvG7Bk4tGOnSBPpvE0bvVIuhs9dluaoWv8GjcnWtM
         C3vb1aRCOnNEmeBc+8DIEHu3MJjtbU/oTaEjJwT/5Q+VpaLm82ujhnXu4CqBfchy1pUI
         SPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693013023; x=1693617823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acKCK1DDVsUgCwVPQW4+BV+8s2HfSsnrUrjpFkgd9wk=;
        b=Zc7FbcRMymg97Mw7AUcocgeUX9q5QxLhKWO1uqATH5tknS12IhXPHt/30Wk4gLJ68D
         ZHdpbUY5zsiiGwAGOeiAn0ZCGFFerLM4O4GHc8Znbat0atnUTnurgYy5HsG+RLq+uMX1
         KJug7NU3VYmSUsvlHuaWvKISXQDRmoRFmYlE5vRX6dw8NPwbcmi9vbb+7DPSNRdO0P8o
         59682bCTFlMNoOjHxgjs0CJ57pF4Khm+uxjIQFJ5KJissmZEYlmFPLwQmrOa9rGXAALJ
         SWdMT3Hjoqe3wQAER/C1eIFbmRYha0GyipDdJ7qTCntL+b//UT7k23RfU0Tdw34n4qoq
         uLEA==
X-Gm-Message-State: AOJu0Yxk16v//0sokfcGqaYBH9cFa+DKrnU/fjVTAfjnQch8ubxYEd2O
        iQ10E/lNdiMGeQQATML/y9M=
X-Google-Smtp-Source: AGHT+IH4NYnJm+tQgvR+rYaA45h9XoYuEpTCK8oT0lwl1wjhA9qrHf69HItpzuopdJJAAu87CUg0YQ==
X-Received: by 2002:a17:903:2642:b0:1ac:8be5:8787 with SMTP id je2-20020a170903264200b001ac8be58787mr14537859plb.21.1693013023425;
        Fri, 25 Aug 2023 18:23:43 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id z1-20020a170903018100b001bdb167f6ebsm2429875plg.94.2023.08.25.18.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 18:23:42 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id D2F5C82EFB85; Sat, 26 Aug 2023 08:23:38 +0700 (WIB)
Date:   Sat, 26 Aug 2023 08:23:38 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 00/15] 6.1.48-rc1 review
Message-ID: <ZOlUGhlro_v6cvo4@debian.me>
References: <20230824141447.155846739@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Nr1MUEtNaDq7pJ3e"
Content-Disposition: inline
In-Reply-To: <20230824141447.155846739@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Nr1MUEtNaDq7pJ3e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2023 at 04:14:56PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.48 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--Nr1MUEtNaDq7pJ3e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZOlUFQAKCRD2uYlJVVFO
o0YxAQCzDPWVI01UQ8OMk0c1w4/zdbNTbiH8jmHRdhQjtJBpzwEAj6mpdQtFZ0/5
1WEuBsFeXqk/B+fVxLzQRakwl/wcWws=
=AgPL
-----END PGP SIGNATURE-----

--Nr1MUEtNaDq7pJ3e--
