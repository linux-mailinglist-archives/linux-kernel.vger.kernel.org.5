Return-Path: <linux-kernel+bounces-111242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8397888699B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A54281C21468
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10103224DE;
	Fri, 22 Mar 2024 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RT/bx1Bo"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B2D20DDB;
	Fri, 22 Mar 2024 09:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711100733; cv=none; b=EtBlWd9YReNIIjnZlZlByyO/ZGEPm8CpE3qGfMg6k0JIpSaUdGz8fvzMjxNA4spEq4HBDiSF+JFchQsMrLvbjKYNqof8ipZJgAzw+tAUneCx1TBBvMsHeqg/77JypuiYgTiJuS1TZaM3t21K/ZS94p4WtMtKn4w8WKKkJBF2Pag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711100733; c=relaxed/simple;
	bh=A4FOGLlvtuthBYiub+mR8yfwfnfz1i/GHCFLNMfFHSs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xw0IQtJlDA8Upd0+6IJ/VM6ODRmeeHkttKqKx9nbwz+UlA69aAGdiRNcd6zVFZKZrafM/WAMhGcR2k08nR3up3HvACFoGo0M/rMJ5J7oj1ByJeIwrmejy8N7HGgKXL5N3nyV0FnK5wFfUoD9fsifOJf5qEI+oTG4zUoXcJtkWS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RT/bx1Bo; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56bdf81706aso756225a12.2;
        Fri, 22 Mar 2024 02:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711100730; x=1711705530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AlmUZX1oKnCqPJXsSuCW5CozYj1wJFSEFEeiu59yIp4=;
        b=RT/bx1BoKmV/H07F2KB3VAiCTU9NK5DSdzkM3LbD6svSDVKB/RT0wKdPy8PT/gljED
         uXuc0C0pKXug4Plzo7ycf3C4ZNFqNvIgP58E/0ORjbRS43S1AjxZptd0EIpabsGmDWE4
         zNwz9U9Zl5byqu+a7KQaLpBxXGD0Z2fMIHrtOFTdQF8SoL+ryMdTn+zY73dnt8xhqE/o
         4OY0YfPd2j1KzUc3pxFrBtuLW+wfEZRy2mpotH7Jw/zZB3fAcZGz8f83FANPWZei5bW2
         R4HQs/6aWBDij5eif2tTjdRBXoD24mcWH8KC0AI0LiJhWCit/b6UDC91PmFdcfXv9jOF
         RxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711100730; x=1711705530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AlmUZX1oKnCqPJXsSuCW5CozYj1wJFSEFEeiu59yIp4=;
        b=EhIk2jv5hTv7M4wJu/xN+KHzAbG3B19AVDWqFnylEt9uTbgYME9Y9r4F7FU5Bv5wvE
         wgl6QdvqTF6NczEtVQ7/8eNdaPeH9ZNScGDDSeJnfP+tHmlyy3fBXxxOemTyTr2mSZcf
         7B1H3BF/Kzoiofcb0RIvp6+QqsQ38GeCNxyFtEmk83O/SG74wBzDBCWJCQyfaLZQdcjs
         5Br2DMkql0ytV1HcC/kuwY9QRtCmuc2RhrANpZOkio4PzkMDoraqGtLSs/D1u/BqbgkV
         Ioba8PxMdfH667hdLV54EJpElHTi23I5LM0HSYHGTwYOykYZqYBQTT42lv1dkY8RUZyM
         Kgog==
X-Forwarded-Encrypted: i=1; AJvYcCXpNWu0Vf9LtwVNot9Un1ytWdEiEb3qFUAuCbNkwkNvvxS/qTrQEg2l0/H+I82umBN28GwFfl06KKZrGpYgG7TK9U9ksDHOV3qoQpS9+oltZ8s3OMgewBvgzF/G8mCy+KDPoVDDX384oQkX5cHoSOFWvElHUJTYbGiKN64WbxjGNmykNvHa+CKmCdK2NIhx8i9fTaQhQ9nT3pzGrkTHCR2ljA==
X-Gm-Message-State: AOJu0YztxUAwaEANpQ3Z1EDFk3asbgxs/THwOaB4G/U6VqV2AGX/fnDA
	4hbZxy5CsryIfCH16U0eOfFh5qOlKrlTE4jvPWbpoLHSdxSC2sxV
X-Google-Smtp-Source: AGHT+IEMdPwXdULfmQN6UAn3oOA+aJ6y8GiAsPYU2u8TIUMJ7NjPC6DuAt/2jKqSVu/RE4c3YGQRhQ==
X-Received: by 2002:a50:cd1c:0:b0:56b:6ec6:af2f with SMTP id z28-20020a50cd1c000000b0056b6ec6af2fmr1179534edi.6.1711100729462;
        Fri, 22 Mar 2024 02:45:29 -0700 (PDT)
Received: from bhlegrsu.conti.de ([2a02:908:2525:6ea0::11c2])
        by smtp.gmail.com with ESMTPSA id b9-20020aa7d489000000b00568ba57983csm839426edr.0.2024.03.22.02.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 02:45:29 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
X-Google-Original-From: Wadim Mueller <wadim.mueller@continental.com>
Date: Fri, 22 Mar 2024 10:45:26 +0100
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Wadim Mueller <wafgo01@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Chester Lin <chester62515@gmail.com>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Matthias Brugger <mbrugger@suse.com>,
	NXP S32 Linux Team <s32@nxp.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Marek Vasut <marex@denx.de>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Matthias Schiffer <matthias.schiffer@tq-group.com>,
	Stefan Wahren <stefan.wahren@chargebyte.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philippe Schenker <philippe.schenker@toradex.com>,
	Yannic Moog <y.moog@phytec.de>, Li Yang <leoyang.li@nxp.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 3/4] dt-bindings: mmc: fsl-imx-esdhc: add NXP S32G3
 support
Message-ID: <20240322094526.GA7097@bhlegrsu.conti.de>
References: <20240321154108.146223-1-wafgo01@gmail.com>
 <20240321154108.146223-4-wafgo01@gmail.com>
 <00174dc3-65a7-4a2e-b48d-a974336a3f18@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00174dc3-65a7-4a2e-b48d-a974336a3f18@linaro.org>

On Thu, Mar 21, 2024 at 06:53:34PM +0100, Krzysztof Kozlowski wrote:
> On 21/03/2024 16:41, Wadim Mueller wrote:
> > Add a compatible string for the SDHC binding of NXP S32G3 platforms. Here
> > we use "nxp,s32g2-usdhc" as fallback since the s32g2-usdhc
> > driver works also on S32G3 platforms.
> > 
> > Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> > index 82eb7a24c857..b42b4368fa4e 100644
> > --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> > @@ -35,6 +35,7 @@ properties:
> >            - fsl,imx8mm-usdhc
> >            - fsl,imxrt1050-usdhc
> >            - nxp,s32g2-usdhc
> > +          - nxp,s32g3-usdhc
> >        - items:
> >            - const: fsl,imx50-esdhc
> >            - const: fsl,imx53-esdhc
> > @@ -90,6 +91,9 @@ properties:
> >            - enum:
> >                - fsl,imxrt1170-usdhc
> >            - const: fsl,imxrt1050-usdhc
> > +      - items:
> > +          - const: nxp,s32g3-usdhc
> > +          - const: nxp,s32g2-usdhc
> 
> No, that's just wrong. G3 is not and is compatible with G2? There is no
> dualism here. Either it is or it is not. Not both.
>

I am trying to understand your statement but I am not sure whether I get
it right.

Let me try to explain what I understand is wrong with this patch. 

Having nxp,s32g2-usdhc and nxp,s32g2-usdhc in one enum

> >            - nxp,s32g2-usdhc
> > +          - nxp,s32g3-usdhc

would mean that those are 
__not__ compatible with each other, whereas the anouther item

> > +      - items:
> > +          - const: nxp,s32g3-usdhc
> > +          - const: nxp,s32g2-usdhc
> 

where both const entries are side by side means that those are compatible. Which is
paradox. Is this undersanding correct?

So if I want to have the follwing im my DTS for the mmc node

usdhc0: mmc@402f0000 {
			compatible = "nxp,s32g3-usdhc",
				     "nxp,s32g2-usdhc";
				     ...
}

The schema update should contain just this part?

i@@ -90,6 +90,9 @@ properties:
           - enum:
               - fsl,imxrt1170-usdhc
           - const: fsl,imxrt1050-usdhc
+      - items:
+          - const: nxp,s32g3-usdhc
+          - const: nxp,s32g2-usdhc
 
   reg:
     maxItems: 1


Is this correct?

With this patch in place I dont see any issues with an 

"make CHECK_DTBS=y freescale/s32g399a-rdb3.dtb"

as well as "make dt_binding_check dtbs_check" seems to be OK with this.


Thanks for your guidence so far, much appreciated!

Best Regard
Wadim



> Best regards,
> Krzysztof
> 

