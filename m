Return-Path: <linux-kernel+bounces-143756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 403D08A3D0F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 16:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 001EB1F21A0F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 14:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2C345038;
	Sat, 13 Apr 2024 14:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6GyervT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834A41F94C;
	Sat, 13 Apr 2024 14:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713020108; cv=none; b=atMWM0s2BwX8ZkXNt8bcn/9B+1w1qfE99SOw9RakaHUi7vTo3ubXMdjj9uX/RvFK3sN8BYQGYXv5eJcaUNSUxTUuRkefmymEFzmtzLtjR/5bqaaRKnabZoBepH/JVlxaME/j9m6pFYa/1bpdySV4uayJKhRnQH2PSLfYuFOAXAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713020108; c=relaxed/simple;
	bh=rRDKKaeTAiGHTGq3L0Kf8LX+mIwIGdchgWI7zKiN+fU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jzFpqeQ9AI0nx1sh70p1PcXqD3S/6aiLlrTBnpgbnhBvjN3rIN3XnAd2kH6xOAePyYp1qK7EqhbqltJW9sudd+ET1/sa/xUPXixc7wK07VCPlRKWxcFgUdesvYXN3rDSrvSEat2O0mh+ufRFDxUVopCDeQWNhTaFi1uhgKY5ObY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6GyervT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE372C113CE;
	Sat, 13 Apr 2024 14:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713020107;
	bh=rRDKKaeTAiGHTGq3L0Kf8LX+mIwIGdchgWI7zKiN+fU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c6GyervTMBZPf4K9enlbb3ujhuUhFr8CbPpFP5IG8s49Lb5kQEfxMU3nwVVI8Xc5Q
	 OGulkKFFzM8iIOnEfx4XVFq5UpaW4hkxr3CGI+AoxoTZZ9/psYb085dQHS0LfyEiuK
	 GxReY0fZdOrStkeUyUKJiKyw71ZK8A7DpCf8nYg9ajgOIs+R9CzqMRxqE5XOLNU5/N
	 ijiRYK7JR53vqw79jIKtr2Qy0RKmTVWnGQKCFgG3HoLuVbhCXOHZaaTrFvW6Lfe0L5
	 7bgQldEynp0nUvWlDu47spDBFgiBD1bHkW4Poc7PQGGx+j4nNWW1zMYRMoD4ptzt9s
	 UuHqhUjmMC3Wg==
Date: Sat, 13 Apr 2024 15:54:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Kim Seer Paller <kimseer.paller@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, David Lechner <dlechner@baylibre.com>, Michael
 Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH 1/4] dt-bindings: iio: dac: Add adi,ltc2664.yaml
Message-ID: <20240413155451.65bd32ad@jic23-huawei>
In-Reply-To: <34de2d9b-c62e-4f18-806c-560ba4474237@linaro.org>
References: <20240412032102.136071-1-kimseer.paller@analog.com>
	<20240412032102.136071-2-kimseer.paller@analog.com>
	<34de2d9b-c62e-4f18-806c-560ba4474237@linaro.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Apr 2024 07:50:17 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 12/04/2024 05:20, Kim Seer Paller wrote:
> > Add documentation for ltc2664 and ltc2672.
> > 
> > Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
> > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> > Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> > ---
> >  .../bindings/iio/dac/adi,ltc2664.yaml         | 230 ++++++++++++++++++
> >  MAINTAINERS                                   |   8 +
> >  2 files changed, 238 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
> > new file mode 100644
> > index 000000000..2f581a9e5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
> > @@ -0,0 +1,230 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/dac/adi,ltc2664.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices LTC2664 and LTC2672 DAC
> > +
> > +maintainers:
> > +  - Michael Hennerich <michael.hennerich@analog.com>
> > +  - Kim Seer Paller <kimseer.paller@analog.com>
> > +
> > +description: |
> > +  Analog Devices LTC2664 4 channel, 16 bit, +-10V DAC
> > +  Analog Devices LTC2672 5 channel, 16 bit, 300mA DAC
> > +  https://www.analog.com/media/en/technical-documentation/data-sheets/ltc2664.pdf
> > +  https://www.analog.com/media/en/technical-documentation/data-sheets/ltc2672.pdf
> > +
> > +$defs:
> > +  toggle-operation:
> > +    type: object
> > +    description: Toggle mode channel setting.
> > +
> > +    properties:
> > +      reg:
> > +        description: Channel number.
> > +        minimum: 0
> > +        maximum: 4
> > +
> > +      adi,toggle-mode:
> > +        description:
> > +          Set the channel as a toggle enabled channel. Toggle operation enables
> > +          fast switching of a DAC output between two different DAC codes without
> > +          any SPI transaction.
> > +        type: boolean
> > +
> > +patternProperties:
> > +  "^channel@[0-4]$":
> > +    type: object  
> 
> patternProps go after properties.  You miss additionalProperties: false
> and actual properties defined in top-level part of the binding.
> 
> I wouldn't call your schema easiest to read. You have two quite
> different devices.

I agree entirely. I think it might be simpler to have 2 bindings.
If you haven't already tried that give it a go.

Note that we can have 2 bindings that in Linux are handled by one
driver (examples already exist max1363 and max1238 IIRC) as well as
the other way around where we have one binding and 2 drivers.

Jonathan

