Return-Path: <linux-kernel+bounces-118162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A297988B54C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18EB41F612F5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4BD83A03;
	Mon, 25 Mar 2024 23:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="L/iX7Pwx"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E79839E8;
	Mon, 25 Mar 2024 23:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711409364; cv=none; b=LG4hwQWCIo4C65QbPjXduP0uoZhpFq2g+8XUgPSIVOOvpA2Efk3QDwii0cV9HJ6Oo/TAcM+UxmID342xtNV21GsgzECwiEXkZpUqivSgpu2gG17sb+jrqjV2uxe5VGXRkAurq9dmLBasnSHZK6p465YjDhp1tjshmS18xZpekQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711409364; c=relaxed/simple;
	bh=M98rbpVkl2XoScqQP+xJyp4zG0Is2tvWXcwgnG9wgLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0PG5dAPnZXz3C+vOst+lDPDdL0dexlgduZHOsARf49M5Wit/5piUoknreMC92flUa0+s7Mjxw6PM6DF91DBgOBE6vrGEYFluH2Xc0KwFTTH6MAiX40ZvtRMDzaOiGcSSzvmojDzTT7KKp8pPQaG1q5VDrC/eNUIa/ci5tq/FWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=L/iX7Pwx; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711409360;
	bh=M98rbpVkl2XoScqQP+xJyp4zG0Is2tvWXcwgnG9wgLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L/iX7PwxH4BVtsydI5/a/eRwIZLpILgdm3XZtBSyBxz8ubHabiZ0AieahIbVNl4zB
	 SqO0X0x+M0KaRXWGG8Wr7XYTLGKwV60pegqqgnyiV1JjQSAwRNSwBIZwtoiZ0cYISy
	 7/tpvy+ZhYIHxNU5CsiLF4h7jgD0Ebxv78QgTN6SwEMRXI9d2ipT/UQapWhwHVlIdr
	 jbIkulzdAWOHugSXcCGtfZXQtmEqUhMe+VgDLLLm34bDAN7WD5dMASHulDfzyKjqFy
	 5HIMQRrl2dJ1t9ZhDV9lwXfyIq5KE8l55AcMol33QG05or9eLjqWelKObtdMsb8JsH
	 gC9ARW+tHZ5Uw==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6794837820A3;
	Mon, 25 Mar 2024 23:29:19 +0000 (UTC)
Date: Mon, 25 Mar 2024 19:29:17 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rafael@kernel.org,
	Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	"open list:THERMAL" <linux-pm@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert "thermal: core: Don't update trip points inside
 the hysteresis range"
Message-ID: <fbef883e-23f8-41b9-852b-c52d18816559@notapiano>
References: <20240325222424.4179635-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240325222424.4179635-1-daniel.lezcano@linaro.org>

On Mon, Mar 25, 2024 at 11:24:24PM +0100, Daniel Lezcano wrote:
> It has been reported the commit cf3986f8c01d3 introduced a regression
> when the temperature is wavering in the hysteresis region. The
> mitigation stops leading to an uncontrolled temperature increase until
> reaching the critical trip point.
> 
> Here what happens:
> 
>  * 'throttle' is when the current temperature is greater than the trip
>    point temperature
>  * 'target' is the mitigation level
>  * 'passive' is positive when there is a mitigation, zero otherwise
>  * these values are computed in the step_wise governor
> 
> Configuration:
> 
>  trip point 1: temp=95°C, hyst=5°C (passive)
>  trip point 2: temp=115°C, hyst=0°C (critical)
>  governor: step_wise
> 
> 1. The temperature crosses the way up the trip point 1 at 95°C
> 
>    - trend=raising
>    - throttle=1, target=1
>    - passive=1
>    - set_trips: low=90°C, high=115°C
> 
> 2. The temperature decreases but stays in the hysteresis region at
>    93°C
> 
>    - trend=dropping
>    - throttle=0, target=0
>    - passive=1
> 
>    Before cf3986f8c01d3
>    - set_trips: low=90°C, high=95°C
> 
>    After cf3986f8c01d3
>    - set_trips: low=90°C, high=115°C
> 
> 3. The temperature increases a bit but stays in the hysteresis region
>    at 94°C (so below the trip point 1 temp 95°C)
> 
>    - trend=raising
>    - throttle=0, target=0
>    - passive=1
> 
>    Before cf3986f8c01d3
>    - set_trips: low=90°C, high=95°C
> 
>    After cf3986f8c01d3
>    - set_trips: low=90°C, high=115°C
> 
> 4. The temperature decreases but stays in the hysteresis region at
>    93°C
> 
>    - trend=dropping
>    - throttle=0, target=THERMAL_NO_TARGET
>    - passive=0
> 
>    Before cf3986f8c01d3
>    - set_trips: low=90°C, high=95°C
> 
>    After cf3986f8c01d3
>    - set_trips: low=90°C, high=115°C
> 
> At this point, the 'passive' value is zero, there is no mitigation,
> the temperature is in the hysteresis region, the next trip point is
> 115°C. As 'passive' is zero, the timer to monitor the thermal zone is
> disabled. Consequently if the temperature continues to increase, no
> mitigation will happen and it will reach the 115°C trip point and
> reboot.
> 
> Before the optimization, the high boundary would have been 95°C, thus
> triggering the mitigation again and rearming the polling timer.
> 
> The optimization make sense but given the current implementation of
> the step_wise governor collaborating via this 'passive' flag with the
> core framework it can not work.
> 
> From a higher perspective it seems like there is a problem between the
> governor which sets a variable to be used by the core framework. That
> sounds akward and it would make much more sense if the core framework
> controls the governor and not the opposite. But as the devil hides in
> the details, there are some subtilities to be addressed before.
> 
> Elaborating those would be out of the scope this changelog. So let's
> stay simple and revert the change first to fixup all broken mobile
> platforms.
> 
> This reverts commit cf3986f8c01d355490d0ac6024391b989a9d1e9d.
> 
> This revert applies on top of v6.9-rc1.
> 
> Fixes: cf3986f8c01d3 ("thermal: core: Don't update trip points inside the hysteresis range")
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reported-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
> Cc: Nícolas F. R. A. Prado <nfraprado@collabora.com>

As mentioned in the commit, the issue is elsewhere, but given the original
commit was an optimization to prevent unnecessary trip point updates, and that
it seems to have caused a regression, sounds reasonable to revert at least while
a proper fix isn't found.

Acked-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Only thing is you might want to add a cc: stable tag to guarantee it is
backported (AFAIR Fixes: doesn't guarantee backport), even more so given there
are conflicts.

Thanks,
Nícolas

