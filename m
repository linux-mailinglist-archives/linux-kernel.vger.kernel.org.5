Return-Path: <linux-kernel+bounces-155290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B2B8AE84B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C6B31C23081
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABED13666F;
	Tue, 23 Apr 2024 13:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WTKjNeqY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V+R4HkPd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD49418E28;
	Tue, 23 Apr 2024 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713879294; cv=none; b=MQh2n/JiAxkgjUts71X9FvZFeo1pKfNfhLLP1PtBxJwubX5+bfcKA8uvJrMKmL7wlwhiBugzgP9fD0+UUN/1L9VORVJ75OR2C0XRXfAy9GSeXJOLqi4KNeRbBfQkyUO92+7rBIdcpU+Jk7sixg9fVy+lVlia7A9YxkbN/WWgngg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713879294; c=relaxed/simple;
	bh=v53nYGkBU6Q0r8sX3eqF6g557Kt1fMudDeT4WFa7Y2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBLFxjSGOm413Y1Di7E0rA5TMPNTxV1LleKrmdvJwQoq49X5e2PCIzAOwz4FvvLjwuCFOG6iC0xWdfAgCiyVaJTo4ZfYutB1KMWTv0ba//bKs8vDHwjSB3Sftvp+COQ2AVV5DTtG1/8BWlKf2NRKTTNUhmj1koyRMXl76PwWZEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WTKjNeqY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V+R4HkPd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 23 Apr 2024 15:34:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713879290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zQzgTOJxdV+4HqjR4K2Hng/ZiXcnP1iJM/wR6D3wAb4=;
	b=WTKjNeqY8xkmjrafgK3JHTMFWg4OmmtvBoHyR86Fz5DQGc8/m4JRw1pNturj88beqVCLmT
	u/3GvaY+7s3kCWvaUaDifQlr/v2fxGWoZwZRKq36MpJfVSR7U9iqQiDsb+Yaf1Yl8XWA6u
	kUIMap3Meje3OFinYmlFLMk4SyWh/0Pynrwvhp1WDbZ3SJZggVNkDtsfGMKqyUt4fy/nSl
	Gm04YqUim+3+mFh2FGUyWtktXFd37D71LIDKndamiMbkQgJczzSQOkBl0xmHIKKPAmT6QX
	tH0EeGkij45IWOvEoXwmtEvj3nwaeCN4OEiiEDYVuvd/7eoSzjoma6p9BB98rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713879290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zQzgTOJxdV+4HqjR4K2Hng/ZiXcnP1iJM/wR6D3wAb4=;
	b=V+R4HkPdnpgdtc0lWO90//+/pjHU2Wv+1ovkWI/lI/cCJ3k3ME+ubW3PIOsWmJQb2JUHs+
	Kju2+Ap2WqZxpOAA==
From: Nam Cao <namcao@linutronix.de>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Jaya Kumar <jayalk@intworks.biz>, Daniel Vetter <daniel@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, tiwai@suse.de, bigeasy@linutronix.de,
	patrik.r.jakobsson@gmail.com,
	Vegard Nossum <vegard.nossum@oracle.com>,
	George Kennedy <george.kennedy@oracle.com>,
	Darren Kenny <darren.kenny@oracle.com>, chuansheng.liu@intel.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] fbdev: fix incorrect address computation in deferred
 IO
Message-ID: <20240423133445.h44pcNzq@linutronix.de>
References: <20240423115053.4490-1-namcao@linutronix.de>
 <1722c1b6-59a5-429d-905c-bc1951a68a68@suse.de>
 <c2bf36b5-3145-491b-b272-d5afae73db7f@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2bf36b5-3145-491b-b272-d5afae73db7f@oracle.com>

On Tue, Apr 23, 2024 at 06:56:52PM +0530, Harshit Mogalapalli wrote:
> Thanks everyone!
> 
> I have tested the patched kernel with the syzkaller reproducer and couldn't
> see a problem.

If you want to take credit for testing it, send us:

	Tested-by: Your Name <your@email>

And that tag will appear in the final commit.

But completely up to you.

Best regards,
Nam

