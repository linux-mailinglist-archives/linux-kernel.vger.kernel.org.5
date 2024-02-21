Return-Path: <linux-kernel+bounces-75167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E75985E40E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A87228449E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BE283CBB;
	Wed, 21 Feb 2024 17:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wfm1TXQh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDD883A11;
	Wed, 21 Feb 2024 17:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535341; cv=none; b=MJ0LRe5OpVP5adOGGduQVx8Hs/njoWZzOPKMxHPnJT5aCxkocirS/GZ55QM8vnfKB3j4gzyYPVocnQr6gtAFPfKNG854p6Rd8P8wnu0hkqlw47E0Oqgouxz8yEgDB59jtjeCPLy8PRZTRO3V9USBK8bfXHEsX84tu60IVB2ePKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535341; c=relaxed/simple;
	bh=1ND4XP4BxD7dsWp7WEvskmKXUzn2yblG+QlUdQjJo1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bZ5oOsDOP0DuS4CfNIRzKCHZGigrRz3Of2FbpuP228i2qkEq2/a6DGSOZVGoD3G4T3F1L5dIECUGYmA95bngiqhv8AAJelKBicczAlY9TBAyqujNBT60BHhCRK0qgpz73AV+NQS2NBi51BN2vw+SI6Fz+mdT052BrMeSCf3XGGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wfm1TXQh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C73C43390;
	Wed, 21 Feb 2024 17:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708535340;
	bh=1ND4XP4BxD7dsWp7WEvskmKXUzn2yblG+QlUdQjJo1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wfm1TXQhjKaSzsfxfL+J32M1OfAcR0cKwIlrb+7ExreEkf3sBLNzFd4wNabN7pAHj
	 dmbV8Uye7i31X9meR26wvY3+TbEQcO/nh7H/3o0mpGVKhaUOcspBJ3cLeiXPT4LgTA
	 DreWJsCNHLq6ZMHWNkM5e2B+QMy9LlpBBpRGVf1aTPxvpS1KmTDKqzqXFduyDBNjal
	 pjd4W20wgXhqJ0r/SRBCS+zlffQ5CPrZRTu2rs0Birl8ss36/XHgIa57q7eIr90Kzq
	 hvW/xDLn8uSS7hfSpqY3QwlfUq0dW0aNaWsps2UdUmyFxgucZrdXeLqzrIKKa0+Bt5
	 0x98L9WdINZTw==
From: SeongJae Park <sj@kernel.org>
To: akpm@linux-foundation.org
Cc: corbet@lwn.net,
	sfr@canb.auug.org.au,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH mm-unstable 1/2] Docs/admin-guide/mm/damon/usage: fix a typo on a reference link
Date: Wed, 21 Feb 2024 09:08:51 -0800
Message-Id: <20240221170852.55529-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240221170852.55529-1-sj@kernel.org>
References: <20240221170852.55529-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was a typo cuasing a document build warning below.  Fix it.

    WARNING: undefined label: 'damon_design_confiurable_operations_set'

Fixes: afc858f0e6db ("Docs/mm/damon: move DAMON operation sets list from the usage to the design document")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index b33eecfd0e901..952528f0739ba 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -184,7 +184,7 @@ and three directories (``monitoring_attrs``, ``targets``, and ``schemes``)
 exist.
 
 DAMON supports multiple types of :ref:`monitoring operations
-<damon_design_confiurable_operations_set>`, including those for virtual address
+<damon_design_configurable_operations_set>`, including those for virtual address
 space and the physical address space.  You can get the list of available
 monitoring operations set on the currently running kernel by reading
 ``avail_operations`` file.  Based on the kernel configuration, the file will
-- 
2.25.1


