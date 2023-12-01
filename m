Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36438007F1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 11:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378179AbjLAKKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 05:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378134AbjLAKKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 05:10:39 -0500
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415F0DC;
        Fri,  1 Dec 2023 02:10:44 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1r90Th-005hiX-2F; Fri, 01 Dec 2023 18:10:34 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 01 Dec 2023 18:10:42 +0800
Date:   Fri, 1 Dec 2023 18:10:42 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Gonglei Arei <arei.gonglei@huawei.com>
Cc:     linux-crypto@vger.kernel.org, pasic@linux.ibm.com, mst@redhat.com,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, wangyangxin1@huawei.com,
        arei.gonglei@huawei.com
Subject: Re: [PATCH] crypto: virtio-crypto: Handle dataq logic  with tasklet
Message-ID: <ZWmxInHyFboXMWZ6@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2fe5c6a60984a9e91bd9dea419c5154@huawei.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel,apana.lists.os.linux.virtualization
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gonglei Arei <arei.gonglei@huawei.com> wrote:
> Doing ipsec produces a spinlock recursion warning.
> This is due to crypto_finalize_request() being called in the upper half.
> Move virtual data queue processing of virtio-crypto driver to tasklet.
> 
> Fixes: dbaf0624ffa57 ("crypto: add virtio-crypto driver")
> Reported-by: Halil Pasic <pasic@linux.ibm.com>
> Signed-off-by: wangyangxin <wangyangxin1@huawei.com>
> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> ---
> drivers/crypto/virtio/virtio_crypto_common.h |  2 ++
> drivers/crypto/virtio/virtio_crypto_core.c   | 23 +++++++++++++----------
> 2 files changed, 15 insertions(+), 10 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
