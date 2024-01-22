Return-Path: <linux-kernel+bounces-32973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF388362A7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5000C1F2A4D6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9069F3D546;
	Mon, 22 Jan 2024 11:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0d6bhKtg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I7LgDcr5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18FF3D3A6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 11:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705924251; cv=none; b=q70dX8Y8BwsOEIIeUaZhY0VGwPayKBUnEeLYE5xPRoC+l/vBXmtO2WkGMc+g1N2vkEdB9SJ7ahHYrTef0yVflpTnJYO5k+Qzv/0bl3zV+MlXp2jRN9E4i9t/t0YmFGJmkNuzGwXrzqq7VJbJ0QcylDOpmeuRxgLOXXXR8TR3no0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705924251; c=relaxed/simple;
	bh=WDVvSfnhQrggKdRxldAkh0NY8BEJ1a6fEzi2Ys1K4Ng=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gf7x4zcVkFJMoOKtGGUPDKU/cJ063U/RcsGC/5ROBm4b6i04X1ENh3SNRBjrOjIYs3oITaYbztlYRVBkOiT9Ph0yoKcXCMzZymDRdoiHKYAqe+Oj1GDFJqf6NwT1nwC/OUXKRn6NWpq8OhXAynUgz5iMFuhpae5NDoxRHjaseS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0d6bhKtg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I7LgDcr5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705924248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YFKECMoJLZviLYQun4GyYyHVq4mfKjebKbyAjFy5jhw=;
	b=0d6bhKtgeguzUycm3WVrrOH6+TV9r5Dujtn4eUrsJWDfmW7g2RnYJMCN5kYXCqgYDpaNaO
	HWnintGzTTg0AhKT6vDKab72Zk7X2YTLVEadkixihP9CUtwoyPhwhYBXozeW866Hcrxs9F
	jFZ0DfrKfjxClmL++rzIAx1qgWnVeEVRfKOdS6b/TTAbo4zX+nZL/2XsYSVOSEtP8meyx6
	qzXxtPcyxdvr6qmHk0QrwxeIsmCpVCJnSVDsZdQbAyynfUDlCBx/GWH6ccBcFaXRKuTv5W
	vpMaliLgufA4PvAt82wRcJ1aTGSup8sUHoa5mtrAQ9nkvV+4bK3m5NOsdamrGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705924248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YFKECMoJLZviLYQun4GyYyHVq4mfKjebKbyAjFy5jhw=;
	b=I7LgDcr5sNyqxnOUPf71p5c1fJ7nmoe+hW0pTiNibn65JR4MjMkw+bbNkt+6O6J5VZh1uO
	Ay+w30QOTMMJ81Cg==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Eric Dumazet <edumazet@google.com>, "Rafael J . Wysocki"
 <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@infradead.org>,
 "Paul E . McKenney" <paulmck@kernel.org>, Rik van Riel <riel@surriel.com>,
 Steven Rostedt <rostedt@goodmis.org>, Sebastian Siewior
 <bigeasy@linutronix.de>, Giovanni Gherdovich <ggherdovich@suse.cz>, Lukasz
 Luba <lukasz.luba@arm.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Srinivas Pandruvada <srinivas.pandruvada@intel.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>
Subject: Re: [PATCH v10 05/20] timers: Introduce add_timer() variants which
 modify timer flags
In-Reply-To: <ZagH0wPCR9PusLxq@localhost.localdomain>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
 <20240115143743.27827-6-anna-maria@linutronix.de>
 <ZagH0wPCR9PusLxq@localhost.localdomain>
Date: Mon, 22 Jan 2024 12:50:47 +0100
Message-ID: <87o7ddy4bs.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Frederic Weisbecker <frederic@kernel.org> writes:

> Le Mon, Jan 15, 2024 at 03:37:28PM +0100, Anna-Maria Behnsen a =C3=A9crit=
 :
>>  timer flags
>
> Yes ;-)

Something got broken when importing the quilt series into git... This
also happend to some other patches/commit messages. I'll have a look at
it and will fix it.

Thanks,

	Anna-Maria


