Return-Path: <linux-kernel+bounces-91952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE03B8718EC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 738F41F2394C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A3651C5F;
	Tue,  5 Mar 2024 09:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uza/fbAK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5F64F897;
	Tue,  5 Mar 2024 09:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629476; cv=none; b=t2QeYxh5mgnrn5+Jm9fKXGRuhNAxJhmv/AowwKX7I9dCMHNo9mNt2Ku6f4nuV87myGc4kWFj10Je7bCIRWStL0rQJUr57selaLhQBAi+IYImQMC0e0QTnLNPfdAg9qDBq/UEdnMP4m6DsQXVfr3DKcwND2w1mz+k9ZiGnDQiWxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629476; c=relaxed/simple;
	bh=7N8xIeprPgoxERgGFCpdp1nknqUERpb0vZx8jiEzfgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncrww3tZz0SF+ZeEqHSxcjT+jh+GfPQQPfc9H4qD5ctnzW8eqNFM/kugaQDSWUVee3N8MxewC/VdLonXMsn+IOAAqLWQll+8s3/G743lBQFj7u3SjaH2nj6ZOvr8zbX1J6wBy71qeUEKi/5kV4pmOU88o0+nvl0UUdZhdr2+nVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uza/fbAK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C3EC433C7;
	Tue,  5 Mar 2024 09:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709629475;
	bh=7N8xIeprPgoxERgGFCpdp1nknqUERpb0vZx8jiEzfgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uza/fbAKpCubQp8iG3HBv+LL8E3D/7aueYJ+iTIJG6tiVEJmzBvrqhY+9771y6ipv
	 B+pmMhjWf1hoBTzgtDqAQ76ALA/VSHK0ntL9eQODNYiBu+xwH9rt49wrnP4/eaOykG
	 q92SYEGgQAbRd35X4Nx5pZeZwX5pWrnsOJwfRTVoBLLdzSjGh7b4AKQDcRTiSOoT7w
	 sPhQA/LeK78Xfid+BO3WoMnRYlk6FZLaGez7m68sT9mJ+dfEBT8p41HcN8GOY165vB
	 XJcwudR1eIJnA0VrOGc/o6Vt7+qwvpQU6saiZ1nrUO4J2HUVgRM1cnPk2/FDxBB/88
	 dQo+a/y58+pDw==
Date: Tue, 5 Mar 2024 09:04:29 +0000
From: Lee Jones <lee@kernel.org>
To: Abdel Alkuor <alkuor@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alice Chen <alice_chen@richtek.com>,
	Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
	ChiYuan Huang <cy_huang@richtek.com>,
	ChiaEn Wu <chiaen_wu@richtek.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	=?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] leds: Add NCP5623 multi-led driver
Message-ID: <20240305090429.GA5206@google.com>
References: <20240217230956.630522-1-alkuor@gmail.com>
 <20240217230956.630522-2-alkuor@gmail.com>
 <20240301085046.GE1209090@google.com>
 <ZeaRpSrkeFKAXIlq@abdel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZeaRpSrkeFKAXIlq@abdel>

On Mon, 04 Mar 2024, Abdel Alkuor wrote:

> On Fri, Mar 01, 2024 at 08:50:46AM +0000, Lee Jones wrote:
> 
> Hi Lee,
> > > +#define NCP5623_REG(x)			((x) << 0x5)
> > 
> > What's 0x5?  Probably worth defining.
> This is a function offset. I'll add a define.
> 
> > 
> > > +	guard(mutex)(&ncp->lock);
> > 
> > Are these self-unlocking?
> Correct. Here is a short introduction about it
> https://www.marcusfolkesson.se/blog/mutex-guards-in-the-linux-kernel/

Neat.

> > > +	ncp->old_brightness = brightness;
> > 
> > The nomenclature is confusing here.
> > 
> > For the most part, this will carry the present value, no?
> >
> Yes, I'll change it to current_brightness instead

Just 'brightness' will be fine.

> > > +	ret = ncp5623_write(ncp->client,
> > > +			    NCP5623_DIMMING_TIME_REG, pattern[0].delta_t / 8);
> > 
> > Why 8?  Magic numbers should be replaced with #defines.
> > 
> This is dim step in ms. I'll add a define for it.
> 
> > > +static int ncp5623_pattern_clear(struct led_classdev *led_cdev)
> > > +{
> > > +	return 0;
> > > +}
> > 
> > Not sure I see the point in this.
> > 
> > Is the .pattern_clear() compulsorily?
> >
> Unfortunately, it is. For example, in pattern_trig_store_patterns, when
> hw pattern is used, it is expected to have pattern_clear implemented.
> 
> static ssize_t pattern_trig_store_patterns(struct led_classdev *led_cdev,
>                                             const char *buf, const u32 *buf_int,
>                                             size_t count, bool hw_pattern)
> {
> 	...
>          if (data->is_hw_pattern)
>                  led_cdev->pattern_clear(led_cdev);
>  	...
> }

Something's not right then.  If this is required, are you sure you're
not meant to do something here?  If there are times when this is not
required, it should be possible to omit it.

-- 
Lee Jones [李琼斯]

