Return-Path: <linux-kernel+bounces-120830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB52288DEA3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC9A61C238A8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0239213A24E;
	Wed, 27 Mar 2024 12:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnNZfGcs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3059013A242;
	Wed, 27 Mar 2024 12:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541325; cv=none; b=Yf4Ie6bb9UQn0/QdnW13d3hgwLRrOfnG5IHtWMzsD5H368eP29JWpN3yTlcotZQ02TkIrBXJXve3MN9B9/PVIoX65JLZd5u+xQBJMBl+/KkmQxtblOWK7UYmsTTGaWaRivK1En8YdofqvDlnRclWlH5dpwVcjY/a5VRckEC89kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541325; c=relaxed/simple;
	bh=GloueK3WocEL+gIBegUHsZVz6flv982uVaODEJFynco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iYo1XwWbT7Rgu3jIi5bkfLk8cqJNQyL8ztoIGZtoYiybk2MFZXdiUGVjXDfj4Zu3ii6nV34Nd3MM9BgosrxKQYZnIDZEATauaHgS59pFp8G0UNeBjlX1Sg+/OisZsbq9kBJiDTwerJDJ9BnT0I7HPhxxXeO3U2Sl1JSy59Lx/GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnNZfGcs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB5AC433C7;
	Wed, 27 Mar 2024 12:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541324;
	bh=GloueK3WocEL+gIBegUHsZVz6flv982uVaODEJFynco=;
	h=From:To:Cc:Subject:Date:From;
	b=nnNZfGcszFWuG6wo6q8lebBbQc1KnfZLk0OW6o9zyMu+lKgoJ1U//oRr/l4GycJQ+
	 GuWZfg7t8Wdv3sKcBQCMglko/APvgYKzRqWAw+ELby7OsDV42BBvNrfIBZSs99rzAK
	 IaY68qin140/0B4eHbxG5IVQv/tMvsaj+cP7uJy2B4SShp/L3tcWXnnvQTFPCyT0rG
	 7/4lXkOQ/uKGak8hL+J0wkVITQuClRZ28QpD9V4S6gSZKfKwC4PQ0hkXCk53hJWLlt
	 ooyagGNWwTLSGP5Afg2Bz6cfTOBiIgSdDHUNYq+IWSSR8ytwpK8tcsuJoRhkdYFYxr
	 knAwa6wLGDgDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	akiyks@gmail.com
Cc: Thorsten Blum <thorsten.blum@toblux.com>,
	Breno Leitao <leitao@debian.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "docs: Makefile: Add dependency to $(YNL_INDEX) for targets other than htmldocs" failed to apply to 6.7-stable tree
Date: Wed, 27 Mar 2024 08:08:42 -0400
Message-ID: <20240327120842.2826444-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.7-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a304fa1d10fcb974c117d391e5b4d34c2baa9a62 Mon Sep 17 00:00:00 2001
From: Akira Yokosawa <akiyks@gmail.com>
Date: Tue, 5 Mar 2024 13:23:00 +0900
Subject: [PATCH] docs: Makefile: Add dependency to $(YNL_INDEX) for targets
 other than htmldocs

Commit f061c9f7d058 ("Documentation: Document each netlink family")
added recipes for YAML -> RST conversion.
Then commit 7da8bdbf8f5d ("docs: Makefile: Fix make cleandocs by
deleting generated .rst files") made sure those converted .rst files
are cleaned by "make cleandocs".

However, they took care of htmldocs build only.

If one of other targets such as latexdocs or epubdocs is built
without building htmldocs, missing .rst files can cause additional
WARNINGs from sphinx-build as follow:

    ./Documentation/userspace-api/netlink/specs.rst:18: WARNING: undefined label: 'specs'
    ./Documentation/userspace-api/netlink/netlink-raw.rst:64: WARNING: unknown document: '../../networking/netlink_spec/rt_link'
    ./Documentation/userspace-api/netlink/netlink-raw.rst:64: WARNING: unknown document: '../../networking/netlink_spec/tc'
    ./Documentation/userspace-api/netlink/index.rst:21: WARNING: undefined label: 'specs'

Add dependency to $(YNL_INDEX) for other targets and allow any targets
to be built cleanly right after "make cleandocs".

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: stable@vger.kernel.org  # v6.7
Cc: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Breno Leitao <leitao@debian.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Reviwed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Message-ID: <e876e3c8-109d-4bc8-9916-05a4bc4ee9ac@gmail.com>
---
 Documentation/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 4479910166fc1..b68f8c816897b 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -111,7 +111,9 @@ $(YNL_INDEX): $(YNL_RST_FILES)
 $(YNL_RST_DIR)/%.rst: $(YNL_YAML_DIR)/%.yaml $(YNL_TOOL)
 	$(Q)$(YNL_TOOL) -i $< -o $@
 
-htmldocs: $(YNL_INDEX)
+htmldocs texinfodocs latexdocs epubdocs xmldocs: $(YNL_INDEX)
+
+htmldocs:
 	@$(srctree)/scripts/sphinx-pre-install --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))
 
-- 
2.43.0





