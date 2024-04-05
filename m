Return-Path: <linux-kernel+bounces-132742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE4D899980
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED51C1C20BE5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A12160789;
	Fri,  5 Apr 2024 09:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4W193bs"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C58D15FCE2;
	Fri,  5 Apr 2024 09:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712309576; cv=none; b=lTYUzwQyQ0RHzqUSM/Z5ylTPfKWOQxADgv/ksgdPtaAerMZbS9uV7knt1AIukH3HA0n75CIl3E4nCr59l1IrhIp/Ij8ltRbslX+j+ElAsXFvwiFQYSRqboAirP0kwybpbt/6wkOPKiQ5P+NVx4FlJZK28Ls+WhKn1eSoDBlstY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712309576; c=relaxed/simple;
	bh=FSGBi+YfdydBGkRK5pkIkzuF1U805TqHDXm+o2pKfv0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rv2BlUps8pYgSlO71B/g21tdrCz/IbFvPe0XqdM/sM3OIwx2yG9l/Am59AOyTTu1+FGwFO4B8oQpZjbVFlyG+v2m+kpukyd1Fmwua8fKZdXv4LSfbQbOEvCuRiPm6vm8G0LXQquHcnVW5vILUvKnT+EsC2pLq7A+sZNmbmdNiTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4W193bs; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56c404da0ebso2948963a12.0;
        Fri, 05 Apr 2024 02:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712309573; x=1712914373; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fp1NiEWvKucXYaZqCRpLFr2R2EuZQk4B8FjI5zW5+7Y=;
        b=K4W193bsQR4M4ohTeNqqLCcz3hyxKu5Zml4zz+WEP49F5Rcqt+FlAGPW93z5qpkGml
         TY9/UC00D1tYLo1wOwWsHjeg+3Z+RRmMbRZKz9LtFikXLMiIAvs2hCuewBPrdGR8E1NZ
         spfZUndEeGngc/Ac3ypPqbxtN15UxN0KG9ymLh6UCN/IIEWSsFecm6tgmyH6wIkbKsq6
         aQoRZ04duXGlZLpW5k3mVj/4oOeFafSBsPT9Ov5V6KFpsJaBeckltmsQuGsuTLfr8DD+
         Adz/Ulk1ok29FPy78UqAo21ndPYQhCZ+WKOM0x5Lddja7AcqJAcOQTKfKPh4K9O20mSg
         Or3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712309573; x=1712914373;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fp1NiEWvKucXYaZqCRpLFr2R2EuZQk4B8FjI5zW5+7Y=;
        b=cGEzSujFXxdVBBNiAwe6pfj+c9/u+cuY7dRC6EHwF05kIKiCNX3QTPI5zElRSdoL5Z
         B9Wa/T4f8HVX3ng//94YqvO6PSj6NPPRhpHYqIj06p0HGf0BMaTJ2d7f26Srte+96AoE
         f4ycadXFn7R6HpZFDi2K5lbMK6z5RCPRCRn+AAppRyR4dZLQlt8xa/BMk7fTmqAbkRQX
         KkPFvh3eqHa/GsM0h4v1agew2hm61BEvQVLtRR7UJOxQ3E2FM/NITmy/nxrWwI2stlAI
         n3PqX/PaXrWyvIH7wbeHcyvcXjA2l00qmlCEFgIxFMcbfM4rRjezluQ2rDxoLutJNd//
         RD/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmeb7/j9Gmbw/t9idojvzHrnmdHuLT46kC0QrjvU0tL8I6JzYQpmOY0KiJl/QWPaLiglGgXF+a9OKKjFyK5+mP7rql0gM24g8YjM11
X-Gm-Message-State: AOJu0Ywqm5yn3HBWt5vwF3f8UTQV7cQ+GIqkH8Y3ehgGt2VEQ/cbC2uP
	JbB2TLfdRJfHYOK5hIH0hn/yu75th+L93UC6jbqzVXfzSteRVpVd
X-Google-Smtp-Source: AGHT+IFMcSfTlYZvAOYL5ZYCNFf4SlAShdw7sui3vPUh9mag9NiY8FXda0nLgRX5jcfEBV5JAN4g7g==
X-Received: by 2002:a17:906:c104:b0:a4e:174f:a913 with SMTP id do4-20020a170906c10400b00a4e174fa913mr1037820ejc.58.1712309572482;
        Fri, 05 Apr 2024 02:32:52 -0700 (PDT)
Received: from foxbook (bfi147.neoplus.adsl.tpnet.pl. [83.28.46.147])
        by smtp.gmail.com with ESMTPSA id ky23-20020a170907779700b00a4e2dc1283asm627529ejc.50.2024.04.05.02.32.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 05 Apr 2024 02:32:52 -0700 (PDT)
Date: Fri, 5 Apr 2024 11:32:47 +0200
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>, LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: xhci_hcd 0000:00:14.0: ERROR Transfer event TRB DMA ptr not
 part of current TD ep_index 1 comp_code 1
Message-ID: <20240405113247.743e34b2@foxbook>
In-Reply-To: <58bca6f2-797a-4e20-a476-2294309afdd5@molgen.mpg.de>
References: <58bca6f2-797a-4e20-a476-2294309afdd5@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/w03htzOCUP+RUl2PSrSjOlE"

--MP_/w03htzOCUP+RUl2PSrSjOlE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

> On a Dell XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022 with Debian 
> sid/unstable, at least Linux 6.8-rc7 and 6.9-rc1+ log the error
> below, when unplugging a USB headset from the USB Type A port of the
> laptop.
Can you reproduce this on other computers or with other USB devices?
(I just tested a few random audio dongles on my PC, nothing happens).

Is there any kernel version known to be free of this problem?

>      xhci_hcd 0000:00:14.0: ERROR Transfer event TRB DMA ptr not part
> of current TD ep_index 1 comp_code 1
>      xhci_hcd 0000:00:14.0: Looking for event-dma 0000000128897080 
> trb-start 0000000128897090 trb-end 0000000128897090 seg-start 
> 0000000128897000 seg-end 0000000128897ff0
This looks like the xHCI driver freed data structures related to a USB
transfer concurrently with the hardware executing this transfer. It's
a bad thing which should never happen, but sometimes it does because of
bugs in USB controllers or the driver.

Can you run patched kernels on the affected laptop? I attach a patch
I used to track down similar issues on UVC webcams. It doesn't fix
anything, but adds some dmesg noise which may be helpful in figuring
out what goes wrong. The patch should work on v6.9-rc1 or -rc2.

Regards,
Michal

--MP_/w03htzOCUP+RUl2PSrSjOlE
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=xhci-noise.patch

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 52278afea94b..6472b2554ed3 100644
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
+		xhci_info(xhci, "process_isoc_td requested %u ep_trb_len %u remaining %u\n", requested, ep_trb_len, remaining);
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
@@ -2597,6 +2618,10 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 	trb_comp_code = GET_COMP_CODE(le32_to_cpu(event->transfer_len));
 	ep_trb_dma = le64_to_cpu(event->buffer);
 
+	bool interesting = trb_comp_code != COMP_SUCCESS && trb_comp_code != COMP_SHORT_PACKET;
+	if (interesting)
+		xhci_info(xhci, "handle_tx_event interesting ep_trb_dma %llx comp_code %d slot %u ep %d", ep_trb_dma, trb_comp_code, slot_id, ep_index);
+
 	ep = xhci_get_virt_ep(xhci, slot_id, ep_index);
 	if (!ep) {
 		xhci_err(xhci, "ERROR Invalid Transfer event\n");
@@ -2640,6 +2665,10 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 		}
 	}
 
+	if (!interesting && ep_ring->interesting)
+		xhci_info(xhci, "handle_tx_event uninteresting ep_trb_dma %llx comp_code %d slot %u ep %d", ep_trb_dma, trb_comp_code, slot_id, ep_index);
+	ep_ring->interesting |= interesting;
+
 	/* Count current td numbers if ep->skip is set */
 	if (ep->skip)
 		td_num += list_count_nodes(&ep_ring->td_list);
@@ -2831,6 +2860,12 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 		ep_seg = trb_in_td(xhci, td->start_seg, td->first_trb,
 				td->last_trb, ep_trb_dma, false);
 
+		if (ep_ring->interesting)
+			xhci_info(xhci, "handle_tx_event first_trb %llx last_trb %llx ep_seg %llx\n",
+					xhci_trb_virt_to_dma(ep_ring->deq_seg, td->first_trb),
+					xhci_trb_virt_to_dma(ep_ring->deq_seg, td->last_trb),
+					ep_seg? ep_seg->dma: -1);
+
 		/*
 		 * Skip the Force Stopped Event. The event_trb(event_dma) of FSE
 		 * is not in the current TD pointed by ep_ring->dequeue because
@@ -2880,7 +2915,7 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 						   td_next->last_trb, ep_trb_dma, false);
 				if (ep_seg) {
 					/* give back previous TD, start handling new */
-					xhci_dbg(xhci, "Missing TD completion event after mid TD error\n");
+					xhci_info(xhci, "Missing TD completion event after mid TD error\n");
 					ep_ring->dequeue = td->last_trb;
 					ep_ring->deq_seg = td->last_trb_seg;
 					inc_deq(xhci, ep_ring);
@@ -2898,9 +2933,14 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 					trb_comp_code);
 				trb_in_td(xhci, td->start_seg, td->first_trb,
 					  td->last_trb, ep_trb_dma, true);
+				xhci_info(xhci, "last xhci_td_cleanup: first_dma %llx last_dma %llx status %d from %s\n",
+						ep_ring->cleanup_first_dma, ep_ring->cleanup_last_dma,
+						ep_ring->cleanup_status, ep_ring->cleanup_from);
+				ep_ring->interesting = true;
 				return -ESHUTDOWN;
 			}
 		}
+
 		if (trb_comp_code == COMP_SHORT_PACKET)
 			ep_ring->last_td_was_short = true;
 		else
@@ -2958,6 +2998,8 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 	 */
 	} while (handling_skipped_tds);
 
+	ep_ring->interesting = interesting;
+
 	return 0;
 
 err_out:
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 6f4bf98a6282..1e6ccb644279 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1360,7 +1360,12 @@ struct xhci_ring {
 	unsigned int		bounce_buf_len;
 	enum xhci_ring_type	type;
 	bool			last_td_was_short;
+	bool			interesting;
 	struct radix_tree_root	*trb_address_map;
+	dma_addr_t		cleanup_first_dma;
+	dma_addr_t		cleanup_last_dma;
+	const char		*cleanup_from;
+	int			cleanup_status;
 };
 
 struct xhci_erst_entry {

--MP_/w03htzOCUP+RUl2PSrSjOlE--

