Return-Path: <linux-kernel+bounces-126489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D70DD893891
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 09:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EE3D1F21407
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 07:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44C1B664;
	Mon,  1 Apr 2024 07:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pC80AAS8"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3998B8F6E;
	Mon,  1 Apr 2024 07:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711955346; cv=none; b=s46A6WL9jeR60OPp2PjDJfbYq9bBZoxy1r0YqGl9TrgJ+Gmf6tojb4S0eb/dOnAKWeYo0Rnq6dIc8p9FEenTYHm+CQcSvuEY+ImYTXNu73kX4fKKZikuO9ex4A0/00+ac6AC0zVUBJPtX9Hv7WuVZszESBC1ebLD/+sRWobxRzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711955346; c=relaxed/simple;
	bh=Yyu6J6GZaiez1H2m1XGhKtvi+4/m1eSvkPh5cBaNwXo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eFzqiGnJhkAQf9nsfdGQawg5wo88jcXwvY9TF7cdHJvxKX9uLR4SKeesL1pd6h5zSCJDsOP/xbPTzofba8Zs9YLLMtyIZL2qgaGLFACWAWy2VW8pXcHzTblANlITL9GGmW/0Q4Ktt5Scs0DUgbsWOn8fcUBcsrgXUBzSIUCzkB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pC80AAS8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=faKtwJA5t6Zj+D3Q/jEbeWC+9IIE68VhlZebCZwcy9Y=; b=pC80AAS8EZ4vHufsZXQhhNJXMB
	pEZ4zygf0sNfgHbd7JHc5VE5r8vplOj8Vdo3RUxGuZj3OM9UhReJOicLxpX1+QY61C88nz5lxjIfg
	sg7AVzqLO24mjIphRT4DTseRQTfjnua7G0tZICN3mZhOyWNk4Ux23hZQfM7ItidY5DxS9ZcvtELvq
	2F5Er7a13fIYALE36kvV1kcuaYoXBuzsP9iPq5Zivg1qEU8qYHH1BFZgbDk70vqEhQDvSf+dHN8gY
	rpOES3fB8J5cnkDomIiqIAd96lW16AN/qj5MdS8bMsnXjsEx8BMLOUbfsLuAH+DFFzx2MSQxg63+M
	iGiaMIfw==;
Received: from fpd2fa7e2a.ap.nuro.jp ([210.250.126.42] helo=[192.168.1.8])
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrBml-0000000016F-0yKC;
	Mon, 01 Apr 2024 07:08:52 +0000
Message-ID: <d64f06f4-81ae-4ec5-ab3b-d7f7f091e0ac@infradead.org>
Date: Mon, 1 Apr 2024 16:08:31 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] powerpc: Fix PS3 allmodconfig warning
From: Geoff Levand <geoff@infradead.org>
To: Arnd Bergmann <arnd@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nathan Chancellor <nathan@kernel.org>, Paul Mackerras <paulus@ozlabs.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Kevin Hao <haokexin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20240320180333.151043-1-arnd@kernel.org>
 <415f4af0-f44a-49fb-b1fa-76f64ed09ec6@infradead.org>
Content-Language: en-US
In-Reply-To: <415f4af0-f44a-49fb-b1fa-76f64ed09ec6@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The struct ps3_notification_device in the ps3_probe_thread routine
is too large to be on the stack, causing a warning for an
allmodconfig build with clang.

Change the struct ps3_notification_device from a variable on the stack
to a dynamically allocated variable.

Reported-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Geoff Levand <geoff@infradead.org>

diff --git a/arch/powerpc/platforms/ps3/device-init.c b/arch/powerpc/platforms/ps3/device-init.c
index 878bc160246e..b18e1c92e554 100644
--- a/arch/powerpc/platforms/ps3/device-init.c
+++ b/arch/powerpc/platforms/ps3/device-init.c
@@ -770,49 +770,51 @@ static struct task_struct *probe_task;
 
 static int ps3_probe_thread(void *data)
 {
-	struct ps3_notification_device dev;
+	struct {
+		struct ps3_notification_device dev;
+		u8 buf[512];
+	} *local;
+	struct ps3_notify_cmd *notify_cmd;
+	struct ps3_notify_event *notify_event;
 	int res;
 	unsigned int irq;
 	u64 lpar;
-	void *buf;
-	struct ps3_notify_cmd *notify_cmd;
-	struct ps3_notify_event *notify_event;
 
 	pr_debug(" -> %s:%u: kthread started\n", __func__, __LINE__);
 
-	buf = kzalloc(512, GFP_KERNEL);
-	if (!buf)
+	local = kzalloc(sizeof(*local), GFP_KERNEL);
+	if (!local)
 		return -ENOMEM;
 
-	lpar = ps3_mm_phys_to_lpar(__pa(buf));
-	notify_cmd = buf;
-	notify_event = buf;
+	lpar = ps3_mm_phys_to_lpar(__pa(&local->buf));
+	notify_cmd = (struct ps3_notify_cmd *)&local->buf;
+	notify_event = (struct ps3_notify_event *)&local->buf;
 
 	/* dummy system bus device */
-	dev.sbd.bus_id = (u64)data;
-	dev.sbd.dev_id = PS3_NOTIFICATION_DEV_ID;
-	dev.sbd.interrupt_id = PS3_NOTIFICATION_INTERRUPT_ID;
+	local->dev.sbd.bus_id = (u64)data;
+	local->dev.sbd.dev_id = PS3_NOTIFICATION_DEV_ID;
+	local->dev.sbd.interrupt_id = PS3_NOTIFICATION_INTERRUPT_ID;
 
-	res = lv1_open_device(dev.sbd.bus_id, dev.sbd.dev_id, 0);
+	res = lv1_open_device(local->dev.sbd.bus_id, local->dev.sbd.dev_id, 0);
 	if (res) {
 		pr_err("%s:%u: lv1_open_device failed %s\n", __func__,
 		       __LINE__, ps3_result(res));
 		goto fail_free;
 	}
 
-	res = ps3_sb_event_receive_port_setup(&dev.sbd, PS3_BINDING_CPU_ANY,
-					      &irq);
+	res = ps3_sb_event_receive_port_setup(&local->dev.sbd,
+		PS3_BINDING_CPU_ANY, &irq);
 	if (res) {
 		pr_err("%s:%u: ps3_sb_event_receive_port_setup failed %d\n",
 		       __func__, __LINE__, res);
 	       goto fail_close_device;
 	}
 
-	spin_lock_init(&dev.lock);
-	rcuwait_init(&dev.wait);
+	spin_lock_init(&local->dev.lock);
+	rcuwait_init(&local->dev.wait);
 
 	res = request_irq(irq, ps3_notification_interrupt, 0,
-			  "ps3_notification", &dev);
+			  "ps3_notification", &local->dev);
 	if (res) {
 		pr_err("%s:%u: request_irq failed %d\n", __func__, __LINE__,
 		       res);
@@ -823,7 +825,7 @@ static int ps3_probe_thread(void *data)
 	notify_cmd->operation_code = 0; /* must be zero */
 	notify_cmd->event_mask = 1UL << notify_region_probe;
 
-	res = ps3_notification_read_write(&dev, lpar, 1);
+	res = ps3_notification_read_write(&local->dev, lpar, 1);
 	if (res)
 		goto fail_free_irq;
 
@@ -834,36 +836,37 @@ static int ps3_probe_thread(void *data)
 
 		memset(notify_event, 0, sizeof(*notify_event));
 
-		res = ps3_notification_read_write(&dev, lpar, 0);
+		res = ps3_notification_read_write(&local->dev, lpar, 0);
 		if (res)
 			break;
 
 		pr_debug("%s:%u: notify event type 0x%llx bus id %llu dev id %llu"
 			 " type %llu port %llu\n", __func__, __LINE__,
-			 notify_event->event_type, notify_event->bus_id,
-			 notify_event->dev_id, notify_event->dev_type,
-			 notify_event->dev_port);
+			notify_event->event_type, notify_event->bus_id,
+			notify_event->dev_id, notify_event->dev_type,
+			notify_event->dev_port);
 
 		if (notify_event->event_type != notify_region_probe ||
-		    notify_event->bus_id != dev.sbd.bus_id) {
+			notify_event->bus_id != local->dev.sbd.bus_id) {
 			pr_warn("%s:%u: bad notify_event: event %llu, dev_id %llu, dev_type %llu\n",
 				__func__, __LINE__, notify_event->event_type,
 				notify_event->dev_id, notify_event->dev_type);
 			continue;
 		}
 
-		ps3_find_and_add_device(dev.sbd.bus_id, notify_event->dev_id);
+		ps3_find_and_add_device(local->dev.sbd.bus_id,
+			notify_event->dev_id);
 
 	} while (!kthread_should_stop());
 
 fail_free_irq:
-	free_irq(irq, &dev);
+	free_irq(irq, &local->dev);
 fail_sb_event_receive_port_destroy:
-	ps3_sb_event_receive_port_destroy(&dev.sbd, irq);
+	ps3_sb_event_receive_port_destroy(&local->dev.sbd, irq);
 fail_close_device:
-	lv1_close_device(dev.sbd.bus_id, dev.sbd.dev_id);
+	lv1_close_device(local->dev.sbd.bus_id, local->dev.sbd.dev_id);
 fail_free:
-	kfree(buf);
+	kfree(local);
 
 	probe_task = NULL;
 


