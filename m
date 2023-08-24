Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72493787B5E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 00:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243822AbjHXWRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 18:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243869AbjHXWRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 18:17:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B50C7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 15:17:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BEEC66B81
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 22:17:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D21EC433C7;
        Thu, 24 Aug 2023 22:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692915464;
        bh=0NvJDo9ck5StkAPdt9jpacHYFZus12xU2AcY/dSsPHE=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=OYgEE5HWN0UAf8CVnArjP8f8trld0m/IBeOUC9Drwc4oZASbf2eydt036DDf6WzCp
         vo0il5IXpZV9BxqGNg2G9TgH22/+kp97SDJ6bjnNpD6QC1Lb+qCe+jKEIXCNiCy6nr
         PCe8M+lpYIiDEG4GA6BeibSceXW+wyapEr+PY+xI5U0Mzh7N0m8PqZi5w8ek34QeEE
         LvxWHpooMjd+4EBGrgxdOHtLWD7xVtQLoZ819mgvUVZNyAP+4iMluvN/K2AJEghhSM
         biaMs5D2p7YQi4oC/Q1x6kJ+zBMalk6KYKE01gt8jTnaVZshnsUmk8T3V9Vp8jlG/s
         w60M2sehLEZoA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 08DC7CE134A; Thu, 24 Aug 2023 15:17:44 -0700 (PDT)
Date:   Thu, 24 Aug 2023 15:17:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, imran.f.khan@oracle.com,
        peterz@infradead.org, jgross@suse.com, vschneid@redhat.com,
        yury.norov@gmail.com
Subject: [GIT PULL] CSD-lock diagnostic changes for v6.5
Message-ID: <5a9cbe81-e583-4a96-81c4-396fd14fde96@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

Once the merge window opens, please pull the following CSD-lock changes.

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/csd-lock.2023.07.15a
  # HEAD: 0d3a00b370424f5f1b9fd037bc8a4a3e7cbf0939: smp: Reduce NMI traffic from CSD waiters to CSD destination (2023-07-10 14:19:04 -0700)

----------------------------------------------------------------
CSD lock commits for v6.5

This series reduces the number of stack traces dumped during CSD-lock
debugging.  This helps to avoid console overrun on systems with large
numbers of CPUs.

----------------------------------------------------------------
Imran Khan (2):
      smp: Reduce logging due to dump_stack of CSD waiters
      smp: Reduce NMI traffic from CSD waiters to CSD destination

 kernel/smp.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)
