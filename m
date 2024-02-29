Return-Path: <linux-kernel+bounces-86779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7642386CAA9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15646B2221D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262CA128820;
	Thu, 29 Feb 2024 13:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CvEaJ/Uk"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2083B8626A
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 13:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709214607; cv=none; b=etx4nstNw/I0j+Zh3Kg7fXJcC6Up4A/o7xDGUGYe6GO4Pb8z9lOpHlFqrFJUnK2nTOlOwSFfAvLDJet/opB7glFKnewrP82Q5fSKZT1ull74NQTxQOqapuVg8167mdkcBbT92H5Kbl+3+7YV9eXvAabie6g0nuoh3QYYGRRJT4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709214607; c=relaxed/simple;
	bh=ZthdLMEgc+nZu6xtx9oT1Y4pegcGJjq7DAE9PSkZaVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ca4FmVlef9g9f2+ScZeD/1pf1nLQRa3YtH76j24JG8EN7VNmDlejhG90caD1R/vJgAcINvtT0OTZUbFp9HVep9iU3/dsHcPfQsbF0lBDql03mbahuH84TriGf+QROY7yNVT7XYzE92f8AXj9xaqVPEBs9kFV6DpYhhlv6lTjGm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CvEaJ/Uk; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5656e5754ccso1332778a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 05:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709214603; x=1709819403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FvjnGKJvWwLxX/Y9kz34/zEMHUMBymFfcTwqG+MSZAM=;
        b=CvEaJ/Uk2YjKhGp1QeAsMfLlXQq4yGprjUcIkWCVxZRFqZ8Ih3sMDAWiUw9R5TvAiL
         5hVoLZkeGLKSnE8olYcmpOIZX0cp5j86Wfiq4sb2JV0DKpJjOv4pSO3/ub1tw1V1KYwF
         dIbl28inSL/ksheV4kytlvSJ5y88+5szt+cqqBa3z6JIWjwqnBCAT/BODeVWdW/Kqsw6
         NnnneN6YDXJMp7EwDptiLI1mWSKWHqJHqNalvYuybwzHOZ9W6BUK41vA6KFhULVUvrUR
         CUAfEn/wikDQqoNm761HAQAb3b8LDrMs1M7BBlNXTMhrNME6eRdNaNh0PLc7p/T62Ilf
         wCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709214603; x=1709819403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvjnGKJvWwLxX/Y9kz34/zEMHUMBymFfcTwqG+MSZAM=;
        b=XOBXAT1vpTnOWseSbXZT4SkBQ1Lz/7dQfxiiPRWyIkLOTXDr02UBqBhUW06embcUKJ
         oxv6JoFz8kCoezh8YZnS5rDPsvpol80wHehDLNBint36to1vJI3Wqm6/T/lR7lcGPLxY
         +d1IL/v/krZT2NU0PCJEQIK9KJvkOg4yM1Ci7jLCF4Chvg6+5fgsKxLEjHNz9a7Bjenn
         5lTDVbNA34fX8O+j+o1yY4qH5aOrbXzCXxH4UG8w/CKoBoSBLJ3dKeMdxg0iOZQAGcIZ
         wmn3SH4ib6cLRYVqOxxiNWSTOSs+esj4vtegNCsh2i9BmgraHoZaw3I0BdxZ8+xN7+YV
         IFsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfrJQ4D8IHIHzh1NO1zW1pq93gSyGyGawoG10kq5MBFuZ8qp7JOD+oiyWZbP73nBgR/4BlweO4DgramRuBMJyZ66/QOc2tvD5Yh/aB
X-Gm-Message-State: AOJu0YyeOc6VSml6rx8o+60KVO/4j755SAG922BBVB4nx4kpjQU4fz1s
	jQP2w32tdSgulLIr0GqioGmQ4iPtFeO0nOo1e7k0Zy1K8263r6Z6YY7pI3bz+UM=
X-Google-Smtp-Source: AGHT+IEoBxCQcRtXeleftoTFRk+T7pqbi9sMqRTWcAaHN3dxPrq61pjP46N3K9zl1ZQ4HnQvAEm7YA==
X-Received: by 2002:a17:906:81d5:b0:a44:4932:77bc with SMTP id e21-20020a17090681d500b00a44493277bcmr1078621ejx.40.1709214603416;
        Thu, 29 Feb 2024 05:50:03 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id hb15-20020a170906b88f00b00a3fcbd4eb2esm702668ejb.1.2024.02.29.05.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 05:50:03 -0800 (PST)
Date: Thu, 29 Feb 2024 14:50:01 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 17/26] printk: nbcon: Assign priority based on
 CPU state
Message-ID: <ZeCLic3zZEdi0-o2@alley>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
 <20240218185726.1994771-18-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218185726.1994771-18-john.ogness@linutronix.de>

On Sun 2024-02-18 20:03:17, John Ogness wrote:
> Use the current state of the CPU to determine which priority to
> assign to the printing context.
> 
> Note: The uart_port wrapper, which is responsible for non-console-
>       printing activities, will always use NORMAL priority.
> 
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -961,6 +961,22 @@ static bool nbcon_atomic_emit_one(struct nbcon_write_context *wctxt)
>  	return ctxt->backlog;
>  }
>  
> +/**
> + * nbcon_get_default_prio - The appropriate nbcon priority to use for nbcon
> + *				printing on the current CPU
> + *
> + * Context:	Any context which could not be migrated to another CPU.

Strictly speaking, this variant does not need to be called with
disabled CPU migration. The panic-CPU could not be migrated.

It would be nice to mention in the commit message, something like:

</proposal>
The emergency context handling is going to be added in a separate
patch. It will use a per-CPU variable.
</proposal>

It would also explain why this context is not handled in this patch.

> + * Return:	The nbcon_prio to use for acquiring an nbcon console in this
> + *		context for printing.
> + */
> +enum nbcon_prio nbcon_get_default_prio(void)
> +{
> +	if (this_cpu_in_panic())
> +		return NBCON_PRIO_PANIC;
> +
> +	return NBCON_PRIO_NORMAL;
> +}
> +
>  /**
>   * nbcon_legacy_emit_next_record - Print one record for an nbcon console
>   *					in legacy contexts

Otherwise, it looks good. With the added commit message:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

