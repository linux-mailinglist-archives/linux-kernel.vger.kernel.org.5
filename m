Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00F77F3F5B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 08:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjKVH63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 02:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjKVH62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 02:58:28 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63829A4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 23:58:24 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5c230c79c0bso2217668a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 23:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1700639904; x=1701244704; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U68ghU0ezOrA/i0cZQ+g/GiyVqNUk3N4qLW4eoZrPv0=;
        b=Ojtj7Mwy5hL7osbU8y3+kwxWJpkB9Ad+ayS5KiXc/DFWZ2fzziOvt7jbZRw9YUzNzQ
         X4KPkVT7oXh/IW50erV3pEfECOxEYRkhaE8Tg0UgSQoejg+tEjkXSzWSa98/+Whjq3pr
         5GOzYXQjZfulP2Mhu7w4ZQ+OJQ3w8f6KO9/QGzejBkn8MjTCMA5Zeo1QqhBOQAQk9oC9
         jtZPCD4TCT7idHDcK1Yhjfx4YPIVtQVRGCJM3fs1LHTK+dlV0GNvWrmP7WzQHnBQnqzK
         sMPjc9rOOdALuuCFeekHMldSUu7k53qfKm6WAoQPMIGOWnV8R1hoV2G4r3GHkUebJicA
         cXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700639904; x=1701244704;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U68ghU0ezOrA/i0cZQ+g/GiyVqNUk3N4qLW4eoZrPv0=;
        b=UtbpwIPn1ftYwPhGkCoBeMm0s47zxVyQAyTBjUm+Fo7oPEb8CfFLhb9FUPjmXud6q/
         aWJrwgZdeZB+ihp9LTbdX3DyVvdzmJob+GlCehrT9tcnU2f2mfkNRgqxJcTbjhxzVTaL
         PPsXYAv73NXi8rW36tMEDupNh7452VMSBEVBqG28mFiQ1UjUeqWUDGyi5jI9EWZiIZd/
         nOo8hiFy3wBF+tTDpHRpto2lhLgaP2SldW82i+kujcKRLnd41Ht0VTQjd3TL3sHDdECI
         5yYtak1ox4seo/0FS++lUBFmNmGrCU7wITE8jNA+eI13RJj1oOEUGuLrLY2kwS1yO43R
         7lzQ==
X-Gm-Message-State: AOJu0YzRvMcL9G5AlQofbA1mqzran0V4Nal2UJ5fJa9hgLy0xnqpl0YJ
        9u9C2XpOL2TMTEKjR4E4e+XWnA==
X-Google-Smtp-Source: AGHT+IGzjpQdS7ieWXTU6K6f7J3jrGKOKi3ukJepvggI5WBLYH9xyJcPuMjf8QAA0/FAbbQn/nbkVw==
X-Received: by 2002:a05:6a21:6d8f:b0:186:1fa0:47b1 with SMTP id wl15-20020a056a216d8f00b001861fa047b1mr1663715pzb.36.1700639903824;
        Tue, 21 Nov 2023 23:58:23 -0800 (PST)
Received: from ?IPv6:2402:7500:4ce:5a5b:f475:8bd5:cf8d:cf6a? ([2402:7500:4ce:5a5b:f475:8bd5:cf8d:cf6a])
        by smtp.gmail.com with ESMTPSA id f8-20020a17090ace0800b002802d9d4e96sm756441pju.54.2023.11.21.23.58.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Nov 2023 23:58:23 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.7\))
Subject: Re: [PATCH v4 00/12] RISC-V: support some cryptography accelerations
From:   Jerry Shih <jerry.shih@sifive.com>
In-Reply-To: <20231121235109.GE2172@sol.localdomain>
Date:   Wed, 22 Nov 2023 15:58:17 +0800
Cc:     Charlie Jenkins <charlie@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        conor.dooley@microchip.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        christoph.muellner@vrull.eu,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3416A95B-8687-44F6-9F77-D30AD6516094@sifive.com>
References: <20230711153743.1970625-1-heiko@sntech.de>
 <20230914001144.GA924@sol.localdomain> <ZQJdnCwf99Glggin@ghost>
 <3A0F6A71-C521-44A5-A56C-076AF3E13897@gmail.com>
 <DD3113B1-AB9F-4D6D-BD6E-8F75A83DA45D@sifive.com>
 <20231006194741.GA68531@google.com>
 <AB98E114-A8DE-492E-B078-7394EE4FA83E@sifive.com>
 <20231102040333.GC1498@sol.localdomain>
 <20231121235109.GE2172@sol.localdomain>
To:     Eric Biggers <ebiggers@kernel.org>
X-Mailer: Apple Mail (2.3445.9.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 22, 2023, at 07:51, Eric Biggers <ebiggers@kernel.org> wrote:
> On Wed, Nov 01, 2023 at 09:03:33PM -0700, Eric Biggers wrote:
>>=20
>> It would be nice to use a real assembler, so that people won't have =
to worry
>> about potential mistakes or inconsistencies in the perl-based =
"assembler".  Also
>> keep in mind that if we allow people to compile this code without the =
real
>> assembler support from the beginning, it might end up staying that =
way for quite
>> a while in order to avoid breaking the build for people.
>>=20
>> Ultimately it's up to you though; I think that you and others who =
have been
>> working on RISC-V crypto can make the best decision about what to do =
here.  I
>> also don't want this patchset to be delayed waiting for other =
projects, so maybe
>> that indeed means the perl-based "assembler" needs to be used for =
now.
>=20
> Just wanted to bump up this discussion again.  In binutils, the vector =
crypto
> v1.0.0 support was released 4 months ago in 2.41.  See the NEWS file =
at
> =
https://sourceware.org/git/gitweb.cgi?p=3Dbinutils-gdb.git;a=3Dblob_plain;=
f=3Dbinutils/NEWS;hb=3Drefs/heads/binutils-2_41-branch
>=20
>    * The RISC-V port now supports the following new standard =
extensions:
>      - Zicond (conditional zero instructions)
>      - Zfa (additional floating-point instructions)
>      - Zvbb, Zvbc, Zvkg, Zvkned, Zvknh[ab], Zvksed, Zvksh, Zvkn, =
Zvknc, Zvkng,
>        Zvks, Zvksc, Zvkg, Zvkt (vector crypto instructions)
>=20
> That's every extension listed in the vector crypto v1.0.0 =
specification
> =
(https://github.com/riscv/riscv-crypto/releases/download/v1.0.0/riscv-cryp=
to-spec-vector.pdf).

It doesn't fit all v1.0 spec.
The `Zvkb` is missed in binutils. It's the subset of `Zvbb`. We needs =
some extra
works if user just try to use `Zvkb`.
=
https://github.com/riscv/riscv-crypto/blob/main/doc/vector/riscv-crypto-ve=
ctor-zvkb.adoc
Some crypto algorithms are already checking for `Zvkb` instead of =
`Zvbb`.

> LLVM still has the vector crypto extensions marked as "experimental" =
extensions.
> However, there is an open pull request to mark them non-experimental:
> https://github.com/llvm/llvm-project/pull/69000
>=20
> Could we just go ahead and remove riscv.pm, develop with binutils for =
now, and
> prioritize getting the LLVM support finished?

Yes, we could.
But we need to handle the extensions checking for toolchains like:
=
https://github.com/torvalds/linux/commit/b6fcdb191e36f82336f9b5e126d51c02e=
7323480
I could do that, but I think I need some times to test the builds. And =
it will introduce
more dependency patch which is not related to actual crypto algorithms =
and the
gluing code in kernel. I will send another patch for toolchain part =
after the v2 patch.
And I am working for v2 patch with your new review comments. The v2 will =
still
use `perlasm`.
And we could move this discussion to this thread.
https://lore.kernel.org/all/20231025183644.8735-1-jerry.shih@sifive.com/

-Jerry=
