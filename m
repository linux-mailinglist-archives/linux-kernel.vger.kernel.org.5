Return-Path: <linux-kernel+bounces-86620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD8286C7E7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 887C9287549
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5DC7B3F1;
	Thu, 29 Feb 2024 11:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gqa1zfhZ"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D3D7B3C5
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 11:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709205586; cv=none; b=W9z+4LS4auR9Yylm7nCuT4M5SvGzv1ZxM/6ELvCpMDcJK8rk9xDc4qu2U5qQfGkm86EzwhCOvVeL77zRCrALWbPX2QsxqppwgNE8hSWWH6txZDOc7f0or1FuEgFdv4Lb8PAktVoT2V60a0fc3IQyIMEJOO8SflW+dL+76OmSklI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709205586; c=relaxed/simple;
	bh=CrfqeJfglTo/ajTyw1Gwgn0fWvXeO8/9hjzuKoGnGV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lK6gRbEOe3ofj7rN8g0guIV1aAAXtCp4A8KkuFvPmB9XpbHdXwQWJecIXKnbQjtB+moVaOIGcTWOXD+2GGLXuEEpeJg8gje2fL6dpb3HAYJpBwueUaU400XriWt+Ly3DjKOD0OqFEPncdIHF9qJfddu4ydp6gyE3BqF9gptM4RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gqa1zfhZ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a43dba50bb7so115752866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 03:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709205582; x=1709810382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Z3D5o73PHWTzmlfs+M2Cnag+Z5lMOi+i4eWtfpyC5s=;
        b=gqa1zfhZpH/XoQsnsXOeJQE3z4zB0jQ/0A05eCIxqGXr7tkxtMxIzNVamr5yLMQ4gm
         jdVcMEUTXzK6Yt9a8n+XRurTm1Y8c/bK9G2Wt/uiC86RzKkydDgXDhDZY2Blpr+xwhsb
         hlk0n/q8cGNbKxRFY8UzyC2gMNhyvS46te7HJhXv+8yjMYCBjIRXjckPmENZgB2EcZRL
         DlVCJoVeZkgtyWW8aCFyptr9HUa056uqELyv2pwNgqJ2781ZQXtkAHnlFqnnl6NrAKt4
         cVzQltFlMEHg47/XF7yOhOoF3pZxXkAV/fseMG1ied5B41A3VYER06ZKwlGCsqcIwKFa
         pseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709205582; x=1709810382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Z3D5o73PHWTzmlfs+M2Cnag+Z5lMOi+i4eWtfpyC5s=;
        b=EtwzePbXN7InEzEEsMc3z8kzZKhPCM3wrxp3rnYuTZ7JXX7xr4lS9xqtA7EPfvw1l1
         O8FMT4y99I0rp+OmUyHVoG/gXKy6W+QrWvIy/Dc59FpCqusIGu77C5qgNixch18sljAa
         ga8er8qrNvSicmFg30EHeMlmV0PDZF8HYlvChr9Lq/jRAg2OTemMXcgmIJ7zEiGEMfPX
         GJYi66QgkVWunpF8qcA40cyfyzDQh/S5QGI/peqOm/XSZed9olAPrwiDYAraaO/v7PAP
         WYb7I5W2QvP4m5NpLmPvzeSPCLEyr5GWW2n1X4iPLscw0BLsCTp0QJ8z3TDIFWqv6q6J
         yTrg==
X-Forwarded-Encrypted: i=1; AJvYcCWEvU3qAjbQHet6fWZLXgMvTqgovpuw/F1l27AwtQqT2V7jgt9ruiq8peFQkEx1+65aT3556H0GfwDCbHU79tlyunT6sziyXb2Eqmgn
X-Gm-Message-State: AOJu0YyhWaDgURa9+0GJmpfBuRFbbJfWgNin6jNPmCiRlikycmOJEVf9
	BgwVJwU3zURA7cWu1PgbhUCdSSpsnP1aSw3VGlQPa603gS3j4i6P0Ej5bHAHG64=
X-Google-Smtp-Source: AGHT+IEiTJIiVnJYh/o1Q6xEvLv1ebup90kGwCYruTGxf4JFDCbY03BB8m2v4P8ypxT/TpQ4Rn8CDw==
X-Received: by 2002:a17:906:474c:b0:a44:553e:5a1d with SMTP id j12-20020a170906474c00b00a44553e5a1dmr539793ejs.20.1709205582558;
        Thu, 29 Feb 2024 03:19:42 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id r9-20020a170906550900b00a3d5d8ff745sm588862ejp.144.2024.02.29.03.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 03:19:42 -0800 (PST)
Date: Thu, 29 Feb 2024 12:19:40 +0100
From: Petr Mladek <pmladek@suse.com>
To: "John B. Wyatt IV" <jwyatt@redhat.com>
Cc: John Ogness <john.ogness@linutronix.de>,
	Clark Williams <williams@redhat.com>, jlelli@redhat.com,
	Derek Barbosa <debarbos@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: NMI Reported with console_blast.sh
Message-ID: <ZeBoTNe2cjb4BeXb@alley>
References: <ZcQjxa4UA6hzXHnU@thinkpad2021>
 <87v86yc88b.fsf@jogness.linutronix.de>
 <ZcaQI8l1dcBx2feC@thinkpad2021>
 <87a5o8j9gp.fsf@jogness.linutronix.de>
 <ZcqMOKtHsZ9qnxNg@thinkpad2021>
 <ZdbZz-v_lug9_t6C@thinkpad2021>
 <ZeBnUCk598gttpds@alley>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeBnUCk598gttpds@alley>

On Thu 2024-02-29 12:15:30, Petr Mladek wrote:
> On Thu 2024-02-22 00:21:19, John B. Wyatt IV wrote:
> > On Mon, Feb 12, 2024 at 04:23:04PM -0500, John B. Wyatt IV wrote:
> > > 
> > > Red Hat's conservers are having an issue with the machine I was testing
> > > on. It may take me a while to get back to you with more test results.
> > > 
> > 
> > Found a work-around with conserver. I was able to follow up on the printk-caller
> > info you requested.
> > 
> > I found 2 additional NMIs for a total of 3. Number 2 is very
> > large-please feel free to let me know what specific information you
> > wanted if it was unnecessary.

[...]

> > Compared to the two NMIs with throughput-performance (no preemption)
> > 
> >   <NMI>
> >   cpus=0
> >    .runnable_avg                  : 3072
> >  kthread (kernel/kthread.c:388) 
> >    .util_est_enqueued             : 0
> >   stack:0     pid:1733  tgid:1733  ppid:2      flags:0x00004000
> >    .min_vruntime                  : 2084315.290254
> >    .removed.load_avg              : 0
> >    .avg_vruntime                  : 2084315.290254
> >  console_blast.s  3497     34770.405603 N     34773.405603         3.000000     34764.898340         4   120 
> >    .util_avg                      : 1024
> >    .util_avg                      : 1024
> 
> It looks like messages from more (many) CPUs are mixed. I guess that they
> are printed by print_cfs_rq(). But the order looks random.
> 
> Also I wonder why it is printed from NMI context. Maybe, it is from
> some perf event, similar to hardlockup detector?

I have realized that we most likely see only small part of the mixed
output. I wonder if it is because it is printed from the emergency
context. Here the messages are flushed when leaving the context
and many might be lost.

Best Regards,
Petr

