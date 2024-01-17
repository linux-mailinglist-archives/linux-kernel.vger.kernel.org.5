Return-Path: <linux-kernel+bounces-28640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA88830138
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ED4A1F258EA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB421118D;
	Wed, 17 Jan 2024 08:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oOJ/2NXY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D0ZpV7qM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269B1D26B;
	Wed, 17 Jan 2024 08:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705479844; cv=none; b=OO9ckrjye31NGVrQMXVKsaLSQiwF1laU2j4RJ8/cpGrtuoCkzAUyK68HZdcnpE6sRwaHZTLc1+jVcep9FDpKHbsizrC4YHBfxCjtdnadAUi8pVnPbaTjAKhtDWaLfgsXiahfMWphJQ51yBJQku8O88+DYCeyz/iR41GFa4QdHE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705479844; c=relaxed/simple;
	bh=iUePzbB8NYoCvTcIh+hge5pvpFVFIrDhBmMxgFJcphw=;
	h=From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type; b=BrZNskASQKjpwZxJ2akvTB5GBwo9ChBg3BPwNmepPsPEeAEIq+ROM6sTG8euoLo9KxFq2SUhM47R91iyjc20WZpDyduIpKZ07wKAiBGeG7bh8hlbLPvfDFdSkocnwyviIG/pof2vekpbvNVR7dl56XKb0fsbuGvdQyh8HJYhWJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oOJ/2NXY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D0ZpV7qM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705479840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iUePzbB8NYoCvTcIh+hge5pvpFVFIrDhBmMxgFJcphw=;
	b=oOJ/2NXYekBGIotxEtql5Rugex2jljT0JAWyVNIVc0tIlmvMa419NfsbNURwM6TmvRva/Y
	qTtuGnn4F7csZ3wG0ITweoDvcm6vPuMz0G+ppQ//93RtkjCtOcahI2ZZOeAXHBSKsRMjXA
	eLSPopizFaB0GYhbofTNHolUCJbKkFjEVoeKIl4FYeiXZzwwzEyPTQ0tbxds2gnwZBGfkP
	D/U2qi0Z/PWOt2u2aEFXTaOGMV+K8GTWiERAK2DlE19nZKKCfkDi0Fonu9z+mRgRAAtfRb
	U+T9dRhEgQAPcJ4OAAacgJiMhDxTCYU7IiatWm7AmG05zjevCHb5ELR4xk9AGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705479840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iUePzbB8NYoCvTcIh+hge5pvpFVFIrDhBmMxgFJcphw=;
	b=D0ZpV7qMwilWr3E0PEMjGIK/quaatGP+/AsJ6qCCPesMTgZfS4MbhNY3dz0Iuw1KQTBzP8
	n8iUFk+oQ/HU5+Ag==
To: Junxiao Chang <junxiao.chang@intel.com>, bigeasy@linutronix.de,
 tglx@linutronix.de, rostedt@goodmis.org, linux-kernel@vger.kernel.org
Cc: hao3.li@intel.com, lili.li@intel.com, jianfeng.gao@intel.com,
 linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] printk: nbcon: check uart port is nbcon or not in
 nbcon_release
In-Reply-To: <20240117065226.4166127-1-junxiao.chang@intel.com>
References: <20240117065226.4166127-1-junxiao.chang@intel.com>
Date: Wed, 17 Jan 2024 09:29:57 +0106
Message-ID: <871qagtlk2.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-01-17, Junxiao Chang <junxiao.chang@intel.com> wrote:
> Different uart ports might have same console pointer,

Please explain how this is possible. It would be a major bug.

John

