Return-Path: <linux-kernel+bounces-126789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80949893CBB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B04DC1C20F55
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0490F47772;
	Mon,  1 Apr 2024 15:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksV+VYSS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A5245974;
	Mon,  1 Apr 2024 15:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711984669; cv=none; b=Dr8TmlO86Nm32w0gbk5Y3O8DxJHog/qkkA/gNTBsbkSlu7h/XPahPvXsPwLyxNk0wnMONl4urQGEzKExtp9s2niTUXMqrjoLSP0KyAlS69DCeQN44L8HNwM0dCqWrVJUzy/gJ2VMfeeqH772JzOtNk1tpXFBczWEGqCV10WDN2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711984669; c=relaxed/simple;
	bh=D83Xak9nDvDD3y92G9E1UTwi43wAfnHrgeFCBth+9FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPBgzzihj9WQKHgobj4u3m8nvkz+DO2SY81Sz5xv0FJO243AkV0cDh+L1mFFk2l+22hd490P65Fm/cf+Vetv+VUupW3szWfaWvunDc3uL381ZXgdKbK4k06Pkz3/mksRah73BVX/k1Z1QuIcLGMWZnfz8iPbwlHggtwSyYmqXoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksV+VYSS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFC5C43390;
	Mon,  1 Apr 2024 15:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711984668;
	bh=D83Xak9nDvDD3y92G9E1UTwi43wAfnHrgeFCBth+9FY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ksV+VYSSXoXl39VJxMGapaLZJkt6ZsDvghxomF3OSk27xh9MkLI185twPxL1qUAkU
	 RPVmlnXqaosJ6gXGBgfYSltYg9bweNT8ClWyeGJWTP++3zsKwwtAQO3tqS+Ae/LJeI
	 AgojRiW+gidp/gADBEoAFf75qmctwtMscZ1dJBoNXLfv9x8dyurEFbHTdQfRw84S3b
	 oXvf8YoCq8bNPkkcZrHYxRw+hPHdASdT2SVut9AFLKRPPj6T6OIQ4/zRn2+qmz7dqd
	 FqwMkeNz5JXlp1R88xIMrJvnJhYFUfN2h/MCZZBqQexInU8MHuOn1PYMOyK8Ev5M6X
	 TeVy2S8aYXKAw==
Date: Mon, 1 Apr 2024 10:17:46 -0500
From: Rob Herring <robh@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: krzysztof.kozlowski+dt@linaro.org, linux@roeck-us.net,
	devicetree@vger.kernel.org, wim@linux-watchdog.org,
	linux-input@vger.kernel.org, dmitry.torokhov@gmail.com,
	linux-rtc@vger.kernel.org, lee@kernel.org, conor+dt@kernel.org,
	linux-watchdog@vger.kernel.org, sre@kernel.org,
	linux-kernel@vger.kernel.org, alexandre.belloni@bootlin.com
Subject: Re: [PATCH v3] dt-bindings: mfd: twl: Convert trivial subdevices to
 json-schema
Message-ID: <171198466420.742996.8175303890554994940.robh@kernel.org>
References: <20240401081831.456828-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401081831.456828-1-andreas@kemnade.info>


On Mon, 01 Apr 2024 10:18:31 +0200, Andreas Kemnade wrote:
> Convert subdevices with just an interrupt and compatbile to
> json-schema and wire up already converted subdevices.
> RTC is available in all variants, so allow it unconditionally.
> GPADC binding for TWL603X uses two different compatibles, so
> specify just the compatible and do not include it.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Changes in v3:
> - added Ack
>   (apparantly many recipients did not receive the V2 patch,
>    so there is a need for a resend)
> 
> Changes in v2:
> - style cleanup
> - absolute paths
> - unevalutedProperties instead of additionalProperties
>   due to not accepting things in if: clauses without it
> 
>  .../bindings/input/twl4030-pwrbutton.txt      | 21 ------
>  .../devicetree/bindings/mfd/ti,twl.yaml       | 72 ++++++++++++++++++-
>  .../devicetree/bindings/rtc/twl-rtc.txt       | 11 ---
>  .../bindings/watchdog/twl4030-wdt.txt         | 10 ---
>  4 files changed, 71 insertions(+), 43 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt
>  delete mode 100644 Documentation/devicetree/bindings/rtc/twl-rtc.txt
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/twl4030-wdt.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>


