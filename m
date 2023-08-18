Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5127278073C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 10:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358634AbjHRIeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 04:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358672AbjHRIeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 04:34:01 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A575D3AB8;
        Fri, 18 Aug 2023 01:33:53 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qWuvM-005ETi-R3; Fri, 18 Aug 2023 16:33:41 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 18 Aug 2023 16:33:41 +0800
Date:   Fri, 18 Aug 2023 16:33:41 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     meenakshi.aggarwal@nxp.com
Cc:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Linux regression tracking #adding (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>, Bastian Krause <bst@pengutronix.de>,
        Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: [PATCH] Revert "crypto: caam - optimize RNG sample size"
Message-ID: <ZN8s5UL1SuJOQtKh@gondor.apana.org.au>
References: <20230814053239.608702-1-meenakshi.aggarwal@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814053239.608702-1-meenakshi.aggarwal@nxp.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,TVD_RCVD_IP,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 07:32:39AM +0200, meenakshi.aggarwal@nxp.com wrote:
> From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> 
> This reverts commit 1abc89661ad3cd18d8c6af5c2584bcc63df43bf2.
> 
> Reverting the commit because of RNG instantiation failure
> observed on imx8mm board.
> 
> Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> ---
>  drivers/crypto/caam/ctrl.c | 52 +++++++++++++++-----------------------
>  drivers/crypto/caam/regs.h | 14 ++--------
>  2 files changed, 22 insertions(+), 44 deletions(-)

This isn't the patch that was being discussed.  The offending
patch was ef492d08030 ("crypto: caam - adjust RNG timing to support
more devices").

I'll revert that one instead of this.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
