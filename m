Return-Path: <linux-kernel+bounces-60544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5B1850679
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 22:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC8D12857D5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 21:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D215FDB1;
	Sat, 10 Feb 2024 21:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aDI3W0Mv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TidBeeQP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312135380E;
	Sat, 10 Feb 2024 21:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707600492; cv=none; b=oTYwUk/Qz3G5VGyAMvWQPB/kVmRMxxzCFFJVDwl3SNYjC2J793O5zGaD9acoNLGagbyWAtDw6+zvUsR1xy4NHiD22jKm9baKKBJcyQnDoEWNs4dvE7M4SMcJOjWFhxbkvNgzPDPgzpeCMW/rhXmkghPPYc5i14ycvBmICDtUszc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707600492; c=relaxed/simple;
	bh=Rs/yafDQmeD2SiVKNQzlXt0TnqSuFCTNA4e1AxeRgrw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CpwnceoVQunF0UE4UYJAQiXUwnCvkWrJETTUEPs5/dURCLfqetllZYIKbw3wcnXVtdWBhI95I2H99VJmvm9xLf9b5Z5dRnFtLYYVPseUbm63Qy7QvcGxhI8W855k0VGLP5tKVALlyeAPquRPY70Sv0vEduuSYjmibdAHYoxGvOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aDI3W0Mv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TidBeeQP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707600483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rs/yafDQmeD2SiVKNQzlXt0TnqSuFCTNA4e1AxeRgrw=;
	b=aDI3W0MvpAjbbSNJ/mH2iGhj2TK9w2VmC2kAsEKMD1m4D4pWDDJNiGQ1hN4cm2OGEDHLy+
	fR7OaW4YlJrO8B84M3sKYLxbm+RRTT6K42Fowt+gTaH7YaiOJAt32NnhnK6GNqKbWPP/bh
	CpEv2Fp0b60sDc0IZQkYgq731rGZAufp5YDiiWIMZUL0e83meqzFpE3Ki/R91zHDeYgQvl
	hwaoHyZc5gnsBlzx0Rxq/z1A7eTgg0lNT4H556OaN/lbQObpZciACX+Uau0T8pXDHucGFN
	siR1nnDj45iX6MlSi1Q2oe7TUwieESGaSadV0SsWQWNFVZt6MYO1cRnmphfXjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707600483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rs/yafDQmeD2SiVKNQzlXt0TnqSuFCTNA4e1AxeRgrw=;
	b=TidBeeQPDkr47xTPc057x9kjfYaOmBhaPkkHoQBCbkMO+Ei3CBw5tFX9OWrA1Mlt3cC0HK
	gBfySuxrnz+pqJDA==
To: "John B. Wyatt IV" <jwyatt@redhat.com>
Cc: Petr Mladek <pmladek@suse.com>, Clark Williams <williams@redhat.com>,
 jlelli@redhat.com, Derek Barbosa <debarbos@redhat.com>, "John B. Wyatt IV"
 <sageofredondo@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: NMI Reported with console_blast.sh
In-Reply-To: <ZcaQI8l1dcBx2feC@thinkpad2021>
References: <ZcQjxa4UA6hzXHnU@thinkpad2021>
 <87v86yc88b.fsf@jogness.linutronix.de> <ZcaQI8l1dcBx2feC@thinkpad2021>
Date: Sat, 10 Feb 2024 22:33:50 +0106
Message-ID: <87a5o8j9gp.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-02-09, "John B. Wyatt IV" <jwyatt@redhat.com> wrote:
>> Could you provide me your kernel config and boot args?
>
> In message below.

Thanks for the config. Could you provide me the boot args as well? I am
trying to understand why early_printk is showing up in your trace.

John Ogness

