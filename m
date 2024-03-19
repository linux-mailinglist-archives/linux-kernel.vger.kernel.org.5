Return-Path: <linux-kernel+bounces-108002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAB18804AF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC0FA1C225D7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AFE3B2A2;
	Tue, 19 Mar 2024 18:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GMqpmle1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b45l9j8m"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3E63A1B0
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 18:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710872493; cv=none; b=r+z7JJAuk4NqHPj48K4YIdOl4DYqIiFAWiFWLxgt835b1YbX3PPaQ7jZySVbPuo4TEFVhdwaQi/HDBRfeGoE7vyEefAn0i3DzYyRMNKe8IFlgTLZAoUEPISqaA9PVEjponpPFki9k/2l/77+6pND05mrbJgPr2x7OohVlUcnfvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710872493; c=relaxed/simple;
	bh=wCYhqiHYU0QdQ4Do9oAmb68LqfxcQNz1K0yqz+H7+7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7l/QocWujcL8se+muNYLWGOrJNFeEZV0Xk8IbQfilJz89s5QbX9EmC2QOK25lZrm6MgmR4l6N6ro/0bkMPGd8jtCyVEled4FoNsNY14U6RhG96zWlm4EHusDR31IKbfx5AHVifqTh+LSmQ5YjErYhJHRdAFkZj6VMbHMqa6IbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GMqpmle1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b45l9j8m; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 19 Mar 2024 19:21:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710872488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wCYhqiHYU0QdQ4Do9oAmb68LqfxcQNz1K0yqz+H7+7U=;
	b=GMqpmle1AcbnMPmTiS7lIX7Sqg3/BtVTi2i5eZTpgZE3ROpy6Y9y4L8kEAOU9eSTyLdsUS
	jnOnIv09AIWnkBRLv1JqubcQ5QIjreqR50l/fE9QGe2LaZnqgYgJ264YaNU0p4gPR0YlIS
	wCwyMMjjmZVZ2LCCm0lhXe7qUD9kvAym31QxYKTJ5RA1zR2ZoKsogAZvJl902cNMsZ0zGY
	6cMf68Bvp62/oHamDR2v4IJ0uGqEuhh1O3A20FTSZZnx8ZEns/euNHIPqrsDBNYjtB7fwD
	T1gQQwJtFlD2GvkvHVH1Cx2a/XScCB5341lmrlWwDRwSEhB576Ly2YkiDYcNdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710872488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wCYhqiHYU0QdQ4Do9oAmb68LqfxcQNz1K0yqz+H7+7U=;
	b=b45l9j8mePD8+WRNUbevJNzWBsfKbm1qdZnDa3vUY2hwk9qIb17UNpINGtXEw2LzC+Mw0P
	2S+gIKv8lLwXl1AQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] Locking: Let PREEMPT_RT compile again with new rwsem
 asserts.
Message-ID: <20240319182127.Sl43cYr2@linutronix.de>
References: <20240319070550.ws_uO21-@linutronix.de>
 <ZfmVPid-d7cpf6Yt@casper.infradead.org>
 <20240319141506.DUd9NKl4@linutronix.de>
 <Zfm21jBMZIci3P6P@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zfm21jBMZIci3P6P@casper.infradead.org>

On 2024-03-19 16:01:26 [+0000], Matthew Wilcox wrote:
> I see Waiman already gave you the substantial answer ... but why did you
> change inline to __always_inline?

To align with the all the other functions in the file which were defined
like that.

Sebastian

