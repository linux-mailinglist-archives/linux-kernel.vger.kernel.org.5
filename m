Return-Path: <linux-kernel+bounces-11573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C759281E85A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 17:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E6A21C21F63
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 16:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC184F60C;
	Tue, 26 Dec 2023 16:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nh0tXZa9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81B44F5EF;
	Tue, 26 Dec 2023 16:24:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D974FC433C7;
	Tue, 26 Dec 2023 16:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703607898;
	bh=hhRnMsLC6POZSHAl85RZB1z8ggwSk2IZQuSs9Nv91wo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Nh0tXZa9pRyyE0rrGnldxUdlb5vATvUO7jMHbwBujWEaNKdKZNikUVC0dZlsr+pPY
	 mPywS9y79fHNRl6m4YYI1O7y7mkDCRTcJZ/+WIil1KLmTQyqDxTWErmEbaRkA45wUf
	 7sLvgC/RlQ/QvZWEzoknzObUQ7ex+i1riCoB5gpQ/Yi9lZfx8MMXPTL1L9EPVaShVq
	 Hq9uCCWomru5wzJH66LOwx+xu8Y0v90qJ8zE6EmiDqVEaOq6jXh42IABWnUL1W4fdx
	 M9gnt/SBmsKYpFD4mSbFlo2GaXtbC2MOiVuSJunJ/Qa/lFTh2QUC9jZgSGWXx5YvMs
	 1dChYEy4+FU3A==
Date: Tue, 26 Dec 2023 16:24:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: cy_huang@richtek.com, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: rtq6056: add support for the
 whole RTQ6056 family
Message-ID: <20231226162450.5437810a@jic23-huawei>
In-Reply-To: <9715ed9d-7edf-430c-808c-00e7748bc59a@linaro.org>
References: <1703562468-29052-1-git-send-email-cy_huang@richtek.com>
	<1703562468-29052-2-git-send-email-cy_huang@richtek.com>
	<9715ed9d-7edf-430c-808c-00e7748bc59a@linaro.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Dec 2023 10:18:47 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 26/12/2023 04:47, cy_huang@richtek.com wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> > 
> > Add compatible support for RTQ6053 and RTQ6059.
> > 
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> >  .../devicetree/bindings/iio/adc/richtek,rtq6056.yaml         | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml b/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml
> > index 88e008629ea8..d1e1f36d1972 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml
> > @@ -25,7 +25,10 @@ description: |
> >  
> >  properties:
> >    compatible:
> > -    const: richtek,rtq6056
> > +    enum:
> > +      - richtek,rtq6053
> > +      - richtek,rtq6056  
> 
> Aren't these devices compatible? Your driver change says they are, so
> express compatibility with list here (and oneOf).

I'm not seeing this thread on lore.kernel.org or in my local email. 
Perhaps something went wrong?

Jonathan


> 
> 
> Best regards,
> Krzysztof
> 


