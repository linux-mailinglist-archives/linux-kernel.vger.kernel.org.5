Return-Path: <linux-kernel+bounces-14424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1397D821CD4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C9E21F22AF7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DB2168C9;
	Tue,  2 Jan 2024 13:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="txQMM01B"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1954168C7
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 13:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5e811c5c1adso75462127b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 05:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704202543; x=1704807343; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W3Vmqnfwgg2A63jy3rbZq6guX5cSGEw8UMQ/rzrryWw=;
        b=txQMM01B7YLiYCVmghSU4trJu9jLYycXbIBtlwsowMSaiAmyccZ3p4MkbomsmnR+/z
         KCaCYIn94Nd9fKHxMkcwAq1wB85/2iOzrR3NoNmIYobsc/NeaWxg1QK8mb0FI0MCdTj6
         aTvraBcgV7Cf9WAA7hF2jAqOS/Qtzriucudh4LUd9QBmpXH6RMDMFpil/E6xSn1+5g3V
         Am2rz2kZlBHG0eONujoPeV06XyPALgtAHl+fIdHID5U4Yt4+uZU5QjnjRhpSO4K8EpH+
         pl8WlZFeFixiLJtC5DX1xxBrQhihGidt1aFCV7WVZBXurTMWWOYaP0fFDNWoX5gNk6BZ
         h3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704202543; x=1704807343;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W3Vmqnfwgg2A63jy3rbZq6guX5cSGEw8UMQ/rzrryWw=;
        b=CeU7ASfuwpXUbkcMURQy46qOuYxWJPsU57iWcy5O3zm3tpzB9siKYiB8nLfxFHGAL9
         xc1TN3dSa3tinfg3vZUaqYcWjTHGgdPKJmf4V+QAFRWE5zAIY9Z05w/5WgFNEblJyZGI
         GPrKVKPDrto2Rs+U0qYjdT755birQ/mIv0p5TdH7Jpt3e0pyRHEsxDBr8zTTTi6+5vC0
         Zg9CB1hQ3pPfH5o2ZhrItD/tH5MyVLDmRW2oStE8L9wW8IO/xeMXp1xEvg+WkXV0N+Zu
         qhVbLJSk0QSi4BIlUdPSdJG5ofi08Dz8f67/jlnihMJd+aO9ek/VLwJxX3n2Lyeq0PMY
         ceQg==
X-Gm-Message-State: AOJu0Yzya/9Q7S4qHMgUI2hIo5+3PTGhDULq8r2cfhlqhLD7nEj+Jzsl
	W7AoinpG5YJ9ewu27Rkgzza3FT0XoJxI7R2Qdpbz3auU98iihw==
X-Google-Smtp-Source: AGHT+IHVvbg4JQQ13wwUDla6tmYgoDw8TIOKOJjubsaFWpec4ys8ds3prz7rsezUNj8l7yrNz1cMKEXNwzGcyYRsBHQ=
X-Received: by 2002:a0d:dd96:0:b0:5c9:cb4c:35df with SMTP id
 g144-20020a0ddd96000000b005c9cb4c35dfmr9605241ywe.37.1704202542703; Tue, 02
 Jan 2024 05:35:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20231227084252epcas2p3b063f7852f81f82cd0a31afd7f404db4@epcas2p3.samsung.com>
 <5754861.DvuYhMxLoT@kreacher> <6019796.lOV4Wx5bFT@kreacher> <13435856.uLZWGnKmhe@kreacher>
In-Reply-To: <13435856.uLZWGnKmhe@kreacher>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 2 Jan 2024 14:35:06 +0100
Message-ID: <CAPDyKFohQjDzpYpm0QQLM4eTzGOzGfDNKUGHHC-niPBOrtR8BQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] PM: sleep: Fix possible deadlocks in core
 system-wide PM code
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, 
	Youngmin Nam <youngmin.nam@samsung.com>, rafael@kernel.org, linux-kernel@vger.kernel.org, 
	d7271.choe@samsung.com, janghyuck.kim@samsung.com, hyesoo.yu@samsung.com, 
	Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Dec 2023 at 21:41, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> It is reported that in low-memory situations the system-wide resume core
> code deadlocks, because async_schedule_dev() executes its argument
> function synchronously if it cannot allocate memory (an not only then)
> and that function attempts to acquire a mutex that is already held.
>
> Address this by changing the code in question to use
> async_schedule_dev_nocall() for scheduling the asynchronous
> execution of device suspend and resume functions and to directly
> run them synchronously if async_schedule_dev_nocall() returns false.
>
> Fixes: 09beebd8f93b ("PM: sleep: core: Switch back to async_schedule_dev()")
> Link: https://lore.kernel.org/linux-pm/ZYvjiqX6EsL15moe@perf/
> Reported-by: Youngmin Nam <youngmin.nam@samsung.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> The commit pointed to by the Fixes: tag is the last one that modified
> the code in question, even though the bug had been there already before.
>
> Still, the fix will not apply to the code before that commit.

An option could be to just do "Cc: stable@vger.kernel.org # v5.7+"
instead of pointing to a commit with a Fixes tag.

>
> ---
>  drivers/base/power/main.c |  148 +++++++++++++++++++++-------------------------
>  1 file changed, 68 insertions(+), 80 deletions(-)
>
> Index: linux-pm/drivers/base/power/main.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/main.c
> +++ linux-pm/drivers/base/power/main.c
> @@ -579,7 +579,7 @@ bool dev_pm_skip_resume(struct device *d
>  }
>
>  /**
> - * device_resume_noirq - Execute a "noirq resume" callback for given device.
> + * __device_resume_noirq - Execute a "noirq resume" callback for given device.
>   * @dev: Device to handle.
>   * @state: PM transition of the system being carried out.
>   * @async: If true, the device is being resumed asynchronously.
> @@ -587,7 +587,7 @@ bool dev_pm_skip_resume(struct device *d
>   * The driver of @dev will not receive interrupts while this function is being
>   * executed.
>   */
> -static int device_resume_noirq(struct device *dev, pm_message_t state, bool async)
> +static void __device_resume_noirq(struct device *dev, pm_message_t state, bool async)
>  {
>         pm_callback_t callback = NULL;
>         const char *info = NULL;
> @@ -655,7 +655,13 @@ Skip:
>  Out:
>         complete_all(&dev->power.completion);
>         TRACE_RESUME(error);
> -       return error;
> +
> +       if (error) {
> +               suspend_stats.failed_resume_noirq++;
> +               dpm_save_failed_step(SUSPEND_RESUME_NOIRQ);
> +               dpm_save_failed_dev(dev_name(dev));
> +               pm_dev_err(dev, state, async ? " async noirq" : " noirq", error);
> +       }
>  }
>
>  static bool is_async(struct device *dev)
> @@ -668,11 +674,15 @@ static bool dpm_async_fn(struct device *
>  {
>         reinit_completion(&dev->power.completion);
>
> -       if (is_async(dev)) {
> -               get_device(dev);
> -               async_schedule_dev(func, dev);
> +       if (!is_async(dev))
> +               return false;
> +
> +       get_device(dev);
> +
> +       if (async_schedule_dev_nocall(func, dev))
>                 return true;
> -       }
> +
> +       put_device(dev);
>
>         return false;
>  }
> @@ -680,15 +690,19 @@ static bool dpm_async_fn(struct device *
>  static void async_resume_noirq(void *data, async_cookie_t cookie)
>  {
>         struct device *dev = data;
> -       int error;
> -
> -       error = device_resume_noirq(dev, pm_transition, true);
> -       if (error)
> -               pm_dev_err(dev, pm_transition, " async", error);
>
> +       __device_resume_noirq(dev, pm_transition, true);
>         put_device(dev);
>  }
>
> +static void device_resume_noirq(struct device *dev)
> +{
> +       if (dpm_async_fn(dev, async_resume_noirq))
> +               return;
> +
> +       __device_resume_noirq(dev, pm_transition, false);
> +}
> +
>  static void dpm_noirq_resume_devices(pm_message_t state)
>  {
>         struct device *dev;
> @@ -698,14 +712,6 @@ static void dpm_noirq_resume_devices(pm_
>         mutex_lock(&dpm_list_mtx);
>         pm_transition = state;
>
> -       /*
> -        * Advanced the async threads upfront,
> -        * in case the starting of async threads is
> -        * delayed by non-async resuming devices.
> -        */
> -       list_for_each_entry(dev, &dpm_noirq_list, power.entry)
> -               dpm_async_fn(dev, async_resume_noirq);
> -

If I understand correctly, this means that we are no longer going to
run the async devices upfront, right?

Depending on how devices get ordered in the dpm_noirq_list, it sounds
like the above could have a negative impact on the total resume time!?
Of course, if all devices would be async capable this wouldn't be a
problem...

>         while (!list_empty(&dpm_noirq_list)) {
>                 dev = to_device(dpm_noirq_list.next);
>                 get_device(dev);
> @@ -713,17 +719,7 @@ static void dpm_noirq_resume_devices(pm_
>
>                 mutex_unlock(&dpm_list_mtx);
>
> -               if (!is_async(dev)) {
> -                       int error;
> -
> -                       error = device_resume_noirq(dev, state, false);
> -                       if (error) {
> -                               suspend_stats.failed_resume_noirq++;
> -                               dpm_save_failed_step(SUSPEND_RESUME_NOIRQ);
> -                               dpm_save_failed_dev(dev_name(dev));
> -                               pm_dev_err(dev, state, " noirq", error);
> -                       }
> -               }
> +               device_resume_noirq(dev);
>
>                 put_device(dev);
>
> @@ -751,14 +747,14 @@ void dpm_resume_noirq(pm_message_t state
>  }
>
>  /**
> - * device_resume_early - Execute an "early resume" callback for given device.
> + * __device_resume_early - Execute an "early resume" callback for given device.
>   * @dev: Device to handle.
>   * @state: PM transition of the system being carried out.
>   * @async: If true, the device is being resumed asynchronously.
>   *
>   * Runtime PM is disabled for @dev while this function is being executed.
>   */
> -static int device_resume_early(struct device *dev, pm_message_t state, bool async)
> +static void __device_resume_early(struct device *dev, pm_message_t state, bool async)
>  {
>         pm_callback_t callback = NULL;
>         const char *info = NULL;
> @@ -811,21 +807,31 @@ Out:
>
>         pm_runtime_enable(dev);
>         complete_all(&dev->power.completion);
> -       return error;
> +
> +       if (error) {
> +               suspend_stats.failed_resume_early++;
> +               dpm_save_failed_step(SUSPEND_RESUME_EARLY);
> +               dpm_save_failed_dev(dev_name(dev));
> +               pm_dev_err(dev, state, async ? " async early" : " early", error);
> +       }
>  }
>
>  static void async_resume_early(void *data, async_cookie_t cookie)
>  {
>         struct device *dev = data;
> -       int error;
> -
> -       error = device_resume_early(dev, pm_transition, true);
> -       if (error)
> -               pm_dev_err(dev, pm_transition, " async", error);
>
> +       __device_resume_early(dev, pm_transition, true);
>         put_device(dev);
>  }
>
> +static void device_resume_early(struct device *dev)
> +{
> +       if (dpm_async_fn(dev, async_resume_early))
> +               return;
> +
> +       __device_resume_early(dev, pm_transition, false);
> +}
> +
>  /**
>   * dpm_resume_early - Execute "early resume" callbacks for all devices.
>   * @state: PM transition of the system being carried out.
> @@ -839,14 +845,6 @@ void dpm_resume_early(pm_message_t state
>         mutex_lock(&dpm_list_mtx);
>         pm_transition = state;
>
> -       /*
> -        * Advanced the async threads upfront,
> -        * in case the starting of async threads is
> -        * delayed by non-async resuming devices.
> -        */
> -       list_for_each_entry(dev, &dpm_late_early_list, power.entry)
> -               dpm_async_fn(dev, async_resume_early);
> -

Ditto.

>         while (!list_empty(&dpm_late_early_list)) {
>                 dev = to_device(dpm_late_early_list.next);
>                 get_device(dev);
> @@ -854,17 +852,7 @@ void dpm_resume_early(pm_message_t state
>
>                 mutex_unlock(&dpm_list_mtx);
>
> -               if (!is_async(dev)) {
> -                       int error;
> -
> -                       error = device_resume_early(dev, state, false);
> -                       if (error) {
> -                               suspend_stats.failed_resume_early++;
> -                               dpm_save_failed_step(SUSPEND_RESUME_EARLY);
> -                               dpm_save_failed_dev(dev_name(dev));
> -                               pm_dev_err(dev, state, " early", error);
> -                       }
> -               }
> +               device_resume_early(dev);
>
>                 put_device(dev);
>
> @@ -888,12 +876,12 @@ void dpm_resume_start(pm_message_t state
>  EXPORT_SYMBOL_GPL(dpm_resume_start);
>
>  /**
> - * device_resume - Execute "resume" callbacks for given device.
> + * __device_resume - Execute "resume" callbacks for given device.
>   * @dev: Device to handle.
>   * @state: PM transition of the system being carried out.
>   * @async: If true, the device is being resumed asynchronously.
>   */
> -static int device_resume(struct device *dev, pm_message_t state, bool async)
> +static void __device_resume(struct device *dev, pm_message_t state, bool async)
>  {
>         pm_callback_t callback = NULL;
>         const char *info = NULL;
> @@ -975,20 +963,30 @@ static int device_resume(struct device *
>
>         TRACE_RESUME(error);
>
> -       return error;
> +       if (error) {
> +               suspend_stats.failed_resume++;
> +               dpm_save_failed_step(SUSPEND_RESUME);
> +               dpm_save_failed_dev(dev_name(dev));
> +               pm_dev_err(dev, state, async ? " async" : "", error);
> +       }
>  }
>
>  static void async_resume(void *data, async_cookie_t cookie)
>  {
>         struct device *dev = data;
> -       int error;
>
> -       error = device_resume(dev, pm_transition, true);
> -       if (error)
> -               pm_dev_err(dev, pm_transition, " async", error);
> +       __device_resume(dev, pm_transition, true);
>         put_device(dev);
>  }
>
> +static void device_resume(struct device *dev)
> +{
> +       if (dpm_async_fn(dev, async_resume))
> +               return;
> +
> +       __device_resume(dev, pm_transition, false);
> +}
> +
>  /**
>   * dpm_resume - Execute "resume" callbacks for non-sysdev devices.
>   * @state: PM transition of the system being carried out.
> @@ -1008,27 +1006,17 @@ void dpm_resume(pm_message_t state)
>         pm_transition = state;
>         async_error = 0;
>
> -       list_for_each_entry(dev, &dpm_suspended_list, power.entry)
> -               dpm_async_fn(dev, async_resume);
> -

Ditto.

>         while (!list_empty(&dpm_suspended_list)) {
>                 dev = to_device(dpm_suspended_list.next);
> +
>                 get_device(dev);
> -               if (!is_async(dev)) {
> -                       int error;
>
> -                       mutex_unlock(&dpm_list_mtx);
> +               mutex_unlock(&dpm_list_mtx);
>
> -                       error = device_resume(dev, state, false);
> -                       if (error) {
> -                               suspend_stats.failed_resume++;
> -                               dpm_save_failed_step(SUSPEND_RESUME);
> -                               dpm_save_failed_dev(dev_name(dev));
> -                               pm_dev_err(dev, state, "", error);
> -                       }
> +               device_resume(dev);
> +
> +               mutex_lock(&dpm_list_mtx);
>
> -                       mutex_lock(&dpm_list_mtx);
> -               }
>                 if (!list_empty(&dev->power.entry))
>                         list_move_tail(&dev->power.entry, &dpm_prepared_list);
>

Other than the potential issue I pointed out, the code as such looks good to me!

Kind regards
Uffe

