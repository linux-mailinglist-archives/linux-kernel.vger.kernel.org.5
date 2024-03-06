Return-Path: <linux-kernel+bounces-93510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C62A8730DB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF7C91F29A7B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFAF5D730;
	Wed,  6 Mar 2024 08:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SPPZvc5l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OKPkj88w"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8960C433B9;
	Wed,  6 Mar 2024 08:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709714182; cv=none; b=bmwndyS1CG01ZXCQoMk/BHEmD6ho4WF6kKkvA9PI+D62uXQVNmmiowqjw039uIQEcKuoAKqzOa2yQyZD5RGmwoJzzQ7TAhxyONp1eq1FJ/Lai8O9pgs/FXK9i/y0EEx515n4y2EskT8phxnVo6ntOOY/EMGYn++4pg/TVF5irSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709714182; c=relaxed/simple;
	bh=VrjVx0JM+ojkmq5bYA33W2pq6FvUz0OgdKtPpf5WOmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHGDDIT8oCXAbwun15FWH+Mdyqneh+dB263W93Nk43PoCgLjSxU/QWA0PjD+oC88VwRWrsXV61Lt6w52D2ZBXH/7g/arBWWXHVAtMnszXzzD1mgcfEMExhMtDcPYhpQyf6RXWG9eVIqoLnEODLXuswVABFAUISbhuM54wJFYygo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SPPZvc5l; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OKPkj88w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 6 Mar 2024 09:36:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709714178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WWNN+xu255TTGbWwnSaz50DvpvIVst/qTUPY9vEWAyg=;
	b=SPPZvc5l/KVmBnxbEl8SBcpwTJ+dQxYTXa+uK0TDkHf+x4LiSLV2S3d9xYsjV5AJZlyJUf
	86hI+21DVI9r9NqcdWdO9VCACYIjb7Ixyb1FZnX67OY4I1c5wlG9sWCPlPkIxZblQiWLJI
	UFvtf5KdZFQ0ZBeOgEIoEsucA1Fa167Ru0A0khw/azHQ7BOF3gzKqkehepjI8F8K6WhfHl
	8BEsov18cNID+t2zAvxOAiZUyu8Cx370nUfs+YzpdUyPhNBI6udOFUTv1ayQ5gQMoU+h8s
	UVGQKkO/A7atQEka6asz1lCQ+0vM6dpKUxofr3s2BhsxgXFuNyR+1mn3C6vr2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709714178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WWNN+xu255TTGbWwnSaz50DvpvIVst/qTUPY9vEWAyg=;
	b=OKPkj88w3XSX7R2Nbq31ZsieTMlpS7+prCKcVxGDpDL7R/gvYPfdObxwFxVK8lNAW+nYJP
	Grj+Sro6J3Dkm9Aw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: =?utf-8?B?6Im+6LaF?= <aichao@kylinos.cn>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	W_Armin <W_Armin@gmx.de>, hdegoede <hdegoede@redhat.com>, 
	"ilpo.jarvinen" <ilpo.jarvinen@linux.intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	platform-driver-x86 <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH v4] platform/x86: add lenovo generic wmi driver
Message-ID: <20240306092652-4ccf20ee-0044-41c8-8712-d8eb30be9ed7@linutronix.de>
References: <2o0aznm5pjb-2o0c9lfkrd4@nsmail7.0.0--kylin--1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2o0aznm5pjb-2o0c9lfkrd4@nsmail7.0.0--kylin--1>

On Wed, Mar 06, 2024 at 04:17:43PM +0800, 艾超 wrote:
> > I would be interested on which devices this driver was tested and is
> > expected to work with.
> 
> Lenovo A70，it is a Computer integrated machine.

Could you mention this in your next commit message?

Do you have any idea on which other devices this should work?

> >> This looks similar to a switch.
> >> Would it be more useful for the user to report a standard switch
> instead
> >> of a key event which needs to be correlated with the sysfs file?
> > I agree, maybe SW_CAMERA_LENS_COVER might be the right thing to use
> here,
> > if those camera states (open/closed) are meant to symbolize camera
> shutter states.
> > In such a case the initial switch state has to be retrieved, or else
> the input device
> > cannot be registered until the first event is received (similar how
> the hp-wmi driver
> > handles SW_CAMERA_LENS_COVER events).
> > Ai Chao, can you tell us if those two camera states are meant to act
> like a switch (camera switched off,
> > camera switched on) or meant to act like a key (camera button pressed,
> camera button released)?
> 
> The camera button is like a switch.  I can used SW_CAMERA_LENS_COVER to
> report input event , but the OS
> 
>  can't to show camera OSD. OS need a key value  map to the camera OSD.

Why can't the OS do this?

The switch should report its value.

