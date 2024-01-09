Return-Path: <linux-kernel+bounces-20888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCF58286FA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3645A1C23B68
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4DC38F94;
	Tue,  9 Jan 2024 13:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="CCveQLyS"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587B6374D9
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 13:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a2328f2b6e5so75282766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 05:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1704806526; x=1705411326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8nyMGssowFI2DlaMmQ3Tpss+UtDdR+faxTS8hNAvao=;
        b=CCveQLySshz7k2ru4M4ppbgS8kxsulNJEaNj7eXYbh4JktAwOMJfpXed+lNRPLObH9
         caLkWyW+M7nBcgw5Wu3CDfoXki638jXuhp6FmI0RRzHSClvj+wNTbyGsX0NG0dLKKujZ
         xzIVzXHAs4sArvhQYY5fGdxXSSW8ZDt3sUvdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704806526; x=1705411326;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X8nyMGssowFI2DlaMmQ3Tpss+UtDdR+faxTS8hNAvao=;
        b=J8+gTjQZ8uCdr0GJviMqfN0t1FblthUpuNYu/ZFyA0ijpXsE3F4YULamlo4utcEGez
         Prp5kgqVy4nuGKwl5fhXcAWB5ZQG3e7Opno3ZoXr6+WpPwv5tpoJiz/tlbMzCesUSMz2
         yvkFiyyn9Nmy7Z0w9+002WSIaeXELSqIHLl4zILrXjwHy5XImeWD0a+GB/IlbPuuuCbZ
         nrtmCHbbai2mFJZiIUMzaSXN4ne6ozREYskHKMjRexGIauEfoVhuoQNLFlCwlah+fMxj
         Hqq08vGmnKBi7e7KHZoW0xQ+TXdQ5INuAkukRc6miNp7jGBXlgp1juoDY0r5TKp8UiOZ
         g5hw==
X-Gm-Message-State: AOJu0YyQLAeTEU+SXs022m8ZeJWNiBo5Vbp7Z6Q/5M6cBHw14L0zjb/+
	iNOBQMRCDEka9TlQzj62/zERsE4jHRPRmg==
X-Google-Smtp-Source: AGHT+IFi7RfzXVRLPVWIVsSbvJo+89aCiOIdxE8Is6w6/5ECdWmo4tLla9mz3sECM1F7viqHnFP/0w==
X-Received: by 2002:a17:907:9282:b0:a26:a4e8:5454 with SMTP id bw2-20020a170907928200b00a26a4e85454mr4655999ejc.0.1704806526503;
        Tue, 09 Jan 2024 05:22:06 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id s23-20020a170906455700b00a27a32e6502sm1026398ejq.117.2024.01.09.05.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 05:22:05 -0800 (PST)
Date: Tue, 9 Jan 2024 14:22:02 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
	Erico Nunes <nunes.erico@gmail.com>,
	=?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Donald Robson <donald.robson@imgtec.com>,
	Frank Binns <frank.binns@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Sarah Walker <sarah.walker@imgtec.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/imagination: Defer probe if requested firmware is
 not available
Message-ID: <ZZ1IellMvvyFlQaF@phenom.ffwll.local>
Mail-Followup-To: Javier Martinez Canillas <javierm@redhat.com>,
	linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
	Erico Nunes <nunes.erico@gmail.com>,
	=?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Donald Robson <donald.robson@imgtec.com>,
	Frank Binns <frank.binns@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Sarah Walker <sarah.walker@imgtec.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
References: <20240109120604.603700-1-javierm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109120604.603700-1-javierm@redhat.com>
X-Operating-System: Linux phenom 6.5.0-4-amd64 

On Tue, Jan 09, 2024 at 01:05:59PM +0100, Javier Martinez Canillas wrote:
> The device is initialized in the driver's probe callback and as part of
> that initialization, the required firmware is loaded. But this fails if
> the driver is built-in and the firmware isn't present in the initramfs:
> 
> $ dmesg | grep powervr
> [    2.969757] powervr fd00000.gpu: Direct firmware load for powervr/rogue_33.15.11.3_v1.fw failed with error -2
> [    2.979727] powervr fd00000.gpu: [drm] *ERROR* failed to load firmware powervr/rogue_33.15.11.3_v1.fw (err=-2)
> [    2.989885] powervr: probe of fd00000.gpu failed with error -2
> 
> $ ls -lh /lib/firmware/powervr/rogue_33.15.11.3_v1.fw.xz
> -rw-r--r-- 1 root root 51K Dec 12 19:00 /lib/firmware/powervr/rogue_33.15.11.3_v1.fw.xz
> 
> To prevent the probe to fail for this case, let's defer the probe if the
> firmware isn't available. That way, the driver core can retry it and get
> the probe to eventually succeed once the root filesystem has been mounted.
> 
> If the firmware is also not present in the root filesystem, then the probe
> will never succeed and the reason listed in the debugfs devices_deferred:
> 
> $ cat /sys/kernel/debug/devices_deferred
> fd00000.gpu     powervr: failed to load firmware powervr/rogue_33.15.11.3_v1.fw (err=-517)
> 
> Fixes: f99f5f3ea7ef ("drm/imagination: Add GPU ID parsing and firmware loading")
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Uh that doesn't work.

Probe is for "I'm missing a struct device" and _only_ that. You can't
assume that probe deferral will defer enough until the initrd shows up.

You need to fix this by fixing the initrd to include the required
firmwares. This is what MODULE_FIRMWARE is for, and if your initrd fails
to observe that it's just broken.

Yes I know as long as you have enough stuff built as module so that there
will be _any_ kind of device probe after the root fs is mounted, this
works, because that triggers a re-probe of everything. But that's the most
kind of fragile fix there is.

If you want to change that then I think that needs an official blessing
from Greg KH/device core folks.

Cheers, Sima

> ---
> 
>  drivers/gpu/drm/imagination/pvr_device.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/imagination/pvr_device.c b/drivers/gpu/drm/imagination/pvr_device.c
> index 1704c0268589..6eda25366431 100644
> --- a/drivers/gpu/drm/imagination/pvr_device.c
> +++ b/drivers/gpu/drm/imagination/pvr_device.c
> @@ -295,8 +295,16 @@ pvr_request_firmware(struct pvr_device *pvr_dev)
>  	 */
>  	err = request_firmware(&fw, filename, pvr_dev->base.dev);
>  	if (err) {
> -		drm_err(drm_dev, "failed to load firmware %s (err=%d)\n",
> -			filename, err);
> +		/*
> +		 * Defer probe if the firmware is not available yet (e.g: the driver
> +		 * is built-in and the firmware not present in the initramfs image).
> +		 */
> +		if (err == -ENOENT)
> +			err = -EPROBE_DEFER;
> +
> +		dev_err_probe(drm_dev->dev, err, "failed to load firmware %s (err=%d)\n",
> +			      filename, err);
> +
>  		goto err_free_filename;
>  	}
>  
> -- 
> 2.43.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

