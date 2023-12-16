Return-Path: <linux-kernel+bounces-2370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C81815BD0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 22:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 166FFB23687
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 21:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF8135281;
	Sat, 16 Dec 2023 21:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renenyffenegger.ch header.i=@renenyffenegger.ch header.b="LKl0zfj4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from belinda3.kreativmedia.ch (belinda3.kreativmedia.ch [80.74.158.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB3735279
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 21:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=renenyffenegger.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renenyffenegger.ch
Received: from localhost.localdomain (localhost [127.0.0.1]) by belinda3.kreativmedia.ch (Postfix) with ESMTPSA id E459552C09D7;
	Sat, 16 Dec 2023 22:12:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renenyffenegger.ch;
	s=default; t=1702761161;
	bh=4vW+T3KHLFqfr2zpg6bp0rN6ZibezijreMWtP2WOKMg=; h=From:To:Subject;
	b=LKl0zfj4hw6Nby6fhbMZKBah+weCEB9h3BL2+xaB8Wq17t0AAM9mRoJMqVbt/yv0p
	 b+ZZfJDQnh1GA2Nivt8zNn2wq91u8iaeKRFedywfqn0qFwSF/r9Gcxhu5Syg3n4Dgg
	 /IyuApltezZ7Axt977oMpz0UMYDALpegmF1hgcHk=
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
Subject: [PATCH v2] Update comment (addition of gtags) in cripts/tags.sh
Date: Sat, 16 Dec 2023 22:12:32 +0100
Message-Id: <20231216211232.2699-1-mail@renenyffenegger.ch>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit f4ed1009fcea (kbuild: add GNU GLOBAL tags generation) added support
for the GNU Global source tagging system. However, this addition
was not reflected in the script's header comment.

Fixes: f4ed1009fcea ("kbuild: add GNU GLOBAL tags generation")
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


