Return-Path: <linux-kernel+bounces-120491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F2788D84A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 050C31C2653C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472272D622;
	Wed, 27 Mar 2024 07:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bky9xrGB"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BA34EB2C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 07:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711526292; cv=none; b=oK76D/1PR/dhnQ3DhMcgJo5WAR8VcjYaYq+xKAmE17rSLI5uLTyW7smuLTy7j/L57UbkuMO6bzsB3wsBgXUDF/h/XvUZMu35MMeCCPC9KwvIUKl7OhFNFIQT8/DDTaWfGlbvoy7KSKUT59AOfxikkwP9TtfLirWx1rPWvs6Y3fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711526292; c=relaxed/simple;
	bh=AdvzqVk7O5Om9zYVogxzKc5FzxJiG73Lmt6jW0x/4ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILtd5DI6Sl3LKtc5kf2Nhe4+0Fo4gho9hndcxW7kVfQY4lr08a4h7zmL6dy9I2/LOj8XXOu36KpG1y9HLXS8P06maSiWbgqteOYaYL/wr31xpvTYrNcKxXDpP1X754YXd2sFB1E5Zw7vgSR2QFJ4ESMIVbWrv0gxg6Py4wjs4TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bky9xrGB; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a4715d4c2cbso810903266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 00:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711526289; x=1712131089; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TDy5Illrx70H+5XvK63d5lpudD3g0VrV2VxsSwir7fI=;
        b=bky9xrGBNrfAkhg94g5H1u4pD7IqEDFi9mCnPvfnoXbHGRxw78DK3o1tBOpZuWBApd
         faaMRakLX79o71Vz8dzusuZ02cfxpMp4B7sGgmoJjvTxxu2XF6bQZma0gcU1EkyWhV0v
         IqB927ZYr+sz3ZTE7J+PnIQmKpDNiAUUeCqOzTWOwiQ305ZvbbnbgJtlT+D1OEuSKN5x
         IAgRzhWu/pEqFXPV6029rCr1ilkJp2s552UWlfmzDIQK89rZt9scULBjgqZtRY+3U6yQ
         D2U1cCjQgrRvwf+M6/5rqDI7MpPdG8n6HKViDz7h8fDo97mpOdFXHC28HRZQU/1NTmSt
         3VJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711526289; x=1712131089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDy5Illrx70H+5XvK63d5lpudD3g0VrV2VxsSwir7fI=;
        b=ennDNN17pbcLF0ggq6gLK9FykfDvDGrVkjaq3eaFtYhDUJ2zxPeqydJZBW1UutOASa
         GYFV09lT6qfr72II9AflhFCU+n1RlmipY+J3SAZlmVfXwfYI2LBBXI+/QmpP3jCZ4sQc
         5jDvbEEW4TfDUa69Oh1M2ROQUCz6kusmRo8jaCRH8djGU26NwHfftKs275YbdNdNcSAE
         U2A7NIrXalkN5qIVRkuhga6SIYJ9s/4xVHGQ2LySkML8t0roPpXTC+59TymdJ1MTolbA
         XCbEec2D5WTxz13Zr3UUrKvAeCPL4eZBa5XaDjwIu/xhQGccPdH8rPaPeox/QNqbPVvD
         WVoA==
X-Forwarded-Encrypted: i=1; AJvYcCVw/PFZtdBPknUzHqmuEe8wIr5RLpu2HBkZt3fNfGurLd4eccEstyphZF/pSmtqCMuX01zGHn2/uAFUFkE624rBaEWR3452koi7IniR
X-Gm-Message-State: AOJu0YxsIHJOEd5ZyM41m/P3ClWIrvbwhNYG626+ikebVURUl8FCgk+/
	LpPU7Up0VAu4MlVHX0tSXyIJ/kAKqNHIZj2b2/n4aQk6xfNfkL6+yAlyg47OrN8=
X-Google-Smtp-Source: AGHT+IGysvCehLKTeF+GjCKTXRvqk8xpwQLSopHP/oRxr76MQGD8YVIJzklfhmT5jk0MinBjuPZBbg==
X-Received: by 2002:a17:906:3c8:b0:a4d:fc15:4e36 with SMTP id c8-20020a17090603c800b00a4dfc154e36mr1365984eja.16.1711526288645;
        Wed, 27 Mar 2024 00:58:08 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id kz18-20020a17090777d200b00a46bdc6278csm5050261ejc.71.2024.03.27.00.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 00:58:08 -0700 (PDT)
Date: Wed, 27 Mar 2024 10:58:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [RFC PATCH 07/13] pinctrl: renesas: pinctrl-rzg2l: Validate
 power registers for SD and ETH
Message-ID: <a0d7e6f4-5f4d-4601-857a-c485cceffe3b@moroto.mountain>
References: <20240326222844.1422948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240326222844.1422948-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326222844.1422948-8-prabhakar.mahadev-lad.rj@bp.renesas.com>

On Tue, Mar 26, 2024 at 10:28:38PM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> On RZ/V2H(P) SoC, the power registers for SD and ETH do not exist,
> resulting in invalid register offsets. Ensure that the register offsets
> are valid before any read/write operations are performed. If the power
                                                            ^^^^^^^^^^^^
> registers are not available, both SD and ETH will be set to -EINVAL.
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Where does this happen?  It doesn't seem to be a part of this patchset.
-EINVAL seems weird here, but it's hard to judge without actually seeing
it.

regards,
dan carpenter


