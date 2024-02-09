Return-Path: <linux-kernel+bounces-59585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B27284F959
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A87C7284410
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FA07AE73;
	Fri,  9 Feb 2024 16:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uP9XrTny"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502CD76905
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707494952; cv=none; b=JunsvH1zTiPXSL5f6WQiBYo8uoDWUvp/71dgrsW9+X8dPnde4uHaF7Zq2kQ8qvGqGy8xAk/KAaXL2TLaUrGATnvLMCZGOka4BSaiaQAmY6XoLya83icKPlUvQqBdEN9vnh52EN36P7lm+xrlGOZTCO7fccyWZplwVhwiLcP1he4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707494952; c=relaxed/simple;
	bh=IIeM8mUDJ3PXlV91DXOkNDk6nOrCsTSkdnpyBI3x1Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmSDh7P5KJOOaB9PO/aMOrOx9Hz7mA7OWT7509u6aX4TXmyz6c5+lmNxgZNDYmxsdtnbD6hNEguaG+ZDeSLHpbfb01Mcftu8iYHYUmaBVpPbzeI3xSoIoSpG86t38oh9J1J/JOPaOKUpKRQuARIsPSouvSCL0d1ebGnD/seWzOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uP9XrTny; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606B3C43394;
	Fri,  9 Feb 2024 16:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707494950;
	bh=IIeM8mUDJ3PXlV91DXOkNDk6nOrCsTSkdnpyBI3x1Wk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uP9XrTnyr9qUDII1Mg3xLEN2Oj5dAMy7n5EQjxWepL0lf7fp7+cflG4Lr5+OTLBHX
	 j7m3sd6nVmHFx2gTbgvllQfhXDKkpmMENr2gHzNj1mLWwlpRIDVG7CfnUbnlxllgkF
	 2Z3P/oe0gAKOh4usYMxJPXmLNspwMTxaxIP/aCHV7e6cGRLgL+hhvY8St+tnWOnO8C
	 /I9Xe8QfELQKiz9c8xpBfqNEWPRK+n3J5D7+eJkMfHwDhxZC9hrB28mlHTThzr+j7i
	 iZZp/fDrKW/Ov44NOi6dv7xRKlGPBb3t8fIVwbrBPN73PVgORrT0tkvsw55sWghEhL
	 O7ftIXFjyq/0g==
Date: Fri, 9 Feb 2024 16:09:06 +0000
From: Will Deacon <will@kernel.org>
To: "JiaLong.Yang" <jialong.yang@shingroup.cn>
Cc: Mark Rutland <mark.rutland@arm.com>, shenghui.qu@shingroup.cn,
	ke.zhao@shingroup.cn, zhijie.ren@shingroup.cn,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/arm_smmuv3: Omit the two judgements which done in
 framework
Message-ID: <20240209160905.GA24565@willie-the-truck>
References: <20231221093802.20612-1-jialong.yang@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221093802.20612-1-jialong.yang@shingroup.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Dec 21, 2023 at 05:38:01PM +0800, JiaLong.Yang wrote:
> 'event->attr.type != event->pmu->type' has been done in
> core.c::perf_init_event() ,core.c::perf_event_modify_attr(), etc.
>
> This PMU is an uncore one. The core framework has disallowed
> uncore-task events. So the judgement to event->cpu < 0 is no mean.

It would be great to refer to the changes which added those checks to
the perf core code. From reading the code myself, I can't convince myself
that perf_try_init_event() won't call into the driver.

> 
> The two judgements have been done in kernel/events/core.c
> 
> Signed-off-by: JiaLong.Yang <jialong.yang@shingroup.cn>
> ---
>  drivers/perf/arm_smmuv3_pmu.c | 8 --------
>  1 file changed, 8 deletions(-)

It looks like _many_ perf drivers have these checks, so if they really
aren't needed, we can clean this up bveyond SMMU. However, as I said
above, I'm not quite convinced we can drop them.

Will

