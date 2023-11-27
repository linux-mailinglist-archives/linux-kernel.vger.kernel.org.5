Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049567FA0F6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbjK0NYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 08:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbjK0NX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 08:23:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD78210D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 05:23:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E111C433C7;
        Mon, 27 Nov 2023 13:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701091428;
        bh=C059we5gZtoUR2N+7x+pLdZMoDPDWRQZK42QQNzTTMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qa3Y1nZ2LSyfweJn3bmRdy3P72ve6qCyUCpIjMqMe4BCZ87sb+YWEAVdQe4MjfV9v
         hp3PWBGYXsxKPcivJD59vQXLvrZjDOCe6EGFiqVNgflR76KWBr1SEAnjtEnes4NCsd
         ZPwZHBfdAXsKWfLFlfrwPMuFZkQq+Mdn7HWtHbNW3zfOthj/r9cnFgncSgjVIzGUOs
         ywCZv9BuP7ka2Sq1Ed7b6T+NgwrNYV1pZxt0il9gZks1GQ4YV1DbJESeNs3SF0xIvy
         Inh5D0fDbpKD8ycujtlD6kiQrdLbE7c/g85QkCKQ8LJg/YPVqnfHynwBFaQ0H9I5sT
         qi/sd+2PtBKDg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D2A3040094; Mon, 27 Nov 2023 10:23:45 -0300 (-03)
Date:   Mon, 27 Nov 2023 10:23:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Tinghao Zhang <tinghao.zhang@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/8] perf tests: Reduce inexplicable test failures
Message-ID: <ZWSYYeWGTMQ1OblG@kernel.org>
References: <20231123075848.9652-1-adrian.hunter@intel.com>
 <ZV9cgN3e7jWcRwlu@kernel.org>
 <5B01AC52-3A95-48E2-BBA8-EC499DFFDFC3@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5B01AC52-3A95-48E2-BBA8-EC499DFFDFC3@linux.vnet.ibm.com>
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

Em Mon, Nov 27, 2023 at 12:49:13PM +0530, Athira Rajeev escreveu:
> 
> 
> > On 23-Nov-2023, at 7:36 PM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > 
> > Em Thu, Nov 23, 2023 at 09:58:40AM +0200, Adrian Hunter escreveu:
> >> Here are some small changes to help reduce inexplicable perf test failures.
> > 
> > Looks ok, applying to perf-tools-next, had to remove a patch adding a
> > new test, by Kan Liang, then reapply it on top of your series, git
> > managed to sort it out:
> 
> Hi Arnaldo,
> 
> I didn’t find this in either of these places:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=perf-tools-next
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/log/?h=perf-tools-next

I was still testing it on the containers setup, it is at:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=tmp.perf-tools-next
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/log/?h=tmp.perf-tools-next

And will move to the perf-tools-next branches soon, I just collected
some more acked-by for some patches in the tmp branch and will push the
updated branch.

- Arnaldo
 
> Sorry if I missed checking correct location. Can you please point to git link ?
> 
> Thanks
> Athira
> > 
> > https://lore.kernel.org/r/20231107184020.1497571-1-kan.liang@linux.intel.com
> > 
> > 
> > - Arnaldo
> 

-- 

- Arnaldo
