Return-Path: <linux-kernel+bounces-35488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFE48391F0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 674EE28B162
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F2C6027B;
	Tue, 23 Jan 2024 15:01:41 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD46760245;
	Tue, 23 Jan 2024 15:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022101; cv=none; b=uCMDAoEf9yenPE5n2/tAtL52NZ72fkXvDZHKJHZBsYH1fW29hRPttrZcnygOE06D8EQB15FKipkw9GW8aJyL0p0VnqBf6rLUf8K4tqKYR3Wl1v9Ec+ZV9L0XJUrpizQmFjqUATj/W+oqmj689D6SLtxfguAcCiZVjnxlEOjfj34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022101; c=relaxed/simple;
	bh=LF/Zv34rP0TE5uHznHjOOjgOXrdxlJsgqn+hUNEhMoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SRxKshKnEsUOP07fnkcaf4ruzu14F0RU5PEuo+Y4QmZP5OTjUdXLMgB2Ip7NfP1F7X9DU9JDCoWifnbZoXVTNvtOJILXJodsiVcu8gLqyNRzzsj2i6NltI6ItS5+Ru80K6jeyKzXx0qlJcxQpKK81Xr27dqJsTmAesg//xX//2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; arc=none smtp.client-ip=217.72.192.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
Received: from localhost.localdomain ([95.223.130.98]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MN4qp-1riRiR27oT-00J5cR; Tue, 23 Jan 2024 16:01:14 +0100
From: Valentin Obst <kernel@valentinobst.de>
To: Valentin Obst <fraunhofer@valentinobst.de>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Trevor Gross <tmgross@umich.edu>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: [PATCH v2 03/12] rust: ioctl: end top-level module docs with full stop
Date: Tue, 23 Jan 2024 16:00:57 +0100
Message-ID: <20240123150112.124084-4-kernel@valentinobst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123150112.124084-1-kernel@valentinobst.de>
References: <20240123150112.124084-1-kernel@valentinobst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LS8V/WWp0eE5kmG//AQ+zgNdRy47Aut6zKjHjLeqmqCGTjC8pGr
 suiRKm3UGQBBTU9SwUO80B+kkBoQo2RxOjHPRPO60Wb9RkOwZeIuCmwaOCEVXQ1U3HMthJh
 NkLEG+4wUd9g1Y+Jq7IwOxx9yGZXYl0on+HSZD2lniaxZ2W0LmexF9+2ucDjIKwe3h7rWMr
 joKZbs7exEFVR1g6XP/gQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IVt1gdfbCUw=;D7Cdf2hPORWC49VRD1JKimfhVyw
 XdoPcv/c627eVnruDfSUv/Zkbi/3UM+OxLOe6AUXPx8zuBBcgR2cKx9fcGZhRM1BajAozi21i
 c5c5lc7GYW237lwlosyeaBx5iz+tEM39wuR+gLBtUTiUHgOK56EDzUO+Hc5q9AaPWZ1OAMv6j
 gdw5FDLDP5rmYhMvwS2uOgfeaVzF9whg006GGRJzDq1OnkVN2Fg7JF4rkTeXgHbAo+yh8BhoH
 p40f0noPJf48EbwYnX3c25wA0U+Dp7f3JTErg1+ChbCh1bTa1TzHRPd2HRxZrx0yJ72gGBJy+
 NTG6znYp3ehfBq60RXWp8IlDvGW63YZKkrWT2+YAoSIrdKczo2/PPgZZOIZQQhvQMvAZ7SVtO
 Xfnochw1vd+6/bDw/eJuNK+1AT0aTPcYXmQ9RivGLcE0OdTqlrRmzkfI/8613thK+ssFvwWkr
 MfozngybxNS8+wMEKkW5gWSALd3e96XYs+58dcraU/VNULJyVpzUA6EOvPzpV8SNF5GfBSzmv
 kCu6pu5yyHvWppZ3MkA4C+qkbjYTjmiuoweeXN5N6n3nqmTMTT32uR5eKkatYrM9gTLyoFmC6
 /x7rj4id2dRW2s9x8F4S1h7TJzKkx0IqmOJ0/h36hxEPjDkuXA9wl9kwbQh+aWODs7mPztT/X
 TbwlHpGp46g4huZGXvCzMJUmnjbwC83TtZfBd+2IRjyHBtmMoA28qaPGIcMXL0ochSlNfdhSI
 vsILYt/eOZwJ3eZv4wGknIN7PGTpRiPe8q715Xfap/5EbhPre0Cbj57YALgN4c9y9Cq8J1Qel
 2bDfpMwe4/9rQX+lvWj9k+Th8do/2Bf7++wFQyfGwD9q240YpfLoRiS5iqicR6zfEs5V5f2ls
 x4chgwrcxUFR0gQ==

Every other module ends its first line of documentation with a full
stop. Adapt the only outlier.

Signed-off-by: Valentin Obst <kernel@valentinobst.de>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
---
 rust/kernel/ioctl.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/ioctl.rs b/rust/kernel/ioctl.rs
index 59050e5f5a5a..5987ad6d38a7 100644
--- a/rust/kernel/ioctl.rs
+++ b/rust/kernel/ioctl.rs
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-//! ioctl() number definitions
+//! ioctl() number definitions.
 //!
 //! C header: [`include/asm-generic/ioctl.h`](srctree/include/asm-generic/ioctl.h)
 
-- 
2.43.0


