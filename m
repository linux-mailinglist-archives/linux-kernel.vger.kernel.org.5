Return-Path: <linux-kernel+bounces-43396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E43B841352
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 534161C243F1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14FC4CB58;
	Mon, 29 Jan 2024 19:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="cIyoTMTe"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373C74C631
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556230; cv=none; b=rDCVpsZSmJce8x4mTJVL3bEadtZyNULgB3UTEdaynGsCLSROrCeALa3wJELx2wVsPZkckGXWghov/HuPoLa/5MrUMkL+eyZ/BnvLsLTfCwDjjYBv+F0T5oa2J9YTcrJB1H/wKHNFePItqd7vbSvwmCCfBwkAvTRl207BTO+3v7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556230; c=relaxed/simple;
	bh=+l5uPTCRmLkpHZQORHGpDSwq129ffrHrqbctuLZjK1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHTeNcAh86Z9pDAiw2PSGjoJZTtks0gGx2ybkXa2EB0OjlDLczpoqH1evKeg4fXt7vAicsjFyjrnGIihhRTEFRskM8BpiIQ2D7EDR5UO3hONF/TrrJX6GLrNAzCf2g/7JEDuQ/Cl70SHQx606SGA70l76NxiumOamxu6ZqjXHdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=cIyoTMTe; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5cde7afa1d7so1125898a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 11:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1706556228; x=1707161028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lM8dW41dYzMNR1IezcaNi16rpbWz1i11PWD6HJFVVTs=;
        b=cIyoTMTe/IaoqMyS1WQqgTgQE+v/szjMvnz1eB4i4NRxc9cfngPHZ7YYaX2rA4gN31
         M0ZZ5IwZ6/JUNH/jk4yAuNqzds0mDwhboXbePc1cBeug47jIE6DLBPLxuVd7Z4uo6t91
         qlSZv4EGZVpnLX24lrH7DK5uguWdMSUfN6W1IicWGovypIkqRDOcj5zWGjQqZ8UBZlLB
         VKAnMr1OyxvRCFsoYHVPtko6k/5zCslir63dCu3zzy30RiqC3TbeXqsUbmKfoLq1RHwD
         g4W/jPiDKzenC7+CzatjWqYB2bnvu2sFVqfq2dqMUjW8aAuqWWM1yXh3AT1VgfELFlzC
         gBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706556228; x=1707161028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lM8dW41dYzMNR1IezcaNi16rpbWz1i11PWD6HJFVVTs=;
        b=G3L6vnf18Wf4rc9iTY/OHBbcg1965SikedyDkknwHDlurGBBnVfyz9geDgJ58JNTjz
         JMRBIDbLABfawA+Y5Q/pyS6e0yw1800dIJAkwseRutyyK2LyMDJ4FRwb/dhnkxPoihal
         FhdpsVUnos1COGxJ1L07Ag8AK/X9UvCEncVx0LiNEHHzfG7nUMwWvcvnslcdAQmD2rea
         8gBe3+XRKeQlGH1H2xh4fv8sdY1SuYxSOud2/QosoSDucrtupneNz1d3kSXK0RVSdN+m
         SqFduc46PXRfSTy/rsx/ge1EQGeehoQyLRUiNTH3Fg7e897w3uv00uNRdZ0GDsYs0OT5
         dNZw==
X-Gm-Message-State: AOJu0YypJI4d9rQWjzmxaxlLuSEWB15K11Rxw1k4yGXYC+qQeqO7dFvy
	qv81vx978+DYrhuTNUBS8Dg3VTA2KnuYwUcmTtVG32kQ6vktJrb00BViN2S+wF8=
X-Google-Smtp-Source: AGHT+IG8efB5GD+wyO+f9WPm+mHAS0TcCH6DWGYOy/DU0f1khE8ut80OS9OLFzrD74bLNqI0qj56og==
X-Received: by 2002:a05:6a20:e58a:b0:19c:a2ff:975e with SMTP id ng10-20020a056a20e58a00b0019ca2ff975emr1951953pzb.45.1706556228480;
        Mon, 29 Jan 2024 11:23:48 -0800 (PST)
Received: from medusa.lab.kspace.sh (c-98-207-191-243.hsd1.ca.comcast.net. [98.207.191.243])
        by smtp.googlemail.com with ESMTPSA id y136-20020a62ce8e000000b006de30d6786bsm1852379pfg.126.2024.01.29.11.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 11:23:48 -0800 (PST)
Date: Mon, 29 Jan 2024 11:23:45 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
	abdhalee@linux.vnet.ibm.com, mingo@redhat.com, will@kernel.org,
	longman@redhat.com, boqun.feng@gmail.com, sachinp@linux.vnet.com,
	mputtash@linux.vnet.com,
	Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
Subject: Re: [linux-next][mainline/master] [IPR] [Function could be =
 "__mutex_lock_slowpath(lock)"]OOPs kernel crash while performing IPR test
Message-ID: <20240129192345.GA2300500@medusa>
References: <67f349e2-33f1-30a3-f92c-3c0a68d6d22f@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67f349e2-33f1-30a3-f92c-3c0a68d6d22f@linux.vnet.ibm.com>

On 2023-08-27 13:56:14 +0530, Tasmiya Nalatwad wrote:
> Greetings,
> 
> [linux-next][mainline/master] [IPR] [Function could be =
> "__mutex_lock_slowpath(lock)"]OOPs kernel crash while performing IPR test

Hello, 

We hit this issue while testing 6.6.9 LTS kernel and I narrowed it down
to commit fcaa174a9c99 ("scsi/sg: don't grab scsi host module reference").
Not holding a reference to the scsi_device caused the last reference to
be dropped in sg_remove_sfp_usercontext(). This caused request_queue to
be set to NULL in scsi_device_dev_release(). Passing NULL to blk_trace_remove()
caused this panic. More detail below.

The issue can be reproduced by having userspace process holding the last
refcount to device that was removed.

# python3
\>>> import os
\>>> fd = os.open('/dev/sg22', os.O_RDONLY)
\>>> # wait until the device is removed
\>>> os.close(fd)
#

# echo 1 >  /sys/bus/pci/devices/0000\:5e\:00.0/remove
# # Now run >>> os.close(fd) above

    python3-14739    53..... 3782240930us : sg_remove_sfp_kprobe: (sg_remove_sfp+0x0/0xa0 <ffffffff816dd5c0>) kref=0xffff88b047055320
    python3-14739    53..... 3782240934us : <stack trace>
 => sg_remove_sfp+0x1/0xa0 <ffffffff816dd5c1>
 => sg_release+0xa2/0x100 <ffffffff816de5e2>
 => __fput+0xe9/0x280 <ffffffff812fcf79>
 => __x64_sys_close+0x39/0x80 <ffffffff812f58a9>
 => do_syscall_64+0x35/0x80 <ffffffff81b57485>
 => entry_SYSCALL_64_after_hwframe+0x46/0xb0 <ffffffff81c0006a>
    kworker/-2357     53..... 3782240948us : scsi_device_dev_release_kprobe: (scsi_device_dev_release+0x0/0x2c0 <ffffffff816c0680>) device=0xffff88ac553a61c0
    kworker/-2357     53..... 3782240951us : <stack trace>
 => scsi_device_dev_release+0x1/0x2c0 <ffffffff816c0681>
 => device_release+0x31/0x90 <ffffffff81662fc1>
 => kobject_put+0x6d/0x180 <ffffffff81b3527d>
 => scsi_device_put+0x20/0x30 <ffffffff816b1190>
 => sg_remove_sfp_usercontext+0xfb/0x190 <ffffffff816de73b>
 => process_one_work+0x133/0x2f0 <ffffffff810a5983>
 => worker_thread+0x2ec/0x400 <ffffffff810a6dbc>
 => kthread+0xe2/0x110 <ffffffff810aed42>
 => ret_from_fork+0x2d/0x50 <ffffffff8103ddad>
 => ret_from_fork_asm+0x11/0x20 <ffffffff810017d1>

python3-14739 was holding the last refcount. sg_remove_sfp() queued
sg_remove_sfp_usercontext() for execution. scsi_device_dev_release()
set sdev->request_queue to NULL causing the panic.

    kworker/49:1-607     [049] .....   519.002877: scsi_device_dev_release_kprobe: (scsi_device_dev_release+0x0/0x2c0 <ffffffff816c0680>) device=0xffff889d227bf1c0
    kworker/49:1-607     [049] .....   519.002882: <stack trace>
 => scsi_device_dev_release+0x1/0x2c0 <ffffffff816c0681>
 => device_release+0x31/0x90 <ffffffff81662fc1>
 => kobject_put+0x6d/0x180 <ffffffff81b3526d>
 => scsi_device_put+0x20/0x30 <ffffffff816b1190>
 => sg_device_destroy+0x2f/0xb0 <ffffffff816dc16f>
 => sg_remove_sfp_usercontext+0x133/0x190 <ffffffff816de763>
 => process_one_work+0x133/0x2f0 <ffffffff810a5983>
 => worker_thread+0x2ec/0x400 <ffffffff810a6dbc>
 => kthread+0xe2/0x110 <ffffffff810aed42>
 => ret_from_fork+0x2d/0x50 <ffffffff8103ddad>
 => ret_from_fork_asm+0x11/0x20 <ffffffff810017d1>

Reverting 80b6051085c5 ("scsi: sg: Fix checking return value of
blk_get_queue()") and fcaa174a9c99 ("scsi/sg: don't grab scsi host module
reference") fixed the problem. The stacktrace above is showing the last
refcount of the scsi_device is dropped from sg_device_destroy().

