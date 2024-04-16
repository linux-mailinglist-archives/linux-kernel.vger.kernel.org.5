Return-Path: <linux-kernel+bounces-147536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EF88A75EC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C26FD1C21263
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B665844C6E;
	Tue, 16 Apr 2024 20:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="roTQfqVU"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0524206F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 20:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713300645; cv=none; b=TYMK/NOTKz03mTjVRBjFPILCboeHPi0BrUz8R9JbQIQPtdcsXUUw4YB2t4fo/puFmi3Ty7FoIQLi1IVYMmZhiFPbbWj4/T8Nbrbdd5JXCYYs+S/XukmGiQ/8OxlnrMUYNsFTwdM9mjhQzHYqg2B4egTrwywqcVxu44x+KpVE7Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713300645; c=relaxed/simple;
	bh=Eu4WBri0HHywzv0oCMBJUoSvA9v4FLMOJtWWols9lKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ShNjC38wEmoaqjA7PihK28UjuRAT7t3p1nP1u8dlo/YGAXC1/XqvbKqaVDmQ0hEN5549Ets3S7KrC2rlGm0MeNvEmVg6vce2NfOnZQzvacd0zMFd68MYTuy7KduWBfJv1pwj9jMd+y/uWCRK6Bx8Upzb0S/R9HUKxT7v46Qsfh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=roTQfqVU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=RhXtqDFd7WIHabhsTN4jqGn/JvJYZ5YpDM7t08OasS8=; b=roTQfqVUefAdZAe5ZGVryZeafg
	zkuf85bEncankvz72wSrDQnnkILaqY++DVCpVnqsD0GXDPbPqDJuAOgz5lK390CEVwtTdtC9WH75t
	DEkPuiw5bovvjBKRz4Q5jZ/PqjoDVpFaTzfE6AgQ7iakEQ+CNStyIka64LFTH2PblNm3vxTxeXWHW
	12BHXCEHlZu5fZ9kYSDsXKpm8nhLT436m8s+R0OxECCOBA1fP7GbsDCwDfwV852FcfdF++dtTWm6Z
	yv/KUjRdm89DnmSoKOavI4NOlQ7J5gy8LrTr8nYw++RZqm13HQK9+tRti6IKuE5kxlIrv5nNQY/uO
	kHGVZrwg==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwplG-0000000DmEA-2jiB;
	Tue, 16 Apr 2024 20:50:38 +0000
Message-ID: <4c882a69-8609-4b39-a95d-3128027373e1@infradead.org>
Date: Tue, 16 Apr 2024 13:50:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: Fix no_vblank field references in documentation
To: Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20240416-drm-no_vblank-kdoc-link-v1-1-a1d8d1e9ff34@somainline.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240416-drm-no_vblank-kdoc-link-v1-1-a1d8d1e9ff34@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/16/24 12:29 PM, Marijn Suijten wrote:
> Browsing the DRM documentation shows that drm_crtc_state.no_vblank
> is not turned into a reference to the no_vblank field, but rather a
> reference to `struct drm_crtc_state`.  The only difference with other
> field references is that the struct name is prefixed by the literal
> `struct` tag, despite also already having a `&` reference prefix in two
> of the three cases.  Remove the `struct` prefix to turn these references
> into proper links to the designated field.
> 
> Fixes: 7beb691f1e6f ("drm: Initialize struct drm_crtc_state.no_vblank from device settings")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
> Note that a simple regex like "&struct \w+\.\w+" shows that there are
> only a handful of violators, most of them inside DRM files.  Let me know
> if you'd like a v2 that addresses all of them in one go (in separate
> patches or one combined change)?
> 
> Kind regards,
> Marijn
> ---
>  drivers/gpu/drm/drm_vblank.c        | 2 +-
>  include/drm/drm_crtc.h              | 2 +-
>  include/drm/drm_simple_kms_helper.h | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index 702a12bc93bd..45504732f98e 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -140,7 +140,7 @@
>   * must not call drm_vblank_init(). For such drivers, atomic helpers will
>   * automatically generate fake vblank events as part of the display update.
>   * This functionality also can be controlled by the driver by enabling and
> - * disabling struct drm_crtc_state.no_vblank.
> + * disabling &drm_crtc_state.no_vblank.
>   */
>  
>  /* Retry timestamp calculation up to 3 times to satisfy
> diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
> index 8b48a1974da3..eb75d0aec170 100644
> --- a/include/drm/drm_crtc.h
> +++ b/include/drm/drm_crtc.h
> @@ -342,7 +342,7 @@ struct drm_crtc_state {
>  	 *    that case.
>  	 *
>  	 * For very simple hardware without VBLANK interrupt, enabling
> -	 * &struct drm_crtc_state.no_vblank makes DRM's atomic commit helpers
> +	 * &drm_crtc_state.no_vblank makes DRM's atomic commit helpers
>  	 * send a fake VBLANK event at the end of the display update after all
>  	 * hardware changes have been applied. See
>  	 * drm_atomic_helper_fake_vblank().
> diff --git a/include/drm/drm_simple_kms_helper.h b/include/drm/drm_simple_kms_helper.h
> index b2486d073763..6e64d91819e7 100644
> --- a/include/drm/drm_simple_kms_helper.h
> +++ b/include/drm/drm_simple_kms_helper.h
> @@ -102,7 +102,7 @@ struct drm_simple_display_pipe_funcs {
>  	 * drm_crtc_arm_vblank_event(), when the driver supports vblank
>  	 * interrupt handling, or drm_crtc_send_vblank_event() for more
>  	 * complex case. In case the hardware lacks vblank support entirely,
> -	 * drivers can set &struct drm_crtc_state.no_vblank in
> +	 * drivers can set &drm_crtc_state.no_vblank in
>  	 * &struct drm_simple_display_pipe_funcs.check and let DRM's
>  	 * atomic helper fake a vblank event.
>  	 */
> 
> ---
> base-commit: 6bd343537461b57f3efe5dfc5fc193a232dfef1e
> change-id: 20240416-drm-no_vblank-kdoc-link-fea1b53008a3

Do you see differences in the generated html for these changes?

"&struct somestruct" and "&somestruct" should both be OK AFAIK, although
Documentation/doc-guide/kernel-doc.rst seems to say that using
"&struct somestruct" is preferred.

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

