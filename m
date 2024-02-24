Return-Path: <linux-kernel+bounces-79736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C3A8625F7
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 17:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D02A1B218C7
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 16:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE633E493;
	Sat, 24 Feb 2024 16:12:39 +0000 (UTC)
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BB147A6C;
	Sat, 24 Feb 2024 16:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708791159; cv=none; b=cE10vyVg2g3JOyR3+l7VTA1OMjnVbWgnB/5Rn65ywLTkZJqerE7UxaH6vLjm8sE4X7MPyKntgYO6PwEP2amizquVupsPSJExVqKqN51CApEXFkk7tEGGB5iQ89kFX0o9ap1TuppLZoWq3LWxW+dhF0DIcSowamvy43NRUT4bSZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708791159; c=relaxed/simple;
	bh=ipX0egL61XZQJmFm0IoITVXsPrRfywKFWzinkfQKy+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YfJSsEjps69vmtfmlDPdySeGSXIdiy0C0zE+6We3LV67JanD+R1UjnzFNJ8k4ThtSRYcm6TuyZ7OQCoXVqBFSH+oImNGlnZjks8hD0mtMThFIQNOb4SmGqfGYSOQiPy0YYtMP69W1RG8Hjs/3dZtcvJ+4/EQLeBpRBQhr5/zIWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 1F018842CF;
	Sat, 24 Feb 2024 17:02:42 +0100 (CET)
Message-ID: <e4173a45-61ca-4427-85aa-1733406a5f39@skole.hr>
Date: Sat, 24 Feb 2024 17:02:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] leds: expresswire: Don't use "proxy" headers
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
References: <20240223203010.881065-1-andriy.shevchenko@linux.intel.com>
From: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
In-Reply-To: <20240223203010.881065-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/23/2024 9:30 PM, Andy Shevchenko wrote:
> Update header inclusions to follow IWYU (Include What You Use)
> principle.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: added one more missing header
>  drivers/leds/leds-expresswire.c  | 4 ++++
>  include/linux/leds-expresswire.h | 4 +++-
>  2 files changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Duje Mihanović <duje.mihanovic@skole.hr>


