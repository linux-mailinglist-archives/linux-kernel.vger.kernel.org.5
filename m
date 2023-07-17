Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7A5756B22
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjGQSBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGQSBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:01:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A538E;
        Mon, 17 Jul 2023 11:01:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11F3D611C3;
        Mon, 17 Jul 2023 18:01:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C34C433C7;
        Mon, 17 Jul 2023 18:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689616861;
        bh=u2+EHFMEH1ec9mTq7zwZQD+FBRuMUdr66YKUaT6vtJs=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=sqbgm1nKOOx6S9BmXyeTB0Hg2nZOUwoHxia5TDL6qpM3imvNvtnHFeFeYWdg6e+Uz
         MnBGISkGkV2yqVUU4L8cHnUlRQronNcqooL34RNkRuLYi8LB9MV3u6+0TY1QN031Gg
         RGRchl7qhFTIrGnFjbjNYBvx1x4hb9SFVfSlHJJ5MUk0ABQBghZusGtMB+bH1LdS4H
         7HnC+RjqA5X0tD1/RZBNenFF0Bc6zko7JA7LuZX+FWPb911jHlATpMuqjxb5gUSkMl
         YNv8RFkg4cbJNG6gmuVhUEypTxZneYaPqtGo1CsThDyrQgxT/+9qkN7zASvnz/qNyV
         +Bs6FGr3FV9HQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 053C1CE03F1; Mon, 17 Jul 2023 11:01:01 -0700 (PDT)
Date:   Mon, 17 Jul 2023 11:01:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/7] Documentation updates for v6.6
Message-ID: <ee7a3e6b-eb1b-4413-b5c3-83b22f7271dd@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains documentation updates:

1.	documentation/rcu: Fix typo, courtesy of Tycho Andersen.

2.	docs/RCU: Add the missing rcu_read_unlock(), courtesy of Alan
	Huang.

3.	Docs/RCU/rculist_nulls: Fix trivial coding style, courtesy of
	SeongJae Park.

4.	Docs/RCU/rculist_nulls: Assign 'obj' before use from the examples,
	courtesy of SeongJae Park.

5.	Docs/RCU/rculist_nulls: Specify type of the object in examples,
	courtesy of SeongJae Park.

6.	Docs/RCU/rculist_nulls: Fix hlist_[nulls]_head field names of
	'obj', courtesy of SeongJae Park.

7.	Docs/RCU/rculist_nulls: Fix text about atomic_set_release(),
	courtesy of SeongJae Park.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/RCU/rculist_nulls.rst   |   38 +++++++++++++++++++++++-----------
 b/Documentation/RCU/lockdep-splat.rst |    2 -
 b/Documentation/RCU/rculist_nulls.rst |    4 ++-
 3 files changed, 30 insertions(+), 14 deletions(-)
