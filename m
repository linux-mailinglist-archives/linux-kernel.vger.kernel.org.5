Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8936D793374
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 03:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238192AbjIFBni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 21:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbjIFBnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 21:43:37 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C991B3;
        Tue,  5 Sep 2023 18:43:34 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68a529e1974so2076628b3a.3;
        Tue, 05 Sep 2023 18:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693964614; x=1694569414; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuAvo1OT8MVuKgjI6ukMWZxsj7IgNKAT9aZUnqZFr+M=;
        b=HWDKeArknQ8lKh4B5IlikzudXXAU/+hd4x5blE+B4duwznr4rX3c0dwnVrHGsK4dYM
         upDDC/HFGkvUHjPC+kpOdpSiHGkRuW911lDPQr9oXN8/KvejaeYzav0KbvGdzPpC10rV
         0zll7m0WPzpDfGXdYpSEC6//hgfZrBIrTSJg7OBGlhQSeP4botSLHS2rbu+cHrwK65KB
         0Ii889PpkVb7jlPcKxXw2SZwsprYv4Y4S2Df19xVHrggJhNrY4ffSVbvubGw8OpZVgPh
         zouxvsriskLiYJkuhkXBavzr8V9vAvT2CxF0rOJ11ri+wjFpfc0ZxNE78L02CIg9/uFG
         6igA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693964614; x=1694569414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZuAvo1OT8MVuKgjI6ukMWZxsj7IgNKAT9aZUnqZFr+M=;
        b=QpdOT1eSGMw5OqrtbY7se1XtOHvWYwptKWNFJsovQVqHQkS+x1Fd6Lvh4IJIkfvF0n
         /eCuJCtXPuHGk2Kjqyc78C0hRR+CgMVMn/konBig3f7hEwS11oLiHwdQ+3gtYOCT6Rb4
         eJE+hG9ESRX7XsG3dIe71OGvBgYEblRXLHOibP3Z63d1sxrXbri1o8VzO6WTsE0MAJcY
         UpKVy9edAXt2/cON93OXD7OaYK2PFmHJknB+xqTBzM37azAQ39C1D/4OPoxTlE+186Kk
         eo3thv7m6XEQI5XF9t4N3SDhBqvA6w5JAOU785nQKtXs0TBB9UywAFoS9sRJar08i82+
         ir8g==
X-Gm-Message-State: AOJu0Yw/pMWx7H/b3aKhrFH3X7JI8GSNZiIC2UdfDxTYGzRLNRWsPm2y
        jIb2HW2Tp13WRTg2LyBpMuc=
X-Google-Smtp-Source: AGHT+IFJJjPDphBBacjDJiqviaz4pVna35tTXOevm3qYLzXqSDsvWahohLQ/fQC29TrRqgfpt1HLiQ==
X-Received: by 2002:a05:6a21:184:b0:153:353e:5e39 with SMTP id le4-20020a056a21018400b00153353e5e39mr2437695pzb.51.1693964613758;
        Tue, 05 Sep 2023 18:43:33 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id v6-20020a170902b7c600b001c0a4146961sm9935388plz.19.2023.09.05.18.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 18:43:33 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 69C1995FE069; Wed,  6 Sep 2023 08:43:30 +0700 (WIB)
Date:   Wed, 6 Sep 2023 08:43:30 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Sergio Callegari <sergio.callegari@gmail.com>,
        netdev@vger.kernel.org
Cc:     Linux Kernel Mailing list <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Oliver Neukum <oliver@neukum.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Regression with AX88179A: can't manually set MAC address anymore
Message-ID: <ZPfZQsLKG9LKGR1G@debian.me>
References: <54cb50af-b8e7-397b-ff7e-f6933b01a4b9@gmail.com>
 <ZPcfsd_QcJwQq0dK@debian.me>
 <6315027e-d1ab-4dec-acf2-0a77bb948807@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="scPX1xTjP0AyGKKl"
Content-Disposition: inline
In-Reply-To: <6315027e-d1ab-4dec-acf2-0a77bb948807@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--scPX1xTjP0AyGKKl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 05, 2023 at 09:34:53PM +0200, Sergio Callegari wrote:
> On 05/09/2023 14:31, Bagas Sanjaya wrote:
> > On Tue, Sep 05, 2023 at 01:02:22PM +0200, Sergio Callegari wrote:
> > > More details:
> > >=20
> > > - before the kernel changes, the interface was supported by a dedicat=
ed
> > > kernel driver. The driver had glitches but was more or less working. =
The
> > > main issue was that after some usage the driver stopped working. Coul=
d fix
> > > these glitches with the driver at
> > > https://github.com/nothingstopsme/AX88179_178A_Linux_Driver
> > Did you mean that you use out-of-tree module?
>=20
> I mean that with kernel 5.15 I could use the in-tree module with some
> glitches (interface occasionally stopping on teleconferencing) as well as
> the indicated out of tree module with no glitches.
>=20
> With current kernels (certainly from 6.2 on) manually setting a MAC addre=
ss
> breaks the interface. Furthermore, even if it compiles and loads fine, it=
 is
> impossible to use the out of tree module because it does not create the e=
th
> device anymore (the eth device now appears with the cdc_ncn module). Being
> this an out of tree module, this is not very important, though.

Then can you please file issue against your external module on that
GH link?

--=20
An old man doll... just what I always wanted! - Clara

--scPX1xTjP0AyGKKl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZPfZPQAKCRD2uYlJVVFO
o//WAP4lyG53jKCrxpFwKR6vkhX9eKlN3PbxPE6IOf/+0JpEYwD/R9J0ekHq+OVw
fDL8cHsBGOk6KtZEFRJoTNbldcmwewc=
=YfY7
-----END PGP SIGNATURE-----

--scPX1xTjP0AyGKKl--
