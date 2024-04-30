Return-Path: <linux-kernel+bounces-163718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD44C8B6EB9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A43FB21A13
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359CC1292D8;
	Tue, 30 Apr 2024 09:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hxQbr2tY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5DsTfBnc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2D9FC02;
	Tue, 30 Apr 2024 09:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714470262; cv=none; b=aBwNRPZlSN6YxrqVDc+y43BUx9DqkvG5N5517MlngR2UYgkXxK4SI0jmA9IhwKS7r3sZBmMDQun8S5Bvhs2KUAtJmJuLg6Fv2dNQ8UpqXAP3vD6/Wz4AkhVUxfQCmy/pfv/YS/1Oq6qilTxt3aa3pdBGzjHESs2X68VgkqKeyxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714470262; c=relaxed/simple;
	bh=aIsQXx2cN/50Udekd5YIExQDXbNkiZsE9WboBbCOMQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TW6upqxv/4G83X7LN83q2ZNHIIaNcpfx6cQT/7SLRmWWeprGzCtrPaDZGZtsvwCTcir1eDf6Bn5nqvFDYhacOvZQqjOry1knoUVE/8Rsl5/sHWEW21rX6IDxbYYA+YQbue2gyTExpOZxgASThqkJBCtq4ZX7xEkqk1yU1JZFyXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hxQbr2tY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5DsTfBnc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Apr 2024 11:44:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714470253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bOowKsb3vb6yvE+cHvGM8w7R27xqlmhDeNm22h9uWUE=;
	b=hxQbr2tYYR6Ee1lJAT7He76rz7uXN6fITztCydq5R0y+2aXyzx8y+6Vo8XqV6nS88lNBRf
	O8dHd4EW32yeLXJN8c7IKdifsAlO/z0QgYuVXt10ewaEHZegcW665jqMZzWSDTOEsV6fnJ
	D2v2sjGmwSHsyH+eMnHr9ER3CAys89T2NuTcRDKFHdgCWlieih6ADW0382t8MACk0ufyas
	PELieLLS62LEZEJy8FVU96XIkb1Jr0GMDe5hw0BihhHKlh8k15qs0GHB/rJ+BUTg3SkykZ
	deJDPLJbOmfwjOUasL+gCCspLGCL0L92T2ePcmO29MlTjMtEryv846jW3oGUaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714470253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bOowKsb3vb6yvE+cHvGM8w7R27xqlmhDeNm22h9uWUE=;
	b=5DsTfBnc0PChyayOH2+kxEBXSDG2J4T+waLj2XZspU23YotrwFbDfRM+u0cPo8IfqEAVz0
	5oX+BJ6diAdjfrAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-rt-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] pmdomain/cpuidle-psci: Support s2idle/s2ram on
 PREEMPT_RT
Message-ID: <20240430094411.HyS2Gecw@linutronix.de>
References: <20240429140531.210576-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240429140531.210576-1-ulf.hansson@linaro.org>

On 2024-04-29 16:05:25 [+0200], Ulf Hansson wrote:
> The hierarchical PM domain topology and the corresponding domain-idle-states
> are currently disabled on a PREEMPT_RT based configuration. The main reason is
> because spinlocks are turned into sleepable locks on PREEMPT_RT, which means
> genpd and runtime PM can't be use in the atomic idle-path when
> selecting/entering an idle-state.
> 
> For s2idle/s2ram this is an unnecessary limitation that this series intends to
> address. Note that, the support for cpuhotplug is left to future improvements.
> More information about this are available in the commit messages.
> 
> I have tested this on a Dragonboard 410c.

Have you tested this with PREEMPT_RT enabled and if so, which kernel?

> Kind regards
> Ulf Hansson

Sebastian

