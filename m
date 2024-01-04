Return-Path: <linux-kernel+bounces-16847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EABF08244D7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D05F1C22093
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7439A241FC;
	Thu,  4 Jan 2024 15:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tGYYc6hr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39508241E6;
	Thu,  4 Jan 2024 15:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 404FKY2O025030;
	Thu, 4 Jan 2024 09:20:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1704381634;
	bh=8L6XjEgvpWhme0+WHDMHLTnWTs8TNY8c5ZoS/bqIkNM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=tGYYc6hrcDhXDL3m/gtiKBRT7BIs7xj95ssF2l98MJFLbKoKI5X59QSFljFRn3R6x
	 IV/g34ACniFJH9XUvQ8oWjSwDO3GYbxv9nzfweyc0xvxdG+7GtP5/P8JEfyslJk61I
	 1pGTXaIZrGUqhofgFq9Dprf+mTUoOOOIih2FQVls=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 404FKYWt088547
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jan 2024 09:20:34 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Jan 2024 09:20:34 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Jan 2024 09:20:34 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 404FKYnn007652;
	Thu, 4 Jan 2024 09:20:34 -0600
Date: Thu, 4 Jan 2024 09:20:34 -0600
From: Nishanth Menon <nm@ti.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Manorit Chawdhry <m-chawdhry@ti.com>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui
	<rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, J
 Keerthy <j-keerthy@ti.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Udit Kumar
	<u-kumar1@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] dt-bindings: thermal: k3-j72xx: Update bindings for
 J721S2 SoCs
Message-ID: <20240104152034.gijjaeehlcylorws@tranquil>
References: <20231228-b4-upstream-j721s2-vtm-dt-binding-v1-1-e866277f9c64@ti.com>
 <65a294e7-1c3c-4022-9498-e83e7415ffb3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <65a294e7-1c3c-4022-9498-e83e7415ffb3@linaro.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 10:33-20240104, Krzysztof Kozlowski wrote:
> On 28/12/2023 07:39, Manorit Chawdhry wrote:
> > The clock and processor ID for J721S2 differs from the existing
> > compatibles, add a new compatible to represent this change for adding
> > support for Adaptive voltage scaling.

This makes no sense to begin with. You do not need a new compatible just
for clock ID change (processor ID has nothing to do with vtm node).

This approach is just plain wrong. AVS support has been done in the past
(class 3,2,1.5 and 0) and bindings have been mature for more that a
decade for the same.

So NAK for this patch

> 
> Subject: everything is "update". Write proper subjects.
> 
> A nit, subject: drop second/last, redundant "bindings for". The
> "dt-bindings" prefix is already stating that these are bindings.
> 
> 
> 
> > 
> > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > ---
> >  .../devicetree/bindings/thermal/ti,j72xx-thermal.yaml        | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
> > index 171b3622ed84..5792ccc058aa 100644
> > --- a/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
> > +++ b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
> > @@ -24,9 +24,13 @@ description: |
> >  
> >  properties:
> >    compatible:
> > -    enum:
> > -      - ti,j721e-vtm
> > -      - ti,j7200-vtm
> > +    anyOf:
> 
> ? Eh, what?
> 
> > +      - items:
> > +          - enum:
> > +              - ti,j721e-vtm
> > +              - ti,j7200-vtm
> > +              - ti,j721s2-vtm
> > +      - maxItems: 2
> 
> What? I really do not understand what are you doing here.
> 
> 
> >  
> >    reg:
> >      items:
> > @@ -72,7 +76,7 @@ examples:
> >    - |
> >      #include <dt-bindings/soc/ti,sci_pm_domain.h>
> >      wkup_vtm0: thermal-sensor@42040000 {
> > -        compatible = "ti,j721e-vtm";
> > +        compatible = "ti,j721e-vtm", "ti,j7200-vtm";
> 
> It's an enum, not a list.
> 
> NAK, please read example-schema and other bindings. Then get review from
> TI folks before posting new versions.
> 
> Best regards,
> Krzysztof
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

