Return-Path: <linux-kernel+bounces-21173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED65828B3C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F9462836AA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BAB3B2BD;
	Tue,  9 Jan 2024 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="ew2/jpsm"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339F03B297
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 17:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5e6c8b70766so29420277b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 09:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1704821341; x=1705426141; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ES7KBLZZG8PKvoN1C5XRDxhZW5V7JmVLq/Pi/J8+3to=;
        b=ew2/jpsmzNm926mWDm2t9p/Ph9J2GMqSH9Y5lLifC88yswIHus2CqfbUg6JuBTall6
         2qfukrpGTJ6VhRtRn7bDzLyop7+5Zt0yuuNFSm/0RfQT7x+XokXqf3330ece+c4tGZoI
         mow5h/FgvDgWwru1OA+b3oA5vUR7txKDdo5/yp3vceebucPfWg6rCz1fvgOezme04vos
         0X2ybsk6dZdeTlsBBzleVAwxVP0neCVTPj5xx6oIxD3Gwcx5z5JXhv+D6eS4ex0DwdG4
         VtTgoUJmKs5YnHDBX2ghBJYLiwYa+PPX8U4GQW9W8kd3kpXFNPHsGfPWevKgUD/AES6n
         griQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704821341; x=1705426141;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ES7KBLZZG8PKvoN1C5XRDxhZW5V7JmVLq/Pi/J8+3to=;
        b=v0N6oxemQAcdaalYvjozHeISJu5pCbp9rzcvSBqVULlK10TZfUVTS9oobdWxuLIMpQ
         tM9MKHvb87sWwhRhJUuOanyLSJXXifPwVTn0YtwHZjBSFnyag0ldzOdNfF8e84jb9tp9
         2r5JjO/2L2fV6O0gg5ZfZEU4OwklobGlsuytrlVzNEX/yQA2I9Qsbq5y6fMIteUVFs4Z
         aIkb1Ii/kFWZL20af/GENZkuwknk2KSgZKNkQiH0HkMFhOmtcoRhLXD5Z+OV3yYD7OeX
         j1whRkirDfLUEnCfmujlTa3Aa1oEhttE/SIYPcglw/qj0M4oMdUnHp36sHnA8w4qR37S
         PpwQ==
X-Gm-Message-State: AOJu0YzXiNb7RfkHHa2H5vsuDNUD5dW+PHLDkfZffU2HpMzBVjxO6oFn
	2cLbEm4XsgkyDIgi+8uLo7fx5OlYcL21lUlJnd9pHRgT7GsMTw==
X-Google-Smtp-Source: AGHT+IGgI/FoLML7Z/cvGXsENd2rwJDH5p4+nuQ7PKd15HF7RA/G4lSfYUHjMfXlkBR8ob0lW+xWSn2ZjfO7PCnI8Dk=
X-Received: by 2002:a81:9184:0:b0:5e8:8890:8afe with SMTP id
 i126-20020a819184000000b005e888908afemr3645470ywg.78.1704821341152; Tue, 09
 Jan 2024 09:29:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109070949.23957-1-shengyang.chen@starfivetech.com> <99d7bb85-17b0-4b5e-a6cf-f5957ad92298@linaro.org>
In-Reply-To: <99d7bb85-17b0-4b5e-a6cf-f5957ad92298@linaro.org>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Tue, 9 Jan 2024 17:28:44 +0000
Message-ID: <CAPY8ntBcXEyg5tXHGwAdbVody7ihHo3gb1C4vE+6PY2biDhN4g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add waveshare 7inch touchscreen panel support
To: neil.armstrong@linaro.org
Cc: Shengyang Chen <shengyang.chen@starfivetech.com>, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com, sam@ravnborg.org, 
	airlied@gmail.com, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, wahrenst@gmx.net, 
	thierry.reding@gmail.com, changhuang.liang@starfivetech.com, 
	keith.zhao@starfivetech.com, jack.zhu@starfivetech.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi

On Tue, 9 Jan 2024 at 11:19, <neil.armstrong@linaro.org> wrote:
>
> Hi,
>
> On 09/01/2024 08:09, Shengyang Chen wrote:
> > This patchset adds waveshare 7inch touchscreen panel support
> > for the StarFive JH7110 SoC.
>
> Could you precise which SKU you're referring to ? is it 19885 => https://www.waveshare.com/7inch-dsi-lcd.htm ?
>
> Are you sure it requires different timings from the RPi one ? In the Waveshare
> wiki it explicitly uses the rpi setup (vc4-kms-dsi-7inch) to drive it: https://www.waveshare.com/wiki/7inch_DSI_LCD

I raise the same question.

Keith Zhao earlier submitted effectively the same set of patches [1]
and the response for the updated timing was:
<quote>
My platform dphy tx hardware has certain limitations.
Only supports integer multiples of 10M bitrate:
such as 160M ,170M, 180M,190M,...1G(max)

as common dphy bitrate = pixclock*bpp/lanes.
This value cannot match successfully in most cases.

so in order to match bitrate , I choose a bitrate value around
pixclock*bpp/lanes,
Prevent overflow and underflow by fine-tuning the timing parameters:-(
that will make the new timming value.
</quote>

I then suggested mode_fixup should be used in the DSI host driver, and
Keith acknowledged that.

Is this new timing still because of the DSI host requirement?

  Dave

[1] https://lists.freedesktop.org/archives/dri-devel/2023-December/434150.html

> Neil
>
> >
> >
> > changes since v1:
> > - Rebased on tag v6.7.
> >
> > patch 1:
> > - Gave up original changing.
> > - Changed the commit message.
> > - Add compatible in panel-simple.yaml
> >
> > patch 2:
> > - Gave up original changing.
> > - Changed the commit message.
> > - Add new mode for the panel in panel-simple.c
> >
> > v1: https://patchwork.kernel.org/project/dri-devel/cover/20231124104451.44271-1-shengyang.chen@starfivetech.com/
> >
> > Shengyang Chen (2):
> >    dt-bindings: display: panel: panel-simple: Add compatible property for
> >      waveshare 7inch touchscreen panel
> >    gpu: drm: panel: panel-simple: add new display mode for waveshare
> >      7inch touchscreen panel
> >
> >   .../bindings/display/panel/panel-simple.yaml  |  2 ++
> >   drivers/gpu/drm/panel/panel-simple.c          | 28 +++++++++++++++++++
> >   2 files changed, 30 insertions(+)
> >
>

