Return-Path: <linux-kernel+bounces-27582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6FA82F27A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2707F285A65
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4201CAA2;
	Tue, 16 Jan 2024 16:37:19 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280541CA92;
	Tue, 16 Jan 2024 16:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TDvkK568dz6K5nX;
	Wed, 17 Jan 2024 00:35:05 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id F24F01408FF;
	Wed, 17 Jan 2024 00:37:14 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 16 Jan
 2024 16:37:14 +0000
Date: Tue, 16 Jan 2024 16:37:13 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Petar Stoykov <pd.pstoykov@gmail.com>, <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Angel Iglesias
	<ang.iglesiasg@gmail.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: iio: pressure: Add Sensirion SDP500
Message-ID: <20240116163713.00006bf3@Huawei.com>
In-Reply-To: <4eab426b-f654-4e10-9ffa-5b34016565fb@linaro.org>
References: <CADFWO8EomrhEgtC+i9ikkcDU1c05kx-8kjrS4usAv-TRKxif+w@mail.gmail.com>
	<4eab426b-f654-4e10-9ffa-5b34016565fb@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 16 Jan 2024 16:31:55 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 16/01/2024 16:24, Petar Stoykov wrote:
> > Sensirion SDP500 is a digital differential pressure sensor. It provides
> > a digital I2C output. Add devicetree bindings requiring the compatible
> > string and I2C slave address (reg).
> > 
> > Signed-off-by: Petar Stoykov <pd.pstoykov@gmail.com>
> > ---
> >  .../bindings/iio/pressure/sdp500.yaml         | 38 +++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/pressure/sdp500.yaml  
> 
> Filename like compatible.
> 
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/pressure/sdp500.yaml
> > b/Documentation/devicetree/bindings/iio/pressure/sdp500.yaml
> > new file mode 100644
> > index 000000000000..af01ec7e3802
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/pressure/sdp500.yaml
> > @@ -0,0 +1,38 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/pressure/sdp500.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: sdp500/sdp510 pressure sensor with I2C bus interface
> > +
> > +maintainers:
> > +  - Petar Stoykov <pd.pstoykov@gmail.com>
> > +
> > +description: |  
> 
> Do not need '|' unless you need to preserve formatting.
> 
> > +  Pressure sensor from Sensirion with I2C bus interface.
> > +  There is no software difference between sdp500 and sdp510.
> > +
> > +properties:
> > +  compatible:
> > +    const: sensirion,sdp500
> > +  
> 
> No resources? No interrupts? No power supply or any pins? No even
> iio-cells? This looks incomplete.

For a pressure sensors, io-channel-cells (which I guess you me you
mean) would be a new thing. We've never yet had a consumer of this
data type...  Not necessarily a bad thing to have as one can
conceive of one, but none of the current pressure sensor bindings
have that.

vdd-supply though definitely wants to be in here and required
given device is unlikely to work without power!

Jonathan


> 
> > +  reg:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c3 {  
> 
> i2c {
> 
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +      sdp500@40 {  
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 
> 
> 
> Best regards,
> Krzysztof
> 
> 


