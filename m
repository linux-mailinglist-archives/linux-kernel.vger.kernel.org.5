Return-Path: <linux-kernel+bounces-78402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5445F8612FF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6B561F25406
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DB87F49C;
	Fri, 23 Feb 2024 13:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dsDRJvVE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wc0aIp5Y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28227F466;
	Fri, 23 Feb 2024 13:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708695640; cv=none; b=pM2DFrxY/dbeWyP5NQxMj88pdyqM790jaI2V9JvozzEPbK8wS2BYPC3zK7n0b3G3AAHqyc3BYgBsXBwcz2ZZuaFeJaHFg1AhIgDdnkB1pvBDK7PKU0bwloaLJ5lyPSWdT9J+RWW5tnEeB5U/Hq5opNUst00OiRBBPzuaS3P+fCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708695640; c=relaxed/simple;
	bh=yBT31D6X20oclfWy+682T89wlg7Fs0eeS65vEzjyTVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPV62pZVDodTnnSC1O8E1APfQdE7PgQ0NcMSdrlHlcRx3QmPgCkTB3BuAP2LqWOxGBqBRThpj8b9rEJ6+14sDA/IRm1vbzxHG+nUPS2G3DxR4kN7hLW8dz6GbtudXTRVYqgRwyZ9zzDZx47uSV+WkFR1uuf3fB3Oh123nBv+9EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dsDRJvVE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wc0aIp5Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 23 Feb 2024 14:40:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708695636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ntvgPN3BhkXn2FHeF6+1NREmqA573BQOrzmqU41B1N8=;
	b=dsDRJvVEq+87A0/vXprpDtRHzl5x4w2yO9KxWN7JMay9nv+qoskC0jQYgMpakAeolqCbij
	6Xt48kgj9RiTqcuLD2vKwDwGVtwWHAqoLEQCvCC8SDan/DnU0FQz73qLwJLpaO+5XDVwEL
	7mv7ad8OnSYGWlPUmdsvTAg5XiWUVm6E4KaNgYkecdKxbF6SssnXzlVVP18jxaHkmwhw8H
	5Ok7AC4pUkTAhitMHbJs98u3sk7GaioWkLIZ1P/jgtnwmNcZApJBAqlrUCHlmL9HRmgRkx
	NzW292d3UVJFw1msNDZ7ZyQsTq0t6W8uIeY9ppJBX05/YdGKAcMRH942FQRGLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708695636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ntvgPN3BhkXn2FHeF6+1NREmqA573BQOrzmqU41B1N8=;
	b=Wc0aIp5YiuvVEKzn8NlN7Socf8FUHnlxremDCpsAkDgzG0NC8lU24T3feFSD3DdlvoWx5j
	j4zMyeiw8iaXwWBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] v6.8-rc4-rt4
Message-ID: <20240223134034.HBeD-gMS@linutronix.de>
References: <20240214161130.ZT9RSWDc@linutronix.de>
 <1ae5b9e6-9eb4-49a5-8cfc-46359c8d74c3@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1ae5b9e6-9eb4-49a5-8cfc-46359c8d74c3@arm.com>

On 2024-02-23 10:52:57 [+0100], Pierre Gondois wrote:
> Hello Sebastian,,
Hi Pierre,

> > Known issues
> >       Pierre Gondois reported crashes on ARM64 together with "rtla timerlat
> >       hist" as trigger. It is not yet understood. The report is at
> > 	https://lore.kernel.org/70c08728-3d4f-47a6-8a3e-114e4877d120@arm.com
> 
> I recently tried to reproduce the issue using the same kernel version and platform,
> but even after multiple resets and attempts to re-trigger it didn't show up.
> As it doesn't seem anyone else reported anything similar, would it make sense
> to drop the reference ?

I've been looking at the thread again and I analysed your report but was
not able to reproduce it myself nor had I an idea what was really going
on.
If you can't reproduce it yourself anymore, same SW & HW, then I guess
there is no point in keeping it. So I am going it to drop this on the
next release. Should you, or someone else, manage to trigger it gain we
can add it again ;)

Thank you for the update.

> Regards,
> Pierre

Sebastian

