Return-Path: <linux-kernel+bounces-52848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E35849D66
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 792271C21B24
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D691B2C688;
	Mon,  5 Feb 2024 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+vxXMg3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5892C19D;
	Mon,  5 Feb 2024 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707144754; cv=none; b=T/TftYFhEQFhBX1QNQa16TqSYB0mV275JxksXoa5p5hRIBuBJXhFXVpBKLnCeFe5whoaXK2bsI69+Dx/J1TWOPxD2j8J1H0Ps7kwe3ecZaUn9h8bY6p7fy0E3Kcq7x3ExefWG9lGQK32cuPL6WNOVNAlQlPi/kDPw18/98IO2NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707144754; c=relaxed/simple;
	bh=fjMQKYSrzUd6ahmVPMrjRavcut9sSWmunk404/C9SHI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rX6z85dfNOS7QiEJKPUxSiuU59LAV5I7YG7osqqLO36dBsNFObHdNNoWcEsUcYVsU1fcVbwUrFuOu4nCs0n/useFkxUT2l+haDhN4PVZ1gOxhjDUUlvX9V3ZL04vciYNWnYsWGErzVgNiAjZ7Y8eCkTMTqhCOckNRQ98g63L1a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+vxXMg3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB0BC433C7;
	Mon,  5 Feb 2024 14:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707144753;
	bh=fjMQKYSrzUd6ahmVPMrjRavcut9sSWmunk404/C9SHI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d+vxXMg3O535t4GiNIaxACgO2E14a3T8adkMrgdyRWzz/KKlYEAeQuiVJqYKPIrse
	 lci5KB9s948+wRFQSjHQ362v/2nm78HQEMIOD083k+4ETVSUfw1j99rB7DbjC/UrIr
	 hguiNIeqRgfbUIU+mRJ1T6yCr8el+2eEyMy5VIWDSLPisTLlvngX5bJxlxn1MdLsah
	 ugYDzwndbh6b24yN2y4oOVua88cGMclRmEMmho1hKHZ8uP3dbvG47wMklhXe+L8XMR
	 C8ftLKSDavq1QFlyjBzgpTXCfGnOnnxlW7MKJq6PPGV2KPYcwZTrzk4EChO4SLV1bY
	 vsuOGKILww4Qg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1rX0Kk-000SGO-Lx;
	Mon, 05 Feb 2024 14:52:30 +0000
Date: Mon, 05 Feb 2024 14:52:29 +0000
Message-ID: <864jen6k0i.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: James Clark <james.clark@arm.com>
Cc: Oliver Upton <oliver.upton@linux.dev>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	broonie@kernel.org,
	suzuki.poulose@arm.com,
	acme@kernel.org,
	James Morse <james.morse@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas
 <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Rob Herring
 <robh@kernel.org>,
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
	Jing Zhang
 <jingzhangos@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/7] arm64: KVM: Use shared area to pass PMU event state to hypervisor
In-Reply-To: <a7cc7791-c476-fd81-b79d-a151293b8302@arm.com>
References: <20240104162714.1062610-1-james.clark@arm.com>
	<20240104162714.1062610-3-james.clark@arm.com>
	<Zb1mCCi13AJ_YjFZ@linux.dev>
	<8a908ee8-620a-d9c2-734b-5a6402950072@arm.com>
	<ZcDc8-FQo8wKavA4@linux.dev>
	<867cjj6ohz.wl-maz@kernel.org>
	<ZcDg1sP3EYZG-i_3@linux.dev>
	<a7cc7791-c476-fd81-b79d-a151293b8302@arm.com>
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
X-SA-Exim-Rcpt-To: james.clark@arm.com, oliver.upton@linux.dev, coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, broonie@kernel.org, suzuki.poulose@arm.com, acme@kernel.org, james.morse@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, mike.leach@linaro.org, leo.yan@linaro.org, alexander.shishkin@linux.intel.com, anshuman.khandual@arm.com, robh@kernel.org, miguel.luis@oracle.com, jintack.lim@linaro.org, ardb@kernel.org, mark.rutland@arm.com, arnd@arndb.de, vdonnefort@google.com, kristina.martsenko@arm.com, tabba@google.com, joey.gouly@arm.com, akihiko.odaki@daynix.com, jingzhangos@google.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Mon, 05 Feb 2024 14:17:10 +0000,
James Clark <james.clark@arm.com> wrote:
>
> On 05/02/2024 13:21, Oliver Upton wrote:
> > On Mon, Feb 05, 2024 at 01:15:36PM +0000, Marc Zyngier wrote:
> >> On Mon, 05 Feb 2024 13:04:51 +0000,
> >> Oliver Upton <oliver.upton@linux.dev> wrote:
> >>>
> >>> Unless someone has strong opinions about making this work in protected
> >>> mode, I am happy to see tracing support limited to the 'normal' nVHE
> >>> configuration. The protected feature as a whole is just baggage until
> >>> upstream support is completed.
> >>
> >> Limiting tracing to non-protected mode is a must IMO. Allowing tracing
> >> when pKVM is enabled is a sure way to expose secrets that should
> >> stay... secret. The only exception I can think of is when
> >> CONFIG_NVHE_EL2_DEBUG is enabled, at which point all bets are off.
> > 
> > Zero argument there :) I left off the "and PMU" part of what I was
> > saying, because that was a feature that semi-worked in protected mode
> > before VM/VCPU shadowing support landed.
> > 
> 
> In that case I can hide all this behind CONFIG_NVHE_EL2_DEBUG for pKVM.
> This will also have the effect of disabling PMU again for pKVM because I
> moved that into this new shared area.

I'm not sure what you have in mind, but dropping PMU support for
non-protected guests when protected-mode is enabled is not an
acceptable outcome.

Hiding the trace behind a debug option is fine as this is a global
setting that has no userspace impact, but impacting guests isn't.

	M.

-- 
Without deviation from the norm, progress is not possible.

