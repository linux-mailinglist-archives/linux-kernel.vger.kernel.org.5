Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040987E7274
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 20:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbjKITt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 14:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjKITt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 14:49:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41ECB3C14;
        Thu,  9 Nov 2023 11:49:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B0BC433C7;
        Thu,  9 Nov 2023 19:49:53 +0000 (UTC)
Date:   Thu, 9 Nov 2023 14:49:56 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Indu Bhagat <indu.bhagat@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-toolchains@vger.kernel.org
Subject: Re: [PATCH RFC 09/10] unwind: Introduce SFrame user space unwinding
Message-ID: <20231109144956.0c20fd98@gandalf.local.home>
In-Reply-To: <20231109193759.6wugcdpucoilnncl@treble>
References: <cover.1699487758.git.jpoimboe@kernel.org>
        <09460e60dd1c2f8ea1abb8d9188195db699ce76f.1699487758.git.jpoimboe@kernel.org>
        <24e46e1c-e9fa-4d44-97f2-068bda6e54b4@oracle.com>
        <20231109193759.6wugcdpucoilnncl@treble>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Nov 2023 11:37:59 -0800
Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> > The structure SFrame FDE in SFRAME_VERSION_1 was unaligned on-disk.  We
> > fixed that in SFRAME_VERSION_2 (Binutils 2.41) by adding some padding as you
> > have already noted. For x86_64, its not an issue though, yes.  
> 
> Agreed.  I actually had v2 implemented but then realized my binutils was
> older so I changed to v1 for testing.  But yeah, we can make v2 the
> minimum.

Cool, my test box has binutils 2.41, so it should be good to go ;-)

-- Steve
