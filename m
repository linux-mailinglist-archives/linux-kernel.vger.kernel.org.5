Return-Path: <linux-kernel+bounces-56609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EBF84CC85
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F2A41C25435
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC787C099;
	Wed,  7 Feb 2024 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VqWrEfm1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nEC8Sjpt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1127A727;
	Wed,  7 Feb 2024 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707315623; cv=none; b=upn5BJx51BUhOE75qrgRDAevI4yJosRNiqycBYHO04MCWdR74TNqTUlNi+tjAZS9fw6JoTVCWAqzvXnOVvop3PPgcFnGIJHIjZ8tqb07LC2wGPDrpvn+5ww5UakDCsH27uJ+QmUZhyLZWIYPHbugK5/jDUp1jrFCZxgHshZ4PHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707315623; c=relaxed/simple;
	bh=VeIwhT0fe+92MYX6xTuLNA8rK5oh5GCxSe8VVVvUYns=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Z8Tx2HPGNyuWYRWYWiNAmIuCnvmPOehKM/FQHcyRYQIngL4JoMhu+vWLXG5pBQzNh2D9eM3WlwCr2AaM+x8tYWopOTruXf4xKLpvrVvWNUuqhbOyqJykhpiN3tjSRtUMbv+R78pN1Noi04uDOqp8/qwtUUho/6ulv8Cj7h+iYnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VqWrEfm1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nEC8Sjpt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 Feb 2024 14:20:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707315620;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dOskqa7x1cU++5agYr8pcl79v/5x3SzbWotILDZVXus=;
	b=VqWrEfm1Hal23q9k7FqV9bqnDUFtr50xGwQD5PNqedKP9b3w7WCsrWtUBQInlS7fP2B0y9
	DN01phW5i24w7wWWIdVBWQcHI56Mg43p0pcFzhiiOKn++p3krHAe+kteS3YE8mRdVDbx98
	cqPOzT7j3GsGQvja7I+WACMD0nHmcPl3vRlpIBhvV9ipFu/LDnpFLd1jSfj7LeUkLO/Mh5
	FBEF/pxMlLLltAZEjULd+iD0aK4WDlrooexYIUghRECn825AD3TLwMcPW5AJ+qsBItHgxf
	BDUNlr/rVoZdWX/0S0HhA5ZtiaTfdUscLsZ4dLX4kNq3ubUuE9LufXkuozAveQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707315620;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dOskqa7x1cU++5agYr8pcl79v/5x3SzbWotILDZVXus=;
	b=nEC8Sjpt/aTRFSTOA1lylWshj70E4DjaR/00U0wfVf9ROqXC9+9sok+IRHZYAARMRKl2P+
	pH8Famkl9oYOJ8BQ==
From: "tip-bot2 for Ricardo B. Marliere" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource: Make clocksource_subsys const
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Ricardo B. Marliere" <ricardo@marliere.net>,
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240204-bus_cleanup-time-v1-1-207ec18e24b8@marliere.net>
References: <20240204-bus_cleanup-time-v1-1-207ec18e24b8@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170731561942.398.5422557140966598380.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     2bc7fc24f9a85cb6b7335354b2733615727689f6
Gitweb:        https://git.kernel.org/tip/2bc7fc24f9a85cb6b7335354b2733615727689f6
Author:        Ricardo B. Marliere <ricardo@marliere.net>
AuthorDate:    Sun, 04 Feb 2024 10:40:15 -03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 Feb 2024 15:11:24 +01:00

clocksource: Make clocksource_subsys const

Now that the driver core can properly handle constant struct bus_type,
move the clocksource_subsys variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/r/20240204-bus_cleanup-time-v1-1-207ec18e24b8@marliere.net
---
 kernel/time/clocksource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 3052b1f..4ef0665 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -1468,7 +1468,7 @@ static struct attribute *clocksource_attrs[] = {
 };
 ATTRIBUTE_GROUPS(clocksource);
 
-static struct bus_type clocksource_subsys = {
+static const struct bus_type clocksource_subsys = {
 	.name = "clocksource",
 	.dev_name = "clocksource",
 };

