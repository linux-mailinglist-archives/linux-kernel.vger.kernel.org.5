Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AD276FD1B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjHDJUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjHDJT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:19:56 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFFF55A3
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 02:16:18 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qRqus-003b6j-2h; Fri, 04 Aug 2023 17:16:15 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 04 Aug 2023 17:16:14 +0800
Date:   Fri, 4 Aug 2023 17:16:14 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Mark O'Donovan <shiftee@posteo.net>
Cc:     linux-kernel@vger.kernel.org, ebiggers@google.com
Subject: Re: [PATCH] lib/mpi: avoid null pointer deref in mpi_cmp_ui()
Message-ID: <ZMzB3t60T9od70Dl@gondor.apana.org.au>
References: <20230724000727.3281733-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724000727.3281733-1-shiftee@posteo.net>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 12:07:27AM +0000, Mark O'Donovan wrote:
> During NVMeTCP Authentication a controller can trigger a kernel
> oops by specifying the 8192 bit Diffie Hellman group and passing
> a correctly sized, but zeroed Diffie Hellamn value.
> mpi_cmp_ui() was detecting this if the second parameter was 0,
> but 1 is passed from dh_is_pubkey_valid(). This causes the null
> pointer u->d to be dereferenced towards the end of mpi_cmp_ui()
> 
> Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
> ---
>  lib/mpi/mpi-cmp.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Could you please resend this to linux-crypto?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
