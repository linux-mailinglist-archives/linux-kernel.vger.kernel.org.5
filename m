Return-Path: <linux-kernel+bounces-134369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A50789B0BE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 14:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4B83B20C5C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 12:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A517F22F0A;
	Sun,  7 Apr 2024 12:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hE6MSKNL"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D301773A;
	Sun,  7 Apr 2024 12:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712492751; cv=none; b=GCwombKwvBq66MxbXYcnowwIFXVSnJgrdYBK4I1Y/+YIkJK3bcvac7OvOSmRU0KoqCt6qOt0duLsya+ufMuJoAPc/ylPZPlEnRM/+bencICmBWTy/p43znuuYrttS71skPkZrj2YNtnthKEkR4dtV3gFGEyJLjzwlMwRx8yuIEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712492751; c=relaxed/simple;
	bh=f15ijHKHL5tTNVMipWgkIcV3zDfQTQtbh4GNUzVRy5U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h/uIDo7QOLahuHxDDNI4hOUqjdkMTQwxTE/PhjQbrC3NJ+/WCwQrS0Ey+cRdum3Z8OvqEb2TQAvVvvX/nmmHb/ebirlgoe5ivGKkNuMcm9maP4M8fbvsU6Qlx1t9qq+knubA1CLg02eIDHYWM3VQRDItTsJA/0O7NiRJ+RUmnmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hE6MSKNL; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a46a7208eedso519214066b.0;
        Sun, 07 Apr 2024 05:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712492748; x=1713097548; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LLfoLTNekMPUU0C0Mf4nAFwbPI/B7C9TuC2nTj1WHg4=;
        b=hE6MSKNLMppNl0eOgIS+LNZW7fg0eEDBugy2Ltz4TLgNGWhWfvWpPnOeOAShQab2AS
         u1johE2AfyYL04aKWR2fI94Y5g4gR/SlnA8g6jM1YO07IAp2OgsrRNKNkwbj5AODM2M3
         TgtmHkM9KzB00E72vUnNAHk837oStXRifziplTu8OLdC+EihO3F8tnj0JgWHlYeOmR4n
         dTs/viFTfu3zX1x0MVusENGvacDL44J8XvPvODoXGtqVnJ2k02dbRCRuX/zdHh42V4lW
         fFtVFnqGgYrI+fCnB+p+8z4AG1TIOoeadoMD9ZOq7i2LdFRq6c1IK7iOSgJIwDodkTCF
         B5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712492748; x=1713097548;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LLfoLTNekMPUU0C0Mf4nAFwbPI/B7C9TuC2nTj1WHg4=;
        b=nM4BJuLZBk9atz8YEDN6z2LmRmy4t1qv5jo4KR9ACutFIfePzPFjw2XyUgGFtGkvFE
         ChWNeHy9GiEY+/R6jY0U2YHl6tgve2+Ds7Yw8qpHYnVkv0sOl7O7J3VWVv7SX4Qprr/9
         cU5Ude8GRBKKxvDn/jmqc9h7bpmXteh5uaYB486CXOFRzVulhNA6XdRxNv8GQ+S8zxAk
         DdAB4UcpFiKubO4l+0HTrdv6RJG09R9qtjTtsLN9op5oCPSoZrJqueIuRYSEmHYjU5YE
         JOkZQUV9YyFAcw/xtPEjkBBepe8IVyTxtmYclrwCRlFwgnQv8Y62pqgyhbFdOM4zpE7F
         b09A==
X-Forwarded-Encrypted: i=1; AJvYcCWBYsVuy0BD39vACBibFYhxeR84QYP12fxWaCPgxCAjySbLBMiRbiasvif21vWpzxEa9wcoRAIIoIRMy2nQ9P8R/Io9Jex4KXqeyvkdTzNKqNDcAGdPWfV9u3x8Kuhu/nHZb41BtMn8
X-Gm-Message-State: AOJu0Yy7RWSBaq1fcgrozB3+sRYpS1Ub50O9IFAhM8QPztHKuT9xJQmH
	Aml4PA+bn077QZb9nsccAN1N7ulaHBv1zr+9jBdnNpz8aNQG2AEV
X-Google-Smtp-Source: AGHT+IFDhmySNpY/v5TYJy78dIkbM10HsrYvBaKocJEoFGa3ZXCFwvTA8xvta4KZIzPmTgRtWt/V+Q==
X-Received: by 2002:a17:906:f745:b0:a51:c553:81c1 with SMTP id jp5-20020a170906f74500b00a51c55381c1mr1669558ejb.26.1712492747695;
        Sun, 07 Apr 2024 05:25:47 -0700 (PDT)
Received: from foxbook (acgm220.neoplus.adsl.tpnet.pl. [83.9.240.220])
        by smtp.gmail.com with ESMTPSA id lv27-20020a170906bc9b00b00a51a67f08d0sm2968824ejb.77.2024.04.07.05.25.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 07 Apr 2024 05:25:47 -0700 (PDT)
Date: Sun, 7 Apr 2024 14:25:42 +0200
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Mathias Nyman <mathias.nyman@intel.com>, LKML
 <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org
Subject: Re: xhci_hcd 0000:00:14.0: ERROR Transfer event TRB DMA ptr not
 part of current TD ep_index 1 comp_code 1
Message-ID: <20240407142542.036fb02f@foxbook>
In-Reply-To: <c57f2116-8c42-44fb-9c32-6115ad88f914@molgen.mpg.de>
References: <58bca6f2-797a-4e20-a476-2294309afdd5@molgen.mpg.de>
	<20240405113247.743e34b2@foxbook>
	<7090d3af-18ce-40e1-8ac2-bf18152e5c4a@molgen.mpg.de>
	<20240406183659.3daf4fa0@foxbook>
	<c57f2116-8c42-44fb-9c32-6115ad88f914@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/wWorqfnujcpmJC.mAxy2oYy"

--MP_/wWorqfnujcpmJC.mAxy2oYy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This (and the absence of any earlier errors on the endpoint) looks
like the hardware may be confirming a "successful" transfer twice or
the driver may be processing one such confirmation twice.

[   94.088594] usb 1-2: USB disconnect, device number 8
[   94.089370] xhci_hcd 0000:00:14.0: ERROR Transfer event TRB DMA ptr not part of current TD ep_index 1 comp_code 1
[   94.089403] xhci_hcd 0000:00:14.0: Looking for event-dma 00000001250310f0 trb-start 0000000125031100 trb-end 0000000125031100 seg-start 0000000125031000 seg-end 0000000125031ff0
[   94.089427] xhci_hcd 0000:00:14.0: last xhci_td_cleanup: first_dma 1250310f0 last_dma 1250310f0 status -115 from finish_td

(I say "successful" but it really isn't - the device is no longer
listening. But there is no delivery confirmation on isochronous OUT
endpoints so the xHC doesn't suspect anything.)

Could you try again with this updated debug patch to get more info?

Regards,
Michal

--MP_/wWorqfnujcpmJC.mAxy2oYy
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=xhci-noise-v2.patch

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 52278afea94b..21886ef303db 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -843,11 +843,16 @@ static void xhci_unmap_td_bounce_buffer(struct xhci_hcd *xhci,
 	seg->bounce_offs = 0;
 }
 
-static int xhci_td_cleanup(struct xhci_hcd *xhci, struct xhci_td *td,
-			   struct xhci_ring *ep_ring, int status)
+static int __xhci_td_cleanup(struct xhci_hcd *xhci, struct xhci_td *td,
+			   struct xhci_ring *ep_ring, int status, const char *from)
 {
 	struct urb *urb = NULL;
 
+	ep_ring->cleanup_first_dma = xhci_trb_virt_to_dma(ep_ring->deq_seg, td->first_trb);
+	ep_ring->cleanup_last_dma = xhci_trb_virt_to_dma(ep_ring->deq_seg, td->last_trb);
+	ep_ring->cleanup_status = status;
+	ep_ring->cleanup_from = from;
+
 	/* Clean up the endpoint's TD list */
 	urb = td->urb;
 
@@ -891,6 +896,8 @@ static int xhci_td_cleanup(struct xhci_hcd *xhci, struct xhci_td *td,
 	return 0;
 }
 
+#define xhci_td_cleanup(xhci, td, ep_ring, status) __xhci_td_cleanup(xhci, td, ep_ring, status, __func__)
+
 
 /* Complete the cancelled URBs we unlinked from td_list. */
 static void xhci_giveback_invalidated_tds(struct xhci_virt_ep *ep)
@@ -2179,6 +2186,15 @@ static int finish_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 		     u32 trb_comp_code)
 {
 	struct xhci_ep_ctx *ep_ctx;
+	struct urb_priv *urb_priv;
+	struct usb_iso_packet_descriptor *frame;
+
+	urb_priv = td->urb->hcpriv;
+	frame = &td->urb->iso_frame_desc[urb_priv->num_tds_done];
+
+	if (ep_ring->interesting)
+		xhci_info(xhci, "finish_td td_status %d comp_code %d frame_status %d frame_actual_length %d\n",
+				td->status, trb_comp_code, frame->status, frame->actual_length);
 
 	ep_ctx = xhci_get_ep_ctx(xhci, ep->vdev->out_ctx, ep->ep_index);
 
@@ -2391,12 +2407,17 @@ static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 	short_framestatus = td->urb->transfer_flags & URB_SHORT_NOT_OK ?
 		-EREMOTEIO : 0;
 
+	if (ep_ring->interesting)
+		xhci_info(xhci, "process_isoc_td event %px requested %u ep_trb_len %u remaining %u\n", event, requested, ep_trb_len, remaining);
+
 	/* handle completion code */
 	switch (trb_comp_code) {
 	case COMP_SUCCESS:
 		/* Don't overwrite status if TD had an error, see xHCI 4.9.1 */
-		if (td->error_mid_td)
+		if (td->error_mid_td) {
+			xhci_info(xhci, "Got SUCCESS after mid TD error\n");
 			break;
+		}
 		if (remaining) {
 			frame->status = short_framestatus;
 			if (xhci->quirks & XHCI_TRUST_TX_LENGTH)
@@ -2462,7 +2483,7 @@ static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 finish_td:
 	/* Don't give back TD yet if we encountered an error mid TD */
 	if (td->error_mid_td && ep_trb != td->last_trb) {
-		xhci_dbg(xhci, "Error mid isoc TD, wait for final completion event\n");
+		xhci_info(xhci, "Error mid isoc TD, wait for final completion event\n");
 		td->urb_length_set = true;
 		return 0;
 	}
@@ -2597,6 +2618,11 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 	trb_comp_code = GET_COMP_CODE(le32_to_cpu(event->transfer_len));
 	ep_trb_dma = le64_to_cpu(event->buffer);
 
+	bool interesting = trb_comp_code != COMP_SUCCESS && trb_comp_code != COMP_SHORT_PACKET;
+	if (interesting)
+		xhci_info(xhci, "handle_tx_event event %px ep_trb_dma %llx comp_code %d len %u slot %u ep %d\n",
+				event, ep_trb_dma, trb_comp_code, EVENT_TRB_LEN(le32_to_cpu(event->transfer_len)), slot_id, ep_index);
+
 	ep = xhci_get_virt_ep(xhci, slot_id, ep_index);
 	if (!ep) {
 		xhci_err(xhci, "ERROR Invalid Transfer event\n");
@@ -2606,6 +2632,11 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 	ep_ring = xhci_dma_to_transfer_ring(ep, ep_trb_dma);
 	ep_ctx = xhci_get_ep_ctx(xhci, ep->vdev->out_ctx, ep_index);
 
+	snprintf(&ep_ring->log_b[ep_ring->log_i++][0], 100,
+			"event %px ep_trb_dma %llx comp_code %d len %u slot %u ep %d",
+			event, ep_trb_dma, trb_comp_code, EVENT_TRB_LEN(le32_to_cpu(event->transfer_len)), slot_id, ep_index);
+	ep_ring->log_i %= 5;
+
 	if (GET_EP_CTX_STATE(ep_ctx) == EP_STATE_DISABLED) {
 		xhci_err(xhci,
 			 "ERROR Transfer event for disabled endpoint slot %u ep %u\n",
@@ -2640,6 +2671,11 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 		}
 	}
 
+	if (!interesting && ep_ring->interesting)
+		xhci_info(xhci, "handle_tx_event event %px ep_trb_dma %llx comp_code %d len %u slot %u ep %d\n",
+				event, ep_trb_dma, trb_comp_code, EVENT_TRB_LEN(le32_to_cpu(event->transfer_len)), slot_id, ep_index);
+	ep_ring->interesting |= interesting;
+
 	/* Count current td numbers if ep->skip is set */
 	if (ep->skip)
 		td_num += list_count_nodes(&ep_ring->td_list);
@@ -2831,6 +2867,12 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 		ep_seg = trb_in_td(xhci, td->start_seg, td->first_trb,
 				td->last_trb, ep_trb_dma, false);
 
+		if (ep_ring->interesting)
+			xhci_info(xhci, "handle_tx_event event %px first_trb %llx last_trb %llx ep_seg %llx\n", event,
+					xhci_trb_virt_to_dma(ep_ring->deq_seg, td->first_trb),
+					xhci_trb_virt_to_dma(ep_ring->deq_seg, td->last_trb),
+					ep_seg? ep_seg->dma: -1);
+
 		/*
 		 * Skip the Force Stopped Event. The event_trb(event_dma) of FSE
 		 * is not in the current TD pointed by ep_ring->dequeue because
@@ -2880,7 +2922,7 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 						   td_next->last_trb, ep_trb_dma, false);
 				if (ep_seg) {
 					/* give back previous TD, start handling new */
-					xhci_dbg(xhci, "Missing TD completion event after mid TD error\n");
+					xhci_info(xhci, "Missing TD completion event after mid TD error\n");
 					ep_ring->dequeue = td->last_trb;
 					ep_ring->deq_seg = td->last_trb_seg;
 					inc_deq(xhci, ep_ring);
@@ -2898,9 +2940,16 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 					trb_comp_code);
 				trb_in_td(xhci, td->start_seg, td->first_trb,
 					  td->last_trb, ep_trb_dma, true);
+				xhci_info(xhci, "last xhci_td_cleanup: first_dma %llx last_dma %llx status %d from %s\n",
+						ep_ring->cleanup_first_dma, ep_ring->cleanup_last_dma,
+						ep_ring->cleanup_status, ep_ring->cleanup_from);
+				for (int i = 0; i < 5; i++)
+					xhci_info(xhci, "handle_tx_event log %2d: %s\n", i-4, &ep_ring->log_b[(ep_ring->log_i + i) % 5][0]);
+				ep_ring->interesting = true;
 				return -ESHUTDOWN;
 			}
 		}
+
 		if (trb_comp_code == COMP_SHORT_PACKET)
 			ep_ring->last_td_was_short = true;
 		else
@@ -2958,6 +3007,8 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 	 */
 	} while (handling_skipped_tds);
 
+	ep_ring->interesting = interesting;
+
 	return 0;
 
 err_out:
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 6f4bf98a6282..7e2c83e3b9e9 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1360,7 +1360,16 @@ struct xhci_ring {
 	unsigned int		bounce_buf_len;
 	enum xhci_ring_type	type;
 	bool			last_td_was_short;
+	bool			interesting;
 	struct radix_tree_root	*trb_address_map;
+
+	dma_addr_t		cleanup_first_dma;
+	dma_addr_t		cleanup_last_dma;
+	const char		*cleanup_from;
+	int			cleanup_status;
+
+	int			log_i;
+	char			log_b[5][100];
 };
 
 struct xhci_erst_entry {

--MP_/wWorqfnujcpmJC.mAxy2oYy--

