Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B586777B0CC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 07:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbjHNFcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 01:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbjHNFch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 01:32:37 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C05F10D7;
        Sun, 13 Aug 2023 22:32:36 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6bca38a6618so3434059a34.3;
        Sun, 13 Aug 2023 22:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691991156; x=1692595956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HT+wJFz4od+UUfh/YvtmtCts/VmDgx7cr4C4A9Q7jmg=;
        b=EwaQFnf2fcDIRzLEbQGAEVFsxezZDz6nc57hFH7REtP1oB9L0AlxJiYL1+nQM1z+NI
         NifqZjgsRL95cnTnLKIPnAFyMYJRSCHF0csdUBdL2WThR8vx1Hm318GxLvPyAUSstMf8
         Z52JKjGAPrzEPz7X+89kfKvySoweEebA5u/569A74HKI+19C9TKe+ELhYRuDDqwzMLx+
         BmkTdufKzwKkJWBOuiKWdEWuL6ueuXUGMC+hA8FiNJNRkD8/I/CmCyXc5new/ThWKZJc
         H47wSZv11ldPpwc3Ltg5e55kh8JmXXNKkE221Ujtcd43ktSUrpxH5K/0ad6Q9TUQrcfG
         S2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691991156; x=1692595956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HT+wJFz4od+UUfh/YvtmtCts/VmDgx7cr4C4A9Q7jmg=;
        b=Pz+0kKXt/ij0+kJGuOXf0QlCuY2LqjmGF01ErDELBpkQ6CmlWmgnMRrZpoIbFOkcHc
         VXSYJhw0USJcMLO4mx15Ya1uZ0t2w+gx4WjWvjkW0QRMpz7ZCizL+TCh5LJRO8PDPW3n
         fZ1P63igiJ6W3gvlMjnf4ODOi4vJ6UU9WQ8OqQgcB9AHLCFqC9KAnJIsZSrR8hqrFpQw
         AQ1Roj+s4PJNYluz/un3vXuMoLZXl16xvFvc4EWZ4PD/DPo6t5Cnbd5TbXMOdKmjSWVD
         mImKoVX+hrtUCVcq7QvsJn9bFYVmEyBltH0N3Db7aybYz8vBb4SOme6GjzgURwomSn1r
         plwA==
X-Gm-Message-State: AOJu0Yw+FmNnJHXiixfHcOSwkRW41DK5G3VftmznR5aLn0VSsCkoK+GH
        1N1O+zBz6Au4XW2kvdHu0Cg=
X-Google-Smtp-Source: AGHT+IE0oT92e/iIz5YUsgN+ZDehbjY0Tt9twn9bkhTYZyq7jC+7Z/jGjA/owrcK2AaZQ2Np7Ytv2g==
X-Received: by 2002:a9d:6e87:0:b0:6bd:9fa:34ff with SMTP id a7-20020a9d6e87000000b006bd09fa34ffmr8198558otr.9.1691991155831;
        Sun, 13 Aug 2023 22:32:35 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id p14-20020a17090adf8e00b0026971450601sm7120844pjv.7.2023.08.13.22.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 22:32:35 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id E5C5A81A9BC4; Mon, 14 Aug 2023 12:32:30 +0700 (WIB)
Date:   Mon, 14 Aug 2023 12:32:30 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.4 000/206] 6.4.11-rc1 review
Message-ID: <ZNm8bm-jNi_nVRfL@debian.me>
References: <20230813211724.969019629@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5wtxyPoyzPwSJrdw"
Content-Disposition: inline
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5wtxyPoyzPwSJrdw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 13, 2023 at 11:16:10PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.11 release.
> There are 206 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--5wtxyPoyzPwSJrdw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZNm8aQAKCRD2uYlJVVFO
oxe3AP0Tpvt2lDrzyp0f73DoiSP+zPulKQ5fNMfbF2wJF1eiTwD/cw3g//u8xx71
16eyW3q2ydg5pb9rIcdLIIHJwwzZKg0=
=J+65
-----END PGP SIGNATURE-----

--5wtxyPoyzPwSJrdw--
