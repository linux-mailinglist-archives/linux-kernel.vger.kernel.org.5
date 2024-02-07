Return-Path: <linux-kernel+bounces-55914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BEF84C352
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361481C24534
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF131095C;
	Wed,  7 Feb 2024 03:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVm909qd"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA8F18B1B;
	Wed,  7 Feb 2024 03:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707278105; cv=none; b=jGnsRACt/YOHbUuhWAAo4khKRDgpcovHz17eUcZVu0VdsOvQ6QgW+80utROtdGQ7f9XqaFWlJ+R5RipCE3SrKnNcBYp2LclzPe1wkXGwWU/c2Drv3XAwHMXg6KRVHVRFRwfDmVWmM8af5VkmpHMu+T/JH6pd5vUZnBQxllZUXhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707278105; c=relaxed/simple;
	bh=alq/Epsr8DHJ6MiKVlHW4MkuUuZ14dHFXS5+zhvZRtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEfEG3yvIOllobNE1a1wUSeuZwiYrQNLBpukkv+buqbMzYdopktO3KEbIYapHvis16wCvzlxMY61/6LOWoNysod5e/otjtCIbLMXBFgluQHzP4xPOY0LDfirS1rz2h7DvCMfxDFNg2a2h6Ju6sDWUnlCELLBuNEb2XMep2/19pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVm909qd; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e0518c83c6so165111b3a.0;
        Tue, 06 Feb 2024 19:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707278103; x=1707882903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JSUyVN+zMp3raBZwXZBWBj6Uh3GxHdSlvMsi0/pJS9o=;
        b=PVm909qdr5KX/aJqFn5Bp3f9bl/942ea1pcTOLqI7jcaVPFQSWly7veTrs4IWkf97D
         fwAaXz3k0CU/o6E4vUJkVOdgPiPWyG4OvbXO4kEmAg3cHCikWH1J3ika9vwSH10clwGE
         5Xyq9jPFoX6Kh2ATGgYTOqjilW6THoTfiKZBQU/K69kYs+/FnhcdLfSjDplkShq/j8Y1
         ldbY7ajyhEUEo6OIJb+u4Gqfcc1koSJqzcx+DLpvPa53so/3kfNeJ96JxahfFHCgIL1B
         +B9AuMC1yNytf4PJFXefN3XTmGUyA1G7Ag+QboGYX9GDSisCGQvlMsFM7ALv500WNB1r
         0iLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707278103; x=1707882903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSUyVN+zMp3raBZwXZBWBj6Uh3GxHdSlvMsi0/pJS9o=;
        b=hUskIdVp6Yps8htHuFtq8ubIXgE9gYuJ8xpEOuryfKcabAvwpcPniKt53z2w73XYvu
         wMx91gKjk+MPxCsShHkc8aqckheXzBgIwK075icRhTvLtDQVvsW6Dyfp+zHcXrdsYSQP
         RV7+geX4U5tclXbdIcoiRDhKw+NLrOjbzWwDEjqe2Dxq/Hpsfevk9yX4XAZWOzCM8g57
         wahR7DjmcZAQnDz3Cz+ZbiZVZBiuobgIpki5d83tdA05r3DyNrvMHkW1mG6+79YcJORN
         L/vC9TqqRhLftVu2fxeSGfg9uKAC2B36W2VC0mwnwmnRuSHY8Zrv29RcNCjH5XMw+lTO
         hYXQ==
X-Gm-Message-State: AOJu0Yyhc7U0/h11wnwEx05SdMoDAjKVZrFydILqBDaELXOVnQpHZGk3
	kIIh/cs7VAJN5izJ+I88lPWERP4R+5gMXsV9/v1xzAULv+/fL13u
X-Google-Smtp-Source: AGHT+IE77kv+k+lKKaVFPON9Wzu5mHAhJc9Oql5lwp9BjmydfTLfoVFhv31rzQNN9LT8w5l/k36BSA==
X-Received: by 2002:a62:cecd:0:b0:6df:f7f3:6197 with SMTP id y196-20020a62cecd000000b006dff7f36197mr1466287pfg.34.1707278103141;
        Tue, 06 Feb 2024 19:55:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVqHuxjtbSzNSU678YJfPEy0Dm3uCr7fqpRRK0RY3PTWJoBpT4vA5ftnW3BwbXhdkawge7zNn0K+3tQtp2TFkKz411lLj2fhOY1tjUhVJwTWX5aBeqr5ZBVVt3JGguGRdiiUftD4gicbv+KrELWBCXyfqg2GJHrdbGoBzSBrRQOMqZh50E5YuVWNg5hpuKKjTVuNo20dkyFzezJHUxSGAMF37r7ev1VDSkT/cbOId3939YqUL8CNTX3WL0IcA2t3WZZOzssTwMVVGieZ7aZzImmZBVpgKivuVX7
Received: from DESKTOP-KA7F9LU.localdomain ([2406:7400:63:f7c5:bcc2:8f62:f66c:2f62])
        by smtp.gmail.com with ESMTPSA id z1-20020aa79901000000b006e063fe6b1dsm310759pff.100.2024.02.06.19.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 19:55:02 -0800 (PST)
Date: Wed, 7 Feb 2024 09:24:57 +0530
From: Vimal Kumar <vimal.kumar32@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, chinmoyghosh2001@gmail.com,
	badolevishal1116@gmail.com, mintupatel89@gmail.com
Subject: Re: [PATCH v4] PM / sleep: Mechanism to find source aborting kernel
 suspend transition
Message-ID: <20240207035457.GA19804@DESKTOP-KA7F9LU.localdomain>
References: <20240205170747.19748-1-vimal.kumar32@gmail.com>
 <2024020555-usable-hardy-345e@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024020555-usable-hardy-345e@gregkh>

On Mon, Feb 05, 2024 at 07:33:17PM +0000, Greg Kroah-Hartman wrote:
> On Mon, Feb 05, 2024 at 10:37:45PM +0530, Vimal Kumar wrote:
> > Sometimes kernel suspend transitions can be aborted unconditionally by
> > manipulating pm_abort_suspend value using "hard" wakeup triggers or
> > through "pm_system_wakeup()".
> > 
> > There is no way to trace the source path of module or subsystem which
> > aborted the suspend transitions. This change will create a list of
> > wakeup sources aborting suspend in progress through "hard" events as
> > well as subsytems aborting suspend using "pm_system_wakeup()".
> > 
> > Example: Existing suspend failure logs:
> > [  349.708359] PM: Some devices failed to suspend, or early wake event detected
> > [  350.327842] PM: suspend exit
> > 
> > Suspend failure logs with this change:
> > [  518.761835] PM: Some devices failed to suspend, or early wake event detected
> > [  519.486939] PM: wakeup source or subsystem uart_suspend_port aborted suspend
> > [  519.500594] PM: suspend exit
> > 
> > Here we can clearly identify the module triggerring abort suspend.
> > 
> > Co-developed-by: Chinmoy Ghosh <chinmoyghosh2001@gmail.com>
> > Signed-off-by: Chinmoy Ghosh <chinmoyghosh2001@gmail.com>
> > Co-developed-by: Mintu Patel <mintupatel89@gmail.com>
> > Signed-off-by: Mintu Patel <mintupatel89@gmail.com>
> > Co-developed-by: Vishal Badole <badolevishal1116@gmail.com>
> > Signed-off-by: Vishal Badole <badolevishal1116@gmail.com>
> > Signed-off-by: Vimal Kumar <vimal.kumar32@gmail.com>
> > ---
> > Changes in v4:
> > - Changed GFP_KERNEL flag to GFP_ATOMIC
> > - Changed mutex_lock to raw_spin_lock
> 
> why raw?
>
 As mutex_lock might sleep, we need to use lock that is suitable for usages in atomic context. raw_spin_lock is already being used for other list in
this driver, so I used the same. If suggested we can switch to spin_lock_irqsave as well.
> 
> > ---
> >  drivers/base/power/wakeup.c | 100 +++++++++++++++++++++++++++++++++++-
> >  1 file changed, 99 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> > index a917219feea6..b04794557eef 100644
> > --- a/drivers/base/power/wakeup.c
> > +++ b/drivers/base/power/wakeup.c
> > @@ -73,6 +73,16 @@ static struct wakeup_source deleted_ws = {
> > 
> >  static DEFINE_IDA(wakeup_ida);
> > 
> > +#ifdef CONFIG_PM_DEBUG
> > +static DEFINE_RAW_SPINLOCK(pm_abort_suspend_list_lock);
> > +
> > +struct pm_abort_suspend_source {
> > +	struct list_head list;
> > +	char *source_triggering_abort_suspend;
> > +};
> > +static LIST_HEAD(pm_abort_suspend_list);
> > +#endif
> > +
> >  /**
> >   * wakeup_source_create - Create a struct wakeup_source object.
> >   * @name: Name of the new wakeup source.
> > @@ -575,6 +585,54 @@ static void wakeup_source_activate(struct wakeup_source *ws)
> > 	trace_wakeup_source_activate(ws->name, cec);
> >  }
> > 
> > +#ifdef CONFIG_PM_DEBUG
> 
> Please do not add #ifdef to .c files, this makes this file even messier.
> 
> > @@ -590,8 +648,13 @@ static void wakeup_source_report_event(struct wakeup_source *ws, bool hard)
> > 	if (!ws->active)
> > 		wakeup_source_activate(ws);
> > 
> > -	if (hard)
> > +	if (hard) {
> > +#ifdef CONFIG_PM_DEBUG
> > +		if (pm_suspend_target_state != PM_SUSPEND_ON)
> > +			pm_abort_suspend_source_add(ws->name);
> > +#endif
> 
> Especially for stuff like this, if you write your .h files properly, no
> #ifdef are needed.
>
 Thanks. We can move it to .h file.
> 
> 
> 
> > 		pm_system_wakeup();
> > +	}
> >  }
> > 
> >  /**
> > @@ -893,12 +956,47 @@ bool pm_wakeup_pending(void)
> > 		pm_print_active_wakeup_sources();
> > 	}
> > 
> > +#ifdef CONFIG_PM_DEBUG
> > +	if (atomic_read(&pm_abort_suspend) > 0) {
> > +		struct pm_abort_suspend_source *info;
> > +
> > +		raw_spin_lock_irqsave(&pm_abort_suspend_list_lock, flags);
> > +		list_for_each_entry(info, &pm_abort_suspend_list, list) {
> > +			pm_pr_dbg("wakeup source or subsystem %s aborted suspend\n",
> > +					info->source_triggering_abort_suspend);
> > +		}
> > +		raw_spin_unlock_irqrestore(&pm_abort_suspend_list_lock, flags);
> > +		pm_abort_suspend_list_clear();
> > +	}
> > +#endif
> > +
> > 	return ret || atomic_read(&pm_abort_suspend) > 0;
> >  }
> >  EXPORT_SYMBOL_GPL(pm_wakeup_pending);
> > 
> >  void pm_system_wakeup(void)
> >  {
> > +
> > +#ifdef CONFIG_PM_DEBUG
> > +#ifdef CONFIG_DEBUG_INFO
> > +	if (pm_suspend_target_state != PM_SUSPEND_ON) {
> > +		char *source_name = kasprintf(GFP_ATOMIC,
> > +					"%ps",
> > +					__builtin_return_address(0));
> > +		if (!source_name)
> > +			goto exit;
> > +
> > +		if (strcmp(source_name, "pm_wakeup_ws_event"))
> > +			pm_abort_suspend_source_add(source_name);
> > +
> > +		kfree(source_name);
> > +	}
> > +exit:
> > +#else
> > +	if (pm_suspend_target_state != PM_SUSPEND_ON)
> > +		pm_pr_dbg("Some wakeup source or subsystem aborted suspend\n");
> > +#endif
> > +#endif
> 
> Would you want to maintain this #ifdef nesting mess for the next 20
> years?  Please do not do this.
> 
 I was hoping if we can remove the "CONFIG_PM_DEBUG" as this functionality can exist by default as well.
 We can avoid nesting and usage for CONFIG_DEBUG_INFO move to .h files.

 Please share your perspective on this.


> thanks,
> 
> greg k-h



Warm Regards,
Vimal Kumar


