Return-Path: <linux-kernel+bounces-70182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8780885946D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 04:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E73FAB217ED
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 03:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B094A33;
	Sun, 18 Feb 2024 03:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkLmkQJk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3366A1847;
	Sun, 18 Feb 2024 03:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708228205; cv=none; b=sZiWGRKW3olbp78qFEbSLbaeJnlRWxOwzDRrqTQg4b2v+7L8sMzsWYug1ud/N1Hm9l6/BfVbcJNkxO/47wneCebjwQwjhzUzx8ULVPUTYGd9hCUvR8Mmyd+RZ5Q2vQy1naIznzWzL1mxiHrD6ZJDfeZ8+prpXhhqwuKKvEHSHcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708228205; c=relaxed/simple;
	bh=sAZtlOB1+PHDIQry/loBfiOjsBGxCaskSKCvfLtCt5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pol1vf1JnuPp3786sEfVrT5FAtnzTD5g11LJ+wcHT02Rs/XdjwdLRJpStENo6vouy6njLZHdJyBowsWpt9c4+RSjJ+I/gJ0WodHDs3EY8LzihL/jn7JYRIvfwWDUYoqs2FVRsbrvOseXv21EffKe8v0VspmAjt6xrpYWdszZDqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkLmkQJk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76897C433C7;
	Sun, 18 Feb 2024 03:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708228204;
	bh=sAZtlOB1+PHDIQry/loBfiOjsBGxCaskSKCvfLtCt5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fkLmkQJkOStOgUabU3CYZ5eG3SXDjWAV7/EwZHEnsEA+jOD0PaLd4RmN98Qv+dGhG
	 bUskwkWxDO0fZYOX8/tnEPcdN7hY83iSBZLwa4FUVgVc25EFtKNjm+PiJWz2o30BYE
	 SIzXHGzhIPza4rvWtp8bWVLVZ3sHGPIthTIg9C/Mas6s4je1vmqaQinDfJbmArQD/Y
	 T4D9axVs+OQIwcAKuWvz0/zR15PkcbNPK6WVJLtgN2TVgl6PnREZl/EC4BvouoMqkD
	 EOPiAmKOmFWZ6AVyHvy0LYOOUDwQWYEx7Bt6NvtoHlFXXhgBR787hSK/yBcHo/gYhi
	 aHENBUJB+P+og==
Date: Sat, 17 Feb 2024 21:50:01 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Gross <agross@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Elliot Berman <quic_eberman@quicinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Guru Das Srinagesh <quic_gurus@quicinc.com>, 
	Andrew Halaney <ahalaney@redhat.com>, Maximilian Luz <luzmaximilian@gmail.com>, 
	Alex Elder <elder@linaro.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@quicinc.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Deepti Jaggi <quic_djaggi@quicinc.com>
Subject: Re: [PATCH v7 11/12] firmware: qcom: scm: clarify the comment in
 qcom_scm_pas_init_image()
Message-ID: <ihz4jczbhn3gdcs6nkgnzpyv3577ebd73qbkynw6jz7ciy4fu3@kxqu7olrrely>
References: <20240205182810.58382-1-brgl@bgdev.pl>
 <20240205182810.58382-12-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205182810.58382-12-brgl@bgdev.pl>

On Mon, Feb 05, 2024 at 07:28:09PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The "memory protection" mechanism mentioned in the comment is the SHM
> Bridge. This is also the reason why we do not convert this call to using
> the TZ memory allocator.
> 

No, this mechanism predates shmbridge.

> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
> Tested-by: Deepti Jaggi <quic_djaggi@quicinc.com> #sa8775p-ride
> Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  drivers/firmware/qcom/qcom_scm.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 839773270a21..7ba5cff6e4e7 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -563,9 +563,13 @@ int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
>  	struct qcom_scm_res res;
>  
>  	/*
> -	 * During the scm call memory protection will be enabled for the meta
> -	 * data blob, so make sure it's physically contiguous, 4K aligned and
> -	 * non-cachable to avoid XPU violations.

What this is saying is that the memory will be made unaccessible to
Linux, so it needs to be contiguous and aligned.

> +	 * During the SCM call the hypervisor will make the buffer containing
> +	 * the program data into an SHM Bridge.

Are you saying that the hypervisor will convert this memory to a
shmbridge, and then pass it to TrustZone?

> This is why we exceptionally
> +	 * must not use the TrustZone memory allocator here as - depending on
> +	 * Kconfig - it may already use the SHM Bridge mechanism internally.
> +	 *

"it may already"? You describe above that we shouldn't pass shmbridge
memory, and the other case never deals with shmbridges. So, I think you
can omit this part.

> +	 * If we pass a buffer that is already part of an SHM Bridge to this
> +	 * call, it will fail.

Could this be because the consumer of this buffer operates in EL2, and
not TZ?

Regards,
Bjorn

>  	 */
>  	mdata_buf = dma_alloc_coherent(__scm->dev, size, &mdata_phys,
>  				       GFP_KERNEL);
> -- 
> 2.40.1
> 

