Return-Path: <linux-kernel+bounces-48666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06EF845F8D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3E431C28D57
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B22512FB2C;
	Thu,  1 Feb 2024 18:08:08 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D82B12FB20;
	Thu,  1 Feb 2024 18:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810888; cv=none; b=d0WX0sbmhdutMqqTrO8J3bIk0QBgLUVAYLgz2fbBTLBFI9F1m3SBKn3BSwBwQ4qAQIoRT0o75VmVdrb35MCx6eq8+EajaEDmmTiyrPTbhfpvEBTWtSM0sHwxuITr6aYzz9q3s5WrxF5H/qPp+XRtx1DGDtwfJIUE5TEywb1Ffu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810888; c=relaxed/simple;
	bh=3fQ4Hj123nWikWKl/jDq76q+bYRtnn4w9qBSsVQBwuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KvRSY70rcyNllJzTKRUeITrNqnE5wbKT/kCRwdct24jKJ98dJX2vDgi2a5yuBHdsJfwxofGDTYWZ2ay/tLMWc+ZCkGgMFUCiS2YJvBzztq79N5Jnvk0bfQiIueoUjm23L2S8lvOK6f428jIWlMyzs5+V4RhclQUCjzyJKFyw+SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0ADEC43390;
	Thu,  1 Feb 2024 18:08:06 +0000 (UTC)
Date: Thu, 1 Feb 2024 13:08:23 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] tracing/timerlat: Move hrtimer_init to timerlat_fd
 open()
Message-ID: <20240201130823.36f1da8d@gandalf.local.home>
In-Reply-To: <2024020122-uncombed-moody-a96d@gregkh>
References: <7324dd3fc0035658c99b825204a66049389c56e3.1706798888.git.bristot@kernel.org>
	<2024020109-duffel-finally-4f0b@gregkh>
	<05c12163-d348-4615-a9e3-f36787629e0e@kernel.org>
	<2024020122-uncombed-moody-a96d@gregkh>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Feb 2024 10:05:59 -0800
Greg KH <gregkh@linuxfoundation.org> wrote:

> > timerlat_fd = open("/sys/kernel/tracing/osnoise/per_cpu/cpu0/timerlat_fd", 'r')
> > timerlat_fd.close();
> > 
> > # ./taskset -c 0 ./timerlat_load.py
> > <BOOM>  
> 
> Then obviously, this is a real, functional, change, so say so in the
> kernel changelog :)

I've updated the change log to remove that comment and add the reproducer.

-- Steve

