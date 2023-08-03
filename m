Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA8576F425
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 22:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjHCUpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 16:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjHCUpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 16:45:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B661030EA;
        Thu,  3 Aug 2023 13:45:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 487AF61EAF;
        Thu,  3 Aug 2023 20:45:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E650C433C8;
        Thu,  3 Aug 2023 20:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691095503;
        bh=UXQA6Sp9+nMzLruVQvdX9wDbmeN6Do6qtEMNu/DE6z0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=piuUAmY1whkLscSpXc/ecQ8BF+bGTHOGX80qiBdapzrA+Bp6pea2GgyjsjrO3iaSL
         W7inX5fZDlClWalQXBHohsJ1aNrw9Whlep2P1KaA6K0lAexF0S3JSZDr6YU0zsl03N
         d7t04VvFvVGiFqNIYCXTbUD/QClspQch/oDS4KDivyBEk6PjfvftNfp+STUjiXf5S0
         FF3nETvU7uUF4kMuEbb1OmY4t8wBKmD8yOFTy3Yy8Uyn8OdjTGnNh74vbN++jdzm1d
         IbodNSFFZ+r91a2NHwzltgo4IDM+iUaneWm3x/NigJi07dpdk11SxVzsUR3CWTe7Ww
         mslOqRW5y3jyQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 15BA1404DF; Thu,  3 Aug 2023 17:45:01 -0300 (-03)
Date:   Thu, 3 Aug 2023 17:45:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Manank Patel <manank@manank.me>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Jens Schleusener <Jens.Schleusener@fossies.org>
Subject: Re: [PATCH] tools: perf: pmu-events: Fix typo poiint->point
Message-ID: <ZMwRzQC+wBgJpDfr@kernel.org>
References: <20230803-fix-typo-v1-1-b794378d594e@manank.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803-fix-typo-v1-1-b794378d594e@manank.me>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 03, 2023 at 11:27:30AM +0530, Manank Patel escreveu:
> Fix typo in file floating-point.json in /arch/x86/westmereep-dp

AFAIK these are generated using a tool, so the fix needs to go to the
file from where the JSON files are generated, Ian?

- Arnaldo
 
> Reported-by: Jens Schleusener <Jens.Schleusener@fossies.org>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=205891
> Signed-off-by: Manank Patel <manank@manank.me>
> ---
>  tools/perf/pmu-events/arch/x86/westmereep-dp/floating-point.json | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/pmu-events/arch/x86/westmereep-dp/floating-point.json b/tools/perf/pmu-events/arch/x86/westmereep-dp/floating-point.json
> index c03f8990fa82..196ae1d9b157 100644
> --- a/tools/perf/pmu-events/arch/x86/westmereep-dp/floating-point.json
> +++ b/tools/perf/pmu-events/arch/x86/westmereep-dp/floating-point.json
> @@ -8,7 +8,7 @@
>          "UMask": "0x1"
>      },
>      {
> -        "BriefDescription": "X87 Floating poiint assists for invalid input value (Precise Event)",
> +        "BriefDescription": "X87 Floating point assists for invalid input value (Precise Event)",
>          "EventCode": "0xF7",
>          "EventName": "FP_ASSIST.INPUT",
>          "PEBS": "1",
> 
> ---
> base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
> change-id: 20230803-fix-typo-3cb207284310
> 
> Best regards,
> -- 
> Manank Patel <manank@manank.me>
> 

-- 

- Arnaldo
