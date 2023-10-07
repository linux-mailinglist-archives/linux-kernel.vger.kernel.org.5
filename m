Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC8C7BC84C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 16:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbjJGOOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 10:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjJGOOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 10:14:33 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9290B6;
        Sat,  7 Oct 2023 07:14:32 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-69101d33315so2483490b3a.3;
        Sat, 07 Oct 2023 07:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696688072; x=1697292872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QbaOkN11ShFjp3tT/ZrL3/V4ETkntY0iC/qweNkeDQE=;
        b=Cbnq2JQGcy5g2I4zwkXkAHvIzJXGP+UZxZ6gA7hHMsKK7j8ZRZQ/Z6dEhH+W1hfkss
         bfQH9dAdsEW/Ke6psstGn8mHVoj3B3kyJoSXhgmwkhbDcdg6TsqsttHFuUMHJwZn//wb
         gTCcdlKlq0BX0etqU0BbYURziFaP8HR8YNFlOlL2c3qKms/GeSlzmeHJkD3O9pVk4hS7
         ZPnS1zK649KEN5ztjoTPprwL7MZmDKCp27RHg+jLn/Gh7+BK9rAd9zdx0rQ0mtAvP7e7
         RBaeYrddw6MOZr2ouYR6pT6SQO2tqGyEmF8LeP4jVmuGi7x7cBJJhy07BA9wRR8N0U3n
         uSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696688072; x=1697292872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QbaOkN11ShFjp3tT/ZrL3/V4ETkntY0iC/qweNkeDQE=;
        b=TXZtLbZ10GXhjxG7+qv+MNznB39XnINgelxiJpOxeuYCWYaFHM3l3dofXKPgwlEUOU
         tUz2TNHJ08PKE/iQI9FiJn8T+SqY0goVsirjr/fbRPAGsElej4FfuiPCzacAgkdttH31
         eaZc+5vhwtiZZZDUo4h0QtOAAC7qkJQHKlA/nVSvBpl4XUjTc8IFrOYB3LsW8K2E9g15
         hnQdOHYbElTpeHf5dL5B1QsQcUXLs/b72SS3MXEfV4XNQshXdbhsRdfTsxSwQarBuu6H
         pjnvovo/3WdeZWKxtXJINNhrRkuwadpIiXIBxvwXK70xjuHsrFzW12xUh3QxLBvVwKjN
         XVqQ==
X-Gm-Message-State: AOJu0YxoXJsAnXRw1fHWqANUKSDNx8Jay7FiwQtzjC+FXiw8JfysT3IC
        91dZfsziRvDJBl+fjJYDsmt3PSYlbt4=
X-Google-Smtp-Source: AGHT+IE1R8llrP0TWOY82g3RLZePSlPEl4OgvLzr13DUw8DNopmWh1YqFvllsyWFlIxDOLYj3zMKxw==
X-Received: by 2002:a05:6a20:7f83:b0:15e:b8a1:57b9 with SMTP id d3-20020a056a207f8300b0015eb8a157b9mr13659474pzj.24.1696688071887;
        Sat, 07 Oct 2023 07:14:31 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id z9-20020aa785c9000000b006926e3dc2besm3227082pfn.108.2023.10.07.07.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 07:14:31 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 1E08481C636A; Sat,  7 Oct 2023 21:14:23 +0700 (WIB)
Date:   Sat, 7 Oct 2023 21:14:23 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Calvince Otieno <calvncce@gmail.com>,
        Linux Outreachy <outreachy@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kernel Build System <linux-kbuild@vger.kernel.org>
Subject: Re: Unable to make file
Message-ID: <ZSFnvwvXMiisHOJ7@debian.me>
References: <CADFX3OQ1rdnR=ONu5wufAYN0NrvMkaveQ_Y9z_1K8m9Dzz3SPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8tSXnb0WXi8G6rnk"
Content-Disposition: inline
In-Reply-To: <CADFX3OQ1rdnR=ONu5wufAYN0NrvMkaveQ_Y9z_1K8m9Dzz3SPA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8tSXnb0WXi8G6rnk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 07, 2023 at 04:50:32PM +0300, Calvince Otieno wrote:
> Hello team!
>=20
> I have a problem. I tried running the Make file and I got this error mess=
age:
>=20
> make[3]: *** No rule to make target 'debian/canonical-certs.pem',
> needed by 'certs/x509_certificate_list'.  Stop.
>=20
> make[2]: *** [scripts/Makefile.build:480: certs] Error 2
>=20
> make[1]: *** [/home/calvince/Documents/labs/git/kernels/staging/Makefile:=
1913:
> .] Error 2
>=20
> make: *** [Makefile:234: __sub-make] Error 2

If you need to keep your modules signed, you have to generate your own
certificate. See Documentation/admin-guide/module-signing.rst in the kernel
sources for how to do that.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--8tSXnb0WXi8G6rnk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZSFnuwAKCRD2uYlJVVFO
o0OkAPwPchkMkTBT3AxCpEroXdS8Ox5JUG6RzzP/QodpsAkSDgD/ToBsBxmcybnx
mg6cl2QWRnmmCE+rKF/nEOfGni+HLA8=
=5xRX
-----END PGP SIGNATURE-----

--8tSXnb0WXi8G6rnk--
