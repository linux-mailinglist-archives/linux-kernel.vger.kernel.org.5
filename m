Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28377A41DB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236297AbjIRHLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240091AbjIRHLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:11:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCE811A;
        Mon, 18 Sep 2023 00:10:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 52B77219A8;
        Mon, 18 Sep 2023 07:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695021058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h8LoirZ0+RzsValGwcKMX5/tGVuF0UyLaQfS4YOgCT0=;
        b=Gkx0cZ5AWhKGCQ9d48JZcTEzkWSjOZ/gnmwWiaJGL85DrqDg+/Ve0eiOGNVLmNCi1VachG
        s94/ha+Y5rXci7dXBoCb9agOXP3hAx2k7wX4pbVGICfnl6uBz+js/CFHKREcDUgSF6Y/D6
        u64l6ue6zkcpDEbvTqGpqYowqxFXTuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695021058;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h8LoirZ0+RzsValGwcKMX5/tGVuF0UyLaQfS4YOgCT0=;
        b=4oFro4bRv693Da50NSOwDV6r2C9Dsm/K3bU6VNqWiHwz4tLkOk8zqWgnjd/1Lnfd6dTYhz
        AhQQfpC95H4HCtDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 41FAD13480;
        Mon, 18 Sep 2023 07:10:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5eIPEAL4B2U8TAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 18 Sep 2023 07:10:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id AD26AA0759; Mon, 18 Sep 2023 09:10:57 +0200 (CEST)
Date:   Mon, 18 Sep 2023 09:10:57 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Kees Cook <keescook@chromium.org>, Jan Kara <jack@suse.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] udf: Annotate struct udf_bitmap with __counted_by
Message-ID: <20230918071057.5q64pz3b7tc3x3z5@quack3>
References: <20230915201404.never.574-kees@kernel.org>
 <118576aa-a667-8c91-821a-351562dc4c61@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <118576aa-a667-8c91-821a-351562dc4c61@embeddedor.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 15-09-23 14:50:14, Gustavo A. R. Silva wrote:
> 
> 
> On 9/15/23 14:14, Kees Cook wrote:
> > Prepare for the coming implementation by GCC and Clang of the __counted_by
> > attribute. Flexible array members annotated with __counted_by can have
> > their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> > (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> > functions).
> > 
> > As found with Coccinelle[1], add __counted_by for struct udf_bitmap.
> > 
> > [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> > 
> > Cc: Jan Kara <jack@suse.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks. I've queued the patch to my tree.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
