Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F94754364
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 21:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236072AbjGNTpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 15:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236203AbjGNTpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 15:45:11 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7822D57;
        Fri, 14 Jul 2023 12:45:10 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E45505BF;
        Fri, 14 Jul 2023 19:45:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E45505BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1689363910; bh=9OVkrDxVo6A8WjUDU3AQWi2pZQRzBF2hWL+uV9EMi1g=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ANq8x1n7PadXgahfP2nzKXNTDfFTWa3BbWdyMolgk4uSDitLr7TMl5M3g4+i4dE91
         hsR/poL7G8l/tEz9c8zFsSrinOLJ1ERiwfYyYtaPmBfGvk7bcqKij055X0aQ5+cxDS
         GJk4/0V29H8vBoiB9hFdHGPITm9BgXKx/+47obuQFhv/Wld+LiMpPVByuKtlkYrP5t
         Fy+H9yhpoxdxSCusZ7kArhtO+2TiHZiC6/m4KwowWsPbZP1LmSO1V4qV88ChcZAAaV
         Gsdla5Jx3eUxySSW5tswO35JrVB+w/jdpI6On+oAdoFamUP8hZvdIfbJiM0mVO3nV3
         Io/hypcwkBDDA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Deming Wang <wangdeming@inspur.com>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Collingbourne <pcc@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3] Documentation/highmem: Add information about
 kmap_local_folio()
In-Reply-To: <20230708121719.8270-1-fmdefrancesco@gmail.com>
References: <20230708121719.8270-1-fmdefrancesco@gmail.com>
Date:   Fri, 14 Jul 2023 13:45:09 -0600
Message-ID: <87r0paxooq.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Fabio M. De Francesco" <fmdefrancesco@gmail.com> writes:

> The differences between kmap_local_page() and kmap_local_folio() consist
> only in the first taking a pointer to a page and the second taking two
> arguments, a pointer to a folio and the byte offset within the folio which
> identifies the page.
>
> The two API's can be explained at the same time in the "Temporary Virtual
> Mappings" section of the Highmem's documentation.
>
> Add information about kmap_local_folio() in the same subsection that
> explains kmap_local_page().
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Peter Collingbourne <pcc@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Will Deacon <will@kernel.org>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>
> v2->v3:	Replaced "request" with "create". Noticed by Randy (thanks),
> 	fixed by Matthew (again thanks).
> 	https://lore.kernel.org/lkml/970a881a-cdaf-2568-657a-3b93b0273338@infradead.org/
>
> v1-v2:	I had Cc'ed everybody but Andrew :-( Sorry, it's now fixed.
> 	In the meantime, I collected the review tags by Ira and Mike
> 	(thanks to both of you). All entries are listed using a simple
> 	ascending lexycographycal order based on first names.
>
>  Documentation/mm/highmem.rst | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)

Applied, thanks.

jon
