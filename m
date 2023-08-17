Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E226677FCCC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353294AbjHQROS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353954AbjHQRN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:13:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E50BF;
        Thu, 17 Aug 2023 10:13:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E93FA63CE6;
        Thu, 17 Aug 2023 17:13:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242FBC433C8;
        Thu, 17 Aug 2023 17:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692292437;
        bh=RXUW5V6p1RTidRORXcrQZ5eIH/N11o40GsglBEZnvbQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cxs1Jbsjy0lTRs0rCLM1YU5vOHkyLFTi5aSRm2RbWwtPNaVXf+1168B82YvaY++LD
         lXT2lwSOYDJ4aBi+tEgfjcvbNDua5uV0zMgpnGXH9/mAZDJxfaF0RwxcJMjYV1PmBW
         FoJGT3VvO2oANemIWhzul3w7NzkMj2TSNMe3fjIK806ADHEl4ZZ3AW0kepOtEXuien
         kyvfIfvGbRl4zowiwHJtl25f1NZf4ZWBmCwwjKZTCgUrux6yxv9Oqu+UPPR1WER9c+
         fnWXdpWWr5kL29xEVABzUiTX8UzfxDFYSQaUVpcn8EOQ+qXF1YQyVwi+rome0uSj5+
         jHpY1zqtoAFyQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2FC5F404DF; Thu, 17 Aug 2023 14:13:54 -0300 (-03)
Date:   Thu, 17 Aug 2023 14:13:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Haixin Yu <yuhaixin.yhx@linux.alibaba.com>,
        Nick Forrington <nick.forrington@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        renyu.zj@linux.alibaba.com
Subject: Re: [PATCH v6 6/6] perf vendor events arm64: Update N2 and V2
 metrics and events using Arm telemetry repo
Message-ID: <ZN5VUkswJnwTaWZj@kernel.org>
References: <20230816114841.1679234-1-james.clark@arm.com>
 <20230816114841.1679234-7-james.clark@arm.com>
 <81e404fb-0eae-e4b8-299a-54ac860fd1dd@oracle.com>
 <43e5d3e9-fe5f-655d-a6d3-44d47081e1a4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43e5d3e9-fe5f-655d-a6d3-44d47081e1a4@arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 17, 2023 at 03:41:11PM +0100, James Clark escreveu:
> 
> 
> On 17/08/2023 12:09, John Garry wrote:
> > On 16/08/2023 12:47, James Clark wrote:
> >> Apart from some slight naming and grouping differences, the new metrics
> >> are functionally the same as the existing ones. Any missing metrics were
> >> manually appended to the end of the auto generated file.
> >>
> >> For the events, the new data includes descriptions that may have product
> >> specific details and new groupings that will be consistent with other
> >> products.
> >>
> >> After generating the metrics from the telemetry repo [1], the following
> >> manual steps were performed:
> >>
> >>   * Change the topdown expressions to compare on CPUID and use
> >>     #slots so that the same data can be shared between N2 and V2. Apart
> >>     from these modifications, the expressions now match more closely with
> >>     the Arm telemetry data which will hopefully make future updates
> >>     easier.
> >>
> >>   * Append some metrics from the old N2/V2 data that aren't present in
> >>     the telemetry data. These will possibly be added to the
> >>     telemetry-solution repo at a later time:
> >>
> >>      l3d_cache_mpki, l3d_cache_miss_rate, branch_pki, ipc_rate, spec_ipc,
> >>      retired_rate, wasted_rate, branch_immed_spec_rate,
> >>      branch_return_spec_rate, branch_indirect_spec_rate
> >>
> >> [1]:https://urldefense.com/v3/__https://gitlab.arm.com/telemetry-solution/telemetry-solution/-/blob/main/data/pmu/cpu/neoverse/neoverse-n2.json__;!!ACWV5N9M2RV99hQ!NW7DYe7T69u8RFn9WLyiCcoHm-8BtlxNK3PRw19udocwlwv0vQpjcSDT5XqGbWzvPQyFrG-eRkuu_VZt7cO8-Q$ 
> >> Signed-off-by: James Clark<james.clark@arm.com>
> > 
> > Reviewed-by: John Garry <john.g.garry@oracle.com>
> 
> Thanks for the reviews!

Thanks everybody, patches merged, reviewed-by tags collected.

- Arnaldo
