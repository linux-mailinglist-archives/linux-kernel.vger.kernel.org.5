Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE227DD0D1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 16:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbjJaPpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 11:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbjJaPps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 11:45:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F723F3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 08:45:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4783C433C7;
        Tue, 31 Oct 2023 15:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698767145;
        bh=FhBL9cZlQZxwRCs4ScUGBQ0z5kjLw2kWgPYm0rSMTGE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XLRibVfccEXi2pbUadWLS70vOk8fLLcmyUU1x6ZAZJo0euyQmXjuqVDgbBHF74lZm
         bu7l3oqOX+8e8psFMdciAJjgLg8pIRQSmtR43X+4rnZ0h6r7en92Yiu9ghCmEanJ9i
         /Vkfa6vtBcw2DqWevvIuofq8LlzrZCgkH4TTv5LHEZXHl9o5ZTKH45vNxRzW0OVXh3
         27VeGTeD9oKvbvJdowAFiRIjKGV8mOAZftcnTSu3ZEklAVAUl6fgy8+gHFkoPZ/aas
         Ttd8kQhj9l3gBf4mJAIqz8f6h1H3bBxx15BY97Ke4J8PWm2eBz4aceb8CFMBI6t6zK
         ahdhooVC50wTw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 86BFD4035D; Tue, 31 Oct 2023 12:45:42 -0300 (-03)
Date:   Tue, 31 Oct 2023 12:45:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Add --debug-file option to redirect debug
 output
Message-ID: <ZUEhJrXUWHyv959i@kernel.org>
References: <20231031105523.1472558-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031105523.1472558-1-yangjihong1@huawei.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 31, 2023 at 10:55:23AM +0000, Yang Jihong escreveu:
> Currently, debug messages is output to stderr, add --debug-file option to
> support redirection to a specified file.
 
>   # perf --debug-file /tmp/perf.log record -v true
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.013 MB perf.data (26 samples) ]
>   # cat /tmp/perf.log
>   DEBUGINFOD_URLS=
>   Using CPUID GenuineIntel-6-3E-4

Ok, reusing debug_set_file() that was introduced to be used in the
'perf daemon' subcommand.

Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
