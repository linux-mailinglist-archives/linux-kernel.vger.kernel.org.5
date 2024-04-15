Return-Path: <linux-kernel+bounces-145480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E488A56B6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D1482839FB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E056F7A140;
	Mon, 15 Apr 2024 15:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MQT7VQ//";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oVnLdcAk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95BA78C7B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 15:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713195825; cv=none; b=p85p+mMP7PDA0nkxiG3hpRfU7dtNap4t98sXW4WNyejCp4pxgfCNd46B8DlAa3rlHPZtvdfvT1Z8EmEcC3ueKn5VmvGOex9B1SDXWfleJqC5XUBNPSwEt7i5w/2XODrhOhRL5+XsfDbtZx1WzXptwrN20xiz8EGWFYhAHAmiO00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713195825; c=relaxed/simple;
	bh=tXti21RKk3WiRN5ZkpL5zI3TBh0gSGT9sbgbGWxBPxI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MRyoc2WIyLrdvEZ1zYuddwfYdx1Duqb2U7hlVUnntQAP7ESRvg7yL/ERk9AVCSMM8N3gcfxy1S50s7KczgXj42v97+BZuehqSAxaE++nKLCOu7THSuMkUFsmxkkcOYp1wFYLOOR7132CF3wApJZzfCmaPyBNPIJrjRyYqQrvGsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MQT7VQ//; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oVnLdcAk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713195822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tXti21RKk3WiRN5ZkpL5zI3TBh0gSGT9sbgbGWxBPxI=;
	b=MQT7VQ//6jVYe8h+/+cK8WE35Kt98YJHbq59Yx110+Yu1kWkfsQCTWiqhHjBbp69wtel9p
	n9TrCxPE4jEKTxzXuapm4XGEcDz/omZcmAvfaGW02BHMtMj8+/L2/SvaGBUodTlnH+amEQ
	JnX1alxD/RYnsa2Ci1GnYQ3RiyiIGp1cz51vhZaPeolGlIaWz8Chw+g/W8+ehuQl3HjgtC
	xGieSWnQGaFd14XECMrMyxPoIKKgSl0o1dCN2MQaisGWFlI79lvMgSJjI+WNSbcX+tbsdf
	gPziYJ37DFnmibRH0imNR0K9xN6O4dc/afuHtz4Y0nofyUjkL/za7/JeAlOLuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713195822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tXti21RKk3WiRN5ZkpL5zI3TBh0gSGT9sbgbGWxBPxI=;
	b=oVnLdcAkEOeLTVpSqB29DRu9YPF1vSS3PQ8SaTkFasYWl6yNk3ocPHtV3CKtJ78/D6b1S6
	fP2JqtFbJwTr/dBA==
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, John Stultz
 <jstultz@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Eric Biederman
 <ebiederm@xmission.com>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V2 17/50] posix-timers: Retrieve interval in common
 timer_settime() code
In-Reply-To: <20240410165552.006883398@linutronix.de>
References: <20240410164558.316665885@linutronix.de>
 <20240410165552.006883398@linutronix.de>
Date: Mon, 15 Apr 2024 17:43:41 +0200
Message-ID: <8734rmvdg2.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Gleixner <tglx@linutronix.de> writes:

> No point in doing this all over the place.
>

Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

