Return-Path: <linux-kernel+bounces-128547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E12895C42
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBA1F286654
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956F815B56B;
	Tue,  2 Apr 2024 19:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bu1IJvQ9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12B415B117;
	Tue,  2 Apr 2024 19:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712085146; cv=none; b=cT3YlsAHmMjt+wT2yjOQ0MhNWVkvoFIwljqAMv3H4hjzz96l+XSu5ckxEkTZVCnWtplLQjog+Vl1iHI4io9CwdMk+z7zeVBGRfUNVcF75E6VT6pvSHDw+Ac530bnpFiwE9uiEl7vaK8rRcXq1UdkARTHCilfG9uq43jc0v+6A3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712085146; c=relaxed/simple;
	bh=VkeMLGAFW5//bstFf8gEidTfiDwlUjD0+6EaPVW/RZw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P0FKSj9bOJxSdNYd9aNE7v68wiUrBoNgzOKVlDr8pQxHrPepGZRQMINRjwQ1rugmV2rtquFYNYP2z3sBWHn20Zqt5dLva2Acsw4TD14uxjlv0+roMT/2ESnqkeaR184bFyUYKDpjZMV/yMB0plPBaJBO6lyd1bGC1HcJtCu4yMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bu1IJvQ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15744C433F1;
	Tue,  2 Apr 2024 19:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712085146;
	bh=VkeMLGAFW5//bstFf8gEidTfiDwlUjD0+6EaPVW/RZw=;
	h=From:To:Cc:Subject:Date:From;
	b=bu1IJvQ9VVWqhvPIcIUUDwnnsAAuIZsq79OaI+ekyVJsAXxd/qlHUZ1fL5WSfuWZG
	 rRuBUFMXfP6e0wo+m7jIA82OeU4QxtRZNxzcHl8hVzi+pHwoe6hmtsIw6fZ/j6W0zk
	 00qrwSzv0hD7P/pallol9lwIHKqRvq+4RJ6BPOtzJz0MrEC3abj3x1VdtYmzlZJb0r
	 lLDa6VDr9Nl3noLR+w0wQS6hQrxYV0NjufY2n8WiS5+BfRhPd9IK6R8k0/VI6vGsYm
	 psRAErL585HWU/01Hdw4mkhNxaFQXwRmG4SSuPxojUSyl2qbcOPcXkX712Rvp4fXiM
	 ra2Nlf9HdGNWA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Quaterly News Letter (2024 Q1)
Date: Tue,  2 Apr 2024 12:12:24 -0700
Message-Id: <20240402191224.92305-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello DAMON community,


Already the first quater of 2024 has passed.  Meanwhile, there were some
exciting news on DAMON community.  Let me share my humble summary of those.

Januarry 2024
=============

Memory management subsystem pull request[1] for Linux v6.8-rc1 that contains
aim-oriented user-feedback driven DAMOS aggressiveness auto-tuning has merged.

SK Hynix shared[2] their DAMOS-based tiered memory management test results
showing 4-17% performance slowdown reduction, with patches for that.

LSF/MM/BPF 2024 topic proposal for DAMON has posted[3].

February 2024
=============

DAMON in Amazon Linux 5.10.y kernel[4] has updated to that of v6.7 Linux
kernel.

DAMON talk for OSSummit NA 2024 has been accepted and scheduled[5].

DAMO v2.2.2 is released with a new command, 'replay'[6].  It is aimed to help
reproducing the real-world memory access pattern for analysis and benchmarks.

Yet another academic paper[7] exploring DAMON for tiered memory management will
be presented at EuroSys 2024[8].

March 2024
==========

DAMO v2.2.4 is released with a new feature for access pattern-based
profiling[9].  Users can know which code is making their program's memory usage
unexpectedly high, or which code is intensively accessing memory, and optimize.

DAMON maintainer received the invitation for LSF/MM/BPF 2024.

Memory management subsystem pull request[10] for Linux 6.9-rc1 that contains
aim-oriented self-feedback driven DAMOS aggressiveness auto-tuning has merged.

References
==========

[1] https://lore.kernel.org/linux-mm/20240108155039.fd2798712a2a93a108b710ce@linux-foundation.org/
[2] https://lore.kernel.org/damon/20240115045253.1775-1-honggyu.kim@sk.com/
[3] https://lore.kernel.org/linux-mm/20240129204749.68549-1-sj@kernel.org/
[4] https://github.com/amazonlinux/linux/tree/amazon-5.10.y/master/mm/damon
[5] https://sched.co/1aBOg
[6] https://github.com/awslabs/damo/blob/v2.2.2/release_note#L5
[7] https://pasalabs.org/papers/2024/Eurosys24_M3_Camera_Ready.pdf
[8] https://2024.eurosys.org/
[9] https://github.com/awslabs/damo/blob/v2.2.4/USAGE.md#profile
[10] https://lore.kernel.org/all/20240313200532.34e4cff216acd3db8def4637@linux-foundation.org/


To recap, the long-awaited DAMOS auto-tuning feature has merged.  More people
from the academy and the industry explored and contributed on DAMON.  DAMON
user-space tool got more useful features.  We will have yet another DAMON
presentation and discussion at OSSummit NA and LSF/MM/BPF.

It was a grateful quarter.  Looking forward to next news of the second quarter.
Happy second quarter and hacking, community!


Thanks,
SJ

