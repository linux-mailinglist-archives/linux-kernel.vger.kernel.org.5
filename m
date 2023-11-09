Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728377E71AE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 19:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345021AbjKISq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 13:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344906AbjKISqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 13:46:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84253185
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 10:46:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA416C433C7;
        Thu,  9 Nov 2023 18:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699555613;
        bh=8pdUvdeeJt1xYI9bSzOjOml7hRUfXdZgRf47A7GvhaM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eLfEagyvP0/lXHGkH87W0+RL0faa6ZzHs3yCG5cqKp5vfEkfVhLauLiNp/0BHfUPD
         Z4rDRxGdSF+Xu/I6ZIxmRSiioiY1IR/J/NUdHJKlJ5Y7ps9C+G5ojU08h+adukGoW+
         n2GHXu/rMxu+Jc0OKNGars8FnZ0GiGpy5uTcT53oUm6ds8qpc6p/FyRxNRGYTNR9YS
         emrGugG3sa9jDf18w1VmMvCw0Lthv33LMQE/yuBo4jMHqZXPAtW/Fb36rDmve93EAq
         xovOqG8RMvZMxYmA7knV3Q0pnveZS/8kTs4TsVNlf88QNpPVqKTSeC2Hu9EE/djehn
         S2pJ83iSk6cxg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 196DE40094; Thu,  9 Nov 2023 15:46:50 -0300 (-03)
Date:   Thu, 9 Nov 2023 15:46:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com
Subject: Re: [PATCH V5 2/8] perf/x86: Add PERF_X86_EVENT_NEEDS_BRANCH_STACK
 flag
Message-ID: <ZU0pGuUBJH+bF1yU@kernel.org>
References: <20231025201626.3000228-1-kan.liang@linux.intel.com>
 <20231025201626.3000228-2-kan.liang@linux.intel.com>
 <ZUlWuROfYcYJlRn4@kernel.org>
 <fb1ebf48-ac2f-499a-b480-ba8474b12200@linux.intel.com>
 <ZUpTtoCzJFHhnSdh@kernel.org>
 <ZUv+G+w5EvJgQS45@kernel.org>
 <a40ff4eb-5507-45b9-9f21-1d153a544e16@linux.intel.com>
 <ZU0MvXe1GF6xejlf@kernel.org>
 <7243048f-5f45-4f3d-9abb-626568359536@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7243048f-5f45-4f3d-9abb-626568359536@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 09, 2023 at 12:05:27PM -0500, Liang, Kan escreveu:
> On 2023-11-09 11:45 a.m., Arnaldo Carvalho de Melo wrote:
> > Em Thu, Nov 09, 2023 at 11:14:31AM -0500, Liang, Kan escreveu:
> >> The below change should fix it. I will post a complete patch shortly.

> > Thanks for the quick response, if all that is needed are the checks
> > below, I'll fold it into your original patch:

> > 2ae01908298426e4 perf tools: Add branch counter knob

> > So that we don't regress, ok?

> Sure.

> I also post the patch to
> https://lore.kernel.org/lkml/20231109164007.2037721-1-kan.liang@linux.intel.com/
> Either folding it or using the new patch is fine for me.

I folded it, retested, pushed out perf-tools-next.
 
> BTW: the new perf test case for the feature is posted here.
> I think Ian is reviewing it.
> https://lore.kernel.org/lkml/20231107184020.1497571-1-kan.liang@linux.intel.com/

Ok, lets wait some more.

Hey, what is SFR/GRR? Sapphire Rapids/Granite Rapids? I thought about
testing this somehow, if possible.

- Arnaldo
