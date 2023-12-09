Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF2080B4F8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 15:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjLIOxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 09:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLIOxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 09:53:47 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1670B1AD;
        Sat,  9 Dec 2023 06:53:53 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6ce6d926f76so2052450b3a.1;
        Sat, 09 Dec 2023 06:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702133632; x=1702738432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g94MtNoEh8BtRD8r3tXOeZRam9pdMQRGTr+fZ9BzUpU=;
        b=BrdebiJ5ZVuty/qbIpcpFevkeB8gEsvsVlxnAqIaJ4S1qseT3A16jVXJ27n+mvl7km
         LEH3sdGdpsdAEeFrbmCP2WWnBjVWb2R/scgDdeapNiz5Y0D2DHNfjhktf9PUDxXQWjdu
         n0t+Usm/bEGqcutHbUM7IMVJ4H9i5duaViZCURT2Pcyquu0DPp9Foow4kiPGNdi1Tzwc
         GhuS+Rr+aixD7jqRUbM+ah2+oCkLhM/iSY/jEP0c7WvsDYa747tUGzpa8zvU6yTzbmF7
         CA6rgcU8B9nNOVDvHCo9SEnUEmlNtE4FnEyFMm7+gBzWO3Ow8IPraDF2xe/M+JdkKxMz
         MA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702133632; x=1702738432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g94MtNoEh8BtRD8r3tXOeZRam9pdMQRGTr+fZ9BzUpU=;
        b=Epqu3jZrGgqLHvgnFbOb4zaMY4EtDzT1cR7X/wBt5DcuaeUE+/CkXMHsq3f/Osat2z
         f6X3F7SXSvCDfMCxUsZc7iLaxE/WAmTD6Dv0e+SdS7/7vNhDola9MqFCb/6nw7zfL4mn
         hyqXx3AsVkBqKuKl5VnZ2OFYHVXf4+gh0nz8OxLsbgc2b30qywHbkToMCJrHDNK5vAv/
         +icu93AKQdOqJuLFxPzERbd4TKlCp9qhluSLxjKHmOle3qo+E2K9A8or+zdI1NqBVNhv
         liaLo8g23MoqYasZEF92a7wMd40htZBnK1rctEoZUssItkas+WvGtSXMTV3TQZlIOrQQ
         J/ZQ==
X-Gm-Message-State: AOJu0Yye9/KhrdnfhmBSo+0avD15/gdfL8zGyQEG/rse+5qDG4xHiWcH
        EXhLcIVvDnO22piTYO06pCLUyCyYcR5rssUl
X-Google-Smtp-Source: AGHT+IHsYvr1KnRCCcXv0L8yhRQdYNGkjVvXLXmtaSn7esomr/uhiqInZ/9pp3G2zmRf8gx4Ev0qiw==
X-Received: by 2002:a05:6a00:2301:b0:6c3:4bf2:7486 with SMTP id h1-20020a056a00230100b006c34bf27486mr2322010pfh.7.1702133632313;
        Sat, 09 Dec 2023 06:53:52 -0800 (PST)
Received: from DESKTOP-KA7F9LU.localdomain ([2406:7400:63:a2b1:e827:3043:e13e:baef])
        by smtp.gmail.com with ESMTPSA id y20-20020a056a00191400b00688435a9915sm3327598pfi.189.2023.12.09.06.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 06:53:51 -0800 (PST)
Date:   Sat, 9 Dec 2023 20:23:47 +0530
From:   Vimal Kumar <vimal.kumar32@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        chinmoyghosh2001@gmail.com, badolevishal1116@gmail.com,
        mintupatel89@gmail.com
Subject: Re: [PATCH] PM / sleep: Mechanism to find source aborting kernel
 suspend transition
Message-ID: <20231209144023.GA1863@DESKTOP-KA7F9LU.localdomain>
References: <20231209081056.1497-1-vimal.kumar32@gmail.com>
 <2023120907-unlucky-playmaker-e27e@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023120907-unlucky-playmaker-e27e@gregkh>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg k-h,

On Sat, Dec 09, 2023 at 10:21:12AM +0100, Greg Kroah-Hartman wrote:
> On Sat, Dec 09, 2023 at 01:40:54PM +0530, Vimal Kumar wrote:
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
> > [  519.486939] Abort: ws or subsystem uart_suspend_port aborted suspend
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
> >  drivers/base/power/wakeup.c | 75 ++++++++++++++++++++++++++++++++++++-
> >  include/linux/suspend.h     |  2 +
> >  kernel/power/suspend.c      |  1 +
> >  3 files changed, 77 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> > index a917219feea6..f640034cab6d 100644
> > --- a/drivers/base/power/wakeup.c
> > +++ b/drivers/base/power/wakeup.c
> > @@ -73,6 +73,13 @@ static struct wakeup_source deleted_ws = {
> >  
> >  static DEFINE_IDA(wakeup_ida);
> >  
> > +struct pm_abort_suspend_source {
> > +	struct list_head list;     //linux kernel list implementation
> 
> Nit, we know this is a list implementation, no need to comment that.
> 
> Also did you run checkpatch on this?  You need a ' ' after "//" to be
> correct.
> 
I do run checkpatch but it was not highlighted. I will remove the comment

> > +	char *source_triggering_abort_suspend;
> > +};
> > +
> > +LIST_HEAD(pm_abort_suspend_list);
> 
> No blank line needed, and also, shouldn't this be static?
>
I missed it, this should be static.

> > +
> >  /**
> >   * wakeup_source_create - Create a struct wakeup_source object.
> >   * @name: Name of the new wakeup source.
> > @@ -575,6 +582,53 @@ static void wakeup_source_activate(struct wakeup_source *ws)
> >  	trace_wakeup_source_activate(ws->name, cec);
> >  }
> >  
> > +/**
> > + * clear_abort_suspend_list: To clear the list containing sources which
> > + * aborted suspend transitions.
> > + * Functionality: The list will be cleared every time system PM exits as we
> > + * can find sources which aborted suspend in the current suspend transisions.
> 
> This isn't the correct way to write kernel doc formats, please see the
> documentation for how to do it.
>
I will correct it in the next version.

> > + */
> > +void clear_abort_suspend_list(void)
> > +{
> > +	struct pm_abort_suspend_source *info, *tmp;
> > +
> > +	if (!list_empty(&pm_abort_suspend_list))
> 
> Why check this, doesn't the list loop work properly here?
> 
The list worked properly, just added for extra check. It will be removed in the next version.

> > +		list_for_each_entry_safe(info, tmp, &pm_abort_suspend_list, list) {
> > +			list_del(&info->list);
> > +			kfree(info);
> > +		}
> 
> No locking at all for this list?
> 
I will gaurd it in the next version.

> > +}
> > +EXPORT_SYMBOL_GPL(clear_abort_suspend_list);
> 
> Global functions should be "subsystem_action", not "action_something"
> like you did here.  Otherwise this gets really messy very quickly.
> 
I will take care of this in future.

> > +
> > +/**
> > + * pm_add_abort_suspend_source: add sources who aborted system suspend transitions.
> > + * @func_name: Name of the WS or subsystem which needs to added in the list
> > + */
> > +void pm_add_abort_suspend_source(const char *source_name)
> > +{
> > +	struct pm_abort_suspend_source *info = NULL;
> > +
> > +	info = kmalloc(sizeof(struct pm_abort_suspend_source), GFP_KERNEL);
> > +	if (unlikely(!info)) {
> 
> Only ever use unlikely/likely if you have documented proof that the code
> is faster (i.e. you can measure it.)  For normal calls like this, the
> compiler and the processor knows better than you, so no need to do
> anything.
> 
I will remove it in the next version.

> > +		pr_err("Failed to alloc memory for pm_abort_suspend_source info\n");
> > +		return;
> > +	}
> > +
> > +	/* Initialize the list within the struct if it's not already initialized */
> > +	if (list_empty(&info->list))
> > +		INIT_LIST_HEAD(&info->list);
> > +
> > +	info->source_triggering_abort_suspend = kstrdup(source_name, GFP_KERNEL);
> > +	if (unlikely(!info->source_triggering_abort_suspend)) {
> 
> Again, don't use likely/unlikely
> 
It will be fixed in the next version.

> > +		pr_err("Failed to get abort_suspend source_name\n");
> > +		kfree(info);
> > +		return;
> > +	}
> > +
> > +	list_add_tail(&info->list, &pm_abort_suspend_list);
> > +}
> > +EXPORT_SYMBOL_GPL(pm_add_abort_suspend_source);
> > +
> >  /**
> >   * wakeup_source_report_event - Report wakeup event using the given source.
> >   * @ws: Wakeup source to report the event for.
> > @@ -590,8 +644,11 @@ static void wakeup_source_report_event(struct wakeup_source *ws, bool hard)
> >  	if (!ws->active)
> >  		wakeup_source_activate(ws);
> >  
> > -	if (hard)
> > +	if (hard) {
> > +		if (pm_suspend_target_state != PM_SUSPEND_ON)
> > +			pm_add_abort_suspend_source(ws->name);
> >  		pm_system_wakeup();
> > +	}
> >  }
> >  
> >  /**
> > @@ -893,12 +950,28 @@ bool pm_wakeup_pending(void)
> >  		pm_print_active_wakeup_sources();
> >  	}
> >  
> > +	if (atomic_read(&pm_abort_suspend) > 0) {
> > +		if (!list_empty(&pm_abort_suspend_list))
> > +			list_for_each_entry(info, &pm_abort_suspend_list, list) {
> > +				log_suspend_abort_reason("ws or subsystem %s aborted suspend\n",
> 
> What is "ws"?
> 
This is for "wakeup_source", we will add it instead of "ws".

> And again, no locking is just not going to work.
> 
I will add lock and gaurd the list in the next version.

> But step back, are you _sure_ you really need this information?  Who is
> going to use it?  Where are they going to use it?  And when are they
> going to use it?
> 
> thanks,
> 
> greg k-h


Suspend-to-RAM and Suspend-to-Idle are widely used features. Sometimes, we have encountered
suspend failures, but the cause of these issues is unknown.

This occurred whenever the suspend was unconditionally aborted using the functionality below:
- Suspend can be aborted via "hard" wakeup triggers using either "pm_wakeup_ws_event", or "pm_wakeup_dev_event".
- Any module can abort the suspend directly  using "pm_system_wakeup"

This change can give developers an upper hand by tracing any such aborted suspend calls and
pointing them in the right direction to debug further.


Warm Regards,
Vimal Kumar
