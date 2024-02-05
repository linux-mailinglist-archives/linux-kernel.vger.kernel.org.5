Return-Path: <linux-kernel+bounces-52068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8EF8493B5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 346851F22743
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DDA107B6;
	Mon,  5 Feb 2024 06:09:33 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCB8BE4A;
	Mon,  5 Feb 2024 06:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707113373; cv=none; b=GlvYEW8nFuNEWiZfur33jpeSqtglll3k7hNtTvePNFNWgfFyB71ddBiGxjNX++QAOoz/Sw2F9DXocNhYYkn9veiBR4KquDa+8dKFhXCtpvlfFoose1/WvNA5lRyfxxNSzzyuRBxcVsS0RmMuril89bFs03f67mL6xMvNNxn11HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707113373; c=relaxed/simple;
	bh=ubohSoxy0nNlpG/cl6FoJaVJyCyPjAubm2llac2X1YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OS/XBayf+FtH7kE/Q+TfdDeJm5l2maBBB0EHkT2GwOR3AA/yKG8LLZvt30BDoI1PvK2ONWUt6zqQb3YzZzuLZ8BYocSeQru3DB8SYE6Bdis+GFgQghK1A2o4EclBSIPy8Ws+S4aTQdS31vwPv8u6YrGabkRUhsRRLBS4WMjuKls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Ax++iYe8Bl8skKAA--.10827S3;
	Mon, 05 Feb 2024 14:09:28 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxHs+Ve8BluusvAA--.49177S4;
	Mon, 05 Feb 2024 14:09:27 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Marco Elver <elver@google.com>
Cc: kasan-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] kasan: Rename test_kasan_module_init to kasan_test_module_init
Date: Mon,  5 Feb 2024 14:09:22 +0800
Message-ID: <20240205060925.15594-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240205060925.15594-1-yangtiezhu@loongson.cn>
References: <20240205060925.15594-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxHs+Ve8BluusvAA--.49177S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrZF45Cry3Jr18uw1DJryxWFX_yoWkGFXEqw
	4UXrZ5G34aqanYkr47uw1fXrs7ua1xCrs8ArWxGFy5Zwn3KwsxZr40qr9rJw4rCr43ArWf
	trWDZr1Yqr12kosvyTuYvTs0mTUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb3kYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JF0_JFyl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
	WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWU
	XVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x07jrPEfUUUUU=

After commit f7e01ab828fd ("kasan: move tests to mm/kasan/"),
the test module file is renamed from lib/test_kasan_module.c
to mm/kasan/kasan_test_module.c, in order to keep consistent,
rename test_kasan_module_init to kasan_test_module_init.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 mm/kasan/kasan_test_module.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/kasan/kasan_test_module.c b/mm/kasan/kasan_test_module.c
index 8b7b3ea2c74e..27ec22767e42 100644
--- a/mm/kasan/kasan_test_module.c
+++ b/mm/kasan/kasan_test_module.c
@@ -62,7 +62,7 @@ static noinline void __init copy_user_test(void)
 	kfree(kmem);
 }
 
-static int __init test_kasan_module_init(void)
+static int __init kasan_test_module_init(void)
 {
 	/*
 	 * Temporarily enable multi-shot mode. Otherwise, KASAN would only
@@ -77,5 +77,5 @@ static int __init test_kasan_module_init(void)
 	return -EAGAIN;
 }
 
-module_init(test_kasan_module_init);
+module_init(kasan_test_module_init);
 MODULE_LICENSE("GPL");
-- 
2.42.0


