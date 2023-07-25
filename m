Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44651762446
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 23:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjGYVWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 17:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGYVWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 17:22:18 -0400
Received: from out-1.mta1.migadu.com (out-1.mta1.migadu.com [95.215.58.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78605E70
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 14:22:16 -0700 (PDT)
Date:   Tue, 25 Jul 2023 23:22:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
        t=1690320134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tHqrqD8etAmFPoplWVHS6xgjs7yFI6bgpUy2PExyaBw=;
        b=lpg23rv0b5yAMBdEBTGiVqKzZ5nlcCQaUn5sXVFujyxLf4FUNyH5LGF4XT6sPC6RMkESeJ
        2IlxEb8lyMvI59riJo1Mmds0qqAZHDNRJ2SjdDTcVYQqCEas+ezNDxtD/NMMSAa79N4ocg
        n+ssBDzw4ym09d16PDOwWeVMwKPw81E=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Henrik Grimler <henrik@grimler.se>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        replicant@osuosl.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Martin =?iso-8859-1?Q?J=FCcker?= <martin.juecker@gmail.com>,
        Artur Weber <aweber.kernel@gmail.com>
Subject: Re: [PATCH v2] ARM: dts: samsung: exynos4412-midas: add USB
 connector and USB OTG
Message-ID: <ZMA9AcfElvuYZTiV@grimlerstat.localdomain>
References: <20230723142417.97734-1-krzysztof.kozlowski@linaro.org>
 <ZMAfSIF0Rwc69nEv@grimlerstat.localdomain>
 <d04af4a2-a07b-66b7-47e1-5c90fb11fe54@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d04af4a2-a07b-66b7-47e1-5c90fb11fe54@linaro.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Tue, Jul 25, 2023 at 10:08:00PM +0200, Krzysztof Kozlowski wrote:
> On 25/07/2023 21:15, Henrik Grimler wrote:
> > On Sun, Jul 23, 2023 at 04:24:17PM +0200, Krzysztof Kozlowski wrote:
> >> Add full description of USB-MUIC (MAX77693 MUIC) and MUIC-MHL
> >> connections, along with proper USB connector and OTG mode for DWC2 USB
> >> controller.
> >>
> >> This fixes dtc W=1 warnings:
> >>
> >>   Warning (graph_child_address): /i2c-mhl/hdmi-bridge@39/ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary
> >>
> >> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> >> Cc: replicant@osuosl.org
> >> Cc: phone-devel@vger.kernel.org
> >> Cc: ~postmarketos/upstreaming@lists.sr.ht
> >> Cc: Martin Jücker <martin.juecker@gmail.com>
> >> Cc: Henrik Grimler <henrik@grimler.se>
> >> Cc: Artur Weber <aweber.kernel@gmail.com>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > 
> > Tested-by: Henrik Grimler <henrik@grimler.se>
> > 
> > * Peripheral mode (still) works
> > * MHL somewhat works
> > * OTG (still) does not work
> > 
> > Further details for those interested:
> > 
> > MHL works reliably if cable is attached before boot, but if cable is
> > attached on already running device it sometimes work after detaching
> > and attaching cable a few times.  On cable attach, when it does not
> > work, we get:
> > 
> >   [  252.831734] max77693-muic max77693-muic: external connector is detached(chg_type:0x0, prev_chg_type:0x0)
> >   [  253.733916] max77693-muic max77693-muic: external connector is attached(chg_type:0x1, prev_chg_type:0x1)
> >   [  253.735232] max77693-muic max77693-muic: CONTROL1 : 0x09, CONTROL2 : 0x04, state : attached
> >   [  254.691877] i2c i2c-15: sendbytes: NAK bailout.
> >   [  254.692150] sii9234 15-0039: writebm:  TPI[0x3d] <- 0x3e
> >   [  255.984336] sii9234 15-0039: RGND is not 1k
> >   [  256.068970] sii9234 15-0039: RSEN_HIGH without RGND_1K
> >   [  256.104457] sii9234 15-0039: discovery failed, no power for MHL?
> >   [  256.118272] i2c i2c-15: sendbytes: NAK bailout.
> >   [  256.118539] sii9234 15-0039: writebm:  TPI[0x3d] <- 0x3e
> >   [  256.375966] sii9234 15-0039: RSEN_HIGH without RGND_1K
> >   [  256.411561] sii9234 15-0039: discovery failed, no power for MHL?
> > 
> > while when it works:
> > 
> >   [  175.348307] max77693-muic max77693-muic: external connector is detached(chg_type:0x1, prev_chg_type:0x0)
> >   [  175.349576] max77693-muic max77693-muic: CONTROL1 : 0x00, CONTROL2 : 0x01, state : detached
> >   [  179.304373] dwc2 12480000.usb: new device is full-speed
> >   [  179.305920] max77693-muic max77693-muic: external connector is detached(chg_type:0x0, prev_chg_type:0x0)
> >   [  180.205735] max77693-muic max77693-muic: external connector is attached(chg_type:0x1, prev_chg_type:0x1)
> >   [  180.207211] max77693-muic max77693-muic: CONTROL1 : 0x09, CONTROL2 : 0x04, state : attached
> >   [  180.309727] i2c i2c-15: sendbytes: NAK bailout.
> >   [  180.309996] sii9234 15-0039: writebm:  TPI[0x3d] <- 0x3e
> > 
> > Not sure if issue here is in muic driver or sii9234 driver.
> > 
> > OTG still does not seem to work, the muic driver detects (only) a
> > detach when OTG cable is attached:
> > 
> >   max77693-muic max77693-muic: external connector is detached(chg_type:0x0, prev_chg_type:0x0)
> > 
> > Same happened when otg cable was attached before these hsotg changes
> > as well. I suppose issue here is with max77693-muic driver.
> > 
> 
> Thanks for testing. I miss here one important thing - did anything
> regressed? Is MHL behaving not worse than before? OTG, as non-working,
> matters less in such case.

No regressions as far as I can tell, only improvements.  We want the
muic node and mhl_to_muic/muic_to_mhl ports so that muic can notify
the mhl chip of cable attachment/detachment (with requires an
additional patch to the sii9234 driver that I will send soon [1]).
The alternative, having the mhl chip always on, has caused issues with
some GUIs [2].

> Best regards,
> Krzysztof

[1] https://gitlab.com/exynos4-mainline/linux/-/commit/742d05797799
[2] https://gitlab.gnome.org/World/Phosh/phosh/-/issues/828#note_1542189

Best regards,
Henrik Grimler
