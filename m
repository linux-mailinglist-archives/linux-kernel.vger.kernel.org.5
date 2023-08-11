Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E452C778DAA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236472AbjHKL3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236461AbjHKL3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:29:09 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4796C10C9;
        Fri, 11 Aug 2023 04:29:08 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qUQKE-00248g-Uq; Fri, 11 Aug 2023 19:29:04 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 11 Aug 2023 19:29:03 +0800
Date:   Fri, 11 Aug 2023 19:29:03 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] crypto: arm64/aes: remove Makefile hack
Message-ID: <ZNYbf0ulRLys3wyp@gondor.apana.org.au>
References: <20230801101146.1550814-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801101146.1550814-1-masahiroy@kernel.org>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 07:11:46PM +0900, Masahiro Yamada wrote:
> Do it more simiply. This also fixes single target builds.
> 
> [before]
> 
>   $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- arch/arm64/crypto/aes-glue-ce.i
>     [snip]
>   make[4]: *** No rule to make target 'arch/arm64/crypto/aes-glue-ce.i'.  Stop.
> 
> [after]
> 
>   $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- arch/arm64/crypto/aes-glue-ce.i
>     [snip]
>     CPP     arch/arm64/crypto/aes-glue-ce.i
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  arch/arm64/crypto/Makefile        | 5 -----
>  arch/arm64/crypto/aes-glue-ce.c   | 2 ++
>  arch/arm64/crypto/aes-glue-neon.c | 1 +
>  3 files changed, 3 insertions(+), 5 deletions(-)
>  create mode 100644 arch/arm64/crypto/aes-glue-ce.c
>  create mode 100644 arch/arm64/crypto/aes-glue-neon.c

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
