Return-Path: <linux-kernel+bounces-124220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7338913FD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 08:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B7CD1F2339E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0416B3D984;
	Fri, 29 Mar 2024 07:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1WUMfvK"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980523D0BD
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 07:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711695726; cv=none; b=r5GhD6YMJaMRWQ/DooxAqcpHh3IMOA/mDGGwd8IVWE2ANvQ5LhKEsla1l6npsarauHcdThVuUoEOQ5tNEvQV6nsAdUlTuCL0SOZtLcnGTp9lNqcN2P9ZIQJe7z/ZIbKgxPHQcEJzrqdje/UAuJWlLQX6W7IoAEEPmVlk4pgTkEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711695726; c=relaxed/simple;
	bh=/T85BMWOBGyInSmentYuXLN5Xgh5VjFRGium8m9HyVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugTMT3Yda/ZDYcZbSjYWiX2E5CWjluI6/qWBnW3SqXfFJofwDCwmS8AAXzfSro8am9y5kEYzgq0EZC3ItC3q8IWNLyS4Si+ZilyNxEeSsTkPrcMfFHXAVc43ib4nxG1qzk/tcj+WU+5dCAtga7mcfHmKC2g+jwZnXylYT2j1Hso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1WUMfvK; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56845954ffeso2482393a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 00:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711695723; x=1712300523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KpYQ/V/QalATcuCFjtKzuSngXyEFzjLdj1ISHAQ06Dg=;
        b=E1WUMfvKse1+bzyci6xWQjg4zWx2OxIlMG6p2BueQsGxiLxAHwV2r8ZNO6A8oHA/RB
         jeZeQ1neBDL84YwC/cqXkVLQdlI0rIbAmteBmPvpKz33qTI3U7jAxzQK3FDdZEjP6Qlh
         owoXXyNWn7W4AO/38Ui3YibTyW1HeNbliOzVoOeISdLCt5cUXuAztupscNSMRW0uwvdZ
         cp8fr+wOe4r08sZ9OedQ/JSTmlcpYosUuBRACk1bxrYmTeObQ4h1Q3tLenX0GhmLhzDo
         bddIKq7wbldHN30hEZITL7WS8roHDJKxFdfRx0Hx2h0W5r9cqs+4gDul1yNJgi1TlJSL
         tAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711695723; x=1712300523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KpYQ/V/QalATcuCFjtKzuSngXyEFzjLdj1ISHAQ06Dg=;
        b=r051J8Us2N8kEVipFLpby5gHt6Grgr24GwmSiSlflrEx0bkEgfud59fHYSIyY4YPtR
         l9hihw0hOlcyUiKhvYe3SkRIpYDrbdKl9eM1l5/hUWl3mWvN4f02r5ISuEzQR4X+GA5I
         s31MqcmIO8CNMqyh8z0co6xFRvNkeSB8f42V2t6F4nU/CGuxguhlEqpBXeP3gLn5onpG
         Ce9oT/Si6JYWGjh4jAsMOUEm0OCQvsCLnpQu6Phjb0/1lWDGu+b+2aNTktpcgk6jI27G
         VB4RQxSvqwzmtvxPhP4YGSPYh55cpfGBPL4jeBA0fu2ZWvYGYXS/vAgM/MENUj3MhJEh
         xSbg==
X-Forwarded-Encrypted: i=1; AJvYcCXH5CnWr2qsU9tM8e1gyBjVk2XK3XDIcMePjEmKJ0Wz6bzTsAfgphUDJcyUyOegNL8ryvldGoedWAMbCx5UgKVXo1GseVP5HQwOxpZN
X-Gm-Message-State: AOJu0YwKaDMSymk0t+ZciGn/7sK6vcxOy5ypdd91PzsfCahDW65xL1Nu
	59nWqBPRRgkw9/137MzNe1Wc/at5vREd5lQCf4I2igybt0ztXHfs
X-Google-Smtp-Source: AGHT+IEtmwuSDRJQSY9qf6Yff5gbg1yfMCU/zUHVfR7m2l+sj18j4WaUo85gxqVYPn+V5uFhjmxMIg==
X-Received: by 2002:a17:906:27c4:b0:a4e:2e14:f75e with SMTP id k4-20020a17090627c400b00a4e2e14f75emr689600ejc.77.1711695722438;
        Fri, 29 Mar 2024 00:02:02 -0700 (PDT)
Received: from gmail.com (195-38-112-2.pool.digikabel.hu. [195.38.112.2])
        by smtp.gmail.com with ESMTPSA id z4-20020a170906714400b00a469e55767dsm1590838ejj.214.2024.03.29.00.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 00:02:01 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 29 Mar 2024 08:01:58 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: fenghua.yu@intel.com, bp@alien8.de, james.morse@arm.com,
	tony.luck@intel.com, peternewman@google.com, babu.moger@amd.com,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, james.greenhalgh@arm.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/resctrl: Fix uninitialized memory read when last CPU
 of domain goes offline
Message-ID: <ZgZnZgfDUWlhQQxW@gmail.com>
References: <979cfd9522021aa6001f8995cd36fb56e1c9cd39.1711659804.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <979cfd9522021aa6001f8995cd36fb56e1c9cd39.1711659804.git.reinette.chatre@intel.com>


* Reinette Chatre <reinette.chatre@intel.com> wrote:

> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index c99f26ebe7a6..4f9ef35626a7 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -85,6 +85,10 @@ cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
>  	if (cpu < nr_cpu_ids && !tick_nohz_full_cpu(cpu))
>  		return cpu;
>  
> +	/* Only continue if tick_nohz_full_mask has been initialized. */
> +	if (!tick_nohz_full_enabled())
> +		return cpu;
> +

So we already have this a few lines up:

        if (!IS_ENABLED(CONFIG_NO_HZ_FULL))
                return cpu;

And we can combine the two checks into a single one, with the patch 
below, right?

Untested.

Thanks,

	Ingo

==============>

 Signed-off-by: Ingo Molnar <mingo@kernel.org>


 arch/x86/kernel/cpu/resctrl/internal.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index c99f26ebe7a6..1a8687f8073a 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -78,7 +78,8 @@ cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
 	else
 		cpu = cpumask_any_but(mask, exclude_cpu);
 
-	if (!IS_ENABLED(CONFIG_NO_HZ_FULL))
+	/* Only continue if tick_nohz_full_mask has been initialized. */
+	if (!tick_nohz_full_enabled())
 		return cpu;
 
 	/* If the CPU picked isn't marked nohz_full nothing more needs doing. */

