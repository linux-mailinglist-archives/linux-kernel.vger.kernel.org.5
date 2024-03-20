Return-Path: <linux-kernel+bounces-109089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B95DE881480
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5FDF1C219E8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07F153E2C;
	Wed, 20 Mar 2024 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="aEEEM0p7"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B8F53E12;
	Wed, 20 Mar 2024 15:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710948362; cv=none; b=BTZfgIcUZwoy9YJ8T5A56tj5YS2adKrhHAxJzOUrq2ldtt5rs1Z1rdN3Th8ZoCDNxEYa8RD6+45H4IZVVDv6/KBO29kQUTjo6RCGztHU+Wdh4u5u0lJfLxui47YEORznjd44XyncOAWofgu6qs+7P1APOksbfYqP1arflu1Lx4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710948362; c=relaxed/simple;
	bh=zR+ah/AZybH8jZSLZxrEDknNvOMLtHTgIU4u4ltErhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nid56izkehyOkBKHVyGdGQdse8boxtpmm+REBOzJN6nLYH+9IoTsWujaTzYJI4Wwh9mmqprZjuipNsGa18q3zH/Yt/xvg6MURuJVcT4r7H+j3QMlgviOqfrqqeUN38jrcYSrul+FAP87n1oS9jL4FrdYqs0tT1FE4+WdQgnStxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=aEEEM0p7; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=/EpaCQTpGqGU5ULt8qAmE+s8SSReKSogNzvd/au7Mjs=;
	t=1710948359; x=1711380359; b=aEEEM0p7s17EwmLjSOM6aJGjCpI3t4WfBnkIqt0HSK1doXv
	FJdYNQgIkX3PfQQhw5p/zKZet62Vejar9cEv8dfDfHDaZpkWW0MwFgG2nyuq25KqcgdUq1v0jp8pu
	9SZ2sAH7N63C/Jy67R2y1PNev3BZjK2nniABPOlbypWZg935cspcVqjGytErp2b9BdkMlB+TR62Z7
	dWAR/Rdm8z61S7p+UPs6TxwaeI2wjtpIEPxd9A1Id2HSkb1f7lmptlp1HiYLqvPwFhq66U0NGLvR4
	mIJGa4HUTVXCW44ZMXzM7Dlxa3dvZRrxi64zEE131NtEg2Obh018gjTuWSWQ70dw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rmxp7-0004iK-29; Wed, 20 Mar 2024 16:25:49 +0100
Message-ID: <db4c8e74-5c79-49be-9781-a5d8669eccc1@leemhuis.info>
Date: Wed, 20 Mar 2024 16:25:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/qxl: fixes qxl_fence_wait
Content-Language: en-US, de-DE
To: Alex Constantino <dreaming.about.electric.sheep@gmail.com>
Cc: 1054514@bugs.debian.org, airlied@redhat.com, carnil@debian.org,
 daniel@ffwll.ch, dri-devel@lists.freedesktop.org, kraxel@redhat.com,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
 spice-devel@lists.freedesktop.org, timo.lindfors@iki.fi,
 tzimmermann@suse.de, virtualization@lists.linux-foundation.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>
References: <fb0fda6a-3750-4e1b-893f-97a3e402b9af@leemhuis.info>
 <20240308010851.17104-1-dreaming.about.electric.sheep@gmail.com>
 <20240308010851.17104-2-dreaming.about.electric.sheep@gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20240308010851.17104-2-dreaming.about.electric.sheep@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1710948359;70f82cbe;
X-HE-SMSGID: 1rmxp7-0004iK-29

On 08.03.24 02:08, Alex Constantino wrote:
> Fix OOM scenario by doing multiple notifications to the OOM handler through
> a busy wait logic.
> Changes from commit 5a838e5d5825 ("drm/qxl: simplify qxl_fence_wait") would
> result in a '[TTM] Buffer eviction failed' exception whenever it reached a
> timeout.
> 
> Fixes: 5a838e5d5825 ("drm/qxl: simplify qxl_fence_wait")
> Link: https://lore.kernel.org/regressions/fb0fda6a-3750-4e1b-893f-97a3e402b9af@leemhuis.info
> Reported-by: Timo Lindfors <timo.lindfors@iki.fi>
> Closes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1054514
> Signed-off-by: Alex Constantino <dreaming.about.electric.sheep@gmail.com>
> ---
>  drivers/gpu/drm/qxl/qxl_release.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)

Hey Dave and Gerd as well as Thomas, Maarten and Maxime (the latter two
I just added to the CC), it seems to me this regression fix did not
maybe any progress since it was posted. Did I miss something, is it just
"we are busy with the merge window", or is there some other a reason?
Just wondering, I just saw someone on a Fedora IRC channel complaining
about the regression, that's why I'm asking. Would be really good to
finally get this resolved...

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

> diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
> index 368d26da0d6a..51c22e7f9647 100644
> --- a/drivers/gpu/drm/qxl/qxl_release.c
> +++ b/drivers/gpu/drm/qxl/qxl_release.c
> @@ -20,8 +20,6 @@
>   * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
>   */
>  
> -#include <linux/delay.h>
> -
>  #include <trace/events/dma_fence.h>
>  
>  #include "qxl_drv.h"
> @@ -59,14 +57,24 @@ static long qxl_fence_wait(struct dma_fence *fence, bool intr,
>  {
>  	struct qxl_device *qdev;
>  	unsigned long cur, end = jiffies + timeout;
> +	signed long iterations = 1;
> +	signed long timeout_fraction = timeout;
>  
>  	qdev = container_of(fence->lock, struct qxl_device, release_lock);
>  
> -	if (!wait_event_timeout(qdev->release_event,
> +	// using HZ as a factor since it is used in ttm_bo_wait_ctx too
> +	if (timeout_fraction > HZ) {
> +		iterations = timeout_fraction / HZ;
> +		timeout_fraction = HZ;
> +	}
> +	for (int i = 0; i < iterations; i++) {
> +		if (wait_event_timeout(
> +				qdev->release_event,
>  				(dma_fence_is_signaled(fence) ||
> -				 (qxl_io_notify_oom(qdev), 0)),
> -				timeout))
> -		return 0;
> +					(qxl_io_notify_oom(qdev), 0)),
> +				timeout_fraction))
> +			break;
> +	}
>  
>  	cur = jiffies;
>  	if (time_after(cur, end))

