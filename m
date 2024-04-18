Return-Path: <linux-kernel+bounces-150650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7D18AA24A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51457282E05
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663D217AD76;
	Thu, 18 Apr 2024 18:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdGk1yOV"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE4E17AD67;
	Thu, 18 Apr 2024 18:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713466125; cv=none; b=AEGoHb9KInj/fsn8vhltchN3SKX38VICIF1JObFTiLUtM/jCZHzTeD/J3JsVhGp1Lo2IL7GJq0UOQpdzddzQLoFh3zshZKMr0x1CIYIs4ZtKuHJKEzWIyJPV9sNVzCnKFY7Wstecnd0/nlISqR5brZPCq867IXYi6j5BSRgpX8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713466125; c=relaxed/simple;
	bh=W5ulwgdUrJHJyD6YLuoUZA+UwpWoOeowPGuclddyjXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T1/GRTiinAjfCVIQv3CW/ZuHCd5X/1tvBDtCKXcf7t9Ahz2uLELqhI51irgERzueriTxcOUYimELta+nanMoswZOkyUJDagkfz+U7VAdkxRN4QVMAeHzXhsKyqslbkLMrZchLEOXFGd61dRii47NivXn8WRP7fm5AevR3eLY4ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdGk1yOV; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d8b2389e73so15037751fa.3;
        Thu, 18 Apr 2024 11:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713466122; x=1714070922; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JHiNbmJba67zCpDm1cRbfEhy21gaCwmHq3i30H1PcAM=;
        b=QdGk1yOVIb+Ug499fXhfwasYsNq2Ui4mhsEdVq3RxbHY9NoHHbVXvrBs9n/jZsN6v2
         IgtcCwfE/y8TCWlJwYwgO/2kekQsYm0sFpnU6fvs2xRkGoDeVNTXxAIWy5fdC9At+fKY
         FkCscbEyUkfHRDw1swsqdUO2uAATujRdZ2aGDSmBUYZZ4c0fc5WYuwH60E4ffk5pV5ku
         OzkC44Wwm4QIbX49lb7Fx7CEB8DsZyk8bVuoDXWTM3H98uj6GCou7/Ku+uL4WlkOg7mf
         v2wBAwfwlqtBPM7ZJWGfuxwGwe0d3S7rqY8yiqenLLibqMnNRMqaSO4w+XvfBZzjgz8L
         c4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713466122; x=1714070922;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JHiNbmJba67zCpDm1cRbfEhy21gaCwmHq3i30H1PcAM=;
        b=DY+uIbL6qD8LTg2C0UsQS5lgJDgAQ2WjeYHbThFxkRFKr+IVI5H0XKxrHbM+jNO+4f
         19W8o7/lSt8r50496pc85kaMWN2z1lfZ6960Kf0dBi3/64ULVroGQEYqek1TDkcDURwa
         y7OvWs00ayR0G4ZwzFuilzZ+5HV1Ni/cTrYTQaWYD8kJ/0uNGSouPs//zhT1XkiP1bSd
         NJCt2wjZvvq5il4949CAyDPz1e3M+LJcOlgoCLySeKGxwbDiODphbqGVpOyYW9o3cpz4
         SQuAnHgAzAIaInD0ydl0l9435NYNAXdglGjgD2mQG4c37C/LAAawEOOf6CkCWeesXddf
         OIsg==
X-Forwarded-Encrypted: i=1; AJvYcCXo4/W4tkxnHUkZlxsFDswns6rbKpHSBuNi8A6j7RmsSa4hNaXu7zUG8T/WYL3V0i3PVpTwnPXSasYr8aXH73oRJMDtCHiw0hrNZKL7
X-Gm-Message-State: AOJu0Yw41G1fe4LA449oOqbzTz9zYcpZmFMQYurNbvbGclpm1TiTUHY0
	dPBhJqN93zJLYukZqw1Wx+9RKnNTGXHl6Qcqrbs0mE6qVxw9DEsa
X-Google-Smtp-Source: AGHT+IEDbiohkd5JSALTW+YmWcjHO6CO4lNYFjNvUSJLQGztz7zC86Pw5cHxWAIt7b2WCX3Cy4mFRw==
X-Received: by 2002:a05:6512:512:b0:516:c099:e798 with SMTP id o18-20020a056512051200b00516c099e798mr2058601lfb.31.1713466121631;
        Thu, 18 Apr 2024 11:48:41 -0700 (PDT)
Received: from shift.daheim (p200300d5ff0fec0050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff0f:ec00:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id ah2-20020a1709069ac200b00a4e393b6349sm1222385ejc.5.2024.04.18.11.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 11:48:41 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1])
	by shift.daheim with esmtp (Exim 4.97)
	(envelope-from <chunkeey@gmail.com>)
	id 1rxWnn-00000001Oik-19oY;
	Thu, 18 Apr 2024 20:48:40 +0200
Message-ID: <e17f3c8e-3f1b-42d6-9d30-7fe21699b632@gmail.com>
Date: Thu, 18 Apr 2024 20:48:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: carl9170: add a proper sanity check for endpoints
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
 Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, lvc-project@linuxtesting.org,
 syzbot+0ae4804973be759fa420@syzkaller.appspotmail.com
References: <20240407131109.26212-1-n.zhandarovich@fintech.ru>
Content-Language: de-DE
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <20240407131109.26212-1-n.zhandarovich@fintech.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/7/24 3:11 PM, Nikita Zhandarovich wrote:
> Syzkaller reports [1] hitting a warning which is caused by presence
> of a wrong endpoint type at the URB sumbitting stage. While there
> was a check for a specific 4th endpoint, since it can switch types
> between bulk and interrupt, other endpoints are trusted implicitly.
> Similar warning is triggered in a couple of other syzbot issues [2].
> 
> Fix the issue by doing a comprehensive check of all endpoints
> taking into account difference between high- and full-speed
> configuration.
> 
> This patch has not been tested on real hardware.
> 
> [1] Syzkaller report:
> ...
> WARNING: CPU: 0 PID: 4721 at drivers/usb/core/urb.c:504 usb_submit_urb+0xed6/0x1880 drivers/usb/core/urb.c:504
> ...
> Call Trace:
>   <TASK>
>   carl9170_usb_send_rx_irq_urb+0x273/0x340 drivers/net/wireless/ath/carl9170/usb.c:504
>   carl9170_usb_init_device drivers/net/wireless/ath/carl9170/usb.c:939 [inline]
>   carl9170_usb_firmware_finish drivers/net/wireless/ath/carl9170/usb.c:999 [inline]
>   carl9170_usb_firmware_step2+0x175/0x240 drivers/net/wireless/ath/carl9170/usb.c:1028
>   request_firmware_work_func+0x130/0x240 drivers/base/firmware_loader/main.c:1107
>   process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
>   worker_thread+0x669/0x1090 kernel/workqueue.c:2436
>   kthread+0x2e8/0x3a0 kernel/kthread.c:376
>   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
>   </TASK>
> 
> [2] Related syzkaller crashes:
> Link: https://syzkaller.appspot.com/bug?extid=e394db78ae0b0032cb4d
> Link: https://syzkaller.appspot.com/bug?extid=9468df99cb63a4a4c4e1
> 
> Reported-and-tested-by: syzbot+0ae4804973be759fa420@syzkaller.appspotmail.com
> Fixes: a84fab3cbfdc ("carl9170: 802.11 rx/tx processing and usb backend")
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

This was tricky. USB 2.0 works and was easy to test.
But I had to hunt down a FULLSPEED USB Host for this.
The driver loads on with a OHCI Host (Silicon Image, Inc. USB0673 (rev 06))

So, I think this would work. But see my comments below.

> ---
> P.S. as AR9170_USB_EP_CMD endpoint can switch between bulk and int,
> I failed to find a prettier solution to this problem. Will be glad
> to hear if there is a better option...
> 
>   drivers/net/wireless/ath/carl9170/usb.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/carl9170/usb.c b/drivers/net/wireless/ath/carl9170/usb.c
> index c4edf8355941..66d2ad561fd3 100644
> --- a/drivers/net/wireless/ath/carl9170/usb.c
> +++ b/drivers/net/wireless/ath/carl9170/usb.c
> @@ -1069,6 +1069,33 @@ static int carl9170_usb_probe(struct usb_interface *intf,
>   			ar->usb_ep_cmd_is_bulk = true;
>   	}
>   
> +	/* Verify that all expected endpoints are present */
> +	if (ar->usb_ep_cmd_is_bulk) {
> +		u8 bulk_ep_addr[] = {
> +			AR9170_USB_EP_RX | USB_DIR_IN,
> +			AR9170_USB_EP_TX | USB_DIR_OUT,
> +			AR9170_USB_EP_CMD | USB_DIR_OUT,
> +			0};
> +		u8 int_ep_addr[] = {
> +			AR9170_USB_EP_IRQ | USB_DIR_IN,
> +			0};
> +		if (!usb_check_bulk_endpoints(intf, bulk_ep_addr) ||
> +		    !usb_check_int_endpoints(intf, int_ep_addr))
> +			return -ENODEV;

Please call carl9170_free(ar); before returning here.
Otherwise the "ar" will memleak'ed.

> +	} else {
> +		u8 bulk_ep_addr[] = {
> +			AR9170_USB_EP_RX | USB_DIR_IN,
> +			AR9170_USB_EP_TX | USB_DIR_OUT,
> +			0};
> +		u8 int_ep_addr[] = {
> +			AR9170_USB_EP_IRQ | USB_DIR_IN,
> +			AR9170_USB_EP_CMD | USB_DIR_OUT,
> +			0};
> +		if (!usb_check_bulk_endpoints(intf, bulk_ep_addr) ||
> +		    !usb_check_int_endpoints(intf, int_ep_addr))
> +			return -ENODEV;

Same here.

> +	}
> +
>   	usb_set_intfdata(intf, ar);
>   	SET_IEEE80211_DEV(ar->hw, &intf->dev);
>   


