Return-Path: <linux-kernel+bounces-133596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F015789A61A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D4981C212A9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43111175554;
	Fri,  5 Apr 2024 21:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXY60WCp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7566C1C36;
	Fri,  5 Apr 2024 21:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712352733; cv=none; b=Yr5Ti2m5mGLO6bNzr1tUaMk/18R+2uXCDpcAG5UX9z8om3CDqJdnznLr+dmaCOaxZw2wGLJYN66a4MYOkpx3Ml2YdlgGA5ouQPZ/uLIxTVHEFyj61tVlbmLUdYQZG0FEkiMvg0ei7Ew/yM6s+3h4fk8w0mIxhJeP83TQU4PLy3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712352733; c=relaxed/simple;
	bh=hsZu3xdis3+8ixCZGH/UiCiP/10YCp3O3EdgM07+RyA=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=PVeAE156L+lhQzVjjITR/x2JBJJtVV0zQowt8suUuabdGn3qWNWaWeYYh/Y3q4Ijx4dXkICXdGUCvVbqfbzGzHD86UDSKYNNf+Uf4GuuD/MYTj0c+9drNBSz7UyHd6RcdSDOM196h6Ka4KNwyNUWa0l23/e44KD/Z5I+6Pfi34s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXY60WCp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF77BC433C7;
	Fri,  5 Apr 2024 21:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712352733;
	bh=hsZu3xdis3+8ixCZGH/UiCiP/10YCp3O3EdgM07+RyA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=nXY60WCpCpc/RzvaYPjvrFvMvHQbDTZNnhzFb453mtmnytCtmJqKr7OMPuFx2RkaY
	 YZPm3PQS3c+iv/LjzhXwmjJkvD6FwuvllQ5cFRB6yw5ntpjzalKCk1UHLBGS9y5IAz
	 fJwaO0PFjeSzseJ6zwpLwpejCO4p+NzKGX2b7ajGPbY00nB+hZGfr+XYQtKAuKbbMs
	 8gRiozxMEbfBiEn3iyoQt+MD75Slj9fRdl9H6EXH8NpfigZpRrGFbEmmED2GkYdUB6
	 69wXbIRtDXKlpeVsC4POG+V6xSJvQ6E44cvfihZoF+xQKVacdY9orwss1C4FIPcKDs
	 CrXMRI8X+/vrg==
Message-ID: <5a6c424fafd7ca1281f4bd771b8c8219.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <66968793-d0c9-9f31-6616-f67fdadcd6e5@quicinc.com>
References: <20240229-camcc-support-sm8150-v1-0-8c28c6c87990@quicinc.com> <20240229-camcc-support-sm8150-v1-4-8c28c6c87990@quicinc.com> <18567989-fb60-49ae-92e6-94e1bc2fa1c7@linaro.org> <66968793-d0c9-9f31-6616-f67fdadcd6e5@quicinc.com>
Subject: Re: [PATCH 4/5] clk: qcom: Add camera clock controller driver for SM8150
From: Stephen Boyd <sboyd@kernel.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Ajit Pandey <quic_ajipan@quicinc.com>, Imran Shaik <quic_imrashai@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>, Jagadeesh Kona <quic_jkona@quicinc.com>
To: Abhishek Sahu <absahu@codeaurora.org>, Bjorn Andersson <andersson@kernel.org>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, Satya Priya Kakitapalli (Temp) <quic_skakitap@quicinc.com>
Date: Fri, 05 Apr 2024 14:32:10 -0700
User-Agent: alot/0.10

Quoting Satya Priya Kakitapalli (Temp) (2024-04-04 23:27:29)
>=20
> On 3/2/2024 9:43 PM, Bryan O'Donoghue wrote:
> >
> > Alternatively switch on the always-on clocks before the really_probe() =

> > but then roll back in a probe_err: goto
> >
> > probe_err:
> > =C2=A0=C2=A0=C2=A0=C2=A0remap_bits_update(regmap, 0xc1e4, BIT(0), 0);
> > =C2=A0=C2=A0=C2=A0=C2=A0pm_runtime_put_sync(&pdev->dev);
> >
> > There may be corner cases where always-on has to happen before=20
> > really_probe() I suppose but as a general pattern the above should be=20
> > how we go.
> >
>=20
> I have rechecked this and see that this clock is PoR ON (i.e BIT(0) is=20
> set upon power ON) and it should be kept always ON as per HW=20
> recommendation. So even if the probe fails we shouldn't be clearing it=20
> against the hw recommendation. We are setting the bit here again to make =

> sure it is set when the driver probes.
>=20

Yes, always on clks should always be on. We don't turn them off if the
driver fails to probe. We should probably print a warning or something
if the register write fails, but since this is mmio it won't fail, so
just make sure they're on and move on.

