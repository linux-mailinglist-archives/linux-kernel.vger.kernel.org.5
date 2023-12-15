Return-Path: <linux-kernel+bounces-1122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB43814AD1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B807B2409E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB879358BD;
	Fri, 15 Dec 2023 14:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renenyffenegger.ch header.i=@renenyffenegger.ch header.b="jbKzOeOX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from belinda3.kreativmedia.ch (belinda3.kreativmedia.ch [80.74.158.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A40F36B03
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 14:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=renenyffenegger.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renenyffenegger.ch
Received: from localhost.localdomain (localhost [127.0.0.1]) by belinda3.kreativmedia.ch (Postfix) with ESMTPSA id 695D952C11E7;
	Fri, 15 Dec 2023 15:34:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renenyffenegger.ch;
	s=default; t=1702650880;
	bh=SbHhS1tKE3TsbPDWNwF39eh3vG2pB4SKuTVALmfNTHg=; h=From:To:Subject;
	b=jbKzOeOXetmL+nGfdaBWpb4DxxGx7a4cc48WKsc2SOcFDk8tOPfRg7bTpXS1CWRm4
	 oDCCHBUwjNXzRpP8kzxbqkYtPTr9wbe0YL0JYsoN0XyQdhRYxaTT1PqInJgqs2wE2k
	 MKpCE7Uk9o19fHdxDjKvIAdQNZKshOhPiZumvo+8=
Authentication-Results: belinda.kreativmedia.ch;
	spf=pass (sender IP is 31.10.137.33) smtp.mailfrom=mail@renenyffenegger.ch smtp.helo=localhost.localdomain
Received-SPF: pass (belinda.kreativmedia.ch: connection is authenticated)
From: =?UTF-8?q?Ren=C3=A9=20Nyffenegger?= <mail@renenyffenegger.ch>
To: gregkh@linuxfoundation.org,
	cristian.ciocaltea@gmail.com,
	masahiroy@kernel.org,
	cmllamas@google.com
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ren=C3=A9=20Nyffenegger?= <mail@renenyffenegger.ch>
Subject: [PATCH] Update comment (addition of gtags) in scripts/tags.sh
Date: Fri, 15 Dec 2023 14:42:46 +0100
Message-Id: <20231215134246.6352-1-mail@renenyffenegger.ch>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit f4ed1009fc (kbuild: add GNU GLOBAL tags generation) added support
for the GNU Global source tagging system. However, this addition
was not reflected in the script's header comment.

Signed-off-by: René Nyffenegger <mail@renenyffenegger.ch>
---
 scripts/tags.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index a70d43723..cb9696134 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -3,7 +3,7 @@
 # Generate tags or cscope files
 # Usage tags.sh <mode>
 #
-# mode may be any of: tags, TAGS, cscope
+# mode may be any of: tags, gtags, TAGS, cscope
 #
 # Uses the following environment variables:
 # SUBARCH, SRCARCH, srctree
-- 
2.30.2


