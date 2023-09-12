Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234F279D99F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 21:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237640AbjILTeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 15:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbjILTeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 15:34:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0AC199;
        Tue, 12 Sep 2023 12:34:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3EAC433C7;
        Tue, 12 Sep 2023 19:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694547256;
        bh=HleCnHPsfjZykYXaJ8HvlvfvgC8Bo/85PJq2XL1IkKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mSzXhisWNHHc5X3OcKTem4wY9TkOdKKVFvfxajxJRXmjekb6hbUhAM+wqsq49DL+i
         rsyl7wWexdGbMVxENT1fkIcGzBfPN57pXkQ7cbA/fitCSoaCvzx4j6CKEz4kP5oKuO
         u4s6dT6V99Sn7mxrkFDQslehzIBGcbaD08c2ueJbkVbmglOkRhAFREuKS4MoICgiIB
         cMaSYYyqIoK+XRHzWrEx4Zg5kyOzJ5u25Encrh8T+4rwOpsSEyYpjygmMkPZJkJdge
         Q4dRaxvWYJs6DhecUY4uDlnGyFqZ4SeLBu+VFMIb5iH4Ciwwe2+tzBMPMApUyoOuqt
         VSF/LY+oP8nYA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C0AE9403F4; Tue, 12 Sep 2023 16:34:13 -0300 (-03)
Date:   Tue, 12 Sep 2023 16:34:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Forrington <nick.forrington@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] perf vendor events arm64: Update V1 events using Arm
 telemetry repo
Message-ID: <ZQC9NXlqVxMcmw0G@kernel.org>
References: <20230831161618.134738-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831161618.134738-1-james.clark@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 31, 2023 at 05:15:30PM +0100, James Clark escreveu:
> This is the last set of JSON updates using the Arm telemetry repo. Perf
> now has an up to date copy of everything that is currently published
> there. Future updates will be done as new data becomes available.
 

Thanks, applied.

- Arnaldo

> James Clark (2):
>   perf vendor events arm64: Update V1 events using Arm telemetry repo
>   perf vendor events arm64: Add V1 metrics using Arm telemetry repo
> 
>  .../arch/arm64/arm/neoverse-v1/branch.json    |   8 -
>  .../arch/arm64/arm/neoverse-v1/bus.json       |  18 +-
>  .../arch/arm64/arm/neoverse-v1/cache.json     | 155 ------------
>  .../arch/arm64/arm/neoverse-v1/exception.json |  45 ++--
>  .../arm64/arm/neoverse-v1/fp_operation.json   |  10 +
>  .../arch/arm64/arm/neoverse-v1/general.json   |  10 +
>  .../arm64/arm/neoverse-v1/instruction.json    | 119 ---------
>  .../arch/arm64/arm/neoverse-v1/l1d_cache.json |  54 ++++
>  .../arch/arm64/arm/neoverse-v1/l1i_cache.json |  14 ++
>  .../arch/arm64/arm/neoverse-v1/l2_cache.json  |  50 ++++
>  .../arch/arm64/arm/neoverse-v1/l3_cache.json  |  22 ++
>  .../arch/arm64/arm/neoverse-v1/ll_cache.json  |  10 +
>  .../arch/arm64/arm/neoverse-v1/memory.json    |  21 +-
>  .../arch/arm64/arm/neoverse-v1/metrics.json   | 233 ++++++++++++++++++
>  .../arch/arm64/arm/neoverse-v1/pipeline.json  |  23 --
>  .../arch/arm64/arm/neoverse-v1/retired.json   |  30 +++
>  .../arch/arm64/arm/neoverse-v1/spe.json       |  18 ++
>  .../arm64/arm/neoverse-v1/spec_operation.json | 110 +++++++++
>  .../arch/arm64/arm/neoverse-v1/stall.json     |  30 +++
>  .../arch/arm64/arm/neoverse-v1/sve.json       |  30 +++
>  .../arch/arm64/arm/neoverse-v1/tlb.json       |  66 +++++
>  21 files changed, 735 insertions(+), 341 deletions(-)
>  delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/branch.json
>  delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/fp_operation.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/general.json
>  delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/instruction.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/l1d_cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/l1i_cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/l2_cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/l3_cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/ll_cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/metrics.json
>  delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/pipeline.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/retired.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/spe.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/spec_operation.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/stall.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/sve.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/tlb.json
> 
> -- 
> 2.34.1
> 

-- 

- Arnaldo
