Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B344808AF5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443404AbjLGOqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443322AbjLGOq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:46:29 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB75A3;
        Thu,  7 Dec 2023 06:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=iUUDZHVt3az3SXfC7sYwpPvzPdIHPFC7thViDztCq4Q=; b=dS8xskovguqOJ5eUSKQ+62Po/P
        kV9OVE13U7QhQeBWaEK68kRxetwAlRFvhyFqRzvR1ZQ6NMBtpuXbIa05JaPMnZrB/iCQnSQ+HIgwT
        pY14sCKkUJxU5fihmDEbheVTVoJ2/F8ja91gTre/shIXyGn2Ca8dqQuXaJf7BcJkB9WQ=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:35438 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1rBFdx-0006Pv-TO; Thu, 07 Dec 2023 09:46:26 -0500
Date:   Thu, 7 Dec 2023 09:46:25 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        leoyang.li@nxp.com, robh@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Message-Id: <20231207094625.01d081092dd60ddc504d7f7b@hugovil.com>
In-Reply-To: <6035c4cc-afe1-456d-a4d0-16992da09a2e@linaro.org>
References: <20231206160303.33185-1-hugo@hugovil.com>
        <20231206160303.33185-3-hugo@hugovil.com>
        <6035c4cc-afe1-456d-a4d0-16992da09a2e@linaro.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH 2/3] dt-bindings: arm: fsl: add Dimonoff gateway EVK
 board
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2023 09:32:38 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 06/12/2023 17:03, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Add DT compatible string for Dimonoff gateway EVK board based on a
> > Variscite VAR-SOM-NANO with a NXP MX8MN nano CPU.
> > 
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> >  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> > index cd87d1afe7b7..e445d65d6f17 100644
> > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > @@ -1025,6 +1025,7 @@ properties:
> >        - description: Variscite VAR-SOM-MX8MN based boards
> >          items:
> >            - enum:
> > +              - dimonoff,dimonoff-gateway-evk # i.MX8MN Dimonoff Gateway EVK Board
> 
> Company name appears twice, which is not really helpful. What's the true
> name? Gateway EVK? Then keep only this.
> 
> Best regards,
> Krzysztof

Ok, will do for V2.

Thank you,
Hugo Villeneuve
