Return-Path: <linux-kernel+bounces-56066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1897384C595
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C829E287F61
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1082031E;
	Wed,  7 Feb 2024 07:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f0oztdqu"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62926200D9
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 07:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707290603; cv=none; b=I+J0uD6iyaRp+C8Vh2/6r7cnhfm8j4e6rwrNrdIF9wCuBzf2QYjkN+8TU+95ifBapWMQlZ7kWqWGaCpfbMq8oPznaW32eJz+nl9m9tC104tqo6yciEjov7l7PByEJ7C5zf9/qkENTOWMGZ5KprssCAQMRR8P805tnMz0EL0PS4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707290603; c=relaxed/simple;
	bh=B35jxefI6tcTL6IQRnkPUsKP9mX+pIhGZ//x/bqYndw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VyF6zuCD5U4zzvyDKKJCHPjc0FMCAkVcM3Xk3XSmOopnjdU4gGPwgN/Uxy5knWcIzdc33Wcqcru82wa1ERRSBOcTZe1Hjf35ilQ9vAJTVEHVz4FzQE2vqWc8sgUXc4m7Hd57RkuIe4yrx/AWm5B84TdtbTsPmjjVPqjUTtuzI0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f0oztdqu; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6047a616bfeso2896027b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 23:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707290600; x=1707895400; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ul/vL+oJkRgYUPa1hDePq1cyQcdFp3HR4K17flhmqx4=;
        b=f0oztdqudMwwXx9odYNv+UfkxoVxAcO2ZWMhLd786yM5dvwp7ylq0PuvRph4iUHaUB
         EZftHskPVUA5A6lzgh2statA75k0URUMfyBzYelUeZy2LscNHKInwhDkkpugXz9LRifZ
         uFEH/Rzgb1QUHgwLBjWQoFaOJip8V4b+1/nVa/vfmq14JOCcXHWhy2qj2G0aGTY8AmmM
         yR1SCMxJGl+IZ5gQRAj9lh10cS8aWGSrz/BVAnb+kPsDNWVTxOk4SpRG1JVnRZifERi8
         ehzGNfcaCklvZVR6egrM7BjipmWlpAwnU1z4xg1epCkNkktKzRnabig1qQ4Uv401SkAC
         WFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707290600; x=1707895400;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ul/vL+oJkRgYUPa1hDePq1cyQcdFp3HR4K17flhmqx4=;
        b=BKMDR6XVDEIzp1wzbTz1kDBpNGDlirtCea/jOfDd7bfbQMmpnq1fymq87BLqGoeSaH
         iypF0c73HvFkzJH007H9SC0DGUYkumFmTKqeH3KSN2Npqc61PUJkANsMBdPjr0LujEMQ
         s5oAzWDEq2g5u25Zoh85jfVawps7ef8Jk38ch39LHCn7idR3HuvFob/L8t19hOfBUjUo
         2YIxQf+LxYriWz5iOgQal0hLF5Xu87we5AoAg1+3Mu/TL1jqsGy1/wy7oTgwUmoM0n/R
         JIJfCCtjofnlSrPy1G3O4V0C/BOjzwAfvLLOD0fh/Hs3J/al1J9hkD+wOwIf4BKcg+yd
         1xjw==
X-Gm-Message-State: AOJu0Yy7lukjpg9bu6eJZDAI72LInbURszjqal3LwJtixNod4CMSIVl4
	OG+rr6up8h7VUV2fC5ZnhPqXF4+BWQfpvzyd6OB9JwkPHr2sO6G/Gh47o7kFp1BPOLUneIfKoUV
	6lzkqvrs8ivV9hp09uqZ+5o5UoFbP5JMfZsolUw==
X-Google-Smtp-Source: AGHT+IFmSPUVi9I1FzvhN0MJUCfEDi+UeMDB4xdBNbC5glZo8HfXW9t8BlXXiKbrYvcPLJEmEfspsezUlkHKpyHMv94=
X-Received: by 2002:a81:4148:0:b0:5ff:92f1:8e24 with SMTP id
 f8-20020a814148000000b005ff92f18e24mr4344209ywk.48.1707290600212; Tue, 06 Feb
 2024 23:23:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207-spmi-multi-master-support-v1-0-ce57f301c7fd@linaro.org>
 <20240207-spmi-multi-master-support-v1-1-ce57f301c7fd@linaro.org>
 <CAA8EJpqsJmv36=o1aTjVH6eMHXMg8BHNpiDvs+Q8YB23ezVGtQ@mail.gmail.com> <ZcMvFtAwQQjAZhk6@linaro.org>
In-Reply-To: <ZcMvFtAwQQjAZhk6@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 7 Feb 2024 09:23:09 +0200
Message-ID: <CAA8EJprqWLX7_yWZzKp3FAKFGkSkk041f9hj1uXuRBrbH5APyQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] spmi: Add support for multi-master
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Feb 2024 at 09:19, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> On 24-02-07 01:55:39, Dmitry Baryshkov wrote:
> > On Wed, 7 Feb 2024 at 01:34, Abel Vesa <abel.vesa@linaro.org> wrote:
> > >
> > > Some newer SPMI controllers support multiple bus masters.
> > > Such a master can control multiple slave devices. The generic
> > > framework needs to be able to pass on the master id to the
> > > controller-specific driver. So do that. The framework will
> > > check if the devicetree child nodes are actually bus masters
> > > and will register the devices for each master. The legacy
> > > approach will still be supported for backwards compatibility.
> >
> > Please remind me, are those two actual bus musters driving a single
> > bus in parallel or two SPMI buses being handled by a single device? In
> > the latter case this implementation is incorrect. There should be
> > multiple spmi_controller instances, one for each bus. Allocate them in
> > a loop and set ctrl->dev.of_node after allocating.
>
> It's two SPMI buses (two sets of wires) handled by the same controller,
> HW-wise.
>
> If we register two spmi controllers with the kernel framework, it will
> be HW inaccurate, because there is just one controller which has
> multiple masters.

struct spmi_controller is a controller for a single bus. Inside your
device you have two SPMI buses, each can be controlled by its own
struct spmi_controller. Just like devices that control multiple I2C,
SPI or USB busses register a separate instance of the bus controller.

>
> I'm not saying it might not work. But, to me, it looks more like a hack.
>
> Basically, we would be mapping HW bus masters to kernel controllers.

Buses, not just masters.

>
> >
> > >
> > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > ---
> > >  drivers/spmi/spmi-mtk-pmif.c |  6 ++--
> > >  drivers/spmi/spmi-pmic-arb.c | 10 +++---
> > >  drivers/spmi/spmi.c          | 76 ++++++++++++++++++++++++++++++--------------
> > >  include/linux/spmi.h         | 10 +++---
> > >  4 files changed, 67 insertions(+), 35 deletions(-)
> >
> > --
> > With best wishes
> > Dmitry



-- 
With best wishes
Dmitry

