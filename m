Return-Path: <linux-kernel+bounces-120672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8553C88DB4E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91FA71C276F6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C6537710;
	Wed, 27 Mar 2024 10:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MljacT9E"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1684125DB;
	Wed, 27 Mar 2024 10:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711535691; cv=none; b=MVE+h8n67dxBT5YPeyV5zmm9RTTEB5aPji2igsTRU2ayJ8JBg3ZEyAkIgCxf5yHsHoL7nT0/oJdqrivM6WT0dCLjeg2wANuen5ElAseghryKsyXhXlwdDILUYibjh5FC96t7NxlVW1zhKaCYnJhiiko7trDW5N7EpwjpUV3g9F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711535691; c=relaxed/simple;
	bh=4jje5NEtLbfC42GRy88kRZdlH+ujdSL7a1ZYybJ+xVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0EZmSy9x2gHaTsKZv5e3bWQA/V1B/eQzkfuNYeqD/tj49+bZ3fgQbdh4I8LfPVk44NIDmiQC4VhYABVbqChw+wfMVaSCAik4uYfB8Ng+TEOmJ88XmwzMNT6fHxL5h3i7hVTqklRHoZOa9qEx7f6xQ471hAM9puaPKSPOhSLcsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MljacT9E; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711535688;
	bh=4jje5NEtLbfC42GRy88kRZdlH+ujdSL7a1ZYybJ+xVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MljacT9E0tWaqvup30MvFhY8+rt5/zDUTgxDEpHJjq2yArIDDq42p01ILR09Jt3PG
	 LIwQ1/DsOMRwUA30cOGJ9zlcUoYp9OTZPNLHkwwtQe4LCPOX0iiCubQUoKngX9zCXt
	 Zcsnw2yQU2ZnpsR7Ln99G5lqVzVwRZMG1Iu796lxRsxzoZ4FXQwQ9CekIRsu5jaQ+G
	 H1vpyQm0w+H2Mr29YFKNczMJR8HJRQ2S+TTw4NucovOGQrs4LCC/RHPj/w+cDBFi4v
	 JtgFVCJUWXXd+ApZZ7jhbpQEobz1+BFFs5ygHgW0/LnGxD1IftQe/JYkECu36APBc4
	 vQhV1KuLal3tA==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sebastianfricke)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B72BC37820A3;
	Wed, 27 Mar 2024 10:34:47 +0000 (UTC)
Date: Wed, 27 Mar 2024 11:34:46 +0100
From: Sebastian Fricke <sebastian.fricke@collabora.com>
To: coolrrsh@gmail.com
Cc: slongerbeam@gmail.com, p.zabel@pengutronix.de, mchehab@kernel.org,
	gregkh@linuxfoundation.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-imx@nxp.com, linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v3] staging: media: remove duplicate line
Message-ID: <20240327103446.45lw5zjghwwcu27h@basti-XPS-13-9310>
References: <20240327023340.3710-1-coolrrsh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20240327023340.3710-1-coolrrsh@gmail.com>

Hey Rajeshwar,

On 27.03.2024 08:03, coolrrsh@gmail.com wrote:
>From: Rajeshwar R Shinde <coolrrsh@gmail.com>
>
>The kernel configuration VIDEO_DEV is defined twice in Kconfig.
>Thus, the redundant code is removed.
>
>Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>
>
>---
>v1->v2
>changed the commit message
>v2->v3
>changed the subject

The subject line isn't any better than before. Lets look at some
accepted examples together:

24d9cb143013 media: staging: imx: controls are from another device, mark this
67673ed55084 media: staging/imx: rearrange group id to take in account IPU
483fe862488f9 staging: media: imx: Merge VIDEO_IMX_CSI into VIDEO_IMX_MEDIA
9958d30f38b96 media: Kconfig: cleanup VIDEO_DEV dependencies

How did I find these? Simply by running git blame on one or more of the
files in the driver at drivers/staging/media/imx

As you can see there are slight variations on the first three but the
general theme is the same, the subject line describes to you that the
driver is found in staging/media and it tells you that the folder of the
driver is 'imx'. Generally, `staging: media: imx` would be preferred
however.
The 4th case shows you an example with a more general subject line and
it is justified in this case as the patch does changes on multiple files
on the whole subsystem (the media subsystem consists of all files found
in drivers/media, drivers/staging/media, Documentation/admin-guide/media
and a few header files).

Now if we take this into account for your subject line. You only change
a single driver, thus you need staging: media: imx:, and you to make
your subject a bit less ambigious you could call the whole thing:

staging: media: imx: Remove duplicate Kconfig dependency

I hope this helps.

Greetings,
Sebastian

>
>---
> drivers/staging/media/imx/Kconfig | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/drivers/staging/media/imx/Kconfig b/drivers/staging/media/imx/Kconfig
>index 21fd79515042..772f49b1fe52 100644
>--- a/drivers/staging/media/imx/Kconfig
>+++ b/drivers/staging/media/imx/Kconfig
>@@ -4,7 +4,6 @@ config VIDEO_IMX_MEDIA
> 	depends on ARCH_MXC || COMPILE_TEST
> 	depends on HAS_DMA
> 	depends on VIDEO_DEV
>-	depends on VIDEO_DEV
> 	select MEDIA_CONTROLLER
> 	select V4L2_FWNODE
> 	select V4L2_MEM2MEM_DEV
>-- 
>2.25.1
>
>

