Return-Path: <linux-kernel+bounces-8750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D80AF81BBB9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9285428E970
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18CA55E5F;
	Thu, 21 Dec 2023 16:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GNGmWCPI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1BA53A17
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so746677a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 08:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703175410; x=1703780210; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JNDwzkyVbVWHRlDqAlVAzcdYLL04NDJIY3AGS0xxeec=;
        b=GNGmWCPI+4bPB0jMcjqWv2dQRgdruXpnDSHIN9F6ahzC9Bxnx1Av3pcA31WDlSKJsJ
         mb2e6rz3HOfBOHEvoNnLKUXqTSEYqaxkn1jwRaq+ytg/cdRV+oX07TX59AYsclRHXymd
         2164+EOsTiF8fE0+PF2Zu3DyTcL9jNeN0qECmvbZnPV49MkPLQ114M/ZVH+DREkajZQY
         n/SzRM9pKi59mhLMiJYkHAHF2VCyXA1LHf5Sb+cD8/eETCoEd1MLCnxX4UJZtAIchVcL
         uh6BaPX+dl9dgFxIOEo2Ac5VxMUng+bwpCM/WzejNR6rrbKiUL0bItbg6QG0x+jEm7f6
         wq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703175410; x=1703780210;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JNDwzkyVbVWHRlDqAlVAzcdYLL04NDJIY3AGS0xxeec=;
        b=ne6VnwDgbpUmFb7Pd8jTO1b/3qG+sJmzN6O/NCjVL2uEcKgrDzKTYgvyXo8RWYtCo7
         xWjme/9F5pa8V7KxmrIuIFpBP4B//68VmIOzXJGL5I9agBseOluRwJrDGJh2z7Y1Wk0b
         VS3VlWHlHTVWAW10FndbZa/PCjFSXKxEFRUZYPB7UrQ1SLisv4cFhfig/8pg5HLDbj1h
         /14KjcHdjHdL3vVQcPN+Oe6EfWXmdZlxq8xk15eIX5o1KgW+7xLG9dEcV5LOGFyY6+BJ
         Ui3Uucy4+n0ayU6PvvMU+CIK6cRvILCJaso+iZxAiVO1B6/QlOEXS6M0FiGcK9qTz7Ou
         0NxA==
X-Gm-Message-State: AOJu0Yyr59IRsN5S74biKh8Pui/BFHHgS+YOKsfOgyfbWAFEDDGqMujv
	G0zwYXyXPjxzyzirBIYjRW7gmkKQaAgCKzTGjxkVEak2x+RPUTQabifvCA==
X-Google-Smtp-Source: AGHT+IGINn7Xjp4T4JuWPq/y5NwX1YFNwZ5TaxZPwiRcnvRwn7M9zvqX0GjDaZz5uuqvzAHwqY8zeL30wI2SCXnzy7Q=
X-Received: by 2002:a17:90b:3547:b0:28b:da84:164c with SMTP id
 lt7-20020a17090b354700b0028bda84164cmr1835002pjb.81.1703175410067; Thu, 21
 Dec 2023 08:16:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220065522.351915-1-sshegde@linux.vnet.ibm.com>
 <CAKfTPtCRoLULQkRTZcJfXvSSqZYV2oRN0a3_AFiuqD7k0LtL-Q@mail.gmail.com> <85230ed0-26a0-4f08-aab0-f0a6ce03abe8@linux.vnet.ibm.com>
In-Reply-To: <85230ed0-26a0-4f08-aab0-f0a6ce03abe8@linux.vnet.ibm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 21 Dec 2023 17:16:38 +0100
Message-ID: <CAKfTPtBYRT9oOoLwZ-Gg3KVdK+2iJnPaXaWfiuebnGEOOArH0Q@mail.gmail.com>
Subject: Re: [PATCH] sched: move access of avg_rt and avg_dl into existing
 helper functions
To: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Cc: mingo@kernel.org, peterz@infradead.org, dietmar.eggemann@arm.com, 
	linux-kernel@vger.kernel.org, srikar@linux.vnet.ibm.com, yu.c.chen@intel.com, 
	tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

Hi Shrikanth,

On Wed, 20 Dec 2023 at 15:49, Shrikanth Hegde
<sshegde@linux.vnet.ibm.com> wrote:
>
>
>
> On 12/20/23 7:29 PM, Vincent Guittot wrote:
>
> Hi Vincent, thanks for taking a look.
>
> > On Wed, 20 Dec 2023 at 07:55, Shrikanth Hegde
> > <sshegde@linux.vnet.ibm.com> wrote:
> >>

[...]

> >> -#ifdef CONFIG_HAVE_SCHED_AVG_IRQ
> >> -       if (READ_ONCE(rq->avg_irq.util_avg))
> >> +       if (cpu_util_irq(rq))
> >
> > cpu_util_irq doesn't call READ_ONCE()
> >
>
>
> I see. Actually it would be right if cpu_util_irq does call READ_ONCE no?

Yes, cpu_util_irq should call READ_ONCE()

>
> Sorry i havent yet understood the memory barriers in details. Please correct me
> if i am wrong here,
> since ___update_load_avg(&rq->avg_irq, 1) does use WRITE_ONCE and reading out this
> value using cpu_util_irq on a different CPU should use READ_ONCE no?

Yes

>
> >
> >>                 return true;
> >> -#endif
> >>
> >>         return false;
> >>  }
> >> @@ -9481,8 +9479,8 @@ static unsigned long scale_rt_capacity(int cpu)
> >>          * avg_thermal.load_avg tracks thermal pressure and the weighted
> >>          * average uses the actual delta max capacity(load).
> >>          */
> >> -       used = READ_ONCE(rq->avg_rt.util_avg);
> >> -       used += READ_ONCE(rq->avg_dl.util_avg);
> >> +       used = cpu_util_rt(rq);
> >> +       used += cpu_util_dl(rq);
> >>         used += thermal_load_avg(rq);
> >>
> >>         if (unlikely(used >= max))
> >> --
> >> 2.39.3
> >>

