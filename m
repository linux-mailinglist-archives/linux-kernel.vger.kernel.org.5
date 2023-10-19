Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C907CF78E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345410AbjJSLzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235234AbjJSLzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:55:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9990AA3;
        Thu, 19 Oct 2023 04:54:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27A7C433C7;
        Thu, 19 Oct 2023 11:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697716499;
        bh=3Rjnnv8gYcApUSKEkh/ed5uX79sQ+/CcglGx45LPGIc=;
        h=From:To:Cc:Subject:Date:From;
        b=sOIqEn9BshtSI/RvA7iSeONwf6/rZXpWt+XaBT1xlstXFyeD0TscC292cO/IBZwTh
         cUX7djfqirF28gnlQzwDBxogG4A7zNf52u6PEQGNgY5ZblftQETN2/igqIlBJ5tUVB
         fiIJuJvK3mUoVmtxi8n0pxgiVaUx+bDCgwR8APr6pBD3CR+Rxc+j453SIVIDV/dDqE
         U7BLw/F5D+JTqLBjPKL54K7Ip8l67Y3fPRCK374arIi7IatDHluwFrw0GXnMHuLL/S
         HNa9l5sT+nuocVahds4IbR7ET6HZ9Z9UIVVSdIJXbAT+97QqoRUZjES0Kq3P6v6lRk
         Y2rfPghxYeiXQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: [PATCH 0/3] RCU refscale update for v6.7
Date:   Thu, 19 Oct 2023 13:54:49 +0200
Message-Id: <20231019115452.1215974-1-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Please find below the RCU reference scalability test updates for the
next merge window:

Paul E. McKenney (3):
  refscale: Fix misplaced data re-read
  refscale: Print out additional module parameters
  doc: Add refscale.lookup_instances to kernel-parameters.txt

Thanks,
        Frederic.

 Documentation/admin-guide/kernel-parameters.txt | 6 ++++++
 kernel/rcu/refscale.c                           | 6 +++---
 2 files changed, 9 insertions(+), 3 deletions(-)

-- 
2.34.1

