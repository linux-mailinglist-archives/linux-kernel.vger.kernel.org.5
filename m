Return-Path: <linux-kernel+bounces-150000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E3F8A98F2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B0F3284D5E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C8715F417;
	Thu, 18 Apr 2024 11:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vsNt5fbK"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE31D15F330
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 11:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713440907; cv=none; b=OEtzu0ZK6O2x1qKgBjBfsg/5PftQZs+G4w8srFMYJhqTn93/8EdPzskSGrnzAfMuv8ajM4PxyuFK+vFJJUG64g6yXBAj+T2r6k7BYlxHAamjLEJiULdlcFw7k4W474kBnoHiHgtMzOzJNT25hPN8bNxdVIV1TDw8N8LhGO0rYec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713440907; c=relaxed/simple;
	bh=gE136ijLAtKzyRYGVhVe2CMoT2C2wSdXn/ajEG1GWyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HpJ5/SAxQU6526Eh0KmEdi9j9sT1pVyKmvdxSglSixKBpri6Ntup1WUWZXNKomuFGsRMI/ukg/izxOeRzoeAJ7MwHWpwRCbK3ZEqlXyUdP5biz3UjnEpvSkhrsa6sHZQX8pP4ACqfj7Qcv4dMSEw3+xKSIE4h6F/2iojW+c0cpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vsNt5fbK; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc6cbe1ac75so638783276.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 04:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713440905; x=1714045705; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NuxTFXDlrm+BFnpHmLBiKm3zNo8+3C9CrzDgCHuzRNk=;
        b=vsNt5fbKOxQkX010Y7B0jwogqFOgePEz+AGFZqPHSmeQeVOrlEEzKl0hO76Amvsgal
         u5r3LP4eECgjWFfcpzb1WXottf2q0j0Guicou9cmWr/eMkcFlz3Z36hIRDrYna8OXzMN
         XDty0nq04+OmzrtmoYhZ3PnBC3gBPdKAS17/67qiBSZ6AsArf2a85CruazPsx075v9a2
         iPXaSOXj97eSc9qBn4xj3QeVwkAIxx1kPiilbhz9R8sw4SRMRZvC7L6/peb7gKWYXf9x
         zTvcvrjjbEC6mlaf8RAYf8IhZ8nCTHkXToozwom+fqc0YB63v43gMgkZuyL45CqI4Ruh
         V+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713440905; x=1714045705;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NuxTFXDlrm+BFnpHmLBiKm3zNo8+3C9CrzDgCHuzRNk=;
        b=souv0uS/bTHMRzbtepVNFTEhiR828QT4mvWLYuwO0Zf6SEUXeuqHvymsPNnQw2tD/N
         vYSMSnmyEALd3Vaa6p5aqzrxSKhKVN3d2PW/bblgjhgWHbUNl61mq2KJRUebCZm6LCTR
         af+hyH5cpgzEnV4TxT9tYi0AXPdi7ox6CiPUyNOndg32UGbBsJRaNdwxsW1KgD/CZvYB
         bBietNiqJ4U3i14Sy6bOG7tlZMt7x8EYtE/dLjS6BA6Uz/UvDJP5TgiSmdK54Zw7kjZQ
         I9Sr5e47vMFxZCTGy8DzmCkAfc26dz6eDo0F7PfFSPQgtSVLKVanfY9lgDw3T3CGabab
         P3Lg==
X-Forwarded-Encrypted: i=1; AJvYcCU3cKkiQUQhDWkvtYV1fyaQy0aNUU+HNyhv6YhqFGXpfzIBzXF0OsuqyOsTte+KGAlpjm57+iIHGDUwLjB7RhVbpTCxabyxyaWiscUI
X-Gm-Message-State: AOJu0Yx9F/w09HertL9b3xiZXwRbwIxm8dPFs1s6JZxukKIrvq3g99N5
	mJ7NepUmrnPlZq9j/Up8/hzzWaYOdNfpoLn6VCUj7PBOg1sIUfI6q1B4Pvy+c80N8Ik3juOyXEH
	JESEfh0UFIyzYQQ80yOnTpUlx381eYIlPAWLs6Q==
X-Google-Smtp-Source: AGHT+IGKBPlfH5drQwVfSarXKWibHJIXInY29SG6VZ1jJJB3cdumDdDbAMYX6JlD836WHkNKoYSwv0xG3WG+/ElPO7w=
X-Received: by 2002:a25:b121:0:b0:dc6:d1a9:d858 with SMTP id
 g33-20020a25b121000000b00dc6d1a9d858mr1686669ybj.8.1713440904861; Thu, 18 Apr
 2024 04:48:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404-topic-smem_speedbin-v2-0-c84f820b7e5b@linaro.org>
 <20240404-topic-smem_speedbin-v2-3-c84f820b7e5b@linaro.org>
 <hi7vzqm5ebypzs6m6bw64ghgfwsdzuaxy65jpah37iw5ww7fku@n3c5sucic27i>
 <bfd6aa32-a28e-47a4-82c7-76c5dd99a44d@linaro.org> <7ynodjzjuxwwqkjgns5jtnkckw52qyldfpsqpjh7645swva4xk@7wucftyjyyy3>
 <2b5f33ba-2108-464c-b4d2-eff2cc6e59cf@linaro.org>
In-Reply-To: <2b5f33ba-2108-464c-b4d2-eff2cc6e59cf@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 18 Apr 2024 14:48:13 +0300
Message-ID: <CAA8EJpqW-YxJdw-+QDEdhqjwAPK1dzmW1dW6=18wcRQgp+Oq6w@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] drm/msm/adreno: Implement SMEM-based speed bin
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
	Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Apr 2024 at 14:31, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On 18.04.2024 1:07 PM, Dmitry Baryshkov wrote:
> > On Thu, Apr 18, 2024 at 11:51:16AM +0200, Konrad Dybcio wrote:
> >> On 18.04.2024 1:43 AM, Dmitry Baryshkov wrote:
> >>> On Wed, Apr 17, 2024 at 10:02:55PM +0200, Konrad Dybcio wrote:
> >>>> On recent (SM8550+) Snapdragon platforms, the GPU speed bin data is
> >>>> abstracted through SMEM, instead of being directly available in a fuse.
> >>>>
> >>>> Add support for SMEM-based speed binning, which includes getting
> >>>> "feature code" and "product code" from said source and parsing them
> >>>> to form something that lets us match OPPs against.
> >>>>
> >>>> Due to the product code being ignored in the context of Adreno on
> >>>> production parts (as of SM8650), hardcode it to SOCINFO_PC_UNKNOWN.
> >>>>
> >>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >>>> ---
> >>
> >> [...]
> >>
> >>>> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> >>>> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> >>>> @@ -6,6 +6,8 @@
> >>>>   * Copyright (c) 2014,2017 The Linux Foundation. All rights reserved.
> >>>>   */
> >>>>
> >>>> +#include <linux/soc/qcom/socinfo.h>
> >>>> +
> >>>
> >>> Stray leftover?
> >>
> >> Looks like
> >>
> >> [...]
> >>
> >>>> +
> >>>> +#ifdef CONFIG_QCOM_SMEM
> >>>
> >>> Please extract to a separate function and put the function under ifdef
> >>> (providing a stub otherwise). Having #ifndefs inside funciton body is
> >>> frowned upon.
> >>
> >> Hm, this looked quite sparse and straightforward, but I can do that.
> >>
> >> [...]
> >>
> >>>> +/* As of SM8650, PCODE on production SoCs is meaningless wrt the GPU bin */
> >>>> +#define ADRENO_SKU_ID_FCODE               GENMASK(15, 0)
> >>>> +#define ADRENO_SKU_ID(fcode)      (SOCINFO_PC_UNKNOWN << 16 | fcode)
> >>>
> >>> If we got rid of PCode matching, is there a need to actually use
> >>> SOCINFO_PC_UNKNOWN here? Or just 0 would be fine?
> >>
> >> The IDs need to stay constant for mesa
> >>
> >> I used the define here to:
> >>
> >> a) define the SKU_ID structure so that it's clear what it's comprised of
> >> b) make it easy to add back Pcode in case it becomes useful with future SoCs
> >> c) avoid mistakes - PC_UNKNOWN happens to be zero, but that's a lucky
> >>    coincidence
> >>
> >> We don't *match* based on PCODE, but still need to construct the ID properly
> >>
> >> Another option would be to pass the real pcode and add some sort of
> >> "pcode_invalid" property that if found would ignore this part of the
> >> SKU_ID in mesa, but that sounds overly and unnecessarily complex.
> >
> > It's fine, just add a comment please. Maybe we can rename PC_UNKNOWN to
> > PC_PRODUCTION?
>
> I don't think that's right. The SoC "product code" may actually mean something
> (again, not necessarily for Adreno specifically), and with Adreno in mind, it
> being only meaningful for engineering samples may change in the future.

Ack


-- 
With best wishes
Dmitry

