Return-Path: <linux-kernel+bounces-91322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15249870E6C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA6D81F21480
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FF378B4C;
	Mon,  4 Mar 2024 21:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="U3zf6rNl"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557418F58
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 21:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588628; cv=none; b=R46T+PlALIMasZiGeAJ4d5jo5pJxDxR5upVnzcMudHKlgN4S8qlOdekH7diR7sBWZ0SW1ZIhClQbS0mO63fY1L7Yd4Jk5k1/aiZd0DhvKCoWFIy9t00STdd4hN2Ge2rzESgX0ubKtrbYmX/Ja9qBYp0Bdde8+vwiYILrjrJ6mY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588628; c=relaxed/simple;
	bh=gEIk3KNMIpuofqC+pRyvAHlCkEZ7jlcfI4PEv6Mt9Fo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MbuNV0v1Ph1v+pZbUe7o64v5UNj58LTar+5YmGyIZ5q1mj3kgaNqrQK9TqIiaJ0iEIRYP23Upo//lxAW80VYAlzgLs/Z+JsE+sQCJlhUYMn6U5pMwjlYm+13V0VPRd4sMEJKGB6QvnLi4rw/C2sWuoL+DixtSl67VnG8Y0OA4LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=U3zf6rNl; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=E1Q94e5EFIOf0PrpzPHEslcyP80xmoYX4L90KOBiz38=; b=U3zf6rNlW1YXMwSvvbRZuUDWRZ
	Cl37Wj5eZvXsTJsanH+iaAWqoEpXQDzXg+9Jqeq3cPF/ouGZHidQuGM+vxalE6c9nvoRpmjIQQoLe
	XO624T7oaQmd6onbC46xoce6QfY32hMNsd+sVDoNSPIqYMZejVixOm382IdZui/m1xK256g4KtJX2
	b+vJzUXnP1dfmdlDuHlAMGxmdXHM14L9kx86q2VfGqsdfoN7j+pg4QBfPYzYKTrLHSse/A70H6wyT
	wf5bXJfau6sm74EEXWM7E9P6xSbreBxezugkZbV+iqq9+wz95PxZ3RDEySFNzCCxjxMjpqNV3pEvi
	d4Tky9dg==;
Received: from [187.90.173.251] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1rhG5h-0060jN-5a; Mon, 04 Mar 2024 22:43:21 +0100
Message-ID: <15015345-3068-2fb8-aa38-f32acf27e1d0@igalia.com>
Date: Mon, 4 Mar 2024 18:43:05 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC] How to test panic handlers, without crashing the kernel
Content-Language: en-US
To: John Ogness <john.ogness@linutronix.de>,
 Jocelyn Falempe <jfalempe@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Daniel Vetter <daniel@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Lukas Wunner <lukas@wunner.de>,
 Uros Bizjak <ubizjak@gmail.com>, Petr Mladek <pmladek@suse.com>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Douglas Anderson <dianders@chromium.org>,
 "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 David Airlie <airlied@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>
References: <266579a9-fde6-40ff-b13d-fb2312db406c@redhat.com>
 <87edcpn1l3.fsf@jogness.linutronix.de>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <87edcpn1l3.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/03/2024 18:12, John Ogness wrote:
> [...]
>> The second question is how to simulate a panic context in a
>> non-destructive way, so we can test the panic notifiers in CI, without
>> crashing the machine.
> 
> I'm wondering if a "fake panic" can be implemented that quiesces all the
> other CPUs via NMI (similar to kdb) and then calls the panic
> notifiers. And finally releases everything back to normal. That might
> produce a fairly realistic panic situation and should be fairly
> non-destructive (depending on what the notifiers do and how long they
> take).
> 

Hi Jocelyn / John,

one concern here is that the panic notifiers are kind of a no man's
land, so we can have very simple / safe ones, while others are
destructive in nature.

An example of a good behaving notifier that is destructive is the
Hyper-V one, that destroys an essential host-guest interface (called
"vmbus connection"). What happens if we trigger this one just for
testing purposes in a debugfs interface? Likely the guest would die...

[+CCing Michael Kelley here since he seems interested in panic and is
also expert in Hyper-V, just in case my example is bogus.]

So, maybe the problem could be split in 2: the non-notifiers portion of
the panic path, and the the notifiers; maybe restricting the notifiers
you'd run is a way to circumvent the risks, like if you could pass a
list of the specific notifiers you aim to test, this could be
interesting. Let's see what the others think and thanks for your work in
the DRM panic notifier =)

Cheers,


Guilherme

