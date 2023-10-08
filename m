Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961097BCFB2
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 21:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344484AbjJHTBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 15:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjJHTBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 15:01:15 -0400
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336B8AC;
        Sun,  8 Oct 2023 12:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1696791669; bh=TpDAiO/3M2zwoN0Tlu29z9aRzpua06n2dHZEpvc3rPM=;
        h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
        b=AJ4A3iCFuUyW1qY02BnUfDrk/+fa1f68mS8EBfsibMVxbVK5sz6Vf8fFVK9kRkn/M
         wYmz3CUII0SQ3B1XXbx++a9pXg3UQRdQRB4MxF3wthJEcg8fXg0ZDpbGS0XPAAnyEN
         Q7LsL9War87Ry/aG1ortCnHPw5G/Zx47bh1hGQy0=
Date:   Sun, 8 Oct 2023 21:01:09 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH] dt-bindings: mfd: rk806: Allow
 rockchip,system-power-controller property
Message-ID: <gcfmcxlitopwjt2ucu73m64j6kmfuvbpdyptdq7mzltuz56zbn@6ddy6z2dilrj>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
        Sebastian Reichel <sebastian.reichel@collabora.com>, linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>, 
        Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
        Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
        "moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>, 
        "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20231008142118.1174090-1-megi@xff.cz>
 <20231008185559.ros34cft2dxoewqe@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231008185559.ros34cft2dxoewqe@mercury.elektranox.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2023 at 08:55:59PM +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Sun, Oct 08, 2023 at 04:21:17PM +0200, Ondřej Jirman wrote:
> > From: Ondrej Jirman <megi@xff.cz>
> > 
> > Declare support for this property.
> > 
> > Signed-off-by: Ondrej Jirman <megi@xff.cz>
> > ---
> 
> This is missing the accompanying driver change. Right now
> this property does nothing for rk806.

Ah, I assumed it does, but looks like it's just implemented in my tree:

https://megous.com/git/linux/commit/?h=ppp-drivers-6.6&id=6394918f339fda0b89f63faac4c4fe162d5ace42

I'll re-send with the driver patch.

Thanks and regards,
	o.


> -- Sebastian
> 
> >  Documentation/devicetree/bindings/mfd/rockchip,rk806.yaml | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk806.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk806.yaml
> > index cf2500f2e9a0..e8c9f17f6ea8 100644
> > --- a/Documentation/devicetree/bindings/mfd/rockchip,rk806.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/rockchip,rk806.yaml
> > @@ -29,6 +29,11 @@ properties:
> >    '#gpio-cells':
> >      const: 2
> >  
> > +  rockchip,system-power-controller:
> > +    type: boolean
> > +    description:
> > +      Telling whether or not this PMIC is controlling the system power.
> > +
> >    vcc1-supply:
> >      description:
> >        The input supply for dcdc-reg1.
> > -- 
> > 2.42.0
> > 


