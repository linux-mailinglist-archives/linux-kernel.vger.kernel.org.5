Return-Path: <linux-kernel+bounces-73181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA3685BEC7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB20F283FC5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C45E6931F;
	Tue, 20 Feb 2024 14:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEmzax39"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9619E6BFA6;
	Tue, 20 Feb 2024 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708439408; cv=none; b=YFyrkzHoiXaZED0i0Zm8s5K4LmxxCq/py+DEnk0+rXSI+UZ52Scjtgt4Zm3nYASfdWIaPFEGRxIdN3F2SGc9m8vtT1aExGkaYBpmwWbH34mC2cgSVEdQDBCoUF0bIXXdQsiNSQuM8GfQE/auK+BeL7Kb4ToZf/nR47aAr/v8hLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708439408; c=relaxed/simple;
	bh=kCC+/P3Nj2JnOo1gfaMulUtZi5pAMzb/Kw6pVZnejfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqNVJb+e246dX+kNnGNHLYK8riMgucYRZG9nEQ7vf7vjaV4aQeAtaAAcKQWSgo3v8OWIsd7ua4fp+MQAJx8EsWDyYpldxIQM7t5+v8MaoMO8joqjVHvnKOc46O1GTcORC+O0sW630cXOCu195MMMFAocBM+82gZNL6OMiT01ah8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEmzax39; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dc09556599so12600135ad.1;
        Tue, 20 Feb 2024 06:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708439405; x=1709044205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pRExbOMqiEoLmXAtACAYPejQABgPL5OppUy7KElQRYI=;
        b=gEmzax39pveO3HFBCmgK1F59RxzcZq8bKMOdRVQXd5hack20rKMrLHaXo1/eRC3cuz
         w4MUPZMybAJ5KsKUC9Bfh9dN9wrTv5ovuxTzqI9pf2uQQ6Cmhk/H/QdBg4fIxQRsCVZU
         TGFndVHCOw1cDBS9Vlm7FAgKQPycMs86DJ1ZguBtzbzdEOCzuAQMNHgqnyrGF7DMyc72
         4WJISqW4cn7sf0oXB12WwYGFvHrjHpY0mBMb/Qn/K/jEKc5EcDkMgxYyVngUGjY/msz+
         5kn2gBkyiohhluA0LFFI/j4xjypCE2a2tOqDzwyRl07kKtYn2MxiK6RUqqEhCAtYUyXb
         CsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708439405; x=1709044205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRExbOMqiEoLmXAtACAYPejQABgPL5OppUy7KElQRYI=;
        b=hwoX39ueu9NnFWkfjTqyW6635W4ymr1pRr99MLa0raFSrgT7RZOScTiyp5qFCn7/92
         0KPEgQ1O8mQiecpxIndCyYMdqdAQEidRKhgY83JOCddkRG16Nv0nd7Vw0+nFJ8iB6o5k
         7A11Ppt1owh3rL3QBjVcxd2rJ/lBsrnF/4633JQXxsZuxmJnAsQqYAkyUIrTSarCC+2S
         teUK2rY4AOrgDale7jjLNGadKrH0WUDYLltN6wFxc3JOfaeZbEDwRaNg3L1DtGOaXXF/
         CzujBYz2lG3PnqWXPbjnan1c4LtqJY8E4mk1ga5F+nNr9/5XvoEhV7t50Sx05U2xys4I
         qNAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXS4SbFuAmxlcXmyFVsy6SCEm9J20HBjSD+X4juqXwZyTM42at52MR7YMOS/4oz1k/RDdeB7z/DVFPCojbsT1GFLWAVvlxp/DmZUJCzjc6BctZgcU60TvVML9R2dn713Y/HoOdWnO7pNQ==
X-Gm-Message-State: AOJu0Yzlsaj13WZj3E+msk5ZbktT6hgjaZqfkk/PolKMCqMxKHthmKj8
	Mi4kmPOWUTN3e0c4pGu75uwpfwnTEBn7cwsWJ5RnB5ahGE9OWxL+cATWPHnM
X-Google-Smtp-Source: AGHT+IF8TMLRs1yKdDmrJqZnPpYffOuK/Fk+GEdHFW8aOevvloelfRNO3bitFFZjEUPFcA4aaCQzSg==
X-Received: by 2002:a17:902:cec2:b0:1da:eed:f25b with SMTP id d2-20020a170902cec200b001da0eedf25bmr20477292plg.46.1708439404655;
        Tue, 20 Feb 2024 06:30:04 -0800 (PST)
Received: from rigel ([220.235.35.85])
        by smtp.gmail.com with ESMTPSA id e17-20020a17090301d100b001d720a7a616sm6231730plh.165.2024.02.20.06.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 06:30:04 -0800 (PST)
Date: Tue, 20 Feb 2024 22:29:59 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/2] gpiolib: cdev: release IRQs when the gpio chip
 device is removed
Message-ID: <20240220142959.GA244726@rigel>
References: <20240220111019.133697-1-herve.codina@bootlin.com>
 <20240220111019.133697-3-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220111019.133697-3-herve.codina@bootlin.com>

On Tue, Feb 20, 2024 at 12:10:18PM +0100, Herve Codina wrote:
> When gpio chip device is removed while some related gpio are used by the
> user-space, the following warning can appear:
>   remove_proc_entry: removing non-empty directory 'irq/233', leaking at least 'gpiomon'
>   WARNING: CPU: 2 PID: 72 at fs/proc/generic.c:717 remove_proc_entry+0x190/0x19c
>   ...
>   Call trace:
>     remove_proc_entry+0x190/0x19c
>     unregister_irq_proc+0xd0/0x104
>     free_desc+0x4c/0xc4
>     irq_free_descs+0x6c/0x90
>     irq_dispose_mapping+0x104/0x14c
>     gpiochip_irqchip_remove+0xcc/0x1a4
>     gpiochip_remove+0x48/0x100
>   ...
>
> Indeed, the gpio cdev uses an IRQ but this IRQ is not released when the
> gpio chip device is removed.
>
> Release IRQs used in the device removal notifier functions.
> Also move one of these function definition in order to avoid a forward
> declaration (move after the edge_detector_stop() definition).
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  drivers/gpio/gpiolib-cdev.c | 33 ++++++++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index 2a88736629ef..aec4a4c8490a 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -688,17 +688,6 @@ static void line_set_debounce_period(struct line *line,
>  	 GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE | \
>  	 GPIO_V2_LINE_EDGE_FLAGS)
>
> -static int linereq_unregistered_notify(struct notifier_block *nb,
> -				       unsigned long action, void *data)
> -{
> -	struct linereq *lr = container_of(nb, struct linereq,
> -					  device_unregistered_nb);
> -
> -	wake_up_poll(&lr->wait, EPOLLIN | EPOLLERR);
> -
> -	return NOTIFY_OK;
> -}
> -
>  static void linereq_put_event(struct linereq *lr,
>  			      struct gpio_v2_line_event *le)
>  {
> @@ -1189,6 +1178,23 @@ static int edge_detector_update(struct line *line,
>  	return edge_detector_setup(line, lc, line_idx, edflags);
>  }
>
> +static int linereq_unregistered_notify(struct notifier_block *nb,
> +				       unsigned long action, void *data)
> +{
> +	struct linereq *lr = container_of(nb, struct linereq,
> +					  device_unregistered_nb);
> +	int i;
> +
> +	for (i = 0; i < lr->num_lines; i++) {
> +		if (lr->lines[i].desc)
> +			edge_detector_stop(&lr->lines[i]);
> +	}
> +

Firstly, the re-ordering in the previous patch creates a race,
as the NULLing of the gdev->chip serves to numb the cdev ioctls, so
there is now a window between the notifier being called and that numbing,
during which userspace may call linereq_set_config() and re-request
the irq.

There is also a race here with linereq_set_config().  That can be prevented
by holding the lr->config_mutex - assuming the notifier is not being called
from atomic context.

You also have a race with the line being freed that could pull the
lr out from under you, so a use after free problem.
I'd rather live with the warning :(.
Fixing that requires rethinking the lifecycle management for the
linereq/lineevent.

Cheers,
Kent.

> +	wake_up_poll(&lr->wait, EPOLLIN | EPOLLERR);
> +
> +	return NOTIFY_OK;
> +}
> +
>  static u64 gpio_v2_line_config_flags(struct gpio_v2_line_config *lc,
>  				     unsigned int line_idx)
>  {
> @@ -1898,6 +1904,11 @@ static int lineevent_unregistered_notify(struct notifier_block *nb,
>  	struct lineevent_state *le = container_of(nb, struct lineevent_state,
>  						  device_unregistered_nb);
>
> +	if (le->irq) {
> +		free_irq(le->irq, le);
> +		le->irq = 0;
> +	}
> +
>  	wake_up_poll(&le->wait, EPOLLIN | EPOLLERR);
>
>  	return NOTIFY_OK;
> --
> 2.43.0
>

