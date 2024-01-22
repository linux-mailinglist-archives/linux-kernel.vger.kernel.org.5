Return-Path: <linux-kernel+bounces-33118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FBD8364EC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2760288CEB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB9E3D38D;
	Mon, 22 Jan 2024 14:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="X5ymU93y"
Received: from sender4-op-o10.zoho.com (sender4-op-o10.zoho.com [136.143.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A7B3D387;
	Mon, 22 Jan 2024 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705932116; cv=pass; b=IncB+2NPWjxZxr/aZYLcMqRsx6YkxQ2kqSI+Q4tLb9gR2yKTzevDzAsH/BKKsunefZXPmHLTbCKo3pdK/TBA6rwCOt+HPDXTQGc3SPLlGkVU6IgIcN3hNcelwbUUu0B2q+l3yDcn86U0gZkEuEdgzPCIUr4oDczJdKEk/qlom+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705932116; c=relaxed/simple;
	bh=3P4BMngYNQYmpkmanLDJHK2BGUcfCcvD9w0ldcpJDOQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NEdKtZtD1vwtKuGkF733z7c9OQpxqQ3kwMBkpotll0VVBMDz2IUuMQ6gKB6q/Mn+GgEr2A0kUa/rM2f1EMjG6b60q6kgkw/LmFoKYYoV95cEV9fVHnRtxkaIghx6EUXzMTc2pyq381vwhuttUjLG4nntxX2II1Nq2MvV+qvan+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=X5ymU93y; arc=pass smtp.client-ip=136.143.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
Delivered-To: i@rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1705932108; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EjBX89v8+XTfQKy4AOInpUo5jkiU01AJIZqIom9eDQwtkbN5aIyd/PkmZuMResgoMYM+ftoSTthGMTIVjQfy5K+OUxJ9bSctXa/XS06QbG2jAMlatIhYkgvw0SBhDWM8d/GqVW8oOK7eZlq1g9Pa4LHGYWG4ygaRSjAcxhJLej0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1705932108; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3P4BMngYNQYmpkmanLDJHK2BGUcfCcvD9w0ldcpJDOQ=; 
	b=gfFo5qrcQ9CyFK/aLazXTuHti3cI9m/cmZ44rJFJRB/ebDDSc0SkniLUzhBTpA/GOv2dILAUlyWUqQ1Ozr+FPx146+DO8e/S9BZrxf9/66rMoz75Is0eyjkxLXbvswTqTkKxOVkma0QnTeqaWQuVsv8MuqbdVKzFVneVnuerAqw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1705932108;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=3P4BMngYNQYmpkmanLDJHK2BGUcfCcvD9w0ldcpJDOQ=;
	b=X5ymU93yUSBiCdsefw0CPQrWrVe2Ss1H11d+crkt/DAh5Yeaqq/weUfoFQ0hc2v5
	haRXL+NZIPZjeVHGi2uAcmPb99OIc6PqvqIRC6/hq2KuX0B3A2dyfbIQyNPQYJA6GII
	xk1+J93D/q59qO8xjNtfAZYasLbpJFDFq4M/oJ8FtgrvhMVQhfqacqbccNbPZTjDc4N
	FtW6/nYcfqzvAF2b0fUCXqJq6q7mIugklGMVv2G6ReAjH5XNCPXLaAX6YaYlgoXrzwW
	KEmHLVSR7DvEEFJ2G44cwY01FZsNAtGfSuubUE4k1uI1Cj1d45nCy6pkmgPCoc9RBPH
	bUhQzL+LLw==
Received: from edelgard.fodlan.icenowy.me (120.85.96.220 [120.85.96.220]) by mx.zohomail.com
	with SMTPS id 170593210725155.73038714373831; Mon, 22 Jan 2024 06:01:47 -0800 (PST)
Message-ID: <c633b856c9eb20288e8bc20539692083af3127ea.camel@icenowy.me>
Subject: Re: [PATCH 4/4] ARM: dts: qcom: msm8974: Add device tree for
 Samsung Galaxy S5 China
From: Icenowy Zheng <uwu@icenowy.me>
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Rong Zhang <i@rong.moe>, Bjorn
 Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 22 Jan 2024 22:01:41 +0800
In-Reply-To: <1635b0e5-df47-4918-be83-edc27c59d8cf@linaro.org>
References: <20240121154010.168440-1-i@rong.moe>
	 <20240121154010.168440-5-i@rong.moe>
	 <1635b0e5-df47-4918-be83-edc27c59d8cf@linaro.org>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

=E5=9C=A8 2024-01-22=E6=98=9F=E6=9C=9F=E4=B8=80=E7=9A=84 11:50 +0100=EF=BC=
=8CKonrad Dybcio=E5=86=99=E9=81=93=EF=BC=9A
> On 21.01.2024 16:39, Rong Zhang wrote:
> > This device has little difference compared to Samsung Galaxy S5
> > (klte),
> > so the device tree is based on qcom-msm8974pro-samsung-klte.dts.
> > The
> > only difference is the gpio pins of i2c_led_gpio. With pins
> > corrected,
> > the LEDs and WiFi are able to work properly.
> >=20
> > Signed-off-by: Rong Zhang <i@rong.moe>
> > ---
>=20
> Looks like you didn't change the brcm,board-type though?

This should be intentional to allow kltechn and klte to share Wi-Fi
NVRAM file.

>=20
> [...]
>=20
> > +++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-kltechn.dts
> > @@ -0,0 +1,16 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include "qcom-msm8974pro-samsung-klte.dts"
>=20
> It's customary not to include .dts files, instead split the common
> parts
> into e.g. qcom-msm8974pro-samsung-klte-common.dtsi and include this
> in
> both the existing and the new one.
>=20
> Konrad


