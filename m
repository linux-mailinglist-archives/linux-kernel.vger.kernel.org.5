Return-Path: <linux-kernel+bounces-58164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C644984E21D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67182B28D5F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB42876417;
	Thu,  8 Feb 2024 13:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iJke3Ccm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y2wIRbRb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE77969300;
	Thu,  8 Feb 2024 13:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707399598; cv=none; b=EUeFYaJmWyvarFqWHbfBqxxsZ274qHdpiURAsGq9iHDHhnhg6e7SNs9nJgPcc5TqL4mAd78rNAn7rNefEsAz/CGuyUDbaJHAxzASpQbivl/VXd1w1xzXo7iuoV6WEcTjhOG1ZvcNrvI1z2vlAWMdILl6BpcNr0hF3Y49UrmxjuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707399598; c=relaxed/simple;
	bh=GAQvZFPGVkGIRHn+TfnYrCD/18BFSOgL0xVQMh03f7Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F/vCsIPUHS/j5Bctc/V/xavVIjlOXg3Tt37h4mTgzC4TUVkgMqGfxDakA+eZH5GkDXcs08TpojCm+LJknxQ3ry7dXXOKrUnOHtIyzltUZ1Dtq84FfqFQfy2ISDbfY7W/63vVOd5BC74pJcUQb2tGUm1QAhfiV/ppoKl060N0BWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iJke3Ccm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y2wIRbRb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707399594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JHDIQzkGG+MPwKNeQEZx8vGwHDj28JgeiF1oIt02Zz8=;
	b=iJke3CcmBJMtWum8U7gZsj4lHvZ7Z1HEwpCpjS5J6VZV/416zRHLSESuKSLlVApH9xlhXh
	w0Ak3425v8+HR6ct9inEZeoa9HRszriudVsxIbNId8Jo1N+rwNXidLQADuIVgvzCdPlNts
	bJqc+71IT7NGwdGDuaN5N6cDDzgLwAgDpjNC6S4orLxCQRQ3dLDQGyhfmls6bDSDITHz/V
	1Awd/WgChIrUxjjQAe7tnOnTBuKXuf3EuFrK74GzPTEWqo7zgeI1Z6imUuHCcWUry/YEig
	HY/iS6bzhyp09nsQGFL8lqm98jQW444z/4rncqLfVDBPxh7tc0p83Ig3AyV8TQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707399594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JHDIQzkGG+MPwKNeQEZx8vGwHDj28JgeiF1oIt02Zz8=;
	b=Y2wIRbRbEDvbBO2IyXfdji8e+QXRZPCsQg1+nF7w/n2BZeNn3qvKdVdXSv9kiDq+XqMcZb
	NY7+ruHKvCgQJhBA==
To: Greg KH <gregkh@linuxfoundation.org>, Petr Mladek <pmladek@suse.com>
Cc: Sreenath Vijayan <sreenath.vijayan@sony.com>, corbet@lwn.net,
 jirislaby@kernel.org, rdunlap@infradead.org, rostedt@goodmis.org,
 senozhatsky@chromium.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 taichi.shimoyashiki@sony.com, daniel.palmer@sony.com,
 anandakumar.balasubramaniam@sony.com
Subject: Re: [PATCH v4 2/2] tty/sysrq: Dump printk ring buffer messages via
 sysrq
In-Reply-To: <2024020845-antiquely-faculty-407d@gregkh>
References: <cover.1706772349.git.sreenath.vijayan@sony.com>
 <ca8dd18e434f309612c907d90e9f77c09e045b37.1706772349.git.sreenath.vijayan@sony.com>
 <ZcOdLrOPiPJmCec5@alley> <2024020845-antiquely-faculty-407d@gregkh>
Date: Thu, 08 Feb 2024 14:45:43 +0106
Message-ID: <87v86zt6qo.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-02-08, Greg KH <gregkh@linuxfoundation.org> wrote:
> I just remembered all the rt-changes coming down the pipe for
> consoles/printk, is this going to mess with that?

It will not mess with the changes because we will continue to support
the legacy consoles anyway.

> So when this option fails when people need it the most, perhaps it's not
> worth adding?  When else would people want to use it?

The feature could be massively improved once the rt-changes (atomic
consoles) become available.

Petr also brought up valid points about this feature (such as the
loglevel) that should be considered. We should clarify what exactly we
want this feature to do. The actual implementation is the easy part.

John

