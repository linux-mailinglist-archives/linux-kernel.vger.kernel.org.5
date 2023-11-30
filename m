Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDADB7FE7A1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 04:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjK3D0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 22:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjK3DZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 22:25:58 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225C01A6;
        Wed, 29 Nov 2023 19:26:05 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3b844e3e817so293264b6e.0;
        Wed, 29 Nov 2023 19:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701314764; x=1701919564; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SgITWGqGXJRMaUBTBsTrQ/zSg9YuJuNVVUoNrgzixl8=;
        b=mO0jOad8250FzUBFH9g6TjIXaMlgNoydgEAWuQwd7w+VELV6g6xWeasrPbXaVja03v
         gJJcg1ygwLqo75aU1B+FylTskEH7fnonTi2+EgeuWJwi/tgJAJPaWqVe106Im+Gt7Q/x
         O6+8o4wUd5kJxSUiu8e8zSDWUsGGeVVpMbf7W/cVW/H5DXfxWCUVjvnbEW5NrPQOaMYK
         Z2GNliX+xtJNE8yPtehl0SBnUy4trubCja80+rAyRBwX+AhxAeLEBfSyWAO/Eu4/T2kM
         jB2Wc6kobx3AltA9FwWEwoPJWGB4DJHwmTlLU4UjjlZ5UFu1rXtbZrRo5AJ2+kHhhgcH
         3ZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701314764; x=1701919564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgITWGqGXJRMaUBTBsTrQ/zSg9YuJuNVVUoNrgzixl8=;
        b=teuvgrJThRiAe9p2wiYbXyYMdCsjaQy3oA3AFL+C6//6TmE7Ekq3G190wTt0WXsN//
         X4xmD4ksZn6JNXEPuJc1K5wRll3rur5Nix2bjqynKYXeZca8S7V1qw6lB9jAgcKZPfCx
         BqPSn9jI6W5GldUQDinBsy6vUKD3rkEqm/5Gb7YuT61aAbbIL0Aur8XejFYAVzBC8e3Q
         RTGwRwvAQ3wz5dj/9nEy7Sx2LaQtp21+FlfBsibdZyp7475Il1P1y/vBk3vnmK8SFRyd
         ZwLEWmUrjtvnQXzKT0qLnHkqvs/yFSwbsl2lnUsiYO9Ype+7fe7JM1+unTTZkAdvgZHP
         Pu0A==
X-Gm-Message-State: AOJu0YwHgw/ybYqKzsn0o64F7kyShvHx8xRYvmL33cqRj4WTseD1pN38
        ZISaZcOgw8jlYChZL9GSrGA=
X-Google-Smtp-Source: AGHT+IF2nu8M/q+hIdk4N0YXdM1T/cv+t0Ba7sqdhd1k52utsB8O0mWj9Y3+QqjLXnkNT9G5ZZUapw==
X-Received: by 2002:a05:6808:1705:b0:3b5:6421:1a6b with SMTP id bc5-20020a056808170500b003b564211a6bmr26806794oib.5.1701314764409;
        Wed, 29 Nov 2023 19:26:04 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id t13-20020a62d14d000000b006baa1cf561dsm164417pfl.0.2023.11.29.19.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 19:26:03 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id ECC3C1152884B; Thu, 30 Nov 2023 10:25:59 +0700 (WIB)
Date:   Thu, 30 Nov 2023 10:25:58 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Livepatching <live-patching@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Attreyee Mukherjee <tintinm2017@gmail.com>
Subject: Re: [PATCH 0/2] Minor grammatical fixup for livepatch docs
Message-ID: <ZWgAxoBULE5lhCQI@archie.me>
References: <20231129132527.8078-1-bagasdotme@gmail.com>
 <ac7a90a7-4d29-059b-fbff-6b67e6f5c2d3@redhat.com>
 <a4da77c2-7a23-4988-b65a-a58c105d89a4@gmail.com>
 <ZWfSgfiT/K6bTx7l@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="op6v+sHcJkHEQM3e"
Content-Disposition: inline
In-Reply-To: <ZWfSgfiT/K6bTx7l@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--op6v+sHcJkHEQM3e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 12:08:33AM +0000, Matthew Wilcox wrote:
> On Thu, Nov 30, 2023 at 06:58:16AM +0700, Bagas Sanjaya wrote:
> > I do this posting because I thought the OP (Attreyee) didn't respond in
> > timely manner (just like random Chinese contributors like @cdjrlc.com
> > and @208suo.com people).
>=20
> That's a ridiculous excuse.  The original posting was two days ago!
> If it had been a week since we last heard from Attreyee, I'd understand.

OK, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--op6v+sHcJkHEQM3e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZWgAvwAKCRD2uYlJVVFO
o4EVAQDUjDkIO5rjz5Ms1KFAKfAHWnpyhhaqKsnGYWWOx2A3ZQD/WIw9YBufSfdS
2vauj3QgcxuEOpwu8P2EUTGXsJnMAg0=
=xC7r
-----END PGP SIGNATURE-----

--op6v+sHcJkHEQM3e--
