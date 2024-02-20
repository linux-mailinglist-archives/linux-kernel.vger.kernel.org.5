Return-Path: <linux-kernel+bounces-73389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FE185C1D6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDC541C23F02
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268747641C;
	Tue, 20 Feb 2024 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="FUQQWI2G"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C513876419;
	Tue, 20 Feb 2024 16:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708448028; cv=none; b=fLQ/HUcB/j3XqthXNnX71KD+Hg5EAvA1VIW8iNqH5P68dJuh+/7obwiUhZJLpTT3fw01F2Xjt3M3KS5wcpP/vxC9Uvtdectvp8PgGtO0z/In9KzgUBpD2Wq9TgZWlvQ1HrlJxtbpXfGBw0NWKlSBQ4GzFAC/adCJodK2Ben8hzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708448028; c=relaxed/simple;
	bh=z4JWuWnGXxtj1e13X8/078DUzc51WgJgv/eBSFm2h68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nLT26YcJ2MWBOODrFZAd6gTcJJVo93sNJMloIy4lBASzUDaO0t1v29SRo1/haWktIw5h57OkA6vTe+aVQn8c35vmy5Pxb2XGH4o6mIV5qYHJVNng1TlSzH11jVTBxFU+Fw0Ir8VBDeDiU6gEnDHWHaiP/qNwxoxGoG/0RiUkx7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=FUQQWI2G; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1708447414; bh=z4JWuWnGXxtj1e13X8/078DUzc51WgJgv/eBSFm2h68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FUQQWI2GUEfDPYh40q++n2IQFf5euFWbZYd/sMkhbd4YMtnzo+/j3Tv2v8HPdgYeB
	 pOvSFLFvC6DOlZhTl26ZZi+xGX1fMErCGsPfrzxU1U50TvZi96MmlDWOlUyoVL+JfC
	 uRCRDnSxr6Mzj9O/IFyIi2arF2v2wX92NXY3+6jU=
From: Luca Weiss <luca@z3ntu.xyz>
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Helge Deller <deller@gmx.de>, Andrew Morton <akpm@linux-foundation.org>,
 "G.Shark Jeong" <gshark.jeong@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maximilian Weigand <mweigand@mweigand.net>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject:
 Re: [PATCH 3/4] backlight: lm3630a: Use backlight_get_brightness helper in
 update_status
Date: Tue, 20 Feb 2024 17:43:32 +0100
Message-ID: <5027630.31r3eYUQgx@g550jk>
In-Reply-To: <20240220141107.GF6716@aspen.lan>
References:
 <20240220-lm3630a-fixups-v1-0-9ca62f7e4a33@z3ntu.xyz>
 <20240220-lm3630a-fixups-v1-3-9ca62f7e4a33@z3ntu.xyz>
 <20240220141107.GF6716@aspen.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 20. Februar 2024 15:11:07 CET Daniel Thompson wrote:
> On Tue, Feb 20, 2024 at 12:11:21AM +0100, Luca Weiss wrote:
> > As per documentation "drivers are expected to use this function in their
> > update_status() operation to get the brightness value.".
> >
> > With this we can also drop the manual backlight_is_blank() handling
> > since backlight_get_brightness() is already handling this correctly.
> >
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> 
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> However...
> 
> > ---
> >  	/* disable sleep */
> > @@ -201,9 +202,9 @@ static int lm3630a_bank_a_update_status(struct backlight_device *bl)
> >  		goto out_i2c_err;
> >  	usleep_range(1000, 2000);
> >  	/* minimum brightness is 0x04 */
> > -	ret = lm3630a_write(pchip, REG_BRT_A, bl->props.brightness);
> > +	ret = lm3630a_write(pchip, REG_BRT_A, brightness);
> 
> ... then handling of the minimum brightness looks weird in this driver.
> 
> The range of the backlight is 0..max_brightness. Sadly the drivers
> are inconsistant regarding whether zero means off or just minimum,
> however three certainly isn't supposed to mean off! In other words the
> offsetting should be handled by driver rather than hoping userspace has
> some magic LM3630A mode.

I could also try and fix that..

1. Treat 1..4 as 4, so have backlight on at that minimum level? Probably
wouldn't be noticable that brightness 1=2=3=4. And the backlight will be
on compared to off as it is now.

2. Decrease max_brightness by 4 values, so probably 0..251 and shift the
values up in the driver so we get 4..255?

Or would you have some other idea here?

Regards
Luca

> 
> You didn't introduce this so this patch still has my R-b ...
> 
> 
> Daniel.
> 





