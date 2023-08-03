Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A658876E538
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbjHCKGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjHCKGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:06:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE43FC;
        Thu,  3 Aug 2023 03:06:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9BF541F86A;
        Thu,  3 Aug 2023 10:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691057208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YH4x5r0551oMePHWmYnqhlhEYKLHr0edawSikUPOQgw=;
        b=nrULm3zZC+YfQQLavQzxyNyfRHuYMyi+5bS8xyB91XXPj1EqBstrl8NDS7gdqjbzeQUug7
        a9BbAJgvRhpTJ3G1mPjlkVq2BywSHurLB6yDeRoRQatYCngAQCfpUaelUf7b3QWNPsuUWT
        p+HXypnSCDoULicq4hcY9ZO1ohzSGN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691057208;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YH4x5r0551oMePHWmYnqhlhEYKLHr0edawSikUPOQgw=;
        b=XBrYLiiOFZ1C0EiAnyTcCq2KK9ONdy1l4bAZYifJmdobjD63C7dMZbZ/cwjVXkVRkgYYBz
        Rn713JckSQc8PoCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8ED201333C;
        Thu,  3 Aug 2023 10:06:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id F6/VIjh8y2T8CAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 03 Aug 2023 10:06:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2ACB1A076B; Thu,  3 Aug 2023 12:06:48 +0200 (CEST)
Date:   Thu, 3 Aug 2023 12:06:48 +0200
From:   Jan Kara <jack@suse.cz>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        Carlos Maiolino <cem@kernel.org>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the vfs-brauner tree
Message-ID: <20230803100648.jeve2ifulusvi6co@quack3>
References: <20230803100303.1cd82ae8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803100303.1cd82ae8@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Thu 03-08-23 10:03:03, Stephen Rothwell wrote:
> After merging the vfs-brauner tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> mm/shmem.c: In function 'shmem_enable_quotas':
> mm/shmem.c:284:23: error: implicit declaration of function 'dquot_load_quota_sb'; did you mean 'dquot_load_quota_inode'? [-Werror=implicit-function-declaration]
>   284 |                 err = dquot_load_quota_sb(sb, type, QFMT_SHMEM,
>       |                       ^~~~~~~~~~~~~~~~~~~
>       |                       dquot_load_quota_inode
> 
> Caused by commit
> 
>   220a17f613eb ("shmem: quota support")
> 
> interacting with commit
> 
>   9543f84c067d ("quota: mark dquot_load_quota_sb static")
> 
> from the ext3 tree.
> 
> I have reverted the ext3 tree patch for today.

Thanks for letting me know. I've reverted the commit 9543f84c067d from my
tree.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
