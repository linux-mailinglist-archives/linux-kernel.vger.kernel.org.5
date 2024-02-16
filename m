Return-Path: <linux-kernel+bounces-68944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEA885823B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E1511F232F3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA3812FB34;
	Fri, 16 Feb 2024 16:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="pW2GhKc2"
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA00112FB28;
	Fri, 16 Feb 2024 16:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708100220; cv=none; b=iTru77MpiS/WIw2KL4YChGSAPn8LAWcbVNwbypN8GNjlhyF7Nd5ovG72KRYEKWS0akK5BL+dvwUqv6ja+6Q1Lckwny8i9dwrCES90WMBDZ0Hy66SqlOtUiqiPqa0LHEXHwWJZdp/FLzrZi4Jce7SOhZgBkifpggMKHKfkjGU/F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708100220; c=relaxed/simple;
	bh=liz7hMDTXQKAHx17d3Q2hZCzsVNFEYpzXI9l9StcDXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t9CTvMPyLsVcIl2d7rwD4Ae+I/7eEVfJ32aK3XhBT6zkEkkkYRL4Piw0vMOoXak5XeWcGc2C68p1cVSrtUM6EzGztT4gbhiED2qklybnvfMqBI4J7jKovYbaQXPGLVE1kxghDRR2HZUJK9khAEI0lRhV8Y9a4SHb239bu1Jf/cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=pW2GhKc2; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4Tbxs30dDDz67v9;
	Fri, 16 Feb 2024 17:16:55 +0100 (CET)
Received: from [10.10.15.23] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4Tbxrs6S7bz680p;
	Fri, 16 Feb 2024 17:16:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1708100214;
	bh=2cjalXf5F8CnOcBPgVTsnQNi+U8AlIg/iVflwmW0vJA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=pW2GhKc22vVCAaydbIZNw9ztcDwfgnp+2xubvy/rnIJkIrZtFXDibsLshRcXETge2
	 vuF8SXPO2JQ/MyBGgIG0kXBx1VIAfmqfbOJzyF0GyubAQVPhaxK5DVYaRODZU/6exG
	 KkI40Pnj9S2f5C1Uotdhn0InxAK91r5xczn126MM=
Message-ID: <86dbf602-7c2c-426e-8e7d-b91572357b3b@gaisler.com>
Date: Fri, 16 Feb 2024 17:16:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sparc: Use shared font data
Content-Language: en-US
To: linux@treblig.org, davem@davemloft.net, sam@ravnborg.org,
 benh@kernel.crashing.org, akpm@linux-foundation.org
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 mpe@ellerman.id.au, glaubitz@physik.fu-berlin.de
References: <20230807010914.799713-1-linux@treblig.org>
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20230807010914.799713-1-linux@treblig.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023-08-07 03:09, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> sparc has a 'btext' font used for the console which is almost identical
> to the shared font_sun8x16, so use it rather than duplicating the data.
> 
> They were actually identical until about a decade ago when
>    commit bcfbeecea11c ("drivers: console: font_: Change a glyph from
>                         "broken bar" to "vertical line"")
> 
> which changed the | in the shared font to be a solid
> bar rather than a broken bar.  That's the only difference.
> 
> This was originally spotted by PMD which noticed that PPC does
> the same thing with the same data, and they also share a bunch
> of functions to manipulate the data.
> 
> Tested very lightly with a boot without FS in qemu.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Applied to my for-next branch.

Thanks,
Andreas

