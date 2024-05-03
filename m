Return-Path: <linux-kernel+bounces-167311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 041C18BA798
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CE6CB2190A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96251146D57;
	Fri,  3 May 2024 07:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvkKNcli"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65C3146A75;
	Fri,  3 May 2024 07:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714720835; cv=none; b=M4Te7n16GX8PBayLJK9vT/A9U9g/VfSLeC9iNh7wNYtp691fKHYdkoMMhg6zLwDi3dzPGE36buJKFCj9qmHeaiVAcOK69cWEeVmLhX2WJNfBEgLvTtVBvxCDN7KrfkSGJNErqIMvdGneWbP9oIE0/gnDuwWuoLyKP6gw0ghXy8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714720835; c=relaxed/simple;
	bh=VkrDitXNDbDsw/xs7zAS2Pp+s+d1L4Fx/47JCMT3yB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJO3pU/hx/P+oIBAXqzXb4eyCaGnAJgByctxNhv9Zbeqo2fhkOTbdOIBUhKQa7aOIHYhBRpUDB20ox6YFxcCqSYBZcXXEkUg8aqNpea0Qm+J9b+/O0yA7AaZ3NzJhEcMUZtowcorCzu3dGt1jILbBuJVTTysUcjFGKtAGLBYsUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvkKNcli; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED49EC116B1;
	Fri,  3 May 2024 07:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714720835;
	bh=VkrDitXNDbDsw/xs7zAS2Pp+s+d1L4Fx/47JCMT3yB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WvkKNcliEjYuU4LXhmSwZwR3iuV5RTxhcMEMoO0JvQiVHxFWyt2vWld4+KNhln3ty
	 uOQ4icLZZuFlmveAhP4Xg1ssN+W5j48rwyOOrG5pO7IGMg2+INJ61ZA4/AVIpaPO31
	 wNv9gwWAksnFrAo66L4F3QVmLJn+Oe0SQJ1lc2WLXsILhZ4dZVGYh8bmbV2GJsq0Jd
	 8sCD7xBbc6j979qAPX2MVkMhL5PC4gRmKv/YQkkp+IcBgfI/omjtqBSQJJCHI3sMVf
	 eGrsUpAXaw8BlzOVgEkkYgxDJS+U1igZtyxE3mTG8mkE3qh3x+/El3xuoPNcF1Dt/O
	 Q7jVPhcHImPfg==
Date: Fri, 3 May 2024 08:20:29 +0100
From: Lee Jones <lee@kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>
Cc: Pavel Machek <pavel@ucw.cz>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] leds: sy7802: Add support for Silergy SY7802
 flash LED controller
Message-ID: <20240503072029.GE1227636@google.com>
References: <20240401-sy7802-v2-0-1138190a7448@apitzsch.eu>
 <20240401-sy7802-v2-2-1138190a7448@apitzsch.eu>
 <20240411124855.GJ1980182@google.com>
 <c5e5f49295350ada2cdb280a77b1c877058d4d64.camel@apitzsch.eu>
 <20240502091017.GF5338@google.com>
 <9bb6ef63e19bf079fd881a3b78b71d7a00e4a3bb.camel@apitzsch.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9bb6ef63e19bf079fd881a3b78b71d7a00e4a3bb.camel@apitzsch.eu>

On Thu, 02 May 2024, André Apitzsch wrote:

> Am Donnerstag, dem 02.05.2024 um 10:10 +0100 schrieb Lee Jones:
> > On Wed, 01 May 2024, André Apitzsch wrote:
> > 
> > > > > +		ret = -EBUSY;
> > > > > +		goto unlock;
> > > > > +	}
> > > > > +
> > > > > +	if (level)
> > > > > +		curr = chip->fled_torch_used | BIT(led-
> > > > > >led_no);
> > > > > +	else
> > > > > +		curr = chip->fled_torch_used & ~BIT(led-
> > > > > >led_no);
> > > > > +
> > > > > +	if (curr)
> > > > > +		val |= SY7802_MODE_TORCH;
> > > > > +
> > > > > +	/* Torch needs to be disabled first to apply new
> > > > > brightness */
> > > > 
> > > > "Disable touch to apply brightness"
> > > > 
> > > > > +	ret = regmap_update_bits(chip->regmap,
> > > > > SY7802_REG_ENABLE,
> > > > > SY7802_MODE_MASK,
> > > > > +				 SY7802_MODE_OFF);
> > > > > +	if (ret)
> > > > > +		goto unlock;
> > > > > +
> > > > > +	mask = led->led_no == SY7802_LED_JOINT ?
> > > > > SY7802_TORCH_CURRENT_MASK_ALL :
> > > > 
> > > > Why not just use led->led_no in place of mask?
> > > 
> > > I might be missing something, but I don't know how to use led-
> > > >led_no
> > > in place of mask, when
> > > led->led_no is in {0,1,2} and
> > > mask is in {0x07, 0x38, 0x3f}.
> > 
> > This doesn't make much sense.
> > 
> > I guess you mean that led_no is a u8 and mask is a u32.
> > 
> > What happens if you cast led_no to u32 in the call to
> > regmap_update_bits()?
> 
> Sorry, I'm still confused. Could you elaborate your original question?

Replied where there is still context.

-- 
Lee Jones [李琼斯]

