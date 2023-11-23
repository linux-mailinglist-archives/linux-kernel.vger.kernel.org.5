Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954167F69A0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 00:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjKWX6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 18:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKWX6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 18:58:42 -0500
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B61D54
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 15:58:46 -0800 (PST)
Date:   Thu, 23 Nov 2023 18:58:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700783924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uXzEssVckVuprVJisGRjCNWWyovdjXQldqf773mP1Pk=;
        b=kpdKfBK+m3STIxKMbE73XXnpN+UWlR2h6i9nrBq9639x7utElzFyzp9zWUVy/paOuQ5Nvc
        Od4PlteSRmzlBXjNYuWAS/G4pCpocAGDb2faLXg6k4GlFM5jZXq19qlwkNe+Bdv2sVbSoz
        dWSNcZ3s0g6p82+l396/YMGXkHoLC7o=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-kernel@vger.kernel.org, Thomas Graf <tgraf@suug.ch>
Subject: Re: [PATCH] rhashtable: Better error message on allocation failure
Message-ID: <20231123235840.76nk3grth2sqmonc@moria.home.lan>
References: <20231122233225.178910-1-kent.overstreet@linux.dev>
 <ZV8OLxA4ewCf3fEt@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV8OLxA4ewCf3fEt@gondor.apana.org.au>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 04:32:47PM +0800, Herbert Xu wrote:
> On Wed, Nov 22, 2023 at 06:32:16PM -0500, Kent Overstreet wrote:
> > Memory allocation failures print backtraces by default, but when we're
> > running out of a rhashtable worker the backtrace is useless - it doesn't
> > tell us which hashtable the allocation failure was for.
> > 
> > This adds a dedicated warning that prints out functions from the
> > rhashtable params, which will be a bit more useful.
> > 
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Cc: Thomas Graf <tgraf@suug.ch>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > ---
> >  lib/rhashtable.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> However, you'll need to repost this via netdev@vger.kernel.org for
> it to be merged.

Thanks!
