Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C887D4321
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 01:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjJWXQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 19:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJWXQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 19:16:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33558FD
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 16:16:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7365C433C7;
        Mon, 23 Oct 2023 23:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698102996;
        bh=zbY2gx3vk7DOKP5W4QGAuwgHd+f4eBuIPdPnVGxW5K4=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=HoIVCXPksvMpoddkmDZ039uOxahKjcblG52msBRDB5APXuz3LR630RZmoool3Bk0D
         /GO1npHyeVxmoBT/LWLogUn5jK6OPzcEj9dXRaKKC16TfwuLwoIAutfxOqoRL9XqjO
         cYKzsLQpxSQkr9MS/rlyqKyphxfuKwKH/iyTE4djzdty9nZw6zDOUCDBeA+WUaM0x1
         v9bCF+aHqf10CKrJEBn2OahcB4OP0WXBsS3QhUIP2zJuvW78hJt2cRAAKgQ8g5oLYW
         Vu/ozc7CLGUswGkV6P8pysjLZ4uN1ximXIPbWzRt4QFySXa7ACOc0yNr38VcOv5aVl
         lKRrm6P1OQTqg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 43CBFCE0593; Mon, 23 Oct 2023 16:16:36 -0700 (PDT)
Date:   Mon, 23 Oct 2023 16:16:36 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com, w@lwt.eu,
        linux@weissschuh.net, ammarfaizi2@gnuweeb.org
Subject: [GIT PULL] urgent nolibc changes for v6.6
Message-ID: <7a47c501-667a-499a-8c11-8039538d18ab@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URG_BIZ autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

Please pull the following urgent nolibc commits from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/urgent/nolibc.2023.10.16a

  # HEAD: 921992229b1f06df6b649860e4a5f3def1489866: tools/nolibc: mark start_c as weak (2023-10-12 21:13:51 +0200)

----------------------------------------------------------------
Urgent pull request for nolibc into v6.6

This pull request contains the following fixes:

o     tools/nolibc: i386: Fix a stack misalign bug on _start

o     MAINTAINERS: nolibc: update tree location

o     tools/nolibc: mark start_c as weak to avoid linker errors

----------------------------------------------------------------
Ammar Faizi (1):
      tools/nolibc: i386: Fix a stack misalign bug on _start

Thomas Weiﬂschuh (2):
      MAINTAINERS: nolibc: update tree location
      tools/nolibc: mark start_c as weak

 MAINTAINERS                      | 2 +-
 tools/include/nolibc/arch-i386.h | 4 +++-
 tools/include/nolibc/crt.h       | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)
