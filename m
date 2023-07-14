Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDE275353F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbjGNIoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbjGNIo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:44:29 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08752708;
        Fri, 14 Jul 2023 01:44:19 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qKEPL-001Rcz-AL; Fri, 14 Jul 2023 18:44:12 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 14 Jul 2023 18:44:04 +1000
Date:   Fri, 14 Jul 2023 18:44:04 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Jia Jie Ho <jiajie.ho@starfivetech.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: starfive - Add AES skcipher and aead support
Message-ID: <ZLEK1AYMmj24rIph@gondor.apana.org.au>
References: <20230706032737.424378-1-jiajie.ho@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230706032737.424378-1-jiajie.ho@starfivetech.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 11:27:37AM +0800, Jia Jie Ho wrote:
> Adding AES skcipher and aead support to Starfive crypto module.
> Skcipher modes of operation include ecb, cbc, ctr, ofb, cfb. Aead modes
> include ccm and gcm.
> 
> Co-developed-by: Huan Feng <huan.feng@starfivetech.com>
> Signed-off-by: Huan Feng <huan.feng@starfivetech.com>
> Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
> ---
>  drivers/crypto/starfive/Kconfig       |    2 +
>  drivers/crypto/starfive/Makefile      |    2 +-
>  drivers/crypto/starfive/jh7110-aes.c  | 1034 +++++++++++++++++++++++++
>  drivers/crypto/starfive/jh7110-cryp.c |   36 +-
>  drivers/crypto/starfive/jh7110-cryp.h |   64 ++
>  5 files changed, 1131 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/crypto/starfive/jh7110-aes.c

This doesn't compile:

  CC [M]  drivers/crypto/starfive/jh7110-cryp.o
  CC [M]  drivers/crypto/starfive/jh7110-hash.o
  CC [M]  drivers/crypto/starfive/jh7110-rsa.o
  CC [M]  drivers/crypto/starfive/jh7110-aes.o
In file included from ../drivers/crypto/starfive/jh7110-aes.c:13:
../drivers/crypto/starfive/jh7110-cryp.h:184:49: error: field ‘aes_done’ has incomplete type
  184 |         struct tasklet_struct                   aes_done;
      |                                                 ^~~~~~~~
../drivers/crypto/starfive/jh7110-cryp.h:185:49: error: field ‘hash_done’ has incomplete type
  185 |         struct tasklet_struct                   hash_done;
      |                                                 ^~~~~~~~~
make[6]: *** [../scripts/Makefile.build:243: drivers/crypto/starfive/jh7110-aes.o] Error 1
make[6]: *** Waiting for unfinished jobs....

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
