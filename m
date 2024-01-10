Return-Path: <linux-kernel+bounces-18781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FF48262FA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 06:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BA821F21FF9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 05:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688BA11CBB;
	Sun,  7 Jan 2024 05:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mAO2EI7Q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A96F11CB9
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 05:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7bbf9437261so61260139f.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jan 2024 21:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704604764; x=1705209564; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nSuwiElX6PlNT4aUpgUOVoJxMe2k+o3qKu2vP2pacdg=;
        b=mAO2EI7Q0t5GfTqb8fIMRWU5AdlUJSsZoqYM2NVyETdaUrxl741ic1GydaIRozv4de
         mUF4pCShbmvknYnMtWmbAZy9BVXiVO4zo3UfCpg8flAVeo/d5RR+w7KudAhkDSa00wb6
         sNjRQmBrKhvTGDIuno/UjFkN6pCRNJLfIIgLaGiqEuyMAw+I+iHQfEeJyG1LgdqChfjA
         L2fanpxZ0juieL40cgc3LEUqatXuaVyZQaXKd7lsy8hbTKpEKjbSvfpOihV7cDiDz7BW
         eOzQYx1waXwthmU/kMtlLyf9UCcHKT8ymQjqlYhxYabBLvsx+YNNfFy6cDGtKFjb3JzT
         cXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704604764; x=1705209564;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nSuwiElX6PlNT4aUpgUOVoJxMe2k+o3qKu2vP2pacdg=;
        b=j/uJD8t6BS4+Bb7gquyXxh1Wi+0JUlIJcWaIBkukMNpkEpxAG9301KpBec0MjLlol7
         LW5Mq2aYie9sb6c7ZG2Lc9rH5Uo8z6gmhT9DEsY8L6z+MauNtEGgMB7uikDjYrGCHtqG
         ayj8BuJ2lj3AHsvTxtA9qKJUXCtALzs5nS12TtOb6jG9o722jrlQV4xr9qM9xadT5FML
         GXzjYry3XowgCQgdOadQsbyP7zymQGDoxqKl70F2irHI46t3+/2zcltJq39xL4Ceby/Z
         FzlDe7noQaOTYwezJkEi1xFEiliDWPUeVDZq3/I2fr99yz/bpL2q1I7sD74PMVka+vLm
         iZ3A==
X-Gm-Message-State: AOJu0YwaLsWSraX4o4xUN3nkQad6DGzs3l4GVEyQb61zYdwTGtsL7+fX
	DLyD8kTA7sCwppp446BC1YH42spTHCh5kLENzyt17MMkTdYt
X-Google-Smtp-Source: AGHT+IEnEAm1Yc7lppJUT8BX2yQ4Qk4lMAc3HGwoofXeJi9xbmN1moHDvBu414uQ4we4GX7vBQDchQ==
X-Received: by 2002:a05:6e02:3883:b0:360:5cd9:a73e with SMTP id cn3-20020a056e02388300b003605cd9a73emr3323633ilb.6.1704604764612;
        Sat, 06 Jan 2024 21:19:24 -0800 (PST)
Received: from thinkpad ([103.197.115.97])
        by smtp.gmail.com with ESMTPSA id jj4-20020a170903048400b001d078445059sm3857763plb.143.2024.01.06.21.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 21:19:24 -0800 (PST)
Date: Sun, 7 Jan 2024 10:49:17 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.li@nxp.com>
Cc: krzysztof.kozlowski@linaro.org, bhelgaas@google.com,
	conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com,
	helgaas@kernel.org, hongxing.zhu@nxp.com, imx@lists.linux.dev,
	kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
	kw@linux.com, l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, robh@kernel.org, s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: Re: [PATCH v7 04/16] dt-bindings: imx6q-pcie: Add linux,pci-domain
 as required for iMX8MQ
Message-ID: <20240107051917.GG3416@thinkpad>
References: <20231227182727.1747435-1-Frank.Li@nxp.com>
 <20231227182727.1747435-5-Frank.Li@nxp.com>
 <20240107031506.GC3416@thinkpad>
 <ZZos6LDk4NTfQHyU@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZZos6LDk4NTfQHyU@lizhi-Precision-Tower-5810>

On Sat, Jan 06, 2024 at 11:47:36PM -0500, Frank Li wrote:
> On Sun, Jan 07, 2024 at 08:45:06AM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Dec 27, 2023 at 01:27:15PM -0500, Frank Li wrote:
> > > iMX8MQ have two pci controllers. Adds "linux,pci-domain" as required
> > > proptery for iMX8MQ to indicate pci controller index.
> > > 
> > 
> > property
> > 
> > > This adjustment paves the way for eliminating the hardcoded check on the
> > > base register for acquiring the controller_id.
> > > 
> > > 	...
> > > 	if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> > > 		imx6_pcie->controller_id = 1;
> > > 	...
> > > 
> > > The controller_id is crucial and utilized for certain register bit
> > > positions. It must align precisely with the controller index in the SoC.
> > > An auto-incremented ID don't fit this case. The DTS or fuse configurations
> > > may deactivate specific PCI controllers.
> > > 
> > 
> > You cannot change the binding for the sake of driver. But you can make this
> > change in other way. See below...
> > 
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > > 
> > > Notes:
> > >     Change from v5 to v6
> > >     - rework commit message to explain why need required and why auto increase
> > >     id not work
> > >     
> > >     Change from v4 to v5
> > >     - new patch at v5
> > > 
> > >  .../bindings/pci/fsl,imx6q-pcie-common.yaml           | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
> > > index d91b639ae7ae7..8f39b4e6e8491 100644
> > > --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
> > > +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
> > > @@ -265,6 +265,17 @@ allOf:
> > >              - const: apps
> > >              - const: turnoff
> > >  
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            enum:
> > > +              - fsl,imx8mq-pcie
> > > +              - fsl,imx8mq-pcie-ep
> > 
> > "linux,pci-domain" is a generic property. So you cannot make it required only
> > for certain SoCs. 
> 
> Sorry, why not? there are many generic property.
> 

It doesn't make sense to make it required only for specific SoCs since it is not
specific to any SoC. You can make it required for all.

> > But you can make it so for all SoCs. This way, the drivers
> > can also rely on it.
> > 
> > Now, you should get rid of the commit message about driver internals:
> 
> Not all dts already added "linux,pci-domain" yet. If required for all SOCs,
> it will cause dtb check warnings.
> 

You can safely add this property to all DTS. Nothing will break.

- Mani

> Frank
> > 
> > > This adjustment paves the way for eliminating the hardcoded check on the
> > > base register for acquiring the controller_id.
> > > 
> > >       ...
> > >       if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> > >               imx6_pcie->controller_id = 1;
> > >       ...
> > > 
> > > The controller_id is crucial and utilized for certain register bit
> > > positions. It must align precisely with the controller index in the SoC.
> > > An auto-incremented ID don't fit this case. The DTS or fuse configurations
> > > may deactivate specific PCI controllers.
> > > 
> > 
> > - Mani
> > 
> > > +    then:
> > > +      required:
> > > +        - linux,pci-domain
> > > +
> > >  additionalProperties: true
> > >  
> > >  ...
> > > -- 
> > > 2.34.1
> > > 
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

