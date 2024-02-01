Return-Path: <linux-kernel+bounces-47935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB9E8454D2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADA762836CE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1417315B111;
	Thu,  1 Feb 2024 10:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHRqrwND"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471994D9F4;
	Thu,  1 Feb 2024 10:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706781946; cv=none; b=HnMksamZ1CRCqDpDzDQXBgNxu8yGj9fWM9zwvbP8Eo1aJeVp5SYIIuRQb5wgLPYU8vYdHOQrvMdn+GmDl9jm81Llo5gdZtesNAIi6QI17CLE9wHGbTn5b9+ZXMEU6l4qaFaJGWhHI903zO77tYotfvtfAPZjJa3lH70Vq/CSFIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706781946; c=relaxed/simple;
	bh=OCNyn/+xthVB/CqbVTIbZppBhTX2tBQqtngKgAF+EVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOf1hpwJ053AzfOCEPH9HpI4l4JXGqec/QttNkcmDt1p2/N+/As/EpOHE5cfDxcQ+co63NjrR/MUzuZNErEp1IM/3vNzciUi7K9erqfUNLGXzgGuHD7RawJEwv5maFOTVkCXUIDQhZFbFxpwlRM3E5GgHTuh7wXl8svggf/KM8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHRqrwND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF129C43390;
	Thu,  1 Feb 2024 10:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706781945;
	bh=OCNyn/+xthVB/CqbVTIbZppBhTX2tBQqtngKgAF+EVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bHRqrwNDCBUSpevdR2oKRzmtqXY9LZ2Vt8YhL/C46k/Aittq0sbfuP7a4DJPlD9ib
	 Sw+UYpgXUOwQty/m4/V8pLakfQPwCdTiOUEBtqLeVVITg4p0dkgz+fyRCRoJWg8ekE
	 cT7PjUWI/BAmuP+1LMcYY3l5oWeNOdWyDYQVW5lFSuBHcsRdWSyzM2tUo/VQn2pn+/
	 VpVGqyAsDRDm+t2d18ZXTCFyg9oQGxHLxOhJoOtiPAmNj9ZW9OxJbEGW15j+EN6ap0
	 uBIgtieGe6HDPKDDHHeyGsTUnyIgSIPnoDOTncfC2EO7YhnfGQ9YRA6PINUg8zoomP
	 J9wgwubT3oFOg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rVTx5-000000006DY-09wo;
	Thu, 01 Feb 2024 11:05:47 +0100
Date: Thu, 1 Feb 2024 11:05:47 +0100
From: Johan Hovold <johan@kernel.org>
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Jiri Kosina <jikos@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: HID: i2c-hid: Document reset-related
 properties
Message-ID: <Zbts-9tRDPcXbhYi@hovoldconsulting.com>
References: <20240131-x13s-touchscreen-v4-0-39c0f9925d3c@quicinc.com>
 <20240131-x13s-touchscreen-v4-1-39c0f9925d3c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131-x13s-touchscreen-v4-1-39c0f9925d3c@quicinc.com>

On Wed, Jan 31, 2024 at 07:07:26PM -0800, Bjorn Andersson wrote:
> Some I2C HID devices has a reset pin and requires that some specified
> time elapses after this reset pin is deasserted, before communication
> with the device is attempted.
> 
> The Linux implementation is looking for these in the "reset-gpios" and
> "post-reset-deassert-delay-ms" properties already, so use these property
> names.
> 
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  Documentation/devicetree/bindings/input/hid-over-i2c.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/hid-over-i2c.yaml b/Documentation/devicetree/bindings/input/hid-over-i2c.yaml
> index 138caad96a29..f07ff4cb3d26 100644
> --- a/Documentation/devicetree/bindings/input/hid-over-i2c.yaml
> +++ b/Documentation/devicetree/bindings/input/hid-over-i2c.yaml
> @@ -50,6 +50,12 @@ properties:
>      description: Time required by the device after enabling its regulators
>        or powering it on, before it is ready for communication.
>  
> +  post-reset-deassert-delay-ms:
> +    description: Time required by the device after reset has been deasserted,
> +      before it is ready for communication.

I know that Rob reluctantly acked this, but re-reading the commit
message for the commit that added support for the reset gpio to the
driver, and added a comment about this not having been added to the
devicetree binding, it becomes obvious that the latter was done on
purpose and that we probably should not be adding the
'post-reset-deassert-delay-ms' property after all:

	For now the new "post-reset-deassert-delay-ms" property is only
	used on x86/ACPI (non devicetree) devs. IOW it is not used in
	actual devicetree files and the same goes for the reset GPIO.
	The devicetree-bindings maintainers have requested properties
	like these to not be added to the devicetree-bindings, so the
	new property + GPIO are deliberately not added to the existing
	devicetree-bindings.

	2be404486c05 ("HID: i2c-hid-of: Add reset GPIO support to i2c-hid-of")

So perhaps we should just do this properly and add a new compatible
property for X13s touchscreen which can be used to determine these
delays (e.g. for cases where some default values are insufficient).

Johan

