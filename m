Return-Path: <linux-kernel+bounces-145489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01ABB8A56D3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 337CA1C2123D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABC97F46B;
	Mon, 15 Apr 2024 15:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npyaoWJU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCCF7C085;
	Mon, 15 Apr 2024 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713196503; cv=none; b=KDTG0SbsWtWBymlpFFobdJfeWfGm+nrglbKsAUUVEsrez3CRDr+Oz5FUjGf46x3TsiaWty7lfn9I9EPPPp52SGpX9CY+xFjV1z2HDTqIpK62375DzSjnTdvyJgWcedYfCBVIdTU/LAHzbtsDCLoJgXeH+v8T5Jk+kjGQYQTo2DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713196503; c=relaxed/simple;
	bh=pAhAc4j06ctb6QIM6LDafY6oK/RUA4RGiOU9gQp1TtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9pv/JGvxwqAXqsNqAKlPi2pxUVe9DC4xY8U8IGxCt2RAqfwca/kp7uTJtJqy7uSi+8IUeILAhiz+4RCLl3p+YMz3SCpu24RoFKGRHKse2haNVaVhShwl35A+KOOQEyitZlf2VPNsp7qR7YMyNUvw4DyzfP4GbicDJNMh88Ddmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npyaoWJU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DE3C113CC;
	Mon, 15 Apr 2024 15:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713196502;
	bh=pAhAc4j06ctb6QIM6LDafY6oK/RUA4RGiOU9gQp1TtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=npyaoWJUS7VjnGqz1BsawgavxDHqkvL1tibl9lHuaYt66+9l10I5mkl6Tf18kaz9R
	 OdKY/C7fJl/SZwrmO0sxdWam15bsgI/LC8T93srYmqlEAj7KVwfVjOL4Dp/FYNgnDH
	 PwGJNtNvs+2JWPt64PRe59rooiGb9ZBijfFuAC0bqw1f8J5uVyiQ4xy0Hb8NY1tO5W
	 FK/g9EaTWF6VNRpfjpTddrmtLa2rHq3hPdxRpQ7qSQ9SHlobu/ZIOxAvTiziqpU30x
	 IBczCY2i2aXH3N3nG4pZrfRhqX9Y0j30gpomz2jDfx+LJqkk4DDpm+ZjKolBpXEfn7
	 bJIjKNS4wcWtA==
Date: Mon, 15 Apr 2024 17:54:57 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: kde@carewolf.com
Cc: lains@riseup.net, hadess@hadess.net, jikos@kernel.org, 
	benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hans de Goede <hdegoede@redhat.com>, Allan Sandfeld Jensen <allan.jensen@qt.io>
Subject: Re: [PATCH] Logitech Anywhere 3SB support
Message-ID: <ntsifcsfo5i6xisxbgfjdpe4uenygqxrt3v5sceflgipznw6cb@gnhvkjmglrtg>
References: <20240413095453.14816-1-kde@carewolf.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240413095453.14816-1-kde@carewolf.com>

[Ccing Hans as well for input]

On Apr 13 2024, kde@carewolf.com wrote:
> From: Allan Sandfeld Jensen <allan.jensen@qt.io>
> 

FWIW, this patch neesd a commit description and signed-offs

> ---
>  drivers/hid/hid-ids.h            |  1 +
>  drivers/hid/hid-logitech-dj.c    | 10 +++++++++-
>  drivers/hid/hid-logitech-hidpp.c |  2 ++
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 2235d78784b1..4b79c4578d32 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -849,6 +849,7 @@
>  #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1	0xc539
>  #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_1	0xc53f
>  #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_POWERPLAY	0xc53a
> +#define USB_DEVICE_ID_LOGITECH_BOLT_RECEIVER		0xc548
>  #define USB_DEVICE_ID_SPACETRAVELLER	0xc623
>  #define USB_DEVICE_ID_SPACENAVIGATOR	0xc626
>  #define USB_DEVICE_ID_DINOVO_DESKTOP	0xc704
> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
> index c358778e070b..92b41ae5a47c 100644
> --- a/drivers/hid/hid-logitech-dj.c
> +++ b/drivers/hid/hid-logitech-dj.c
> @@ -120,6 +120,7 @@ enum recvr_type {
>  	recvr_type_27mhz,
>  	recvr_type_bluetooth,
>  	recvr_type_dinovo,
> +	recvr_type_bolt,

I am *really* hesitant in integrating the bolt receiver into
logitech-dj.ko:
- the bolt receiver is not capable of making the distinction between the
  source of the events (so only one mouse/keyboard can be used at the
  time)
- we still have a couple of outstanding and impossible to debug issues
  with some high resolution mice connected over the unifying receiver,
  and adding one more receiver makes me nervous
- I have a strong feeling by reading the code that the keyboard part
  will fail (there is a comment "For the keyboard, we can reuse the same
  report by using the second byte which is constant in the USB HID
  report descriptor." though I can't seem to find this constant report
  on the bolt receiver)
- what are the benefits of adding it?
- will it break fwupd?

>  };
>  
>  struct dj_report {
> @@ -1068,6 +1069,7 @@ static void logi_hidpp_recv_queue_notif(struct hid_device *hdev,
>  		workitem.reports_supported |= STD_KEYBOARD;
>  		break;
>  	case 0x0f:
> +	case 0x10:
>  	case 0x11:
>  		device_type = "eQUAD Lightspeed 1.2";
>  		logi_hidpp_dev_conn_notif_equad(hdev, hidpp_report, &workitem);
> @@ -1430,7 +1432,8 @@ static int logi_dj_ll_parse(struct hid_device *hid)
>  		dbg_hid("%s: sending a mouse descriptor, reports_supported: %llx\n",
>  			__func__, djdev->reports_supported);
>  		if (djdev->dj_receiver_dev->type == recvr_type_gaming_hidpp ||
> -		    djdev->dj_receiver_dev->type == recvr_type_mouse_only)
> +		    djdev->dj_receiver_dev->type == recvr_type_mouse_only ||
> +		    djdev->dj_receiver_dev->type == recvr_type_bolt)
>  			rdcat(rdesc, &rsize, mse_high_res_descriptor,
>  			      sizeof(mse_high_res_descriptor));
>  		else if (djdev->dj_receiver_dev->type == recvr_type_27mhz)
> @@ -1773,6 +1776,7 @@ static int logi_dj_probe(struct hid_device *hdev,
>  	case recvr_type_dj:		no_dj_interfaces = 3; break;
>  	case recvr_type_hidpp:		no_dj_interfaces = 2; break;
>  	case recvr_type_gaming_hidpp:	no_dj_interfaces = 3; break;
> +	case recvr_type_bolt:		no_dj_interfaces = 4; break;

4? The device I have here only has 3 (unless I misremember how this is
supposed to be working).

>  	case recvr_type_mouse_only:	no_dj_interfaces = 2; break;
>  	case recvr_type_27mhz:		no_dj_interfaces = 2; break;
>  	case recvr_type_bluetooth:	no_dj_interfaces = 2; break;
> @@ -1950,6 +1954,10 @@ static const struct hid_device_id logi_dj_receivers[] = {
>  	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
>  		USB_DEVICE_ID_LOGITECH_UNIFYING_RECEIVER_2),
>  	 .driver_data = recvr_type_dj},
> +	{ /* Logitech bolt receiver (0xc548) */
> +	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
> +		USB_DEVICE_ID_LOGITECH_BOLT_RECEIVER),
> +	 .driver_data = recvr_type_bolt},
>  
>  	{ /* Logitech Nano mouse only receiver (0xc52f) */
>  	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index 3c00e6ac8e76..509142982daa 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -4380,6 +4380,8 @@ static const struct hid_device_id hidpp_devices[] = {
>  	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb023) },
>  	{ /* MX Master 3S mouse over Bluetooth */
>  	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb034) },
> +	{ /* MX Anywhere 3SB mouse over Bluetooth */
> +	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb038) },

That I can accept, however know that there is a regression in bluez
0.73[0] (but it should be fixed in 0.74)

Cheers,
Benjamin


[0] https://github.com/bluez/bluez/issues/778#issuecomment-2048870358

>  	{}
>  };
>  
> -- 
> 2.39.2
> 

