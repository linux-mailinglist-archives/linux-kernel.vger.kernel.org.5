Return-Path: <linux-kernel+bounces-64824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE669854349
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2E93B270FC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AC51170E;
	Wed, 14 Feb 2024 07:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="QUjjJE8p"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D603E111B6;
	Wed, 14 Feb 2024 07:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707894533; cv=none; b=lhMsgQcMJ8h2n/64iy/Dz+8aedY2QGGlPSFCHkHfaUB2NvDqIRyMAdfmLz+HC9jXt1ThUrxhmyhIx1mWX1ObwxNhXGCOXxGXfgUiSXEHTDmmCaTxTfnBHOcAaLs+hRQBihCQHX6bbC2vSgaEqcrYLyUJsOlEd+9SLGI9f9mVu3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707894533; c=relaxed/simple;
	bh=RayJ1tOkR9umoBjincQZbdFH6T7xK9Zxhq+zYYR5wd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEdTQNDJjnFdQk2X/DbMtPLtG+ZiK7eKsHHV37L/qPtWllSg5g3O2XmFpVkvpdSqYBeqXbUgCcVEoGQqw2zSKGME6h+ZcjZV9rHwHLIBSyINTmr6mdUBhkejq78bSPa9HaSROlQVJH0aFM40v6wUkYSyn39bh/AHRCq0AiAMY/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=QUjjJE8p; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 9123760505;
	Wed, 14 Feb 2024 07:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1707894524;
	bh=RayJ1tOkR9umoBjincQZbdFH6T7xK9Zxhq+zYYR5wd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QUjjJE8pNkn7mugYJDMW75jCJR2xxsI/sQ1A5kL5etzQEdtArTxJ6sn2qrOIV2HZC
	 5JV59CiPrKsa1iTZ1aOy9KKSJ4gUx8Hsn5VpdT7mxdwKJqnMbRJI3Xc1uY2RxZBNXR
	 csQ7KfYbn980PZV6gis8Wng5J6Kam0jFauJ5O4Ct0WDUlTlLIwVv2pCuQUlg1yrsmx
	 073CJ+jvL9QB31jBEEfRHXqzq5m2fl62PT+nxv318+01AnRyut8Ls1BZYXdGt0bq/t
	 JA6aiYeHfKpKnwjf3J0xz8+Gnfp6RmNC29azucOmhIw1lmCIMtanmcIrSPy9H7PXeq
	 8S1JtoSDDgU6g==
Date: Wed, 14 Feb 2024 09:08:08 +0200
From: Tony Lindgren <tony@atomide.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	"David S . Miller" <davem@davemloft.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dhruva Gole <d-gole@ti.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v6 4/6] serial: core: Add support for DEVNAME:0.0 style
 naming for kernel console
Message-ID: <20240214070808.GN52537@atomide.com>
References: <20240213084545.40617-1-tony@atomide.com>
 <20240213084545.40617-5-tony@atomide.com>
 <jnfrv7wj4wigtzsh7r7p4zgbtim64kniriwbtjc3pebznyvwtk@7l36wdfn6tja>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jnfrv7wj4wigtzsh7r7p4zgbtim64kniriwbtjc3pebznyvwtk@7l36wdfn6tja>

* Sebastian Reichel <sre@kernel.org> [240213 23:58]:
> I would expect an update to the console= section in [0] somewhere in
> this series.

Good idea, will add.

Regards,

Tony

> [0] Documentation/admin-guide/kernel-parameters.txt

