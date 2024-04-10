Return-Path: <linux-kernel+bounces-139471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A238A039F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B3D7282938
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E0D3A1A2;
	Wed, 10 Apr 2024 22:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KEfir5ut";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mRPtHIDZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F204B50249
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789207; cv=none; b=Vw2wii4I/uzYEwboTY190VVDL2VK17DfljHHqLXS3tp3Vh3fxU4e0deuSnhVfXJOYTTCFWE7peHdFyrynfocVTVz+ukS3ON2c1XR1FRVBHLWlfZcr2YLyQmtZF10aDH4TRPXE5aQidMBNgQ5AnG9Ri/OhmS1/F+FwLZsaRkOYSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789207; c=relaxed/simple;
	bh=9JR/luG7t5T3jOUPOePLWiqmKbhtO9ZuNt63a7+o1js=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=fdKW8WDrDdYjLG8uS92FM2UsMRvZAxi/3Gb6wzZyNbSTPIziFo2311psF289sFMBJzpFENWxyc40aMwmyavSj4FSQoFZCw5BOYrniXHdPga8mDqU2uwERteuDRT+FRL3JygyY66UQS8/lv6oworWE8ZsEPunwqyi/5dQuSxmaSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KEfir5ut; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mRPtHIDZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240410165552.069350753@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712789204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=eV59jzwlnvMqC78q7RxRP7GMuITiFT7fNLVqSGWWbAc=;
	b=KEfir5utURRdFHULxGLSLgNBqucoflI9ebdqhPJ2zP9A2YFAVFjRuBAtDucpHCjNfqAWeN
	PULK8sogl1TVIkLuhtYCYAAxIHIh1JIWZVe9McPVuy7zqKat2JDQyfwQLXcR0GlivapuVd
	BH+gNrWg6ZmBgeOeAqwbpyYk71rwyd0/uWeVmyOcEV/L3lYoElNcgFw+B5QeKL695qGxBD
	sCNxh8NfqIPz4l0gOo32pc656kaxeVqny/M+L+4J4016mRw+XSPEpNPl2h9Lod7H4+FMB6
	uxVOTT6r3ldmRrzd6H75XNasqe4O7FuyzQMfkzehGFmflpD5fzk9xp2oxzuPvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712789204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=eV59jzwlnvMqC78q7RxRP7GMuITiFT7fNLVqSGWWbAc=;
	b=mRPtHIDZwPxnELHsnfmJe5k2TmYBxInFypS+d40LNMIv4kSRS5YGx2Lu//iqJHaXroHNcG
	bHdZfBC7POS0/KCg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 John Stultz <jstultz@google.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Oleg Nesterov <oleg@redhat.com>
Subject: [patch V2 18/50] posix-timers: Clear overrun in common_timer_set()
References: <20240410164558.316665885@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 00:46:43 +0200 (CEST)

Keeping the overrun count of the previous setup around is just wrong. The
new setting has nothing to do with the previous one and has to start from a
clean slate.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/posix-timers.c |    1 +
 1 file changed, 1 insertion(+)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -881,6 +881,7 @@ int common_timer_set(struct k_itimer *ti
 	timr->it_requeue_pending = (timr->it_requeue_pending + 2) &
 		~REQUEUE_PENDING;
 	timr->it_overrun_last = 0;
+	timr->it_overrun = -1LL;
 
 	/* Switch off the timer when it_value is zero */
 	if (!new_setting->it_value.tv_sec && !new_setting->it_value.tv_nsec)


