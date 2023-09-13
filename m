Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BC779DE36
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 04:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238129AbjIMCTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 22:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbjIMCTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 22:19:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2205D170A;
        Tue, 12 Sep 2023 19:19:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CD3C433C7;
        Wed, 13 Sep 2023 02:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694571544;
        bh=njmsIlOnk+gidOj5TYyhHjoryn9sBCUbcma0uf7HMBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XSvHS/hye/UJjDrLEPyZf5DnYoDMd+K15naBeARtblPyCUgjhrfh2PCit5cCqr5Ve
         pOPhlqy/YNeXw0rBYgbnRGe5IVh2wkl0m3qiZvlZtSlTWqaEYmUxz53wo1oP7eQy56
         Kquv7UkhxQFtT8V2sS4sO1t/4MRg/TncpvJMpTyDUhXlYRfLFIZRZpmEeT6lYpt9ic
         iruUZJ2N1p74cygzEEEshZCempXyhZN4sHsU72WApgk2CMuNamGJty0jJoGlGe19n8
         T4b8nSZrMt6pNbaLyBoXrRPtA5V+8G+qk0hNBomgDyfHp3P/denTlE0EoOVlszQxyY
         vIC46VLlEW4Xg==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (no title)
Date:   Wed, 13 Sep 2023 02:19:02 +0000
Message-Id: <20230913021902.1993-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230912183559.4733-1-sj@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, 12 Sep 2023 18:35:57 +0000 SeongJae Park <sj@kernel.org> wrote:

> Date: Tue, 12 Sep 2023 02:24:11 +0000
> Subject: [PATCH v2 0/2] mm/damon: add a tracepoint for damos apply target regions

I added a blank line in the header of the original patch, and it resulted in
this weird no-title mail, sorry.  I will rebase this on latest mm-unstable and
resend.


Thanks,
SJ

> 
> Changlog
> --------
> 
> From v1
> (https://lore.kernel.org/damon/20230911045908.97649-1-sj@kernel.org/)
> - Get scheme/target indices only when the trace is enabled (Steven Rostedt)
> 
> From RFC
> (https://lore.kernel.org/damon/20230827004045.49516-1-sj@kernel.org/)
> - Fix the 4 byte hole (Steven Rostedt)
> - Add documentation
> 
> Description
> -----------
> 
> DAMON provides damon_aggregated tracepoint to let users record full monitoring
> results.  Sometimes, users need to record monitoring results of specific
> pattern.  DAMOS tried regions directory of DAMON sysfs interface allows it, but
> the interface is mainly designed for snapshots and therefore would be
> inefficient for such recording.  Implement yet another tracepoint for efficient
> support of the usecase.
> 
> 
> SeongJae Park (2):
>   mm/damon/core: add a tracepoint for damos apply target regions
>   Docs/admin-guide/mm/damon/usage: document damos_before_apply
>     tracepoint
> 
>  Documentation/admin-guide/mm/damon/usage.rst | 37 +++++++++++++++----
>  include/trace/events/damon.h                 | 39 ++++++++++++++++++++
>  mm/damon/core.c                              | 32 +++++++++++++++-
>  3 files changed, 100 insertions(+), 8 deletions(-)
> 
> 
> base-commit: b67dc18d1406be3598248d2cc78904a81176fa13
> -- 
> 2.25.1
> 
