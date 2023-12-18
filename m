Return-Path: <linux-kernel+bounces-4144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED352817869
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A470282A1C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394B15A858;
	Mon, 18 Dec 2023 17:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N33tRL+n"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2318F5A86C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 17:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40c39ef63d9so37934055e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 09:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1702919874; x=1703524674; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+RiatOxWl7xAZWtyNTIV4d75IqQQcquTpnxuK7jcUgw=;
        b=N33tRL+nciBFzOdHuav1/iNlHhCk56oTonaxVbZ82GJ3+Ke+ji+GaxfgI8+gPPClr8
         qcYx0XgRA7yKFa11hAAK5vABUxOW4wciDY+u2kAZnhV1Uwekvd4v1D7GpCLGoq6uRa/H
         3+IOjInU7nB/WNbADHAowhSMbadOIbn2Ww6U9b2xkJPORJIszxfspO/M8WuPqBcUWH9a
         sxL4TWsBMqSea9NsuqqpvlpqX809juWuujPUVzgeQugJyRj4gW1cC6Z4viMQgfSLHGVg
         1RPesfetMzqEcQdDXn1yS0b80kKiFO7epblgIPOB6659oKxhhBvid5kH39AeKqrYfLpG
         GuTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702919874; x=1703524674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RiatOxWl7xAZWtyNTIV4d75IqQQcquTpnxuK7jcUgw=;
        b=EFCHwCEE9LNo0g4iY0ZMgPW9MuZ322AXXhDIHecV4rjJNPYLsI2DaxVyBO4SJEuWDA
         ldtJwCToIJy86By2HvDNfw/aHD48R12b7FFTBX0TfUHPDYrgfxd5L2iZMFwcvjVdVimn
         Mc+zILhTcSsxWR0U8Y9t7GJHqEanWVUL8+DdcW0j5mRPG2+DBGesoVdhyyriuSdTfLjT
         gGjC5C7rqDGW1pOJ501KPMo6K+aay+7S1bf1G2Wa5/M6ZmjWmkyFPd0yLonNeh3QWQts
         99RERp45EUahwR4KuorEfJTxZrE6PrVT7CMdQz+2onzDTPHcj92qrg1+QTrW5khmRPyN
         EhMg==
X-Gm-Message-State: AOJu0YylIFKy0LhOmZvk9BmA2c034h42IB/UMzSsz67x/YZYOA4T4p2/
	/jWDlP9I7raWG1JASk0BajmjoQ==
X-Google-Smtp-Source: AGHT+IEwMIliHjC7iDOY1o8HNidpbat+gS3Pxad96ksfnGAW6fAfE2D4bdRiYKvy1U+cZv33BWBEoQ==
X-Received: by 2002:a7b:c849:0:b0:40b:3d9f:eedf with SMTP id c9-20020a7bc849000000b0040b3d9feedfmr8947312wml.15.1702919874353;
        Mon, 18 Dec 2023 09:17:54 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id q20-20020a17090622d400b00a2359ea1072sm1300517eja.38.2023.12.18.09.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 09:17:54 -0800 (PST)
Date: Mon, 18 Dec 2023 18:17:51 +0100
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
Subject: Re: [re: PATCH v2 00/15 -  07/11] dyndbg: __skip_spaces
Message-ID: <ZYB-v4Vp1mj-jVl_@alley>
References: <CAK8ByeK8dGcbxfXghw6=LrhSWLmO0a4XuB8C0nsUc812aoU0Pw@mail.gmail.com>
 <cover.1701993656.git.jim.cromie@gmail.com>
 <bdc86387d74ea059d04f301df414ee3d6564634d.1701993656.git.jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdc86387d74ea059d04f301df414ee3d6564634d.1701993656.git.jim.cromie@gmail.com>

On Thu 2023-12-07 17:15:10, Jim Cromie wrote:
> This private version treats a comma like a space.

Please, make it clear that this patch adds a new function.
Also please explain why it is needed and what are the effects.

> Its not known necessary ATM, but seems prudent.

It might be that I am not a native speaker but I can't parse
the above sentence at all.

What is not known?
What is prudent?


> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>  lib/dynamic_debug.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index a380b8151dd8..c974f6e19ca1 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -628,6 +628,14 @@ static int ddebug_change(const struct ddebug_query *query,
>  	return nfound;
>  }
>  
> +char *__skip_spaces(const char *str)
> +{
> +	str = skip_spaces(str);
> +	if (*str == ',')
> +		str = skip_spaces(++str);
> +	return (char *)str;
> +}

The function should not be called "skip_spaces" when it skips also
characters which are not typical white-space characters.

Also the "__" are usually used the other way around. func()
is usually a wrapper around __func().

Please, use another name. If you can't find a good name then
it suggests that the design is bad. The result would likely
be hard to understand and maintain.

Best Regards,
Petr

PS: I am sorry, I do not have time for a proper review. I primary wanted
    to check if the patchset somehow affected printk(). And I realized
    that I do not understand what the changes are about. The commit
    messages and the motivation might make sense only to people who
    know the big picture. But I was not able to get the picture
    for the changes in dot,comma,space handling.

