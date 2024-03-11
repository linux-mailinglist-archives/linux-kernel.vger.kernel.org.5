Return-Path: <linux-kernel+bounces-98508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42178877B22
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 08:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7341E1C20F94
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 07:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C5110942;
	Mon, 11 Mar 2024 07:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yH30ZJpc"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EA5101C6
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 07:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710140698; cv=none; b=esG9dThH8NzDHCBBNICYQAQL6MybJwdbVAtxylnaEzN+s4ujq3Gn8iNPcCH9Ju4XoU3uZHJm1mLlD5YfS/37fL80Wf7l1zgmNnIbUq5hVfP1OCp7F37UrBVl024w/iyIjfVsrELwLHEQCsmc+tR0znQL5EP5p6k9D9WncFbaAro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710140698; c=relaxed/simple;
	bh=LDF1jMVuiZYW3+Qdxhj7V/tg1OZHnC5qcrFnW/RQ6ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n72CmrML4dwU/UpFifWQRlWwRxgXMfoJPtAd4J+2X77/AmjEGObIdlEK2c1So44yztMwA+IkXxPm1imT7OQNv/jPTaX0IpGrvWkmfVthxPGMZTJQLD/5T/Su8Wjtsvt+ZPOX3jTlUC6ZHtCuxMw/zQVp+BuUXIqxiBWVl2Y9ZOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yH30ZJpc; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-512f892500cso2653402e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 00:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710140695; x=1710745495; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1fKA6+EcIyG1VGF8wUUOjJ4Vzk29UqXeKfPp1lEfdws=;
        b=yH30ZJpcd0tGzvzjbpHl+2iFkUvOhwM41r/Aw6wyu83Z56PC3/g7pm96HLJigbU0Qt
         8M5bHqXswYT7QUFm0mZYMZ/KsIlmwusek7ZL3WqxZKtvRzZRE6dPXOCK2FJPUvw+4nba
         bS9poGj8HVkSvjIjKgAjueXZO4S7NNAnjCRoBiRNsZuO7UwX8M6QJGsARIVwc10axIAm
         3+L98NoQkf8D3qcbKi06vLuCUlsPtzrwPaLLePKdbtsNzEWSuIcMDHXDcUUezXV7vHXo
         QmdE83S6cAscVE305aRZe6S5ZJsuaYuBwTQT90bk7y0/vXJ1BJqnhdHKpAvGRLtfXij/
         PBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710140695; x=1710745495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fKA6+EcIyG1VGF8wUUOjJ4Vzk29UqXeKfPp1lEfdws=;
        b=pjTNhDy0F93nO8qogXPrlvFteU0i3qYVsPPvZjhxCjrDTiqpk+yDU0w+przyI75ULD
         gXxD/FNgMiAySEImvlj0ddOETju5y1yRLyepAB6nx7pO3WcrNoNJqodnXJSAT4Z75Cgu
         OLKqmHSvIZehd5e7dDoEBuTA3YAV6IFlZrZ01MFixl2Lu+0hJPlGZyhVXtl6i+RO9O1A
         GCEc1OfZ5UVAwahUkc3Hrnsx0qXb/I8EL8ug9eANGS47ipIWKMIKL3zq8IGPTiVoymBR
         TYrH67K8zFqJjasRcqqgt0NxWCFTyWhgUMzxs/xgHafmYzTMvakDHxu8zLraJYUX9KTk
         Lqng==
X-Forwarded-Encrypted: i=1; AJvYcCU2gD2ji+6fIWS91/8Vkb6gB7gPdxwLUTDZ7Q0owuEUj24LTZOGlHDRINrTJpXv0Pg0d/HTnPUeJlpg3aWk5yhuVUhN3VnIHFHjmAtR
X-Gm-Message-State: AOJu0Yx7p88PRVlD8x5c6QSkIfzaIWjiWxE16UzFl/iLduNCGmqnQAy+
	dLBm3+fbankGoXyzQgufxDi13ESY9m1E+k3Eva0xPgow2DdjHW80yqI3HoJToEw=
X-Google-Smtp-Source: AGHT+IEcIiLHEOOICmbB0uULxC6RFfg6iqj9sUyoOsFQQ3tWtascKJ3bpzX5fnNEoUiAoOFpalJ96A==
X-Received: by 2002:ac2:4428:0:b0:513:aa3a:4204 with SMTP id w8-20020ac24428000000b00513aa3a4204mr886796lfl.69.1710140694651;
        Mon, 11 Mar 2024 00:04:54 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id m38-20020a05600c3b2600b00412b6fbb9b5sm14677443wms.8.2024.03.11.00.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 00:04:54 -0700 (PDT)
Date: Mon, 11 Mar 2024 10:04:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>,
	Lee Jones <lee@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	Larry.Finger@lwfinger.net, johannes@sipsolutions.net,
	kvalo@kernel.org, arnd@arndb.de
Subject: Re: [RFC] staging: wlan-ng: Driver broken since kernel 5.15
Message-ID: <fba3951f-00b7-41af-8ef4-1e7c86e0cb48@moroto.mountain>
References: <6dc14151-e71e-4118-826d-3ca5c8ee907f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dc14151-e71e-4118-826d-3ca5c8ee907f@gmail.com>

On Sat, Mar 09, 2024 at 11:09:24PM +0100, Philipp Hortmann wrote:
> Hi,
> 
> I would remove the driver from the mainline kernel. What are your thoughts?
> 
> I bought two WLAN devices (DUT: D-Link DWL-122 and T-Sinus 111 data) that
> are supported by wlan-ng driver. Issue is that the driver is not working
> anymore.
> 
> The error picture is that the device does not receive any packets.
> The dmesg says:
> [  123.695917] prism2_usb 2-1.6:1.0 wlan0: Unknown mgmt request message
> 0x0e4f9800
> [  127.508211] prism2_usb 2-1.6:1.0 wlan0: Unknown mgmt request message
> 0x04f0d000
> ...
> 
> A working commit 8fc4fb1728855a22f9149079ba51877f5ee61fc9 (HEAD) Date: Mon
> Jul 5 11:16:28 2021 -0700
> A failing commit  d980cc0620ae77ab2572235a1300bf22519f2e86 (HEAD) Date:  Fri
> Jul 16 19:08:09 2021 -0700

Those dates are 11 days apart during the v5.14 merge window.  You're
saying 5.15 is broken but the broken commit is in 5.14-rc2 so it really
was broken earlier.

There were only 3 patches to wlan-ng between v5.13 and v5.14.

$ git log --oneline v5.13..v5.14 drivers/staging/wlan-ng/
b1e9109aeff3 staging: wlan-ng: silence incorrect type in argument 1 (different address spaces)
ad843f392035 staging: wlan-ng: remove redundant initialization of variable txresult
ea82ff749587 staging: wlan-ng: cfg80211: Move large struct onto the heap

Obviously I'm going to suspect the largest patch.  Reviewing that patch
now, I see we removed a memset() from the loop.  That seems like a bug.

-               memset(&msg2, 0, sizeof(msg2));
-               msg2.msgcode = DIDMSG_DOT11REQ_SCAN_RESULTS;
-               msg2.bssindex.data = i;
+               msg2->msgcode = DIDMSG_DOT11REQ_SCAN_RESULTS;
+               msg2->bssindex.data = i;

That's the only interesting change so I suspect it's the issue...
Could you test this patch?  I feel like if you're the first person to
complain since Aug 29 2021 then probably we should just remove the
driver.  Greg is on vacation so lets hold off on removing it until he
comes back.

regards,
dan carpenter


diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
index 471bb310176f..0c270ed8ce67 100644
--- a/drivers/staging/wlan-ng/cfg80211.c
+++ b/drivers/staging/wlan-ng/cfg80211.c
@@ -347,6 +347,7 @@ static int prism2_scan(struct wiphy *wiphy,
 	for (i = 0; i < numbss; i++) {
 		int freq;
 
+		memset(msg2, 0, sizeof(*msg2));
 		msg2->msgcode = DIDMSG_DOT11REQ_SCAN_RESULTS;
 		msg2->bssindex.data = i;
 

