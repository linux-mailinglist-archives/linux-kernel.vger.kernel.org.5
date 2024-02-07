Return-Path: <linux-kernel+bounces-56415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7670584C9E1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF1291F24A48
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A69A1F61F;
	Wed,  7 Feb 2024 11:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OAOzleU3"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB57F1D6B6
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 11:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707306329; cv=none; b=RgatbUVgt9d/bu4IO6hjDvICaQweArCZdyBhANLB0FkD5PCaeGCISCLSqug9afK0wtIQlXQKvJo+/uFK1xhzMwo9I8CfXRzwf50cz8Fh5RapGJzgxMCwz/4M+BQXH9SP89Amk5K3Yb7MZRAOSNCBqz7EqTWCTAG5kpToQnakh0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707306329; c=relaxed/simple;
	bh=IXfFeG2/K8g7CfX5pVLPJBoqzXw4E/6hFgYmUY+wogI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cni0oQHz89LSfp0pyV4ZkTaLMVULJodyZDNA165MFZKgvCQdqZ2VWcaGEq5Th9skrZpBadeCnlzmfr9+9rwgjt0KY+IAv4et6GQHz4z8k39X1Qe3kbYpAEe3ETrocuo5HNvnX2FDGV4NyJCbwr3i5serDkFM1Vg5x5pinFUeFJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OAOzleU3; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-60485382886so5648557b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 03:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707306326; x=1707911126; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0QJWHcQRNdZ++xNr9XAli49/YD9Wnzb7ytJ9y9YhSe4=;
        b=OAOzleU32vC7Sa3seH6H7+sVmZGmXKPN3cSIRWV8/APSkmBiuuPAsIW/XKw6qVf7Yi
         q+55aBfK/+0IAkI7pZrJyz+hPfuHbIdmEUoxcwA5BK52l3XAGMFCqgtn9Cme1PBCIvJk
         6/0KMHNpce56tzTHzG0K5vad7JeZJieNAAhvIqkQK8jEwTJ9B6b2s7uDy4Cl7vDLQdjh
         7SDQtvSi4wW6QhOWRZSyU1YSU8plOwX97P0WgKbCqpUrd0k33j7BBShDuJvqKhb9cYFO
         59QsotuXaVs32u8Ezoes+jgjPnWStB7smxVatNbk+gKKxN1NZbxegey9aNooy8eb0GcX
         eB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707306326; x=1707911126;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0QJWHcQRNdZ++xNr9XAli49/YD9Wnzb7ytJ9y9YhSe4=;
        b=sJy+Bjf784CgFcN3T2y+iNuqfKaMnJaPrMFPwKCoq5Ocu6xx+bFPqwEHhM8h1Wfukg
         5k1nWktboicr/MBzuEul1RERlV3kKiCciS2AC39uq+sSm7VkfBOTO52+biWhtZjfR594
         S1fNoEnVLvRoKrJCu+hXK1d7rHU7PnsDmbNiGgoy5WpKoRA+unafTtScoFkvDDC1EiAj
         SDbROo9CrKSKmrIFjWwk/4S0JYaP79kRMXGvh/2PEH0os8oJLQ8UDKUXkkDRKGt0Yb5h
         UsxeGCQlRLl38JI11ZQ5y4ai0l+9/G2FotByHAIffu8CIre7vg/bvVPNKxDZYZdk5UMr
         B11A==
X-Gm-Message-State: AOJu0YxUgQ240Yq1TpTTIITxloZbtkjzWykqzElZ9CsHBEWRCyVnuwVN
	mUDXDVGC42iAmEUqYKYO1IWB0pNjo/P01F4U41HLlIgpvzZMnwVc2m3QYz/SI25zyUDxiutM2Ge
	e5FZnguDM+cw02+d3NvRBJ09sgLZ6gIOrvtGxbA==
X-Google-Smtp-Source: AGHT+IH/o53PW2EBoUiu+Xx5ucqrkx2JVhwy9re+Mvcxtl2y/qEnzuhByDLE8rDyLEGdQlkM81L0zIoLvRmrkgLGS88=
X-Received: by 2002:a05:690c:f8a:b0:5ff:4987:4ef3 with SMTP id
 df10-20020a05690c0f8a00b005ff49874ef3mr5462398ywb.24.1707306326640; Wed, 07
 Feb 2024 03:45:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207-spmi-multi-master-support-v1-0-ce57f301c7fd@linaro.org>
 <20240207-spmi-multi-master-support-v1-1-ce57f301c7fd@linaro.org>
 <CAA8EJpqsJmv36=o1aTjVH6eMHXMg8BHNpiDvs+Q8YB23ezVGtQ@mail.gmail.com>
 <ZcMvFtAwQQjAZhk6@linaro.org> <CAA8EJprqWLX7_yWZzKp3FAKFGkSkk041f9hj1uXuRBrbH5APyQ@mail.gmail.com>
 <ZcNIddeG6VHxBEOQ@linaro.org>
In-Reply-To: <ZcNIddeG6VHxBEOQ@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 7 Feb 2024 13:45:15 +0200
Message-ID: <CAA8EJpo-16u34Yc6MLmHSqFrQ0VrZAq6TwGeVc5WFwMmhruqoA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] spmi: Add support for multi-master
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Feb 2024 at 11:08, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> On 24-02-07 09:23:09, Dmitry Baryshkov wrote:
> > On Wed, 7 Feb 2024 at 09:19, Abel Vesa <abel.vesa@linaro.org> wrote:
> > >
> > > On 24-02-07 01:55:39, Dmitry Baryshkov wrote:
> > > > On Wed, 7 Feb 2024 at 01:34, Abel Vesa <abel.vesa@linaro.org> wrote:
> > > > >
> > > > > Some newer SPMI controllers support multiple bus masters.
> > > > > Such a master can control multiple slave devices. The generic
> > > > > framework needs to be able to pass on the master id to the
> > > > > controller-specific driver. So do that. The framework will
> > > > > check if the devicetree child nodes are actually bus masters
> > > > > and will register the devices for each master. The legacy
> > > > > approach will still be supported for backwards compatibility.
> > > >
> > > > Please remind me, are those two actual bus musters driving a single
> > > > bus in parallel or two SPMI buses being handled by a single device? In
> > > > the latter case this implementation is incorrect. There should be
> > > > multiple spmi_controller instances, one for each bus. Allocate them in
> > > > a loop and set ctrl->dev.of_node after allocating.
> > >
> > > It's two SPMI buses (two sets of wires) handled by the same controller,
> > > HW-wise.
> > >
> > > If we register two spmi controllers with the kernel framework, it will
> > > be HW inaccurate, because there is just one controller which has
> > > multiple masters.
> >
> > struct spmi_controller is a controller for a single bus. Inside your
> > device you have two SPMI buses, each can be controlled by its own
> > struct spmi_controller. Just like devices that control multiple I2C,
> > SPI or USB busses register a separate instance of the bus controller.
>
> Well, this is what this patchset is trying to do in the generic part.
> The SPMI controller supports multiple buses (HW-wise) and therefore SW
> implementation shouldn't be tied to single bus requirement.

So, after the off-line discussion:
- add new compatible string for sm8450+
- register two spmi controller instances
- drop the master-id from the SPMI interface
- optionally: think about having a new separate driver for v7 SPMI.

>
> >
> > >
> > > I'm not saying it might not work. But, to me, it looks more like a hack.
> > >
> > > Basically, we would be mapping HW bus masters to kernel controllers.
> >
> > Buses, not just masters.
> >
> > >
> > > >
> > > > >
> > > > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > > > ---
> > > > >  drivers/spmi/spmi-mtk-pmif.c |  6 ++--
> > > > >  drivers/spmi/spmi-pmic-arb.c | 10 +++---
> > > > >  drivers/spmi/spmi.c          | 76 ++++++++++++++++++++++++++++++--------------
> > > > >  include/linux/spmi.h         | 10 +++---
> > > > >  4 files changed, 67 insertions(+), 35 deletions(-)
> > > >
> > > > --
> > > > With best wishes
> > > > Dmitry
> >
> >
> >
> > --
> > With best wishes
> > Dmitry



-- 
With best wishes
Dmitry

