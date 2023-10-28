Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3EDB7DA652
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 12:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjJ1KBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 06:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjJ1KBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 06:01:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A78E0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 03:01:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F80EC433C8;
        Sat, 28 Oct 2023 10:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698487261;
        bh=jD8diEFIWGkaeDjK5iWfzamXjWLpGg30ZsZP3jbzSYU=;
        h=Date:From:To:Cc:Subject:From;
        b=au/dFyMAVVJzftz+nC8826XWpuynsNeq/sclFwvaqN3jYZ7qxZWlPLq4+fFAm9BJR
         1B0hQDgbFTCdSty/0G8ieX5otgRF2We/D6IqmUPNPZmcr+9KXUA8qUVp1dLsPaN8ks
         +9JV4tOj9OTROHlOoIqh/PLuNA5maZsih93iK4IkmGs4DmEwSPbOiAtlQwGTEWdLra
         tfLeHJoBuOb62+naFuXC9F3lore+zX1yxBPGwMz6cyJ8VnWlnb6YKEdDbWm3JWctWB
         lph6vhIeDmkG+L2xZl5mjqjixPhbS/J2gz6PMsi7OGHZaehSw8hsxYD2TLxTX5Xw04
         l1OAlpuIivWUw==
Date:   Sat, 28 Oct 2023 19:00:56 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Yujie Liu <yujie.liu@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] probes: fixes for v6.6-rc7
Message-Id: <20231028190056.dde870427d845332e99e9db9@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Probes fixes for v6.6-rc7:

- tracing/kprobes: Fix kernel-doc warnings for the variable length
  arguments.

- tracing/kprobes: Fix to count the symbols in modules even if the
  module name is not specified so that user can probe the symbols in
  the modules without module name.


Please pull the latest probes-fixes-v6.6-rc7 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-fixes-v6.6-rc7

Tag SHA1: 454c20691731e6dd7e8b67f3ef6cbc3b666583e5
Head SHA1: 926fe783c8a64b33997fec405cf1af3e61aed441


Andrii Nakryiko (1):
      tracing/kprobes: Fix symbol counting logic by looking at modules as well

Yujie Liu (1):
      tracing/kprobes: Fix the description of variable length arguments

----
 kernel/trace/trace_kprobe.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
