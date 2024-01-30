Return-Path: <linux-kernel+bounces-45310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DECC3842E59
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E5291C22749
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D589762C7;
	Tue, 30 Jan 2024 21:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lm1Gu+Zq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64A76A02A;
	Tue, 30 Jan 2024 21:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706648651; cv=none; b=vCZRelUm7+SzzgPzOMmF61tTcdCMTeVguVt+WUEqyJbIuDvgJ7ko90DKqCjk2Elh3dYj+bz9ILhQ4BdvKbptbXbT2Trc/HLHylK+Wa3GCP3W7VZEq6maPoJ72IUCiY4UaS7DGKr6sxUCXyKCFPpxJ7UjNfEXIpZzWWkfPRP/Ixw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706648651; c=relaxed/simple;
	bh=L7g7Xr6LSWiL/PufA+EKv8CV+udPLfTQfGO5ji9xvhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTMXMc0KHnNbojlgJX0qbGOrORVddPJNsRIkZYJbBnKYQd/Q2pLfX5Ae8N3k7ENJk3oxED2VcOe6C4PDYF65L3yWO7+zoYnug2WLrfGidyfLIzOgJuCKQH1NlUYNXP/TUrs3rAXjy+0AXiGVNM3+ctQ5596YhtErtjGB1vIwOuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lm1Gu+Zq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4DFC433F1;
	Tue, 30 Jan 2024 21:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706648651;
	bh=L7g7Xr6LSWiL/PufA+EKv8CV+udPLfTQfGO5ji9xvhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lm1Gu+Zqb98HKjzLlciqyq1GrY+Q6mevlVV7Robs3PtFrGibOksONsnFlaSnU5iyI
	 TqZRAX120B8ZRlO2EKcpOj/b66OHIMtjYZhY1ngFpvyPTN8xe9Fbuhklliv+ShJR1m
	 X3XM5Xan/rPgqO3h8M/Q6KHTPd8BeORfF2LC4wWvX1U5zqWaZB68MeYJHhJ4HDIax2
	 j6w03tlpUwK+9MqIiZuCU8cSajwEhBa3lhcHVz4YuOUzFrVGnZoWdrBIaEB+no4AR4
	 DScq9sU1vWT8Xp6aNr54wpUBhfMu/1sz/REIwspQ8Fgo8gugizSYkSMxMadrzrHYkb
	 AB++3/d8nyenQ==
Date: Tue, 30 Jan 2024 16:04:10 -0500
From: Sasha Levin <sashal@kernel.org>
To: Armin Wolf <W_Armin@gmx.de>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>, ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.7 15/18] platform/x86: wmi: Remove ACPI
 handlers after WMI devices
Message-ID: <ZblkSguc70hT8puW@sashalap>
References: <20240116001308.212917-1-sashal@kernel.org>
 <20240116001308.212917-15-sashal@kernel.org>
 <0d179914-5912-46ee-9c10-50b9bbcac718@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <0d179914-5912-46ee-9c10-50b9bbcac718@gmx.de>

On Tue, Jan 16, 2024 at 12:53:46PM +0100, Armin Wolf wrote:
>Am 16.01.24 um 01:12 schrieb Sasha Levin:
>
>>From: Armin Wolf <W_Armin@gmx.de>
>>
>>[ Upstream commit 22574e17626391ad969af9a13aaa58a1b37ad384 ]
>>
>>When removing the ACPI notify/address space handlers, the WMI devices
>>are still active and might still depend on ACPI EC access or
>>WMI events.
>>Fix this by removing the ACPI handlers after all WMI devices
>>associated with an ACPI device have been removed.
>
>Hello,
>
>i would advise against including this patch in the next stable kernels.
>
>The WMI ACPI notify handler is still using list_for_each_entry() which is
>not safe when the WMI devices are removed before the ACPI notify handler.
>
>This issue existed inside the WMI code for a long time, but this patch might
>trigger it. Since no users reported any issues regarding ACPI errors during
>WMI removal, i would drop this patch.

Ack, I'll drop it.

-- 
Thanks,
Sasha

