Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EAD809A51
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 04:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573062AbjLHD2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 22:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHD2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 22:28:12 -0500
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAC7D53;
        Thu,  7 Dec 2023 19:28:17 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1rBRX6-008IE0-47; Fri, 08 Dec 2023 11:28:09 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 08 Dec 2023 11:28:17 +0800
Date:   Fri, 8 Dec 2023 11:28:17 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        wangyangxin <wangyangxin1@huawei.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2] crypto: virtio-crypto: Handle dataq logic  with
 tasklet
Message-ID: <ZXKNUdXNV7G3ED3P@gondor.apana.org.au>
References: <ad8c946eb2294a7bb9eef26066c06b72@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad8c946eb2294a7bb9eef26066c06b72@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 11:52:51AM +0000, Gonglei (Arei) wrote:
> Doing ipsec produces a spinlock recursion warning.
> This is due to crypto_finalize_request() being called in the upper half.
> Move virtual data queue processing of virtio-crypto driver to tasklet.
> 
> Fixes: dbaf0624ffa5 ("crypto: add virtio-crypto driver")
> Reported-by: Halil Pasic <pasic@linux.ibm.com>
> Signed-off-by: wangyangxin <wangyangxin1@huawei.com>
> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> ---
>  v2: calling tasklet_kill() in virtcrypto_remove(), thanks for MST.
> 
>  drivers/crypto/virtio/virtio_crypto_common.h |  2 ++
>  drivers/crypto/virtio/virtio_crypto_core.c   | 26 ++++++++++++++++----------
>  2 files changed, 18 insertions(+), 10 deletions(-)

Your patch has already been merged.  So please send this as
an incremental patch.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
