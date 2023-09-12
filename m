Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690E479CFDB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbjILL1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234703AbjILL1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:27:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06431721;
        Tue, 12 Sep 2023 04:26:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A6ECE212AE;
        Tue, 12 Sep 2023 11:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694518006;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q9JhXdCy9bma9ysFoTsLUThteBCBnpRHj2yaGJinfGk=;
        b=VYkHhBcM0IvTv46yVWaKjXaD0//taNU/FDwmuNbPONoAMsS1AqA9lDzgfku18SExnPfnyD
        7nIp6THXuwChb6/Y/0lnjdw9BvtkeOIIGzuWwSDvHJRX317ymYSuC2xJcMeTvmZZ50skRy
        1hcQ5NbqPEGWsEt4HUsrKynR51YIBws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694518006;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q9JhXdCy9bma9ysFoTsLUThteBCBnpRHj2yaGJinfGk=;
        b=04wWBhxQxVCu/twy5dtDl1Hy4zvhyNcCZcdG/T3pkefrQSZ4g8phMBMl3+H0ft4BwBeHBX
        4soc1wm1Gwu+hpCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7CF37139DB;
        Tue, 12 Sep 2023 11:26:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wRCeHfZKAGWIdAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 12 Sep 2023 11:26:46 +0000
Date:   Tue, 12 Sep 2023 13:20:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the btrfs tree
Message-ID: <20230912112011.GB20408@suse.cz>
Reply-To: dsterba@suse.cz
References: <20230912104646.3a9140f7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912104646.3a9140f7@canb.auug.org.au>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 10:46:46AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the btrfs tree, today's linux-next build (powerpc
> ppc64_defconfig) produced these warnings:
> 
> In file included from include/linux/swab.h:5,
>                  from include/uapi/linux/byteorder/big_endian.h:14,
>                  from include/linux/byteorder/big_endian.h:5,
>                  from arch/powerpc/include/uapi/asm/byteorder.h:14,
>                  from include/asm-generic/bitops/le.h:6,
>                  from arch/powerpc/include/asm/bitops.h:336,
>                  from include/linux/bitops.h:68,
>                  from fs/btrfs/extent_io.c:3:
> In function 'btrfs_disk_key_to_cpu',
>     inlined from 'btrfs_item_key_to_cpu' at fs/btrfs/accessors.h:648:2,
>     inlined from 'fiemap_find_last_extent_offset' at fs/btrfs/extent_io.c:2804:2,
>     inlined from 'extent_fiemap' at fs/btrfs/extent_io.c:2879:8:
> include/uapi/linux/swab.h:128:28: warning: 'disk_key.objectid' may be used uninitialized [-Wmaybe-uninitialized]
>   128 | #define __swab64(x) (__u64)__builtin_bswap64((__u64)(x))
>       |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/uapi/linux/byteorder/big_endian.h:33:26: note: in expansion of macro '__swab64'
>    33 | #define __le64_to_cpu(x) __swab64((__force __u64)(__le64)(x))
>       |                          ^~~~~~~~
> include/linux/byteorder/generic.h:87:21: note: in expansion of macro '__le64_to_cpu'
>    87 | #define le64_to_cpu __le64_to_cpu
>       |                     ^~~~~~~~~~~~~
> fs/btrfs/accessors.h:622:25: note: in expansion of macro 'le64_to_cpu'
>   622 |         cpu->objectid = le64_to_cpu(disk->objectid);
>       |                         ^~~~~~~~~~~
> In file included from fs/btrfs/extent_io.c:34:
> fs/btrfs/accessors.h: In function 'extent_fiemap':
> fs/btrfs/accessors.h:645:31: note: 'disk_key.objectid' was declared here
>   645 |         struct btrfs_disk_key disk_key;
>       |                               ^~~~~~~~
> In function 'fiemap_find_last_extent_offset',
>     inlined from 'extent_fiemap' at fs/btrfs/extent_io.c:2879:8:
> fs/btrfs/extent_io.c:2805:33: warning: 'disk_key.type' may be used uninitialized [-Wmaybe-uninitialized]
>  2805 |         if (key.objectid != ino || key.type != BTRFS_EXTENT_DATA_KEY) {
> fs/btrfs/accessors.h: In function 'extent_fiemap':
> fs/btrfs/accessors.h:645:31: note: 'disk_key.type' was declared here
>   645 |         struct btrfs_disk_key disk_key;
>       |                               ^~~~~~~~
> 
> I don't really have any idea what caused this (it *may* have been my
> change from gcc v12 to v13?).

I tried 12 and 13, no warnings on x86_64, however the report is on
powerpc. If this is on a big endian host it could be a valid warning, we
have an optmization where the on-disk format endianity matches CPU
(little endian) then the structures btrfs_disk_key and btrfs_key are
equivalent and no coversion is needed.

There were some changes that might be related and newly added to
for-next so we don't have any other reference point, I'll take a look.
