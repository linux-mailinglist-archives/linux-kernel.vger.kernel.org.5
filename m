Return-Path: <linux-kernel+bounces-20386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84900827DFC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 05:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D72D1C23563
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5851371;
	Tue,  9 Jan 2024 04:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGcBbq/v"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE5915A4;
	Tue,  9 Jan 2024 04:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6d9a79a1ad4so1006780b3a.2;
        Mon, 08 Jan 2024 20:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704775741; x=1705380541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GcVbVidTOCl6eb5k7/CArebD5VL1E+DnTdDkFp0PXJg=;
        b=mGcBbq/vlhgss3g6Ta8EvZf4vYz3IuM7/lJR8Zbih/fGOjdbXUZQ2V0IoP1P4BRy2U
         OAPK11UT7RBNi/49hcUB//+kRqn6QK9lXi1tpzqMuPPpzYfhRJHIvqrbA59uT3P5kGIJ
         3Hqc70aVRkR0y7K+HhzxalJUxT8Dgw8Dl9pSV5eBFOrufLzgBBMGfuE6dVajvEYZEyLJ
         KH1DkhoF6GDy/pqlSQuYDflTVGqha6bICrWvDr0cA/OrgFN+jAnkr/2u9YLoErqxctM5
         SsyEfARRy6CA5YOUydrgBNebyYjE5DnnoY456+agLXjVj9czl8XnxCdEf0kNulJdbMvB
         YS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704775741; x=1705380541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GcVbVidTOCl6eb5k7/CArebD5VL1E+DnTdDkFp0PXJg=;
        b=GpHsdBL/fdbi9PbEKwsvfbvN7IpTmzlHaOR1MQ4gpkZ94P1LsEcbz0GhlRxs0493mT
         tYNUrSRnFdfMV8jlnZ2sgzDstjYVW9EIUvZuAu7zQOank/TAT+NXjMtOOLCV7YH6cjaJ
         Zb0F/PC0uXIRRNaBSB+YwoFcBq0Wu8qECGWa5OQ1UeKKpColVLY1sw+n9UD+dwuUbeDx
         hCebKzI3YWwVP0w+Pkg4gO9nvGx4I8Koy2aQa0GCR76N2y/YUUhyGtzkDBIoXB+CAY51
         hJD6YMkCSLeMm73wVI1thNMA5+nRulineLpXB5g/DjU2O927EPL7MckrIzpAWZIQ84iH
         TeOQ==
X-Gm-Message-State: AOJu0YwWqAEdUBkIkQ8XVMqYLmcTCu2+JaqDjZQh6Ps03RV/qd56BWJ4
	LXt5gsV5J+Z21ZIwgE+T7B43zI2PU+uN6g==
X-Google-Smtp-Source: AGHT+IHBFovOyZneJyA1eKT6FVWIjhUtp2+U4okoPhc6nIeSQzHM1d4m0wPznQVWDcdoRUzvdBFiTw==
X-Received: by 2002:a05:6a20:dc85:b0:199:f077:c0e1 with SMTP id ky5-20020a056a20dc8500b00199f077c0e1mr350649pzb.19.1704775741443;
        Mon, 08 Jan 2024 20:49:01 -0800 (PST)
Received: from DESKTOP-KA7F9LU.localdomain ([2406:7400:63:8f51:fc6d:dffa:d522:7f1f])
        by smtp.gmail.com with ESMTPSA id k4-20020a170902ba8400b001d4e0752b5esm721671pls.157.2024.01.08.20.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 20:49:01 -0800 (PST)
Date: Tue, 9 Jan 2024 10:18:55 +0530
From: Vimal Kumar <vimal.kumar32@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	chinmoyghosh2001@gmail.com, badolevishal1116@gmail.com,
	mintupatel89@gmail.com
Subject: Re: [PATCH v2] PM / sleep: Mechanism to find source aborting kernel
 suspend transition
Message-ID: <20240109044855.GA10187@DESKTOP-KA7F9LU.localdomain>
References: <20231210100303.491-1-vimal.kumar32@gmail.com>
 <2023121037-unroasted-gradation-a47f@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023121037-unroasted-gradation-a47f@gregkh>

Apologies for delayed response.

On Sun, Dec 10, 2023 at 11:35:02AM +0100, Greg Kroah-Hartman wrote:
> On Sun, Dec 10, 2023 at 03:33:01PM +0530, Vimal Kumar wrote:
> > +#define MAX_SUSPEND_ABORT_LEN 256
> 
> What does this number mean?

 It was for buffer size assuming function name won't go beyond that.
 We have removed this and modified to dynamic allocation in the next version.  
> 
> > +static DEFINE_RAW_SPINLOCK(abort_suspend_lock);
> 
> Why is this a "raw" spinlock?  What requires this?

 We tried to use same as one used for wakeup_source. We modified to
 mutex_lock in the next version. 
> 
> > +
> > +struct pm_abort_suspend_source {
> > +	struct list_head list;
> > +	char *source_triggering_abort_suspend;
> > +};
> > +static LIST_HEAD(pm_abort_suspend_list);
> > +
> >  /**
> >   * wakeup_source_create - Create a struct wakeup_source object.
> >   * @name: Name of the new wakeup source.
> > @@ -575,6 +584,56 @@ static void wakeup_source_activate(struct wakeup_source *ws)
> >  	trace_wakeup_source_activate(ws->name, cec);
> >  }
> >  
> > +/**
> > + * abort_suspend_list_clear - Clear pm_abort_suspend_list.
> > + *
> > + * The pm_abort_suspend_list will be cleared when system PM exits.
> > + */
> > +void abort_suspend_list_clear(void)
> > +{
> > +	struct pm_abort_suspend_source *info, *tmp;
> > +	unsigned long flags;
> > +
> > +	raw_spin_lock_irqsave(&abort_suspend_lock, flags);
> > +	list_for_each_entry_safe(info, tmp, &pm_abort_suspend_list, list) {
> > +		list_del(&info->list);
> > +		kfree(info);
> > +	}
> > +	raw_spin_unlock_irqrestore(&abort_suspend_lock, flags);
> > +}
> > +EXPORT_SYMBOL_GPL(abort_suspend_list_clear);

 Removed EXPORT_SYMBOL in next version and fixed the name.

> > +
> > +/**
> > + * pm_abort_suspend_source_add - Update pm_abort_suspend_list
> > + * @source_name: Wakeup_source or function aborting suspend transitions.
> > + *
> > + * Add the source name responsible for updating the abort_suspend flag in the
> > + * pm_abort_suspend_list.
> > + */
> > +static void pm_abort_suspend_source_add(const char *source_name)
> > +{
> > +	struct pm_abort_suspend_source *info;
> > +	unsigned long flags;
> > +
> > +	info = kmalloc(sizeof(*info), GFP_KERNEL);
> > +	if (!info)
> > +		return;
> > +
> > +	/* Initialize the list within the struct if it's not already initialized */
> > +	if (list_empty(&info->list))
> > +		INIT_LIST_HEAD(&info->list);
> 
> How can this list head not be initialized already?

 This list is internal to the structure we are defining. Check is reduntant here.
> 
> > +
> > +	info->source_triggering_abort_suspend = kstrdup(source_name, GFP_KERNEL);
> > +	if (!info->source_triggering_abort_suspend) {
> > +		kfree(info);
> > +		return;
> > +	}
> > +
> > +	raw_spin_lock_irqsave(&abort_suspend_lock, flags);
> > +	list_add_tail(&info->list, &pm_abort_suspend_list);
> > +	raw_spin_unlock_irqrestore(&abort_suspend_lock, flags);
> > +}
> > +
> >  /**
> >   * wakeup_source_report_event - Report wakeup event using the given source.
> >   * @ws: Wakeup source to report the event for.
> > @@ -590,8 +649,11 @@ static void wakeup_source_report_event(struct wakeup_source *ws, bool hard)
> >  	if (!ws->active)
> >  		wakeup_source_activate(ws);
> >  
> > -	if (hard)
> > +	if (hard) {
> > +		if (pm_suspend_target_state != PM_SUSPEND_ON)
> > +			pm_abort_suspend_source_add(ws->name);
> >  		pm_system_wakeup();
> > +	}
> >  }
> >  
> >  /**
> > @@ -877,6 +939,7 @@ bool pm_wakeup_pending(void)
> >  {
> >  	unsigned long flags;
> >  	bool ret = false;
> > +	struct pm_abort_suspend_source *info;
> >  
> >  	raw_spin_lock_irqsave(&events_lock, flags);
> >  	if (events_check_enabled) {
> > @@ -893,12 +956,29 @@ bool pm_wakeup_pending(void)
> >  		pm_print_active_wakeup_sources();
> >  	}
> >  
> > +	if (atomic_read(&pm_abort_suspend) > 0) {
> > +		raw_spin_lock_irqsave(&abort_suspend_lock, flags);
> > +		list_for_each_entry(info, &pm_abort_suspend_list, list) {
> > +			pm_pr_dbg("wakeup source or subsystem %s aborted suspend\n",
> > +					info->source_triggering_abort_suspend);
> > +		}
> > +		raw_spin_unlock_irqrestore(&abort_suspend_lock, flags);
> > +	}
> 
> After you print them all out, why not remove them from the list now?
> Why wait until later?
 Yes, this can be done. We have changed it in the next version.

> 
> > +
> >  	return ret || atomic_read(&pm_abort_suspend) > 0;
> >  }
> >  EXPORT_SYMBOL_GPL(pm_wakeup_pending);
> >  
> >  void pm_system_wakeup(void)
> >  {
> > +	char buf[MAX_SUSPEND_ABORT_LEN];
> 
> You never actually check to ensure that you do not overflow this value,
> right?  And are you _SURE_ you can put a string this big on the stack?
> 
 We have changed to dynamic allocation based on the required size in the next version.

> > +
> > +	if (pm_suspend_target_state != PM_SUSPEND_ON) {
> > +		sprintf(buf, "%ps", __builtin_return_address(0));
> > +		if (strcmp(buf, "pm_wakeup_ws_event"))
> 
> This is _VERY_ fragile, you are relying on a specific symbol to never
> change its name, which is not going to work in the long run, AND this
> will not work if you don't have symbols in your kernel, right?
>
 As this is void function, we are depending on this symbol. We have put the
 changes under debug flag in the next version.
 If the symbol changes in future we need to adopt or if the pm_system_wakeup()
 modified to take some input that can be used later.
 
> How was this tested?
> 
 As of now we invoked "pm_system_wakeup()" from one of the late_suspend calls
 and tested this functionality which listed source_name invoking abort suspend. 

> And again, why is this even needed, who will use it?  What tools will
> consume it?  Who will rely on it?
> 
> thanks,
> 
> greg k-h

 Kernel developer can use this in debugging suspend failure while supporting system wide s2r.

 Commit 8a537ece3d94 (PM / wakeup: Integrate mechanism to abort suspend transitions
 in progress) and commit 60d4553bdc1a0 allowed to invoke pm_system_wakeup() when
 wakeup_source_report_event() is called to signal a "hard" event to abort system
 suspend in progress. Also, suspend can be aborted by direct call to pm_system_wakeup().

 In some scenario, we have encoundered a situation where system suspend was aborted using
 the above mechanism. However we faced a challenge in identifying the subsystem or module
 responsible suspend failures. This will prove valuable in debugging system suspend
 failures  by providing details about the sources aborting suspend in progress.

Warm Regards,
Vimal Kumar

