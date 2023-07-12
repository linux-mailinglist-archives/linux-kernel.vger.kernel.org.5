Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC24751098
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 20:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjGLSeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 14:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjGLSeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 14:34:13 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD00E77
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 11:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689186852; x=1720722852;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fzeqHp7tyE/YJ6Hhq0Az+HA7iwMS9ASPfg9HhLFprU0=;
  b=WwbaJX1pLgyyd1Q3VheC9a3E3dFW4evoCLZUx5yClvR4EV3u2hTWqmby
   pe8s3cnpdIvsOEehl5TMgWGGchMqR9kV3i5shW9Tb6rlNBRjBgdmHWDQU
   /7S/DmQzlBnM1iQ7kbB2xV+g9BNLtCyR+sjNWoUr+VitLHcrJWQIOPfao
   RVn+xx8W/dw8IQyFTaDSdrETTbvft+9jDz+F8hov6Y3/hz3vzkx3wuQXD
   QyHCEKbX1mOjkJlGGjGipa5phkEEA+ibYTyy1KRAzxU6ScMSTnvJKcmxo
   aJHfl1gSYKSBGCR37bOr3b5t8/dhG/XezejcIU8KhQuDsyxiNNb3n/R1L
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="349827958"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="349827958"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 11:34:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="715663208"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="715663208"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga007.jf.intel.com with ESMTP; 12 Jul 2023 11:34:11 -0700
Date:   Wed, 12 Jul 2023 11:36:53 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Remove repeated words in a comment
Message-ID: <20230712183653.GB27117@ranerica-svr.sc.intel.com>
References: <20230707024420.93140-1-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707024420.93140-1-rui.zhang@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 10:44:20AM +0800, Zhang Rui wrote:
> Remove repeated words in a comment.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  kernel/sched/fair.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a80a73909dc2..2d6f47eecb66 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10700,8 +10700,8 @@ asym_active_balance(struct lb_env *env)
>  	/*
>  	 * ASYM_PACKING needs to force migrate tasks from busy but lower
>  	 * priority CPUs in order to pack all tasks in the highest priority
> -	 * CPUs. When done between cores, do it only if the whole core if the
> -	 * whole core is idle.
> +	 * CPUs. When done between cores, do it only if the whole core is
> +	 * idle.

Ah! I missed this.

FWIW, Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
