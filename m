Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1863E764B5B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 10:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbjG0IOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 04:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234330AbjG0IN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:13:56 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4184D5251;
        Thu, 27 Jul 2023 01:09:10 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qOw2I-000YeE-6L; Thu, 27 Jul 2023 16:07:51 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 27 Jul 2023 16:07:50 +0800
Date:   Thu, 27 Jul 2023 16:07:50 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Zhang Yiqun <zhangyiqun@phytium.com.cn>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: all - alloc and init all req alloc as zero
Message-ID: <ZMIl1vSitJBU3UJS@gondor.apana.org.au>
References: <20230727080548.8666-1-zhangyiqun@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727080548.8666-1-zhangyiqun@phytium.com.cn>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 04:05:48PM +0800, Zhang Yiqun wrote:
> This patch is to change all req struct alloc function from kmalloc
> to kzalloc. Sometimes, it will incur some errors without initialized
> zero.
> 
> Signed-off-by: Zhang Yiqun <zhangyiqun@phytium.com.cn>
> ---
>  include/crypto/akcipher.h | 2 +-
>  include/crypto/hash.h     | 2 +-
>  include/crypto/kpp.h      | 2 +-
>  include/crypto/skcipher.h | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)

Nack.  Unless you have a specific issue please don't submit vague
patches like this.  You should always state what issue led you to
make a change like this.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
