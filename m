Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773E67BA808
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 19:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjJER3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 13:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjJER3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:29:23 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628DB268E;
        Thu,  5 Oct 2023 10:26:52 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qoLYf-003l8K-3c; Thu, 05 Oct 2023 18:26:18 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 05 Oct 2023 18:26:21 +0800
Date:   Thu, 5 Oct 2023 18:26:21 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     wangzhou1@hisilicon.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: hisilicon/qm - fix PF queue parameter issue
Message-ID: <ZR6PTeFIjbP48sqN@gondor.apana.org.au>
References: <20230928085722.39087-1-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928085722.39087-1-liulongfang@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 04:57:22PM +0800, Longfang Liu wrote:
> If the queue isolation feature is enabled, the number of queues
> supported by the device changes. When PF is enabled using the
> current default number of queues, the default number of queues may
> be greater than the number supported by the device. As a result,
> the PF fails to be bound to the driver.
> 
> After modification, if queue isolation feature is enabled, when
> the default queue parameter is greater than the number supported
> by the device, the number of enabled queues will be changed to
> the number supported by the device, so that the PF and driver
> can be properly bound.
> 
> Fixes: 8bbecfb402f7 ("crypto: hisilicon/qm - add queue isolation support for Kunpeng930")
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  drivers/crypto/hisilicon/hpre/hpre_main.c |  5 +++++
>  drivers/crypto/hisilicon/qm.c             | 18 ++++++++++++------
>  drivers/crypto/hisilicon/qm_common.h      |  1 -
>  drivers/crypto/hisilicon/sec2/sec_main.c  |  5 +++++
>  drivers/crypto/hisilicon/zip/zip_main.c   |  5 +++++
>  include/linux/hisi_acc_qm.h               |  7 +++++++
>  6 files changed, 34 insertions(+), 7 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
