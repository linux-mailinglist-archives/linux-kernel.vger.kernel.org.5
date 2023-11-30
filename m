Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2347FF864
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjK3RgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjK3RgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:36:05 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A3B131;
        Thu, 30 Nov 2023 09:36:11 -0800 (PST)
Received: from p200301077700c3001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7700:c300:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1r8kxC-006snc-0n; Thu, 30 Nov 2023 18:35:58 +0100
Date:   Thu, 30 Nov 2023 18:35:55 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        bcousson@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: omap4-embt2ws: Add Bluetooth
Message-ID: <20231130183555.1b329b78@aktux>
In-Reply-To: <20231007072442.GW34982@atomide.com>
References: <20231004070309.2408745-1-andreas@kemnade.info>
        <6b4968d9-80d3-4a5a-b42e-3982825e45e9@linaro.org>
        <20231007070015.GS34982@atomide.com>
        <20231007072442.GW34982@atomide.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On Sat, 7 Oct 2023 10:24:42 +0300
Tony Lindgren <tony@atomide.com> wrote:

> * Tony Lindgren <tony@atomide.com> [231007 07:00]:
> > * Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> [231005 08:47]:  
> > > On 04/10/2023 09:03, Andreas Kemnade wrote:  
> > > > Since the required clock is now available, add bluetooth.
> > > > 
> > > > Note: Firmware (bts file) from device vendor reroutes tx for some time
> > > > during initialisation and later put it back, producing timeouts in
> > > > bluetooth initialisation but ignoring that command leads to proper
> > > > initialisation.
> > > > 
> > > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > > ---  
> > > 
> > > 
> > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>  
> > 
> > Applying into omap-for-v6.7/dt thanks.  
> 
> Looks like this causes the following #clock-cells warning so dropping
> this patch.
> 
> Regards,
> 
> Tony
> 
> arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts:457.17-462.4: Warning (clocks_property):
> /ocp/interconnect@48000000/segment@0/target-module@6c000/serial@0/bluetooth-gnss:
> Missing property '#clock-cells' in node /ocp/interconnect@48000000/segment@0/targe
>

I do not get this warning on top of omap-for-v6.8/dt. So I think the
time is really there for this patch.

Regards,
Andreas
