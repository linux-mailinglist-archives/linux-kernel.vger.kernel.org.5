Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDD879DD94
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 03:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238031AbjIMBca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 21:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjIMBc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 21:32:28 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3D610E6;
        Tue, 12 Sep 2023 18:32:24 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-5733789a44cso3710090eaf.2;
        Tue, 12 Sep 2023 18:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694568744; x=1695173544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vq8SgHFXKS/TzFJSEmQtwxfAWXj6dXC3+mc9FsXzQZg=;
        b=J3CNpbC7FRbJefEBec8UWlsQjDcTEuiKYu0lkWTW+y86SBEmecHkjgOdXQf51lKmla
         pUxLluAEXD6lG1T6XLh3RlOwVsjFq1jkmYat40WMWUba1RCL6WL9KoNtYRLch0jQkZPl
         KR+tVWfYUB7enIlq/XZUuGWUaYom0r1iXznVjOqRp560EgszpIv/0zNU1jQJqGk6/aiR
         1UGSsWMfYewf7ap5x0FgbI+CkkRsj7MgGvB+yrlqL+pvgjXpjkbb3siEcBCroMAoQMaF
         4TJyT2yy7nTAkxVGIpR78OJPJn0V9lHJWG6t9/q+IuYjBaFUW9BKk8pRWtqPq2IvOJ2V
         Q0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694568744; x=1695173544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vq8SgHFXKS/TzFJSEmQtwxfAWXj6dXC3+mc9FsXzQZg=;
        b=xQAHU/SVoHsio+lvNZDcoDZ9LJypq7fVbfu2t45q/4zWYHTCNS6/+oBoUMSfd5sStK
         fE7ha506K/THFmWmAu/btYPXXkpTQXd059J7j/WGj+M7miMMAqwWPbxgilkIfXiMrXq7
         wS+qPJIrxq9IGZ+doE1QTsG+nymY545DH4nE+XLkgZYfYzApOlXAg2/UfpUyAeG7pSo3
         rDyq7sDgSV3+Iqd2LOkHpncCBRYlk+CAQQKD98krPk+Fim5qAKQxhzwryt/SVEKF6H1Y
         mVEyK+BHY25UCu307RlCeJUybt/9CCX8HqDXgJIx6y0SS03kmKxu/ytf5tNXeySwBrCj
         BtJQ==
X-Gm-Message-State: AOJu0YwrvYzfd1zoGHzpwNBPr0sdLVDnfLgoGKCsK03sdT1HGD/ooS8V
        MdF4hZiDNPrTf9etqdZEmAxjQqi2lac=
X-Google-Smtp-Source: AGHT+IEt/bNpU0mRtK+AR7hsEVoqnuNX7FLGK81vCmsCoUDqeDEL7zNOB7lGTmHbnmb1jDXtdgZqDQ==
X-Received: by 2002:a05:6358:2611:b0:135:3f5c:9675 with SMTP id l17-20020a056358261100b001353f5c9675mr1730097rwc.19.1694568743861;
        Tue, 12 Sep 2023 18:32:23 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id c14-20020aa781ce000000b00687dde8ae5dsm7997630pfn.154.2023.09.12.18.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 18:32:23 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 6773E89F3BBE; Wed, 13 Sep 2023 08:32:20 +0700 (WIB)
Date:   Wed, 13 Sep 2023 08:32:20 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Angus Gardner <angusg778@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: Removed unnecessary parenthesis around
 conditions to comply with the checkpatch coding style.
Message-ID: <ZQERJIGOOeYxgX3E@debian.me>
References: <ZQEKFR1OPoXGI2lO@midnight>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x1+FQVa4UDBiUUPt"
Content-Disposition: inline
In-Reply-To: <ZQEKFR1OPoXGI2lO@midnight>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x1+FQVa4UDBiUUPt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2023 at 11:02:13AM +1000, Angus Gardner wrote:
> ---
>  drivers/staging/fbtft/fb_ra8875.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

No patch description and SoB, so Greg can't take this as-is.

> -	if ((par->info->var.xres =3D=3D 320) && (par->info->var.yres =3D=3D 240=
)) {
> +	if (par->info->var.xres =3D=3D 320 && par->info->var.yres =3D=3D 240) {

Greg prefers explicit parentheses on complex expressions (see [1] and [2]
for examples), hence NAK.

Thanks.

[1]: https://lore.kernel.org/linux-staging/ZCWGOZqdH1kWtOEq@kroah.com/
[2]: https://lore.kernel.org/linux-staging/Y%2FiaYtKk4VSokAFz@kroah.com/

--=20
An old man doll... just what I always wanted! - Clara

--x1+FQVa4UDBiUUPt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZQERHgAKCRD2uYlJVVFO
o73FAQCZr9WVvTPdXrwCR23Z8ew/F2TTSZkLjZY6t94QNZFc4gD8CN1oD399IWU0
p9IhzWXKtA85w37Q5pwbRZUfvAEcmwg=
=8y2y
-----END PGP SIGNATURE-----

--x1+FQVa4UDBiUUPt--
