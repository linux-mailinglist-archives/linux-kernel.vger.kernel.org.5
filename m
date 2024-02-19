Return-Path: <linux-kernel+bounces-71688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BB185A908
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBD10B259AC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC3C40BE7;
	Mon, 19 Feb 2024 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V2zUSuX8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UQsJZDNp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D683F9F8;
	Mon, 19 Feb 2024 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708360521; cv=none; b=pHSonDjs3QjqWItgR7n+rBP7KB/1NtlNGBr9jk6DIeQBPFZxWTXtzr0scareYXclAEfGjXRqlI/w4QqlYzA7W7vLOauLL/Ls6hscRG9/GiSfRo8SOyy0X2hlBXmkH9E5iTFhltCJaNCo2k3KjXHPgRqRJbNx6OP51yXQDhpjX+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708360521; c=relaxed/simple;
	bh=0/qGMTY0QzX5yGfg8KCT/DD2MfErUyzudLGCN7wutkA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Nm2NySnp6UaMEaZcdQoJ/cNjc3/prF6czQxqymdBqkJwt/4zV9bw0hVCEptSlzRWbSzbDXrL9p9bBgZDyPDn5w7s45dFFjeE1d1PoW9O6RT5obP7uhL1D410aV/XIWb5fSHE6l6t1PcOvGOgMTfCenFx+6HRMvvItAsrSHC9K1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V2zUSuX8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UQsJZDNp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 19 Feb 2024 16:35:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708360518;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pk7T2jpSR0byywKBG5od7jkk31qcfovIG9EFCImsOd0=;
	b=V2zUSuX8g4477CHqws2anB3wJH76GLShjMu1UjcuiDdOgULWAqvutYwepKWjsmVoFuP5J8
	20PH5USRSQ5zcMLXoHBpFRf7Cr1ChuCC7y+UXMKdFHzUiNbSV4e9g2gtI/hVu0cN/R0po5
	u82VdFfGizQ3mqLrChcZikGGB3POnA9BDQkuthEd5ij0uBmIz7M3NvVHyyZvFAZ3KLIqXt
	jIy7xOSmG41Jn2K9Zg062jAkW28V0k9+Fj7jll574Wo1tPgMarvfxxhdb2wD9cnnsv+UmB
	vSODrbKZhzDD+9Obtp3Qqg9f32g8JGWeGeWQj2AO5fOYFbZuzs6ZCbsKvv4vag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708360518;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pk7T2jpSR0byywKBG5od7jkk31qcfovIG9EFCImsOd0=;
	b=UQsJZDNpYsRm30+4+Akfy08+Mbi674FcHEThCCgIX1U81WAY5sAeBy8J+qhLUTtm1vPniA
	Kze4/vIexvCKNRBg==
From: "tip-bot2 for Peter Hilber" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Fix cross-timestamp interpolation on
 counter wrap
Cc: Peter Hilber <peter.hilber@opensynergy.com>,
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231218073849.35294-2-peter.hilber@opensynergy.com>
References: <20231218073849.35294-2-peter.hilber@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170836051741.398.13453271590417776552.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     84dccadd3e2a3f1a373826ad71e5ced5e76b0c00
Gitweb:        https://git.kernel.org/tip/84dccadd3e2a3f1a373826ad71e5ced5e76b0c00
Author:        Peter Hilber <peter.hilber@opensynergy.com>
AuthorDate:    Mon, 18 Dec 2023 08:38:39 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 19 Feb 2024 12:18:51 +01:00

timekeeping: Fix cross-timestamp interpolation on counter wrap

cycle_between() decides whether get_device_system_crosststamp() will
interpolate for older counter readings.

cycle_between() yields wrong results for a counter wrap-around where after
< before < test, and for the case after < test < before.

Fix the comparison logic.

Fixes: 2c756feb18d9 ("time: Add history to cross timestamp interface supporting slower devices")
Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/r/20231218073849.35294-2-peter.hilber@opensynergy.com

---
 kernel/time/timekeeping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 266d028..8f35455 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1186,7 +1186,7 @@ static bool cycle_between(u64 before, u64 test, u64 after)
 {
 	if (test > before && test < after)
 		return true;
-	if (test < before && before > after)
+	if (before > after && (test > before || test < after))
 		return true;
 	return false;
 }

