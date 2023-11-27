Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBA17FA0C9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbjK0NUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 08:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbjK0NUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 08:20:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77F61A2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 05:20:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E4DC433C7;
        Mon, 27 Nov 2023 13:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701091250;
        bh=BM2l69clFzuDzEVVhytXVUK2DJxV/0d206kvjSJINks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xv0EazDbL5w497ShYfaO6O4fNO3gSTJkF2A2hgKPWQvK3qdpYmsJBsPkoINsEVvDi
         CmZb57F8xzqqTfBqUeHF/evGsAj0Y9zXPXXDE799sfWDaZJM8JRhX6/EDsTaBxfjaT
         0FiasSKE2LFArvU2OnBbPgxrLs1zO0Sa1E9Mdmg8LjqUpYxlqwOHUQ1sDxISrZXaAa
         YQTR2jYSaHBQySKthYmKSchxflkzdf0RAzONuHRUkAT8iv1VGh6QZD/hJq0W81H6U7
         lcW/TQH4Ne4uDhHoAt+qjCyZL2QWhSE7gLOC6tNnaSbCioO8HyVz9kEXSzGrTTb+3W
         J/izWbOrAq8sw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E5A3940094; Mon, 27 Nov 2023 10:20:47 -0300 (-03)
Date:   Mon, 27 Nov 2023 10:20:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Nick Forrington <nick.forrington@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        vmolnaro@redhat.com
Subject: Re: [PATCH] perf test: Remove atomics from test_loop to avoid test
 failures
Message-ID: <ZWSXr7e5KxM79Z0l@kernel.org>
References: <20231102162225.50028-1-nick.forrington@arm.com>
 <alpine.LRH.2.20.2311242037260.11297@Diego>
 <20231125030529.GB178091@leoy-huanghe>
 <f0ac7523-edce-4b0b-a142-14c03c912720@arm.com>
 <20231126074030.GA647134@leoy-yangtze.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126074030.GA647134@leoy-yangtze.lan>
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

Em Sun, Nov 26, 2023 at 03:41:14PM +0800, Leo Yan escreveu:
> Maybe the commit log caused a bit confusion, the problem is after

We'll have the Link pointing to this discussion.

> enabling "-moutline-atomics" on aarch64, the overhead is altered into
> the linked __aarch64_ldadd4_relax() function, test_loop() cannot be
> sampled anymore, but it's not about stack tracing.
> 
> Anyway, the patch is fine for me.

I'm taking this as an Acked-by: Leo

But probably this could be even a Tested-by, ok?

- Arnaldo
