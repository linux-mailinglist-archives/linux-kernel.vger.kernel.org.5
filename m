Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D08177446E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbjHHSSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbjHHSR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:17:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451941EF64
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:25:25 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qTQSP-0003Jg-Kc; Tue, 08 Aug 2023 19:25:21 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qTQSO-0007Eh-NV; Tue, 08 Aug 2023 19:25:20 +0200
Date:   Tue, 8 Aug 2023 19:25:20 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, dan.scally@ideasonboard.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/4] dt-bindings: arm: fsl: fix DEBIX binding
Message-ID: <20230808172520.5nboxnch4yzqyu3z@pengutronix.de>
References: <20230807171513.156907-1-m.felsch@pengutronix.de>
 <20230807171513.156907-2-m.felsch@pengutronix.de>
 <9a86a125-2eda-721b-8b17-c1cfe144adc9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a86a125-2eda-721b-8b17-c1cfe144adc9@linaro.org>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-08-08, Krzysztof Kozlowski wrote:
> On 07/08/2023 19:15, Marco Felsch wrote:
> > The current imx8mp-debix-model-a.dts uses all three compatibles. Fix the
> > corresponding bindings by adding an own entry for it. Mark
> > polyhex,imx8mp-debix as deprecated but keep it within the dts file since
> 
> The deprecation did not happen anymore.

Damn, you're right. I will fix this thanks.

> > we already have a user for it [1].
> > 
> > [1] https://elixir.bootlin.com/barebox/v2023.07.1/source/arch/arm/ \
> >     boards/polyhex-debix/board.c#L38
> > 
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> > Changelog:
> > 
> > v3:
> > - drop 'deprecated' status and adapt comment instead
> 
> With adjustments in commit msg:
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> 
> Best regards,
> Krzysztof
> 
> 
