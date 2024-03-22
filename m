Return-Path: <linux-kernel+bounces-111144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCE3886851
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0A791C208BC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B003FBAC;
	Fri, 22 Mar 2024 08:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JHtyBQH6"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0B83FB87;
	Fri, 22 Mar 2024 08:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711096518; cv=none; b=eRyvRm3Lycb7ApnXtvnIBjdesZVe7Opnefl2cWkj4NUEEdU7QIVpEgOM3Ur5C44um9ErReKVMzRQf9dVd4Jw/CtGMKrsi3K6kNJ0likACK3j3KuS8pSkreyT23GdLihKoH+kJ6TFoQ7P1pq5d6bXAfdrobhbBSXeXDFn7P/f0hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711096518; c=relaxed/simple;
	bh=ubt8vwuXHMoPvm2FKiDUEHRj3q7PZZktUm1LKe+DoxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lvc1Lv4sF1vhyT5ijFDp1g1LX+3ydRGLLNpIW/oC/DgERrxxWSgim50IQFi44oDCqCSUEC5JeHJbGA+ZipO3s7Adr/U36F5xH1NzT2VDSGb/D+WmH3H+JQ9bhTA1RILUqcK0YBWHbXnmKAvcifrPd3es64PGIMXTHJYKe/gJU4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JHtyBQH6; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=B+eEe2rJKYVCOSpsUyFR0aFEgGcdrU57l8z/qph+tmM=; b=JHtyBQH6EX7GceqkO4taJJgxTp
	MHSM6Uqnw3YFlkvvhAiy3qbAR0vYz3MGRdxZmGg5/mdAUNTul1mWj09WvLulV1q1v69YEuYQIuXhn
	P+4q733Age1NYD6hfFWEFc0t+KuF9HA90D8+TcIfO/d9koXu4navByN+ZmWwMcqPO/i01Opbj0EBy
	WTuTwTFJ/dZm7bPQd8J/FD43zJbO6Y047A+sffZnE54IZNoZV5n9cCRmuC+yxOzAZwfnlJQq4pCoy
	ym665tUf6yqhhjtVMcCNHOKjEijyCNM6tDQWevVoSRf1chQmYyScxbzC4JT3i+oeKd+PzlolBJwMN
	7ds5xwDA==;
Received: from fpd2fa7e2a.ap.nuro.jp ([210.250.126.42] helo=[192.168.1.8])
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnaMZ-0000000EhCD-3xGY;
	Fri, 22 Mar 2024 08:34:56 +0000
Message-ID: <87f6365f-a40e-4606-baff-170cb8fc48f3@infradead.org>
Date: Fri, 22 Mar 2024 17:34:45 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc: ps3: mark ps3_notification_device static for
 stack usage
To: Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Nathan Chancellor <nathan@kernel.org>, Paul Mackerras <paulus@ozlabs.org>,
 Arnd Bergmann <arnd@arndb.de>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Kevin Hao <haokexin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20240320180333.151043-1-arnd@kernel.org>
 <CAMuHMdW41e+DSBKBgugTkjoLy6bXfji-KWmB_d9EstEv01eC6w@mail.gmail.com>
Content-Language: en-US
From: Geoff Levand <geoff@infradead.org>
In-Reply-To: <CAMuHMdW41e+DSBKBgugTkjoLy6bXfji-KWmB_d9EstEv01eC6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/21/24 17:32, Geert Uytterhoeven wrote:
> --- a/arch/powerpc/platforms/ps3/device-init.c
>> +++ b/arch/powerpc/platforms/ps3/device-init.c
>> @@ -770,7 +770,7 @@ static struct task_struct *probe_task;
>>
>>  static int ps3_probe_thread(void *data)
>>  {
>> -       struct ps3_notification_device dev;
>> +       static struct ps3_notification_device dev;
>>         int res;
>>         unsigned int irq;
>>         u64 lpar;
> 
> Making it static increases kernel size for everyone.  So I'd rather
> allocate it dynamically. The thread already allocates a buffer, which
> can be replaced at no cost by allocating a structure containing both
> the ps3_notification_device and the buffer.

Here's what I came up with.  It builds for me without warnings.
I haven't tested it yet.  A review would be appreciated.

diff --git a/arch/powerpc/platforms/ps3/device-init.c b/arch/powerpc/platforms/ps3/device-init.c
index 878bc160246e..9bb44a6ccdaf 100644
--- a/arch/powerpc/platforms/ps3/device-init.c
+++ b/arch/powerpc/platforms/ps3/device-init.c
@@ -770,37 +770,48 @@ static struct task_struct *probe_task;
 
 static int ps3_probe_thread(void *data)
 {
-	struct ps3_notification_device dev;
+	struct ps3_probe_thread_local {
+		struct ps3_notification_device dev;
+		union {
+			char buf[512];
+			struct ps3_notify_cmd notify_cmd;
+			struct ps3_notify_event notify_event;
+		};
+	};
+	struct ps3_probe_thread_local *local;
+	struct ps3_notification_device *dev;
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
+	local = kzalloc(sizeof(local), GFP_KERNEL);
+
+	if (!local)
 		return -ENOMEM;
 
-	lpar = ps3_mm_phys_to_lpar(__pa(buf));
-	notify_cmd = buf;
-	notify_event = buf;
+	dev = &local->dev;
+	notify_cmd = &local->notify_cmd;
+	notify_event = &local->notify_event;
+
+	lpar = ps3_mm_phys_to_lpar(__pa(&local->notify_cmd));
 
 	/* dummy system bus device */
-	dev.sbd.bus_id = (u64)data;
-	dev.sbd.dev_id = PS3_NOTIFICATION_DEV_ID;
-	dev.sbd.interrupt_id = PS3_NOTIFICATION_INTERRUPT_ID;
+	dev->sbd.bus_id = (u64)data;
+	dev->sbd.dev_id = PS3_NOTIFICATION_DEV_ID;
+	dev->sbd.interrupt_id = PS3_NOTIFICATION_INTERRUPT_ID;
 
-	res = lv1_open_device(dev.sbd.bus_id, dev.sbd.dev_id, 0);
+	res = lv1_open_device(dev->sbd.bus_id, dev->sbd.dev_id, 0);
 	if (res) {
 		pr_err("%s:%u: lv1_open_device failed %s\n", __func__,
 		       __LINE__, ps3_result(res));
 		goto fail_free;
 	}
 
-	res = ps3_sb_event_receive_port_setup(&dev.sbd, PS3_BINDING_CPU_ANY,
+	res = ps3_sb_event_receive_port_setup(&dev->sbd, PS3_BINDING_CPU_ANY,
 					      &irq);
 	if (res) {
 		pr_err("%s:%u: ps3_sb_event_receive_port_setup failed %d\n",
@@ -808,11 +819,11 @@ static int ps3_probe_thread(void *data)
 	       goto fail_close_device;
 	}
 
-	spin_lock_init(&dev.lock);
-	rcuwait_init(&dev.wait);
+	spin_lock_init(&dev->lock);
+	rcuwait_init(&dev->wait);
 
 	res = request_irq(irq, ps3_notification_interrupt, 0,
-			  "ps3_notification", &dev);
+			  "ps3_notification", &local->dev);
 	if (res) {
 		pr_err("%s:%u: request_irq failed %d\n", __func__, __LINE__,
 		       res);
@@ -823,7 +834,7 @@ static int ps3_probe_thread(void *data)
 	notify_cmd->operation_code = 0; /* must be zero */
 	notify_cmd->event_mask = 1UL << notify_region_probe;
 
-	res = ps3_notification_read_write(&dev, lpar, 1);
+	res = ps3_notification_read_write(&local->dev, lpar, 1);
 	if (res)
 		goto fail_free_irq;
 
@@ -834,36 +845,36 @@ static int ps3_probe_thread(void *data)
 
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
+			notify_event->bus_id != dev->sbd.bus_id) {
 			pr_warn("%s:%u: bad notify_event: event %llu, dev_id %llu, dev_type %llu\n",
 				__func__, __LINE__, notify_event->event_type,
 				notify_event->dev_id, notify_event->dev_type);
 			continue;
 		}
 
-		ps3_find_and_add_device(dev.sbd.bus_id, notify_event->dev_id);
+		ps3_find_and_add_device(dev->sbd.bus_id, notify_event->dev_id);
 
 	} while (!kthread_should_stop());
 
 fail_free_irq:
-	free_irq(irq, &dev);
+	free_irq(irq, &local->dev);
 fail_sb_event_receive_port_destroy:
-	ps3_sb_event_receive_port_destroy(&dev.sbd, irq);
+	ps3_sb_event_receive_port_destroy(&dev->sbd, irq);
 fail_close_device:
-	lv1_close_device(dev.sbd.bus_id, dev.sbd.dev_id);
+	lv1_close_device(dev->sbd.bus_id, dev->sbd.dev_id);
 fail_free:
-	kfree(buf);
+	kfree(local);
 
 	probe_task = NULL;
 



