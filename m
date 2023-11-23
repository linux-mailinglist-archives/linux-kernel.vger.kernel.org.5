Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58AE7F6105
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345672AbjKWOGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345666AbjKWOGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:06:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E724E1BD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:06:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36DA1C433C8;
        Thu, 23 Nov 2023 14:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700748419;
        bh=7AjvflHZ4Q+tu2gcCZ/AZVRiLJFF8yXIkk94/htWwjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pn0GNNcfjUmL+7d0znpJmSBi5Yw0vWYwinKR+w0AGhbKoxycoTMusmCIXXBXUIBc9
         h7Yf9xJY039OIOZ6p8D5yt3e8OOgA0zd5ODTk8hamd6R0xnJ5mlrY3RBVFmmxH5f/r
         4ehKuQX3/03Jcjam0q+umi3OChh/oYL5y4x9CfRXMVJ9SS+UMl9vkfQTc7kJVQICGm
         jrptxGUXHNOXYhPa6fzqWk51sQkS7kzX6LnpB5WAJAWhTsE0YGcN3IR+mlcmcQ00DC
         1lOFwF7T7MpyfekIUrQAte4H/tXXFNX9oBNG0dmwgf0anY2w+w2UUXdwuQYmIc13xd
         IxIbJnLu+oz7A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B179E40094; Thu, 23 Nov 2023 11:06:56 -0300 (-03)
Date:   Thu, 23 Nov 2023 11:06:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Tinghao Zhang <tinghao.zhang@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/8] perf tests: Reduce inexplicable test failures
Message-ID: <ZV9cgN3e7jWcRwlu@kernel.org>
References: <20231123075848.9652-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123075848.9652-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 23, 2023 at 09:58:40AM +0200, Adrian Hunter escreveu:
> Here are some small changes to help reduce inexplicable perf test failures.

Looks ok, applying to perf-tools-next, had to remove a patch adding a
new test, by Kan Liang, then reapply it on top of your series, git
managed to sort it out:

https://lore.kernel.org/r/20231107184020.1497571-1-kan.liang@linux.intel.com


- Arnaldo
