Return-Path: <linux-kernel+bounces-92789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00060872602
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE2428A838
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1CD175AD;
	Tue,  5 Mar 2024 17:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="O19GfPtP"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F88B175A6
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 17:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709661083; cv=none; b=HDV3UHXet6reuI73Udi8Y4Df4wtxCX/dcrqgoYiPYxF3521Dp0dXZgUCd4GAmo5ay71PCxTJd9rgMTIqjbkqt/6bJf0vVt3kZFwGVb/mg8ToB6ntE78+IvFqIQvtnTVKPK9w+lARp9AgMktOg9ddrI4kaIH6b1xGUs2Kfm+MLkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709661083; c=relaxed/simple;
	bh=3qs0HAQZhk6vRqfVWwucVgVMDW9ITOlHkZVL0DNK5xM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MEforeihgDfB9660DzrQ845KhLor6oUH/YiSIpxrqxiUaBtgCJLjru/tVMQaPFtvm7PKxgmnvQ4HNaUGpqEYfTqQmpJV2nzwve6b2F9G5KmU1MgVdZ3os2bXlVgsK0PIB/PyEX5lGduB5TCS455qXpCeBx2wV+jbqIk+gJ+qdOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=O19GfPtP; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OryvIzzC78fLNiJM5tDS7CTV+mpBOEM5K+ePV0wOwPk=; b=O19GfPtPID2BGaSmWQCLguZxAP
	D/yNCoLEHrezKsM6KVaOVznHugp7dZmQ//e7ggcsbplUqqJhCH9pwRbPA2g5ah3vBLXkEvj8cnrLT
	GZIflT5D80XVUnT5yHDwOEFM61Sh7cBIDL2lgOU6UnE3cMTLesLzlB7g0lBN28hTq9S8psqLDCqDu
	JbIGr4gg1lLFLK/3ZwSNYVHoyy1kJ9Pw0ArrN5VcBG2qxXVKYEE7EofhVyW+SFfa43ofdKOiKkgpQ
	CGLoWX/ZYhjCMuCm67HuyOEY02WxXXv/xCetL/4B7xOdQEIpsBlYsZlfUzD/E80ly2gmCb+xnPYxJ
	zgphCLag==;
Received: from [187.90.173.251] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1rhYwM-006KfD-MC; Tue, 05 Mar 2024 18:50:58 +0100
Message-ID: <3d0c4180-aa6d-4519-d6d8-8f16b98587dc@igalia.com>
Date: Tue, 5 Mar 2024 14:50:51 -0300
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
To: Jocelyn Falempe <jfalempe@redhat.com>,
 Michael Kelley <mhklinux@outlook.com>,
 John Ogness <john.ogness@linutronix.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Daniel Vetter <daniel@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Lukas Wunner <lukas@wunner.de>,
 Uros Bizjak <ubizjak@gmail.com>, Petr Mladek <pmladek@suse.com>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Douglas Anderson <dianders@chromium.org>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 David Airlie <airlied@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>
References: <266579a9-fde6-40ff-b13d-fb2312db406c@redhat.com>
 <87edcpn1l3.fsf@jogness.linutronix.de>
 <15015345-3068-2fb8-aa38-f32acf27e1d0@igalia.com>
 <SN6PR02MB4157AF2E765F7ED3B9487351D4222@SN6PR02MB4157.namprd02.prod.outlook.com>
 <d1d2093c-72a3-4f64-9a8f-9844dc38f0c5@redhat.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <d1d2093c-72a3-4f64-9a8f-9844dc38f0c5@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/03/2024 13:52, Jocelyn Falempe wrote:
> [...]
> Or maybe have two lists of panic notifiers, the safe and the destructive 
> list. So in case of fake panic, we can only call the safe notifiers.
> 

I tried something like that:
https://lore.kernel.org/lkml/20220427224924.592546-1-gpiccoli@igalia.com/

There were many suggestions, a completely refactor of the idea (panic
lists are not really seen as reliable things).

Given that, I'm not really sure splitting in lists gonna fly; maybe
restricting the test infrastructure to drm_panic plus some paths of
panic would be enough for this debugfs interface, in principle? I mean,
to unblock your work on the drm panic stuff.

Cheers,


Guilherme

