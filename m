Return-Path: <linux-kernel+bounces-166045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1BE8B952D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C88B61F21EDF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E4E819;
	Thu,  2 May 2024 07:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGcbvCrQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2301CD31;
	Thu,  2 May 2024 07:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714634494; cv=none; b=Jkbi99AVOVotwta+DSMxHeKPV9Q3nU4sFMO7ccXZBaSXgg+JaiqEn659kGLBrHgroPtBKmuqxHl7xS2wkmtp4GO0XgCtFfGMzCXRfm/Z3OVdwHRJ+QDaY7Q4NjRBI7JoXp9gYhvU7wnP9uMd9UIhrSUtnIV09+bB/gqv0Ij7YpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714634494; c=relaxed/simple;
	bh=tX69CvEtAwgo4XZ4l/Uep5L3565GREJ/19F+uS2/KpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOiWKRUsUS499Qo14p7RFZv+xHyHf+ooO+c8ruo6jmPbznLzLWLol6/DXsiDW12qDedOfYoaKV1aQUtO9TqjJVMQZ8GwokKcnuI/uREfj1IxIEMtsje3eFitKfvo3gmlPrCUO+r1EDBHUCEeMeJevrXKV7SBYSRtlHpXbu5wysQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGcbvCrQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD48C113CC;
	Thu,  2 May 2024 07:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714634493;
	bh=tX69CvEtAwgo4XZ4l/Uep5L3565GREJ/19F+uS2/KpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MGcbvCrQDirSeDnPM0TpNimb91ucNM+8g3bD+PgHyc9ntVB+g2zov+7PyIdYgkvsU
	 jtz4hactVTRvJISbUNUhpKLI+BBX6iqpPrUpbDLCcpvjR7DDeFB0R05Ou0BZh5TP83
	 zhNKgRAdqM3mz/ke21ppHndeEXLoUBxjXf3wJ0WzpkBfzGYq25aX6HVu2Dx5RVmTyI
	 20/F1/pZ70UB763380hHv6L+yrovyv0fDZcNO0MbOeSBT8MK4gpXlYosj28jQEEjsd
	 i8xKnp6Z1NSnVOYsRSYFSbcVk4KpQIdp2hl3cYk4nUdwg5CfvMIUB1wnDtVletoO01
	 /tNAKvXRfu0xQ==
Date: Thu, 2 May 2024 08:21:26 +0100
From: Lee Jones <lee@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Alexander Shiyan <shc_work@mail.ru>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-omap@vger.kernel.org,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH v2 19/19] const_structs.checkpatch: add lcd_ops
Message-ID: <20240502072126.GC5338@google.com>
References: <20240424-video-backlight-lcd-ops-v2-0-1aaa82b07bc6@kernel.org>
 <20240424-video-backlight-lcd-ops-v2-19-1aaa82b07bc6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240424-video-backlight-lcd-ops-v2-19-1aaa82b07bc6@kernel.org>

On Wed, 24 Apr 2024, Krzysztof Kozlowski wrote:

> 'struct lcd_ops' is not modified by core code.
> 
> Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Patch making lcd_ops const in progress:
> https://lore.kernel.org/r/20240414-video-backlight-lcd-ops-v1-0-9b37fcbf546a@kernel.org
> 
> Cc: Lee Jones <lee@kernel.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  scripts/const_structs.checkpatch | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/const_structs.checkpatch b/scripts/const_structs.checkpatch
> index fa96cfd16e99..52e5bfb61fd0 100644
> --- a/scripts/const_structs.checkpatch
> +++ b/scripts/const_structs.checkpatch
> @@ -39,6 +39,7 @@ kgdb_arch
>  kgdb_io
>  kobj_type
>  kset_uevent_ops
> +lcd_ops

Acked-by: Lee Jones <lee@kernel.org>

>  lock_manager_operations
>  machine_desc
>  microcode_ops

-- 
Lee Jones [李琼斯]

