Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104077BE1FF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377585AbjJIOAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376693AbjJIOAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:00:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327CD99;
        Mon,  9 Oct 2023 07:00:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F54C433C7;
        Mon,  9 Oct 2023 14:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696860050;
        bh=8dVUagdGNC5FwwkHDRtNMhAMiOn3f8fiNVQH6CjW9lk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lDw4VxspF/aZja0dt3g0BaHJnFbxKKkpUeJguSagp5qXuIpaucUoP41n6vjvZh10U
         EzTkmw2cZVhFN03Q1LJvyKD0Wp56nyR26OF2FPfuAipuEJfrv4VpRCTUf0u7vjb5f+
         t4cf1tIMF4JpOuU58XjrKA3PcfmSKHz+c9Pp7pVsmgRL2TVqVQODGX8bMh85ciquDH
         C1c85X94mrTXJcg4auQnBeH99suZ5w9GF5lukK6iyTdO2ZenEYGkTLf2YDPr11lIcg
         Ok2Z5B+eENtNltp4gRiJUNGfmF6FJd5wJ/ieiRyXliF4TuvarT6/QcmV8CsIdl10FI
         7j0ICfeq3+W5A==
Date:   Mon, 9 Oct 2023 16:00:41 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the vfs-brauner tree
Message-ID: <20231009-behaarten-hotel-17e3c1e7de74@brauner>
References: <20230928105443.1b1ad98c@canb.auug.org.au>
 <20231002112142.bfjj54ikijf4iwfr@quack3>
 <20231003132711.djftyh7vltljy2hh@moria.home.lan>
 <20231004154628.kgrvqbwphkjbkne6@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231004154628.kgrvqbwphkjbkne6@quack3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> But the merge at this point would be somewhat difficult because you'd need
> to pull Christian's branch into your tree to get bdev_open_by_path() in the
> first place. And that branch already depends on some changes in the btrfs
> tree. So to save ourselves some headaches during the merge window, I think
> not removing the old functions until bcachefs gets merged is the easiest
> solution.

I dropped

commit 8ea3ec0740bdea9105eb416f07eef5d031b9385a
Author:     Jan Kara <jack@suse.cz>
AuthorDate: Wed Sep 27 11:34:35 2023 +0200
Commit:     Christian Brauner <brauner@kernel.org>
CommitDate: Thu Sep 28 16:51:49 2023 +0200

    block: Remove blkdev_get_by_*() functions

    blkdev_get_by_*() and blkdev_put() functions are now unused. Remove
    them.

    Acked-by: Christoph Hellwig <hch@lst.de>
    Reviewed-by: Christian Brauner <brauner@kernel.org>
    Signed-off-by: Jan Kara <jack@suse.cz>
    Link: https://lore.kernel.org/r/20230927093442.25915-29-jack@suse.cz
    Signed-off-by: Christian Brauner <brauner@kernel.org>

for now. You can find an archive of that branch including that commit
under the tag vfs.super.2023-10-09

Thanks!
