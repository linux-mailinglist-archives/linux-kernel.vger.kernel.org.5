Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86B87EAEAB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 12:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbjKNLOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 06:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKNLOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 06:14:44 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1913189;
        Tue, 14 Nov 2023 03:14:40 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CA38BC000B;
        Tue, 14 Nov 2023 11:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699960479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KIj6F7OlqwB7D0mHoxTDr4C4+/7gqjpgDdXihBuie7M=;
        b=Ahq+dCJ+kduDb9wvVwE2uEP9YOa1fPXt9ey9m5AFeSC0hpluXGehgt+K8RVxQfoYNBDGSr
        B5VIoNy6HnRB5ZuwyCMduwhoCHzgWrEaGCiGMKypC7yMQtvecoOqHFIVba7y3VBCJI0zlF
        VeqfFPYxn9WZcIrOLLPf7tWHOf6uO8z9WPrrNxb/8DJ84c45IF/GVgYKZCmHR698I3v926
        h554ku6bZdxxJ2Ic8wMJNx2id/ksbSiavOiZCiqjRng8g2bLfHtrgPWOJ5CLtCg8WNvy3n
        C/qBkZ43t/y0agpEAuq+qwpa2hi+qjHbC8K06EPmZCOfKjtbtuorKddPmP4Iqg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 14 Nov 2023 12:14:38 +0100
Message-Id: <CWYHP2PTNVNT.316KO84HP5CZV@tleb-bootlin-xps13-01>
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH 6/6] arm64: dts: ti: k3-j7200: use J7200-specific USB
 compatible
Cc:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
To:     "Gregory CLEMENT" <gregory.clement@bootlin.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Roger Quadros" <rogerq@kernel.org>,
        "Peter Chen" <peter.chen@kernel.org>,
        "Pawel Laszczak" <pawell@cadence.com>,
        "Nishanth Menon" <nm@ti.com>,
        "Vignesh Raghavendra" <vigneshr@ti.com>,
        "Tero Kristo" <kristo@kernel.org>
X-Mailer: aerc 0.15.2
References: <20231113-j7200-usb-suspend-v1-0-ad1ee714835c@bootlin.com>
 <20231113-j7200-usb-suspend-v1-6-ad1ee714835c@bootlin.com>
 <87wmuk64bs.fsf@BL-laptop>
In-Reply-To: <87wmuk64bs.fsf@BL-laptop>
X-GND-Sasl: theo.lebrun@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue Nov 14, 2023 at 11:01 AM CET, Gregory CLEMENT wrote:
> > ---
> > diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boo=
t/dts/ti/k3-j7200-main.dtsi
> > index 709081cd1e7f..581905d9199e 100644
> > --- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> > @@ -788,7 +788,7 @@ pcie1_ep: pcie-ep@2910000 {
> >  	};
> > =20
> >  	usbss0: cdns-usb@4104000 {
> > -		compatible =3D "ti,j721e-usb";
> > +		compatible =3D "ti,j7200-usb";
>
> What about keeping the old compatible as fallback in the unlikley case
> we have a new dtb with an old kernel ?

I see the usecase; that will be done in V2.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
