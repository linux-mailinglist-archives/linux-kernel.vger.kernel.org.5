Return-Path: <linux-kernel+bounces-60099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 765BE84FFCD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A94E41C2284D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0C436AEF;
	Fri,  9 Feb 2024 22:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="oiKalBI3"
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDB124A1C;
	Fri,  9 Feb 2024 22:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.103.80.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707517300; cv=none; b=I+XPq7C9U55papfMbDZDaW9YHgbMzEYFTqi1tHCyD+ElN22Q/wQYELjWpUZNpyw62nK3rDf6xWYzMViCCbHni0tGyya++gjJzPhwtTMK7aN3cYFxkt4FdO+waYp4pSLyHLZvEOdveUwEWssqr5FvauOkMO50S3OQG2NkzanU5Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707517300; c=relaxed/simple;
	bh=nPUzSVNO0JR5uZFqIok9jwwQ80cWnH4zzFa89Rs2OJE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AKAXrmzNQuzjMavmeZnRTNE8/h+FGhTgeYsDwLBOl/85ccBvVhE9gRSMd4xlThHmBZ1PPnOfCjCNZ3HjoHcZUgtwoc+Bc88hbPH87QK3p0d3dNnTwK7w1q8njnae+FWPj7s/k9thnmIOESOHjtM/qxTBav8BNDVT2KK+ez3nito=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it; spf=pass smtp.mailfrom=vaga.pv.it; dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b=oiKalBI3; arc=none smtp.client-ip=212.103.80.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaga.pv.it
Received: from localhost (unknown [127.0.0.1])
	by mx.kolabnow.com (Postfix) with ESMTP id 5915D20C81F1;
	Fri,  9 Feb 2024 23:21:36 +0100 (CET)
Authentication-Results: ext-mx-out011.mykolab.com (amavis);
 dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
 header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
	content-transfer-encoding:mime-version:message-id:date:date
	:subject:subject:from:from:received:received:received; s=
	dkim20160331; t=1707517295; x=1709331696; bh=FsMLQgcgR2RXy8n0jzd
	bLSB9viHUO86AeksgQ5aNO6o=; b=oiKalBI3Lb2LVuVTAA4FuCw9HvJUkaVaLhY
	HDh9v1ad2gcay7QHTuCNCTJwCDX3jxT13/9yQyarPqhQAKKExKOb6otbb4RzxVp0
	5Pi7fENcavSMYg95ghNYq+SHJ/J59JNPuFon3CjxiN5/Txtp1iy3Fgmwr3nvpgEB
	ziMcDXhVMg2r5RdUHlKv9DgqlayeKalAPQ/DhXveH6oX2nzO82OMyzruNaMDKMAi
	ST3LSHnANPTHjWLmn4snFNYomHXAIq7yn4Aa5HJvxFMt69iICX0uaQLzzj4JrUW2
	4ACuVZf7XBPIOqE2Lm1PUNhyz8OhvtOgyXPEjHwiFSsG3XL6tbSaqGiIIJdm0XuO
	kHUA3/1xb2LP18GZmv/BeerbXtb/DDcQoQAFKWg7bPjuJGkAZxqqiS5SkztFrjMc
	IKbuSvVfxOEsdAU6u1JKlU8bD5Uz7KmARUr6Dwzi+EEX8vxV/ps0qEcLFNewU8TM
	h6mYDL8nMal+kiYZoJAKRR5TaHM3HENpG6hFPFy2+IcC1bavjTNoRqblk8E/9hG3
	qV4A0c+ybq2+BlUBMhYFv0nEFcemYw4FekiQCxky32KXuJSkj1ruHZLMFjvRsgJC
	FwtUBMypUExMQC8Ve7VSR1IW4znn3R1M1J0peghhBxoh0YcGvzhh8TLuotj/QAlG
	D/Bf9zfI=
X-Virus-Scanned: amavis at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level:
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out011.mykolab.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 6Vq4zpR3Yv1N; Fri,  9 Feb 2024 23:21:35 +0100 (CET)
Received: from int-mx011.mykolab.com (unknown [10.9.13.11])
	by mx.kolabnow.com (Postfix) with ESMTPS id 5B92820C73F8;
	Fri,  9 Feb 2024 23:21:35 +0100 (CET)
Received: from ext-subm010.mykolab.com (unknown [10.9.6.10])
	by int-mx011.mykolab.com (Postfix) with ESMTPS id 1A43C30B0C06;
	Fri,  9 Feb 2024 23:21:35 +0100 (CET)
From: Federico Vaga <federico.vaga@vaga.pv.it>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Davide Benini <davide.benini@gmail.com>,
	Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH] doc:it_IT: remove unreferenced and not translated page
Date: Fri,  9 Feb 2024 23:21:15 +0100
Message-Id: <20240209222115.31505-1-federico.vaga@vaga.pv.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The netdev-FAQ page in the italian translation was creted to avoid
having broken links. With the evolution of the documentation this was
not referenced anymore, but the page never removed.

Reported-by: Davide Benini <davide.benini@gmail.com>
Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 .../translations/it_IT/networking/netdev-FAQ.rst    | 13 -------------
 1 file changed, 13 deletions(-)
 delete mode 100644 Documentation/translations/it_IT/networking/netdev-FAQ.rst

diff --git a/Documentation/translations/it_IT/networking/netdev-FAQ.rst b/Documentation/translations/it_IT/networking/netdev-FAQ.rst
deleted file mode 100644
index 8a1e049585c0..000000000000
--- a/Documentation/translations/it_IT/networking/netdev-FAQ.rst
+++ /dev/null
@@ -1,13 +0,0 @@
-.. include:: ../disclaimer-ita.rst
-
-:Original: :ref:`Documentation/process/maintainer-netdev.rst <netdev-FAQ>`
-
-.. _it_netdev-FAQ:
-
-==========
-netdev FAQ
-==========
-
-.. warning::
-
-    TODO ancora da tradurre
-- 
2.39.2


