Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949977F5A0E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 09:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344952AbjKWIcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 03:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235027AbjKWIck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 03:32:40 -0500
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556D8D56
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 00:32:45 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1r658Y-002hsk-JM; Thu, 23 Nov 2023 16:32:39 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 23 Nov 2023 16:32:47 +0800
Date:   Thu, 23 Nov 2023 16:32:47 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, Thomas Graf <tgraf@suug.ch>
Subject: Re: [PATCH] rhashtable: Better error message on allocation failure
Message-ID: <ZV8OLxA4ewCf3fEt@gondor.apana.org.au>
References: <20231122233225.178910-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122233225.178910-1-kent.overstreet@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 06:32:16PM -0500, Kent Overstreet wrote:
> Memory allocation failures print backtraces by default, but when we're
> running out of a rhashtable worker the backtrace is useless - it doesn't
> tell us which hashtable the allocation failure was for.
> 
> This adds a dedicated warning that prints out functions from the
> rhashtable params, which will be a bit more useful.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Thomas Graf <tgraf@suug.ch>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> ---
>  lib/rhashtable.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

However, you'll need to repost this via netdev@vger.kernel.org for
it to be merged.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
