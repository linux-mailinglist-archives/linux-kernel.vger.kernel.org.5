Return-Path: <linux-kernel+bounces-4069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6D6817795
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C97E7284BAC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438121E520;
	Mon, 18 Dec 2023 16:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gBNGgbyo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B051498BC
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 16:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40c339d2b88so36876805e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1702917254; x=1703522054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/rOppEuE9fe8jK025Yd36IdkiDsieSocMieD2PWZmg8=;
        b=gBNGgbyoUVijHfkMRibg3eWKqGWsqzlwR99xEr8v1/i07O0NW9XMK+CdWUzLAFBeDk
         3RaxsPpsX8Kj5cY52QVXjP2pCDzT4f3L5WxYoYSROoi/lVNcg6ym9WemLY12XYAA3Hb4
         L4fknAj2sifpanUvHjqzBfIxvegqKLF4NmpIJnOegcsIYRa7U75B5xgOIpgHZxyasQLE
         WbxrTkw+UaIJXN1EKKwmXCi+tGL4cVe96JGvdqEw+a09DT5v4S4q4zRPERhCOraFwDOn
         i4RN9iMULFBUlEJDpM2LnTHCHu1k+zMS1Dx0UUdpucsFGr2vc55EvAPDqHTc8ATD1aQ4
         81Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702917254; x=1703522054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rOppEuE9fe8jK025Yd36IdkiDsieSocMieD2PWZmg8=;
        b=I/iIBKZPDBJr5NjYe6NUt4IYI4eHwYfTl/0NNjjjcTXxCnHb2n8hRoGnw5yyd0oKra
         5jtYZ/Stc0c9HLQHvcWPVfj3z/6EkiIqb5NNDWeyXIiDqJZlo+/skmNYUqBFylDJcttG
         D9iiGxGyWSlf1mA7nfQXQux68xWzs6IiJ4XAfHDiLxeHAJ9NfY6+vXR2m46D/OTbCIR2
         Tu/K1cHuTcFWH0lfrmGAV1+M4MQvhWDGyF1tfi4zHIgseyvWT5e/mjoUCy5+ZCVIL5Sy
         Ht8swBHeE7jhh9maDlD7SZA+BG42TyuImAZLuTuExjvGpQ6zD0MKP7aDuKIO7nGKQw4n
         p7hA==
X-Gm-Message-State: AOJu0YzDAC1EDk4R+knUdYw87xboiXreZCVRakgsKI1SplmoCPanWmSt
	84VzEYtIhVHwQPsB6gs/aC+IYw==
X-Google-Smtp-Source: AGHT+IFgaUxBTqFKKtJeHzKpC/cBQB8gSB2dVjVuKhQguEwkv9LiA+Ha7V379VzvROHOEZGQbuAe9A==
X-Received: by 2002:a05:600c:54c1:b0:40b:5e21:e263 with SMTP id iw1-20020a05600c54c100b0040b5e21e263mr8508945wmb.80.1702917254225;
        Mon, 18 Dec 2023 08:34:14 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id ts7-20020a170907c5c700b00a1b65cd1957sm14343131ejc.107.2023.12.18.08.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 08:34:13 -0800 (PST)
Date: Mon, 18 Dec 2023 17:34:11 +0100
From: Petr Mladek <pmladek@suse.com>
To: Jim Cromie <jim.cromie@gmail.com>
Cc: lb@semihalf.com, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, bleung@google.com, contact@emersion.fr,
	daniel@ffwll.ch, dianders@chromium.org, groeck@google.com,
	jbaron@akamai.com, john.ogness@linutronix.de, keescook@chromium.org,
	ppaalanen@gmail.com, rostedt@goodmis.org, seanpaul@chromium.org,
	sergey.senozhatsky@gmail.com, upstream@semihalf.com,
	vincent.whitchurch@axis.com, yanivt@google.com,
	gregkh@linuxfoundation.org
Subject: Re: [re: PATCH v2 00/15 -  03/11] dyndbg: disambiguate quoting in a
 debug msg
Message-ID: <ZYB0gyz-2M3k2kbD@alley>
References: <CAK8ByeK8dGcbxfXghw6=LrhSWLmO0a4XuB8C0nsUc812aoU0Pw@mail.gmail.com>
 <cover.1701993656.git.jim.cromie@gmail.com>
 <674f65e71c5c3e874b6b72b6f9d8cdd7a091b6d0.1701993656.git.jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <674f65e71c5c3e874b6b72b6f9d8cdd7a091b6d0.1701993656.git.jim.cromie@gmail.com>

On Thu 2023-12-07 17:15:06, Jim Cromie wrote:
> When debugging a query parsing error, the debug message wraps the
> query in escaped-double-quotes.  This is confusing when mixed with any
> quoted args where quotes are stripped by the shell.
> 
> So this replaces the \"%s\" with <%s> in the format string, allowing a
> user to see how the shell strips quotes:
> 
> lx]# echo  module "foo" format ,_ -f > /proc/dynamic_debug/control
> [  716.037430] dyndbg: read 26 bytes from userspace
> [  716.037966] dyndbg: query 0: <module foo format ,_ -f> on module: <*>

Could you provide a real life example, please? It is hard to imagine
what '"foo" format' means in a real life.

Also could you please provide output before and after?

Honestly, Using <> as quotes looks pretty non-standard and confusing
to me. Also this changes only one place but '\"' is used in many
other locations which would make dyndbg messages even more confusing.

I do not understand how this would help. The double quote is gone
even in this variant.

BTW: It is a bit funny that this patch is supposed to make the debug
     message better readable. For me, the echo command is hard
     to read in the first place. I would use:

lx]# echo "module $my_module ,_ -f" > /proc/dynamic_debug/control

Maybe, this change fixes the output to match some personal style.
I wonder how common is the style. I can't remember seeing:

    $> echo param param param

Instead I frequently see:

    $> echo "bla bla bla".

Best Regards,
Petr

