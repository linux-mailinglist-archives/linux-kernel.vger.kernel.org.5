Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73EE27C4D65
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345300AbjJKImf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjJKImd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:42:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D124B93;
        Wed, 11 Oct 2023 01:42:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61AE1C433C9;
        Wed, 11 Oct 2023 08:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697013751;
        bh=/qnCsWhvwJGmydL5cFopunMWv+54w3gBRXtRDqkm3Mo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Db5h7oG7HRhT0j2ZKdp8Krg7SPnXjuNjx2Sjo1zzsZZVC6a4g2b0i7l7W1Rtee219
         QHEqRS0aSTOl/B93iRJcePiEzxMD9X9QaXPtoTUJJIbpdfYGg1WZkGL/upySXZOOmi
         Bb4/LgU0qiUuaEsdpkaB02sCp9KGfk2nLsCpPJwYhyrqkXIZnUcQJX2lOMFz9p/fCP
         apVub3lK2vbP6MNxKheZCxdXRYPrRJWYdlK8BuSCWSwg9qlP1VGTmaqOUstwp8s6aq
         QjWC99i4o0m+7Du3ofOKBi0Llc0Ih9ek7oq8e05Y4JFZZEUN2R5/AIA6qbSMwx0m6b
         1c6x2zZESjT/g==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50567477b29so8563817e87.3;
        Wed, 11 Oct 2023 01:42:31 -0700 (PDT)
X-Gm-Message-State: AOJu0YzqW+XAxku8vsXyPbaPu+RogsW/LxiaDHSLWS61EfqIrnoQEuPT
        GMCoK1Vnm3zid+R00PPZl5JbYOOdj1394nyXb5w=
X-Google-Smtp-Source: AGHT+IEQ8N+hxnKlsY3kdHlMUmD2dB5AsGDgukW+xZ9lNPz+9WLrpyVRancG44N14b/uhYsTkc7NkZszxEOW8nSO8M4=
X-Received: by 2002:a05:6512:2527:b0:4fe:279b:7603 with SMTP id
 be39-20020a056512252700b004fe279b7603mr18296412lfb.14.1697013749583; Wed, 11
 Oct 2023 01:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231010212530.63470-1-dimitri.ledkov@canonical.com>
In-Reply-To: <20231010212530.63470-1-dimitri.ledkov@canonical.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 11 Oct 2023 10:42:18 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFVPnowdREEjVREy=KKY12nZUp58qL2b_u97=bOTz0wgA@mail.gmail.com>
Message-ID: <CAMj1kXFVPnowdREEjVREy=KKY12nZUp58qL2b_u97=bOTz0wgA@mail.gmail.com>
Subject: Re: [PATCH] crypto: mscode_parser: remove sha224 authenticode support
To:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2023 at 23:25, Dimitri John Ledkov
<dimitri.ledkov@canonical.com> wrote:
>
> It is possible to stand up own certificates and sign PE-COFF binaries
> using SHA-224. However it never became popular or needed since it has
> similar costs as SHA-256. Windows Authenticode infrastructure never
> had support for SHA-224, and all secureboot keys used fro linux

fro

> vmlinuz have always been using at least SHA-256.
>
> Given the point of mscode_parser is to support interoperatiblity with

interoperatibility

> typical de-facto hashes, remove support for SHA-224 to avoid
> posibility

the possibility

> of creating interoperatibility

interoperability

> issues with rhboot/shim,
> grub, and non-linux systems trying to sign or verify vmlinux.
>
> SHA-224 itself is not removed from the kernel, as it is truncated
> SHA-256. If requested I can write patches to remove SHA-224 support
> across all of the drivers.
>

We can stop using it but we cannot remove it.

As you say, it is just SHA-256 with a different initial state and a
truncated hash, so removing support entirely achieves very little. And
there are plenty of other algorithms we'd be happy to remove first if
we were only sure that nobody was relying on them. (Note that AF_ALG
supports AEAD so someone somewhere could be using the kernel's sha224
from user space)

> Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  crypto/asymmetric_keys/mscode_parser.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/crypto/asymmetric_keys/mscode_parser.c b/crypto/asymmetric_keys/mscode_parser.c
> index 6416bded0e..855cbc46a9 100644
> --- a/crypto/asymmetric_keys/mscode_parser.c
> +++ b/crypto/asymmetric_keys/mscode_parser.c
> @@ -84,9 +84,6 @@ int mscode_note_digest_algo(void *context, size_t hdrlen,
>         case OID_sha512:
>                 ctx->digest_algo = "sha512";
>                 break;
> -       case OID_sha224:
> -               ctx->digest_algo = "sha224";
> -               break;
>
>         case OID__NR:
>                 sprint_oid(value, vlen, buffer, sizeof(buffer));
> --
> 2.34.1
>
