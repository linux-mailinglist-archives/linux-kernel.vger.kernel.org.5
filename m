Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D6A7DB2C9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 06:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjJ3FYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 01:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjJ3FYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 01:24:08 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A8990;
        Sun, 29 Oct 2023 22:24:05 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qxKkc-00COW1-SZ; Mon, 30 Oct 2023 13:23:47 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 30 Oct 2023 13:23:53 +0800
Date:   Mon, 30 Oct 2023 13:23:53 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Networking <netdev@vger.kernel.org>,
        Linux Crypto List <linux-crypto@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Francesco Ruggeri <fruggeri@arista.com>,
        Salam Noureddine <noureddine@arista.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the crypto tree
Message-ID: <ZT896a2j3hUI1NF+@gondor.apana.org.au>
References: <20231030155809.6b47288c@canb.auug.org.au>
 <20231030160953.28f2df61@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030160953.28f2df61@canb.auug.org.au>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 04:09:53PM +1100, Stephen Rothwell wrote:
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 30 Oct 2023 15:54:37 +1100
> Subject: [PATCH] fix up for "crypto: ahash - remove crypto_ahash_alignmask"
> 
> interacting with "net/tcp: Introduce TCP_AO setsockopt()s"
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  net/ipv4/tcp_ao.c | 6 ------
>  1 file changed, 6 deletions(-)

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

If we simply apply this patch to the netdev tree then everything
should work at the next merge window.  But perhaps you could change
the patch description to say something like remove the obsolete
crypto_hash_alignmask.  It's not important though.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
