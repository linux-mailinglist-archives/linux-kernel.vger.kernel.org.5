Return-Path: <linux-kernel+bounces-163754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1235C8B6F6B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352FA1C22B71
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EF5129A73;
	Tue, 30 Apr 2024 10:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i3r1fXF2"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C02128828
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 10:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714472242; cv=none; b=CMWvAANczPu2T0acytXXJpAdsClYs6g7gMx3mwIvtqMyzYq3fJXl3wih9bcfljP3ySePnDPfr6ey/Fx4nEreilBU4CW/xczYwRyiY6pLdBzaJRnMaURm3aBHAdLr6KAGD6MprQY93jd5BWJKkmDS1ND0zpr3uZIPtdmOLqrbp4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714472242; c=relaxed/simple;
	bh=AVxBw4jJDmo2mb14BKYuflx3kx2EIDQMDJJh8tHoa7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCheAoQI2iFOwYhi38SCYkNnHR8+Q5FmRPVhpCy5qpjN+2aU61CpUFCIFkbTK0OBMdIgI7JZSsdmdHMilqcJN2I9gpnxs+sLKt52qOifB4U7up3pgyuuqKHgg8VGLtpBh1i1DtliH34tOynCqy1lC6IvjLFqNzcR6CUP7u6O+Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i3r1fXF2; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2dd19c29c41so66794991fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 03:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714472239; x=1715077039; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vLkLH0SSmvOSmWzdY7vcX+RCH3AFTNGOUA3YHRv8hu4=;
        b=i3r1fXF2A8QJprcO7KYD8yCoF+uRw1i+Y4ab3cbOLtGaCXq56nCX1t3pzY0kZLoZkU
         Mv5GPXEJTVLvIdBRfa7Peda2U25RbL7V+ChYju/1UocFwhknztjn2vDJIO14/dFODT0w
         r+R6LmEGQiyZRWzIHrQfPLI60UkLySgH+KKTKPVoaMKPTHuECT5KJ6PUh19G4XHkO+Q+
         TXSnLNIxe6F1rGANcmGBNkhdnAOA1YUaK3tmnXhMCCUdE5q8+U7SDc+jEGfT419uk83Y
         rxqnoB5OUZkd9ns55MnyJfgw+4iSOhgvxr2REAN1Ha3vCjjJP2w+5GbkABtI/P3MdjRa
         5UzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714472239; x=1715077039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLkLH0SSmvOSmWzdY7vcX+RCH3AFTNGOUA3YHRv8hu4=;
        b=O1kg/tz4rm0KV+ekIjKxDo00tAqtVQNsOPOW0XiY0hbhF7Bs7Yxk55djNYa7Y+UaOT
         JFvFlFePT4ycwGM8Q7KhQTxXZeZKQ9wggxn6jKQBjsvz1z0LUN3kCdMfRFaDgMlIcxxp
         6tEyfqvupF87i/H9iJAAzmVYl4SUWmRrQFlHeJYz7sLPX0hH8fJnhdcVDwGdzzzpAWGY
         Kdr/RcPu0c/sDZuTMVrX0py8fjUbH0jHU5nlHwoVIvll3z4Uv588Nsmc9vHA0mq6k+AQ
         LOKxi0/BPagqFrrxigK8TAq3sUZ7V8PRDmdWNQdathi2977IkA9jrgBOZiAh0f4X1ya6
         SfrA==
X-Forwarded-Encrypted: i=1; AJvYcCVJyxW7R2ij6aR0O6H9cfVsiD5qWASvE20BOn8KUXTnzYfxPkijNMxfin/VDTCti6nDZnVAvpEmeaHLwYqOWzbAXxTwXowEbFwLCOwD
X-Gm-Message-State: AOJu0Yx9nXLrHm67Akv8NddDuJumd59m8EkMnBaWJFR2wp1DcGmV9p48
	c2FskrdiUcMw0RbxB+GL+eWMgN5YOy18k3sFXA70EBcQtV9AeYNgfw24t6VaIy8=
X-Google-Smtp-Source: AGHT+IHaFm4lzkxq9U1a8iPWUfix49p5Xd5gLpx7H0AEzCvQ84t8kRB/7beeUSB3FIO6fjrXa0k+4A==
X-Received: by 2002:a2e:8e23:0:b0:2e0:e129:7011 with SMTP id r3-20020a2e8e23000000b002e0e1297011mr1308756ljk.16.1714472238962;
        Tue, 30 Apr 2024 03:17:18 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id f28-20020a2eb5bc000000b002e0e78240a4sm205475ljn.77.2024.04.30.03.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 03:17:18 -0700 (PDT)
Date: Tue, 30 Apr 2024 13:17:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, robdclark@gmail.com, 
	david.heidelberg@collabora.com, guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, 
	mcanal@igalia.com, linux-mediatek@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/5] drm/ci: generate testlist from build
Message-ID: <k7sepoksttro3dgxxtwxfmlxwv5w5zn3aeso7p24mm3n74bo45@kx2dpe2qkqgo>
References: <20240430091121.508099-1-vignesh.raman@collabora.com>
 <20240430091121.508099-3-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430091121.508099-3-vignesh.raman@collabora.com>

On Tue, Apr 30, 2024 at 02:41:18PM +0530, Vignesh Raman wrote:
> Stop vendoring the testlist into the kernel. Instead, use the
> testlist from the IGT build to ensure we do not miss renamed
> or newly added tests.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
>  drivers/gpu/drm/ci/build-igt.sh  |   23 +
>  drivers/gpu/drm/ci/igt_runner.sh |    9 +-
>  drivers/gpu/drm/ci/testlist.txt  | 2761 ------------------------------
>  3 files changed, 28 insertions(+), 2765 deletions(-)
>  delete mode 100644 drivers/gpu/drm/ci/testlist.txt
> 
> diff --git a/drivers/gpu/drm/ci/build-igt.sh b/drivers/gpu/drm/ci/build-igt.sh
> index 500fa4f5c30a..cedc62baba1e 100644
> --- a/drivers/gpu/drm/ci/build-igt.sh
> +++ b/drivers/gpu/drm/ci/build-igt.sh
> @@ -26,6 +26,29 @@ meson build $MESON_OPTIONS $EXTRA_MESON_ARGS
>  ninja -C build -j${FDO_CI_CONCURRENT:-4} || ninja -C build -j 1
>  ninja -C build install
>  
> +set +ex
> +export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/igt/lib64
> +while read -r line; do
> +    if [ "$line" = "TESTLIST" ] || [ "$line" = "END TESTLIST" ]; then
> +        continue
> +    fi
> +
> +    tests=$(echo "$line" | tr ' ' '\n')
> +
> +    for test in $tests; do
> +        output=$(/igt/libexec/igt-gpu-tools/"$test" --list-subtests)
> +
> +        if [ -z "$output" ]; then
> +            echo "$test"
> +        else
> +            echo "$output" | while read -r subtest; do
> +                echo "$test@$subtest"
> +            done
> +        fi
> +    done
> +done < /igt/libexec/igt-gpu-tools/test-list.txt > /igt/libexec/igt-gpu-tools/testlist.txt
> +set -ex

Is the list in sync between x86 and arm/arm64 IGT builds? Is there a
chance of having a safety net here?

> +
>  mkdir -p artifacts/
>  tar -cf artifacts/igt.tar /igt
>  
> diff --git a/drivers/gpu/drm/ci/igt_runner.sh b/drivers/gpu/drm/ci/igt_runner.sh
> index f1a08b9b146f..20026612a9bd 100755
> --- a/drivers/gpu/drm/ci/igt_runner.sh
> +++ b/drivers/gpu/drm/ci/igt_runner.sh
> @@ -59,25 +59,26 @@ fi
>  
>  curl -L --retry 4 -f --retry-all-errors --retry-delay 60 -s ${FDO_HTTP_CACHE_URI:-}$PIPELINE_ARTIFACTS_BASE/$ARCH/igt.tar.gz | tar --zstd -v -x -C /
>  
> +TESTLIST="/igt/libexec/igt-gpu-tools/testlist.txt"
>  
>  # If the job is parallel at the gitab job level, take the corresponding fraction
>  # of the caselist.
>  if [ -n "$CI_NODE_INDEX" ]; then
> -    sed -ni $CI_NODE_INDEX~$CI_NODE_TOTAL"p" /install/testlist.txt
> +    sed -ni $CI_NODE_INDEX~$CI_NODE_TOTAL"p" $TESTLIST
>  fi
>  
>  # core_getversion checks if the driver is loaded and probed correctly
>  # so run it in all shards
> -if ! grep -q "core_getversion" /install/testlist.txt; then
> +if ! grep -q "core_getversion" $TESTLIST; then
>      # Add the line to the file
> -    echo "core_getversion" >> /install/testlist.txt
> +    echo "core_getversion" >> $TESTLIST
>  fi
>  
>  set +e
>  igt-runner \
>      run \
>      --igt-folder /igt/libexec/igt-gpu-tools \
> -    --caselist /install/testlist.txt \
> +    --caselist $TESTLIST \
>      --output /results \
>      $IGT_SKIPS \
>      $IGT_FLAKES \

-- 
With best wishes
Dmitry

