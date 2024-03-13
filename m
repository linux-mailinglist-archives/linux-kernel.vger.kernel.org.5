Return-Path: <linux-kernel+bounces-100960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3B887A01E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02A1D1F233C5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61611A20;
	Wed, 13 Mar 2024 00:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b="f9DdHUoU"
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16785182;
	Wed, 13 Mar 2024 00:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.156.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710289273; cv=none; b=fbSb20656YdZ3uAhXoKRYf8JtitZtuRapcxzWBcIw6CVX77t0BWyMGY3mMg3hEd3v4Pm84aRsV9BJ0cAr6yHqJK3klajnoZKDNcrgWOyLn53W+35TsQD8zTyrdADp+XOmujSRMYPbVUP+Ffs7hjsw3WnZ3ly8msgLq1N07TuMSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710289273; c=relaxed/simple;
	bh=h+oGPjpyxC+yBzEporjFKDQteq5fynJ48ffEoR1vIR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TTaj+JznHMZHxlS7ch4CAPdRRBH9Jtkj+BzXi1BdMrgmBBJbKdEWoRGL85uD1xX2c59csYhR8i4P7qncQk46C00cKX2BNvUv5MohtXj3hNNYdmGBFyXk/Pk4yJo3/K3ug4S+WtGcoHRWTdatvy0zJQPxgEPpLJ9whf0jfcD5j60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net; spf=pass smtp.mailfrom=bewilderbeest.net; dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b=f9DdHUoU; arc=none smtp.client-ip=71.19.156.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bewilderbeest.net
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:712b:6300::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: zev)
	by thorn.bewilderbeest.net (Postfix) with ESMTPSA id D3F332DE;
	Tue, 12 Mar 2024 17:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
	s=thorn; t=1710289271;
	bh=EY/zd3I+RDkhsnrVHS1RIaB8erXsoc+pY5+WBGfC1kg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f9DdHUoUtrWwcxgHL4/JdBEBFZ67mPjYGk9o05HF1yu0zdlS+3LN99ssYeNyYPP0D
	 6hRiHalXht50T7hyVNipc/S/P+wtzUBFciIctR2gYVf7WPaZFg+SUAlXhC08iddTTr
	 R/bW6yxuBVeNIpEAGHp+U3e37eeLd08dfSSGWqEc=
Date: Tue, 12 Mar 2024 17:21:09 -0700
From: Zev Weiss <zev@bewilderbeest.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Ban Feng <baneric926@gmail.com>, jdelvare@suse.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	corbet@lwn.net, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, kcfeng0@nuvoton.com, kwliu@nuvoton.com,
	openbmc@lists.ozlabs.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, DELPHINE_CHIU@wiwynn.com,
	naresh.solanki@9elements.com, billy_tsai@aspeedtech.com
Subject: Re: [PATCH v4 3/3] hwmon: Driver for Nuvoton NCT7363Y
Message-ID: <a93e2971-cafc-480b-b439-f42ed0838660@hatter.bewilderbeest.net>
References: <20240227005606.1107203-1-kcfeng0@nuvoton.com>
 <20240227005606.1107203-4-kcfeng0@nuvoton.com>
 <a90ed00c-f836-4fb6-8191-9974937e3eb7@hatter.bewilderbeest.net>
 <CALz278Zgfgob573vgWz4PgC7vb=i8xt3kC1hSjo_cQi00B0XAg@mail.gmail.com>
 <cd63bec7-01c6-466e-b772-3a3d3d90a7d5@hatter.bewilderbeest.net>
 <37e11daa-c24e-45b2-a22d-769693fd2038@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37e11daa-c24e-45b2-a22d-769693fd2038@roeck-us.net>

On Tue, Mar 12, 2024 at 04:58:12PM PDT, Guenter Roeck wrote:
>On 3/12/24 16:18, Zev Weiss wrote:
>>On Wed, Mar 06, 2024 at 11:35:31PM PST, Ban Feng wrote:
>>>Hi Zev,
>>>
>>>On Sat, Mar 2, 2024 at 4:19 PM Zev Weiss <zev@bewilderbeest.net> wrote:
>>>>
>>>>On Mon, Feb 26, 2024 at 04:56:06PM PST, baneric926@gmail.com wrote:
>>>>>From: Ban Feng <kcfeng0@nuvoton.com>
>>>>>
>>>>>NCT7363Y is an I2C based hardware monitoring chip from Nuvoton.
>>>>>
>>>>>Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>
>>>>>---
>>
>><snip>
>>
>>>>>+
>>>>>+static const struct of_device_id nct7363_of_match[] = {
>>>>>+      { .compatible = "nuvoton,nct7363" },
>>>>
>>>>As far as I can see from the code in this driver, it looks like this
>>>>driver should also be compatible with the nct7362; shall we add the ID
>>>>table entry for it now?  (Though I only have a datasheet for the
>>>>nct7362, not the nct7363, so I don't know exactly how they differ.)
>>>
>>>As far as I know, the difference between these two ICs is 0x2A~0x2C
>>>Fading LED for 7362, and 0x2A Watchdog Timer for 7363.
>>>In my v1 patch, I indeed add the nct7362 to the ID table, however,
>>>this makes it more complicated and our datasheet isn't public yet.
>>>I think maybe supporting more chips will be done in the future, but not now.
>>>
>>
>>If the only differences are in features the driver doesn't utilize, I'm not clear on how it adds any complexity.  As far as I'm aware, neither datasheet is public (NCT7363 nor NCT7362), so if we're going to have a public driver for one, why not also do so for the other?  It's a single additional line -- and furthermore, having made that change and tested it out, I can report that the driver seems to work just fine on NCT7362 hardware as well.
>>
>
>"if we're going to have a public driver for one, why not also do so for the other"
>
>If you are trying to say that there should be two separate drivers, sorry, that
>would be absolutely unacceptable.
>

Sorry if that was unclear -- it was very much *not* my intent to suggest 
adding a separate driver, merely that we make the nct7363 driver also 
support the nct7362.


Zev


