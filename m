Return-Path: <linux-kernel+bounces-80224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF985862C44
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 18:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3A4B1C20AD2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 17:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEBE1862E;
	Sun, 25 Feb 2024 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpiRkISU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88FC17BB5
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 17:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708881805; cv=none; b=Y9lkdMsAZd089hzDV2y5pqTyrhikbNVn2PzIBtmc2IjigaZybXNDE+2CLJ4MgjjGOsH1Eb6vwKxzu5RLE4OVJlpBmnkpZU0Jk1XgHBkbAt1gmckWVw3IAboNEpn5flK6hdLJ3DihJJvUtnjUU5tOCwJxwi3j8mjIfMh1CPsLEaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708881805; c=relaxed/simple;
	bh=n31uvN3EKuNhBVZlFx/PskpErcQNgwBocvUs9RbSYdg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=A51p/E7sYUfND6YjoNRA0seAsHny5PICGA9NhyOINGkuHI8TEu0dS9M49LfXOgRMZKh220XZ+Y+CLFJCeWK+odgH2q3V6PzmvSvnZH6Eg5bR8T0v7D3eo4a+wd6hNJ2y5pIIHwEOaN6I6y7MPHF0N3ssRMXI98Sb4VSEA5S3em4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpiRkISU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2636DC433F1;
	Sun, 25 Feb 2024 17:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708881805;
	bh=n31uvN3EKuNhBVZlFx/PskpErcQNgwBocvUs9RbSYdg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RpiRkISUdj3iEqSwXNudFslC9mMhLzKP3W5IvtmX5LMpaMQw1DjyadIng4AKgYcFs
	 4UFGym95EpeHutT0kLuqNyW5pYQD5JcPCPo/3khiDQLXxY7JRIHMeEb73MjiFX5pts
	 0v8Lue0CzdySt2FXPBQdcEwneVDK52DS0ZyXBjB/e2MJQowDU2oHjqraP4Jj6Io9bI
	 /ZNyrPaH4MtV9aakyCw5z3LTl6dHFt0q5XBjA3zPxIzD6TWJCbIGsiBRjAFa0Mcv9T
	 ov706avBCJE4M4C6ovbQNzE4VwXOKbWFvGU+rbVibG2ZKGzsBDyQHX4gJVpo/YhF9M
	 ztP1wNI5WVTxw==
Received: from disco-boy.misterjones.org ([217.182.43.188] helo=www.loen.fr)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1reIDi-006bWb-PT;
	Sun, 25 Feb 2024 17:23:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 25 Feb 2024 17:23:22 +0000
From: Marc Zyngier <maz@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Biju Das
 <biju.das.jz@bp.renesas.com>, x86@kernel.org
Subject: Re: [PATCH] genirq/irqdomain: Don't call ops->select for
 DOMAIN_BUS_ANY tokens
In-Reply-To: <878r38cy8n.ffs@tglx>
References: <20240220114731.1898534-1-maz@kernel.org> <878r38cy8n.ffs@tglx>
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <6792b2913a47b6ceb5650cdde3deecf2@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 217.182.43.188
X-SA-Exim-Rcpt-To: tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dmitry.baryshkov@linaro.org, biju.das.jz@bp.renesas.com, x86@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On 2024-02-25 16:19, Thomas Gleixner wrote:
> On Tue, Feb 20 2024 at 11:47, Marc Zyngier wrote:
>> Users of the IRQCHIP_PLATFORM_DRIVER_{BEGIN,END} helpers rely
>> on a fwspec containing only the fwnode (and crucially a number
>> of parameters set to 0) together with a DOMAIN_BUS_ANY token
>> to check whether a parent irqchip has probed and registered
>> a domain.
>> 
>> Since de1ff306dcf4 ("genirq/irqdomain: Remove the param count
>> restriction from select()"), we call ops->select unconditionally,
>> meaning that irqchips implementing select now need to handle
>> ANY as a match.
>> 
>> Instead of adding more esoteric checks to the individual drivers,
>> add that condition to irq_find_matching_fwspec(), and let it
>> handle the corner case, as per the comment in the function.
>> 
>> This restores the functionnality of the above helpers.
>> 
>> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Reported-by: Biju Das <biju.das.jz@bp.renesas.com>
>> Fixes: de1ff306dcf4 ("genirq/irqdomain: Remove the param count 
>> restriction from select()")
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> Link: 
>> https://lore.kernel.org/r/20240219-gic-fix-child-domain-v1-1-09f8fd2d9a8f@linaro.org
> 
> Bah. That breaks x86 because it uses DOMAIN_BUS_ANY to find the MSI
> parent for a fwspec (IOAPIC and HPET) which gets either picked up by 
> the
> interrupt remapping or by the root vector domain.
> 
> Fix below.
> 
> Thanks,
> 
>         tglx
> ---
> Subject: x86/apic/msi: Use DOMAIN_BUS_GENERIC_MSI for HPET/IO-APIC 
> domain search
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Sun, 25 Feb 2024 16:56:12 +0100
> 
> The recent restriction to invoke irqdomain_ops::select() only when the
> domain bus toke is DOMAIN_BUS_ANY breaks the search for the parent MSI
> domain of HPET and IO-APIC. The latter causes a full boot fail.
> 
> The restriction itself makes sense to avoid adding DOMAIN_BUS_ANY 
> matches
> into the various ARM specific select() callbacks. Reverting this change
> would obviously break ARM platforms again and require DOMAIN_BUS_ANY
> matches added to various places.
> 
> A simpler solution is to use the DOMAIN_BUS_GENERIC_MSI token for the 
> HPET
> and IO-APIC parent domain search. This works out of the box because the
> affected parent domains check only for the firmware specification 
> content
> and not for the bus token.
> 
> Fixes: 5aa3c0cf5bba ("genirq/irqdomain: Don't call ops->select for
> DOMAIN_BUS_ANY tokens")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Looks good to me.

Reviewed-by: Marc Zyngier <maz@kernel.org>

         M.
-- 
Jazz is not dead. It just smells funny...

