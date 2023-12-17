Return-Path: <linux-kernel+bounces-2790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 749B08161E6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 21:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B17B1C210C4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 20:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D220481B1;
	Sun, 17 Dec 2023 20:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renenyffenegger.ch header.i=@renenyffenegger.ch header.b="fcxFUIbI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from belinda3.kreativmedia.ch (belinda3.kreativmedia.ch [80.74.158.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E2E481A0
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 20:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=renenyffenegger.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renenyffenegger.ch
Received: from localhost.localdomain (localhost [127.0.0.1]) by belinda3.kreativmedia.ch (Postfix) with ESMTPSA id F415A52C117F;
	Sun, 17 Dec 2023 21:03:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renenyffenegger.ch;
	s=default; t=1702843398;
	bh=B/bryHy8sOFhgzvuWK91HuVG4+9anT7IYo8PB05dxR0=; h=From:To:Subject;
	b=fcxFUIbIMOd61t1OrZqZp/o/gfMedDr4dUKaT2wJatw37mdHGg6P95/XGSbgOsxuF
	 C+3GJwTXBqbVp20OW2Hs0Z7j9J9Gj9fnNcaHaH02dW+BUqioTSVDxsgjiAoN9OUNXu
	 xqg8eB4Gm8WCMc4C3bE38FyEn2gQs0YFZ4zmbD2U=
Authentication-Results: belinda.kreativmedia.ch;
	spf=pass (sender IP is 31.10.136.22) smtp.mailfrom=mail@renenyffenegger.ch smtp.helo=localhost.localdomain
Received-SPF: pass (belinda.kreativmedia.ch: connection is authenticated)
From: =?UTF-8?q?Ren=C3=A9=20Nyffenegger?= <mail@renenyffenegger.ch>
To: gregkh@linuxfoundation.org,
	cristian.ciocaltea@gmail.com,
	masahiroy@kernel.org,
	cmllamas@google.com
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ren=C3=A9=20Nyffenegger?= <mail@renenyffenegger.ch>
Subject: [PATCH v2] Update comment (addition of gtags) in scripts/tags.sh
Date: Sun, 17 Dec 2023 09:27:19 +0100
Message-Id: <20231217082719.4747-1-mail@renenyffenegger.ch>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit f4ed1009fcea ("kbuild: add GNU GLOBAL tags generation") added
support for the GNU Global source tagging system. However, this addition
was not reflected in the script's header comment.

Fixes: f4ed1009fcea ("kbuild: add GNU GLOBAL tags generation")
Signed-off-by: René Nyffenegger <mail@renenyffenegger.ch>
---
v2 of this patch adds the "Fixes:" tag that was missing in
https://lore.kernel.org/all/20231215134246.6352-1-mail@renenyffenegger.ch/

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


