Return-Path: <linux-kernel+bounces-159768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF5B8B33B7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B6E01C21A4E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA0513DB90;
	Fri, 26 Apr 2024 09:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hp9BbYGJ"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2DC13D8B6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 09:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714123013; cv=none; b=iwRMQ3sIjrV2ycx0G8yNz954Le6WTYqD25mCttzcp2CD8WymZrrPHaKX8dS1wLsilpyk3Ur7VHgrEKbPgIQUpdQX0xG7y+NN+n9/CzvUh0AcaQuqicPIoSAYWsF4c8G3QMs41v88yZvyFlDeyOZJL40CgJBGvWLZb6z4RIVdp5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714123013; c=relaxed/simple;
	bh=zAgKQvFrqBDTFX13F6wBlBpnyEvLpQwg/v9jaYHnoJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ufe/KKXWPYp7JT5wJnFiLoVylBIYjEctwZlqVZ+0mep22bbsKM7A9lvj0UE7EG/AlnZbegxVrkvDHHr8xUMQXsA6KNGzhre0qjc4KZES4GhYSVYZqld9n15aNyNL8cmWxHbkdTj6ifN86fWH7FlxIubqQ5kQAxoWdvhV/w7+TOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hp9BbYGJ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4187c47405aso13084115e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 02:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714123010; x=1714727810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wtWpy9Lgm95m3RnkoldI8iHDQ2l7NCe3R0HbIn79igY=;
        b=Hp9BbYGJPRO7x800A60sIDFETsZDoFNBX6PmVuwMog9X3e6ffnxUyIy4QuH81qdzvD
         oCf98oTJ9w/XE/ZmACpdC3b0Mm4prvM0j8a7dk3jGF+t5K8wEVvkM0xei6GRQyxZ/p8g
         ITvodSYstBr9/UyLxEYtjk9B0EUv75els85zEQ4pglfF7OCiqNGtrAMW6odKaGNpNpv5
         DYDTqRe0uzv8jUa0jMR2GvamIaDIFPMmNqT8h0DW0STC7NbPvQKwUWrwfwjn5M+rGdo2
         zlJ2rApm2PKoKhKRtyUNNqglFvjRGhs4cr+d6uwDfRTPaPbb/Lww+C6O2ZproN79AHSI
         4hXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714123010; x=1714727810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtWpy9Lgm95m3RnkoldI8iHDQ2l7NCe3R0HbIn79igY=;
        b=WLyo+t6R3IfLNIDHD0YWbO8FCstVj8+uh2CcER2f+LWDdO+wsnDyHRI0YekQPcZtn0
         wOrkvqpXyiEXeiQRL+hYoukSg5RS74C6a3EDqrcW1q8e6+lQ+pDMj2cR2jpO91l+A+zr
         pU98iCHOLTNmPAGdUNGsdvBdiz33s6cWac2jRDrhe//dqp0luOj7lCdI4C6ZcEyGOc4U
         zmK2vxS/RShpVDpZ8U4HrFFhu9tz7EhD3f05RmrOWmJ640JSbfOXG2exFafz7HKfkZMo
         s6ppvHXBlwYc2O6iUysOKz2hWECzhuN70vumLZaL/TnSzPUz4roI2Naek/iZNNTRHCdu
         cLzA==
X-Forwarded-Encrypted: i=1; AJvYcCVj8/ea78Dv7RP36mUCmbJVoswfCwKl6mQjcx17Ywj0VT5BhiqZBLyHTPqwkL2EuimkHRd0V5qgTPvPBp+ykcV+F01u1Jty81pcjsdA
X-Gm-Message-State: AOJu0YwcW8/S8KYA1g4uS1booLQLvLSGvq5PHzzxopMy0Iii4f/ReTo2
	6yvVh8aDBVSsgoPGNq/ylteluEzKOUCpIzoTQ2H8wWA69XfNaRNI27UpvytS64o=
X-Google-Smtp-Source: AGHT+IEG8i+8YqPGXE7NyAEe92XBUgHIuPaem/HnPBOUmFEDTzHhIh4tS8CKnTcfaMOX01XFtN6+Qg==
X-Received: by 2002:a05:600c:138f:b0:41a:da4:319e with SMTP id u15-20020a05600c138f00b0041a0da4319emr1483014wmf.18.1714123009923;
        Fri, 26 Apr 2024 02:16:49 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id o3-20020a05600c4fc300b00418f7605249sm28153560wmq.24.2024.04.26.02.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 02:16:49 -0700 (PDT)
Date: Fri, 26 Apr 2024 12:16:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sungwoo Kim <iam@sung-woo.kim>
Cc: daveti@purdue.edu, Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix slab-use-after-free in
 l2cap_send_cmd
Message-ID: <cff764c2-a3d1-4a12-9260-54122e7a1fef@moroto.mountain>
References: <20240426072006.358802-1-iam@sung-woo.kim>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426072006.358802-1-iam@sung-woo.kim>

On Fri, Apr 26, 2024 at 03:20:05AM -0400, Sungwoo Kim wrote:
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 84fc70862..a8f414ab8 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -3953,6 +3953,9 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
>  	if (!chan)
>  		goto response;
>  
> +	l2cap_chan_hold(chan);
> +	l2cap_chan_lock(chan);
> +
>  	/* For certain devices (ex: HID mouse), support for authentication,
>  	 * pairing and bonding is optional. For such devices, inorder to avoid
>  	 * the ACL alive for too long after L2CAP disconnection, reset the ACL
> @@ -4041,6 +4044,11 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
>  		chan->num_conf_req++;
>  	}
>  
> +	if (chan) {
> +		l2cap_chan_unlock(chan);
> +		l2cap_chan_put(chan);
> +	}
> +
>  	return chan;
        ^^^^^^^^^^^^
This doesn't fix the bug because we're returning chan.

As soon as you call l2cap_chan_put() then chan will be freed by in the
other thread which is doing l2cap_conn_del() resulting in a use after
free in the caller.

regards,
dan carpenter


