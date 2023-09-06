Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77754794514
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 23:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244798AbjIFV2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 17:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235806AbjIFV2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 17:28:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023B319BB;
        Wed,  6 Sep 2023 14:28:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628A3C433C8;
        Wed,  6 Sep 2023 21:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694035691;
        bh=97KtZLFki8TYIdeuSt8RiztJLygVCH9CnWN8bj1BXpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DgUoVWuBhBn5cDUBE7Kd5AczoOgQGiWzZmBVbqSMtB0k59yLwIB3tCUnZqhN5Zl/6
         GWeWLkJXdiueV9biyBGWJLqBU9HREI9ZNbpRNmG20oWvV4i8/4Wv3qisShK92srKOc
         9COjCv2WBoHT5q5Rsr3ft6aWQfSHjfAdSwi0Ec4Plr8y7eo4+/Drt/DiISeIFFRRb6
         RiPLG+YrgIRW5v4YZME797MEZF2c/CQIljO1INuM6u06N8yi4GGh3RblMAFJTb/zvi
         7oMe5ZmvxD8cieZj9KBd6nRTZlD7tZ+gd8Qbqb5zkGbLVnW5hyR8uWU9mR70fai9Wq
         LWyOYRavyebeQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8524F403F4; Wed,  6 Sep 2023 18:28:08 -0300 (-03)
Date:   Wed, 6 Sep 2023 18:28:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>, bpf@vger.kernel.org
Subject: Re: [PATCHSET 0/5] perf lock contention: Add cgroup support (v2)
Message-ID: <ZPju6GNFy3sALgRb@kernel.org>
References: <20230906174903.346486-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906174903.346486-1-namhyung@kernel.org>
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

Em Wed, Sep 06, 2023 at 10:48:58AM -0700, Namhyung Kim escreveu:
> Hello,
> 
> The cgroup support comes with two flavors.  One is to aggregate the
> result by cgroups and the other is to filter result for the given
> cgroups.  For now, it only works in BPF mode.
> 
> * v2 changes
>  - fix compiler errors  (Arnaldo)
>  - add Reviewed-by from Ian

Thanks, applied, tested, pushing to tmp.perf-tools-next.

- Arnaldo
