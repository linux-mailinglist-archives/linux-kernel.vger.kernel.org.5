Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B6D766E74
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236483AbjG1Nbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbjG1Nbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:31:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF875421D;
        Fri, 28 Jul 2023 06:31:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7B8162154;
        Fri, 28 Jul 2023 13:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D2EC433C8;
        Fri, 28 Jul 2023 13:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690550963;
        bh=dJ/zmPsFQ+JgVXeFfxfEAvFGUMbo+Z0t5O+InptEFuw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AbT21N9+3NEGy3RZ5G8cr9yxwQusCXxwZPclFtPaDX3H/fjm0GSWEVOvESipPMVkG
         F6vkgonbYnk2ItD4mf7Dx5ucaPfw7tu/7P6rfzQygiozgC1eC4+GHTwfFeqkeHfwOx
         0GT7NUwya9xIkP/s92/JPV+Ohdrsg2Z0JHRSmcxUmNEcpSsVsykDZCKg6BYEfW8FUp
         J6t5raJMy6H3FtZGcsImUPgp1xYwm1+8ZBW7+MpuIt6ouhI6RZJ+9dx637vo0oddzF
         APA2xr3YCTgdO+BG4qjFAvSHwo6kt/53XpUkwPWNcoYSbuqFpRaIJLU8h2jEOL5wt8
         6X3ZvGSPYbgkw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 71F2040096; Fri, 28 Jul 2023 10:29:20 -0300 (-03)
Date:   Fri, 28 Jul 2023 10:29:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, masahiroy@kernel.org,
        leo.yan@linaro.org, broonie@kernel.org, Aishwarya.TCV@arm.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/1] perf tools: Add a place to put kernel config
 fragments for test runs
Message-ID: <ZMPCsEeO1Xad/pR6@kernel.org>
References: <20230628105303.4053478-1-james.clark@arm.com>
 <CAM9d7cgo97jJTTTV7F2kJ=sF9MBoRwegN4r0dWotbUD=Nr1_cQ@mail.gmail.com>
 <36767548-fbc3-9c4b-848c-d1d3102e442a@arm.com>
 <85fad198-278a-aea2-3ada-f4f6a31f02ef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85fad198-278a-aea2-3ada-f4f6a31f02ef@arm.com>
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

Em Fri, Jul 28, 2023 at 11:48:34AM +0100, James Clark escreveu:
> 
> 
> On 30/06/2023 09:04, James Clark wrote:
> > 
> > 
> > On 29/06/2023 23:03, Namhyung Kim wrote:
> >> Hi James,
> >>
> >> On Wed, Jun 28, 2023 at 3:53 AM James Clark <james.clark@arm.com> wrote:
> >>>
> >>> Changes since RFC:
> >>>
> >>>  * Changed arch filename convention to use the ARCH= build time values
> >>>    instead of uname
> >>>
> >>> It seems like there were no objections on the RFC, apart from maybe
> >>> changing the perf tests to run as a kself test. But that's probably not
> >>> going to happen for a while, if ever, and these fragments can always
> >>> be moved in that case.
> >>
> >> I missed the RFC, sorry.  Could you please add a link for that?
> >>
> >> Thanks,
> >> Namhyung
> > 
> > Yep, it's here:
> > https://lore.kernel.org/lkml/d02cce4a-47b1-a776-0d3a-a6a7c9a4d8fd@arm.com/T/
> > 
> 
> Hi Arnaldo,
> 
> Any interest in taking this one?

Yeah, looks useful, we can go on from this starting point and improve
it.

I merged it into perf-tools-next.

Thanks,

- Arnaldo
 
> Thanks
> James
> 
> >>
> >>
> >>>
> >>> James Clark (1):
> >>>   perf tools: Add a place to put kernel config fragments for test runs
> >>>
> >>>  tools/perf/tests/config-fragments/README |  7 +++++++
> >>>  tools/perf/tests/config-fragments/arm64  |  1 +
> >>>  tools/perf/tests/config-fragments/config | 11 +++++++++++
> >>>  3 files changed, 19 insertions(+)
> >>>  create mode 100644 tools/perf/tests/config-fragments/README
> >>>  create mode 100644 tools/perf/tests/config-fragments/arm64
> >>>  create mode 100644 tools/perf/tests/config-fragments/config
> >>>
> >>>
> >>> base-commit: ad5f604e186ac08d12c401e34ea96c09c38ddbc5
> >>> --
> >>> 2.34.1
> >>>

-- 

- Arnaldo
