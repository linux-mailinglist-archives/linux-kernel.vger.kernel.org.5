Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DE67BCE4D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 14:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344738AbjJHMNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 08:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjJHMNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 08:13:00 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BCBB9
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 05:12:59 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6934202b8bdso3021181b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 05:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696767179; x=1697371979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gzVWyC3Uw96qg3fz/cZmSjeBDgcHMVStHcIEt656adM=;
        b=EioW+jqsFpYk7xBiKsI5B2lQgml+etpealrXGKmaq8OK2MQTRepWuySeutb4nPjpp8
         l8DKH5fUhagZd+vDYxwCP9ekJfaCLvhjcG+NIsWWDkBE1zJKN1iVaJHF5JSyCO/lN/To
         1FcpU6rFdZi/QRULEbjzU1UpHodz0bLGVQa+7u17dX5TK8O5adsHTKE2ZDI/6oP3WZGY
         yinz/1ymZeCn2PLLr5pQ7/wj/ylm4AVoY9zAtyO2Qe51dWb+i7i6uTAMvi62gkExSnd9
         lF3sK53HZBiWJPZtgMx0dAKbXoov9OddhBI2YPTGxX8X1A5lO5M7YtACfweK/RsVKSVL
         rlOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696767179; x=1697371979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzVWyC3Uw96qg3fz/cZmSjeBDgcHMVStHcIEt656adM=;
        b=perh5xSd2wZ//g4bHXRk0r8Dchzb911uWMiXBNgcph9+VSY194tjDR/BlcusiyHrNq
         xUq7ecgcQOIDU8KDfvUnjj/CqV9LhKYtokCyhklDwrVTYwjQ+/re8ZqUNwSjG/JQlGL6
         lwqO42D1Yqm+08FwtYuejg6PIuwvjKTKmcaKPOdwMD646fMurbEfUMhCEBeGwZUXK5Oe
         z+4+d4efa+bTt6xLQtI/HNGfR00oFJGxUNmcAQgde2077cLV+cxFnTq3ICEJxMWsGRao
         WaIw85b/ayDElbFio78dGKRJTnQsVNYQX9RrIK+H8+0jOofyXVzxV1XmgCnDV+O8All7
         Qoqg==
X-Gm-Message-State: AOJu0Ywb9RjMSs0UOePIxMdXyGlisvg2awKdMvw0EC0LlenRn+bLtBh3
        agvHemcXPDzc04MjrlsJ6bQ=
X-Google-Smtp-Source: AGHT+IG09OpOyVbQjpi6nCvLRRi2DaE/Semj9suFIITKCrSRwUNKYiMYL4pp7WcjbftboHNbEr0/Ng==
X-Received: by 2002:a05:6a00:1410:b0:68b:eb3d:8030 with SMTP id l16-20020a056a00141000b0068beb3d8030mr13707120pfu.1.1696767179204;
        Sun, 08 Oct 2023 05:12:59 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id x52-20020a056a000bf400b0069023d80e63sm4500313pfu.25.2023.10.08.05.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 05:12:58 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 30E8F81B12C1; Sun,  8 Oct 2023 19:12:49 +0700 (WIB)
Date:   Sun, 8 Oct 2023 19:12:48 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Gilbert Adikankwu <gilbertadikankwu@gmail.com>,
        Linux Outreachy <outreachy@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Julia Lawall <Julia.Lawall@inria.fr>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [ERROR] HELP NEEDED
Message-ID: <ZSKcwGbe0ZDWSdHQ@debian.me>
References: <CAKrXSsbDAA=VXpy5kO33S9LkjLVGyZNKsmN2ttk_fK0kKRRLAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1grw6rbc3eaU5EHP"
Content-Disposition: inline
In-Reply-To: <CAKrXSsbDAA=VXpy5kO33S9LkjLVGyZNKsmN2ttk_fK0kKRRLAw@mail.gmail.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1grw6rbc3eaU5EHP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 08, 2023 at 12:12:17AM +0100, Gilbert Adikankwu wrote:
> Hello fellow community member,
>=20
> I'm trying to build the kernel on Ubuntu 22.04 LTS natively installed
> on my computer and I'm getting this error message:
>=20
> arch/x86/entry/thunk_64.o: warning: objtool: missing symbol table
> make[2]: *** [scripts/Makefile.build:361: arch/x86/entry/thunk_64.o] Erro=
r 1
> make[2]: *** Deleting file 'arch/x86/entry/thunk_64.o'
> make[1]: *** [scripts/Makefile.build:497: arch/x86/entry] Error 2
> make: *** [Makefile:1764: arch/x86] Error 2
>=20
> It seems like a file is missing but I don't know if that is possible
> because I just cloned the repository and didn't touch any file.
>=20

You should always clean up the tree first (`make mrproper`), then do
the build as usual. To speed up build time, you can try copying your
current kernel configuration (can be found either in `/boot/` directory
or in `/proc/config.gz`), then trim it up with `make localmodconfig`.
Make sure that all options needed by your computer are enabled (you
may have to plug all peripherals available on your hand) as well as
options related to kernel subsystem/driver you're hacking. For more
information, see Documentation/admin-guide/quickly-build-trimmed-linux.rst.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--1grw6rbc3eaU5EHP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZSKcwAAKCRD2uYlJVVFO
o9svAP9tcVmFjDxIFZm9zqVK9xGXMpPBKQPLPDNkFEX1hLG7tQEAvOi372x7TrVY
6HT8Pre2YYn79aM8tQ3YfUxIVtCO8AA=
=ljq/
-----END PGP SIGNATURE-----

--1grw6rbc3eaU5EHP--
