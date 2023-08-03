Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320F776E9F6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbjHCNVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234312AbjHCNVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:21:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C79134
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 06:21:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A24A61D85
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 13:21:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59D7C433C8;
        Thu,  3 Aug 2023 13:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691068878;
        bh=P2Afs0UoL43WPKRc7AQyCm9Zj3/y9gTFP9/secVRq50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j4T7qtVAIdFa4b95sClAHJcmj2/zWG4VCBfAufvVa9/noUF+IXXkuLOa1Jv8wfoXS
         dXqL58HgXsvE0W2Yiz5sP5Ax05/g/O1qHGysvVr3t/7fOQSbZTiLcVClLKzCSW7CF7
         3TuEy2kYu+hUhTdw2Zo4EJ7Z6NjbZnxrIP5KpE1/spdRnFuKvmvJhoDsyeZlDFogek
         cgliUp4Yx/DQVcEB4PiQU2lIBlPGyWf1w9RG9lWRPB8rSjOomXZJxeBSOL6wEp4Gsg
         c3H42Ohahdp8+xdVb9geB+gzwL/PyL4+Dq/DRWvizVXh8n+kyPPB4Vwy883vXmX4cu
         uQvZlY7ZmEC0w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 370214012D; Thu,  3 Aug 2023 10:21:15 -0300 (-03)
Date:   Thu, 3 Aug 2023 10:21:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] perf script python: Cope with declarations after
 statements found in Python.h
Message-ID: <ZMupy4/htzpWO/Ai@kernel.org>
References: <ZMpdKeO8gU/cWDqH@kernel.org>
 <CAP-5=fXOi9-GznqdzsQDsdje7+nL0v57GOPBW24yWD5yX3JDCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXOi9-GznqdzsQDsdje7+nL0v57GOPBW24yWD5yX3JDCA@mail.gmail.com>
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

Em Wed, Aug 02, 2023 at 10:31:21AM -0700, Ian Rogers escreveu:
> On Wed, Aug 2, 2023 at 6:42 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > So add -Wno-declaration-after-statement to the python scripting CFLAGS.
> >
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Link: https://lore.kernel.org/lkml/
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, added the tag to both patches.

- Arnaldo
