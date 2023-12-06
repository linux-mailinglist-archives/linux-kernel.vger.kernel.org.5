Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B668807990
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 21:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441799AbjLFUiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 15:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379519AbjLFUip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 15:38:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89C8CA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 12:38:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D950C433C7;
        Wed,  6 Dec 2023 20:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701895131;
        bh=cQz7nqAhJZLeNLfbhuwDJLQndqN6EGPd06sE/qHTxl8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a3ZLEOI6PlyPKjcBOzbvg/uWztpxbKN5SsnZQQ0mKemEGbPgXokQ796Pi+GsuTCs4
         K1XZeQgGkhlSUs0ryripNmigxDsf5W2ZLO82+jbRHd8dmyUL5WLYaAir2w9hB6h8un
         ViRMa7bySqAP2uONoVEX22zWsUrOvdB1NOrqA05rmJs5RBadH8V6DA/RMc5sJz3746
         /+pcGNJEnzBl9jezENsKgt4p/xtynH/P0qiKYxmWthtAARxRgRwpoDqP6qqYJsDWxb
         uJ5YYV+0bG/Y3Ul4lXZkzQOnx9cjHCor6KyZTctKAmGquJAqfLe5h8NgC2GXraZ0e2
         WifWGUersqUDw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2A44B403EF; Wed,  6 Dec 2023 17:38:48 -0300 (-03)
Date:   Wed, 6 Dec 2023 17:38:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     kan.liang@linux.intel.com
Cc:     irogers@google.com, peterz@infradead.org, mingo@redhat.com,
        namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        john.g.garry@oracle.com, will@kernel.org, james.clark@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org,
        yuhaixin.yhx@linux.alibaba.com, renyu.zj@linux.alibaba.com,
        tmricht@linux.ibm.com, ravi.bangoria@amd.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/6] perf mem: Remove useless header files for X86
Message-ID: <ZXDb2Gs1ECjejSbn@kernel.org>
References: <20231206201324.184059-1-kan.liang@linux.intel.com>
 <20231206201324.184059-7-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206201324.184059-7-kan.liang@linux.intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 06, 2023 at 12:13:24PM -0800, kan.liang@linux.intel.com escreveu:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The X86 mem-events.c only has perf_mem_events array now. Remove useless
> header files.

It would be great that those were removed while you made the cleanups,
i.e. removed the need for one of them, remove it together with the
refactorings, etc.

But I don't think this is a requirement, just would make it cleaner.

Will wait for reviews now.

- Arnaldo
 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/arch/x86/util/mem-events.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
> index 71ffe16de751..62df03e91c7e 100644
> --- a/tools/perf/arch/x86/util/mem-events.c
> +++ b/tools/perf/arch/x86/util/mem-events.c
> @@ -1,11 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include "util/pmu.h"
> -#include "util/pmus.h"
> -#include "util/env.h"
> -#include "map_symbol.h"
> -#include "mem-events.h"
>  #include "linux/string.h"
> -#include "env.h"
> +#include "util/map_symbol.h"
> +#include "util/mem-events.h"
> +#include "mem-events.h"
> +
>  
>  #define MEM_LOADS_AUX		0x8203
>  
> -- 
> 2.35.1
> 

-- 

- Arnaldo
