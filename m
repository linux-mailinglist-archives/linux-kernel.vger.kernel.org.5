Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDE87D3E04
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbjJWRlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbjJWRlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:41:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7971CD7A;
        Mon, 23 Oct 2023 10:41:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43E8C433CC;
        Mon, 23 Oct 2023 17:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698082860;
        bh=s4PKCMf+mYuSUwyiknZuLzVRYAXpdi2OJwb++cxkFEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PynV0iN4icEZwIhXh70iTiOLjBEUrQgryyDXXlM+tU3CX9N1FACwjCvT2WP+yuFGu
         j02ZCdlLP5FMs5/pM6IAmRx1eBwpIHHRjGILuM15bVM8UHBThh4Fx5l5pCzr9m/IqY
         /AoosjqM0s3Tg3M9m1no734HSQoWqd0fs8oxF4oJI6lmI+8yggG8eCC5FWGKTKFraw
         wj3JJl6uaiCad+He5ZFMI0b9X+TIVt3O3aaS2sZy/KsLAkxaph2TEqg9wJkn5UjixR
         4BhDQ1AdiV06mnf88EBW8g5m0zwkbKIWTa8+dbsAJQKH/aMAZaeIhmVw9l2jFuRFUy
         iBMOPDDrndtsg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5CCB64035D; Mon, 23 Oct 2023 14:40:57 -0300 (-03)
Date:   Mon, 23 Oct 2023 14:40:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-toolchains@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH 22/48] perf annotate: Add --type-stat option for debugging
Message-ID: <ZTawKZK/ImWsPkUI@kernel.org>
References: <20231012035111.676789-1-namhyung@kernel.org>
 <20231012035111.676789-23-namhyung@kernel.org>
 <ZTatKUD6nS7OlvuC@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTatKUD6nS7OlvuC@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 23, 2023 at 02:28:10PM -0300, Arnaldo Carvalho de Melo escreveu:
> When building with NO_DWARF=1 or in systems lacking the used DWARF
> libraries. I noticed with some of the build containers, will updated
> those to have the required libraries so that this feature gets compile
> tested there.

The problem was that I build with/without NO_LIBELF=1, and with it set
NO_DWARF=1 is enabled and thus breaks the build.

- Arnaldo
