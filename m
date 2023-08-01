Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AFB76BC2F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjHASU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 14:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjHASUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:20:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5702684;
        Tue,  1 Aug 2023 11:20:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F92461644;
        Tue,  1 Aug 2023 18:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591A6C433C7;
        Tue,  1 Aug 2023 18:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690914013;
        bh=gsd932w3PMNapqXMwnESzIlhw5itErWu7WrLlJ3MjXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bAxt3shh+3di5opI2s3Ot3GCRXzdxLiZrtA0ByDf2KtFbgcl2iDn9Vz2WfU66TYOa
         lIz2AXizwNDo1ERj3ol3cdkuQimGjUfIZUtopdUjQVnxSfMgtYLhJxC9kX0z20a6Xm
         sxz7wELXXgMk92NKWRkeXMWrcFbqlsC6ZRJZJpEPq46X3e0gMJQoKgOEAL9GQ753Jr
         XjlzMIqzcY2+2EzWFA9+XAxlmdooFIE4tkp7veugcsEF3Bg38cuJtmmOOIgoTk2h+t
         N4+8qXF9N1/JKjqlJlA4RwQzrZUbiLvUst1qW0i0H+ySLOuMOxUV+op8u6Y30NoXK7
         hrur6BgLAvR/Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 75C9A405DE; Tue,  1 Aug 2023 15:20:10 -0300 (-03)
Date:   Tue, 1 Aug 2023 15:20:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-perf-users@vger.kernel.org, renyu.zj@linux.alibaba.com,
        john.g.garry@oracle.com, namhyung@kernel.org,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Forrington <nick.forrington@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 4/5] perf vendor events arm64: Update N2-r0p3 and V2
 metrics and events using Arm telemetry repo
Message-ID: <ZMlM2rTqggT+0iGJ@kernel.org>
References: <20230711100218.1651995-1-james.clark@arm.com>
 <20230711100218.1651995-5-james.clark@arm.com>
 <CAP-5=fVPriUQZN+OzDOVnMMe0y9QzRHuaBMgrCcSvbE+3ME=Lg@mail.gmail.com>
 <59630da4-316b-55c4-c2c7-30c53b1ba642@arm.com>
 <750344ea-d1a2-87c2-b790-38dd79e11223@arm.com>
 <CAP-5=fU1z2+ZUFP0BdQyvy0DK_am9p=9p3goeB44M2cLiF7y7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU1z2+ZUFP0BdQyvy0DK_am9p=9p3goeB44M2cLiF7y7g@mail.gmail.com>
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

Em Tue, Aug 01, 2023 at 08:56:35AM -0700, Ian Rogers escreveu:
> On Tue, Aug 1, 2023 at 3:55 AM James Clark <james.clark@arm.com> wrote:
> > On 12/07/2023 09:33, James Clark wrote:
> > > On 12/07/2023 02:04, Ian Rogers wrote:
> > >> It might be nice to add "beat" to the glossary:
> > >> https://perf.wiki.kernel.org/index.php/Glossary

> > > I requested an account and I will add it. There is a definition in the
> > > Arm glossary here if, like me, you weren't sure:

> > I'm not sure if my wiki account request worked. I didn't get a response,
> > and I also get a "your IP is blocked from editing" on the password reset
> > page (this is an Arm internal IP).
> > Do you know anything about the account request procedure?

> The wiki is run by RedHat and Arnaldo is able to give permissions.
> Arnaldo could you take a look?

Lemme check.

- Arnaldo
