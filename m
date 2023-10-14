Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA6E7C92B4
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 06:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbjJNEHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 00:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbjJNEHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 00:07:04 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5ADC2;
        Fri, 13 Oct 2023 21:07:01 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qrVvK-0070KV-3B; Sat, 14 Oct 2023 12:06:47 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 14 Oct 2023 12:06:50 +0800
Date:   Sat, 14 Oct 2023 12:06:50 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Denis Kenzior <denkenz@gmail.com>
Cc:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        James Prestwood <prestwoj@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] crypto: remove md4 driver
Message-ID: <ZSoT2loMni1PWqiq@gondor.apana.org.au>
References: <20231008040140.1647892-1-dimitri.ledkov@canonical.com>
 <ZSkeWHdOAOfjtpwJ@gondor.apana.org.au>
 <2e52c8b4-e70a-453f-853a-1962c8167dfa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e52c8b4-e70a-453f-853a-1962c8167dfa@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 09:37:52AM -0500, Denis Kenzior wrote:
>
> Does this patch break userspace?
> 
> Here's a thread regarding MD4 the last time its removal was attempted:
> https://lore.kernel.org/linux-crypto/20210818144617.110061-1-ardb@kernel.org/
> 
> Please note that iwd does use MD4 hashes here:
> https://git.kernel.org/pub/scm/libs/ell/ell.git/tree/ell/checksum.c#n63
> 
> https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/src/eap-mschapv2.c#n165

I've backed this out for now.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
