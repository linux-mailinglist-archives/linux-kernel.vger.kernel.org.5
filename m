Return-Path: <linux-kernel+bounces-154271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE578ADA1E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30BD41F2143E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA59165FB7;
	Mon, 22 Apr 2024 23:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzf2AMGH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC391635A3;
	Mon, 22 Apr 2024 23:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830188; cv=none; b=NwsZWDnB04SRKBAXXQ6EUk3QxRo/xfrKLPZsRAlXC4XP2LrDjafMFadJ96sZp3hBM66pffEN22jSfsaVTbxjxmzm/sGCg7lTl9l9HOXSN7kEvq+6UE27C+24RhebzAmrfq5fl8TZttRz35poRDFT2cEZ3ajPYZ51W2FMQ45lvHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830188; c=relaxed/simple;
	bh=+JpMFQTdPsaUyqPBbx8fx1lOmW3fraQVX3DN1OV7NrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBZD4vwcCHFCLt025OMJCnT+tovWzcEg+JIUosfJTHZEWWfpwKzJ+N3XzYozp1neRP3ErXpR44rumq2cUctDDnbuC3f+uEnCTRAJHelyIuDyjw8/CIbmqwfzS+cdw8CiNDgOBQLUJjxrTw1+ghTD/KGEgMTEfIVgyhOuaanoPIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzf2AMGH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5E5C2BD11;
	Mon, 22 Apr 2024 23:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830188;
	bh=+JpMFQTdPsaUyqPBbx8fx1lOmW3fraQVX3DN1OV7NrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hzf2AMGHT0EDXkNDNl1+UFTSlqQoVFTFuJJrrfkoI44hqj9OaMJynkszfoxVcpogs
	 VQzENu2PN3KIczPi6RU0FNc2hNfO41y2rESOwhM46XF4nf3cACk9afPiIQFaaCA8bj
	 Cgg44IP484XTt5v1st1tH2H36gQKmR8g+6R262GfQJef3gslXKMjT5dtm4o7BdWnR4
	 XL0jXppUE99BPuOSyHOALAmmcUxZ+daZywbni4K6Jl25INTbcOBN2ZOz5cin0FsKEV
	 pHt/pW8COKzAZvINwhJ35CDxZ88dbUgJ7dtwksAUg99xYkgRmkJ82QsE+kO9Kqh7Ld
	 kVpJuU/KmMT/w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wei Yang <richard.weiyang@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-mm@kvack.org
Subject: [PATCH AUTOSEL 6.6 10/29] memblock tests: fix undefined reference to `BIT'
Date: Mon, 22 Apr 2024 19:16:51 -0400
Message-ID: <20240422231730.1601976-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231730.1601976-1-sashal@kernel.org>
References: <20240422231730.1601976-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.28
Content-Transfer-Encoding: 8bit

From: Wei Yang <richard.weiyang@gmail.com>

[ Upstream commit 592447f6cb3c20d606d6c5d8e6af68e99707b786 ]

commit 772dd0342727 ("mm: enumerate all gfp flags") define gfp flags
with the help of BIT, while gfp_types.h doesn't include header file for
the definition. This through an error on building memblock tests.

Let's include linux/bits.h to fix it.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Suren Baghdasaryan <surenb@google.com>
CC: Michal Hocko <mhocko@suse.com>
Link: https://lore.kernel.org/r/20240402132701.29744-4-richard.weiyang@gmail.com
Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/gfp_types.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 6583a58670c57..dfde1e1e321c3 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -2,6 +2,8 @@
 #ifndef __LINUX_GFP_TYPES_H
 #define __LINUX_GFP_TYPES_H
 
+#include <linux/bits.h>
+
 /* The typedef is in types.h but we want the documentation here */
 #if 0
 /**
-- 
2.43.0


