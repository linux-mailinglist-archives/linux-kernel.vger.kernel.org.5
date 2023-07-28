Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D415766E96
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235881AbjG1Nka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235774AbjG1Nk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:40:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6B419BF;
        Fri, 28 Jul 2023 06:40:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27724620FD;
        Fri, 28 Jul 2023 13:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6410BC433C7;
        Fri, 28 Jul 2023 13:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690551626;
        bh=tlsE0+7xNYDWBajQc3lmfmA80SXhLg/A7CaGn11d9K4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XA0YMVO5hYSzb8+pjL5xabzJ+9mlCLygcwa9jXFvHHSWeMe1fZiU4OZvFMFxrKAlF
         0KSWiCG/BvrXtTrhS+RsntbAqlN5bua7POD+bunD9eoeINxDuQNI+01ktbDtI7xoy4
         75HAJZFjEH+1kkaDQzKM+dDpm3oLTEClOW6Y9DP1nyO7dpB8pRNlrYofQ5IMqUV7kA
         0wNmtIC/QBNBwyO5knoD7md0/9JY9pCVLT2EOvrB2tBiKArpjWB8sowLwRahEoAP6R
         qHvkoLEEeYUH43idKDmCufY2FLSTl4hmuP02jjX1nGhyE2OeGNui/lsxOV9wwpayQ6
         yJ5iS8N8gU5Dw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CAA8340096; Fri, 28 Jul 2023 10:40:23 -0300 (-03)
Date:   Fri, 28 Jul 2023 10:40:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jing Zhang <renyu.zj@linux.alibaba.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Will Deacon <will@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v5 0/3] Add aliases and JSON metrics for Yitian710 DDR
Message-ID: <ZMPFR7YQJt2dEY35@kernel.org>
References: <1690528175-2499-1-git-send-email-renyu.zj@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690528175-2499-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jul 28, 2023 at 03:09:32PM +0800, Jing Zhang escreveu:
> Hi,
> 
> I add aliases and JSON metrics for Yitian710 DDR. The kernel part that
> this series depends on has been applied to for-next/perf. And this series
> have all been reviewed. Can you help to apply them? Thank you.
> 
> Thanks,
> Jing

Thanks, applied.

- Arnaldo

 
> Change since v4:
> - Kernel patch has applied to for-next/perf, so this patchset only has
>   tools part and docs.
> - Fixed patch conflicts.
> - Link: https://lore.kernel.org/all/1687245156-61215-1-git-send-email-renyu.zj@linux.alibaba.com/
> 
> Jing Zhang (3):
>   perf jevents: Add support for Yitian 710 DDR PMU aliasing
>   perf vendor events: Add JSON metrics for Yitian 710 DDR
>   docs: perf: Update metric usage for Alibaba's T-Head PMU driver
> 
>  Documentation/admin-guide/perf/alibaba_pmu.rst     |   5 +
>  .../arm64/freescale/yitian710/sys/ali_drw.json     | 373 +++++++++++++++++++++
>  .../arm64/freescale/yitian710/sys/metrics.json     |  20 ++
>  tools/perf/pmu-events/jevents.py                   |   1 +
>  4 files changed, 399 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/ali_drw.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/metrics.json
> 
> -- 
> 1.8.3.1
> 

-- 

- Arnaldo
