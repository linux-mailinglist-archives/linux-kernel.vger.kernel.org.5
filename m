Return-Path: <linux-kernel+bounces-118447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DF788BB02
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4851F31DCF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498D213048E;
	Tue, 26 Mar 2024 07:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lRPe7SI2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u7Wl7kWV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCB21272BB
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 07:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711437323; cv=none; b=shpDL6zizqAppdVgmAaCP+R6DyKVfqJ0WkMzV5cXmfhep5R7/OH7FxeRJNNKXYo28jz5JsdJM/WwS/EdrN/0QMYVet4u0/UpvKGoZML3QCUtJvSc+FPGJTz52+2NSHpB409t3lQxtFeFR/l1llkaOuP501aFPsZqiZqmlgVTtKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711437323; c=relaxed/simple;
	bh=zIk4ALG0JQRKIVpRwvcdGZ/Wor1s3XRXprh31Nr4gkU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YCaNkB8uBlWDf7ERzHry9aoAkOr1oAcyyZAQetVxBCSjDUq/dWL0hdGF6gGMwqvw8JKFfVUaCCqI2Ggy6vndY9QZ7JeFiuxIwpBUhPaRtfykNVsZka8th+KSqsfbSeLvWb77g8+05vIWf7tb4Acct49jyJajr0YTsi82pU5HL4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lRPe7SI2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u7Wl7kWV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711437319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zIk4ALG0JQRKIVpRwvcdGZ/Wor1s3XRXprh31Nr4gkU=;
	b=lRPe7SI2+PGlkH+gqSamP1ukG3tl9Lzmai8mgGXoz62bKd4h88DTuSujZpwHQBqeNRUrxX
	TcC8FioZkq1Zk7X0LTbkkHBiBiRtYYOy9Tfv+DVWYSF5gFGxzRtIOWBEiRF8kFi03UjqEC
	ZuJ2DXBvcdt3wcmnK8rsMZOSN9c7qIU47Og61oiZFXlmthDrhVW9alNhCtKoLf4FhAQTY9
	0F0gpt8or9Y3l7T4JclwifQLybg+jElVpH70mcbliz8slBG5hxTvCDgqeOpOw75Fghqz3g
	fQfVmnDgVSnFy+C4syk7pbijJBQ7kqaYp43Mb7nNPRpbyJb48QrigGRopGC8dQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711437319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zIk4ALG0JQRKIVpRwvcdGZ/Wor1s3XRXprh31Nr4gkU=;
	b=u7Wl7kWVeYeq6pmxnP0kfutGTnx/EE9DbRxNNhvhFkROLN+vrJellPMRPZzbqvK32ovLCQ
	I7u4xPclOvcF4jAw==
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar
 <mingo@kernel.org>, John Stultz <jstultz@google.com>
Subject: Re: [patch 1/1] MAINTAINERS: Add co-maintainers for time[rs]
In-Reply-To: <20240325172048.548199937@linutronix.de>
References: <20240325172048.548199937@linutronix.de>
Date: Tue, 26 Mar 2024 08:15:19 +0100
Message-ID: <87edbxtqew.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Gleixner <tglx@linutronix.de> writes:

> Anna-Maria and Frederic are working in this area for years. Volunteer them
> into co-maintainer roles.
>
> While at it bring the file lists up to date.
>

Thanks a lot for the trust!

Acked-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

