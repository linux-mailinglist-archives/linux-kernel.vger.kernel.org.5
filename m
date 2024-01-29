Return-Path: <linux-kernel+bounces-42829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF7D840762
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7756E1F26A33
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA79D657BD;
	Mon, 29 Jan 2024 13:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xLt8otU/"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC273657A9
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 13:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706536077; cv=none; b=Rro9aQXTqcdYYw8LaKJG99h2hazpXMmnbWYJSrQGyOqkXVM9UXGH+9ymuGK3ydGFn9QDGkvGkR99I2njRsPiUnU6kQsKwzLEVy/tjKmRSpfczhUOlP/TUfeMJyJVHQb/UV6yLKKP6MOUgKMtAf1ANp+BblfaBevaI9eW65L9E8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706536077; c=relaxed/simple;
	bh=21jznJn2yyDb6oC/magzEzz9zV3F+RCWlsRUoVdYgTA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D/4mDT3h2jnOE6EHnnzqyD/sSVCb+cs7HggifMblLSS4q1/yvMOf3j6KNZSQ5ABJ7zoSvRiCtdCUmNt8kxbSUXbMJ+y4THNMzoM9fzo1EbZukVy7QWmvo7+7I8gJQzOCM/lVAkbITSGvhBe3V0uGgqx0ehoCfW/D1d4nC6loERE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xLt8otU/; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40ef6da20feso5417735e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 05:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706536072; x=1707140872; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=byhnXqD/Gkvhb9bjZRgQdgbOondAaOF5MjikPjTLXrc=;
        b=xLt8otU/sk3R2wcsfa0GTVQlpr2h5oCA3g11Ji2RX7yVMZ+Jy2LeC6AGiF9dS/Hqd2
         ZlZLkF4Qj2f1R1zbe/7pgMhZ5m5lAAH10Jw/6Lo04ooBUsBjDEgnnKvJO/nhY8hOF5+I
         T/8SCE3GQlpR5ssnq6udr8Rts3+8HZDhGONVzkS11fZglpO+BMfQGdKEShX7DbxeqD5E
         FgaY4LHXeyORAgGhI4NsGnIEFiI8ToBPghPQtW8n6qSODEBy2ws1uiVYWtzOVXQC6WjD
         VWyWGY+Qxh0Xct3TAlxklVlCGy16hFrEDsvsQPHepVKBdKGxHVjaOFECmNpVWoq79ILW
         25pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706536072; x=1707140872;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=byhnXqD/Gkvhb9bjZRgQdgbOondAaOF5MjikPjTLXrc=;
        b=JkFqClwTQrX0T9nkDu5wovGaEkPJYsBdDkMuA6OCaFu5ZfywqM0tXN9FKFFUCuZHfu
         Pr4ZqVuGhcp5QsDKwVRtVs7PP3/WFpSqSlRmewjLATLBXQk0dW+l8Bk5GKw/lU2raVCq
         mlXmLtdsCEe9R0X3kfleUu60lB0BRRiNurGpbI/YD/SlDb+/DnrxlFyDILJcslX/3n/k
         yyrwGR5cwn8J96eQWFaDD/a3n0QKDlGYJs53dbgyrILwO2WMfXL15L2VXzC1naiuIFF2
         0eA3DJBfqYoEL34zezHvOw9GVwpN6XLV+iTEFLWD+Xu4010E4VqgtsbbWhueeiYe+YL3
         /4GQ==
X-Gm-Message-State: AOJu0YyUa+WmzygbK6bLoW5/P7k+34Lz5fu5yxw9cHiHCmIes3u4c/cS
	2yjFFjZHLap0i/i2rz7/pGZdcmKWFgK+JpMHAJ6E2wQgb52lom3o1CplNDpDnSQ=
X-Google-Smtp-Source: AGHT+IGqogLrgYhcgplVsYkT3hYqcyoHgLEBbbw8STFX++f8EIwc2vbsjJ9GItKiK5AqTowVfrMSCQ==
X-Received: by 2002:a05:600c:1c26:b0:40e:e8e3:40c2 with SMTP id j38-20020a05600c1c2600b0040ee8e340c2mr4715714wms.12.1706536072116;
        Mon, 29 Jan 2024 05:47:52 -0800 (PST)
Received: from [10.1.1.109] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600c314d00b0040efb445698sm1340224wmo.5.2024.01.29.05.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 05:47:51 -0800 (PST)
Message-ID: <7d42f80acf7c8bd3882f5ac253a761c71de2034c.camel@linaro.org>
Subject: Re: [PATCH 9/9] clk: samsung: gs101: don't CLK_IGNORE_UNUSED
 peric1_sysreg clock
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	peter.griffin@linaro.org, mturquette@baylibre.com, sboyd@kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
 tudor.ambarus@linaro.org, willmcvicker@google.com,
 semen.protsenko@linaro.org,  alim.akhtar@samsung.com,
 s.nawrocki@samsung.com, tomasz.figa@gmail.com,  cw00.choi@samsung.com,
 linux-arm-kernel@lists.infradead.org,  linux-samsung-soc@vger.kernel.org,
 linux-clk@vger.kernel.org,  devicetree@vger.kernel.org
Date: Mon, 29 Jan 2024 13:47:49 +0000
In-Reply-To: <74b63fd9-bf7a-4a88-bfa9-a975a4f12bca@linaro.org>
References: <20240127001926.495769-1-andre.draszik@linaro.org>
	 <20240127001926.495769-10-andre.draszik@linaro.org>
	 <74b63fd9-bf7a-4a88-bfa9-a975a4f12bca@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi=C2=A0Krzysztof,

On Mon, 2024-01-29 at 12:03 +0100, Krzysztof Kozlowski wrote:
> On 27/01/2024 01:19, Andr=C3=A9 Draszik wrote:
> > Now that we have hooked it up in the DTS, we can drop the
>=20
> Your driver patch cannot depend on DTS. Not for a new platform. I am
> repeating this all the time last days...
>=20
> > CLK_IGNORE_UNUSED from here.
> >=20
> > Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> > ---
> > =C2=A0drivers/clk/samsung/clk-gs101.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/clk/samsung/clk-gs101.c b/drivers/clk/samsung/clk-=
gs101.c
> > index 7f6c3b52d9ff..d55ed64d0e29 100644
> > --- a/drivers/clk/samsung/clk-gs101.c
> > +++ b/drivers/clk/samsung/clk-gs101.c
> > @@ -3393,7 +3393,7 @@ static const struct samsung_gate_clock peric1_gat=
e_clks[] __initconst =3D {
> > =C2=A0	GATE(CLK_GOUT_PERIC1_SYSREG_PERIC1_PCLK,
> > =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0 "gout_peric1_sysreg_peric1_pclk", "mout=
_peric1_bus_user",
> > =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0 CLK_CON_GAT_GOUT_BLK_PERIC1_UID_SYSREG_=
PERIC1_IPCLKPORT_PCLK,
> > -	=C2=A0=C2=A0=C2=A0=C2=A0 21, CLK_IGNORE_UNUSED, 0),
>=20
> I don't understand. You just added this clock in this patchset. This
> means that your patch #3 is incorrect.

In patch #3 I'm hooking up all the clocks to Linux. If I don't CLK_IGNORE_U=
NUSED
for the 'sysreg' pclk in patch #3, then it'll hang on loading drivers that
require sysreg access (because Linux disabled the clock).

I can not change patch #8 to come between 2 and 3 either, because at that s=
tage
neither the clock nor the DT node reference &cmu_peric1 actually exist, and=
 the
clock and can't be claimed by sysreg.

Since we can not mix DT and driver changes in the same commit, I can not me=
rge
patches #3 and #4 and #8 either.

I had to do it this way so that the platform always boots for every commit =
to keep
things bisectable.

Alternatively, I could merge patches #4 and #8 (but that seems wrong to me)=
, or
drop patches #7, #8 and #9 from this series and apply it later in the -rc p=
hase?


Is there a better way that you have in mind that we're missing, that keeps =
things
atomic and bootable/bisectable?=20


Cheers,
Andre'


