Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB6D755ABB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 07:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjGQFFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 01:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGQFFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 01:05:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671B0E51;
        Sun, 16 Jul 2023 22:05:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6E8E60F1D;
        Mon, 17 Jul 2023 05:05:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4297C433C8;
        Mon, 17 Jul 2023 05:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689570340;
        bh=f1/1Qm7+ghUulCXlp4Wtc+jVt4wBjXfAiwQ5BfkAqcw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rCB5wKuDjH/kjrepsmuDiFjCX4Rz2GCWQHNp6m7Zz0CLBXHn9+4OpduqfPa9VH0qL
         oUSk/56nYZFOFbmNxRED2/ahJDTqCjqRah//2YSEbdxP5ui1yDg5oJYONYC6vBAOry
         bx2QLAYfr2NNJ4EeAd2F40tLsyPuKHadJr6yW7WQxh+3DlUU1+VZNklwZfOQcNiRmP
         OJ4tQF9YmQZRMJZqyaLaSkIMRiVHgwjjZn4n4gnBEi15YkBse5U8by8bbRZ9Um+G5h
         czP1kh46Q63RpN3xEOyCY0wCOeIki4hi19WDZCC1urYZD/cPUpbdlqk2H5GYF3AY0l
         1vly28QLaZ3xQ==
Date:   Mon, 17 Jul 2023 08:05:37 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tags need some work in the rdma-fixes tree
Message-ID: <20230717050537.GA9461@unreal>
References: <20230717073649.5fc71a09@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717073649.5fc71a09@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 07:36:49AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   e77ac83ee5fd ("RDMA/irdma: Fix data race on CQP request done")
> 
> Fixes tag
> 
>   Fixes: 915cc7ac0f8 ("RDMA/irdma: Add miscellaneous utility definitions")
> 
> has these problem(s):
> 
>   - SHA1 should be at least 12 digits long
> 
> In commit
> 
>   df56ce725d7c ("RDMA/irdma: Fix data race on CQP completion stats")
> 
> Fixes tag
> 
>   Fixes: 915cc7ac0f8 ("RDMA/irdma: Add miscellaneous utility definitions")
> 
> has these problem(s):
> 
>   - SHA1 should be at least 12 digits long
> 
> In commit
> 
>   13120f2d08fd ("RDMA/irdma: Add missing read barriers")
> 
> Fixes tag
> 
>   Fixes: 3f49d684256 ("RDMA/irdma: Implement HW Admin Queue OPs")
> 
> has these problem(s):
> 
>   - SHA1 should be at least 12 digits long
> 
> This can be fixed for the future by setting core.abbrev to 12 (or
> more) or (for git v2.11 or later) just making sure it is not set
> (or set to "auto").

Thanks, fixed.

> 
> -- 
> Cheers,
> Stephen Rothwell


