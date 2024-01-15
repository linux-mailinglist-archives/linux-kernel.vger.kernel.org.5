Return-Path: <linux-kernel+bounces-26278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECF082DDF8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 874871C2160B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3301804E;
	Mon, 15 Jan 2024 16:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kGSnck9t"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ADD18044;
	Mon, 15 Jan 2024 16:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705337485;
	bh=dHrpPgE6W2ysfX9JA8iUx8Mkh6tRKxdK22Y1noa7ro0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kGSnck9tmLoilegRXCWJuPXXPA/cPaZHme9m2T8BGsfjArqe7tEu9MiN3dwe65OvA
	 hrNPQVTCnxyKdhGedaHe1gUJGPnnUUyNggyzfvALONQ4Qhq+NVnUVIAdUPJxQojl4e
	 MYF7j/1hzcAORVyGVaWvp3wafkkiQJQE8FGlCPOSYEvJyzZqbsvPkFUjEOuNbXxhvB
	 0VEoyPEScPyltKZnUbGPSFoa2AlL2OhtMamRGT37CK7A3shJEs1uNLVneXpAW/2Vbc
	 FGPKK+TxQZkKFrhodxErWHQvK30ldtPAit4N2g5a3WmS+NH4npk19/e+Sf1LiHZ+aP
	 +Gc3IGt+xBJ7g==
Received: from [100.95.196.25] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: koike)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 12F3037813EC;
	Mon, 15 Jan 2024 16:51:20 +0000 (UTC)
Message-ID: <00510feb-bf87-4ca6-acd7-2ca99b4b2707@collabora.com>
Date: Mon, 15 Jan 2024 13:51:20 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/ci: add sc7180-trogdor-kingoftown
Content-Language: en-US
To: Vignesh Raman <vignesh.raman@collabora.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
Cc: airlied@gmail.com, daniel@ffwll.ch, daniels@collabora.com,
 david.heidelberg@collabora.com, guilherme.gallo@collabora.com,
 sergi.blanch.torne@collabora.com, robdclark@gmail.com,
 quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org, sean@poorly.run,
 marijn.suijten@somainline.org, linux-kernel@vger.kernel.org
References: <20240104081435.1936059-1-vignesh.raman@collabora.com>
From: Helen Koike <helen.koike@collabora.com>
In-Reply-To: <20240104081435.1936059-1-vignesh.raman@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/01/2024 05:14, Vignesh Raman wrote:
> Add job that executes the IGT test suite for sc7180-trogdor-kingoftown.
> This commit also updates xfails for sc7180-trogdor-lazor-limozeen.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>

Applied to drm-misc-next.

Thanks
Helen


> ---
> 
> See pipeline: https://gitlab.freedesktop.org/vigneshraman/linux/-/pipelines/1069934
> 
> ---
>   drivers/gpu/drm/ci/build.sh                   |  1 +
>   drivers/gpu/drm/ci/test.yml                   | 25 ++++++++++++----
>   .../gpu/drm/ci/xfails/msm-sc7180-fails.txt    | 30 -------------------
>   .../gpu/drm/ci/xfails/msm-sc7180-flakes.txt   | 17 -----------
>   .../gpu/drm/ci/xfails/msm-sc7180-skips.txt    |  7 -----
>   .../msm-sc7180-trogdor-kingoftown-fails.txt   | 17 +++++++++++
>   ...sm-sc7180-trogdor-lazor-limozeen-fails.txt | 17 +++++++++++
>   7 files changed, 55 insertions(+), 59 deletions(-)
>   delete mode 100644 drivers/gpu/drm/ci/xfails/msm-sc7180-fails.txt
>   delete mode 100644 drivers/gpu/drm/ci/xfails/msm-sc7180-flakes.txt
>   delete mode 100644 drivers/gpu/drm/ci/xfails/msm-sc7180-skips.txt
>   create mode 100644 drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-fails.txt
>   create mode 100644 drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-fails.txt
> 
> diff --git a/drivers/gpu/drm/ci/build.sh b/drivers/gpu/drm/ci/build.sh
> index 97ff43759b91..331a61e0d25a 100644
> --- a/drivers/gpu/drm/ci/build.sh
> +++ b/drivers/gpu/drm/ci/build.sh
> @@ -26,6 +26,7 @@ if [[ "$KERNEL_ARCH" = "arm64" ]]; then
>       DEVICE_TREES+=" arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper-sku16.dtb"
>       DEVICE_TREES+=" arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dtb"
>       DEVICE_TREES+=" arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r5.dtb"
> +    DEVICE_TREES+=" arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dtb"
>   elif [[ "$KERNEL_ARCH" = "arm" ]]; then
>       GCC_ARCH="arm-linux-gnueabihf"
>       DEBIAN_ARCH="armhf"
> diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
> index a079f3632a95..0c7920c0254d 100644
> --- a/drivers/gpu/drm/ci/test.yml
> +++ b/drivers/gpu/drm/ci/test.yml
> @@ -82,20 +82,35 @@
>     tags:
>       - $RUNNER_TAG
>   
> -msm:sc7180:
> +.msm-sc7180:
>     extends:
>       - .lava-igt:arm64
>     stage: msm
> -  parallel: 4
>     variables:
>       DRIVER_NAME: msm
> -    DEVICE_TYPE: sc7180-trogdor-lazor-limozeen
> -    DTB: sc7180-trogdor-lazor-limozeen-nots-r5
>       BOOT_METHOD: depthcharge
>       KERNEL_IMAGE_TYPE: ""
> -    GPU_VERSION: sc7180
> +
> +msm:sc7180-trogdor-lazor-limozeen:
> +  extends:
> +    - .msm-sc7180
> +  parallel: 4
> +  variables:
> +    DEVICE_TYPE: sc7180-trogdor-lazor-limozeen
> +    DTB: sc7180-trogdor-lazor-limozeen-nots-r5
> +    GPU_VERSION: ${DEVICE_TYPE}
>       RUNNER_TAG: mesa-ci-x86-64-lava-sc7180-trogdor-lazor-limozeen
>   
> +msm:sc7180-trogdor-kingoftown:
> +  extends:
> +    - .msm-sc7180
> +  parallel: 6
> +  variables:
> +    DEVICE_TYPE: sc7180-trogdor-kingoftown
> +    DTB: sc7180-trogdor-kingoftown
> +    GPU_VERSION: ${DEVICE_TYPE}
> +    RUNNER_TAG: mesa-ci-x86-64-lava-sc7180-trogdor-kingoftown
> +
>   msm:apq8016:
>     extends:
>       - .baremetal-igt-arm64
> diff --git a/drivers/gpu/drm/ci/xfails/msm-sc7180-fails.txt b/drivers/gpu/drm/ci/xfails/msm-sc7180-fails.txt
> deleted file mode 100644
> index f71166a57731..000000000000
> --- a/drivers/gpu/drm/ci/xfails/msm-sc7180-fails.txt
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -kms_color@ctm-0-25,Fail
> -kms_color@ctm-0-50,Fail
> -kms_color@ctm-0-75,Fail
> -kms_color@ctm-blue-to-red,Fail
> -kms_color@ctm-green-to-red,Fail
> -kms_color@ctm-negative,Fail
> -kms_color@ctm-red-to-blue,Fail
> -kms_color@ctm-signed,Fail
> -kms_cursor_legacy@cursor-vs-flip-toggle,Fail
> -kms_cursor_legacy@cursor-vs-flip-varying-size,Fail
> -kms_cursor_legacy@cursorA-vs-flipA-atomic-transitions,Crash
> -kms_flip@flip-vs-modeset-vs-hang,Fail
> -kms_flip@flip-vs-panning-vs-hang,Fail
> -kms_pipe_crc_basic@compare-crc-sanitycheck-nv12,Fail
> -kms_plane_alpha_blend@alpha-7efc,Fail
> -kms_plane_alpha_blend@coverage-7efc,Fail
> -kms_plane_alpha_blend@coverage-vs-premult-vs-constant,Fail
> -kms_plane_alpha_blend@pipe-A-alpha-7efc,Fail
> -kms_plane_alpha_blend@pipe-A-coverage-7efc,Fail
> -kms_plane_alpha_blend@pipe-A-coverage-vs-premult-vs-constant,Fail
> -kms_plane_alpha_blend@pipe-B-alpha-7efc,Fail
> -kms_plane_alpha_blend@pipe-B-alpha-basic,Fail
> -kms_plane_alpha_blend@pipe-B-alpha-opaque-fb,Fail
> -kms_plane_alpha_blend@pipe-B-constant-alpha-max,Fail
> -kms_plane_alpha_blend@pipe-B-constant-alpha-mid,Fail
> -kms_plane_alpha_blend@pipe-B-coverage-7efc,Fail
> -kms_plane_alpha_blend@pipe-B-coverage-vs-premult-vs-constant,Fail
> -kms_rmfb@close-fd,Fail
> -kms_universal_plane@disable-primary-vs-flip-pipe-b,Fail
> -kms_universal_plane@universal-plane-pipe-B-sanity,Fail
> diff --git a/drivers/gpu/drm/ci/xfails/msm-sc7180-flakes.txt b/drivers/gpu/drm/ci/xfails/msm-sc7180-flakes.txt
> deleted file mode 100644
> index 04730044ed12..000000000000
> --- a/drivers/gpu/drm/ci/xfails/msm-sc7180-flakes.txt
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -kms_color@ctm-0-25
> -kms_color@ctm-0-50
> -kms_color@ctm-0-75
> -kms_color@ctm-blue-to-red
> -kms_color@ctm-green-to-red
> -kms_color@ctm-negative
> -kms_color@ctm-red-to-blue
> -kms_color@ctm-signed
> -kms_flip@flip-vs-modeset-vs-hang
> -kms_flip@flip-vs-panning-vs-hang
> -kms_plane@pixel-format
> -kms_plane@pixel-format-source-clamping
> -kms_plane@plane-position-covered
> -kms_plane@plane-position-hole
> -kms_plane@plane-position-hole-dpms
> -kms_writeback@writeback-fb-id
> -kms_writeback@writeback-invalid-parameters
> diff --git a/drivers/gpu/drm/ci/xfails/msm-sc7180-skips.txt b/drivers/gpu/drm/ci/xfails/msm-sc7180-skips.txt
> deleted file mode 100644
> index e59a2fddfde0..000000000000
> --- a/drivers/gpu/drm/ci/xfails/msm-sc7180-skips.txt
> +++ /dev/null
> @@ -1,7 +0,0 @@
> -# Suspend to RAM seems to be broken on this machine
> -.*suspend.*
> -
> -# Test incorrectly assumes that CTM support implies gamma/degamma
> -# LUT support.  None of the subtests handle the case of only having
> -# CTM support
> -#kms_color.*
> diff --git a/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-fails.txt b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-fails.txt
> new file mode 100644
> index 000000000000..7e4d8744fcc6
> --- /dev/null
> +++ b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-fails.txt
> @@ -0,0 +1,17 @@
> +kms_color@ctm-0-25,Fail
> +kms_color@ctm-0-50,Fail
> +kms_color@ctm-0-75,Fail
> +kms_color@ctm-blue-to-red,Fail
> +kms_color@ctm-green-to-red,Fail
> +kms_color@ctm-negative,Fail
> +kms_color@ctm-red-to-blue,Fail
> +kms_color@ctm-signed,Fail
> +kms_cursor_legacy@cursor-vs-flip-toggle,Fail
> +kms_cursor_legacy@cursor-vs-flip-varying-size,Fail
> +kms_flip@flip-vs-modeset-vs-hang,Fail
> +kms_flip@flip-vs-panning-vs-hang,Fail
> +kms_pipe_crc_basic@compare-crc-sanitycheck-nv12,Fail
> +kms_plane_alpha_blend@alpha-7efc,Fail
> +kms_plane_alpha_blend@coverage-7efc,Fail
> +kms_plane_alpha_blend@coverage-vs-premult-vs-constant,Fail
> +kms_rmfb@close-fd,Fail
> diff --git a/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-fails.txt b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-fails.txt
> new file mode 100644
> index 000000000000..7e4d8744fcc6
> --- /dev/null
> +++ b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-fails.txt
> @@ -0,0 +1,17 @@
> +kms_color@ctm-0-25,Fail
> +kms_color@ctm-0-50,Fail
> +kms_color@ctm-0-75,Fail
> +kms_color@ctm-blue-to-red,Fail
> +kms_color@ctm-green-to-red,Fail
> +kms_color@ctm-negative,Fail
> +kms_color@ctm-red-to-blue,Fail
> +kms_color@ctm-signed,Fail
> +kms_cursor_legacy@cursor-vs-flip-toggle,Fail
> +kms_cursor_legacy@cursor-vs-flip-varying-size,Fail
> +kms_flip@flip-vs-modeset-vs-hang,Fail
> +kms_flip@flip-vs-panning-vs-hang,Fail
> +kms_pipe_crc_basic@compare-crc-sanitycheck-nv12,Fail
> +kms_plane_alpha_blend@alpha-7efc,Fail
> +kms_plane_alpha_blend@coverage-7efc,Fail
> +kms_plane_alpha_blend@coverage-vs-premult-vs-constant,Fail
> +kms_rmfb@close-fd,Fail

