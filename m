Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF577766A1F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjG1KWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbjG1KWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:22:01 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0C13A81;
        Fri, 28 Jul 2023 03:21:59 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qPKbR-0011pF-RY; Fri, 28 Jul 2023 18:21:46 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 28 Jul 2023 18:21:45 +0800
Date:   Fri, 28 Jul 2023 18:21:45 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Jia Jie Ho <jiajie.ho@starfivetech.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2] crypto: starfive - Add AES skcipher and aead support
Message-ID: <ZMOWuVRiywHkwHHk@gondor.apana.org.au>
References: <20230717040302.444880-1-jiajie.ho@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717040302.444880-1-jiajie.ho@starfivetech.com>
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

On Mon, Jul 17, 2023 at 12:03:02PM +0800, Jia Jie Ho wrote:
> Adding AES skcipher and aead support to Starfive crypto module.
> Skcipher modes of operation include ecb, cbc, ctr, ofb, cfb. Aead modes
> include ccm and gcm.
> 
> v1->v2:
> - Add include interrupt.h to fix compile error. (Herbert)
> 
> Co-developed-by: Huan Feng <huan.feng@starfivetech.com>
> Signed-off-by: Huan Feng <huan.feng@starfivetech.com>
> Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
> ---
>  drivers/crypto/starfive/Kconfig       |    2 +
>  drivers/crypto/starfive/Makefile      |    2 +-
>  drivers/crypto/starfive/jh7110-aes.c  | 1034 +++++++++++++++++++++++++
>  drivers/crypto/starfive/jh7110-cryp.c |   36 +-
>  drivers/crypto/starfive/jh7110-cryp.h |   65 ++
>  5 files changed, 1132 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/crypto/starfive/jh7110-aes.c

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
