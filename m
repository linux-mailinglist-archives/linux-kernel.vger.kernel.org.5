Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853977C835A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjJMKjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjJMKjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:39:41 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1039BBB;
        Fri, 13 Oct 2023 03:39:27 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qrFZb-006jgf-92; Fri, 13 Oct 2023 18:39:16 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 13 Oct 2023 18:39:20 +0800
Date:   Fri, 13 Oct 2023 18:39:20 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] crypto: remove md4 driver
Message-ID: <ZSkeWHdOAOfjtpwJ@gondor.apana.org.au>
References: <20231008040140.1647892-1-dimitri.ledkov@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231008040140.1647892-1-dimitri.ledkov@canonical.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2023 at 05:01:39AM +0100, Dimitri John Ledkov wrote:
> No internal users left and cryptographically insecure. Users should
> upgrade to something else, e.g. sha256 blake3.
> 
> Some drivers have their own full or partial md4 implementation without
> using crypto/md4.
> 
> Userspace code search indicates a few copies of hash_info.h
> https://codesearch.debian.net/search?q=HASH_ALGO_MD4&literal=1 without
> need for MD4.
> 
> Preserve uapi hash algorithm indexes and array length, but rename the
> MD4 enum.
> 
> Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
> ---
>  crypto/Kconfig                 |   6 -
>  crypto/Makefile                |   1 -
>  crypto/hash_info.c             |   4 +-
>  crypto/md4.c                   | 241 ---------------------------------
>  crypto/tcrypt.c                |  12 --
>  crypto/testmgr.c               |   6 -
>  crypto/testmgr.h               |  42 ------
>  include/uapi/linux/hash_info.h |   2 +-
>  8 files changed, 3 insertions(+), 311 deletions(-)
>  delete mode 100644 crypto/md4.c

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
