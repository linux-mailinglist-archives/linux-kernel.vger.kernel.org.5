Return-Path: <linux-kernel+bounces-31636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA9E8331B3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 00:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B14362847F7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 23:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823BE5917B;
	Fri, 19 Jan 2024 23:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9BT//+n"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CD855E63
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 23:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705708671; cv=none; b=hlW8l7RQU+Sxf7EbMlQwnmIBXx4C0uW9Gj1gjJttuLLFNs25xx3tAZ01930j0yzRJCkpt4zRGqNtFYZupu5ajE/rphUis5SAsJ6tdrpr5f6J+3R7Xyaax3qZvWhK++FU4eorGGqH7/0edPep0lXzQidR/R1FpyXhSpCuEw+fQ08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705708671; c=relaxed/simple;
	bh=d+kyZBnSMGAMeH2tRQB9dVuey0EYIkA2ubcgG5TybpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gt6DU3ECQ7KIMAIuA2xrs7XlMld83nyZ1E95OmCORuGIUjkKhzvgeyPq/GpBt/pQEVgVPIlgNRJf0OAhbvHqQwqSxdhT3iEsGOXxwcJHUgpnVpdLiIYDj7YhFY8s2ZfXAOEIe4EOPeGv8zD4D420FqEP1H62mV50m9WgJRcZ5pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9BT//+n; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-28bec6ae0ffso980867a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 15:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705708670; x=1706313470; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GWMdx0fINotNtujTj4fTXjkXpaMQwO69VYzEDHZPfTs=;
        b=h9BT//+nRY3u5RGxf5+7/yfuEinS0oy/eFr/znv1xE8PD2vb3IpN1hBYCwve6CZoYD
         YecHpyPl5kwEuOSBa3X/XZDoG6/taiROIdffub3K1LZTAwPKcp1Sf6zKTVPlqOmaku1z
         nTNv/xc+RZEP/cFYqcJyZ1tbtSnuOwaeRBXRZvL0ccLLd/+1wtK/3aPLIgUwt2qod92z
         ymUmmERb6CZwtmpIj4GQgGFKUKw6B+u9fRObhQ1BurRGKzaM7fs6bkl20kTjsTlQ0EIL
         OMWv+LqybXxI84bs0JPDsr/xic8DOxfGCw22aGNQjKpr1M25BkfXyWCBwYjf6NTmBLu+
         TWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705708670; x=1706313470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GWMdx0fINotNtujTj4fTXjkXpaMQwO69VYzEDHZPfTs=;
        b=NY8GwFCcdg557PaSUAQFZjBxkeMwsKtVZegs7oUc8aoTgpkn4a2kg+93U+hag+icEh
         zaLFFrfV0VX/PVqF9WNrqAsuYoLXF6mj0xfhu9qTExH8R/TRyaCRtQIesiSthaRn1PwO
         +M0tcv2yoDTgJwyiGg6j9FiOjasftXQVDFQUWE5HLfsKj+sRqQj14P7se+FhTI3imAyb
         501CUUq7HH50STKzNlWjr1sNnQoEF1IfhCtinKBxu577VsuU54jOu7CZBACiUWl1/L3m
         dYvw8xX0hCcmI9XJpzXW9AuO+HvHa9wESIhJJSN4wKGIIjZgC2Da670LYkVmbgStVVmD
         9BSA==
X-Gm-Message-State: AOJu0YxUbT+9NkUy0XsjWLByv00wCHneR4qv8g41nF0hkPR6tK8Rk/kr
	TJb+OUSx1NifwYF1w+TmwMz6maCLLS+qiCAvp9V0fcH8Ub7eAxrd
X-Google-Smtp-Source: AGHT+IGcALPI40KkmE93wHhBFCjERua2rQpFm7XeBFWqxUESW57/mnYDudph9ku3c2LpoxSWJeW4Fw==
X-Received: by 2002:a17:90a:9910:b0:290:2494:3d31 with SMTP id b16-20020a17090a991000b0029024943d31mr495721pjp.23.1705708669570;
        Fri, 19 Jan 2024 15:57:49 -0800 (PST)
Received: from localhost (dhcp-72-235-13-140.hawaiiantel.net. [72.235.13.140])
        by smtp.gmail.com with ESMTPSA id dj7-20020a17090ad2c700b0029065f70565sm304672pjb.41.2024.01.19.15.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 15:57:49 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 19 Jan 2024 13:57:48 -1000
From: Tejun Heo <tj@kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Joe Mario <jmario@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mark power efficient workqueue as unbounded if nohz_full
 enabled
Message-ID: <ZasMfA-v1YykDA1i@slm.duckdns.org>
References: <ZaqbP0QmVPAQTbYA@tpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaqbP0QmVPAQTbYA@tpad>

On Fri, Jan 19, 2024 at 12:54:39PM -0300, Marcelo Tosatti wrote:
> 
> A customer using nohz_full has experienced the following interruption:
> 
> oslat-1004510 [018] timer_cancel:         timer=0xffff90a7ca663cf8
> oslat-1004510 [018] timer_expire_entry:   timer=0xffff90a7ca663cf8 function=delayed_work_timer_fn now=4709188240 baseclk=4709188240
> oslat-1004510 [018] workqueue_queue_work: work struct=0xffff90a7ca663cd8 function=fb_flashcursor workqueue=events_power_efficient req_cpu=8192 cpu=18
> oslat-1004510 [018] workqueue_activate_work: work struct 0xffff90a7ca663cd8
> oslat-1004510 [018] sched_wakeup:         kworker/18:1:326 [120] CPU:018
> oslat-1004510 [018] timer_expire_exit:    timer=0xffff90a7ca663cf8
> oslat-1004510 [018] irq_work_entry:       vector=246
> oslat-1004510 [018] irq_work_exit:        vector=246
> oslat-1004510 [018] tick_stop:            success=0 dependency=SCHED
> oslat-1004510 [018] hrtimer_start:        hrtimer=0xffff90a70009cb00 function=tick_sched_timer/0x0 ...
> oslat-1004510 [018] softirq_exit:         vec=1 [action=TIMER]
> oslat-1004510 [018] softirq_entry:        vec=7 [action=SCHED]
> oslat-1004510 [018] softirq_exit:         vec=7 [action=SCHED]
> oslat-1004510 [018] tick_stop:            success=0 dependency=SCHED
> oslat-1004510 [018] sched_switch:         oslat:1004510 [120] R ==> kworker/18:1:326 [120]
> kworker/18:1-326 [018] workqueue_execute_start: work struct 0xffff90a7ca663cd8: function fb_flashcursor
> kworker/18:1-326 [018] workqueue_queue_work: work struct=0xffff9078f119eed0 function=drm_fb_helper_damage_work workqueue=events req_cpu=8192 cpu=18
> kworker/18:1-326 [018] workqueue_activate_work: work struct 0xffff9078f119eed0
> kworker/18:1-326 [018] timer_start:          timer=0xffff90a7ca663cf8 function=delayed_work_timer_fn ...
> 
> Set wq_power_efficient to true, in case nohz_full is enabled. 
> This makes the power efficient workqueue be unbounded, which allows
> workqueue items there to be moved to HK CPUs.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Applied to wq/for-6.9.

A side note: with the recent affinity improvements to unbound workqueues, I
wonder whether we'd be able to drop wq_power_efficient and just use
system_unbound_wq instead without noticeable perf difference.

Thanks.

-- 
tejun

