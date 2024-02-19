Return-Path: <linux-kernel+bounces-71603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D62285A7A3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D325B25191
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51421405F2;
	Mon, 19 Feb 2024 15:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="29uN5GrD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MR81Dmyl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7723CF67;
	Mon, 19 Feb 2024 15:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708357210; cv=none; b=OT/TbxOwTS7tzk1joALoaPXWWAwOHhkY5mKS1zk0AwDScW0hXh607+LvGJPIR2iXie12q88d3E3vH1CGNN6zu4Ih/4zGO9CYH4NUCPXPazB6tEw3BvykTCX2Ik9cjBenCCQa6B6JSSUJ3wWKixXBwqdihdC8FGXoXo2m/JJ1lqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708357210; c=relaxed/simple;
	bh=2xglRp24K0ngAsMpicpTrhgbwtum8XdpL/77bvNcnqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G5htdoh0DewkaHQ5hboba1pOUsQFzufU7vIbqzeaXwpkc+2taASsnSheJgEDugKEJaIwvjk4nUtxEvpayFakFafNxBsnLAITMWf6eRBkAbVt4BHE880NwZhBO20VP/P0vSjU4aMlbma7BNv/ZuQeYOWb0VoqFd2Ng17qyfkUWSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=29uN5GrD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MR81Dmyl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708357206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jU+XjkvuIDGH4O48sip7TH7TW67eQu5qXALaeJfPZY8=;
	b=29uN5GrDPNQqpgJ6urrtY7kzwPWAi92vGvXafx330dxbY0YR3Yn14LU65fylLvyq8Tz51f
	C5gVCyufz7JDYc01w+Wb7PRLZGN8XY8h6gplAk1fO//tmnF1s/Gi4GzEvPhT3CXgGssbsz
	AKkbKUO6bzENLBURGD/BAkpEsEz0ietBYwjEYjHA+5DzRuw8XWof8eRYGrBo7HZU21m/Es
	vFVzVkv0qHGVyd7aoTZr8kUjgFEMTbW2TyWgJ0XdZV5GKJASekyu/dhpvkbEOpi8FZhsWr
	1Trip6PB6kQ3yiuFItNNByUFyRamvRavMhPvUe3MPqSjjBD/CklW1kgpxbeeOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708357206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jU+XjkvuIDGH4O48sip7TH7TW67eQu5qXALaeJfPZY8=;
	b=MR81DmylMnhvEy0enrO6LQ6uCQ7K6zDF+DdNGdyuhMeJW9ljJHszQc91pKg7l/U5PgTHeJ
	UXOOpoe9Twp1YHDQ==
To: linux-kernel@vger.kernel.org
Cc: Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	linux-s390@vger.kernel.org
Subject: [PATCH 07/10] s390/vdso: Use generic union vdso_data_store
Date: Mon, 19 Feb 2024 16:39:36 +0100
Message-Id: <20240219153939.75719-8-anna-maria@linutronix.de>
In-Reply-To: <20240219153939.75719-1-anna-maria@linutronix.de>
References: <20240219153939.75719-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is already a generic union definition for vdso_data_store in vdso
datapage header.

Use this definition to prevent code duplication.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
---
 arch/s390/kernel/vdso.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index bbaefd84f15e..a45b3a4c91db 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -25,10 +25,7 @@ extern char vdso32_start[], vdso32_end[];
 
 static struct vm_special_mapping vvar_mapping;
 
-static union {
-	struct vdso_data	data[CS_BASES];
-	u8			page[PAGE_SIZE];
-} vdso_data_store __page_aligned_data;
+static union vdso_data_store vdso_data_store __page_aligned_data;
 
 struct vdso_data *vdso_data = vdso_data_store.data;
 
-- 
2.39.2


