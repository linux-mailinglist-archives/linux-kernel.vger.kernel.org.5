Return-Path: <linux-kernel+bounces-19825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CDF8274C1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ABE0B22229
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAC552F67;
	Mon,  8 Jan 2024 16:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="q3QHvqdK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDD6524C8
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 16:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 870DD24002D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 17:15:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1704730537; bh=Ts/rOOm0/Jq58HYvOJXottonXceweiTE91bQUrYjFqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=q3QHvqdKJhTn1p6fiWYdee57zvhifiCR2vUxYtlkYlDApvZHCc1yrdS3w760e27Vv
	 r8Osz2cuC41ts3vtM6YZ2XfIfv/JHwACVG69zZnLS6PHixmT5Ar1aw7l+w5j+BttZr
	 jpm2qrf+rXg0W9JN/B8aV2tn5TEJ5Vp17TwdHkr8ZYW5ol/0guxFfkhnhRF0GtBEHD
	 i1zyJ0IQWpJMRMfvnvUXLsA0CMhh06p/yjW4hNderRJhD1Ww3YQLla8elGXxD0L5C0
	 E0ZAcN0BRLwN+T33PMT2EHuKVt114vZp2dtikmU6/rC/gYARk3XT/o1K9b3cahFIrf
	 ZsJXYQekFFYkg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4T7zgR3Q0kz9rxF;
	Mon,  8 Jan 2024 17:15:30 +0100 (CET)
From: Yueh-Shun Li <shamrocklee@posteo.net>
To: Jonathan Corbet <corbet@lwn.net>,
	Hu Haowen <src.res.211@gmail.com>,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: Yueh-Shun Li <shamrocklee@posteo.net>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] coding-style: recommend reusing macros from split headers instead of kernel.h
Date: Mon,  8 Jan 2024 16:03:21 +0000
Message-ID: <20240108160746.177421-1-shamrocklee@posteo.net>
In-Reply-To: <107b6b5e-ca14-4b2b-ba2e-38ecd74c0ad3@infradead.org>
References: <107b6b5e-ca14-4b2b-ba2e-38ecd74c0ad3@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Dear Maintainers,

This series of patches targets the "Linux kernel coding style"
documentation and recommend reusing macros inside the include/linux
directory instead of the obsolete header "include/linux/kernel.h".

This addresses the issue 'Irrelevant documentation recommending the use
of "include/linux/kernel.h"'[1][2] and help deprecating "kernel.h".

If applied, developers will no longer be confused by the contradiction
between "Linux kernel style guide" suggestions and the deprecation
notice on top of "kernel.h".

There's also a patch that adds an example to show how reusing macro
definition from shared headers help prevent naming collisions.

This series contains the update to the zh_TW and zh_CN translation of
the corresponding documentation changes.

Best regards,

Shamrock

[1]: https://lore.kernel.org/linux-doc/bc63acd7ef43bdd8d9609fa48dbf92f9@posteo.net/
[2]: https://lore.kernel.org/linux-doc/107b6b5e-ca14-4b2b-ba2e-38ecd74c0ad3@infradead.org/

Yueh-Shun Li (4):
  coding-style: recommend split headers instead of kernel.h
  coding-style: show how reusing macros prevents naming collisions
  doc/zh_TW: coding-style: update content for section 18
  doc/zh_CN: coding-style: update content of section 18

 Documentation/process/coding-style.rst        | 41 +++++++++++++++----
 .../zh_CN/process/coding-style.rst            | 39 ++++++++++++++----
 .../zh_TW/process/coding-style.rst            | 39 ++++++++++++++----
 3 files changed, 95 insertions(+), 24 deletions(-)

-- 
2.42.0


