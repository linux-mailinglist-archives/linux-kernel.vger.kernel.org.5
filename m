Return-Path: <linux-kernel+bounces-72820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2DA85B911
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B68EAB25C08
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906DE60EDE;
	Tue, 20 Feb 2024 10:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JzWnAvH8"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61882612E2
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708424806; cv=none; b=r2umxcMzOHJ1WF9S1/N9NQlVvCeLTiFMhY/md8i/jBnr4QnIB9T1ZdHpZhrCuUf4+tvMKSxOatJRkhh/DbRSB/asWph8j1uMPjyp+C19+GhS/0W5fa8wyBZ4/8xkjv9zg84HZR3dy//AlhSSuKusYELpNpbVZ90o9ZQAF6fsoco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708424806; c=relaxed/simple;
	bh=UbdGD3nZopvYspQWvksbNHC5ctRZvbWZyzdQm6MqcwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UX/q+E9TsemMH/HmH8+1yFW4t8ppvp1rvE+uRYOERPOUbK6R6oS/GsTgXyPh1fT+ySqZKEadzwTcxKsgS8MBh5mV4u8hXBuZKCiZxJf8roYnk5OaQ1Bvay/KXhx4EqhWaVCnck3dQJYSHMj1bBV+KU8ZBuCSY4exMrHBHC8NrKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JzWnAvH8; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-563e6131140so4829935a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 02:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1708424802; x=1709029602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qzMzPVH/PcFAooYvsiGIOEAcodet9zh9VPCF8I5O13E=;
        b=JzWnAvH8DwkvQ6dJkkbIGxpSEECAqMt00Sh014MrZlJPIkiwgwpUSR25iG+tnV9yHE
         CIMw+jUk3A21Axv/99Z0nuJZe3MUzT5e9FrOSvDlgUUbbaaJjFrXUuV8kn1h51SNbtX8
         vEH7lPBicxVa5cqlGJSFkWn4b4O7hrFQs9yG9ypsNpNWRvah6qMcMsobp92w2d3kPID5
         vD86JzELSd9uDy41qFpTZIJAAt+SN9IBBgiSN7Rt5GdpTLXxE4yCG+imXtBdeHmIzy+1
         XTY74DieqmWj3ilu/KDHo/xAAPtur5S0pkwRn7FEd0mvani0sHRSLTEq69DcidAPLYnB
         ATWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708424802; x=1709029602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzMzPVH/PcFAooYvsiGIOEAcodet9zh9VPCF8I5O13E=;
        b=kfuWDkeyM7YWYW7gDStx9eK5NiZhABKKdKh7B4EYyoitVKgG40OYPWmEPNWYFoRjpW
         lwy0baowAqAb5bRoitJDWIUsQ5QpQl15b93e+1dTBit4d8/6paVBhFmdw608amyYXwZb
         pFaWpYQDHhIXy1GNvzM87SraIhI+wXJ76+jOgt0+QggChC3a6Tt64lO3wXXnHQzgZM5k
         l7eWiFjkMUcTCM9nfHtxQhVI+Br7hthhwtbBq7KNLspcPR+276u8vbDohYmU0CeIoMg1
         OM2QLep1WdTg28ayD+zcjeBU2YMCm3/W6+iDuaIps0GZYRxaCQrP0UWQPNJFObEKAoMP
         xEUA==
X-Forwarded-Encrypted: i=1; AJvYcCXLf4y8J+KjT4m+E5RziLh5VIth0TREH0Us22c3Y5rwJVHGhKBVB8LjfsIEey185tjF/yZKVnQWypuS3EYqePchqLKu5PNcDVzWFZPc
X-Gm-Message-State: AOJu0Yxh7jUmg29F+jqPmJLxIMakJDdUcnI5QT6GrlncaIzt32SDL7Ht
	8s3ysto0SnKNZxUu8SCJZKCj/rSol3hb9AX6d/EYoFGVfarrlwENfFheN/lE+qpJmWWDtkjIrPK
	s
X-Google-Smtp-Source: AGHT+IE8ZdOONgvs/zhC2gfKBJF3+fpil5OUj4Q+EnbN3SvrWUoz/ig/NiNJFTVLPm5DSMOpHFmV/w==
X-Received: by 2002:a17:906:d212:b0:a3d:af58:5f99 with SMTP id w18-20020a170906d21200b00a3daf585f99mr9027827ejz.21.1708424802563;
        Tue, 20 Feb 2024 02:26:42 -0800 (PST)
Received: from alley (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id f16-20020a17090624d000b00a3efce660c2sm431546ejb.198.2024.02.20.02.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 02:26:42 -0800 (PST)
Date: Tue, 20 Feb 2024 11:26:41 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 04/26] printk: Consider nbcon boot consoles on
 seq init
Message-ID: <ZdR-TTVpXziZ7RXo@alley>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
 <20240218185726.1994771-5-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218185726.1994771-5-john.ogness@linutronix.de>

On Sun 2024-02-18 20:03:04, John Ogness wrote:
> If a non-boot console is registering and boot consoles exist, the
> consoles are flushed before being unregistered. This allows the
> non-boot console to continue where the boot console left off.
> 
> If for whatever reason flushing fails, the lowest seq found from
> any of the enabled boot consoles is used. Until now con->seq was
> checked. However, if it is an nbcon boot console, the function
> nbcon_seq_read() must be used to read seq because con->seq is
> always 0.

This says that con->seq is always 0.

> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3391,11 +3391,20 @@ static void console_init_seq(struct console *newcon, bool bootcon_registered)
>  
>  				newcon->seq = prb_next_seq(prb);
>  				for_each_console(con) {
> -					if ((con->flags & CON_BOOT) &&
> -					    (con->flags & CON_ENABLED) &&
> -					    con->seq < newcon->seq) {
> -						newcon->seq = con->seq;
> +					u64 seq;
> +
> +					if (!((con->flags & CON_BOOT) &&
> +					      (con->flags & CON_ENABLED))) {
> +						continue;
>  					}
> +
> +					if (con->flags & CON_NBCON)
> +						seq = nbcon_seq_read(con);
> +					else
> +						seq = con->seq;
> +
> +					if (seq < newcon->seq)
> +						newcon->seq = seq;

But this sets con->seq to some value even for nbcon consoles.

It would make more sense to use nbcon_seq_force() for nbcon
consoles here and remove the copying from nbcon_init().

Otherwise, it looks good.

Best Regards,
Petr

