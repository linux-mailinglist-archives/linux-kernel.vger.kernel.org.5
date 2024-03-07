Return-Path: <linux-kernel+bounces-95942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4880B87552C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 039AB28680F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118EB130AF8;
	Thu,  7 Mar 2024 17:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="dJmSa48x"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295CE1E89D
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 17:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709832645; cv=none; b=tRCwn4gfBzoBrncaulU+BE3P3sWtQ8WjPaG86JzooyfF5ku59exUg1bNUV4bCvSVrzh/qQ++DwQnbMnfya9959aSov8ZNCjVhqebEzyggY6k5ayCOWrBk2SFePpeqrMmn8ItysFMaOKEd0+eope+zock21ACAPNvtC71QLKjQ2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709832645; c=relaxed/simple;
	bh=nDX4Y4f9uDd31QKwCcae32hfL42F3oMhlu3XdePCRkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Em3pBfvHUJ0MG01dvJN5w5G0lomooFcldIrw2uzoAGb8m5CuOQzwggo2vVm3YhON2lydLq2pVctX4JvLK3rrvf5VPWw6ta/OiNXgRAkw5ndSh4IywZqdDTfm/ceUMgpZxJmK8meQZFDfSWIZJHcvsE/kKShqO4p1sSfnVa6ORIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=dJmSa48x; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Yjv33NnLtrKGXvU8im2Fiysp5cKmGpJjJLOeYzsCHSo=; b=dJmSa48xx/KGtJQYUHKXAHww0I
	2TpS6y7zmFtLxSOUg2wuvbbyMnofWM1qtRlKmrvzCtF+igxzMHaZ/vc6TQmxQGJ052ked0oZd2YQ4
	ENCSOyuIjz9g10Ks3o6oP/sk5j0S59BGjSHBg5+fFuO4C0mwLkL0u6zxtvh/gX92XKlorY7581l8J
	nVttOiWGIzoQyoPUBlvhEx5EaYIERG8v3f5EkOZStNR+s9uMJmf7WYDq+mQMoSSDNODhnSDU21kAW
	zWULxlayCTTF8PFPqoIIjeeAuRanMl4pJhMUDsdhk1iMJwQDFV/uiQ/27zpQBMwdbV2wD9PPotijG
	BZVfQcJA==;
Received: from [177.62.247.190] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1riHZN-007MWj-6r; Thu, 07 Mar 2024 18:30:13 +0100
Message-ID: <0f8e9c87-ab40-fe49-da2c-fdcfdc9deeae@igalia.com>
Date: Thu, 7 Mar 2024 14:30:05 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC] How to test panic handlers, without crashing the kernel
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
 <3d0c4180-aa6d-4519-d6d8-8f16b98587dc@igalia.com>
 <adeac189-87f8-4b70-9c04-3eaaf2ed7bc5@redhat.com>
Content-Language: en-US
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <adeac189-87f8-4b70-9c04-3eaaf2ed7bc5@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/03/2024 14:22, Jocelyn Falempe wrote:
> [...]
> 
> For drm_panic, I changed the way the debugfs is calling the drm_panic 
> functions in the last version:
> https://patchwork.freedesktop.org/patch/581845/?series=122244&rev=9
> 
> It doesn't use the panic notifier list, but create a file for each plane 
> of each device directly.
> It allows to test the panic handler, not in a real panic condition, but 
> that's still better than nothing.
> 

Nice! Seems a very good idea, at least as a first step to unblock the
work you're doing.

Thanks again for the effort, much appreciated =)

