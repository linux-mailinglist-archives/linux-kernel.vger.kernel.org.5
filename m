Return-Path: <linux-kernel+bounces-128131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F112895696
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FE281C21F83
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3FA86ACA;
	Tue,  2 Apr 2024 14:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ka/TmWA3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD528615E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068074; cv=none; b=gKMW3cg/9hCvX0gQcLNxH1gU2tvcjYhUehHLE6hSE0USDxiVxPbmBmkPKLAF7KMTLr54lUlOWban0sMfxLJ950xV0+0cdTCN7hza5O4cxaSWhY/pUNNUBS+MrZjE5QuO8JyzgNVWxiZ7an6irxGuGLydlvl5S5+lDun69yqR7Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068074; c=relaxed/simple;
	bh=ZSgVBOH7JXa+1vKhQpi7bkdSxzUCt7bmMNzjk/zbVw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQN0vwWQxnomQKneHf2giLC4cwgNAiE3Rn3KcFF772uu3aK6NUXyy5oKqY3eFfIrTlQWfHekmVyJcGi3QAcz6rYJIHIeowrdj8M5Do6f+WHGjvUByqeRyRWyzZ5SoBxH5bWHjoaaWb4KhKn4KspWWl4/SveDBOx449N+WVaQTzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ka/TmWA3; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712068072; x=1743604072;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZSgVBOH7JXa+1vKhQpi7bkdSxzUCt7bmMNzjk/zbVw4=;
  b=ka/TmWA3ehPmL1HEUlgP3Vj4YXtOufl1ZbPZfrxLIZH/bzO2q8jvXjSO
   AOY72q1ckrerzDaosu8i4R/ZV8XUUKR11iDlsPCq80cnkqzmNtoRC9Jgo
   1KEss8nqyCr8L1EXVANJFUejvKJwhp3u3wOQytaWm+aliUPoVIQu7kiBs
   ThnwPj9nFyaSoOu5zMfAfvUJ+K8GgSXNcDxZmsw8JE2FoFkxbMrlGHMin
   cXY6jYSVHITLzYAh4QhK08AOf+t5/AAw27X8zZtSkrpanj5xqNZqfPKvP
   PTqfAFCeiIKSoDa1xiDBbLBMAopwIOoHaRHuwQoWcEZSgYxuSpBezR0zc
   Q==;
X-CSE-ConnectionGUID: rGIxRCRDSTWqAGzGJfnXTg==
X-CSE-MsgGUID: +jfxzMncRquXN0BzghQqsA==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="10205330"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="10205330"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 07:27:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="915142839"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="915142839"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 07:27:49 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rrf74-00000000phT-3nOm;
	Tue, 02 Apr 2024 17:27:46 +0300
Date: Tue, 2 Apr 2024 17:27:46 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "fengchunguo@126.com" <fengchunguo@126.com>
Cc: ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	Gary Feng <chunguo.feng@semidrive.com>
Subject: Re: [PATCH] tty: serial: fixed uart irq maybe cause irq storm
Message-ID: <ZgwV4qG2S9O96_Ew@smile.fi.intel.com>
References: <1711966746-225228-1-git-send-email-fengchunguo@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1711966746-225228-1-git-send-email-fengchunguo@126.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 01, 2024 at 06:19:06PM +0800, fengchunguo@126.com wrote:
> From: "Gary Feng" <chunguo.feng@semidrive.com>
> 
> if not disable uart irq before disable clk,  uart irq maybe triggered after
> disabled clk immediately, then maybe cause irq storm.
> 
> Reproduced the below call trace, see i2c not be connected, but irq storm
> was triggered.

> i2c_designware 30b70000.i2c: controller timed out
> CPU: 2 PID: 2932 Comm: gnss@1.0-servic 
> Tainted: G O 5.14.61-00094-geaa0149416cc-dirty #8
> Hardware name: Semidrive kunlun x9 REF Board (DT)
> Call trace:
> [<ffff00000808a3cc>] dump_backtrace+0x0/0x3c0
> [<ffff00000808a7a0>] show_stack+0x14/0x1c
> [<ffff000008cef43c>] dump_stack+0xc4/0xfc
> [<ffff00000814eb80>] __report_bad_irq+0x50/0xe0
> [<ffff00000814eaec>] note_interrupt+0x248/0x28c
> [<ffff00000814c0e8>] handle_irq_event+0x78/0xa4
> [<ffff00000814fcb8>] handle_fasteoi_irq+0xe4/0x1b4
> [<ffff00000814b060>] __handle_domain_irq+0x7c/0xbc
> [<ffff00000808176c>] gic_handle_irq+0x4c/0xb8
> [<ffff000008083230>] el1_irq+0xb0/0x124
> [<ffff000008d09f5c>] _raw_spin_unlock_irqrestore+0x10/0x44
> [<ffff00000865b784>] dw8250_set_termios+0x48/0xf4
> [<ffff0000086545a4>] serial8250_set_termios+0x14/0x28
> [<ffff00000864c4f4>] uart_change_speed+0x38/0x10c
> [<ffff00000864e458>] uart_set_termios+0xd0/0x17c
> [<ffff000008630ad4>] tty_set_termios+0x160/0x1e4
> [<ffff00000863165c>] set_termios+0x32c/0x3bc
> [<ffff000008631248>] tty_mode_ioctl+0x6f0/0x7d8
> [<ffff000008631a6c>] n_tty_ioctl_helper+0x10c/0x1e8
> [<ffff00000862d2c4>] n_tty_ioctl+0x120/0x194
> [<ffff00000862a724>] tty_ioctl+0x658/0xa34
> [<ffff0000082a8f40>] do_vfs_ioctl+0x554/0x810
> [<ffff0000082a9368>] SyS_ioctl+0x88/0x94
> Exception stack(0xffff00000ccf3ec0 to 0xffff00000ccf4000

Please read
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#backtraces-in-commit-messages
and update the commit message accordingly.

..

> +		/*Need disable uart irq before disabled clk, because uart irq maybe triggered after
> +		 * disabled clk immediately, then cause irq storm.
> +		 */


/*
 * Use canonical multi-line comment
 * style and make sure the lines are not
 * too long.
 */

..

FWIW, the patch that compares this with current clock rate most likely will be
reverted, meaning your fix might be not needed anymore, or has to be rebased.

-- 
With Best Regards,
Andy Shevchenko



