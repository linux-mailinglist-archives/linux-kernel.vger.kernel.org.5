Return-Path: <linux-kernel+bounces-22660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 850F382A10D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8A531F23A9B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932244E1D3;
	Wed, 10 Jan 2024 19:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kgb8ZWZU"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA924E1C1;
	Wed, 10 Jan 2024 19:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-28c93513462so2741470a91.2;
        Wed, 10 Jan 2024 11:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704914965; x=1705519765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7WI8ku+I93FyTp2vVuirOMVJ2TB2x4m8v81fvqOn898=;
        b=Kgb8ZWZUCnq2S1xZCsM7Uk0rrGtNDLEn+0G1YiErYWH89j3iGIWhxvI8OZzluy8urN
         Hl8+yEaqFV0EmBGDmNXtvyUnpejbTGXa/dSKDCw1M93RvlJ5xle/xMlCasAFx+0f299c
         px9fCWBovu794vNsGxUcOPqGwq4+EeZaVKyGs6kNrJja9tQsE5EGteFtAZDwXeITB8f5
         pTT9oPgYCFAE/E047fVoJEEiDbr3MvIOQ6Lt+ORDFWhFYQKqlyH1Y5f1mqQdObV0kM3K
         FZVdf0YMSeQP4dSUjsmgdMwcG8KMqz3sQrlMHogPopdhSxE7X5OPNE/C9CiQNI6V86qP
         S/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704914965; x=1705519765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7WI8ku+I93FyTp2vVuirOMVJ2TB2x4m8v81fvqOn898=;
        b=tcsOn8FQXlz4ybGrqmkcI421kM4PHIG2Au8UDin4f38Og18Eyiq5W26nPCNEjsvJvr
         jVjEno6h6Cf+uirrXnisTJQwg7xc4WTFLpOojOpEK3Vq1HqiOB/qdQHVQLt2DZQyNir7
         PrdJ7TePdJ2O9Kj8i8sNaY2Doi1bVqdSOClc18qXWf5Xhs7UL6a+q6iDVKBQYQj8SQ2i
         Nz1IT3PHuMnPN0OK62HyszROnP89M+IthhBbLwpOrX47O8Lujehqf63v3PV8+m/TPjiS
         20sH3Y2lnOlevMuaM+7V9tvWFBUtKFHyvRjCp06wcj4bqgGCnfLVSvRTGY3bzsBXnndD
         zdEA==
X-Gm-Message-State: AOJu0YyKLKFU6coZVDWUdfzdl8LFSjIbZtCW45IMJ5v3yvD0gHFYceM/
	j0YsCjDH9Pku6bM9Mj0BE/jk6DSFQdsM22eB1hE=
X-Google-Smtp-Source: AGHT+IFBPm7b4aCCiyxMadONXgXd714MoYWrp6GeucD3uHx+P0Wv8tbT76KVqGFheQffoeordqCjxEGcEb8NSyPfOMY=
X-Received: by 2002:a17:90a:560e:b0:28d:ba6e:d3de with SMTP id
 r14-20020a17090a560e00b0028dba6ed3demr1073830pjf.95.1704914965415; Wed, 10
 Jan 2024 11:29:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240106215146.147922-1-aford173@gmail.com> <10409718.nUPlyArG6x@steina-w>
In-Reply-To: <10409718.nUPlyArG6x@steina-w>
From: Adam Ford <aford173@gmail.com>
Date: Wed, 10 Jan 2024 13:29:14 -0600
Message-ID: <CAHCN7xLhCSM3zdb5zq-WowS+TxYWLj30znniFxiQGpJRXm+ZzA@mail.gmail.com>
Subject: Re: [PATCH V7 1/2] dt-bindings: display: imx: add binding for i.MX8MP
 HDMI PVI
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: dri-devel@lists.freedesktop.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor.dooley@microchip.com>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Fabio Estevam <festevam@gmail.com>, Robert Foss <rfoss@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Jonas Karlman <jonas@kwiboo.se>, Liu Ying <victor.liu@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Maxime Ripard <mripard@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	linux-arm-kernel@lists.infradead.org, 
	Neil Armstrong <neil.armstrong@linaro.org>, linux-kernel@vger.kernel.org, 
	Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 5:48=E2=80=AFAM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Hi Adam,
>
> thanks for pushing this forward.
>
> Am Samstag, 6. Januar 2024, 22:51:44 CET schrieb Adam Ford:
> > From: Lucas Stach <l.stach@pengutronix.de>
> >
> > Add binding for the i.MX8MP HDMI parallel video interface block.
> >
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> > V7:  No Change
> >
> > V6:  Add s-o-b message for myself (Adam)
> >
> > V5:  I tried to help move this along, so I took Lucas' patch and
> >      attempted to apply fixes based on feedback.  I don't have
> >      all the history, so apologies for that.
> >      Removed the pipe character from the Description.
> >      Increased the register size from 0x40 to 0x44.
> > diff --git
> > a/Documentation/devicetree/bindings/display/imx/fsl,imx8mp-hdmi-pvi.yam=
l
> > b/Documentation/devicetree/bindings/display/imx/fsl,imx8mp-hdmi-pvi.yam=
l
> > new file mode 100644
> > index 000000000000..3377f152f319
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/imx/fsl,imx8mp-hdmi-pvi=
yaml
> > @@ -0,0 +1,83 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/imx/fsl,imx8mp-hdmi-pvi.yam=
l#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Freescale i.MX8MP HDMI Parallel Video Interface
> > +
> > +maintainers:
> > +  - Lucas Stach <l.stach@pengutronix.de>
> > +
> > +description:
> > +  The HDMI parallel video interface is a timing and sync generator blo=
ck in
> > the +  i.MX8MP SoC, that sits between the video source and the HDMI TX
> > controller. +
> > +properties:
> > +  compatible:
> > +    const: fsl,imx8mp-hdmi-pvi
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +
> > +    properties:
> > +      port@0:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: Input from the LCDIF controller.
> > +
> > +      port@1:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: Output to the HDMI TX controller.
> > +
> > +    required:
> > +      - port@0
> > +      - port@1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - power-domains
> > +  - ports
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/power/imx8mp-power.h>
> > +
> > +    display-bridge@32fc4000 {
> > +        compatible =3D "fsl,imx8mp-hdmi-pvi";
> > +        reg =3D <0x32fc4000 0x44>;
>
> Shall interrupt-parent =3D <&irqsteer_hdmi>; be added here as well?

That does appear to the case.  Good catch.  The HDMI documentation
isn't as thorough as some other parts of the tech ref manual are.

I'll fix this when I resubmit

adam
>
> Best regards,
> Alexander
>
> > +        interrupts =3D <12 IRQ_TYPE_LEVEL_HIGH>;
> > +        power-domains =3D <&hdmi_blk_ctrl IMX8MP_HDMIBLK_PD_PVI>;
> > +
> > +        ports {
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +
> > +            port@0 {
> > +                reg =3D <0>;
> > +                pvi_from_lcdif3: endpoint {
> > +                    remote-endpoint =3D <&lcdif3_to_pvi>;
> > +                };
> > +            };
> > +
> > +            port@1 {
> > +                reg =3D <1>;
> > +                pvi_to_hdmi_tx: endpoint {
> > +                    remote-endpoint =3D <&hdmi_tx_from_pvi>;
> > +                };
> > +            };
> > +        };
> > +    };
>
>
> --
> TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Ge=
rmany
> Amtsgericht M=C3=BCnchen, HRB 105018
> Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan S=
chneider
> http://www.tq-group.com/
>
>

