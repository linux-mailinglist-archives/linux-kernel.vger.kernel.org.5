Return-Path: <linux-kernel+bounces-101134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C79987A2E9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 07:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 880301F22243
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 06:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E744513AD8;
	Wed, 13 Mar 2024 06:19:39 +0000 (UTC)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0B68828
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 06:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710310779; cv=none; b=kKPuibuJ52hmjvOXYPgWrMA0bjfK1e7gSsB8d9Y3+Lz3xcDNEpCE/TSm6FhCxzEXUfNOon77XWXcMko49wbZbX6seJyzFJSyZOsTJjQh+lZRU4nrvG6YZUO2Lv0qZ9m+XR+TbuGHgpbATk4WQlmhXnFCzavnfSOcg9roGkx9LNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710310779; c=relaxed/simple;
	bh=sN9cgM5sDQP/8akQIklTPwknhOljGmma1TLCsFS+TUg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=atAcqxb5zf7YRxpja04ZGTlTRIzIrFERhRfLS4EcVnTz2R+4U9uAxtlYh5K3hWN4bMMIPMN/NoOUAv1lXDpoOA7Mune3al2qBdkJQg89LbXo8ccDBQeGyQGLz2XozZWfSTrJt+LbcjRqmN4WPDEKHuZS9gnha45Bjv4CMF50KG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp80t1710310709trkc2gr1
X-QQ-Originating-IP: GLC8Iu67rXhV6eCFYKQmrbl6IkFlciWctK/Tvp2LRJk=
Received: from john-PC ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 13 Mar 2024 14:18:27 +0800 (CST)
X-QQ-SSF: 01400000000000E0L000000A0000000
X-QQ-FEAT: RmDZc/K2LPGX8QM1YeXZshthElQ2uZpSSUsxNZv7fWEpt0RBL4E/tI9skKcKk
	5ZKVyGSJl6s0vhpvrJ0lBNIiqBablTIX6rfDaqRRdX6YMmoXIHmkJyt5dkxecksOnZBvLTS
	BvY8b8+x3uU3l2ZZvXdM41PEGNgsaaYJIbyoSn8GSP+5p9ISHi7kqDiHsnaJ7aVOBgpCTeL
	I75T0mKZGigjLTDDU29Hd1eflwxhYelYIPNV8gy3o3aadoOjBG2MIAeyshmJETwXq8tHCV0
	2Fp/Cz4T88wyf6HnXL0/43kW5pTFj8E6AiLizSKrWJitqyZfUkVGWf9+ZSEVUOEnFU+1tTi
	Yk/Uh1FEKP4ICh+IFZEYZODJxIog/wakp2B9pTWCdpCzfemdPy8z/Q4ZgoHhT06jdcMv7t9
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17432395954863793065
Date: Wed, 13 Mar 2024 14:18:27 +0800
From: Qiang Ma <maqianga@uniontech.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch, srinivasan.shanmugam@amd.com,
 sunran001@208suo.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/amdgpu: Clear the hotplug interrupt ack bit
 before hpd initialization
Message-ID: <A65A2F93D9F165EC+20240313141827.40f30bd5@john-PC>
In-Reply-To: <20240131075703.24600-1-maqianga@uniontech.com>
References: <20240131075703.24600-1-maqianga@uniontech.com>
Organization: UOS
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4a-0

On Wed, 31 Jan 2024 15:57:03 +0800
Qiang Ma <maqianga@uniontech.com> wrote:

Hello everyone, please help review this patch.

  Qiang Ma

> Problem:
> The computer in the bios initialization process, unplug the HDMI
> display, wait until the system up, plug in the HDMI display, did not
> enter the hotplug interrupt function, the display is not bright.
> 
> Fix:
> After the above problem occurs, and the hpd ack interrupt bit is 1,
> the interrupt should be cleared during hpd_init initialization so that
> when the driver is ready, it can respond to the hpd interrupt
> normally.
> 
> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> ---
> v2:
>  - Remove unused variable 'tmp'
>  - Fixed function spelling errors
>  
> drivers/gpu/drm/amd/amdgpu/dce_v10_0.c |  2 ++
>  drivers/gpu/drm/amd/amdgpu/dce_v11_0.c |  2 ++
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c  | 22 ++++++++++++++++++----
>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c  | 22 ++++++++++++++++++----
>  4 files changed, 40 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c index
> bb666cb7522e..12a8ba929a72 100644 ---
> a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c +++
> b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c @@ -51,6 +51,7 @@
>  
>  static void dce_v10_0_set_display_funcs(struct amdgpu_device *adev);
>  static void dce_v10_0_set_irq_funcs(struct amdgpu_device *adev);
> +static void dce_v10_0_hpd_int_ack(struct amdgpu_device *adev, int
> hpd); 
>  static const u32 crtc_offsets[] = {
>  	CRTC0_REGISTER_OFFSET,
> @@ -363,6 +364,7 @@ static void dce_v10_0_hpd_init(struct
> amdgpu_device *adev) AMDGPU_HPD_DISCONNECT_INT_DELAY_IN_MS);
>  		WREG32(mmDC_HPD_TOGGLE_FILT_CNTL +
> hpd_offsets[amdgpu_connector->hpd.hpd], tmp); 
> +		dce_v10_0_hpd_int_ack(adev,
> amdgpu_connector->hpd.hpd); dce_v10_0_hpd_set_polarity(adev,
> amdgpu_connector->hpd.hpd); amdgpu_irq_get(adev, &adev->hpd_irq,
>  			       amdgpu_connector->hpd.hpd);
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c index
> 7af277f61cca..745e4fdffade 100644 ---
> a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c +++
> b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c @@ -51,6 +51,7 @@
>  
>  static void dce_v11_0_set_display_funcs(struct amdgpu_device *adev);
>  static void dce_v11_0_set_irq_funcs(struct amdgpu_device *adev);
> +static void dce_v11_0_hpd_int_ack(struct amdgpu_device *adev, int
> hpd); 
>  static const u32 crtc_offsets[] =
>  {
> @@ -387,6 +388,7 @@ static void dce_v11_0_hpd_init(struct
> amdgpu_device *adev) AMDGPU_HPD_DISCONNECT_INT_DELAY_IN_MS);
>  		WREG32(mmDC_HPD_TOGGLE_FILT_CNTL +
> hpd_offsets[amdgpu_connector->hpd.hpd], tmp); 
> +		dce_v11_0_hpd_int_ack(adev,
> amdgpu_connector->hpd.hpd); dce_v11_0_hpd_set_polarity(adev,
> amdgpu_connector->hpd.hpd); amdgpu_irq_get(adev, &adev->hpd_irq,
> amdgpu_connector->hpd.hpd); }
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c index
> 143efc37a17f..28c4a735716b 100644 ---
> a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c +++
> b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c @@ -272,6 +272,21 @@ static
> void dce_v6_0_hpd_set_polarity(struct amdgpu_device *adev,
> WREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[hpd], tmp); }
>  
> +static void dce_v6_0_hpd_int_ack(struct amdgpu_device *adev,
> +				 int hpd)
> +{
> +	u32 tmp;
> +
> +	if (hpd >= adev->mode_info.num_hpd) {
> +		DRM_DEBUG("invalid hdp %d\n", hpd);
> +		return;
> +	}
> +
> +	tmp = RREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[hpd]);
> +	tmp |= DC_HPD1_INT_CONTROL__DC_HPD1_INT_ACK_MASK;
> +	WREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[hpd], tmp);
> +}
> +
>  /**
>   * dce_v6_0_hpd_init - hpd setup callback.
>   *
> @@ -311,6 +326,7 @@ static void dce_v6_0_hpd_init(struct
> amdgpu_device *adev) continue;
>  		}
>  
> +		dce_v6_0_hpd_int_ack(adev,
> amdgpu_connector->hpd.hpd); dce_v6_0_hpd_set_polarity(adev,
> amdgpu_connector->hpd.hpd); amdgpu_irq_get(adev, &adev->hpd_irq,
> amdgpu_connector->hpd.hpd); }
> @@ -3088,7 +3104,7 @@ static int dce_v6_0_hpd_irq(struct
> amdgpu_device *adev, struct amdgpu_irq_src *source,
>  			    struct amdgpu_iv_entry *entry)
>  {
> -	uint32_t disp_int, mask, tmp;
> +	uint32_t disp_int, mask;
>  	unsigned hpd;
>  
>  	if (entry->src_data[0] >= adev->mode_info.num_hpd) {
> @@ -3101,9 +3117,7 @@ static int dce_v6_0_hpd_irq(struct
> amdgpu_device *adev, mask = interrupt_status_offsets[hpd].hpd;
>  
>  	if (disp_int & mask) {
> -		tmp = RREG32(mmDC_HPD1_INT_CONTROL +
> hpd_offsets[hpd]);
> -		tmp |= DC_HPD1_INT_CONTROL__DC_HPD1_INT_ACK_MASK;
> -		WREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[hpd],
> tmp);
> +		dce_v6_0_hpd_int_ack(adev, hpd);
>  		schedule_delayed_work(&adev->hotplug_work, 0);
>  		DRM_DEBUG("IH: HPD%d\n", hpd + 1);
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c index
> adeddfb7ff12..8ff2b5adfd95 100644 ---
> a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c +++
> b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c @@ -264,6 +264,21 @@ static
> void dce_v8_0_hpd_set_polarity(struct amdgpu_device *adev,
> WREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[hpd], tmp); }
>  
> +static void dce_v8_0_hpd_int_ack(struct amdgpu_device *adev,
> +				 int hpd)
> +{
> +	u32 tmp;
> +
> +	if (hpd >= adev->mode_info.num_hpd) {
> +		DRM_DEBUG("invalid hdp %d\n", hpd);
> +		return;
> +	}
> +
> +	tmp = RREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[hpd]);
> +	tmp |= DC_HPD1_INT_CONTROL__DC_HPD1_INT_ACK_MASK;
> +	WREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[hpd], tmp);
> +}
> +
>  /**
>   * dce_v8_0_hpd_init - hpd setup callback.
>   *
> @@ -303,6 +318,7 @@ static void dce_v8_0_hpd_init(struct
> amdgpu_device *adev) continue;
>  		}
>  
> +		dce_v8_0_hpd_int_ack(adev,
> amdgpu_connector->hpd.hpd); dce_v8_0_hpd_set_polarity(adev,
> amdgpu_connector->hpd.hpd); amdgpu_irq_get(adev, &adev->hpd_irq,
> amdgpu_connector->hpd.hpd); }
> @@ -3176,7 +3192,7 @@ static int dce_v8_0_hpd_irq(struct
> amdgpu_device *adev, struct amdgpu_irq_src *source,
>  			    struct amdgpu_iv_entry *entry)
>  {
> -	uint32_t disp_int, mask, tmp;
> +	uint32_t disp_int, mask;
>  	unsigned hpd;
>  
>  	if (entry->src_data[0] >= adev->mode_info.num_hpd) {
> @@ -3189,9 +3205,7 @@ static int dce_v8_0_hpd_irq(struct
> amdgpu_device *adev, mask = interrupt_status_offsets[hpd].hpd;
>  
>  	if (disp_int & mask) {
> -		tmp = RREG32(mmDC_HPD1_INT_CONTROL +
> hpd_offsets[hpd]);
> -		tmp |= DC_HPD1_INT_CONTROL__DC_HPD1_INT_ACK_MASK;
> -		WREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[hpd],
> tmp);
> +		dce_v8_0_hpd_int_ack(adev, hpd);
>  		schedule_delayed_work(&adev->hotplug_work, 0);
>  		DRM_DEBUG("IH: HPD%d\n", hpd + 1);
>  	}


