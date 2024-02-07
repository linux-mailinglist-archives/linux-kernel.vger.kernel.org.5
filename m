Return-Path: <linux-kernel+bounces-56166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CD784C6E4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A083C1F249B4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA5E22333;
	Wed,  7 Feb 2024 09:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RpSPfZS/"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7390219FD
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 09:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707296891; cv=none; b=LUfYIKlhL/kp+FmfSlnCLuyji7EyLUMu3fj6nB2DUO33u61DA6e/64KQjLBkKpGnyV6Qxhha0qAbg0o5Qu//5cqlX5U6Ot9R7p5UtoP7yiq+u6UHpZVBd3PwMwNrIVum3ggXYVqiFzd6d6ju6HQxcVQtr0eaFP+D2LI31kYAQ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707296891; c=relaxed/simple;
	bh=LizzINJGC5xEtbjImiJIdvLHBRIezQZMDq+PcR30woo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQXZGhp4NHdDIyk31zJyrINSEvb4u2jQLRR4yRh/RJ4kQfvEmH1vGLiJLxifAUH6C2lNlVXZYq7mC++2E/Q2KlijHTpwwJmNyIaUbe0RWtkYXXGdNaxoUNDmb/N6UVJGsglEEy+tuy1SfS1GuZnLzbPVWMhtqFrl8sCTR48AzzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RpSPfZS/; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55ee686b5d5so434234a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 01:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707296888; x=1707901688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TsNj2DX8RJsqHOPPwaVUY94IMVrEnah0wSC3qGvPZMs=;
        b=RpSPfZS/b4nBCeABEu4lz/XDRF8B1yEUohQNd5l1jbMbaOaXdRCIWw/8f4W89WLOhi
         WHPAoKx4yu0BxaYmFDMaoEGwZlu76DlJjGNisHlVTlyG5UYvqG61DFdAGkBKEJBzgEJl
         TsKcSF/mEYoyiwvKoA56mBIPZps8pq2eM7fPx8eI7knUM34Fhdn7YcGppK3abP2xYCnj
         9KS1AlVnNtwSuqXaVpJCSI759RBN04qJ7AKKytRma7AK7lzWJrredhWxnlKVUU0j+Tg/
         o/p7ChaTziizWy6Dh7D6w6ruip3htITTEvgUBCfJmeVXDUAe/HH5rq9kc1H06HQGEtnf
         1MRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707296888; x=1707901688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsNj2DX8RJsqHOPPwaVUY94IMVrEnah0wSC3qGvPZMs=;
        b=Y8xQhfiADaEfcSlOVwXNWeKu7oowm7pErH9N1UdpgLMAe0ZbnMzjuBWzzadhbTv51r
         TMVSenllMzts/43xhrX/vNnJyYoexi6MLp/4LzG0b/D+WuJc/vgrroy40QtSWczHqMFl
         w5ifoOwg6FVtKaBnnXKuAYscEvri2vskX0V4ICOXY2547eReTQ7XhdfSYZrSCbwuygWD
         JRGpAFz9Xq/KfhEH6EbAt03lB4KwxIadYZD1mhhbBtZY0M8eftYfzMX8VZxRsXILB033
         5uYnOkmaGZWYxUG4S4ZJ6l74AoC/AvbldaWI8ZGpoQ8kdrrTjWuB48OCwKNr/8e2DFch
         0gNw==
X-Gm-Message-State: AOJu0YyPLde5JftBvEVo/a+7cifBjQ9Z01qi8iMp9A5M9uSgD2kUO42V
	+bXsYy7GmeAQH+o+gC/ttfCll0kcfHrMNzp/2cjA9d4yAbre1fKLA9kX0ysFots=
X-Google-Smtp-Source: AGHT+IGGcb322HA0o5RHNBrkSMZHPf8n0gbux/28bD/rBXtfoFtT5yhn0dzUVOa8i9Lwlhq6DNXeqQ==
X-Received: by 2002:aa7:de04:0:b0:560:1652:e7cb with SMTP id h4-20020aa7de04000000b005601652e7cbmr3693310edv.16.1707296887842;
        Wed, 07 Feb 2024 01:08:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU+rUyq+VfYElNWnIEpSD69Mb31OSI6iMCKmXTJb2gIF+MK3w0nklCk7YxlQ+5SIw0shtAqcVLEaz/kdD6yXacs0svf29R+lPj51I/s7oUy5k9KXkmvEJa+O2vyTor9OF3RAmfabD52nteSiJDIccTcCpF4M5DXn3Umz8/2QwXkurxzG9hpkpdyi9NRbS6uVU6AeZLoyg8HDrejOTjxVqtfAAHlKHqhOQSx4DM8gfmAHSdKyPH0mMNMzs02NKqM71p/d3WIIcVrWIzN6nWpy7x5wmrxhHTNYswC5C15P/PtXH8zWNchzR10lWKgqHFeSGEhJME0W3wzBhAgAf9TXOt0VvttXVnkFSawr64adMdlTIeJpWLwo8w5pujtBg5TtwKKyObqtuo=
Received: from linaro.org ([62.231.97.49])
        by smtp.gmail.com with ESMTPSA id f1-20020aa7d841000000b00560cd4f3098sm450117eds.95.2024.02.07.01.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 01:08:07 -0800 (PST)
Date: Wed, 7 Feb 2024 11:08:05 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH RFC 1/2] spmi: Add support for multi-master
Message-ID: <ZcNIddeG6VHxBEOQ@linaro.org>
References: <20240207-spmi-multi-master-support-v1-0-ce57f301c7fd@linaro.org>
 <20240207-spmi-multi-master-support-v1-1-ce57f301c7fd@linaro.org>
 <CAA8EJpqsJmv36=o1aTjVH6eMHXMg8BHNpiDvs+Q8YB23ezVGtQ@mail.gmail.com>
 <ZcMvFtAwQQjAZhk6@linaro.org>
 <CAA8EJprqWLX7_yWZzKp3FAKFGkSkk041f9hj1uXuRBrbH5APyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJprqWLX7_yWZzKp3FAKFGkSkk041f9hj1uXuRBrbH5APyQ@mail.gmail.com>

On 24-02-07 09:23:09, Dmitry Baryshkov wrote:
> On Wed, 7 Feb 2024 at 09:19, Abel Vesa <abel.vesa@linaro.org> wrote:
> >
> > On 24-02-07 01:55:39, Dmitry Baryshkov wrote:
> > > On Wed, 7 Feb 2024 at 01:34, Abel Vesa <abel.vesa@linaro.org> wrote:
> > > >
> > > > Some newer SPMI controllers support multiple bus masters.
> > > > Such a master can control multiple slave devices. The generic
> > > > framework needs to be able to pass on the master id to the
> > > > controller-specific driver. So do that. The framework will
> > > > check if the devicetree child nodes are actually bus masters
> > > > and will register the devices for each master. The legacy
> > > > approach will still be supported for backwards compatibility.
> > >
> > > Please remind me, are those two actual bus musters driving a single
> > > bus in parallel or two SPMI buses being handled by a single device? In
> > > the latter case this implementation is incorrect. There should be
> > > multiple spmi_controller instances, one for each bus. Allocate them in
> > > a loop and set ctrl->dev.of_node after allocating.
> >
> > It's two SPMI buses (two sets of wires) handled by the same controller,
> > HW-wise.
> >
> > If we register two spmi controllers with the kernel framework, it will
> > be HW inaccurate, because there is just one controller which has
> > multiple masters.
> 
> struct spmi_controller is a controller for a single bus. Inside your
> device you have two SPMI buses, each can be controlled by its own
> struct spmi_controller. Just like devices that control multiple I2C,
> SPI or USB busses register a separate instance of the bus controller.

Well, this is what this patchset is trying to do in the generic part.
The SPMI controller supports multiple buses (HW-wise) and therefore SW
implementation shouldn't be tied to single bus requirement.

> 
> >
> > I'm not saying it might not work. But, to me, it looks more like a hack.
> >
> > Basically, we would be mapping HW bus masters to kernel controllers.
> 
> Buses, not just masters.
> 
> >
> > >
> > > >
> > > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > > ---
> > > >  drivers/spmi/spmi-mtk-pmif.c |  6 ++--
> > > >  drivers/spmi/spmi-pmic-arb.c | 10 +++---
> > > >  drivers/spmi/spmi.c          | 76 ++++++++++++++++++++++++++++++--------------
> > > >  include/linux/spmi.h         | 10 +++---
> > > >  4 files changed, 67 insertions(+), 35 deletions(-)
> > >
> > > --
> > > With best wishes
> > > Dmitry
> 
> 
> 
> -- 
> With best wishes
> Dmitry

