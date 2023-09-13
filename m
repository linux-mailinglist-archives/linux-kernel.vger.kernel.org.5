Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7457E79E2FD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 11:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239233AbjIMJJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 05:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjIMJJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:09:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8B41999
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 02:09:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E95E8218E2;
        Wed, 13 Sep 2023 09:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694596163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N8aXtXyU167osDlSPQvFZ9ThP1MOOP1aetre3kE6nKU=;
        b=DRHVny3HUUBEaMmrOsH2kdzAnQJ4tYB/qHh922kDbFAohoUHFDncgn0/lhM3B05j0uDqwC
        MyZvXj6145tCoQRHqu33Vy0x+AjqHJi2fOmLmjMhGvlqJbLSnFXohXboGi3T9i0SK7Ef14
        yoY6jDHIIDeu21gzmiVTbs014S8yEGU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694596163;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N8aXtXyU167osDlSPQvFZ9ThP1MOOP1aetre3kE6nKU=;
        b=rHQIPJPlkBJPzfWqSPRzbcOJZGufJflsrFPKITe8/FD0SG+EQ50qjqCnbRztY4B/fSq6yt
        R50g0/1BtOz7qQCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D4C9E13582;
        Wed, 13 Sep 2023 09:09:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 90l2M0N8AWUJOgAAMHmgww
        (envelope-from <chrubis@suse.cz>); Wed, 13 Sep 2023 09:09:23 +0000
Date:   Wed, 13 Sep 2023 11:10:10 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Edward AD <eadavis@sina.com>,
        syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com,
        lkp@intel.com, syzkaller-bugs@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        oe-lkp@lists.linux.dev, akpm@linux-foundation.org,
        ltp@lists.linux.it
Subject: Re: [LTP] [PATCH] mm: as the same logic with queue_pages_range
Message-ID: <ZQF8cn4k1qqdYj8x@yuki>
References: <20230906061902.591996-1-eadavis@sina.com>
 <202309121302.8864096c-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202309121302.8864096c-oliver.sang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> Running tests.......
> <<<test_start>>>
> tag=vma02 stime=1694438526
> cmdline="vma02"
> contacts=""
> analysis=exit
> <<<test_output>>>
> vma02       0  TINFO  :  pid = 3639 addr = 0x7f5202dd6000
> vma02       0  TINFO  :  start = 0x7f5202dd6000, end = 0x7f5202dd7000
> vma02       0  TINFO  :  start = 0x7f5202dd7000, end = 0x7f5202dd8000
> vma02       0  TINFO  :  start = 0x7f5202dd8000, end = 0x7f5202dd9000
> vma02       1  TFAIL  :  vma02.c:144: >1 unmerged VMAs.
> incrementing stop

So the test is reproducer for:

commit 9d8cebd4bcd7c3878462fdfda34bbcdeb4df7ef4
Author: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Date:   Fri Mar 5 13:41:57 2010 -0800

    mm: fix mbind vma merge problem

    Strangely, current mbind() doesn't merge vma with neighbor vma although it's possible.
    Unfortunately, many vma can reduce performance...


And what the test does is:

- map 3 continous pages
- popluate
- mbind() first page
- mbind() all three pages
- checks that there is only single VMA for the pages after second
  mbind()

-- 
Cyril Hrubis
chrubis@suse.cz
