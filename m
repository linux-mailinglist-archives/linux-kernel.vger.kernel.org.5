Return-Path: <linux-kernel+bounces-75166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A2985E40B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D28971F2560F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F63483A09;
	Wed, 21 Feb 2024 17:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkiwtVes"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA4A80C03;
	Wed, 21 Feb 2024 17:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535340; cv=none; b=tXJY+UgwsnnPHNE3Vi2YHZl1H4qC02YDY10Px2vu6KVgEsW9C0xs9fgSkb0CPwcN3tM35bcosqOlvDJYBWouvFWkLShfJWSGVqRoP9S6qVZtqVG76P6IhhPn678uhw/IfmDgU0fg0HUOuxr6X7XpzjlXLvsQBYFkeewceStah9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535340; c=relaxed/simple;
	bh=Iebx3DhDS6Bx0b0HmR+RiWnRVdPqC8qv6l5MTMORFjk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u9DsqK8/wP8Sineqx3TQ9NNJnIx1N4vzkj60MUlTd8+r7JkQ9Dp3Azjn7HC+JKXLBYeUB64v0ufPoyrejNCOFoLT59GSwv/K9OcjEDhZlkvY3YPAGeTqwkHEJ/2ZJ68sAbxvcyrs5OLzBpDfwKLSPoieEiE4+ri2iQzzEGci/lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkiwtVes; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395E6C433C7;
	Wed, 21 Feb 2024 17:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708535339;
	bh=Iebx3DhDS6Bx0b0HmR+RiWnRVdPqC8qv6l5MTMORFjk=;
	h=From:To:Cc:Subject:Date:From;
	b=SkiwtVesGyygNUQAt9GjEawOkXaHiIAsJIZbRDMSw4YW0jbHTFnt9dMZXIX2qryPR
	 UNdi5KVTD1kTwsIpcfmxDL0+1RFJU2zjLFAMKcz8TLvIIlLVTHTH+mvrWENmEwhFOR
	 DH5OPpQTY4y1rrbpA00EB+Fa9Wuqf7s5teMl6VcIcg+5kjM7z28EZao5MtNHUlSbek
	 w9IfsN0cRE54rRBHgXuDiuIO+9wINYoimAfpxHfOyk57x0weHewA9SrxXcI8WrVbkT
	 O9GQxQHzpxBOeZ1hpTxVX4p+l+Fthwwq9qP/HYKZGznfWoXnk18/VDdtob9GWxO3AJ
	 h/hdaZNOGa9Fg==
From: SeongJae Park <sj@kernel.org>
To: akpm@linux-foundation.org
Cc: corbet@lwn.net,
	sfr@canb.auug.org.au,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH mm-unstable 0/2] mm/damon: fix typos on reference links
Date: Wed, 21 Feb 2024 09:08:50 -0800
Message-Id: <20240221170852.55529-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some patches that merged in mm-unstable have typos that cause document
build warning.  Fix those.

SeongJae Park (2):
  Docs/admin-guide/mm/damon/usage: fix a typo on a reference link
  Docs/admin-guide/mm/damon/usage: fix a typo on the auto-tuning design
    reference link

 Documentation/admin-guide/mm/damon/usage.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.25.1


