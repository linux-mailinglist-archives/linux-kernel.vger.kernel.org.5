Return-Path: <linux-kernel+bounces-73440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 333E185C29A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88759B23C1C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B0777655;
	Tue, 20 Feb 2024 17:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="LCJcHreW"
Received: from iguana.tulip.relay.mailchannels.net (iguana.tulip.relay.mailchannels.net [23.83.218.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63441768FF;
	Tue, 20 Feb 2024 17:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.253
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708449956; cv=pass; b=XWB0cfbxNeeOqCjdFhwAN/t2Vg6YgtlTWsNmacuFjnS9348CqfLblCY40s1i7aiToOI145tf3kLJdbFZITofHNB8VGSehkC9ZAIJMS3gzyhHYWxyui4vdvLSucNbnvWATQBdseClMujFSOfRxa+Ik+R7ATPih8MX2gq/yORL/vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708449956; c=relaxed/simple;
	bh=dwqFzFtF67bmHYRFe9jtxHDVVpBai0q7JDsGwgGIvXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLl+veVivrBYQWt7pYDX26fr++Z+RSMeO7OI6ttVTXvWc703jJ2y5Yh1/prmj+V4ICEr636OSGYbTi9nrK9/+TnzJHEzBf5N3r+a8TRrVtqKp7MoNGbR1+NjgnbTsBMH06VQxViuYeijISSzvgZxs3ptJuVjgoj3NliFe/rjBYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=LCJcHreW; arc=pass smtp.client-ip=23.83.218.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id EE593101C9F;
	Tue, 20 Feb 2024 17:25:46 +0000 (UTC)
Received: from pdx1-sub0-mail-a278.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 16D1F1017D8;
	Tue, 20 Feb 2024 17:25:46 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1708449946; a=rsa-sha256;
	cv=none;
	b=uFe0KtnQTNcohrldk3TsLrZze9jjJapsfc7cERSpDdANNiIXo7KhsZXWLBLX9iabTuK98i
	7THSEXCa1OzhjtZ44i+nuDPeLKibyxmNpjY/0ZLTT6jqjouQHumaLHLDdAVzZyeyNU5DHj
	rcJUaRTC/u8s1i2T8eGBpHRgW7YSZVFqwVHgUsKjY+0XEvZzUd8fOsvvrFTtp+UyJZHpTe
	SpaRAW05PkrMidQtaBQ6++L+6mJgoAvlkw3/Rd6PqC5Hq0eEqu3Vxg2YY1YzuonCsZ9hkZ
	w6yKQ5ZL7Cxi1081S40duwxoXRG0Kn8YxOcofaoVS+BHK9HP07FrMPE2d4EcGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1708449946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=QzN7EVnZPsjMJ5YLCF9u7H6lIgeQ/8GdiwxTEbneVZE=;
	b=4iPejISHCraxmp9j7OIq12cswL/0fAVnjKKNrTYMnH+z/SKDCTSKE1ezYZQV0czZpULyhw
	P0p0uVfw2GbSqA/WBAxiXtqXYdPLO2qw/FlZUKZJaU9XcqdCzBN8mZ63B1p1ChOViQc5pA
	64A87EVijTYfR+/sl41y2ibevWLoQxfjY8bYPAPLgEnfj+iQl3W/l4uvKmciKMYaDK7+u5
	EDxt499O2fE2L5vHVibDMBuYR5r+yQwj3LhKbnG0Vkq5gM3mOpoXdFQd1Z+tldeOHIUSD9
	vuCFNU8EcwcGi4daOTaCw2NmHbv0yu7w2CbgqLENnXUF7wRJFClW8u/BG+OXKQ==
ARC-Authentication-Results: i=1;
	rspamd-55b4bfd7cb-5kjb7;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Bored-Bored: 4c241a466fe9111b_1708449946834_2238152251
X-MC-Loop-Signature: 1708449946834:2999301632
X-MC-Ingress-Time: 1708449946834
Received: from pdx1-sub0-mail-a278.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.108.238.155 (trex/6.9.2);
	Tue, 20 Feb 2024 17:25:46 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a278.dreamhost.com (Postfix) with ESMTPSA id 4TfRBc0N57z3M;
	Tue, 20 Feb 2024 09:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1708449945;
	bh=QzN7EVnZPsjMJ5YLCF9u7H6lIgeQ/8GdiwxTEbneVZE=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=LCJcHreWz34d/c9pRfqoxFZWgNst+zT0EUA1YG9/FERYgaaC3azBl3iejiECE66pY
	 j88hAXfKyMZRiOEg49791CkFdnnixXaHKb4swQPcgERl5SZwuFidDpof3ROOAFxSo2
	 93ww1byZYHE5WQz2yjnG2LtRjHxGGdy3fcTwxm32DIxs9rF2HKJF0DMHQ1kx4N0mDL
	 rSEhNa1oAdZJUs5nwacM84pa+MlVxaD/XTIl5LI+Hhw+Jvzn1vVrpifdICm3P5p8L9
	 LcioJjNeNmQgfEcQWBE7yM+5+o7OSt3znCIU9hgg1aRuQzI0r1OzSrRRtV3a2UM4nH
	 T3AuYAFzxWpng==
Date: Tue, 20 Feb 2024 09:25:40 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, mpatocka@redhat.com, 
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev, msnitzer@redhat.com, 
	ignat@cloudflare.com, damien.lemoal@wdc.com, bob.liu@oracle.com, houtao1@huawei.com, 
	peterz@infradead.org, mingo@kernel.org, netdev@vger.kernel.org, allen.lkml@gmail.com, 
	kernel-team@meta.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, mchehab@kernel.org
Subject: Re: [PATCH 5/8] usb: core: hcd: Convert from tasklet to BH workqueue
Message-ID: <bckroyio6l2nt54refuord4pm6mqylt3adx6z2bg6iczxkbnyk@bb5447rqahj5>
Mail-Followup-To: Tejun Heo <tj@kernel.org>, torvalds@linux-foundation.org, 
	mpatocka@redhat.com, linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev, 
	msnitzer@redhat.com, ignat@cloudflare.com, damien.lemoal@wdc.com, bob.liu@oracle.com, 
	houtao1@huawei.com, peterz@infradead.org, mingo@kernel.org, netdev@vger.kernel.org, 
	allen.lkml@gmail.com, kernel-team@meta.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, 
	linux-usb@vger.kernel.org, mchehab@kernel.org
References: <20240130091300.2968534-1-tj@kernel.org>
 <20240130091300.2968534-6-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240130091300.2968534-6-tj@kernel.org>
User-Agent: NeoMutt/20231221

On Mon, 29 Jan 2024, Tejun Heo wrote:

>The only generic interface to execute asynchronously in the BH context is
>tasklet; however, it's marked deprecated and has some design flaws. To
>replace tasklets, BH workqueue support was recently added. A BH workqueue
>behaves similarly to regular workqueues except that the queued work items
>are executed in the BH context.
>
>This patch converts usb hcd from tasklet to BH workqueue.

In the past this tasklet removal was held up by Mauro's device not properly
streaming - hopefully this no longer the case. Cc'ing.

https://lore.kernel.org/all/20180216170450.yl5owfphuvltstnt@breakpoint.cc/

>
>Signed-off-by: Tejun Heo <tj@kernel.org>
>Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>Cc: Alan Stern <stern@rowland.harvard.edu>
>Cc: linux-usb@vger.kernel.org

Acked-by: Davidlohr Bueso <dave@stgolabs.net>

>---
> drivers/usb/core/hcd.c  | 23 ++++++++++++-----------
> include/linux/usb/hcd.h |  2 +-
> 2 files changed, 13 insertions(+), 12 deletions(-)
>
>diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
>index 12b6dfeaf658..edf74458474a 100644
>--- a/drivers/usb/core/hcd.c
>+++ b/drivers/usb/core/hcd.c
>@@ -1664,9 +1664,10 @@ static void __usb_hcd_giveback_urb(struct urb *urb)
>	usb_put_urb(urb);
> }
>
>-static void usb_giveback_urb_bh(struct tasklet_struct *t)
>+static void usb_giveback_urb_bh(struct work_struct *work)
> {
>-	struct giveback_urb_bh *bh = from_tasklet(bh, t, bh);
>+	struct giveback_urb_bh *bh =
>+		container_of(work, struct giveback_urb_bh, bh);
>	struct list_head local_list;
>
>	spin_lock_irq(&bh->lock);
>@@ -1691,9 +1692,9 @@ static void usb_giveback_urb_bh(struct tasklet_struct *t)
>	spin_lock_irq(&bh->lock);
>	if (!list_empty(&bh->head)) {
>		if (bh->high_prio)
>-			tasklet_hi_schedule(&bh->bh);
>+			queue_work(system_bh_highpri_wq, &bh->bh);
>		else
>-			tasklet_schedule(&bh->bh);
>+			queue_work(system_bh_wq, &bh->bh);
>	}
>	bh->running = false;
>	spin_unlock_irq(&bh->lock);
>@@ -1706,7 +1707,7 @@ static void usb_giveback_urb_bh(struct tasklet_struct *t)
>  * @status: completion status code for the URB.
>  *
>  * Context: atomic. The completion callback is invoked in caller's context.
>- * For HCDs with HCD_BH flag set, the completion callback is invoked in tasklet
>+ * For HCDs with HCD_BH flag set, the completion callback is invoked in BH
>  * context (except for URBs submitted to the root hub which always complete in
>  * caller's context).
>  *
>@@ -1725,7 +1726,7 @@ void usb_hcd_giveback_urb(struct usb_hcd *hcd, struct urb *urb, int status)
>	struct giveback_urb_bh *bh;
>	bool running;
>
>-	/* pass status to tasklet via unlinked */
>+	/* pass status to BH via unlinked */
>	if (likely(!urb->unlinked))
>		urb->unlinked = status;
>
>@@ -1747,9 +1748,9 @@ void usb_hcd_giveback_urb(struct usb_hcd *hcd, struct urb *urb, int status)
>	if (running)
>		;
>	else if (bh->high_prio)
>-		tasklet_hi_schedule(&bh->bh);
>+		queue_work(system_bh_highpri_wq, &bh->bh);
>	else
>-		tasklet_schedule(&bh->bh);
>+		queue_work(system_bh_wq, &bh->bh);
> }
> EXPORT_SYMBOL_GPL(usb_hcd_giveback_urb);
>
>@@ -2540,7 +2541,7 @@ static void init_giveback_urb_bh(struct giveback_urb_bh *bh)
>
>	spin_lock_init(&bh->lock);
>	INIT_LIST_HEAD(&bh->head);
>-	tasklet_setup(&bh->bh, usb_giveback_urb_bh);
>+	INIT_WORK(&bh->bh, usb_giveback_urb_bh);
> }
>
> struct usb_hcd *__usb_create_hcd(const struct hc_driver *driver,
>@@ -2926,7 +2927,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
>			&& device_can_wakeup(&hcd->self.root_hub->dev))
>		dev_dbg(hcd->self.controller, "supports USB remote wakeup\n");
>
>-	/* initialize tasklets */
>+	/* initialize BHs */
>	init_giveback_urb_bh(&hcd->high_prio_bh);
>	hcd->high_prio_bh.high_prio = true;
>	init_giveback_urb_bh(&hcd->low_prio_bh);
>@@ -3036,7 +3037,7 @@ void usb_remove_hcd(struct usb_hcd *hcd)
>	mutex_unlock(&usb_bus_idr_lock);
>
>	/*
>-	 * tasklet_kill() isn't needed here because:
>+	 * flush_work() isn't needed here because:
>	 * - driver's disconnect() called from usb_disconnect() should
>	 *   make sure its URBs are completed during the disconnect()
>	 *   callback
>diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
>index 00724b4f6e12..f698aac71de3 100644
>--- a/include/linux/usb/hcd.h
>+++ b/include/linux/usb/hcd.h
>@@ -55,7 +55,7 @@ struct giveback_urb_bh {
>	bool high_prio;
>	spinlock_t lock;
>	struct list_head  head;
>-	struct tasklet_struct bh;
>+	struct work_struct bh;
>	struct usb_host_endpoint *completing_ep;
> };
>
>--
>2.43.0
>

