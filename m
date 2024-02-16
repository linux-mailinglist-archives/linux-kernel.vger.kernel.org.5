Return-Path: <linux-kernel+bounces-69357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F08B08587D3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FE9D1F243B4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4A1145FFC;
	Fri, 16 Feb 2024 21:16:58 +0000 (UTC)
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FFF1419BF;
	Fri, 16 Feb 2024 21:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708118217; cv=none; b=rMl7kEQ/uUAic6C6FDZcrrSP7rCfLyW6SQ5MbPfoE0r7qdSuji6NaZWmjk/+5giTpERj11nrsLJ0x3nSuKUzuCfjHEAFhgejKc0lVl/ZHD9gRUBTKHvNdORAQbahL6ofU7ROpdW+iJbSw0FQr2E9aOoaeFeSxIoo/8gCAVo9hA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708118217; c=relaxed/simple;
	bh=vsUzdyJf3pTQ7iUhH2zrKBom94/d9kxFvZKujmQlDa8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=C47endjyJfvtxLwdkGL3+1z4KV31SIg5yumN+xQixIaIif88+oHxyS7awHNN9atRmtlV2YcjAk8cIUNAdfiIOP69j5Ne8b8lZ3Lawfn/l9oF9xqo/xWh5UXdhmxXoYhskPpKpLwi1tBYEIp2u4XyWWyqn6/o57N3D0qV/vQekHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id AA20687245;
	Fri, 16 Feb 2024 22:16:45 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Subject: [PATCH v2 0/2] leds: expresswire: Fix dependencies
Date: Fri, 16 Feb 2024 22:15:42 +0100
Message-Id: <20240216-expresswire-deps-v2-0-8be59c4a75f5@skole.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAH7Qz2UC/32NQQrCMBBFr1JmbSRJbUldeQ/pIjSjGZSmzEisl
 Nzd2AO4fP/z399AkAkFzs0GjJmE0lzBHhqYop/vqChUBqvtSVtjFa4Lo8ibGFXARRS6oUMXvEP
 fQp3V+kbrrryOlSPJK/Fnf8jml/6RZaO06l3ng9FT6If2Io/0xGNkGEspX9WBO7uvAAAA
To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Flavio Suligoi <f.suligoi@asem.it>, Hans de Goede <hdegoede@redhat.com>, 
 Jianhua Lu <lujianhua000@gmail.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Helge Deller <deller@gmx.de>, Jingoo Han <jingoohan1@gmail.com>, 
 Karel Balej <balejk@matfyz.cz>, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-leds@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=846;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=vsUzdyJf3pTQ7iUhH2zrKBom94/d9kxFvZKujmQlDa8=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlz9CFR8jXTTpNjeM5Z13FI+8f8Uv4Ix9lAQpaT
 Jn64esMzpWJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZc/QhQAKCRCaEZ6wQi2W
 4RfwEACDN/l5D7tzp7o766y36S3GhsHIEtzUEBCRk0smhUo5lpciXjTWgIQ6I+0jjopw+PcFgIG
 keEipaCgUGqaHg5rT3DMbhUYiQlloAX+Il3q4dXGtQPa66bp5+LAkMSyLiiFJd5jYNYlDED3vg5
 PDxTaXZxFKf437PJv0/9XwzMVhuDScudoKLp05K1rzil3WWxjqRnh9ljn/wlUDYZzKvnrYU73tb
 8utBDSnh7YF8/o7MLJrhH53zTya1Qd9LYXJiXcVMTG0fNaWWQLnse0LKnzjhMAL4nNiF32Uxi+h
 te2BisSHEzflz04dBfXWT3VUQZzuz5nzUDJvfSz08Hm7E9yxBLPV/bg2yhUlXkrvt1qGX2oLxQA
 iNOap3FLdazQfgl9sUPcVh6HazF9grJQ3Uo08ZQW/y00HdBgkOTtP3RIMLAt0qZIVdc3NSe0nRy
 dGARsxhrs3BzXZqh9CpZdEDP2m1xEK1Ywx8zXksC8n0Dd1+MwymROLay2ut/6i1Qxm2XN0UWovi
 HB0d+iE9JiFYKTmA9rsdpz0H8izcEbwrmonCYFiv0PywgcYqtgrzsdVeruX3qWCEu/8a9Im4Ker
 hEoPoIWK3sSX4gXRUbNs6QGiw2E5xtTiU2ztPMyerPn7Rb5OSRVV1ChUEf0xbsq2TA4h1Z86dM1
 duaZbd+56zSXTCg==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1

LEDS_EXPRESSWIRE does not depend on NEW_LEDS in practice but still does
in Kconfig. Fix up its Kconfig entry to reflect this and fix a Kconfig
warning.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
Changes in v2:
- Fix checkpatch errors
- Pull Daniel's Reviewed-by
- Link to v1: https://lore.kernel.org/r/20240212-expresswire-deps-v1-0-685ad10cd693@skole.hr

---
Duje Mihanović (2):
      Revert "leds: Only descend into leds directory when CONFIG_NEW_LEDS is set"
      leds: expresswire: don't depend on NEW_LEDS

 drivers/Makefile     |  2 +-
 drivers/leds/Kconfig | 10 ++++++----
 2 files changed, 7 insertions(+), 5 deletions(-)
---
base-commit: ae00c445390b349e070a64dc62f08aa878db7248
change-id: 20240212-expresswire-deps-e895e8da8ea3

Best regards,
-- 
Duje Mihanović <duje.mihanovic@skole.hr>



