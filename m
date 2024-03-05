Return-Path: <linux-kernel+bounces-91882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 289F48717D0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EF451C215D4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92C78004D;
	Tue,  5 Mar 2024 08:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AW1ONpUi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U+YKs3J2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C3E7F480
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 08:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709626484; cv=none; b=twAKyqv7s6CH3iQZKtueOZ+wAT61J4pN9vExy7iXIHZo3sDe2ZqT4IuGmY7q4ZjWeP6cr/FxA4Fh45A6Q9fAT/zdw0j6i9+hSZ5ZsDCHF4t/8Ln5YRaNSY0tet5Z5ptKZwBf+zZHum/jwRoKvRZIJHr7FYAiU3XKWnQJ1lYDQZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709626484; c=relaxed/simple;
	bh=QNj7PzdvPD7WI4n6gxvH/sldUw13zTEnUHfCfXtrBfY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aU/Gr+seclLbr3i6j2UN2nM+SZ/T8OaDRchoVK/MlLdBrBIHNVivFPZSL2HAXVu7631d4DvUgYqMwgDz4LVT4m2TqU9CW1TEhOF9/+DWsnslAYyJn1wnJ8dFi6wMJntGbcuaC4BGgdGErSTQYPzQZijiO+3wH+KePNAVOVR/uKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AW1ONpUi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U+YKs3J2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709626480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QNj7PzdvPD7WI4n6gxvH/sldUw13zTEnUHfCfXtrBfY=;
	b=AW1ONpUi54JG/W8Xq0iCOJ+eRZYJ71mlsZBTKucUQukQApG9jkJQp/vHbhqXgmx1KJcg0q
	xrymlFFOn0K0nfGkWctpzzoZ72zAPuBe0YI8psTYXU+GxSCjkbH5vRUKBIIaxxNujxjllB
	dH1dWuw1wM2cbKyB0MrxCclkRTYo8Dz/mRGbxw2dgMMFL9utPOrct/XyJ7udlpwyoc5YVQ
	42WlvyPN2gFl6YCASoEctdlIzZGQICvvsf3e9VpNi7UV0Z2KQbJforFdImyUNpJDlvxkl7
	mHKEkbHEflkF1p2+FXc6E0mija2dsyi8/2T0QfXLX+2vQ3g1hwTtRERCBcZ33g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709626480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QNj7PzdvPD7WI4n6gxvH/sldUw13zTEnUHfCfXtrBfY=;
	b=U+YKs3J2V6X7uOq6wIPVddHSenSEATkimtwzqfXS5cAp6V6TjivHnzU/TBO8ROHOj9ZFab
	t0bUT9BLfjBLuECQ==
To: Daniel Vetter <daniel.vetter@ffwll.ch>, DRI Development
 <dri-devel@lists.freedesktop.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Daniel Vetter
 <daniel.vetter@ffwll.ch>, Daniel Vetter <daniel.vetter@intel.com>, Jocelyn
 Falempe <jfalempe@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Lukas Wunner
 <lukas@wunner.de>, Petr Mladek <pmladek@suse.com>, Steven Rostedt
 <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [RFC] drm/panic: Add drm panic locking
In-Reply-To: <20240301103903.2538083-1-daniel.vetter@ffwll.ch>
References: <20240301100516.2516297-1-daniel.vetter@ffwll.ch>
 <20240301103903.2538083-1-daniel.vetter@ffwll.ch>
Date: Tue, 05 Mar 2024 09:20:04 +0106
Message-ID: <87o7bt6qpf.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Daniel,

Great to see this moving forward!

On 2024-03-01, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> But for the initial cut of a drm panic printing support I don't think
> we need that, because the critical sections are extremely small and
> only happen once per display refresh. So generally just 60 tiny locked
> sections per second, which is nothing compared to a serial console
> running a 115kbaud doing really slow mmio writes for each byte. So for
> now the raw spintrylock in drm panic notifier callback should be good
> enough.

Is there a reason you do not use the irqsave/irqrestore variants? By
leaving interrupts enabled, there is the risk that a panic from any
interrupt handler may block the drm panic handler.

John Ogness

