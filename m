Return-Path: <linux-kernel+bounces-49238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3488467CE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87F2D28BC3D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5948017555;
	Fri,  2 Feb 2024 06:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4ZaMBDv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9287717547;
	Fri,  2 Feb 2024 06:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706853847; cv=none; b=BzcPslsGV9Lk/EoZZ2dmODDIeiL/NGH+E1apj3xxqx6CZ6b4yAfjKnZvenNq1YSL6uyEkPul/moO5ueRhniAhiSMwzS+QVh/GR62wBXXF+bzZM6RMYdsK6dHXBTBykY7okFRF8dIFEFAb49Uq8kJSPSJqk69ht38W+zX2n2VQnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706853847; c=relaxed/simple;
	bh=q9Ziz4l7b3bEIEH2wHez2bI0i2FEn3bnuA8lIONGyvA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kMNqw5WR9I71iuk6t2SD29YqhMGjLsV8N4KP/+UrsnKNHExjAXNonyJooATFd+UtGcGwr/z0eVi4UQH8SHjhG9DR1s3AEk12cbwYjBPNKFXHBDMjuxh5k7YG2//viP5BzoUd1UZyMGoEtPaVipr6pE7xW+RIv4ou2+3BSLk5ptk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4ZaMBDv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A38C433C7;
	Fri,  2 Feb 2024 06:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706853847;
	bh=q9Ziz4l7b3bEIEH2wHez2bI0i2FEn3bnuA8lIONGyvA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a4ZaMBDvUSerM5Vsg0MLGQqLfVm7VrWxHu/cuTIkI/Y/HWB2zGeRkFAyPN76RgEIK
	 DQs/AGTT99td7gh0zKLzNhKTLL1ht592bqDmGZUg3VNYkRaepuHBylB2Qo2974pVA1
	 rffwxp0mjeU1BWOuxiOMKi5i8zOdIhIWcWxP/RrUZfvFmDC28rDpTA539Ph6RnFt/p
	 ala226m6eC5JE3ItjRET3a0vzp8B9/CwWLjZN9uodGj9H072Osn6BkIrr/ZfpRmU/9
	 uoRGZ8O3XDoGQ6+/nrHvX4yVbiG02t3H/IHCjX1CfDx8tbd1+jPJ/Gla8t5yH6Q8MA
	 uNrZDK5NX/xLw==
Date: Fri, 2 Feb 2024 15:04:03 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: linux-trace-kernel@vger.kernel.org, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Pengutronix Kernel Team
 <kernel@pengutronix.de>
Subject: Re: Boot-time dumping of ftrace fuctiongraph buffer
Message-Id: <20240202150403.7ccc4126dbeaad8bdf77c384@kernel.org>
In-Reply-To: <d33e5271-219d-4b8e-be5a-8903219d7fd6@pengutronix.de>
References: <d33e5271-219d-4b8e-be5a-8903219d7fd6@pengutronix.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Ahmad,

On Thu, 1 Feb 2024 13:21:37 +0100
Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:

> Hello,
> 
> I semi-regularly debug probe failures. For drivers that use dev_err_probe
> rigorously, this is a quick matter: The probe function records a deferral reason
> and if the deferral persists, deferred_probe_timeout_work_func() will print
> the collected reasons, even if PID 1 is never started.
> 
> For drivers that don't call dev_err_probe, I find myself sometimes doing printf
> debugging inside the probe function.
> 
> I would like to replace this with the function graph tracer:
> 
>   - record the probe function, configured over kernel command line
>     (The device indefinitely deferring probe is printed to the console,
>      so I know what I am looking for on the next boot)
> 
>   - Dump the function graph trace
> 
>   - See if the last call before (non-devm) cleanup is getting a clock, a GPIO,
>     a regulator or w/e.

What kind of information you prints by the printk()?
If the target (suspicious driver probe function) is obvious, you can use kprobe
event and tp_printk. Or, even if you don't know, if you are sure which function
is the starting/ending point, you can use bootconfig to record the specific part
of execution in the ring buffer, and dump it as Steve said.

In Documentation/trace/boottime-trace.rst, there is an example.
-----
With the trigger action and kprobes, you can trace function-graph while
a function is called. For example, this will trace all function calls in
the pci_proc_init()::

  ftrace {
        tracing_on = 0
        tracer = function_graph
        event.kprobes {
                start_event {
                        probes = "pci_proc_init"
                        actions = "traceon"
                }
                end_event {
                        probes = "pci_proc_init%return"
                        actions = "traceoff"
                }
        }
  }
-----

Thank you,

> 
> For this to be maximally useful, I need to configure this not only at boot-time,
> but also dump the ftrace buffer at boot time. Probe deferral can hinder the kernel from
> calling init and providing a shell, where I could read /sys/kernel/tracing/trace.
> 
> I found following two mechanisms that looked relevant, but seem not to
> do exactly what I want:
> 
>   - tp_printk: seems to be related to trace points only and not usable
>     for the function graph output
> 
>   - dump_on_oops: I don't get an Oops if probe deferral times out, but maybe
>     one could patch the kernel to check a oops_on_probe_deferral or dump_on_probe_deferral
>     kernel command line parameter in deferred_probe_timeout_work_func()?
> 
> 
> Is there existing support that I am missing? Any input on whether this
> would be a welcome feature to have?
> 
> Thanks!
> 
> Cheers,
> Ahmad
>     
> -- 
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
>  


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

