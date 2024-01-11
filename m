Return-Path: <linux-kernel+bounces-23346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C15DD82AB6B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62113B26B22
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAD411C93;
	Thu, 11 Jan 2024 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wTJpXToq"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C943D11722
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e5bfa260bso7286255e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 01:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704967064; x=1705571864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rg4wmvX3JEOaUNaxPXlZ7EWQ7WRH8BzbgnD+DbwJ0F4=;
        b=wTJpXToqIk/NfMbqCeC9MkhPDYBPWG3JVNkOxnbMGT/7eDvni9Vo1m1gGEtnGqOmWM
         jcD5QIdtHknMHLW9OjlD07Qmy0sUOQ7PU/4jV7/w9HsDMrQ4Bqv/Qfoa6vSA+/GOwQ+v
         Xb4F2m5DWV/OMnQVoioLzfldab6TvMRoCHfgYyckwcu1dTg0tpj7OW1GcIw3wcjqS8NH
         8hzv1kfT+Yvu8Py/J7G9FHide9zm8htbSQB28rgHnVVk0PLYI0utX1XtJW/ef8dmHQ4L
         oJgWm0ULp1whpVhuk0bge0igvtvMasVYYRoPwX1oTH5KorkMgKRVJpH6O4nnenTcZy1C
         GEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704967064; x=1705571864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rg4wmvX3JEOaUNaxPXlZ7EWQ7WRH8BzbgnD+DbwJ0F4=;
        b=uga4BL/AAyo3W1ITIOBW6UiJLPly2AY+D6J0wmQnt8h0ohKpK5rq83MF6xIWJrnDl5
         esnn4cVyEbw9IQZbBUC4t70ZOqsAWaxoMmGR79hXvVEoQDSGdspdMc26F5xFMh0mwkls
         wniyn8h+6KH1G5y7Y1N4mxULven1Mcvd/UN9ci7KbYbgnwncaW4POugZefqpx2fGrQXO
         j1Xlw9uKVk3UQAaWKiAk7NFlGVhERspzDwgFygRZurrbuskyOlX2HzDoo97ccMK86Dnc
         bBzZh8F6QyFe07J8rDCOObbjc/62GT5/wluxTuFcypLyQKXvEO+QEckx0o6Agwy5x644
         MEEQ==
X-Gm-Message-State: AOJu0YyHikZv7unp7LpQ6Syil2VEfIxqdzCtHNXkHuraPvDwsADtlHRm
	/lpEoOrGLaKtVbEHQ2xea5ZgM6NiLuW3
X-Google-Smtp-Source: AGHT+IFWQ7HjjFwL9jphsXkUr1ha9C23n3m/RGsKF2r+L/5P4ke4UxRNrHgL59yiDHchMve6GiWrwA==
X-Received: by 2002:a05:600c:4f0d:b0:40e:5967:742a with SMTP id l13-20020a05600c4f0d00b0040e5967742amr122111wmq.299.1704967063883;
        Thu, 11 Jan 2024 01:57:43 -0800 (PST)
Received: from google.com (185.83.140.34.bc.googleusercontent.com. [34.140.83.185])
        by smtp.gmail.com with ESMTPSA id o8-20020a05600c510800b0040e624995f1sm44258wms.8.2024.01.11.01.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 01:57:43 -0800 (PST)
Date: Thu, 11 Jan 2024 09:57:40 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	kernel-team@android.com
Subject: Re: [PATCH v10 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <ZZ-7lAdAUxlwoY0z@google.com>
References: <20240105094729.2363579-1-vdonnefort@google.com>
 <20240105094729.2363579-2-vdonnefort@google.com>
 <20240109234230.e99da87104d58fee59ad75c6@kernel.org>
 <ZZ1ir0edlY3OzjyC@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ1ir0edlY3OzjyC@google.com>

[...]

> > > +	 */
> > > +	smp_wmb();
> > > +	WRITE_ONCE(cpu_buffer->mapped, 1);
> > > +
> > > +	/* Init meta_page values unless the writer did it already */
> > > +	cmpxchg(&cpu_buffer->meta_page->entries, 0,
> > > +		local_read(&cpu_buffer->entries));
> > > +	cmpxchg(&cpu_buffer->meta_page->overrun, 0,
> > > +		local_read(&cpu_buffer->overrun));
> > > +	cmpxchg(&cpu_buffer->meta_page->subbufs_touched, 0,
> > > +		local_read(&cpu_buffer->pages_touched));
> > > +	cmpxchg(&cpu_buffer->meta_page->subbufs_lost, 0,
> > > +		local_read(&cpu_buffer->pages_lost));
> > 
> > Instead of using these cmpxchg, can we move this initialization before
> > smp_wmb()? Thus we can avoid conflict with rb_update_meta_page()
> 
> Good point, Not sure why I made this more complicated than it should be.

Ha, I know, that was before v6, where the writer was updating all of that. From
v6 the update has been moved to the irq_rb_work.

> 
> > 
> > Thank you,
> >
> 
> [...]

