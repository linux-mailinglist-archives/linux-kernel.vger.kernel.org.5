Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29996789D34
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 13:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjH0LNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 07:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjH0LNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 07:13:33 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1904109
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 04:13:27 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68bed2c786eso1566135b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 04:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693134807; x=1693739607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wl+ZKaftHVuwcTbRl19eCRdFRFIermlTFAXbwQSTovI=;
        b=Ixl0UtCC0wGnGSq3F+Uckf+/TAO69magjf11+C1VrpC9edmVIeg3XoZ9GqDKa8vcHM
         4eDBhgJmnTk7onLWcuaBxoSOb2dzK5D7FvMdye0T5/VCYI314FvnFeDg6PfrX504H2BI
         /10d7lXLiOla1/d/UaU+uLpS7CwI74kBmYQ00VrUnUJHQGz9EY8M8AOB9E/F1JlQF5Db
         bk9HZ3LNrncf0qMoU3n2w0zzL90mrOe8as4SZzwr5MiHhsnDT0boKlEwaiAkMMgwfWzo
         q/khJhwaT9LdS385fxzgfGYYTCu0Z6e+/+ko4968hHLksBAqGIR+l6/M8HUvVNwPvPcA
         8bEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693134807; x=1693739607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wl+ZKaftHVuwcTbRl19eCRdFRFIermlTFAXbwQSTovI=;
        b=hmWax+MylxoBeCj4WLeqTdl9p3QpeNeA36yqubvfzMNqmWDlFEa9SWwOZLpUvFZe8A
         SFtP3ejqDoPg6ooH9tKyCP3MgpOTPxYbRBTsJx8EZROJFWCbLUCOrroztMDZIH8sOj9B
         0zXl45IwUdf38foGB1+pR+PUl1HRIhyIKf5uq4942kcXAQ065GDDIbINB2aF+0K+fMp8
         snHPBuoxrdXtRFqFSm78JEaS0pIQavCkYSm9Hdr7nM7h72YhQS04V7zvbfLAD/V9bO33
         IQJw1HYZlC2gKr/WfsiWKayzcoI3aZ0O9G05pTHCZysVqMesS3MmM2IejPU9gM+Q+pl0
         YFbg==
X-Gm-Message-State: AOJu0YyHFz0SboURrRGD0w+uKEjTNqsuC7muMjxhtBA6tDmnCxgKd8cG
        xnI43EimVfaYgIjyOFPtscQ=
X-Google-Smtp-Source: AGHT+IFV9Je2TsAUtqFlGu6yon5xWIS+COJBQaa7pM2/w5q7z489DhcGyxHk/LwhA2sgf/ZE7PeGSg==
X-Received: by 2002:a17:902:e743:b0:1b5:2b12:6f50 with SMTP id p3-20020a170902e74300b001b52b126f50mr22133950plf.12.1693134807336;
        Sun, 27 Aug 2023 04:13:27 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id o9-20020a170902bcc900b001b567bbe82dsm5054923pls.150.2023.08.27.04.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 04:13:26 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id D6DC38158460; Sun, 27 Aug 2023 18:13:22 +0700 (WIB)
Date:   Sun, 27 Aug 2023 18:13:22 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Toralf =?utf-8?Q?F=C3=B6rster?= <toralf.foerster@gmx.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: 6.1.48 regression at boot : WARNING: CPU: 0 PID: 0 at
 arch/x86/kernel/alternative.c:572 apply_returns+0x1e4/0x210
Message-ID: <ZOsv0h6bsYSnfg2b@debian.me>
References: <3d6fbd04-2861-91a8-938c-45195f307eed@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VftMaAw9Zowqs3kT"
Content-Disposition: inline
In-Reply-To: <3d6fbd04-2861-91a8-938c-45195f307eed@gmx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VftMaAw9Zowqs3kT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 26, 2023 at 03:47:13PM +0200, Toralf F=C3=B6rster wrote:
>=20
> I do get a
>=20
> missing return thunk: 0xffffffff948a73fe-srso_untrain_ret+0x0/0x2: e9 7b =
92
> 35 ff
> WARNING: CPU: 0 PID: 0 at arch/x86/kernel/alternative.c:572
> apply_returns+0x1e4/0x210
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper/0 Tainted: G                T  6.1.48 #38
> Hardware name: LENOVO 21J5002FGE/21J5002FGE, BIOS R23ET60W (1.30 )
> 09/14/2022
> RIP: 0010:apply_returns+0x1e4/0x210
> Code: 36 01 00 0f 85 f7 fe ff ff 49 89 d8 b9 05 00 00 00 4c 89 f2 48 89 de
> 48 c7 c7 e8 7e ff 93 c6 05 22 7d 36 01 01 e8 8c a9 09 00 <0f> 0b e9 cf fe=
 ff
> ff c7 84 24 81 00 00 00 cc cc cc cc 42 c7 44 38
> RSP: 0000:ffffffff94203e00 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffffffff948a73fe RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffffff9488601c R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff948866e8
> R13: cccccccccccccccc R14: ffffffff93c0067e R15: ffffffff94219118
> FS:  0000000000000000(0000) GS:ffff97dcdee00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff97d6f4c01000 CR3: 0000000234210000 CR4: 0000000000750ef0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  ? __warn+0x6f/0xc0
>  ? apply_returns+0x1e4/0x210
>  ? report_bug+0xdb/0x140
>  ? handle_bug+0x3c/0x70
>  ? exc_invalid_op+0x17/0x80
>  ? asm_exc_invalid_op+0x1a/0x20
>  ? retbleed_return_thunk+0x7e/0x7e
>  ? apply_returns+0x1e4/0x210
>  ? _raw_spin_unlock_irqrestore+0xd/0x30
>  alternative_instructions+0x68/0x1e1
>  arch_cpu_finalize_init+0x48/0x9a
>  start_kernel+0x789/0x877
>  secondary_startup_64_no_verify+0xd3/0xdb
>  </TASK>
> ---[ end trace 0000000000000000 ]---
>=20
> here at a
>=20
> Linux p14s 6.1.48 #38 SMP Sat Aug 26 15:41:04 CEST 2023 x86_64 AMD Ryzen 7
> PRO 6850U with Radeon Graphics AuthenticAMD GNU/Linux
>=20
> Otherwise the kernel seems to work fine.

Thanks for the regression report. I'm adding it to regzbot (as stable-speci=
fic
regression for now):

#regzbot ^introduced: v6.1.47..v6.1.48

--=20
An old man doll... just what I always wanted! - Clara

--VftMaAw9Zowqs3kT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZOsvygAKCRD2uYlJVVFO
o2u9AP9K7QEj7//dUWHwx175JBn6FCkvfSKhZddvsXFw+sXaFgEA7tUahEKXEYsc
sT786Vg912dfpJ/skhKwDAfFut6TmgE=
=doDz
-----END PGP SIGNATURE-----

--VftMaAw9Zowqs3kT--
