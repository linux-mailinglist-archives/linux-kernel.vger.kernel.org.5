Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA76B7588E2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 01:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjGRXHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 19:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjGRXHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 19:07:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C633A1;
        Tue, 18 Jul 2023 16:07:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B53E661372;
        Tue, 18 Jul 2023 23:07:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22736C433AB;
        Tue, 18 Jul 2023 23:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689721627;
        bh=+Pd8n6b3Bgde2sfLuTMJEdG3inSaboDgyN2R66pO+Cc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rbODd0eCkMojMdEsT2JG+DPQ5FfVcqjO+7TpaLSAITlHBKbP8U5e58LV5FWFBRUVd
         WfqtFLFPPQLBI+WPyuMGATfmm8+J0uFQJTLKlLbH9TiCN9639o12nq+YJVNSQMYjF3
         FGmaUehU1XG17oDii9iC9SAEy4rTkasUr+Y04Pcv/VZ+0YArgAhZB99N8buGKADRBJ
         LYRHsl2hQRSIsn8KC+LLc8NDcS7nrGUW9UGRFo1Q8ScX1Afl7wGan1l3BVCFlU6WkM
         vGsLFim7pfqlnxvDigXrfzxNxmdbDg2Bt/X2KpPLyeaCtSy8DvI3aGq9xkLL6VVsa3
         nN1xZb5T64iiQ==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2b70bfc8db5so96446021fa.2;
        Tue, 18 Jul 2023 16:07:07 -0700 (PDT)
X-Gm-Message-State: ABy/qLYTqMOKKDuXbXPae+TkVvIBHii04NLL6oWZ3NaBL/5Qi+7Br2Fg
        c5nvwOCmp+hymOSvFXr6KDal+Fhmc/vR2DtYc2E=
X-Google-Smtp-Source: APBJJlE2SEtdQ0viGgTX1RHV1Jf09uAG1PnJ2kbrstQtKT8l+bPM54I0W1KpO3/vBtrnR6qoOuKC/wwAZ5RCUS+NTqM=
X-Received: by 2002:a2e:968c:0:b0:2b5:8f85:bf67 with SMTP id
 q12-20020a2e968c000000b002b58f85bf67mr476772lji.53.1689721624966; Tue, 18 Jul
 2023 16:07:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230718125847.3869700-1-ardb@kernel.org> <20230718125847.3869700-2-ardb@kernel.org>
 <20230718223239.GB1005@sol.localdomain> <20230718225450.GD1005@sol.localdomain>
In-Reply-To: <20230718225450.GD1005@sol.localdomain>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 19 Jul 2023 01:06:53 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGR=1vA5T+iiRBSiabMqZxdCar_mXLOfcWPW0G1eHiXPA@mail.gmail.com>
Message-ID: <CAMj1kXGR=1vA5T+iiRBSiabMqZxdCar_mXLOfcWPW0G1eHiXPA@mail.gmail.com>
Subject: Re: [RFC PATCH 01/21] crypto: scomp - Revert "add support for deflate
 rfc1950 (zlib)"
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Kees Cook <keescook@chromium.org>,
        Haren Myneni <haren@us.ibm.com>,
        Nick Terrell <terrelln@fb.com>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Richard Weinberger <richard@nod.at>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        qat-linux@intel.com, linuxppc-dev@lists.ozlabs.org,
        linux-mtd@lists.infradead.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jul 2023 at 00:54, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Tue, Jul 18, 2023 at 03:32:39PM -0700, Eric Biggers wrote:
> > On Tue, Jul 18, 2023 at 02:58:27PM +0200, Ard Biesheuvel wrote:
> > > This reverts commit a368f43d6e3a001e684e9191a27df384fbff12f5.
> > >
> > > "zlib-deflate" was introduced 6 years ago, but it does not have any
> > > users. So let's remove the generic implementation and the test vectors,
> > > but retain the "zlib-deflate" entry in the testmgr code to avoid
> > > introducing warning messages on systems that implement zlib-deflate in
> > > hardware.
> > >
> > > Note that RFC 1950 which forms the basis of this algorithm dates back to
> > > 1996, and predates RFC 1951, on which the existing IPcomp is based and
> > > which we have supported in the kernel since 2003. So it seems rather
> > > unlikely that we will ever grow the need to support zlib-deflate.
> > >
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  crypto/deflate.c | 61 +++++-----------
> > >  crypto/testmgr.c |  8 +--
> > >  crypto/testmgr.h | 75 --------------------
> > >  3 files changed, 18 insertions(+), 126 deletions(-)
> >
> > So if this is really unused, it's probably fair to remove it on that basis.
> > However, it's not correct to claim that DEFLATE is obsoleted by zlib (the data
> > format).  zlib is just DEFLATE plus a checksum, as is gzip.
> >
> > Many users of zlib or gzip use an external checksum and therefore would be
> > better served by DEFLATE, avoiding a redundant builtin checksum.  Typically,
> > people have chosen zlib or gzip simply because their compression library
> > defaulted to it, they didn't understand the difference, and they overlooked that
> > they're paying the price for a redundant builtin checksum.
> >
> > An example of someone doing it right is EROFS, which is working on adding
> > DEFLATE support (not zlib or gzip!):
> > https://lore.kernel.org/r/20230713001441.30462-1-hsiangkao@linux.alibaba.com
> >
> > Of course, they are using the library API instead of the clumsy crypto API.
> >
>
> Ah, I misread this patch, sorry.  It's actually removing support for zlib (the
> data format) from the scomp API, leaving just DEFLATE.  That's fine too; again,
> it ultimately just depends on what is actually being used via the scomp API.
> But similarly you can't really claim that zlib is obsoleted by DEFLATE just
> because of the RFC dates.  As I mentioned, many people do use zlib (the data
> format), often just because it's the default of zlib (the library) and they
> didn't know any better.  For example, btrfs compression supports zlib.
>

I am not suggesting either is obsolete. I am merely pointing out that
zlib-deflate is as old as plain deflate, and so we could have
implemented both at the same time when IPcomp support was added, but
we never bothered.
