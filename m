Return-Path: <linux-kernel+bounces-69605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3A6858C48
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 02:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4579F1F21ACC
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFD623748;
	Sat, 17 Feb 2024 00:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ab1s7a8Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A731B80F;
	Sat, 17 Feb 2024 00:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708131528; cv=none; b=qOvYOpeYqJWT2ZzLAQcAiyA18b1hfma/ykMpZlkTCv9WLOJ4aQq7ASccP6ZTo/ON3euxNAtraJQzA1VgZGsiph5bqjspyFYEkqJLqiupZTClz7W7sztnfIwxvNx3iJOy8vF3VBhV8JvGO0/7BAYpeIWKMQUG7QE3bTzVo2yuc0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708131528; c=relaxed/simple;
	bh=ZF7Ys29G8g/k6D1jFHkNld6ID7JrPCUQzMebjrLS5cc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DLm5Y1xswx8lGGuvCA+3gmcRW5S1hBfGm2vTcj3Lq/8bMJRLk/q0hPn1r1vAj29Ek/gjgNTXexeUf3dHXElir4EKBBjgDFQl5jMsfCX8Dhm5h/cggINih7NxLatYaRs+vC1YRD8rjED2m3VlxFQc3Ut0vR+8kdv0/VSheFc/6sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ab1s7a8Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A969C43394;
	Sat, 17 Feb 2024 00:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708131528;
	bh=ZF7Ys29G8g/k6D1jFHkNld6ID7JrPCUQzMebjrLS5cc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ab1s7a8ZVMd65Gov613sVFUA9Z1HOsB0ADjuIBE2ac+9N/3GFt/fZ3Jh3yqR3KlAU
	 ZBCbYFIJ/7sYSlVdaUALdwiw7n5Vz70vwWf/AMYu6WrYE30mAQ5MznaR6kRP2y/VwZ
	 eApMMw8nps4ukwaCWHjwmqguvLzL6Z7xRQBAmFLZfPLPv5aG9wQAYvZvMcvBsKcOTQ
	 go4PJwvFy2JnFHrjrtignzt40wD0jMQVyWcqbkCYt37sb71r90hFvv3Ib8T5u9ZP9w
	 P1SYlEYr2cLkqkL8Q/QYAVJOpFM2r/ZPc5tslHjzZIMxnD2DQGrKbNzR5QMRQkwm0G
	 TEa6NN702cKYQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] Docs/mm/damon: move the list of DAMOS actions to design doc
Date: Fri, 16 Feb 2024 16:58:39 -0800
Message-Id: <20240217005842.87348-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240217005842.87348-1-sj@kernel.org>
References: <20240217005842.87348-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS operation actions are explained nearly twice on the DAMON usage
document, once for the sysfs interface, and then again for the debugfs
interface.  Duplication is bad.  Also it would better to keep this kind
of concept level details in design document and keep the usage document
small and focus on only the usage.  Move the list to design document and
update usage document to reference it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 47 ++++++--------------
 Documentation/mm/damon/design.rst            | 26 +++++++++--
 2 files changed, 36 insertions(+), 37 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 58c34e66b31b..0335d584956b 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -302,27 +302,8 @@ In each scheme directory, five directories (``access_pattern``, ``quotas``,
 
 The ``action`` file is for setting and getting the scheme's :ref:`action
 <damon_design_damos_action>`.  The keywords that can be written to and read
-from the file and their meaning are as below.
-
-Note that support of each action depends on the running DAMON operations set
-:ref:`implementation <sysfs_context>`.
-
- - ``willneed``: Call ``madvise()`` for the region with ``MADV_WILLNEED``.
-   Supported by ``vaddr`` and ``fvaddr`` operations set.
- - ``cold``: Call ``madvise()`` for the region with ``MADV_COLD``.
-   Supported by ``vaddr`` and ``fvaddr`` operations set.
- - ``pageout``: Call ``madvise()`` for the region with ``MADV_PAGEOUT``.
-   Supported by ``vaddr``, ``fvaddr`` and ``paddr`` operations set.
- - ``hugepage``: Call ``madvise()`` for the region with ``MADV_HUGEPAGE``.
-   Supported by ``vaddr`` and ``fvaddr`` operations set.
- - ``nohugepage``: Call ``madvise()`` for the region with ``MADV_NOHUGEPAGE``.
-   Supported by ``vaddr`` and ``fvaddr`` operations set.
- - ``lru_prio``: Prioritize the region on its LRU lists.
-   Supported by ``paddr`` operations set.
- - ``lru_deprio``: Deprioritize the region on its LRU lists.
-   Supported by ``paddr`` operations set.
- - ``stat``: Do nothing but count the statistics.
-   Supported by all operations sets.
+from the file and their meaning are same to those of the list on
+:ref:`design doc <damon_design_damos_action>`.
 
 The ``apply_interval_us`` file is for setting and getting the scheme's
 :ref:`apply_interval <damon_design_damos>` in microseconds.
@@ -763,19 +744,17 @@ Action
 ~~~~~~
 
 The ``<action>`` is a predefined integer for memory management :ref:`actions
-<damon_design_damos_action>`.  The supported numbers and their meanings are as
-below.
-
- - 0: Call ``madvise()`` for the region with ``MADV_WILLNEED``.  Ignored if
-   ``target`` is ``paddr``.
- - 1: Call ``madvise()`` for the region with ``MADV_COLD``.  Ignored if
-   ``target`` is ``paddr``.
- - 2: Call ``madvise()`` for the region with ``MADV_PAGEOUT``.
- - 3: Call ``madvise()`` for the region with ``MADV_HUGEPAGE``.  Ignored if
-   ``target`` is ``paddr``.
- - 4: Call ``madvise()`` for the region with ``MADV_NOHUGEPAGE``.  Ignored if
-   ``target`` is ``paddr``.
- - 5: Do nothing but count the statistics
+<damon_design_damos_action>`.  The mapping between the ``<action>`` values and
+the memory management actions is as below.  For the detailed meaning of the
+action and DAMON operations set supporting each action, please refer to the
+list on :ref:`design doc <damon_design_damos_action>`.
+
+ - 0: ``willneed``
+ - 1: ``cold``
+ - 2: ``pageout``
+ - 3: ``hugepage``
+ - 4: ``nohugepage``
+ - 5: ``stat``
 
 Quota
 ~~~~~
diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 1bb69524a62e..9f16c4e62e72 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -294,9 +294,29 @@ not mandated to support all actions of the list.  Hence, the availability of
 specific DAMOS action depends on what operations set is selected to be used
 together.
 
-Applying an action to a region is considered as changing the region's
-characteristics.  Hence, DAMOS resets the age of regions when an action is
-applied to those.
+The list of the supported actions, their meaning, and DAMON operations sets
+that supports each action are as below.
+
+ - ``willneed``: Call ``madvise()`` for the region with ``MADV_WILLNEED``.
+   Supported by ``vaddr`` and ``fvaddr`` operations set.
+ - ``cold``: Call ``madvise()`` for the region with ``MADV_COLD``.
+   Supported by ``vaddr`` and ``fvaddr`` operations set.
+ - ``pageout``: Call ``madvise()`` for the region with ``MADV_PAGEOUT``.
+   Supported by ``vaddr``, ``fvaddr`` and ``paddr`` operations set.
+ - ``hugepage``: Call ``madvise()`` for the region with ``MADV_HUGEPAGE``.
+   Supported by ``vaddr`` and ``fvaddr`` operations set.
+ - ``nohugepage``: Call ``madvise()`` for the region with ``MADV_NOHUGEPAGE``.
+   Supported by ``vaddr`` and ``fvaddr`` operations set.
+ - ``lru_prio``: Prioritize the region on its LRU lists.
+   Supported by ``paddr`` operations set.
+ - ``lru_deprio``: Deprioritize the region on its LRU lists.
+   Supported by ``paddr`` operations set.
+ - ``stat``: Do nothing but count the statistics.
+   Supported by all operations sets.
+
+Applying the actions except ``stat`` to a region is considered as changing the
+region's characteristics.  Hence, DAMOS resets the age of regions when any such
+actions are applied to those.
 
 
 .. _damon_design_damos_access_pattern:
-- 
2.39.2


