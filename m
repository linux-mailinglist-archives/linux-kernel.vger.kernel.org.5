Return-Path: <linux-kernel+bounces-88778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8FF86E673
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B84C28A7F8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7427E38FBC;
	Fri,  1 Mar 2024 16:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TvL4sdkh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DF22F3E
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 16:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709312005; cv=none; b=M01kuaGwuPdVEzhikp0Z1IMkaQwPUUWGBip763iXWJkx0zZx2ZoRqUxIMCTJ4/0R/i7OQRMp65293HyajTQV+PnthYonp60xDPncrqttkGzzUNsEpYQt/Fg5CGvLuHvs2WLjaCTNRHBNP+DttIzTT9CZyigo+C/laT1SHiltoo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709312005; c=relaxed/simple;
	bh=Bxr2z1UM0sWuyWBlEwdzeGviNQBX/Cz7gaBXN/LSnFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvVGyLbQhPE/Z7x5kn/pzGkuSHtqPQFOdEvkM6JFVywIxwaf1HuNwltJb9upRBBk6NXfv/YlNVghx4uHl5GU6XbMGeAjov4Gfq58KaxQEU1169iXuteAAqSTCNoT6K1lW3KO0Ha1RfRW8kdcg3DnoTcmGhGkCdb41QW9BmBQZOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TvL4sdkh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709312002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mnTwiMADK8/eZ4X5li0kPAr1pEQ+f6B4THtEc6ABCsk=;
	b=TvL4sdkhcQz74QIT538FOuG8UPbFtNb5jB957X316FGUIE8F/Ytg3J8Thv0M0J3FDwoLQy
	RxHFpy0py6oGvZI584gH5fXu3kAndUFESLvByQbkvuotk8wLhxvNdMsGKUkTZwcx1tS/VX
	BGIFWQrTBX4+BLn1GRHhEhtgEtr3RlA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-SfY_3-pQMCiEjUTw1RGCGw-1; Fri, 01 Mar 2024 11:53:21 -0500
X-MC-Unique: SfY_3-pQMCiEjUTw1RGCGw-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-78810ef9d5aso30551785a.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 08:53:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709312001; x=1709916801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnTwiMADK8/eZ4X5li0kPAr1pEQ+f6B4THtEc6ABCsk=;
        b=btIdCRhDRimM5rUudOIuRUfDy6yrR98+NVc0akjluux/TGYrP1bKFa1KQFtqlLbe7d
         27vXOrzjMPXLblpzKUnB/zuRXtAeZEc8m+SmBCSzUOt88NAgxeAhvOIUC83xTb5klIU8
         QSumTCi08liX1BeD4raSCQOVbMvyhRI1hSB7KFGU50RwyVfIzu2twPpDb3UW0SjxAyYu
         8B8AMXVAOHwTMV1Uqb0FdvBaot7DI/VcwdKXPmVfOHFQSEnjZXYwISmbR8bo6JbquFKJ
         QN3FCr3s1asemQzcob/klz2fGkS6YJifl2rK5iiPMIo23jGZeukc+3Tov7LONPZLIYyG
         oxTA==
X-Forwarded-Encrypted: i=1; AJvYcCVM5pcz+K6WshyCq98qP8gKnJsbWafnAt5J32My0y/1RiYdw/0Y+WnJ+rVW9O67lvhPKQTqa15hVEduWh9uZRx9p3anHc5Xqp5+Iou0
X-Gm-Message-State: AOJu0YxzW/XY/E3kTCDuebqIZrSUsVu5AeUSFGXUAfllNKVryipiBA3c
	tPdk+kkTxrkdPNjxlEpxc76hKP4zWHxmFeFVmm7N7K7IWTxIODAqy2lKhyLNy/TOJjSRV3PMY4i
	tMoCwBUd0PtE0j2RXcH0ModqSH1IiQCSlSB2rD6jmjAsLQJ6fhbfA+E2/axGeLA==
X-Received: by 2002:ae9:e119:0:b0:787:ec02:92f4 with SMTP id g25-20020ae9e119000000b00787ec0292f4mr2233161qkm.19.1709312001070;
        Fri, 01 Mar 2024 08:53:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdyu/Q+jPAX2NusR1rW5HWBPK4b/7c04/rUi1ZZ5DQbDJ5K9ToAF5bsYSo1bU39ml2s/y2LQ==
X-Received: by 2002:ae9:e119:0:b0:787:ec02:92f4 with SMTP id g25-20020ae9e119000000b00787ec0292f4mr2233147qkm.19.1709312000847;
        Fri, 01 Mar 2024 08:53:20 -0800 (PST)
Received: from thinkpad2021 ([71.217.42.17])
        by smtp.gmail.com with ESMTPSA id b5-20020a05620a118500b00787ec3a77c4sm1781021qkk.100.2024.03.01.08.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 08:53:20 -0800 (PST)
Date: Fri, 1 Mar 2024 11:53:18 -0500
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>,
	Clark Williams <williams@redhat.com>, jlelli@redhat.com,
	Derek Barbosa <debarbos@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: NMI Reported with console_blast.sh
Message-ID: <ZeIH_l4T2uIanMyZ@thinkpad2021>
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

On Thu, Feb 29, 2024 at 12:15:28PM +0100, Petr Mladek wrote:
> On Thu 2024-02-22 00:21:19, John B. Wyatt IV wrote:
> > On Mon, Feb 12, 2024 at 04:23:04PM -0500, John B. Wyatt IV wrote:
> > 
> > I found 2 additional NMIs for a total of 3. Number 2 is very
> > large-please feel free to let me know what specific information you
> > wanted if it was unnecessary.
> > 
> > This first one (the original) is with the real-time profile (no preemption).
> > The next two are with the performance-througput (no preemption).
> > 
> > This is what real-time NMI reports with the caller information enabled. It
> > looks like it is lacking some information compared to the other two further below.
> > 
> > [ T2481] Call Trace:
> > [ T2477] Kernel panic - not syncing: sysrq triggered crash
> > [    C0] NMI backtrace for cpu 0
> 
> This message seems to be printed by nmi_cpu_backtrace().
> 
> I am surprised. I would expect to see the backtrace printed from panic().
> It calls dump_stack() directly on the panic-CPU. And this panic() should
> be called from sysrq_handle_crash(). IMHO, it should be (normal)
> interrupt context.
> 
> Is it different on RT?

Yes. There are no NMIs on this machine in my tests for when I run an RT
enabled kernel.

> 
> Or have you somehow modified the kernel to use NMI for sysrq?
> 

I have not modified the kernel source code from 6.7.0-rt6.

-- 
Sincerly,
John Wyatt
Software Engineer, Core Kernel


