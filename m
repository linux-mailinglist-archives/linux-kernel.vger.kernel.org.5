Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BD67899F5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 02:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjH0Aws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 20:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjH0Awb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 20:52:31 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBA319A
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 17:52:29 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68bee12e842so1452095b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 17:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693097548; x=1693702348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BI5kulqpf0hYzC1rK27iSaXu0DMIsGtaUbe3SdWYK7g=;
        b=p/aj5Jgv23FaxAcoD0vm6s9LU47G/hnuF1tRRC78tLx99HH3KyxL35aLq2zL75ETfU
         qEKeGaLh7+xKXxOZaO7OJFKkeuEpSEW8f0k6oEIwpuDsjSt6DEOtVJ1XJDXjsOJUtpHO
         K/BvjJwOBpqgPI9X/xGjb3VyvpqlKZ3yIPUYmf1aNws/Tw3GJUYUZyacckBdgud5ZoOj
         N8gEvnczrMr2BFsQyfF7MRDyXeyoSl9oXEmQwAANMfbf4T0TrMRdLDrjb4A6fx0MWD45
         NzXhDZL/FcFCvtG6kbO6OpuT3hHULiVZq+cuae5ORgWKAJ/X/YBzOYk3B5cjgOukKy57
         iI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693097548; x=1693702348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BI5kulqpf0hYzC1rK27iSaXu0DMIsGtaUbe3SdWYK7g=;
        b=KOOGXVVynjBnhIuDNQ/oJkBZf4msYzl18taPykPNT4IFwr2zRGVhhhUC4gpqGaJAHy
         3cRNUWsqPNojtIMkxL1w+kdGClvaCtrdei4pKJM+/kFBUq3M2Z6UrVS/9MYBokpUAOSq
         AdShxEPYgF5POGqnQ6OLv3cSVqi2OI8SIyvgE2j4w8Z9u6Y5GynGMWgD1V+zGHKbXVj4
         0lZkDYvF10cRT97aRgC/RcIZ8UxDNnjNFf6gqf0SJ/r4+VK9zEOIKxlguP6M9ma640WF
         9iqOZAQsGCxf1pfSR8Ou04Uy7kf1A4lJlzF5hef5mEIB9Fq6qus0qF65LKaGAdcr185E
         mubg==
X-Gm-Message-State: AOJu0YzBxCtjOt07sQqSZO82J1V3oXE4lEKUS8Rzho6O2W10QrdM78Z/
        2J70eXkqhOT5P1Uu8F1UHoA=
X-Google-Smtp-Source: AGHT+IGQNkq4dMTl+Eff14gwDQ/CWLDJzn/5p5xlKwa68nVj/QGcL0QkDGNgUj4BxQDpTrnqWl8J4g==
X-Received: by 2002:a05:6a20:2c2:b0:13f:67b6:b65f with SMTP id 2-20020a056a2002c200b0013f67b6b65fmr14682634pzb.54.1693097547582;
        Sat, 26 Aug 2023 17:52:27 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id x19-20020a170902821300b001bdd68b3f4bsm4289247pln.295.2023.08.26.17.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 17:52:27 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id A75FC9928258; Sun, 27 Aug 2023 07:52:22 +0700 (WIB)
Date:   Sun, 27 Aug 2023 07:52:22 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Toralf =?utf-8?Q?F=C3=B6rster?= <toralf.foerster@gmx.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: 6.1.48 regression at boot : WARNING: CPU: 0 PID: 0 at
 arch/x86/kernel/alternative.c:572 apply_returns+0x1e4/0x210
Message-ID: <ZOqeRpAHzqLDrlno@debian.me>
References: <3d6fbd04-2861-91a8-938c-45195f307eed@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="psxE9tKXVxHdu6fE"
Content-Disposition: inline
In-Reply-To: <3d6fbd04-2861-91a8-938c-45195f307eed@gmx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--psxE9tKXVxHdu6fE
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

Do you have any external modules?

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

Can you confirm that v6.1.47 doesn't have this regression? Is it also
reproducible on latest mainline?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--psxE9tKXVxHdu6fE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZOqeQAAKCRD2uYlJVVFO
o+bqAQD3Gvb3DJtaeJ7wlOCM9OvkQDWk/2mrMMOZZKgigANkRQD/cViYFqyj/p0K
8gh4z6zYHCfJlNXCWYXk9vNAOju5Ngk=
=6HCM
-----END PGP SIGNATURE-----

--psxE9tKXVxHdu6fE--
