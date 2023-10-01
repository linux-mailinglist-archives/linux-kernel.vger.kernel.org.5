Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1788B7B464B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 10:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbjJAId6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 04:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234510AbjJAId4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 04:33:56 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08ED683;
        Sun,  1 Oct 2023 01:33:54 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qmrtd-002PUw-7x; Sun, 01 Oct 2023 16:33:50 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 01 Oct 2023 16:33:53 +0800
Date:   Sun, 1 Oct 2023 16:33:53 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Gaurav Jain <gaurav.jain@nxp.com>
Cc:     Horia Geanta <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH] crypto: caam/qi2 - fix Chacha20 + Poly1305 self test
 failure
Message-ID: <ZRku8WKoMiiUJdsX@gondor.apana.org.au>
References: <20230921094444.2121891-1-gaurav.jain@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921094444.2121891-1-gaurav.jain@nxp.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 03:14:44PM +0530, Gaurav Jain wrote:
> key buffer is not copied in chachapoly_setkey function,
> results in wrong output for encryption/decryption operation.
> 
> fix this by memcpy the key in caam_ctx key arrary
> 
> Fixes: c10a53367901 ("crypto: caam/qi2 - add support for Chacha20 + Poly1305")
> Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
> ---
>  drivers/crypto/caam/caamalg_qi2.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
