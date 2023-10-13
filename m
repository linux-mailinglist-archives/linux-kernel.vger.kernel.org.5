Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84BC7C8357
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjJMKkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjJMKj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:39:56 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F65F7;
        Fri, 13 Oct 2023 03:39:43 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qrFZy-006jhC-3r; Fri, 13 Oct 2023 18:39:39 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 13 Oct 2023 18:39:42 +0800
Date:   Fri, 13 Oct 2023 18:39:42 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Weili Qian <qianweili@huawei.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        liulongfang@huawei.com
Subject: Re: [PATCH] crypto: hisilicon/qm - alloc buffer to set and get xqc
Message-ID: <ZSkebr0vRhNelyZL@gondor.apana.org.au>
References: <20231008123617.23742-1-qianweili@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231008123617.23742-1-qianweili@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2023 at 08:36:17PM +0800, Weili Qian wrote:
> If the temporarily applied memory is used to set or get the xqc
> information, the driver releases the memory immediately after the
> hardware mailbox operation time exceeds the driver waiting time.
> However, the hardware does not cancel the operation, so the hardware
> may write data to released memory.
> 
> Therefore, when the driver is bound to a device, the driver reserves
> memory for the xqc configuration. The subsequent xqc configuration
> uses the reserved memory to prevent hardware from accessing the
> released memory.
> 
> Signed-off-by: Weili Qian <qianweili@huawei.com>
> ---
>  drivers/crypto/hisilicon/debugfs.c   |  75 +++---
>  drivers/crypto/hisilicon/qm.c        | 332 ++++++++++++---------------
>  drivers/crypto/hisilicon/qm_common.h |   5 +-
>  include/linux/hisi_acc_qm.h          |  13 ++
>  4 files changed, 191 insertions(+), 234 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
