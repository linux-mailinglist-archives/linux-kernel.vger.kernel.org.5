Return-Path: <linux-kernel+bounces-20084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8DC827915
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970CD1F2399B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A19955780;
	Mon,  8 Jan 2024 20:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="Km3dH0NA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE0F55C09
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 20:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 40F28240106
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 21:19:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1704745154; bh=lf5MzC4u4JCsFDts+R6PhzoZ89yrvoguPVHpbORk/xM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=Km3dH0NAQ/+OVyp0gZoHmgkUdE4Au5dJCt40AfOdRbMX1Vdf6xfiSAzHZgZMxRKDd
	 x54VunuwvfGuHCXkTYywpZzvGcjSr54UPS+FHMZE2MnzvtYc99UnmmH7XkjpC33BJ2
	 X1exeYs+ObCKws+reFDxjAqXbBfbuo02xmym2Bg/E5I9FwNpDrmCOMR5VHewFihXDB
	 pZeFSuLpqf8T/SPKBDfVi21rDsEVB44OOz7N0Ee6tHhwMZy6KVAesLYDAjGQtHjdJI
	 tbswdHEHNeyIsBDrJwD2UONBxhuhbOkx9RyyfGu/NYwSSn/j+gBV1GaLXGDRB3Tz7L
	 PYoMDfNpKiCtw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4T854Z1lvxz9rxK;
	Mon,  8 Jan 2024 21:19:09 +0100 (CET)
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
Subject: [PATCH v3 0/1] coding-style: recommend reusing macros from split headers instead of kernel.h
Date: Mon,  8 Jan 2024 20:18:43 +0000
Message-ID: <20240108201851.191604-1-shamrocklee@posteo.net>
In-Reply-To: <107b6b5e-ca14-4b2b-ba2e-38ecd74c0ad3@infradead.org>
References: <107b6b5e-ca14-4b2b-ba2e-38ecd74c0ad3@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear Maintainers,

This patch targets the "Linux kernel coding style" documentation and
recommend reusing macros inside the include/linux directory instead of
the obsolete header "include/linux/kernel.h".

This addresses the issue 'Irrelevant documentation recommending the use
of "include/linux/kernel.h"'[1][2] and help deprecating "kernel.h".

Changes in this roll:

Drop the patch mentioning the naming collisions caused by
locally-defined macro variants.[3]

Drop the patches that updates the zh_TW and zh_CN translation. I'll
send them again once the change of the untranslated documentation gets
ready.

Best regards,

Shamrock

[1]: https://lore.kernel.org/linux-doc/bc63acd7ef43bdd8d9609fa48dbf92f9@posteo.net/
[2]: https://lore.kernel.org/linux-doc/107b6b5e-ca14-4b2b-ba2e-38ecd74c0ad3@infradead.org/
[3]: https://lore.kernel.org/linux-doc/87ederwuid.fsf@meer.lwn.net/

Yueh-Shun Li (1):
  coding-style: recommend split headers instead of kernel.h

 Documentation/process/coding-style.rst | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

-- 
2.42.0


