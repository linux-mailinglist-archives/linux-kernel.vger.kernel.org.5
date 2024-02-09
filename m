Return-Path: <linux-kernel+bounces-58942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC3A84EEF3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 124901F2884C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 02:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8261865;
	Fri,  9 Feb 2024 02:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owD9rfwg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D5D5240;
	Fri,  9 Feb 2024 02:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707446492; cv=none; b=XJwXJbkKmbuv5U558CBIxFkmc8Ed87mL89dwCe8k6IatuBt/ht9AdA3rGHl42ruPqNHCnci4JCamsnY5q4J+4I81h8OV+T7tyjXvZH1Fby3xb0sbeUaxZu7Go/CQu3D/bdNblRYXeWGtaRz4YRpA/0XAkN1Ne8sbDscwmbmH58o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707446492; c=relaxed/simple;
	bh=KduIljUwZruXs5Atd9wNqwJ+XlIM/aqqIrk3ACjew9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMscjdt5vCI1fS7q2mk3FaNawXn42DkLA6qK4ZjnVkS7WBF+TJlFZTmBQlAjDWNvCuYEZuE28BYj0P6R61VKsOEitZjcwDDQnRJwkGsJVtn/9jJkoaA/qcyqkeB5l1SVpTG+e/mT2W3JhAEYMh1PPdXx5HaAGpFZPg5280Q6RVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owD9rfwg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4EC9C433F1;
	Fri,  9 Feb 2024 02:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707446491;
	bh=KduIljUwZruXs5Atd9wNqwJ+XlIM/aqqIrk3ACjew9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=owD9rfwgk1qz70BVKbn4z4t0epilxumg8tgN5yrDwER2s7KU9H3XazUdy2JWaJeDY
	 mzQij3z1xNC453CqKVhm18mbi8UFTWmeWn1B6kErNjkGHlaOHAo6BG3Mvoc5gQ4Xve
	 OrQcvT7rNhCvG4iH74INxb6Vv/RVBDr8Yv3H8N3kxkZbTyNvQFWSUBnSYVj7UncgIq
	 H4bXWSTgIq/lQbStAnZKCLwpylJF+EeEU+YmB0zTp9Ti3503KackegoIooxqjvhxzd
	 mNvd2lnTyWRSjQRHGUpVdu5RTACuzLAH3/RA9/KlvhEHCv+XKXo1VyYF98R3w4UW8e
	 WZPGXXkKfnYUg==
Date: Thu, 8 Feb 2024 20:41:28 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, quic_ppratap@quicinc.com, 
	quic_jackp@quicinc.com
Subject: Re: Re: [PATCH 2/3] arm64: dts: qcom: sa8295p: Enable tertiary
 controller and its 4 USB ports
Message-ID: <ofunpypiiyyhbn5dtrotaluyf3bq7rfj5gwbrku4ibw2dqh4dt@6sxsks33yw5b>
References: <20240206114745.1388491-1-quic_kriskura@quicinc.com>
 <20240206114745.1388491-3-quic_kriskura@quicinc.com>
 <CAA8EJpoed-hu4hPXAcwQxmJAaNRwJ2y5q9qybWaPP8bdMnz_oA@mail.gmail.com>
 <0470a930-d629-4467-b619-58d3e76f59a7@quicinc.com>
 <CAA8EJppJAdHXoVs_2VqQf=_Wk_LoEcNMY2H-Xzqu8KzeaN8i0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJppJAdHXoVs_2VqQf=_Wk_LoEcNMY2H-Xzqu8KzeaN8i0g@mail.gmail.com>

On Tue, Feb 06, 2024 at 03:24:45PM +0200, Dmitry Baryshkov wrote:
> On Tue, 6 Feb 2024 at 14:28, Krishna Kurapati PSSNV
> <quic_kriskura@quicinc.com> wrote:
> >
> >
> >
> > On 2/6/2024 5:43 PM, Dmitry Baryshkov wrote:
> > > On Tue, 6 Feb 2024 at 14:03, Krishna Kurapati <quic_kriskura@quicinc.com> wrote:
> > >>
> > >> Enable tertiary controller for SA8295P (based on SC8280XP).
> > >> Add pinctrl support for usb ports to provide VBUS to connected peripherals.
> > >
> > > These are not just pinctrl entries. They hide VBUS regulators. Please
> > > implement them properly as corresponding vbus regulators.
> > >
> >
> > Hi Dmitry. Apologies, can you elaborate on your comment. I thought this
> > implementation was fine as Konrad reviewed it in v13 [1]. I removed his
> > RB tag as I made one change of dropping "_state" in labels.
> 
> My comment is pretty simple: if I'm not mistaken, your DT doesn't
> reflect your hardware design.
> You have actual VBUS regulators driven by these GPIO pins. Is this correct?
> If so, you should describe them properly in the device tree rather
> than describing them just as USB host's pinctrl state.
> 

This is correct, these gpios are wired to the enable-pin of a set of
regulators providing the VBUS voltage. Please, Krishna, represent them
as always-on fixed-regulators instead.

Regards,
Bjorn

