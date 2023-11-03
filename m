Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F957E058F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 16:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbjKCP3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 11:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjKCP3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 11:29:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE35AD47
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 08:29:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A658C433C8;
        Fri,  3 Nov 2023 15:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699025374;
        bh=edDh2XpsaRN563DnkZjJS4NVRd5Q2t6fG+6H66m7udo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pLKrlXw0L/S2UskO27XAQmgmPT6dZ9tMrLKEzIAGadNvTyjmUTgfNTp2/NRvrhXOc
         AU7doFGJd5md7YUNuCv/hT6BFkdkw/Iz/mX8YeQXa3iAE9xw2C8NIDIDnAr95xFQqF
         ozvx+yZZNsHu2cC04cn4sGCnTqMVyoQpqAivCylvbvEzLg91ZCfwRVFlLA6YUd+Ocf
         77mfT7iqC37kNp56ClsZNfCH2r/q0enSSej2pokdgN5cLW3aIRCVkJtBM7miOhsGWU
         m8wJ/8JGgvLWLBcjastpZYJCwVI2gEF/6NFKwkydGRDfXthcRja6S6YOkW0u+y5kgV
         H0phMvB4epNVQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 768A54035D; Fri,  3 Nov 2023 12:29:31 -0300 (-03)
Date:   Fri, 3 Nov 2023 12:29:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf debug: List available options when no variable
 is specified
Message-ID: <ZUUR2/9An1ccCY+C@kernel.org>
References: <20231101064543.1481957-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101064543.1481957-1-yangjihong1@huawei.com>
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

Em Wed, Nov 01, 2023 at 06:45:43AM +0000, Yang Jihong escreveu:
> Minor help message improvement for `perf --debug`
 
> Before:
 
>   # perf --debug
>   No variable specified for --debug.
 
>    Usage: perf [--version] [--help] [OPTIONS] COMMAND [ARGS]
 
> After:
 
>   # perf --debug
>   No variable specified for --debug, available options: verbose,ordered-events,stderr,data-convert,perf-event-open
> 
>    Usage: perf [--version] [--help] [OPTIONS] COMMAND [ARGS]

Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
 
> Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
> 
> Changes since v1:
>  - Provide helper to iterate debug_opts and print name instead of adding a new variable.
