Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCA97CB810
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 03:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbjJQBj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 21:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjJQBjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 21:39:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE9CA7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 18:39:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C217C433C7;
        Tue, 17 Oct 2023 01:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697506793;
        bh=X9ybuDQ5vbgQfGB4//LGybKQtTMkw3cwEf53bFGt+1Y=;
        h=Date:From:To:Cc:Subject:From;
        b=UXsay9+oKoR2UFUHk/EJa60Oe/iDFMndgT6kXv+5jUr5YPgT/Z3lmm2nvhy/h80mz
         3IMgPXI/g3KPWxXGOxIu1NO196yB91Cb7KXQfdRwI/ZnUR1IXm0/734LDQsIqTDLEo
         ZokRNbtntshQKDkloz2AQGconlMGqGcv6Pu4eluDUukNK/ZEZgVs3iLAR+am2tBgj2
         cjOUtneNOUhCg7ANmMNuX8CYV/bGptVYqojfXn2eJ20jSFecxLh+YxeiygSQ3dVab3
         ejJKN2e46yirnxwzuFMI1NzKysQpekPJJLh/KqpakpBP4nICDFRHhGZxKdt5x31E+l
         8hUCAdCPldIHQ==
Date:   Tue, 17 Oct 2023 10:39:49 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [GIT PULL] probes: Fixes for 6.6-rc6
Message-Id: <20231017103949.3e81d95ecf737e55bdbdf7f3@kernel.org>
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

Probes fixes for v6.6-rc6:

 - Fix fprobe document to add a new ret_ip parameter for callback
   functions. This has been introduced in v6.5 but the document was not
   updated.

 - Fix fprobe to check the number of active retprobes is not zero. This
   number is passed from parameter or calculated by the parameter and it
   can be zero which is not acceptable. But current code only check it is
   not minus.


Please pull the latest probes-fixes-v6.6-rc6 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-fixes-v6.6-rc6

Tag SHA1: 54b9689eff548f43f5862c43dbd48305c52c0579
Head SHA1: 700b2b439766e8aab8a7174991198497345bd411


Masami Hiramatsu (Google) (2):
      Documentation: probes: Add a new ret_ip callback parameter
      fprobe: Fix to ensure the number of active retprobes is not zero


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
