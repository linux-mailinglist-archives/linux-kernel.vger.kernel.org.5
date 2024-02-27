Return-Path: <linux-kernel+bounces-83400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3803686983D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E406D295093
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40142146015;
	Tue, 27 Feb 2024 14:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7zrkFUJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71992145FF9;
	Tue, 27 Feb 2024 14:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709044153; cv=none; b=rVviKp4YL8MBuVPdoTxRlRBkJO+K2DIQEBtZINDI93wCPe47XpNUJy72B5gtBLHFKvvQPUMy5+AZ271yjireVQ+k6NgLxV4mim+gG3ugpupXMGv2dBitPQnejkVZlCpeU0ditARn5QqfEdswc9fiyA16r3a+0HhraEt03taiybg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709044153; c=relaxed/simple;
	bh=BeuKeRmCI8fl+4Mky6qTDE0ESLxkqayEq8heDHUciIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1vlyfTIEhhDx+NrrCDLla3+KcSIeW5VgJ+zSrqzPy59to4T1+OihuRQOtessErjmQSq/yu9e4rcEz+jejfJRH3px4n2eOm35RDHK+qEhB4h4KBSSaNMtOoICN3Rq73ChOsyyAxwoFZx2/ielFfkbAf8VY8tEZbW6Sxmr5cj3bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7zrkFUJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB05C43390;
	Tue, 27 Feb 2024 14:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709044153;
	bh=BeuKeRmCI8fl+4Mky6qTDE0ESLxkqayEq8heDHUciIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e7zrkFUJjNkuT6ejQss+PGilg6MNPyI006Dx1xx8Zoe39qoMrNhJei7Ymxa34PjBb
	 XXEnchbRee8ptxfWLoZirWVOzrypkJuJN831n7y8aYviicaZZkbm+K+6LgaO8GRodf
	 axaBwr1hpp/O4zsmtbMqRFCMz0fc/Bskw7Pa1KxBm8uKJbKWG3qPPaTTAVv2M1bfVm
	 ZEc1BIqE6o2uzkwBPWVH3HjI46Kt9VBq12B5U+pPIDmsPZW7eVb2W4vmdytNSbU8P6
	 hTbFCfJ7AxhuU5WdnavbGLC8XrL90TYMhcDVVgjnjns8L6ETTmUknj8su/EcURMCGE
	 ia+RFHnjoLtnA==
Date: Tue, 27 Feb 2024 08:29:11 -0600
From: Rob Herring <robh@kernel.org>
To: =?utf-8?B?UGF3ZcWC?= Anikiel <panikiel@google.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, airlied@gmail.com,
	akpm@linux-foundation.org, conor+dt@kernel.org, daniel@ffwll.ch,
	dinguyen@kernel.org, hverkuil-cisco@xs4all.nl,
	krzysztof.kozlowski+dt@linaro.org,
	maarten.lankhorst@linux.intel.com, mchehab@kernel.org,
	mripard@kernel.org, tzimmermann@suse.de, devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, chromeos-krk-upstreaming@google.com,
	ribalda@chromium.org
Subject: Re: [PATCH v2 8/9] media: dt-bindings: Add Intel Displayport RX IP
Message-ID: <20240227142911.GB3863852-robh@kernel.org>
References: <20240221160215.484151-1-panikiel@google.com>
 <20240221160215.484151-9-panikiel@google.com>
 <13aeb2ff-72f4-49d9-b65e-ddc31569a936@linaro.org>
 <CAM5zL5q0oKoTMR0jSwYVAChCOJ9iKYPRFiU1vH4qDqhHALKz4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM5zL5q0oKoTMR0jSwYVAChCOJ9iKYPRFiU1vH4qDqhHALKz4w@mail.gmail.com>

On Mon, Feb 26, 2024 at 11:59:42AM +0100, Paweł Anikiel wrote:
> On Mon, Feb 26, 2024 at 10:13 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 21/02/2024 17:02, Paweł Anikiel wrote:
> > > The Intel Displayport RX IP is a part of the DisplayPort Intel FPGA IP
> > > Core. It implements a DisplayPort 1.4 receiver capable of HBR3 video
> > > capture and Multi-Stream Transport. The user guide can be found here:
> > >
> > > https://www.intel.com/programmable/technical-pdfs/683273.pdf
> > >
> > > Signed-off-by: Paweł Anikiel <panikiel@google.com>
> > > ---
> > >  .../devicetree/bindings/media/intel,dprx.yaml | 160 ++++++++++++++++++
> > >  1 file changed, 160 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/media/intel,dprx.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/media/intel,dprx.yaml b/Documentation/devicetree/bindings/media/intel,dprx.yaml
> > > new file mode 100644
> > > index 000000000000..31025f2d5dcd
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/media/intel,dprx.yaml
> > > @@ -0,0 +1,160 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/media/intel,dprx.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Intel DisplayPort RX IP
> > > +
> > > +maintainers:
> > > +  - Paweł Anikiel <panikiel@google.com>
> > > +
> > > +description: |
> > > +  The Intel Displayport RX IP is a part of the DisplayPort Intel FPGA IP
> > > +  Core. It implements a DisplayPort 1.4 receiver capable of HBR3 video
> > > +  capture and Multi-Stream Transport.
> > > +
> > > +  The IP features a large number of configuration parameters, found at:
> > > +  https://www.intel.com/content/www/us/en/docs/programmable/683273/23-3-20-0-1/sink-parameters.html
> > > +
> > > +  The following parameters have to be enabled:
> > > +    - Support DisplayPort sink
> > > +    - Enable GPU control
> > > +  The following parameters' values have to be set in the devicetree:
> > > +    - RX maximum link rate
> > > +    - Maximum lane count
> > > +    - Support MST
> > > +    - Max stream count (only if Support MST is enabled)
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: intel,dprx-20.0.1
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  intel,max-link-rate:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: Max link rate configuration parameter
> >
> > Please do not duplicate property name in description. It's useless.
> > Instead explain what is this responsible for.
> >
> > Why max-link-rate would differ for the same dprx-20.0.1? And why
> > standard properties cannot be used?
> >
> > Same for all questions below.
> 
> These four properties are the IP configuration parameters mentioned in
> the device description. When generating the IP core you can set these
> parameters, which could make them differ for the same dprx-20.0.1.
> They are documented in the user guide, for which I also put a link in
> the description. Is that enough? Or should I also document these
> parameters here?

Use the standard properties: link-frequencies and data-lanes. Those go 
under the port(s) because they are inheritly per logical link.

Rob

