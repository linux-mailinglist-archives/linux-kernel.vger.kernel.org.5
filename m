Return-Path: <linux-kernel+bounces-38600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E705283C2F9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28225B21391
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850744F605;
	Thu, 25 Jan 2024 13:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkT9D3PY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB87B3172D;
	Thu, 25 Jan 2024 13:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706187655; cv=none; b=RXLkE4/DlNF0HYaTEDzQCpN22U/Org+Zw0wL7ZPAQ2LuG5TRd7APh8WW9r++UUEqqc9EIl2p2CvVIvK6e9c4O/s6wNdMynBloJDtF6kXedV5KV8G/ALv+azbmohfPE1AcCXWpErR7B8mJbGkuGYNdv8uZ9ML4TGEevVa7qwLTic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706187655; c=relaxed/simple;
	bh=99bv9c9eHb4ZdXwaGxVfbOS63w2nNy5OFAbWyD1Bli4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mP8hWKUO82BAKmP5ZpIAjEgqD6Ufe/b7kPdSb4967WmlnZIJc5/sbkqXA4rMcBcrBAtQkDVR6ja3FVlvv0DBRJXm3xFJ1C06jJelTH9ZielrfUjrAMUetCnaQNY2fLef+3LD2+PRrNw5WTLwDvcLo+NnZFys6GW5c+J3hg16rAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkT9D3PY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34BD1C433F1;
	Thu, 25 Jan 2024 13:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706187655;
	bh=99bv9c9eHb4ZdXwaGxVfbOS63w2nNy5OFAbWyD1Bli4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PkT9D3PYND3pBYWrVLVUK+Re669pSmoPnHh6SkfDJ94KdzW1ClDWidO4RV1qWY4gD
	 aMCZ7y4XLz5fhiVt0VrT7p+U1cEp5eDWOiQ99oMH/5tn09q7Fa7ayWVVArwyqu0CCE
	 rsfuZqd4whgdal9xPYuy4xwrksrP8mlPq7aPCIbM4+3n0AECMUIyFfl9s7x7Kp011Y
	 UwpnPGacNkJisHrmsWDIW/coQ26S/TZj8PTUSNzg4wmmw+8oxBIJ1dtLXUzVpVymRI
	 XHjVAXIoPxDo3LzHXQN45t2TsF1aNqipwjKnKwDjlmwv3Yct4Mj/UG4xqO22EEh/t4
	 ivCzdQL+mKpsQ==
Date: Thu, 25 Jan 2024 13:00:49 +0000
From: Lee Jones <lee@kernel.org>
To: Martin Kurbanov <mmkurbanov@salutedevices.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	kernel@salutedevices.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/2] leds: aw200xx: support for hw pattern controllers
Message-ID: <20240125130049.GF74950@google.com>
References: <20231207125938.175119-1-mmkurbanov@salutedevices.com>
 <20231207125938.175119-2-mmkurbanov@salutedevices.com>
 <20231221161011.GO10102@google.com>
 <85c89859-ae03-4692-9c09-5779e4c40eae@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85c89859-ae03-4692-9c09-5779e4c40eae@salutedevices.com>

Looping in Jacek (LEDS) and Greg (SYFS) for some knowledgable input.

On Fri, 12 Jan 2024, Martin Kurbanov wrote:
> On 21.12.2023 19:10, Lee Jones wrote:
> > On Thu, 07 Dec 2023, Martin Kurbanov wrote:
> > 
> >> This led-controller supports 3 pattern controllers for auto breathing or
> >> group dimming control. Each pattern controller can work in auto
> >> breathing or manual control mode. All breathing parameters including
> >> rising/falling slope, on/off time, repeat times, min/max brightness
> >> and so on are configurable.
> >>
> >> Signed-off-by: Martin Kurbanov <mmkurbanov@salutedevices.com>
> >> ---
> >>  .../testing/sysfs-class-led-driver-aw200xx    | 108 +++
> >>  Documentation/leds/leds-aw200xx.rst           | 274 ++++++++
> >>  drivers/leds/leds-aw200xx.c                   | 649 ++++++++++++++++++
> >>  3 files changed, 1031 insertions(+)
> >>  create mode 100644 Documentation/leds/leds-aw200xx.rst
> > 
> > This interface is bananas.  Exposing an entire register interface to
> > sysfs does not sit will with me at all.  When we add support to a sysfs
> > class, we usually require it to be generic and work across all devices.
> > Adding device specific interfaces is generally decried and to be
> > avoided.  Don't forget, once we commit something to sysfs, it becomes
> > ABI and we have to support it forever.
> > 
> > A far better approach would be to add support for this in userspace
> > instead  You can use the standard I2C character device API to achieve
> > the same result.  That way we don't have the same level of commitment
> > and is generally a much more flexible/future-proof.
> > 
> 
> I used sysfs similarly to other LED drivers (for example, leds-lm3533).
> Additionally, the controller has interrupts about the completion of the pattern,
> which is best to handle in the kernel. In the case of implementation in user
> mode, there may be synchronization problems, as the controller has several
> memory pages that can be switched by writing the page number to register 0xF0.

leds-lm3533 is a 12 year old legacy exception AND has less than half of
the sysfs exports proposed here.  What makes aw200xx so different it
needs to an incomparable interface to any other that we currently
support?

-- 
Lee Jones [李琼斯]

