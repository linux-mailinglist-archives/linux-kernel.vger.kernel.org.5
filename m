Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B61E7FE4AC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 01:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjK3AOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 19:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjK3AOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 19:14:53 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C0A198;
        Wed, 29 Nov 2023 16:15:00 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cfc985c92dso4077365ad.0;
        Wed, 29 Nov 2023 16:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701303299; x=1701908099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XgvvqXVzaotAd/CUGNZ9LYCSCzLytzyYCTwTYlrlctA=;
        b=KQGHoRNv1zqU+7CSfCiTtRZxVLCWYlAbDSGyVqbsUnAYnFQzZJFEVjHuJBKyKM4P/Y
         wPNLd/jgLpUFxQIcTu2ycRVPEOMeSGMi8rOEqRKbllQ3Y7qnmC1UzS4+X+xWtE2mCqAi
         e54UOcas9uZPJKN1nv5kV6mwPPkJEfCgpwGMGx6BSLImsHcrl5uez+Hh8V+/BGPAESl9
         qFhGlmfGWjyjZU71wiP4GxxsSPTB2QlgWIzDlumj2SQegEFW403RGfE57GUwY3IoKiHF
         igmDPDFGafXZEJA0WZWpFH2uxHBo5S7WYzcwGnCGBqGmn5IBy9iKdYISARXguTxxKLRo
         IlYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701303299; x=1701908099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgvvqXVzaotAd/CUGNZ9LYCSCzLytzyYCTwTYlrlctA=;
        b=iICjqGO9mcYzz2QtYL4SAtrAS/z+v8JfPPPeQy2WgJvnvvOTrwb0vsvWoeM730ucqU
         72XoJBesiyc3p4PIQQYohppEfR4dD5IolBTfUnM+YrfdezuFLCJ4/EhZtCt5JF1SgjCs
         kW/AIyyw+EiD9gE4zIhDmoTxmauGlridMbxaQWy8al0luDu091RjidspFhsS0k8bTL50
         hFaFLJ0Uradtxo3IH4ATb8IfvpKuPkI5aYpM6t7MxdaORrB5epIGaokOxko8ZUikyDPU
         Pc2+QLBJ1740xyUOtSP/6AhyGL1Sp+1m2OiCuENoiqknHRPUraGa77LvfJ6KzDSrivPm
         htuw==
X-Gm-Message-State: AOJu0Yzs2rvLGxDkrvMWQOATwwyoNO353lbn9QgANYj/KJo/V83A5XY5
        0AnQ+4flBMP8+v2ZmilndPM=
X-Google-Smtp-Source: AGHT+IFwHg0L3OUXQxPg+VlrpT+ok8Fz6c75w7NizeaLFuDwH+tx1tPdaci9ZvywrMgQSACrcdGXsQ==
X-Received: by 2002:a17:902:e54e:b0:1d0:8b5:495a with SMTP id n14-20020a170902e54e00b001d008b5495amr6670307plf.16.1701303299432;
        Wed, 29 Nov 2023 16:14:59 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id a2-20020a170902ecc200b001cfc2d024edsm7761146plh.29.2023.11.29.16.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 16:14:58 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id B82BF1141356B; Thu, 30 Nov 2023 07:14:56 +0700 (WIB)
Date:   Thu, 30 Nov 2023 07:14:56 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Attreyee M <tintinm2017@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Livepatching <live-patching@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Chandan Babu R <chandanbabu@kernel.org>
Subject: Re: [PATCH 0/2] Minor grammatical fixup for livepatch docs
Message-ID: <ZWfUAIoVPr6Q9UrD@archie.me>
References: <20231129132527.8078-1-bagasdotme@gmail.com>
 <874jh4pr8w.fsf@meer.lwn.net>
 <ZWdYGrhTYFzG5BZq@casper.infradead.org>
 <CAJjsb4r5S80ZqdX3EnucSfeiyeFEgUOW+5++=XG4rT85Os4PNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d7kgRwf6ihSX4QqA"
Content-Disposition: inline
In-Reply-To: <CAJjsb4r5S80ZqdX3EnucSfeiyeFEgUOW+5++=XG4rT85Os4PNQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d7kgRwf6ihSX4QqA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 09:07:01PM +0530, Attreyee M wrote:
> Respected Maintainers,
>=20
> Please give me some time to make the changes again.
> I will be making the changes in a day.
>=20

Please don't top-post; reply inline with appropriate context instead.

OK, see you in v2! Don't forget to Cc: me in the v2.

--=20
An old man doll... just what I always wanted! - Clara

--d7kgRwf6ihSX4QqA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZWfUAAAKCRD2uYlJVVFO
o1mQAQCOs/lC5kuZXvQVzRGqArCgu0KlQlFujgdaTKEkmYs2tQEAsL3D4ZwC7ev3
R34c9GpmKdwgPGhJFXXpfcHOkId8QgU=
=r3tN
-----END PGP SIGNATURE-----

--d7kgRwf6ihSX4QqA--
