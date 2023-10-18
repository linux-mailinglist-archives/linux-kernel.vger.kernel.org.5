Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5177CD663
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344584AbjJRI1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjJRI1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:27:15 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE64B6;
        Wed, 18 Oct 2023 01:27:13 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 85E1860018;
        Wed, 18 Oct 2023 08:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697617631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YZ6/blhVqXcitNe516+tjnjApU7Lkkx3Z1Lh/AJ/Ves=;
        b=GOp5F5jA93HhAFPSuu7MPFLAzhDgujjWx/mfyZO/I1w83nLBLzw4KNQaYnxoKH6/6n17o/
        qgv5cfb6o8ae8i8v0RTyKihBpK6KpsKjE5TgYbFlFwQWnHviCCWCOmceg6j6NdupCX2Yiz
        S/meJKpvt1SDgZYSns1C9LlRuxXZ5aoqedLAPmhWzsFP+Njgmav0a/SHsnn79GAYcZnmXT
        wKOiOCVMG+AFdC76DNkB2K84RM4EZo6nojU/HO7vtbvpONvh84SFEDQmB1dP8Kes48PvT7
        sg5dq4y2Q87ZtCEgvt/qzVmoWxEHCmHMcDNVimnoOqvL3g+DEIHjNRi57vUnlg==
Date:   Wed, 18 Oct 2023 10:27:05 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Romain Perier <romain.perier@gmail.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Daniel Palmer <daniel@0x0f.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/3] Add RTC for MStar SSD20xD SoCs
Message-ID: <20231018082705acb3df9d@mail.local>
References: <20230913151606.69494-1-romain.perier@gmail.com>
 <169746807623.26616.11393539981836060067.b4-ty@bootlin.com>
 <CABgxDoLd7F9kZXsoXtwizPgU6N905XdviEjtoyu6-dARGbyHYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgxDoLd7F9kZXsoXtwizPgU6N905XdviEjtoyu6-dARGbyHYw@mail.gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/2023 08:09:10+0200, Romain Perier wrote:
> Le lun. 16 oct. 2023 à 16:55, Alexandre Belloni
> <alexandre.belloni@bootlin.com> a écrit :
> >
> >
> > On Wed, 13 Sep 2023 17:16:03 +0200, Romain Perier wrote:
> > > This patches series adds a new driver for the RTC found in the Mstar
> > > SSD202D SoCs. It adds a basic rtc driver, the corresponding devicetree
> > > bindings.
> > >
> > > The rtctest (from selftests) has been passed on this driver, with the
> > > following output:
> > >
> > > [...]
> >
> > Applied, thanks!
> 
> Hi,
> 
> Thanks!
> 
> >
> > [1/3] rtc: Add support for the SSD202D RTC
> >       commit: ebf6255868e6141c737cacb8d62b0b347f344877
> > [2/3] dt-bindings: rtc: Add Mstar SSD202D RTC
> >       commit: cfb67623ce281e045ec11e3eddb1b68b879b53a1
> >
> > Best regards,
> 
> Ah , you also merged dt-bindings, Conor (from dt maintainers) prefers
> trivial-rtc.yaml, it makes sense with the current driver.
> I planned to make the change for trivial-rtc in v3, so I can adapt the
> commit and rename  mstar,ssd202d-rtc.yaml to trivial-rtc.yaml, what do
> you think ?
> 

This is fine as-is.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
