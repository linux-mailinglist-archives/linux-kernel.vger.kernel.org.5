Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0937FACF5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjK0WGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbjK0WGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:06:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28CFD4B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:06:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3117BC433C8;
        Mon, 27 Nov 2023 22:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701122775;
        bh=hT50ThkIvKWMJVrWm5ccSiYE90oywa4kHmvXT/ms/N0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S3qqa5GY3lSoS0P3DeGmJvvogkW10LRRbZt+Pli9oQHWDti5bqKe8S9eYPQXCribx
         I1gE25n/Q6Gh7dmSbIjfn2U0ID9mZIsBXj051FsBebrvTHEDDYymA0Cf2Fqzh83xp7
         2BNEW0BtttYDbolnD9F3kEj9kWYp2nbEUVt65tz2iwDn+wgbEarwKRiYOc1cpO46N9
         ZE/JxRT1zio6t1CkrO/9KvPjSPJYZFx5NMusCeYG+KiZrCwMCYgQyUwcg4xbVMwfXZ
         O/3I9BAibMe6xUub7hnWsywvMO1ps0HM+ARzk5maBynKTFU9OHi/MhTixt8Ty2dxUr
         agAYtI9sY5WsQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0984940094; Mon, 27 Nov 2023 19:06:12 -0300 (-03)
Date:   Mon, 27 Nov 2023 19:06:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Add --debug-file option to redirect debug
 output
Message-ID: <ZWUS1M0HM7WZXwML@kernel.org>
References: <20231031105523.1472558-1-yangjihong1@huawei.com>
 <ZUEhJrXUWHyv959i@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUEhJrXUWHyv959i@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 31, 2023 at 12:45:42PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Oct 31, 2023 at 10:55:23AM +0000, Yang Jihong escreveu:
> > Currently, debug messages is output to stderr, add --debug-file option to
> > support redirection to a specified file.
>  
> >   # perf --debug-file /tmp/perf.log record -v true
> >   [ perf record: Woken up 1 times to write data ]
> >   [ perf record: Captured and wrote 0.013 MB perf.data (26 samples) ]
> >   # cat /tmp/perf.log
> >   DEBUGINFOD_URLS=
> >   Using CPUID GenuineIntel-6-3E-4
> 
> Ok, reusing debug_set_file() that was introduced to be used in the
> 'perf daemon' subcommand.
> 
> Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Thanks, applied to perf-tools-next.

- Arnaldo

