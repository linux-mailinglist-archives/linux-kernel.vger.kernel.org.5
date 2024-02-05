Return-Path: <linux-kernel+bounces-52698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEB7849B8F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59E23283FC9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EAA210E0;
	Mon,  5 Feb 2024 13:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEeuHPmW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7021EB56;
	Mon,  5 Feb 2024 13:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707138940; cv=none; b=RvdbZbyoHH5o4rjEZlmX8QK9qbNBs2wylqXfTWvumGO3cBxsWm2OKX33BNm2K2Il3iaAKxutKMSs+GFkZW1NTFrD5M41marDca/LFZUuaePP0wfXTY2Roye0p/57K9Sz4n6iRAOfqlVGjD3GxopqwI5MrLxP61HLGiVsviKGt2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707138940; c=relaxed/simple;
	bh=6JEN0DBAiHPFyGGPONH92+iR7vBOYSdVo4q0QeyWNw4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uWTGInSQ7HCJV+OMfl33Z0swEp6QVIq3xOCAg89DryJbgcohg/lDPEaj10p5D7EModSzvgUYjzfBi3mKkrgPkqpoIwOtZm/Pj4uc0ah4bJF/5nrKCMcMK77vjfocelOQYkAt+73k65TY+hGx1WxmrjBpfKrOzmg0HpUxB+XGUuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEeuHPmW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A56C43390;
	Mon,  5 Feb 2024 13:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707138939;
	bh=6JEN0DBAiHPFyGGPONH92+iR7vBOYSdVo4q0QeyWNw4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jEeuHPmWknWSvna+7Tkazlgv5+2cap1HwWBU3db/vLXOWu5fTsL47AYuUR1PdXXC+
	 rJMyAZ3b2LbVAbHAdVAoUNZRfpe09Jdon9H871vYPeQ0fQY9x0pS0V/yOlI9Ef85aX
	 iBq+/oDFtAc6bYlLDHp3/5o9ioFollD/3p7B7NFZXTqwFB7LMKPwyzSJNb3RqtLePn
	 VwLh+MiXFoMi5iSpKWcCUaXwJ8D6BBK0/s5aLRnva+OzHhL1ZYVT50m7TTlv8GpHqL
	 af3/6Co5Umzh0CDlHePmM/csh2C0/Ctng3HE4yq3xB18uLtdRSjtc80nEvWFLzjM+K
	 6av45lPley9iQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1rWyoz-000QXp-A2;
	Mon, 05 Feb 2024 13:15:37 +0000
Date: Mon, 05 Feb 2024 13:15:36 +0000
Message-ID: <867cjj6ohz.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: James Clark <james.clark@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	broonie@kernel.org,
	suzuki.poulose@arm.com,
	acme@kernel.org,
	James Morse <james.morse@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Rob Herring <robh@kernel.org>,
	Miguel Luis <miguel.luis@oracle.com>,
	Jintack Lim <jintack.lim@linaro.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Vincent Donnefort <vdonnefort@google.com>,
	Kristina Martsenko <kristina.martsenko@arm.com>,
	Fuad Tabba <tabba@google.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>,
	Jing Zhang <jingzhangos@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/7] arm64: KVM: Use shared area to pass PMU event state to hypervisor
In-Reply-To: <ZcDc8-FQo8wKavA4@linux.dev>
References: <20240104162714.1062610-1-james.clark@arm.com>
	<20240104162714.1062610-3-james.clark@arm.com>
	<Zb1mCCi13AJ_YjFZ@linux.dev>
	<8a908ee8-620a-d9c2-734b-5a6402950072@arm.com>
	<ZcDc8-FQo8wKavA4@linux.dev>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: oliver.upton@linux.dev, james.clark@arm.com, coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, broonie@kernel.org, suzuki.poulose@arm.com, acme@kernel.org, james.morse@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, mike.leach@linaro.org, leo.yan@linaro.org, alexander.shishkin@linux.intel.com, anshuman.khandual@arm.com, robh@kernel.org, miguel.luis@oracle.com, jintack.lim@linaro.org, ardb@kernel.org, mark.rutland@arm.com, arnd@arndb.de, vdonnefort@google.com, kristina.martsenko@arm.com, tabba@google.com, joey.gouly@arm.com, akihiko.odaki@daynix.com, jingzhangos@google.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Mon, 05 Feb 2024 13:04:51 +0000,
Oliver Upton <oliver.upton@linux.dev> wrote:
> 
> Unless someone has strong opinions about making this work in protected
> mode, I am happy to see tracing support limited to the 'normal' nVHE
> configuration. The protected feature as a whole is just baggage until
> upstream support is completed.

Limiting tracing to non-protected mode is a must IMO. Allowing tracing
when pKVM is enabled is a sure way to expose secrets that should
stay... secret. The only exception I can think of is when
CONFIG_NVHE_EL2_DEBUG is enabled, at which point all bets are off.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.

