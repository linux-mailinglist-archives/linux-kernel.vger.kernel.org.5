Return-Path: <linux-kernel+bounces-159939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8D58B3689
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FBA62855F8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D038145338;
	Fri, 26 Apr 2024 11:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="0QHVck+5"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA5F144D24
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 11:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714131190; cv=none; b=hu2YgcRJ9FrsMMJfLXw1652YUn7imDf4jo8nNaRSSQucbzqsGpEqyGZy2TNRFr6tIN3rPkQme/OdLEZjKD7OsyRGLEqFEbTkCuTV3HaqqJkjKVfFljppC7ncQtIqcripDF3Uc3uhv7EEdpEvdndVdd3hoU5lV7B1aifvwshpCyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714131190; c=relaxed/simple;
	bh=geBqZPdJKBHdolO8PO7FM1jSAd+Io8kVp5K3TQpvuP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScMbARxREf4Utb6TdUOv1EiTeK3nQ2vO5ilnQy+Ogb8KuvOE/SwNebL2VPyxLOjZlKudw+9ecmy9XTTItgp+/u15YzEYlnW8/LM39ccZvdLLFUS1Vnex8DsIdc5gsUmBmBQij5U9gCyVhtYlllOeudGu88RDGuGbtVq339nKdsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=0QHVck+5; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d87660d5c9so22665881fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 04:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1714131187; x=1714735987; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DAxZtDWunLrbApHdmQojPuCJgA5oa4jSx3wfchhqKB4=;
        b=0QHVck+5wxVXzmxM0Bkk50aFP3iINnDadIsTn03Fx7xe116VMKdCV86MiR4kYy/o7A
         F0MGtraJVOgtujpDP3/N9P6joJSHof4Z/JNMr+lljn7ld/z38/O1snCvoS094uCwqRnk
         1J0i0+zPxCxl5LmG7M6gYcULlQyyF1TmMQ1yLYVJLs8xqdTQhGjWDFaNQMhDSlJ5uajT
         E/AXQoJsrnYs5RuReWIKnBjq89L6yI2PYxGP0H3Aesy1+uxoe0FqxszGBipBdtIkLT1q
         zBUk+OuVduvsGDJhaZzcYHEDNZWEUDWztnJWpgHEGwA8RjNHYmdZDQGkqWxRl0GJjWR5
         ZIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714131187; x=1714735987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAxZtDWunLrbApHdmQojPuCJgA5oa4jSx3wfchhqKB4=;
        b=plTotkpiXS4OTCxE45HsCrh5r1AY3rhl6706bxbtStMBm2M7SEuk/vJR0aMTu+uRDA
         cK2dljv2qCSpcXpCqxdwH8R67HpR5vJIbBXnc/OIf6Px+24/oL8PL7F7RDgyJ8yLuHpG
         4ZAoKhGZoQyItEWqOkV4w2NFFruEKlmVNKdDFlm/bqctTCAJXqS5SJ/BVSt+vWsIoTVW
         /LZuBrdAkbwUGLCV0FaNvb9J+vqE/9J3GelvONK2jqPasW3Q2z5UxvwRzpep53hQVDo9
         ePZK0S2KjtNuaTjqfUnrb/K4Z62iI8k/uXFQc2vnrhHMIaz6wS7GWrIMgj/zwGol6cgC
         ptRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoO4R4WvOXMVy6hzwMaZKkEaaPaKgArI7MRoO5c+oslN2jgbIW6WTGUObsj0KFQe7mtS7nPeFzNWsLJjSd+/z18xsxFhQ/4jGP/bAh
X-Gm-Message-State: AOJu0YwChaqTUtjns+6hRsgZPYlrnSIH+rMiKlwf06HHyFREV7AqNcuQ
	ztAt5QHN7epcu/0QXx5yLrnpVgoWTaqq+gJIa+vBkyjgw/ShWhv7/6tPFxq4Sro=
X-Google-Smtp-Source: AGHT+IFLc/PqloyXRg++rSdNuN7+okZ9J+o4IZDykkrt4Th0AQi4RxfoPh1Ms89wn1jjCsQv/qjxnA==
X-Received: by 2002:a05:651c:155:b0:2dd:cb34:ddbc with SMTP id c21-20020a05651c015500b002ddcb34ddbcmr2107369ljd.48.1714131186378;
        Fri, 26 Apr 2024 04:33:06 -0700 (PDT)
Received: from localhost (89-24-35-126.nat.epc.tmcz.cz. [89.24.35.126])
        by smtp.gmail.com with ESMTPSA id i13-20020a05600c354d00b00419fba938d8sm21958029wmq.27.2024.04.26.04.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 04:33:05 -0700 (PDT)
Date: Fri, 26 Apr 2024 13:33:04 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Slark Xiao <slark_xiao@163.com>
Cc: loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hariprasad Kelam <hkelam@marvell.com>
Subject: Re: [PATCH net v2] net: wwan: Fix missing net device name for error
 message print
Message-ID: <ZiuQ8LAL1uyTVAxJ@nanopsycho>
References: <20240426092444.825735-1-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426092444.825735-1-slark_xiao@163.com>

Fri, Apr 26, 2024 at 11:24:44AM CEST, slark_xiao@163.com wrote:
>In my local, I got an error print in dmesg like below:
>"sequence number glitch prev=487 curr=0"
>After checking, it belongs to mhi_wwan_mbim.c. Refer to the usage
>of this net_err_ratelimited() API in other files, I think we
>should add net device name print before message context.

You don't add dev device name, but rather constant string.

>
>Fixes: aa730a9905b7 ("net: wwan: Add MHI MBIM network driver")
>Signed-off-by: Slark Xiao <slark_xiao@163.com>
>Reviewed-by: Hariprasad Kelam <hkelam@marvell.com>
>---
> drivers/net/wwan/mhi_wwan_mbim.c | 12 ++++++------
> 1 file changed, 6 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan_mbim.c
>index 3f72ae943b29..6cefee25efc4 100644
>--- a/drivers/net/wwan/mhi_wwan_mbim.c
>+++ b/drivers/net/wwan/mhi_wwan_mbim.c
>@@ -186,14 +186,14 @@ static int mbim_rx_verify_nth16(struct mhi_mbim_context *mbim, struct sk_buff *s
> 
> 	if (skb->len < sizeof(struct usb_cdc_ncm_nth16) +
> 			sizeof(struct usb_cdc_ncm_ndp16)) {
>-		net_err_ratelimited("frame too short\n");
>+		net_err_ratelimited("mbim: frame too short\n");

Does not make any sense. If you have multiple instances of mbim, you are
still clueless. You can access netdevice, print out the name as other
net_err_ratelimited() instances do. Btw, it would be more correct to use
netdev_err(), but there is no "ratelimited" variant of that. Perhaps
better to introduce it.

pw-bot: cr


> 		return -EINVAL;
> 	}
> 
> 	nth16 = (struct usb_cdc_ncm_nth16 *)skb->data;
> 
> 	if (nth16->dwSignature != cpu_to_le32(USB_CDC_NCM_NTH16_SIGN)) {
>-		net_err_ratelimited("invalid NTH16 signature <%#010x>\n",
>+		net_err_ratelimited("mbim: invalid NTH16 signature <%#010x>\n",
> 				    le32_to_cpu(nth16->dwSignature));
> 		return -EINVAL;
> 	}
>@@ -201,7 +201,7 @@ static int mbim_rx_verify_nth16(struct mhi_mbim_context *mbim, struct sk_buff *s
> 	/* No limit on the block length, except the size of the data pkt */
> 	len = le16_to_cpu(nth16->wBlockLength);
> 	if (len > skb->len) {
>-		net_err_ratelimited("NTB does not fit into the skb %u/%u\n",
>+		net_err_ratelimited("mbim: NTB does not fit into the skb %u/%u\n",
> 				    len, skb->len);
> 		return -EINVAL;
> 	}
>@@ -209,7 +209,7 @@ static int mbim_rx_verify_nth16(struct mhi_mbim_context *mbim, struct sk_buff *s
> 	if (mbim->rx_seq + 1 != le16_to_cpu(nth16->wSequence) &&
> 	    (mbim->rx_seq || le16_to_cpu(nth16->wSequence)) &&
> 	    !(mbim->rx_seq == 0xffff && !le16_to_cpu(nth16->wSequence))) {
>-		net_err_ratelimited("sequence number glitch prev=%d curr=%d\n",
>+		net_err_ratelimited("mbim: sequence number glitch prev=%d curr=%d\n",
> 				    mbim->rx_seq, le16_to_cpu(nth16->wSequence));
> 	}
> 	mbim->rx_seq = le16_to_cpu(nth16->wSequence);
>@@ -222,7 +222,7 @@ static int mbim_rx_verify_ndp16(struct sk_buff *skb, struct usb_cdc_ncm_ndp16 *n
> 	int ret;
> 
> 	if (le16_to_cpu(ndp16->wLength) < USB_CDC_NCM_NDP16_LENGTH_MIN) {
>-		net_err_ratelimited("invalid DPT16 length <%u>\n",
>+		net_err_ratelimited("mbim: invalid DPT16 length <%u>\n",
> 				    le16_to_cpu(ndp16->wLength));
> 		return -EINVAL;
> 	}
>@@ -233,7 +233,7 @@ static int mbim_rx_verify_ndp16(struct sk_buff *skb, struct usb_cdc_ncm_ndp16 *n
> 
> 	if (sizeof(struct usb_cdc_ncm_ndp16) +
> 	     ret * sizeof(struct usb_cdc_ncm_dpe16) > skb->len) {
>-		net_err_ratelimited("Invalid nframes = %d\n", ret);
>+		net_err_ratelimited("mbim: Invalid nframes = %d\n", ret);
> 		return -EINVAL;
> 	}
> 
>-- 
>2.25.1
>
>

