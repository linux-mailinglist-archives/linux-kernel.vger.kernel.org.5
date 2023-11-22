Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF38B7F4DFB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 18:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343975AbjKVRPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 12:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjKVRPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 12:15:05 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E92583;
        Wed, 22 Nov 2023 09:15:01 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B547B40002;
        Wed, 22 Nov 2023 17:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700673299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AkVswiJ7VPVtZX+F/mFSJMy4cTc8YcymiMChgnVRYnw=;
        b=YPVFJTVFZnnaVhBQtagXSCU0uOltCQ8PaBP/vpt0JIu2EA3Uh7BbmzW4752uw5vV6z0TFz
        GPFuSXlnqFvHwTnUkGwF6GvkuVYCUkimS6hJXQyvgW51IApN8GrG4qbc1qEsPbnNYHgDzT
        fC/ZhiN9fhu7k0o8ySDkh7StR8RvYOpsdZQYHpz1Bb+bE3+n5tqMa+9WOnYAYxqG4WaEow
        oqq4vaW1FpXnNmXUk+j/1h2NdTYKvyu07xycfVkhZiKZ4TjTaJw0to5AhUyDFNBXzYaOHU
        M+eVf7eoIgIEG1FErKH7Rb6n9jyj6QKr6euF3ha9qu/kUquevZlUKchwnhvXCw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 22 Nov 2023 18:14:57 +0100
Message-Id: <CX5IDB4IPK92.31F1ICOWQSL84@tleb-bootlin-xps13-01>
Subject: Re: [PATCH v2 1/7] dt-bindings: usb: ti,j721e-usb: add ti,j7200-usb
 compatible
Cc:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
        "Conor Dooley" <conor.dooley@microchip.com>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
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
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.15.2
References: <20231120-j7200-usb-suspend-v2-0-038c7e4a3df4@bootlin.com>
 <20231120-j7200-usb-suspend-v2-1-038c7e4a3df4@bootlin.com>
 <6f0da181-717c-4b14-ba3f-d287efe4105b@linaro.org>
 <CX4NADEZZEO1.3TXPVNOONKBCF@tleb-bootlin-xps13-01>
 <d0cc33d4-2b1a-43cd-8cd9-6b58d6c71c85@linaro.org>
 <CX5A3OSPKM1Q.1CPN17KI0PD7A@tleb-bootlin-xps13-01>
 <e91c2fa3-2cb4-44be-953f-2bfa26db2b4f@linaro.org>
In-Reply-To: <e91c2fa3-2cb4-44be-953f-2bfa26db2b4f@linaro.org>
X-GND-Sasl: theo.lebrun@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed Nov 22, 2023 at 1:00 PM CET, Krzysztof Kozlowski wrote:
> On 22/11/2023 11:46, Th=C3=A9o Lebrun wrote:
> >  - properties:
> >    compatible:
> >      oneOf:
> >        - const: ti,j7200-usb
> >        - items:
> >            - const: ti,j721e-usb
> >            - const: ti,am64-usb
> >=20
> >    J721E & AM64 are compatible, express that & update devicetrees.
> >=20
> > Option one is simpler & doesn't change devicetrees so I'd lean in that
> > direction. What's your opinion?
>
> This one should be for am64.
>
> For your j7200, it depends whether the fallback to j721e makes sense,
> IOW, if the Linux can use j721e compatible solely to use j7200 device.

All compatibles might be equivalent if the reset-on-resume behavior is
observed on all three platforms. I don't have access to J721E or AM64
to test that.

@Roger Quadros: do you have any news if USB suspend/resume works on
J721E and/or AM64? My testing on the J7200 EVM is (1) boot, (2) put
the "USB2.0_MUX_SEL" GPIO high to have USB devices connected without
plugging anything, then (3) trigger a s2idle. I get a memory bus
exception on resume without my patches.

Regards,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
