Return-Path: <linux-kernel+bounces-48012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD4484563C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FE3BB238D5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808DAF51A;
	Thu,  1 Feb 2024 11:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="grd+BLvC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t4zdW6qw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF09C15B970;
	Thu,  1 Feb 2024 11:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706786980; cv=none; b=W1JyD+0nF0lOK/x3/4TtK4dNv54jQTnWxyru8Kbl8xS+GTiwzgPX23QPkznqf6XIRZXKXRucXlbW5K7kHAbv/hHyare9cWomjaby1nNU0XywLeaivu6TX2tbpk/TQfnePsyNg27QFmD5xImhxfYSfvVOYNOfQLOtYVhNqBTMmKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706786980; c=relaxed/simple;
	bh=N59cteCuM1gkkOQNHLFLkmRsPXR1qrb8VkKrOroB6Ts=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hfRiRPhPhwceVvEH22PJT4OqEugbnoD6KPoc+WUnR+21Wp4q73En8LBvLSFTAdWdMOSn3SJc00YeW3casrbGP/am3NI5Bubk7SJBlPjpcg1SbAyay9SEvFGQ+fgsw77+VMtH1G9/QMeVoIo41nxpv61W5+UbIon1hbKsIPScFmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=grd+BLvC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t4zdW6qw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706786977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N59cteCuM1gkkOQNHLFLkmRsPXR1qrb8VkKrOroB6Ts=;
	b=grd+BLvCowvUE3ckE2wROp99t208zMWjwFjvBix+xxYku8ZyCJXO1knDbBZ+Yyp564SX6z
	sr3DXocSnsJeeT8Dwyw/gdgB0JOvLVgPSE9IaIA06HVd2D4T7v7j1sQCvBYRep/HmnqF0w
	n5tzZda5xOZxrrgcCUlG8nhV0M4uVFQAlpzk3CVZ5PeVwLWkzMu7+H3iHZ1UTC+AemcbIv
	58VlK/SEhN5HwvKz/6lMD7eDSecO1lb5kVKestqlGJmN7u4MRbH30AKMmWvb8kax77mZ/f
	D8UEMvH2aIZM9oFIodaIthYb6u+KPeHEm0s3TwRu+KKhpI01zkIKFmyt3IBx7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706786977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N59cteCuM1gkkOQNHLFLkmRsPXR1qrb8VkKrOroB6Ts=;
	b=t4zdW6qwJiYwX+e/kJfaEnHLE1cgxAqy2onSxSJxCqPJIyAa5scnvJqqYGK+2SqXcJOx1n
	ix3UiuxD8Pagt6CQ==
To: Sreenath Vijayan <sreenath.vijayan@sony.com>, corbet@lwn.net,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, pmladek@suse.com
Cc: rdunlap@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, taichi.shimoyashiki@sony.com,
 daniel.palmer@sony.com, anandakumar.balasubramaniam@sony.com,
 sreenath.vijayan@sony.com
Subject: Re: [PATCH v4 2/2] tty/sysrq: Dump printk ring buffer messages via
 sysrq
In-Reply-To: <ca8dd18e434f309612c907d90e9f77c09e045b37.1706772349.git.sreenath.vijayan@sony.com>
References: <cover.1706772349.git.sreenath.vijayan@sony.com>
 <ca8dd18e434f309612c907d90e9f77c09e045b37.1706772349.git.sreenath.vijayan@sony.com>
Date: Thu, 01 Feb 2024 12:35:32 +0106
Message-ID: <87plxgo21v.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-02-01, Sreenath Vijayan <sreenath.vijayan@sony.com> wrote:
> When terminal is unresponsive, one cannot use dmesg to view printk
> ring buffer messages. Also, syslog services may be disabled,
> to check the messages after a reboot, especially on embedded systems.
> In this scenario, dump the printk ring buffer messages via sysrq
> by pressing sysrq+D.
>
> Signed-off-by: Sreenath Vijayan <sreenath.vijayan@sony.com>
> Signed-off-by: Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>

Reviewed-by: John Ogness <john.ogness@linutronix.de>

