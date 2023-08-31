Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B483D78ECA4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 13:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237545AbjHaL5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 07:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbjHaL5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 07:57:53 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29A6CFA;
        Thu, 31 Aug 2023 04:57:50 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qbgIL-009eDu-Nm; Thu, 31 Aug 2023 19:57:06 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 31 Aug 2023 19:57:07 +0800
Date:   Thu, 31 Aug 2023 19:57:07 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Yang Shen <shenyang39@huawei.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, ardb@kernel.org,
        kees@kernel.org, linux-kernel@vger.kernel.org, enlin.mu@unisoc.com,
        ebiggers@google.com, gpiccoli@igalia.com, willy@infradead.org,
        yunlong.xing@unisoc.com, yuxiaozhang@google.com,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        qat-linux@intel.com,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [PATCH 1/4] crypto: hisilicon/zip - Remove driver
Message-ID: <ZPCAExA8Zs5J6QzJ@gondor.apana.org.au>
References: <ZO8ULhlJSrJ0Mcsx@gondor.apana.org.au>
 <E1qbI7v-009Bvf-CA@formenos.hmeau.com>
 <8a73f9cb-b1e8-3b54-4b6c-7cfb19244560@huawei.com>
 <ZPAoRvMYbsoNfnLk@gondor.apana.org.au>
 <aa6c291a-d9f0-1e2a-63df-e53dfcefba53@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa6c291a-d9f0-1e2a-63df-e53dfcefba53@huawei.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 05:39:08PM +0800, Yang Shen wrote:
>
> OK, I'm sorry I got missunderstand about the purpose of the patch. The
> hardware also
> support the deflate algorithm. I can change the driver to register the
> deflate interface and
> remove the zlib-deflate. Is this plan acceptable? If yes, please don't
> remove the hisilicon
> zip driver and I'll send the fix patch as soon as possible. It may take me a
> week to adapt
> and verify the driver.

Yes that's fine.  Please send a patch to add deflate and remove
zlib-deflate as well as gzip.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
