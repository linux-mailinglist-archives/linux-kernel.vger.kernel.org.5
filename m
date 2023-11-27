Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB177FA318
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbjK0OkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbjK0OkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:40:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E719C2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:40:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EFF6C433C7;
        Mon, 27 Nov 2023 14:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701096009;
        bh=vTUbAPNKdHgfHvgxRcJCOXwUsIbXASFDzkkqMyquuPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O7KkJl13o2go+127IAK9+2Ecf7MaeoMoLOgY2ssC/KD6WW9vOiAqWkiCx+HinnvCq
         YZ6rAUHxh4kbXrcfCrdl3AOS3lMu8JXhY9rMmizsj8RBVqnlVf9oebahYHtFlRgAQN
         LDsRGvmDGP5B+4xHIuI01j1QyE6l8zLkvP+PtuUjcZgiAXusHpZPDAvFwt7ZiEDZbT
         Sw8sUXC4rfIeGB+FEZSWITwgkKw4oGdRMEe7zHsIaGgXU+/thpi9ImiSTxM9vXMLPn
         PJYvMwiea8vDubXtqbVMwOnYu9ZY6gkIOb/R/cpLj1lEGgTcVOGBkdbsHlMcuIB0xI
         A4DZfn+D7iPHQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 71CF340094; Mon, 27 Nov 2023 11:40:07 -0300 (-03)
Date:   Mon, 27 Nov 2023 11:40:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nikita Shubin <n.shubin@yadro.com>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4] perf vendor events riscv: add StarFive Dubhe-90 JSON
 file
Message-ID: <ZWSqR8cqMB//WE/A@kernel.org>
References: <20231122030908.2981502-1-jisheng.teoh@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122030908.2981502-1-jisheng.teoh@starfivetech.com>
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

Em Wed, Nov 22, 2023 at 11:09:08AM +0800, Ji Sheng Teoh escreveu:
> Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
> Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> ---
> Changelog:
> v3 -> v4:
> - Reuse common and firmware json file from starfive/dubhe-80.
> - Rebase against latest perf-tools-next
> - Update commit message to reflect the above changes.

I guess this addressed all the review comments, applied, if something is
still amiss we can add a followup patch.

- Arnaldo

> v2 -> v3:
> - Add standard RISC-V firmware event
> - Update commit message to reflect addition of standard
>   RISC-V firmware event.
> v1 -> v2:
> - Rename 'Starfive Dubhe' to 'StarFive Dubhe-90' in commit message.
> - Rename 'starfive/dubhe' pmu-events folder to 'starfive/dubhe-90'
> - Update MARCHID to 0x80000000db000090 in mapfile.csv
> ---
>  tools/perf/pmu-events/arch/riscv/mapfile.csv | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
