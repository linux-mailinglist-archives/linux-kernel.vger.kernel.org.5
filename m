Return-Path: <linux-kernel+bounces-123069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DF08901B8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 228F21C22D31
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E34127B67;
	Thu, 28 Mar 2024 14:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="oMB4Ha4F"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0687E775;
	Thu, 28 Mar 2024 14:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711636154; cv=none; b=V5G5P4SQQnhwXJdaFmGPmhrTn+ZVHluq+33W+asxmhysDrGtWH51G9sqqPVxgKXoHfoOyKLGGlVLOyJ0AE/juUraSdCaoCsjILKcG5lEl6GasSiGHhD+EjCZZkQPQwxeemBs/2eP+QN/nrwPbhLHBX+6bXNdn7J01TGfUGH+fJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711636154; c=relaxed/simple;
	bh=RgIsN2+9YTTR8Ah5iuVZwz4NadsK+VqbP0f38xQ2Pe4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3B+wQ6Can2tLtiFmKMwAnpEdcp/P0ZZtw4t3Sh8yG337awVERJzXboLTqv5l7GnSVMr59uBQS4umedm+pBRn0Vf7w8hguLOCxWR6oAm+yOWk2m8efcURTmWAAWCfVZJTj4/ozJSfjpVX69g37XNu+vxqCwy36YyigEkISS49x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=oMB4Ha4F; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id DEDE310000E;
	Thu, 28 Mar 2024 17:29:06 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru DEDE310000E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1711636146;
	bh=evQRgmgfpBfE7ABI70oDODcWR8kPQd8V040QqDbhPSQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=oMB4Ha4FC7ybfhcUSoswKvOJhUj29Bq5Rd7h9qEdYDfmYH7X6DJiSC3G3MjYM3NY2
	 Q6AEQZ0Uehd+MoAVb6NF6Tc+smi0HRsRNtne5+hMWylFb81NajdGQTQnMX7Pa3ljjk
	 7cydUzFlqQR/nVUHzL8PYiEArvuxzgVzoOznVGd5UsK2045PhR3qTFE72O4+sRZmVQ
	 Y2NkNOLFaYacssXKdGiaIv5mGrUwvEYWoel4FmFgrNEwJECRldQ2PWBrU16zqCosGq
	 pi/X9Z3buwa97hVkDR2yKV5KCw2wbBVA9UJj7F+ovgEgl2yFMDJPAlAE1G4W4WbGKG
	 d/kIiQbh6xIbA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 28 Mar 2024 17:29:06 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m02.sberdevices.ru
 (172.16.192.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 28 Mar
 2024 17:29:06 +0300
Date: Thu, 28 Mar 2024 17:29:06 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <neil.armstrong@linaro.org>
CC: <jbrunet@baylibre.com>, <mturquette@baylibre.com>, <khilman@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <glaroque@baylibre.com>,
	<rafael@kernel.org>, <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
	<lukasz.luba@arm.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<kernel@salutedevices.com>, <rockosov@gmail.com>,
	<linux-amlogic@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: thermal: amlogic: add support for A1
 thermal sensor
Message-ID: <20240328142818.5mnktmaq2dctos6o@CAB-WSD-L081021>
References: <20240328133802.15651-1-ddrokosov@salutedevices.com>
 <20240328133802.15651-2-ddrokosov@salutedevices.com>
 <19897482-2fa1-4688-aeec-855123558374@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <19897482-2fa1-4688-aeec-855123558374@linaro.org>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184473 [Mar 28 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/03/28 12:54:00 #24494464
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Neil,

Thank you for quick feedback.

On Thu, Mar 28, 2024 at 03:07:52PM +0100, neil.armstrong@linaro.org wrote:
> Hi,
> 
> On 28/03/2024 14:37, Dmitry Rokosov wrote:
> > Provide right compatible properties for Amlogic A1 Thermal Sensor
> > controller. A1 family supports only one thermal node - CPU thermal
> > sensor.
> > 
> > Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> > ---
> >   .../bindings/thermal/amlogic,thermal.yaml          | 14 +++++++++-----
> >   1 file changed, 9 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
> > index 20f8f9b3b971..0e7f6568d385 100644
> > --- a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
> > +++ b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
> > @@ -13,11 +13,15 @@ description: Binding for Amlogic Thermal
> >   properties:
> >     compatible:
> > -    items:
> > -      - enum:
> > -          - amlogic,g12a-cpu-thermal
> > -          - amlogic,g12a-ddr-thermal
> > -      - const: amlogic,g12a-thermal
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - amlogic,g12a-cpu-thermal
> > +              - amlogic,g12a-ddr-thermal
> > +          - const: amlogic,g12a-thermal
> > +      - items:
> > +          - const: amlogic,a1-cpu-thermal
> > +          - const: amlogic,a1-thermal
> 
> In this case you can just use "amlogic,a1-cpu-thermal" or "amlogic,a1-thermal", no need for a fallback.

Okay, I will send v2 with only one compatible w/o fallback.

-- 
Thank you,
Dmitry

