Return-Path: <linux-kernel+bounces-99984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A91E879042
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0028B1F21B62
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9213377F21;
	Tue, 12 Mar 2024 09:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="asgOlZAF"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F37E77F12
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710234197; cv=none; b=Xna9bgjWv6zzDtB6zpSLJ+f9cNFuk4diRJSZ+y2FNwulxiOyTTQqqvygbtSBzw/siiA7NaX469OonKj1yoSTHRqf4xcH3FCG/C+wPDAYQCxWjxMog0Yh6ZntSFgVy6nbFS6r2JKQUhZ610znLpAId+AYpoR4h/8t6U3v271eHoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710234197; c=relaxed/simple;
	bh=s1TPGDD3FQrj7OxiV2Kb3nYfjuUTXMyg7DkuslLMXRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwEY7t/TsgXr9UH2oU0h0DPNvZwdOLUzQNMZjxupzm/vzq7iGv4v/8EuqqJfL93N7IjJXkJAHXNJS6tK6G4PGxZvj+WtjekWWpyUAfFrgTpEINbf01Vabn2suNFmjgyWbCo2spD3k2nH+7JoQv9o346yw4nAd0tvm0Kd4ONJOAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=asgOlZAF; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a44f2d894b7so654407366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 02:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710234194; x=1710838994; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J6i3TaLouGAS+GfFlJ9J9LI/0HUB7fKxpK6hNinsoOw=;
        b=asgOlZAFPUlCwCxRPCNW4draZ9W+h6iFrQNQJ6C+EgV2efaL7bmHhhz7lrIsjT3il4
         hSp3Z6a80I8AK5vGghWinnzEG0BA/bZzwVjeQex9YENjG3dRMG/rxV8Qw61eS6y3V3CR
         xojgdutKGHB41BRsG+0XPGLuMcw6AE1u5PLXzUNVrsh5wHhEpZLPlISZuE51QYXL1Uon
         qDnyPqCoRpXfYqAMqoyT355n5ze+j1zTbnNdf2T1A+C+VzqQ/x33AXEdkMrXV+B3JlVN
         JBzamrttwMc9P/X3eNMrwXdmi1GPut4SahNfyApdEyb2+W8DocdcfRM5Thqo+kv4dmpa
         C43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710234194; x=1710838994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6i3TaLouGAS+GfFlJ9J9LI/0HUB7fKxpK6hNinsoOw=;
        b=VFbKJ/+LqCUjxR0cr7iKZOUwrgQdzOwewyyeEz59DvCZIAHfeW//b1ZkDbqr/Exytv
         erwixACbmCLqORLeMJjXiOvfzFGvB4LftaLNGSOD8aV3EymT55k1QjmDcuyl1kbt/Dwy
         rnfHxd0swbHGuwGa+wHusF3nZxGFKGg5/1hP0//Rtax5pdWzJB8craP8Bfh+C8VAQPKD
         csK3BspB9CH9pjvedRTTUzBuMT1zmJh655myaZY0EVrESH4iEKI7BHxp1zcRfxsglxGv
         AAxiDOFDUEEMit4QhOm33ttgUsarBYrWZ491xkRQtg3sRB1DSfgF/1Sq8Hrn7x5RjVrB
         1PeA==
X-Forwarded-Encrypted: i=1; AJvYcCWCu4qpn/0xF8J4bk2ZUlib98i9wd/LbZRUHhNcb8MPi6fY8LC20h7+H41FSpvKgHSEJU7qX1hx85vflIzCqm6iIqH1dheVlNxqexaJ
X-Gm-Message-State: AOJu0YxIOVZcvX8ZQgqfAqzCpC+csUJz3kVYwArwxJQQxVeennmeXmyF
	fS51JyLiTQkO2SzF9RxdYiz96Q2PegTC3txB2CqjtTuTAFkRY/y3nV+NT9xURAI=
X-Google-Smtp-Source: AGHT+IGdtm50SLGxk2hDpFRAfup4txP1asLzv4Joh/YOzp2qyBoqbm6d1pprOfLQaSq5NS65zoeS+w==
X-Received: by 2002:a17:906:11da:b0:a44:dc35:df19 with SMTP id o26-20020a17090611da00b00a44dc35df19mr2047419eja.67.1710234194076;
        Tue, 12 Mar 2024 02:03:14 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id hg13-20020a1709072ccd00b00a45fefe4fc5sm3576879ejc.135.2024.03.12.02.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 02:03:13 -0700 (PDT)
Date: Tue, 12 Mar 2024 12:03:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Felix N. Kimbu" <felixkimbu1@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: p80211conv: Rename local foo to decrypt_check
Message-ID: <9bffd12a-afae-45cd-a4f3-451872146bf3@moroto.mountain>
References: <Ze9Ie67PCSvBU+og@MOLeToid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ze9Ie67PCSvBU+og@MOLeToid>

On Mon, Mar 11, 2024 at 07:07:55PM +0100, Felix N. Kimbu wrote:
> @@ -185,14 +185,14 @@ int skb_ether_to_p80211(struct wlandevice *wlandev, u32 ethconv,
>  		p80211_wep->data = kmalloc(skb->len, GFP_ATOMIC);
>  		if (!p80211_wep->data)
>  			return -ENOMEM;
> -		foo = wep_encrypt(wlandev, skb->data, p80211_wep->data,
> -				  skb->len,
> -				  wlandev->hostwep & HOSTWEP_DEFAULTKEY_MASK,
> -				  p80211_wep->iv, p80211_wep->icv);
> -		if (foo) {
> +		decrypt_check = wep_encrypt(wlandev, skb->data, p80211_wep->data,
> +				  					skb->len,
> +									wlandev->hostwep & HOSTWEP_DEFAULTKEY_MASK,
> +									p80211_wep->iv, p80211_wep->icv);

With the rename the indenting did need to be updated, yes.  However it
should have been:

		decrypt_check = wep_encrypt(wlandev, skb->data, p80211_wep->data,
				  	    skb->len,
					    wlandev->hostwep & HOSTWEP_DEFAULTKEY_MASK,
					    p80211_wep->iv, p80211_wep->icv);

[tab][tab][tab][tab][tab][space][space][space][space]skb->len,

See my blog for how to resend a patch:
https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

regards,
dan carpenter


