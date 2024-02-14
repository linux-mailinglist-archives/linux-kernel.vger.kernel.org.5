Return-Path: <linux-kernel+bounces-64888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B61854456
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F910285CFD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575C279CC;
	Wed, 14 Feb 2024 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="I+0PK/P4"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC59BE48;
	Wed, 14 Feb 2024 08:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707900733; cv=none; b=c6KT6M0loMsYqmYbIpruGocCBQdcw91/Xfk2rWiIdGHWoqQ2RdQ4dbQ174ynpDchNmyuxsB/NUwFxHZaj/fjMwgWR/bWCQNXcvW1bLqHd9HolCMWndBqUtJ3QgMiZOxhqRd+TZK4G3pprtMtLeE2pP1PRzGw79n7sK9+h3yyRL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707900733; c=relaxed/simple;
	bh=nEHFJ8FOb7Ym987IDiDvA7rd7Tjxqoe8bFUXqLzY7gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRTfJRbZ2uQjFLRJR5qIPmt4kqDqHWgRDMKo4fJkLF1XkOWyR9se5F6igeCQiMfAv5fU9LkYrIcms6/zdfH1FOEf/gpk0DpvG5ihBa2wlHufo5iF/wkTmh1CwxRpE2grIZgBokJuVbz7W0WvV3yfLiqWaOb+xIkNN0mz6AAxVlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=I+0PK/P4; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 32AF060434;
	Wed, 14 Feb 2024 08:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1707900731;
	bh=nEHFJ8FOb7Ym987IDiDvA7rd7Tjxqoe8bFUXqLzY7gk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I+0PK/P4QPFHY+jV3JTyXLnyJTtiSxWGr8KHfDeHreN8UDXCZ0ZCl1domDzbcpLqC
	 UbhHwJ94K0S2GRhH+ovvGpcadwLBeE7ZotcRIgFK9qGjvE4ddtF3ehU6RzFsYMVyvG
	 JrO3aRBZhkPYDDZ240g50Bd5CyMzAZVkq86yQdUTe1Rpu9thjwrSSm+WW2BAJ3dCB2
	 HbH93XpXunWk4VCxwperPjszAzv2qZiyexF7uxIqEPU9tPlm5dHq+ayZ2+SLQFNCEJ
	 mGqlQ2kreN9uNQSpvkUo9QZwoHF2cx0XVbuFcIlpMbwaZD/vJijXwKxN/6/pEuHjGm
	 yN6CPSA6uio/A==
Date: Wed, 14 Feb 2024 10:51:38 +0200
From: Tony Lindgren <tony@atomide.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	"David S . Miller" <davem@davemloft.net>,
	Dhruva Gole <d-gole@ti.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v6 1/6] printk: Save console options for
 add_preferred_console_match()
Message-ID: <20240214085138.GQ52537@atomide.com>
References: <20240213084545.40617-1-tony@atomide.com>
 <20240213084545.40617-2-tony@atomide.com>
 <Zcub1bQrDqHE0Mkt@smile.fi.intel.com>
 <20240214084905.GP52537@atomide.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214084905.GP52537@atomide.com>

* Tony Lindgren <tony@atomide.com> [240214 10:49]:
> * Andy Shevchenko <andriy.shevchenko@linux.intel.com> [240213 16:42]:
> > 		strscpy(con->name, str, namelen);
> > 		strscpy(con->opt, opt, optlen); // not sure if emptying opt is okay
> 
> The strings above now get terminated too sort with the + 1 removed,
> I suggest we use what we already do for brl_opt:
> 
> 		strscpy(con->name, str, CONSOLE_NAME_MAX);
> 		strscpy(con->opt, opt, CONSOLE_OPT_MAX);
> 

Heh but that won't work for str and CONSOLE_NAME_MAX..

Tony

