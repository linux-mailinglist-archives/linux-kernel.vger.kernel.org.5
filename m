Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8151379101B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 04:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350900AbjIDC0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 22:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjIDC0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 22:26:50 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6E0CA;
        Sun,  3 Sep 2023 19:26:46 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68becf931bfso453361b3a.0;
        Sun, 03 Sep 2023 19:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693794406; x=1694399206; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oqAXsZOZJGusCvu1li0lXtZ3vaqzYY4YZubTl2x2e2I=;
        b=SB73E3LzOH2eCaFz7wXJV2m0En1R6xZEFS7HMKmxEjBKzQ2K2EmTqTDXV3ABKJFYlg
         qG1JwfWw9CZacRhkeVWrtI25Ng/Zm5wWBQpgpOf56Trp4a0m7ukK5hII/F6Oaugy6/q2
         zNVzQly9dHeBv13qPcKlxV5Z3rL7RxmQxGXwWOgpvFU+sjXS9b03Mf6eC6/e9iy/r6ZK
         vCSoouI9MFOx6EF+cvKbx67ipxiCa1FPzP0JMD5bnMP61Z1Fvt1kh+jEGKnmg3M6eEfj
         +cTuh3WdxhiGsYHb9AYvIp/Ugtja0WKLGOEWdkFLBgzcOK6mZ42DR5LiXGQ9Yg359QX8
         41jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693794406; x=1694399206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqAXsZOZJGusCvu1li0lXtZ3vaqzYY4YZubTl2x2e2I=;
        b=Whe6KuIAVdtVNJwVxZcEPHMF9TdwSnuB1LU7LDSpAG88sAyxS5sK/3GBZgIPpVyrko
         xewDT9sFMaI3XszOThBLEFBnoqU+HRRKEeOl+djyTvvkJBL275BrWcRw8Q03OUfL7gZ1
         beu2fi3PvSkrIif7YLrUeO6ebo4wnMtoR1obHGCa9bYM0vGbFlpHxoIHh7FrzeeWAlB+
         +Dvwz/4+aw9G/ziwl5sKxv1pgX/VsVkydmpebZZjcdzSOLRPhCsFSZDctzhMzek38x1r
         VzCk/w00Jx/zrUmqKBYTay2iSom7VEp4oslLQxRn1PCwHVYsKeTYBwigyFoxNmjGY5+T
         5mDQ==
X-Gm-Message-State: AOJu0YyQwPDh3yWsG7L/mMMAq9qJEg4l9WjEIQRg9kfo7wdbfEl4sik2
        b4p+hf5I46OnOVA7t4sqqvY=
X-Google-Smtp-Source: AGHT+IEhELGDgpYytqGJP7meWXze88TaWW+8qS28m6xviXpXQ3WT4Fx/1xwYJEMxT8XpuYDgprQ0Lg==
X-Received: by 2002:a05:6a20:1006:b0:14c:ad99:22a9 with SMTP id gs6-20020a056a20100600b0014cad9922a9mr6587216pzc.32.1693794406163;
        Sun, 03 Sep 2023 19:26:46 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902d38600b001ae0a4b1d3fsm6467800pld.153.2023.09.03.19.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 19:26:45 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id C49FE8B0C37B; Mon,  4 Sep 2023 09:26:42 +0700 (WIB)
Date:   Mon, 4 Sep 2023 09:26:42 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Turritopsis Dohrnii Teo En Ming <tdtemccnp@gmail.com>,
        Linux bcachefs <linux-bcachefs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     ceo@teo-en-ming-corp.com,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: Linus Torvalds calls for calm as bcachefs filesystem doesn't
 make Linux 6.5
Message-ID: <ZPVAYuIqRWrMmevT@debian.me>
References: <CAD3upLuL3TWYrLOALoMFbM2QdiL8Va=PH3OYZDHZZTrSpfF-_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cR9UpDOPz+qHdbKx"
Content-Disposition: inline
In-Reply-To: <CAD3upLuL3TWYrLOALoMFbM2QdiL8Va=PH3OYZDHZZTrSpfF-_w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cR9UpDOPz+qHdbKx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[trimming context and obvious *political* stuff]

On Mon, Jul 10, 2023 at 10:12:33PM +0800, Turritopsis Dohrnii Teo En Ming w=
rote:
> Article: Linus Torvalds calls for calm as bcachefs filesystem doesn't
> make Linux 6.5
> Link: https://www.theregister.com/2023/07/10/linux_6_5_rc1_bcachefs/
>=20

Kent had resent the PR for 6.6 cycle [1]. If it is merged, you can
test the mainline with bcachefs enabled and report any problems found.

Thanks.

[1]: https://lore.kernel.org/all/20230903032555.np6lu5mouv5tw4ff@moria.home=
=2Elan/

--=20
An old man doll... just what I always wanted! - Clara

--cR9UpDOPz+qHdbKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZPVAWgAKCRD2uYlJVVFO
o/ZxAP9g+UG+P2FULEsfVwVdRcCTNDqWGtfKlGh6UZYXLsVB2QEAvyMKHux0lv20
xNC/ECuzGxZ/SCt87M3SFJmcakNC5A8=
=T2fq
-----END PGP SIGNATURE-----

--cR9UpDOPz+qHdbKx--
