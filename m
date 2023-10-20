Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57BF7D0803
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 07:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376310AbjJTF6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 01:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376293AbjJTF6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 01:58:07 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D147CA;
        Thu, 19 Oct 2023 22:58:06 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qtiWH-0097il-6w; Fri, 20 Oct 2023 13:58:02 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 20 Oct 2023 13:58:06 +0800
Date:   Fri, 20 Oct 2023 13:58:06 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     =?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@apitzsch.eu
Subject: Re: [PATCH] crypto: qcom-rng - Add missing dependency on hw_random
Message-ID: <ZTIW7oSsJr5Ce1Km@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231016-qcom_rng-v1-1-1a7d7856651e@apitzsch.eu>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

André Apitzsch <git@apitzsch.eu> wrote:
> This should fix the undefined reference:
> 
>> /usr/bin/aarch64-alpine-linux-musl-ld: Unexpected GOT/PLT entries detected!
>> /usr/bin/aarch64-alpine-linux-musl-ld: Unexpected run-time procedure linkages detected!
>> /usr/bin/aarch64-alpine-linux-musl-ld: drivers/crypto/qcom-rng.o: in function `qcom_rng_probe':
>> qcom-rng.c:(.text+0x130): undefined reference to `devm_hwrng_register'
> 
> Fixes: f29cd5bb64c2 ("crypto: qcom-rng - Add hw_random interface support")
> Signed-off-by: André Apitzsch <git@apitzsch.eu>
> ---
> drivers/crypto/Kconfig | 1 +
> 1 file changed, 1 insertion(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
