Return-Path: <linux-kernel+bounces-48011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C08845639
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D753B22003
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C57415CD7C;
	Thu,  1 Feb 2024 11:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QzE2sx9W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RvvNU0ek"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4104815CD43;
	Thu,  1 Feb 2024 11:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706786915; cv=none; b=iSDHi+r/ERLSgxPQ5RjZEaVmaUDuWLxIQ0+diiBu/BfOePe3tcDObuB6dbpjKp1zuKk8CSHZJDFRG5P29hgm9XowtRidFSBJqJLtfO7D41wanIBUluuE1LitI4KoHw1wB0i98ddpEiXeaxJbmQBaZmlfBNtdqmzHADxE8YNoyzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706786915; c=relaxed/simple;
	bh=EqDFDjr65DaTO5ggMTdy8mexaExyCS1krDj5TMD2nUw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AZnSzNnOEjr8WhlNfYhKfhPWQ7NJmZ1cJzLimUK/Eqev4XgE/wU6KGAtx5Buba4H9W9UtIlY/LlRjQqRKtZWMX3DeQSuhHnuSQG6Xq8ZLmpr9xVg0JK+R/F/S3FU8v37JAAVdhQl15NDZ9bkmQe1lQsiQBO3AQNCaYP9SxGOVu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QzE2sx9W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RvvNU0ek; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706786906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EqDFDjr65DaTO5ggMTdy8mexaExyCS1krDj5TMD2nUw=;
	b=QzE2sx9Wxfn6tw0aBb0420I35AUa7LEYnmu5QEZW0zSj8eazpjB5B1EEBm57nLKwin6F3v
	FoFkC4E1k/PGBNqkZa8k1F/cJJZ+xHee1/rcwhPO/I1WXQ7U+u92eReJ+cwvVQPl2lI6WN
	SZYJ1+OoZ8O7uG8Nd1mFRqMdWkyDTIoWYt+hXAaGN4Lezhqao5YF2z+4vVWjBPsdOdSUUy
	YI9M5L4IW+sfyi8jZJgsKIRzM+I6XwvdSgxJlujldtdTMHDYVrwdLuQ0iEdttXHdL5Xg0y
	zKI61sSDJIhj04D7lwvQx8Zl3qKYtviJw6dgsRnbL1NjD+nKl4d8UpgDe2aKgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706786906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EqDFDjr65DaTO5ggMTdy8mexaExyCS1krDj5TMD2nUw=;
	b=RvvNU0ekbs845Rjzq7oecrmt8UowWVMaI4WtKRCMAce1vmWlsseYmTUmj4cypTdTad/kXh
	O6D9w6n3+NKGcDAg==
To: Sreenath Vijayan <sreenath.vijayan@sony.com>, corbet@lwn.net,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, pmladek@suse.com
Cc: rdunlap@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, taichi.shimoyashiki@sony.com,
 daniel.palmer@sony.com, anandakumar.balasubramaniam@sony.com,
 sreenath.vijayan@sony.com
Subject: Re: [PATCH v4 1/2] printk: Add function to dump printk buffer
 directly to consoles
In-Reply-To: <8cb5936021c5811bd03a6bc18300b1384009ac26.1706772349.git.sreenath.vijayan@sony.com>
References: <cover.1706772349.git.sreenath.vijayan@sony.com>
 <8cb5936021c5811bd03a6bc18300b1384009ac26.1706772349.git.sreenath.vijayan@sony.com>
Date: Thu, 01 Feb 2024 12:34:22 +0106
Message-ID: <87sf2co23t.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-02-01, Sreenath Vijayan <sreenath.vijayan@sony.com> wrote:
> It is useful to be able to dump the printk buffer directly to
> consoles in some situations so as to not flood the buffer.
> To do this, we reuse the CONSOLE_REPLAY_ALL mode code in
> console_flush_on_panic() by moving the code to a helper function
> console_rewind_all(). This is done because console_flush_on_panic()
> sets console_may_schedule to 0 but this should not be done in our
> case. Then console_rewind_all() is called from the new function
> dump_printk_buffer() with console lock held to set the console
> sequence number to oldest record in the buffer for all consoles.
> Releasing the console lock will flush the contents of printk buffer
> to the consoles.
>
> Suggested-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Sreenath Vijayan <sreenath.vijayan@sony.com>
> Signed-off-by: Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>

Reviewed-by: John Ogness <john.ogness@linutronix.de>

