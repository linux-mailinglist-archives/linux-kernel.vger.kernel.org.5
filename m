Return-Path: <linux-kernel+bounces-30517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 502FD831FC4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06480283653
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5822E410;
	Thu, 18 Jan 2024 19:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="G8nzFqbl";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="M2IhRQzu"
Received: from mailrelay2-1.pub.mailoutpod2-cph3.one.com (mailrelay2-1.pub.mailoutpod2-cph3.one.com [46.30.211.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200C22E403
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 19:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705606315; cv=none; b=XDGwGMt9/uhwUSyMLd86ytLzFHeIewhekzm+Inlk2YdFVh8ha4ZaalawtxaUkBEZspkBingY3hV08UVB3b2tIrHXC4dcobsv+lOF0Fkhuj+KLkfFLUpsl0PL3KGE7yGy6/fG+l5JGK4y9v0wuyecwQFa+Nuw3eVrQZ3l27MENeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705606315; c=relaxed/simple;
	bh=vVVnzqY+EY0SOiGfdFNXM65FWvxpPLAtME59q4uRfeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTE7x4iDVNJsBrMFB+TSMwTfwTh5q/lexjKul+ZoyJCt1DgQDOaLdCkAmrTm6ox0z+KRRQ44G+mIXzZwsh8DBB1lYK1MUthzyLfcLokzgi3fV1U530xIP82accz+eMAeee+VKoWO3d4Qs9KiuFwe0B75oOm71eFWPVjB4aRe/uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=G8nzFqbl; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=M2IhRQzu; arc=none smtp.client-ip=46.30.211.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
X-HalOne-ID: 11cb3bcc-b638-11ee-b2ba-b520e3c7e1da
Received: from mailrelay5.pub.mailoutpod3-cph3.one.com (unknown [104.37.34.42])
	by mailrelay2.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPS
	id 11cb3bcc-b638-11ee-b2ba-b520e3c7e1da;
	Thu, 18 Jan 2024 19:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=BWvtIZzeIG8OQ9lhdg7O1Ah8L08MbdZeVVuTjMHxWYY=;
	b=G8nzFqblNhH5mYOI6VDQG/LovZIk7vAPPrdqS6byoV1ORZvE6we8m/wbGOq5EsHZ/SHcjQ9DA9H/c
	 jKsF0sVymxb+vKwY6eZOrYfA4WcQexqXmw2Pjn8aUzEXH7XSMnEksFwZNo2exOJI863AVpN+zEYacy
	 554O5ixTJXSRsh4A0c9Jz5lfs96bhgykZsS0YPGOVevF4wegBryTiFoa8j0rg+Z0BzpuVbdeZye1tV
	 2qG4Gjq5AXWSJ6A6dacB7ByKwKdhFcNreuUKu2ykJSeB3DbQ9F2+bJ9ju9stO1gYDI3IH/VR/WLJ16
	 dBl1+msMY1omwZxActJHL1PsFxpKqnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=BWvtIZzeIG8OQ9lhdg7O1Ah8L08MbdZeVVuTjMHxWYY=;
	b=M2IhRQzuVcfPvogIfXlOznEYNzckT9lZDdlcuSr1btDeg4DaqaHqJGGheQ4gFS7G0lQl80XLqCEdw
	 hyDFgxHAA==
X-HalOne-ID: 0fb75f5f-b638-11ee-a200-9fce02cdf4bb
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay5.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 0fb75f5f-b638-11ee-a200-9fce02cdf4bb;
	Thu, 18 Jan 2024 19:30:42 +0000 (UTC)
Date: Thu, 18 Jan 2024 20:30:40 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: conor.dooley@microchip.com, bbrezillon@kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	lee@kernel.org, thierry.reding@gmail.com,
	u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
	linux4microchip@microchip.com
Subject: Re: [PATCH v3 0/3] Convert Microchip's HLCDC Text based DT bindings
 to JSON schema
Message-ID: <20240118193040.GA223383@ravnborg.org>
References: <20240118092612.117491-1-dharma.b@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118092612.117491-1-dharma.b@microchip.com>

Hi Dharma et al.

On Thu, Jan 18, 2024 at 02:56:09PM +0530, Dharma Balasubiramani wrote:
> Converted the text bindings to YAML and validated them individually using following commands
> 
> $ make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/
> $ make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/
> 
> changelogs are available in respective patches.
> 
> Dharma Balasubiramani (3):
>   dt-bindings: display: convert Atmel's HLCDC to DT schema
>   dt-bindings: atmel,hlcdc: convert pwm bindings to json-schema
>   dt-bindings: mfd: atmel,hlcdc: Convert to DT schema format

I know this is a bit late to ask - sorry in advance.

The binding describes the single IP block as a multi functional device,
but it is a single IP block that includes the display controller and a
simple pwm that can be used for contrast or backlight.

If we ignore the fact that the current drivers for hlcdc uses an mfd
abstraction, is this then the optimal way to describe the HW?


In one of my stale git tree I converted atmel lcdc to DT, and here
I used:

+  "#pwm-cells":
+    description:
+      This PWM chip use the default 3 cells bindings
+      defined in ../../pwm/pwm.yaml.
+    const: 3
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    maxItems: 2
+    items:
+      - const: lcdc_clk
+      - const: hclk

This proved to be a simple way to describe the HW.

To make the DT binding backward compatible you likely need to add a few
compatible that otherwise would have been left out - but that should do
the trick.

The current atmel hlcdc driver that is split in three is IMO an
over-engineering, and the driver could benefit merging it all in one.
And the binding should not prevent this.

	Sam

