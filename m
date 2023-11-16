Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156517EE316
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbjKPOku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbjKPOkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:40:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A15C4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L9kXXXn3aJGAPD5UxD244hDDhKrswiOK7ITBCUVRwbk=; b=ae0itXsopz0McaVrIPsZ4DFdVi
        wixazVLB9i+2Mz4OIzjEvlKdf+qfb0izhdDt4kZWDiuFPPVbdFdF2qvraZLrbw2GqfAmVaROdyhkM
        jT3B4x2KvnAl9nowHDr+LhhfFQhlDDRYvX1Bm+BYgws+Pg02X6HxjX4GsR+iNbLe1k78bcDvHGtdF
        n94d3kH44O1RVBQz5OqmoWUKpInl1igExtu3h6DONz0fARyU0U+8v3LZ8yEASRgCL1bfj/NP86hLu
        D4iTr3WNOjOJDyDKqFx5Ezfu9yDR1uK+shyKbHF9NF1XUL1JBYmI/cR/9IILujVqWF8zl8Ehvczso
        B0x1DBwA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r3dXm-003Y68-Q3; Thu, 16 Nov 2023 14:40:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 774D130017D; Thu, 16 Nov 2023 15:40:34 +0100 (CET)
Date:   Thu, 16 Nov 2023 15:40:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        artem.bityutskiy@linux.intel.com, rui.zhang@intel.com
Subject: Re: [RESEND PATCH 2/4] x86/smp: Export symbol cpu_clustergroup_mask
Message-ID: <20231116144034.GG8262@noisy.programming.kicks-ass.net>
References: <20231116142245.1233485-1-kan.liang@linux.intel.com>
 <20231116142245.1233485-2-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116142245.1233485-2-kan.liang@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 06:22:43AM -0800, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Intel cstate PMU driver will invoke the topology_cluster_cpumask() to
> retrieve the CPU mask of a cluster. A modpost error is triggered since
> the symbol cpu_clustergroup_mask is not exported.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  arch/x86/kernel/smpboot.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 48e040618731..376387ca6be5 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -747,6 +747,7 @@ const struct cpumask *cpu_clustergroup_mask(int cpu)
>  {
>  	return cpu_l2c_shared_mask(cpu);
>  }
> +EXPORT_SYMBOL(cpu_clustergroup_mask);

I made that _GPL.

Queued the lot.
