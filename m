Return-Path: <linux-kernel+bounces-145575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A518A57FC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65A21F210A0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DE5824B5;
	Mon, 15 Apr 2024 16:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=carewolf.com header.i=@carewolf.com header.b="UUTDQdNb";
	dkim=permerror (0-bit key) header.d=carewolf.com header.i=@carewolf.com header.b="+oDNW7Uc"
Received: from mailrelay3-3.pub.mailoutpod3-cph3.one.com (mailrelay3-3.pub.mailoutpod3-cph3.one.com [46.30.212.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D791482485
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 16:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713199078; cv=none; b=egWVQNUtyNNclPsX2kEO8KhaprDK6UA/K6fQPnP2fSjFzwIE97zpqo+fJ3lz47nKLZB3KWUfQmrdyc02rkz4V+np5FN89QLF9dtv69VbTMv8ZmgoDyJt99+MOwtjPgs96agaANsJZ4gcjd9XY1LsiSv+DYRqRcLW760s18qstwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713199078; c=relaxed/simple;
	bh=5f82cXsX0Yc9vUiO80hi059Uy6riWDjU5KIdsMKZlB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U8Mr/mfRFt8jWX/mal7BXDt+95z+5QO58NCB5uXhfINYeIF8k5plRHsUzivKbX6LOLjspKN46EWP/FZe7F5fhdhoMEO74+2Bg1CaRgf0rEIzT/F2ZQUExOfLCL8YCl+eXjPtg+OZbNcAOOo6m9H8Ee+BGqmBBwneHSspJUjL6Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=carewolf.com; spf=none smtp.mailfrom=carewolf.com; dkim=pass (2048-bit key) header.d=carewolf.com header.i=@carewolf.com header.b=UUTDQdNb; dkim=permerror (0-bit key) header.d=carewolf.com header.i=@carewolf.com header.b=+oDNW7Uc; arc=none smtp.client-ip=46.30.212.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=carewolf.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=carewolf.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=carewolf.com; s=rsa2;
	h=content-type:content-transfer-encoding:mime-version:references:in-reply-to:
	 message-id:date:subject:cc:to:from:from;
	bh=vsC16hvCMFPYmCQkGrA9j3yxl922C60EqFZAOHN8RCE=;
	b=UUTDQdNbY2uV2DPEiMAaZZWquxtUdgw3O4BDYkPweQQZ/vUwxryJxTHabVC1N1tJ3tl2oWYvdwfBU
	 W3EUg/M+nRuxNpleYR1SScqNZEVjfiRnYE6DrZUndcXGxP2teBrMTaw4VsvNqMlA+cwkNyIT359mxu
	 tKW58gM4oSwubzkEG/q9GkvLylXPTvu1b5QeWV/ceky1f+rEdZEvIWmeP6YmVNz/xkDHnZKD1ooa19
	 vHkA5olsshfeHHOxLsxX1pWZ63WMlUMS79LYYJSQPApiiI0XVpwqttwTRx5uPiFzaBs7U7TPq2Z0Qp
	 ncxFrdWmozPr8vbfcevwjeaQxDYqd1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=carewolf.com; s=ed2;
	h=content-type:content-transfer-encoding:mime-version:references:in-reply-to:
	 message-id:date:subject:cc:to:from:from;
	bh=vsC16hvCMFPYmCQkGrA9j3yxl922C60EqFZAOHN8RCE=;
	b=+oDNW7UcUcCVLMDDFqms95XoHW70Ads/2DaW76BziJIGum3zqNvw+GKul4X6GZENKkt+YVxGfOCx7
	 SEc3ziSAA==
X-HalOne-ID: 570aa5e4-fb46-11ee-b0da-5166eb5bc2d3
Received: from twilight.localnet (dynamic-2a02-3103-004c-5300-b5a9-dc4e-89ff-7d46.310.pool.telefonica.de [2a02:3103:4c:5300:b5a9:dc4e:89ff:7d46])
	by mailrelay3.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 570aa5e4-fb46-11ee-b0da-5166eb5bc2d3;
	Mon, 15 Apr 2024 16:36:44 +0000 (UTC)
From: Allan Sandfeld Jensen <kde@carewolf.com>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: lains@riseup.net, hadess@hadess.net, jikos@kernel.org,
 benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] Logitech Anywhere 3SB support
Date: Mon, 15 Apr 2024 18:36:43 +0200
Message-ID: <2266147.iZASKD2KPV@twilight>
In-Reply-To: <ntsifcsfo5i6xisxbgfjdpe4uenygqxrt3v5sceflgipznw6cb@gnhvkjmglrtg>
References:
 <20240413095453.14816-1-kde@carewolf.com>
 <ntsifcsfo5i6xisxbgfjdpe4uenygqxrt3v5sceflgipznw6cb@gnhvkjmglrtg>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Monday 15 April 2024 17:54:57 CEST Benjamin Tissoires wrote:
> [You don't often get email from bentiss@kernel.org. Learn why this is
> important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> [Ccing Hans as well for input]
> 
> On Apr 13 2024, kde@carewolf.com wrote:
> > From: Allan Sandfeld Jensen <allan.jensen@qt.io>
> 
> FWIW, this patch neesd a commit description and signed-offs
> 
> > ---
> > 
> >  drivers/hid/hid-ids.h            |  1 +
> >  drivers/hid/hid-logitech-dj.c    | 10 +++++++++-
> >  drivers/hid/hid-logitech-hidpp.c |  2 ++
> >  3 files changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> > index 2235d78784b1..4b79c4578d32 100644
> > --- a/drivers/hid/hid-ids.h
> > +++ b/drivers/hid/hid-ids.h
> > @@ -849,6 +849,7 @@
> > 
> >  #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1    0xc539
> >  #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_1  0xc53f
> >  #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_POWERPLAY       0xc53a
> > 
> > +#define USB_DEVICE_ID_LOGITECH_BOLT_RECEIVER         0xc548
> > 
> >  #define USB_DEVICE_ID_SPACETRAVELLER 0xc623
> >  #define USB_DEVICE_ID_SPACENAVIGATOR 0xc626
> >  #define USB_DEVICE_ID_DINOVO_DESKTOP 0xc704
> > 
> > diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
> > index c358778e070b..92b41ae5a47c 100644
> > --- a/drivers/hid/hid-logitech-dj.c
> > +++ b/drivers/hid/hid-logitech-dj.c
> > @@ -120,6 +120,7 @@ enum recvr_type {
> > 
> >       recvr_type_27mhz,
> >       recvr_type_bluetooth,
> >       recvr_type_dinovo,
> > 
> > +     recvr_type_bolt,
> 
> I am *really* hesitant in integrating the bolt receiver into
> logitech-dj.ko:
> - the bolt receiver is not capable of making the distinction between the
>   source of the events (so only one mouse/keyboard can be used at the
>   time)
> - we still have a couple of outstanding and impossible to debug issues
>   with some high resolution mice connected over the unifying receiver,
>   and adding one more receiver makes me nervous
> - I have a strong feeling by reading the code that the keyboard part
>   will fail (there is a comment "For the keyboard, we can reuse the same
>   report by using the second byte which is constant in the USB HID
>   report descriptor." though I can't seem to find this constant report
>   on the bolt receiver)
> - what are the benefits of adding it?
> - will it break fwupd?
> 
I added it to get hires scroll wheel events working out of the box.

The main differences for the bolt receiver as I briefly skimmed it, are 
different peering commands, which I didn't want to touch that.

For my purpose I discovered the bolt receiver operated much like the gaming-
hidpp receiver, except that I have four interfaces.

> >  };
> >  
> >  struct dj_report {
> > 
> > @@ -1068,6 +1069,7 @@ static void logi_hidpp_recv_queue_notif(struct
> > hid_device *hdev,> 
> >               workitem.reports_supported |= STD_KEYBOARD;
> >               break;
> >       
> >       case 0x0f:
> > +     case 0x10:
> >       case 0x11:
> >               device_type = "eQUAD Lightspeed 1.2";
> >               logi_hidpp_dev_conn_notif_equad(hdev, hidpp_report,
> >               &workitem);
> > 
> > @@ -1430,7 +1432,8 @@ static int logi_dj_ll_parse(struct hid_device *hid)
> > 
> >               dbg_hid("%s: sending a mouse descriptor, reports_supported:
> >               %llx\n",
> >               
> >                       __func__, djdev->reports_supported);
> >               
> >               if (djdev->dj_receiver_dev->type == recvr_type_gaming_hidpp
> >               ||
> > 
> > -                 djdev->dj_receiver_dev->type == recvr_type_mouse_only)
> > +                 djdev->dj_receiver_dev->type == recvr_type_mouse_only ||
> > +                 djdev->dj_receiver_dev->type == recvr_type_bolt)
> > 
> >                       rdcat(rdesc, &rsize, mse_high_res_descriptor,
> >                       
> >                             sizeof(mse_high_res_descriptor));
> >               
> >               else if (djdev->dj_receiver_dev->type == recvr_type_27mhz)
> > 
> > @@ -1773,6 +1776,7 @@ static int logi_dj_probe(struct hid_device *hdev,
> > 
> >       case recvr_type_dj:             no_dj_interfaces = 3; break;
> >       case recvr_type_hidpp:          no_dj_interfaces = 2; break;
> >       case recvr_type_gaming_hidpp:   no_dj_interfaces = 3; break;
> > 
> > +     case recvr_type_bolt:           no_dj_interfaces = 4; break;
> 
> 4? The device I have here only has 3 (unless I misremember how this is
> supposed to be working).
> 
I am getting four. The fourth one is the one with 0x10 case I added above.
[    5.706399] logitech-djreceiver 0003:046D:C548.0003: device of type eQUAD 
Lightspeed 1.2 (0x10) connected on slot 2

You can leave out the added 0x10 case, and just treat the bolt receiver as a 
gaming_hidpp receiver I assume. I got an error there about unknown device, 
when I originaly tried just using the gaming_hidpp type, but it is possible it 
could still work (I hit another bug when I originally tried that) . I can go 
back and check if you would prefer this minimalist solution?

I dont have any additional bolt capable devices, so I can't test how it would 
work if I peered more devices.

Best regards
Allan





