Return-Path: <linux-kernel+bounces-136397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C693789D39B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 756D11F22CCC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F392F7D40E;
	Tue,  9 Apr 2024 07:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YmAM6foS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QspW2m+w"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD8A7D3E0;
	Tue,  9 Apr 2024 07:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712649461; cv=none; b=OlJLPmYmJRggtSxkbNEA4Ipqmv2BE+f+DCjJfXFrOayvAdWaoBFFKqldLutp38C+X5okLo1mEXOK+Yf9361pzc5+troRjVPVwVialplv7m0hhuJxBdaXoFf83nC3yoybN4hLlgfhHoSrSfmyXdX4Yu2fdA63SLb+BhN5maPv/zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712649461; c=relaxed/simple;
	bh=3iLCOHZGZxn8caX6nvkzqjZa1OPo1B0x90mnVg5jlAM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qc5ka/YiZLJnbXFEuvXfl+wAoluwPbYtFc6dOq9pUSXCSNRg61UaaCIeuxeM8humv2MXGBZRdKUCZH4IpGBb7fAbMo6ReRm7sN3ZoI4Y7PCO3k3nNetXiQmB5th5Dkf40r8OidAqTYDV0ZQQLFo++WUfPfnc1KzRhZ2rUr1qKt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YmAM6foS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QspW2m+w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712649451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xQSgeM4AOh1vk8otimsz4IR1mQP8l+71QrIomYISZaA=;
	b=YmAM6foSsh41RBsiuQ7RGikoc9sXx4Grz6IpkysyTC9S3yJo0vpKQlV2r2oAsoXfKYzN0X
	vEmUqjKoVLtNmIOU3T+dbpyn2wB9NjCV58+PUvtbAF5BnMdjlC6R8juXtra1ZQZTEp3D3D
	vkP5/ivTvFf0OV8evuxyeb1L3yRtvSlEcpjfbwjlLrZ4ub5kBfHTu0AZun9rQaVLaivEXv
	Zr6JAw45bi2IuRM7RX+09Ty/AXc+onbPm/seHPZ/mIvRlMmiCPNeVmqAfRrmb3HxkyoZrd
	pU0hbVPxn7uzC2cBsOlFMEOW/NY1rj27kDAmVCxBx/srayyZpjbssWL1quIITA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712649451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xQSgeM4AOh1vk8otimsz4IR1mQP8l+71QrIomYISZaA=;
	b=QspW2m+wUvK5rhD/Km6upKLw9mUpFDsNeceaZzlosSny3PVGGlynwtv6G9P6bzqTNV1heM
	QGIpuzCO3dOVWyBg==
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar
 <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, LKML
 <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org
Subject: Re: NOHZ tick-stop error: local softirq work is pending, handler
 #08!!! on Dell XPS 13 9360
In-Reply-To: <256fdb2e-9b83-4837-bd31-0c34e4267c31@molgen.mpg.de>
References: <354a2690-9bbf-4ccb-8769-fa94707a9340@molgen.mpg.de>
 <87o7ak411y.fsf@somnus>
 <256fdb2e-9b83-4837-bd31-0c34e4267c31@molgen.mpg.de>
Date: Tue, 09 Apr 2024 09:57:31 +0200
Message-ID: <87sezv7ytw.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Paul Menzel <pmenzel@molgen.mpg.de> writes:

> Dear Anna-Maria,
>
>
> Thank you for your response.
>
>
> Am 08.04.24 um 12:10 schrieb Anna-Maria Behnsen:
>
>> Paul Menzel writes:
>
>>> On Dell XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022, with Linux 6.9-rc2+
>>> built from commit b1e6ec0a0fd0 (Merge tag 'docs-6.9-fixes' of
>>> git://git.lwn.net/linux) the external USB-C adapter Dell DA300 stopped
>>> working (only the Ethernet port was used). Linux logged:
>>=20
>> thanks for the report. Can you please provide a trace beside the dmesg
>> output? The following trace events should be enabled (via kernel command
>> line):
>>=20
>> trace_event=3Dtimer:*,timer_migration:*,sched:sched_switch,sched:sched_w=
akeup,sched:sched_process_hang,irq:softirq_entry,irq:softirq_raise,irq:soft=
irq_exit
> Unfortunately I haven=E2=80=99t been able to reproduce it until now. Shou=
ld it=20
> happen again, I am going to try your suggestion.
>

Thanks for letting me know.

Thanks,

	Anna-Maria


