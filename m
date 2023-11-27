Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3FB7FA2CE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbjK0OcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbjK0ObV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:31:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A355819B0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:31:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150DDC433C7;
        Mon, 27 Nov 2023 14:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701095465;
        bh=PbhIFUrBhOvnfv4NDx5a77aTGBoap14K6Uj6Djcsix4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sP2j4SMQRM0RqzTchLsoyEHreiBoofKTOODh2t08XfmwSlVy6Z4tjOoKFqb6eYahW
         3mmPO7VA+2aeKI5BqKFd/0BYER+Auje4bUgyCfVBPJCgFd2ijS2fUoAx9FLX8IFlNl
         wO2XguiKU7rIPj2cwaEW1JKUuK6Q0mH6no0a8rPO9W2keDW6ggGIEqnt3u9d99QJJZ
         pEzCRN9+7naXwB1hyanofuxQ6xlnmMuB6SMumbmZQi6i7HjIIRkIraH1UYspjkZpum
         VQ7bGmQpOgf/afSmbJ61fjsYW9YmYut0U0IqzsevO1cejRAtZWgBnwoCiQvULBCyb6
         iHO2/D0SnCxpA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BF84040094; Mon, 27 Nov 2023 11:31:02 -0300 (-03)
Date:   Mon, 27 Nov 2023 11:31:02 -0300
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
Message-ID: <ZWSoJnUWnp5Os9zZ@kernel.org>
References: <20231123075848.9652-1-adrian.hunter@intel.com>
 <ZV9cgN3e7jWcRwlu@kernel.org>
 <5B01AC52-3A95-48E2-BBA8-EC499DFFDFC3@linux.vnet.ibm.com>
 <ZWSYYeWGTMQ1OblG@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZWSYYeWGTMQ1OblG@kernel.org>
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

Em Mon, Nov 27, 2023 at 10:23:45AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Nov 27, 2023 at 12:49:13PM +0530, Athira Rajeev escreveu:
> > > On 23-Nov-2023, at 7:36 PM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > I didn’t find this in either of these places:
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=perf-tools-next
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/log/?h=perf-tools-next
> 
> I was still testing it on the containers setup, it is at:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=tmp.perf-tools-next
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/log/?h=tmp.perf-tools-next
> 
> And will move to the perf-tools-next branches soon, I just collected
> some more acked-by for some patches in the tmp branch and will push the
> updated branch.

Done.

- Arnaldo
