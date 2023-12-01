Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7CB800A00
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378592AbjLALlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 06:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378541AbjLALlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:41:06 -0500
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709F41704;
        Fri,  1 Dec 2023 03:41:12 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1r91tG-005jtE-EO; Fri, 01 Dec 2023 19:41:03 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 01 Dec 2023 19:41:11 +0800
Date:   Fri, 1 Dec 2023 19:41:11 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Edward Adam Davis <eadavis@qq.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, olivia@selenic.com,
        syzbot+c52ab18308964d248092@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] hwrng: core - fix task hung in hwrng_fillfn
Message-ID: <ZWnGV39HJr9uUB2/@gondor.apana.org.au>
References: <ZWmt6wrbxN1W+cnv@gondor.apana.org.au>
 <tencent_0AD55DB29954CFB30D9825850DEE12325D07@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_0AD55DB29954CFB30D9825850DEE12325D07@qq.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 07:37:39PM +0800, Edward Adam Davis wrote:
>
> Reduce the scope of critical zone protection.
> The original critical zone contains a too large range, especially like 
> copy_to_user() should not be included in the critical zone.

Which part in particular is taking 143 seconds? The buffer is
only 128 bytes long.  Why is a 128-byte copy taking 143 seconds,
even with a page fault?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
