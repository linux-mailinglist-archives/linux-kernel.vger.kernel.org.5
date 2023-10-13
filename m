Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C99E7C82E9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjJMKVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjJMKVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:21:14 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9631DB7;
        Fri, 13 Oct 2023 03:21:12 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qrFI1-006j3w-Po; Fri, 13 Oct 2023 18:21:06 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 13 Oct 2023 18:21:10 +0800
Date:   Fri, 13 Oct 2023 18:21:10 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ingyu Jang <ingyujang25@unist.ac.kr>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, ysjeon@unist.ac.kr,
        ingyujang25@unist.ac.kr
Subject: Re: [PATCH] crypto: authencesn - Fix incorrect setauthsize function
Message-ID: <ZSkaFmV4tfxjV3Kt@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013095523.184497-1-ingyujang25@unist.ac.kr>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ingyu Jang <ingyujang25@unist.ac.kr> wrote:
>
> diff --git a/crypto/authencesn.c b/crypto/authencesn.c
> index 91424e791d5c..c1346d5b7950 100644
> --- a/crypto/authencesn.c
> +++ b/crypto/authencesn.c
> @@ -52,6 +52,8 @@ static int crypto_authenc_esn_setauthsize(struct crypto_aead *authenc_esn,
>        if (authsize > 0 && authsize < 4)
>                return -EINVAL;
> 
> +       authenc_esn->authsize = authsize;
> +

The premise of this patch is incorrect.  Please check the code for
setauthsize in crypto/aead.c.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
