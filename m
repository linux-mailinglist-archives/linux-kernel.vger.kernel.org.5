Return-Path: <linux-kernel+bounces-12503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF3E81F5CE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 08:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C02131C21BD2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 07:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379CE53B4;
	Thu, 28 Dec 2023 07:58:55 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159665232;
	Thu, 28 Dec 2023 07:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(636813:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Thu, 28 Dec 2023 15:58:24 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.27; Thu, 28 Dec
 2023 15:58:24 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1258.27 via Frontend
 Transport; Thu, 28 Dec 2023 15:58:24 +0800
Date: Thu, 28 Dec 2023 15:58:24 +0800
From: ChiYuan Huang <cy_huang@richtek.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Jonathan Cameron <jic23@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Uwe
 =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: rtq6056: add support for the
 whole RTQ6056 family
Message-ID: <20231228075824.GA16067@linuxcarl2.richtek.com>
References: <1703562468-29052-1-git-send-email-cy_huang@richtek.com>
 <1703562468-29052-2-git-send-email-cy_huang@richtek.com>
 <9715ed9d-7edf-430c-808c-00e7748bc59a@linaro.org>
 <20231226111921.GA22684@linuxcarl2.richtek.com>
 <0f1f0991-9ad9-4216-afc8-8340eddb1ad9@linaro.org>
 <20231228031929.GA32046@linuxcarl2.richtek.com>
 <e1036e63-1914-4412-8c55-40ae206d56d0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e1036e63-1914-4412-8c55-40ae206d56d0@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Dec 28, 2023 at 08:09:35AM +0100, Krzysztof Kozlowski wrote:
> On 28/12/2023 04:19, ChiYuan Huang wrote:
> > On Tue, Dec 26, 2023 at 01:12:50PM +0100, Krzysztof Kozlowski wrote:
> >> On 26/12/2023 12:19, ChiYuan Huang wrote:
> >>> On Tue, Dec 26, 2023 at 10:18:47AM +0100, Krzysztof Kozlowski wrote:
> >>>> On 26/12/2023 04:47, cy_huang@richtek.com wrote:
> >>>>> From: ChiYuan Huang <cy_huang@richtek.com>
> >>>>>
> >>>>> Add compatible support for RTQ6053 and RTQ6059.
> >>>>>
> >>>>> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> >>>>> ---
> >>>>>  .../devicetree/bindings/iio/adc/richtek,rtq6056.yaml         | 5 ++++-
> >>>>>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml b/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml
> >>>>> index 88e008629ea8..d1e1f36d1972 100644
> >>>>> --- a/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml
> >>>>> +++ b/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml
> >>>>> @@ -25,7 +25,10 @@ description: |
> >>>>>  
> >>>>>  properties:
> >>>>>    compatible:
> >>>>> -    const: richtek,rtq6056
> >>>>> +    enum:
> >>>>> +      - richtek,rtq6053
> >>>>> +      - richtek,rtq6056
> >>>>
> >>>> Aren't these devices compatible? Your driver change says they are, so
> >>>> express compatibility with list here (and oneOf).
> >>>>
> >>> Thanks, I try to take other binding as the reference. One more question.
> >>> If rtq6053 is compatible with rtq6056, there's only chip package type difference.
> >>> Do I need to seperate it into a dedicated enum element?
> >>> Or just put it into one item and said this part number is compatible with rtq6056? 
> >>
> >> See example-schema. You need enum and items, both in oneOf:.
> >>
> > After reading the 'example-schema', I Still cannot understand what the special case items
> > means.
> 
> What is "special case items"?
> 
I may misunderstand something. The special case is the 'fallback' that you mentaioned in
the last.
> > 
> > But in my case, is the below change correct?
> > [Diff]
> > properties:
> >    compatible:
> > -    enum:
> > -      - richtek,rtq6053
> > -      - richtek,rtq6056
> > -      - richtek,rtq6059
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - richtek,rtq6053
> > +              - richtek,rtq6056
> > +              - richtek,rtq6059
> 
> This changes nothing, you still have just one item. The example-schema
> has exactly that case, so why you are coding it differently?
> 
> Anyway, test your DTS with the fallback, you will see that above does
> not work.
> 
I rewrite the below one and tested. it seems correct.

[Diff]
   compatible:
-    enum:
-      - richtek,rtq6053
-      - richtek,rtq6056
-      - richtek,rtq6059
+    oneOf:
+      - enum:
+          - richtek,rtq6053
+          - richtek,rtq6059
+      - items:
+          - const: richtek,rtq6056

Just one more question. If rtq6053 is fully compatibie with rtq6056, does it need to be put
into oneOf enum or be just put into items enum and use the 'fallback' mechanism?

If so, the 'richtek,rtq6053' in of_device_id match can be removed. Though it just remove
one line, but less-changed would be better.

ChiYuan.
Best regards,
> Krzysztof
> 

