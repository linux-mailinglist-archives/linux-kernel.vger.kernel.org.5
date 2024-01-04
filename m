Return-Path: <linux-kernel+bounces-17308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA482824B2F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 23:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45ABB1F221C3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EF02D03B;
	Thu,  4 Jan 2024 22:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9CXiraW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FFE2CCBA;
	Thu,  4 Jan 2024 22:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d5ac76667so7444465e9.1;
        Thu, 04 Jan 2024 14:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704408562; x=1705013362; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q4pnsNw+NuNUhm4UP8Hiirnu7xvke/Sxw6O837o0pn8=;
        b=I9CXiraWr/AVS5ebNxEc1XrxLv/Kzas6jiN3Itqc3HeAu/aRXw9KF/osCAZs9xFcN6
         idHcoJYyD7DDP63wbTnsbsFc33nbuZw4pFtsTsX+ALks+Fg6wT6jW3aJrfSVjvGeLYb2
         iPTghWXREGD1BOXSnC7f3p/G+wRkTG6OgRFWexul4HtlDxFVUmxFaC2W08EttmgemH+U
         ajz8bzPpUXNKoWHq2hS1U3QKK0TpVviFq/ZvCEERvauuWhpeCjPdMGiT6rrEbERnyI03
         /JA3djs/9qZSjYtPrgbUh+Ycl16Hb6cBAaeoVrz50Jlx/Y+dL0E+QfAWVYqetVjg0p8u
         1igw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704408562; x=1705013362;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q4pnsNw+NuNUhm4UP8Hiirnu7xvke/Sxw6O837o0pn8=;
        b=TYUY+RdWrI4uW3juaioUQQ1p+N91JYS07BJveTl5/SbAskIMvrudFzBJqLzpZu0skn
         4LoDLypt788zU3wHbhlv9lzotKEck8yIdbdtV/b4FgCMJDTZdYFKDziIUeZUbj4tijk4
         9RwAbMR6k7+PWbV8Y+jkLQfKhwY47IGs5LU3qjX954QMoVlQq84ZeyNJwilRSI2cvsUN
         mPKo7WHO3Ud6jGay+Or62g2BAePufPDmFIZJkwD5BYH3MjnmOwMtg0B/hx9IodKPNnLn
         /t4WlsZj3uG7vVsBhHbEIhFOTYiosTzEUjjT6iYZQ6Mv4s5oiF00QkpbGH6cxqLzmwQ1
         +bGA==
X-Gm-Message-State: AOJu0Yz91W0n6AttuE3TK/iYDVY17gPKyKTba3KYKTdvmmwF9U4xyWqK
	KyHEe75oJXY2CIYBEZ2olPWI8WIt1Z8=
X-Google-Smtp-Source: AGHT+IHdPuuD6alviTC5BtK7t1Py2xB/EyT3EEbSH87WcJvg/r8ZVZt4CzVnI8cstq8/SQxOq1MiYQ==
X-Received: by 2002:a05:600c:4444:b0:40c:909:fdb4 with SMTP id v4-20020a05600c444400b0040c0909fdb4mr771798wmn.90.1704408562141;
        Thu, 04 Jan 2024 14:49:22 -0800 (PST)
Received: from Ansuel-xps. (host-80-116-159-187.pool80116.interbusiness.it. [80.116.159.187])
        by smtp.gmail.com with ESMTPSA id l33-20020a05600c1d2100b0040d6e07a147sm537022wms.23.2024.01.04.14.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 14:49:21 -0800 (PST)
Message-ID: <659735f1.050a0220.efb5.1c0d@mx.google.com>
X-Google-Original-Message-ID: <ZZc05lSfYNheJq9Z@Ansuel-xps.>
Date: Thu, 4 Jan 2024 23:44:54 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Jonghwa Lee <jonghwa3.lee@samsung.com>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [RESEND PATCH 1/2] PM / devfreq: Fix buffer overflow in
 trans_stat_show
References: <20240104215521.10772-1-ansuelsmth@gmail.com>
 <9d57f4ea-67d1-48b5-92df-c5556f95f5d6@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d57f4ea-67d1-48b5-92df-c5556f95f5d6@wanadoo.fr>

On Thu, Jan 04, 2024 at 11:19:44PM +0100, Christophe JAILLET wrote:
> Le 04/01/2024 à 22:55, Christian Marangi a écrit :
> > Fix buffer overflow in trans_stat_show().
> > 
> > Convert simple snprintf to the more secure scnprintf with size of
> > PAGE_SIZE.
> > 
> > Add condition checking if we are exceeding PAGE_SIZE and exit early from
> > loop. Also add at the end a warning that we exceeded PAGE_SIZE and that
> > stats is disabled.
> > 
> > Return -EFBIG in the case where we don't have enough space to write the
> > full transition table.
> > 
> > Also document in the ABI that this function can return -EFBIG error.
> > 
> > Cc: stable@vger.kernel.org
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218041
> > Fixes: e552bbaf5b98 ("PM / devfreq: Add sysfs node for representing frequency transition information.")
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >   Documentation/ABI/testing/sysfs-class-devfreq |  3 +
> >   drivers/devfreq/devfreq.c                     | 57 +++++++++++++------
> >   2 files changed, 42 insertions(+), 18 deletions(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-class-devfreq b/Documentation/ABI/testing/sysfs-class-devfreq
> > index 5e6b74f30406..1e7e0bb4c14e 100644
> > --- a/Documentation/ABI/testing/sysfs-class-devfreq
> > +++ b/Documentation/ABI/testing/sysfs-class-devfreq
> > @@ -52,6 +52,9 @@ Description:
> >   			echo 0 > /sys/class/devfreq/.../trans_stat
> > +		If the transition table is bigger than PAGE_SIZE, reading
> > +		this will return an -EFBIG error.
> > +
> >   What:		/sys/class/devfreq/.../available_frequencies
> >   Date:		October 2012
> >   Contact:	Nishanth Menon <nm@ti.com>
> > diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> > index 63347a5ae599..8459512d9b07 100644
> > --- a/drivers/devfreq/devfreq.c
> > +++ b/drivers/devfreq/devfreq.c
> > @@ -1688,7 +1688,7 @@ static ssize_t trans_stat_show(struct device *dev,
> >   			       struct device_attribute *attr, char *buf)
> >   {
> >   	struct devfreq *df = to_devfreq(dev);
> > -	ssize_t len;
> > +	ssize_t len = 0;
> >   	int i, j;
> >   	unsigned int max_state;
> > @@ -1697,7 +1697,7 @@ static ssize_t trans_stat_show(struct device *dev,
> >   	max_state = df->max_state;
> >   	if (max_state == 0)
> > -		return sprintf(buf, "Not Supported.\n");
> > +		return scnprintf(buf, PAGE_SIZE, "Not Supported.\n");
> 
> Hi,
> 
> maybe using  sysfs_emit_at() could be even cleaner and less verbose?
>

If you notice this change is done in the second patch of the series.
This patch still use this more generic way to permit this to be
backported on stable kernel. (older kernel doesn't have sysfs_emit_at()
hence it can't be backported)

> >   	mutex_lock(&df->lock);
> >   	if (!df->stop_polling &&
> > @@ -1707,31 +1707,52 @@ static ssize_t trans_stat_show(struct device *dev,
> >   	}
> >   	mutex_unlock(&df->lock);
> > -	len = sprintf(buf, "     From  :   To\n");
> > -	len += sprintf(buf + len, "           :");
> > -	for (i = 0; i < max_state; i++)
> > -		len += sprintf(buf + len, "%10lu",
> > -				df->freq_table[i]);
> > +	len += scnprintf(buf + len, PAGE_SIZE - len, "     From  :   To\n");
> > +	len += scnprintf(buf + len, PAGE_SIZE - len, "           :");
> > +	for (i = 0; i < max_state; i++) {
> > +		if (len >= PAGE_SIZE - 1)
> > +			break;
> > +		len += scnprintf(buf + len, PAGE_SIZE - len, "%10lu",
> > +				 df->freq_table[i]);
> > +	}
> > +	if (len >= PAGE_SIZE - 1)
> > +		return PAGE_SIZE - 1;
> > -	len += sprintf(buf + len, "   time(ms)\n");
> > +	len += scnprintf(buf + len, PAGE_SIZE - len, "   time(ms)\n");
> >   	for (i = 0; i < max_state; i++) {
> > +		if (len >= PAGE_SIZE - 1)
> > +			break;
> 
> I'm not sure that adding all these tests is needed. It could save some
> cycles in the worse case (when buf could overflow), but in fact wastes
> cycles in the normel case.
>

Consider that cpufreq stats does the same exact checks and I feel the 2
thing should be equal (given they do the same exact task)

Also with case of -EBIG, I would expact the thing to be very big and
exiting early might be beneficial, for normal stats I would expact only
a few cycle added. Myabe we can reduce them just for the for cycle?

> >   		if (df->freq_table[i] == df->previous_freq)
> > -			len += sprintf(buf + len, "*");
> > +			len += scnprintf(buf + len, PAGE_SIZE - len, "*");
> >   		else
> > -			len += sprintf(buf + len, " ");
> > +			len += scnprintf(buf + len, PAGE_SIZE - len, " ");
> > +		if (len >= PAGE_SIZE - 1)
> > +			break;
> > +
> > +		len += scnprintf(buf + len, PAGE_SIZE - len, "%10lu:",
> > +				 df->freq_table[i]);
> > +		for (j = 0; j < max_state; j++) {
> > +			if (len >= PAGE_SIZE - 1)
> > +				break;
> > +			len += scnprintf(buf + len, PAGE_SIZE - len, "%10u",
> > +					 df->stats.trans_table[(i * max_state) + j]);
> > +		}
> > +		if (len >= PAGE_SIZE - 1)
> > +			break;
> > +		len += scnprintf(buf + len, PAGE_SIZE - len, "%10llu\n", (u64)
> > +				 jiffies64_to_msecs(df->stats.time_in_state[i]));
> > +	}
> > -		len += sprintf(buf + len, "%10lu:", df->freq_table[i]);
> > -		for (j = 0; j < max_state; j++)
> > -			len += sprintf(buf + len, "%10u",
> > -				df->stats.trans_table[(i * max_state) + j]);
> > +	if (len < PAGE_SIZE - 1)
> > +		len += scnprintf(buf + len, PAGE_SIZE - len, "Total transition : %u\n",
> > +				 df->stats.total_trans);
> > -		len += sprintf(buf + len, "%10llu\n", (u64)
> > -			jiffies64_to_msecs(df->stats.time_in_state[i]));
> > +	if (len >= PAGE_SIZE - 1) {
> > +		pr_warn_once("devfreq transition table exceeds PAGE_SIZE. Disabling\n");
> > +		return -EFBIG;
> >   	}
> > -	len += sprintf(buf + len, "Total transition : %u\n",
> > -					df->stats.total_trans);
> >   	return len;
> >   }
> 

-- 
	Ansuel

