Return-Path: <linux-kernel+bounces-133366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6609D89A2E3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E9A7287F1C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322F3171652;
	Fri,  5 Apr 2024 16:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOkWhwsg"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165A81CFBC;
	Fri,  5 Apr 2024 16:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712335767; cv=none; b=NeYHLdCLyzBgmk71lz/R+Od8UBsWMy3U7aiIlPX7wM4E2rn9Xo+nu0TfXd4i6jqT6UKhbZ+tBbmiVaDPfZ5B1rG/1eW8j950a168tpPNMHLJw5iE2vJx6apcd1BgI0R0lFrb4zQdsHgGVCE1zyDZqYbtB4A7fMjzPYspNsFltjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712335767; c=relaxed/simple;
	bh=T0g8xyK5uS/p7J8GajjFc1VMqONFTU1lTEm8f8h3bs8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m0DHHo+FaakVEyLyRoAR96R+DpX6BBwaY7ucuoAaojkSDBjvvGIqJ9wIuRhJFtxtyqwlAEHiIbI8Uw1nrAvTs+0SubxKCWmT0hoEM0+DDLK6Pzrndp/1hAecJVmCsJ4oohpjYORe2ilT3we+LD2pAEpdo8vpQLFRgG0sb9sNwQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOkWhwsg; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e6ff4e1e97so1353667a34.3;
        Fri, 05 Apr 2024 09:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712335765; x=1712940565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Q301Hmu4jkyy54Tck51kniDcTmciVu05IC0+dyM5+M=;
        b=eOkWhwsgpgjkk+rLAAYLZiSHO83CVPCQykN5qDWUw3DrgsENm5Ilxk4TtoRFXU2EmW
         OcQPsFNGbD3XuDKtdSJ0wapJBQzJ69z1Y0AW37r20obaXKYg+Nv+vyOj+2l0sucOZvgS
         4prVhphKfR7BIXgkaXx1MKbP9/oZ2hEGlV2CSfWevUo0dQ7UVDfXHCMcI+YluSTEE4RD
         8YFHjM2xbRm1TrvK43m9u2FLIC65/9YhUV23loqxQCFq1Y3pJJ+7gQ3YBLtKqum9YfJZ
         D3l0mUikqotalPQay5h6tdhjStQmKiI3Kvrm4w6PqvzCDa7nkXJwKVfYZKqHotLvzEXs
         OuPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712335765; x=1712940565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Q301Hmu4jkyy54Tck51kniDcTmciVu05IC0+dyM5+M=;
        b=pNAXt4pemaCU0p48MnVCiYDdQ5I8K+UIElFzrRRHGB0FUMNHK1gwYiPYWjyRav0MtZ
         /WFAYsbusWCfiYIOhMPdLmGlwlhxpX4xAD9ixAx1TN1Ym1e9hy0VxzpzjII0EobBLE22
         C1V/sT3nbzCrpKa48KBXzAnea37nGEIN62OYZRI72WvtFRw3RXft4e5Rp5yEeO8JOxOu
         cMvCzyUDji/COrqBsK/DuTNtZg4Nzaw2gTSFVluOsuc4vTBdZJ7kgF3VdyOZx3qbCrgO
         SFsmThPtiNNFlNh480hhmIp7dydMo1t/YUygRbYz4h2mKA43aXyW/4IoK/ckKXGPgSiv
         qyzw==
X-Forwarded-Encrypted: i=1; AJvYcCVDl8LVF+pvwof9zUNJJda607CmvgO2/6wr1KydE4KblXBNvrZAY4XrCefmBeTB62p+vTP1KChQNIEwI1yh3KcIe/SxJVt7GB6iDY+o8t4vTAV8o9V41cVPdOyHpET2sjwIUx8v3TzM
X-Gm-Message-State: AOJu0YzdOiCTbjXKnrZAhOEA1m1ykhvZuRomrLHfBr4W7RSRws8nB0I/
	XXPIwio24HQ78UXvzCDhFtPPhJZ2RbKpnGJ1bgXhAh7RlgSvzPQb
X-Google-Smtp-Source: AGHT+IEzk99QfVxQGmX333/pp4ac+5cgTfZoHLprBPeFsWR06+FIxuNZhd/TPqokoDumENH73G4qLg==
X-Received: by 2002:a05:6830:1043:b0:6e9:e688:23eb with SMTP id b3-20020a056830104300b006e9e68823ebmr2026680otp.35.1712335765094;
        Fri, 05 Apr 2024 09:49:25 -0700 (PDT)
Received: from localhost.localdomain (024-171-058-032.res.spectrum.com. [24.171.58.32])
        by smtp.gmail.com with ESMTPSA id d25-20020a05683018f900b006e8aeb6706bsm340376otf.6.2024.04.05.09.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 09:49:24 -0700 (PDT)
From: Matthew Cassell <mcassell411@gmail.com>
To: corbet@lwn.net,
	akpm@linux-foundation.org,
	vbendel@redhat.com,
	rppt@kernel.org
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mcassell411@gmail.com
Subject: [PATCH] Documentation/admin-guide/sysctl/vm.rst adding the importance of NUMA-node count to documentation
Date: Fri,  5 Apr 2024 16:49:20 +0000
Message-Id: <20240405164920.2844-1-mcassell411@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If any bits are set in node_reclaim_mode (tunable via
/proc/sys/vm/zone_reclaim_mode) within get_pages_from_freelist(), then
page allocations start getting early access to reclaim via the
node_reclaim() code path when memory pressure increases. This behavior
provides the most optimization for multiple NUMA node machines. The above
is mentioned in:

Commit 9eeff2395e3cfd05c9b2e6 ("[PATCH] Zone reclaim: Reclaim logic")
states "Zone reclaim is of particular importance for NUMA machines. It
can be more beneficial to reclaim a page than taking the performance
penalties that come with allocating a page on a REMOTE zone."

While the pros/cons of staying on node versus allocating remotely are
mentioned in commit histories and mailing lists. It isn't specifically
mentioned in Documentation/ and isn't possible with a lone node. Imagine a
situation where CONFIG_NUMA=y (the default on most major distributions)
and only a single NUMA node exists. The latter is an oxymoron
(single-node == uniform memory access). Informing the user via vm.rst that
the most bang for their buck is when multiple nodes exist seems helpful.

Signed-off-by: Matthew Cassell <mcassell411@gmail.com>
---
 Documentation/admin-guide/sysctl/vm.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index c59889de122b..10270548af2a 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -1031,7 +1031,8 @@ Consider enabling one or more zone_reclaim mode bits if it's known that the
 workload is partitioned such that each partition fits within a NUMA node
 and that accessing remote memory would cause a measurable performance
 reduction.  The page allocator will take additional actions before
-allocating off node pages.
+allocating off node pages. Keep in mind enabling bits in zone_reclaim_mode
+makes the most sense for topologies consisting of multiple NUMA nodes.
 
 Allowing zone reclaim to write out pages stops processes that are
 writing large amounts of data from dirtying pages on other nodes. Zone
-- 
2.34.1


