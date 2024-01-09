Return-Path: <linux-kernel+bounces-20907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A0E82873B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83E781C24005
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F010B38FA8;
	Tue,  9 Jan 2024 13:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b="xAt013FQ"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257332206B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 13:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fooishbar.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bbebe6191bso2759287b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 05:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20230601.gappssmtp.com; s=20230601; t=1704807499; x=1705412299; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7mDLa1lDA9I4zsDt/vUi7Q5DM723KSTf2pIxDEMdeEE=;
        b=xAt013FQ0cnwm2q0cqlfPmezjtYXDSEPqvyCEM9VomZlxc9PV6X93nBZ21mo6eA4vq
         13uZZbimjCx2zbiYZq1SMS6TkSMGpjg9/alsKd92TkAzrs5EzN5rdJzWXr8h9Cv4Ks+W
         6cz0Wod6cyl/nF2BKCngJGdt1sWNsr6h0LQGRqfTSfGPz50Rc6plwMSE355QdDjkPGVm
         EKGZpWBMkAQdzwMu82QS1OBMC0hCmau/uL7LXWg2NdslTSzOkpxpPNUs67nE2KtiSb97
         yUPdjkUBPCy5YflhjfJofVALnwtQ4XmCRdZTzsnewRzmzR1K3kyYuJoIqhBkRzx8N8k7
         b1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704807499; x=1705412299;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7mDLa1lDA9I4zsDt/vUi7Q5DM723KSTf2pIxDEMdeEE=;
        b=ESgOvi+YZnrGmrYkaoQIN4zGBOLZKiZ/vHnQvcsAo2k8mKKQWtJgaJMoetjzJY5CuX
         dwwXJvb1DmgL9657khYW6qHwDE3LCot8WXwYFh3h29J20PTSHqU/h02sFIJMMHaSzRbK
         AkmEDvSHOw3chndGR6ykwQWD6vkBbJUtSnwLQhWQT4xPQbJ8ZTVR9Bhh9iRHJBhon3ob
         IX3GCJiJKtINk/A6R+y0SSn+FljGTDmf2yNAGZawyNKaOrTIypaktWupDZQA2SXW2SI5
         ocUPvWLM9TaRK8xedvSy5kNWgVwGW/b6N9ysRUH2z+BIgcJfn3ZV8i8LAAUx4wDAxVV3
         ElWA==
X-Gm-Message-State: AOJu0Yy1MrugXGh75H530u3+6pu37fuaP7OqGiAlNjjFMQuygUKq8fiM
	D8Cbao6uyHfVLGOvPCdj31jwFObsH3Psw0X0o1AlJlpBJg4yaw==
X-Google-Smtp-Source: AGHT+IEiIF+TOwHH0WeGea/W9p977jXEPA2RPNa5wHtj/r0Fwo02EIRShmM0F605PcR5+mNqG3weRRapKtHQAzzaPtk=
X-Received: by 2002:a05:6808:3185:b0:3bb:d83a:99a8 with SMTP id
 cd5-20020a056808318500b003bbd83a99a8mr8896956oib.58.1704807499107; Tue, 09
 Jan 2024 05:38:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220121110.1441160-1-vignesh.raman@collabora.com>
In-Reply-To: <20231220121110.1441160-1-vignesh.raman@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Tue, 9 Jan 2024 13:38:08 +0000
Message-ID: <CAPj87rOMPioOK0r74vcnVkXusm6Nah6KNUWyxYgpVLdkMNtW2g@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] drm/ci: Add support for GPU and display testing
To: Helen Koike <helen.koike@collabora.com>, Dave Airlie <airlied@gmail.com>, 
	Sima Vetter <daniel@ffwll.ch>, Daniel Stone <daniels@collabora.com>, Emma Anholt <emma@anholt.net>, 
	linux-rockchip <linux-rockchip@lists.infradead.org>, guilherme.gallo@collabora.com, 
	sergi.blanch.torne@collabora.com, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, 
	David Heidelberg <david.heidelberg@collabora.com>, Rob Clark <robdclark@gmail.com>, 
	linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On Wed, 20 Dec 2023 at 12:11, Vignesh Raman <vignesh.raman@collabora.com> wrote:
> Some ARM SOCs have a separate display controller and GPU, each with
> different drivers. For mediatek mt8173, the GPU driver is powervr,
> and the display driver is mediatek. In the case of mediatek mt8183,
> the GPU driver is panfrost, and the display driver is mediatek.
> With rockchip rk3288/rk3399, the GPU driver is panfrost, while the
> display driver is rockchip. For amlogic meson, the GPU driver is
> panfrost, and the display driver is meson.
>
> IGT tests run various tests with different xfails and can test both
> GPU devices and KMS/display devices. Currently, in drm-ci for MediaTek,
> Rockchip, and Amlogic Meson platforms, only the GPU driver is tested.
> This leads to incomplete coverage since the display is never tested on
> these platforms. This commit series adds support in drm-ci to run tests
> for both GPU and display drivers for MediaTek, Rockchip, and Amlogic
> Meson platforms.

Thanks a lot for these. The patches need to be squashed to be
bisectable though. For example, patch #2 changes the MTK job names and
adds more jobs, but the corresponding xfail updates only come in #7
and #8. This means we have a span of a few patches where we don't have
useful test results.

A better sequencing would be something like:
  1. add ANX7625 config
  2. refactor _existing_ MTK display jobs to use YAML includes, change
the existing job name, and rename the existing xfail set, remove
IGT_FORCE_DRIVER from the script since it's now set by the job
  3. add MTK Panfrost+PVR GPU jobs with new xfails, add xfail entry to
MAINTAINERS
  4+5: same as 2+3 but for Amlogic
  6+7: same as 2+3 but for Rockchip

Then the separate rename/update xfail commits just disappear, as does
the removal of IGT_FORCE_DRIVER, because it's just done incrementally
as part of the commits which change the related functionality. It's
extremely important that every change can work standalone, instead of
introducing intermediate breakage which is only fixed in later commits
in the series.

Cheers,
Daniel

