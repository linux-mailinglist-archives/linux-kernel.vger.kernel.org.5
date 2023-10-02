Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA027B5003
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 12:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236401AbjJBKRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 06:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236414AbjJBKQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 06:16:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3182D197
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 03:16:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F01C433CA;
        Mon,  2 Oct 2023 10:16:50 +0000 (UTC)
Date:   Mon, 2 Oct 2023 11:16:48 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 4/4] mm/gup: adapt get_user_page_vma_remote() to never
 return NULL
Message-ID: <ZRqYkHXmiBg+PfQM@arm.com>
References: <cover.1696174961.git.lstoakes@gmail.com>
 <b57d5f6618818f2f781a664039ace025c932074c.1696174961.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b57d5f6618818f2f781a664039ace025c932074c.1696174961.git.lstoakes@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2023 at 05:00:05PM +0100, Lorenzo Stoakes wrote:
> get_user_pages_remote() will never return 0 except in the case of
> FOLL_NOWAIT being specified, which we explicitly disallow.
> 
> This simplifies error handling for the caller and avoids the awkwardness of
> dealing with both errors and failing to pin. Failing to pin here is an
> error.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  arch/arm64/kernel/mte.c |  4 ++--

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
