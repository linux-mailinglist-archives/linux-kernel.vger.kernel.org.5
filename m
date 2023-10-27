Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2903B7D9A33
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345987AbjJ0Nj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345954AbjJ0Njz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:39:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843901A7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 06:39:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73CAC433C8;
        Fri, 27 Oct 2023 13:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698413993;
        bh=K1n5c9rQ/qe3e3IncOBFgW5/PfZSET5tGuj+Igr0VT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T6epLDz4g7CRB9/bsgqS758g9JtDU+MrEaYsHqWjrEs0bncyX+NmBxHHcqNhxzUEM
         oZcTIPDP1kBLHkLdhU9mxQCvmRdYtgaX6jO0ApzeDKwY73lHtZo8yd33o5ILx3Qw8g
         Qa4l020qA0wWfSFG6TDDfUV2xqI7biRr4KAia+CnIMp+CKUVATf/lhKp4yyC18CgEK
         Xl7b7hrDPE41pEa8/+4c43C2M1YKwtG7WkJcW25ms+bqdFt6zegqRGhDZhq0zwybKJ
         cPVUeViqhqr1XRYqEmuwoRqNsyE3DKkKAK7zl/ahfHl4G+JlzYMhVPzfFdtibP6Zx1
         Ngy9NFszH987Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 449404035D; Fri, 27 Oct 2023 10:39:46 -0300 (-03)
Date:   Fri, 27 Oct 2023 10:39:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf python: Add missing util/rlimit.c file to the
 python binding linkage list
Message-ID: <ZTu9omkWbbShhN97@kernel.org>
References: <20231027023028.1106441-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027023028.1106441-1-yangjihong1@huawei.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 27, 2023 at 02:30:28AM +0000, Yang Jihong escreveu:
> Fixes: c4a852635edd ("perf data: Increase RLIMIT_NOFILE limit when open too many files in perf_data__create_dir()")

This is not the cset that introduced the problem, I added it to the
patch I submitted for this:

Fixes: e093a222d7cba1eb ("perf evsel: Rename evsel__increase_rlimit to rlimit__increase_nofile")

Since the patch in your messgage basically has what is in the patch I
submitted, I added an:

Acked-by: Yang Jihong <yangjihong1@huawei.com>

to it.

In the future, the right thing would be for you to use:

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>

As I didn't provide a Signed-off-by for the patch, I just mentioned that
the patch cured things for me, sometimes a patch like this may not be
the ultimate fix.

Thanks,

- Arnaldo
