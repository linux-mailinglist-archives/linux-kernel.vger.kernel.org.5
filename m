Return-Path: <linux-kernel+bounces-21470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B2E828FDB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 968DFB2154F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57853DBB4;
	Tue,  9 Jan 2024 22:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lqp5NxiL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6673DB8F;
	Tue,  9 Jan 2024 22:24:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F7FC433C7;
	Tue,  9 Jan 2024 22:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704839049;
	bh=vxtpJA2s8AqkXkFQ5LmLxQ6bcmMMv6WCaSKfKwRX4fk=;
	h=From:To:Cc:Subject:Date:From;
	b=Lqp5NxiLmN/4gOFoZBuO+DGWOCFL2outeDPK2obA7pe3pqH0Q4N68GlMFgd5A1eIK
	 tNHLQIUvLzZK5GfG1thFvPn7nt9P/PuYAOoBEu1upljgrODeNK9IJelIUs2kH8cFkg
	 J6SfcgFg7h0KIlEHBkOHJN97THlkZrDo9d3JiHOtmPan41Klkl2d9T8tNCE8zGvEWB
	 IUSNL2sAAoHvkb9+sKf3JMclm7YT335W0UFFiQuhHKg+xRD/Buauk5gv6V5hxeJXys
	 +yGHWkVo9Ugs5k05aqYcJnzCRKDuDhwvweZi4AB8HPIwpMZz+AyuvF+KEfcFpeRy2R
	 L6hykXF0ygLhg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 0/2] rcu/nocb cleanups
Date: Tue,  9 Jan 2024 23:23:59 +0100
Message-ID: <20240109222401.28961-1-frederic@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This is an excerpt from the "[PATCH 0/8 v2] rcu: Fix expedited GP
deadlock (and cleanup some nocb stuff)" patchset with only nocb bits
that were off-topic.

No change since their previous posting.

Frederic Weisbecker (2):
  rcu/nocb: Make IRQs disablement symmetric
  rcu/nocb: Re-arrange call_rcu() NOCB specific code

 kernel/rcu/tree.c      | 47 +++++++++++++++++++++---------------------
 kernel/rcu/tree.h      |  9 ++++----
 kernel/rcu/tree_nocb.h | 38 +++++++++++++++++++++-------------
 3 files changed, 51 insertions(+), 43 deletions(-)

-- 
2.43.0


