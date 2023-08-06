Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05FF7713C7
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 08:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjHFGfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 02:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHFGfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 02:35:46 -0400
Received: from out-97.mta1.migadu.com (out-97.mta1.migadu.com [IPv6:2001:41d0:203:375::61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C861FDB
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 23:35:43 -0700 (PDT)
Date:   Sun, 6 Aug 2023 16:33:45 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1691303741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5QcmFk87OSOnLQz2aC/rzCVz9SI5NqtxQgcc/xuSFnA=;
        b=LO2GkUBlLmae2f6NePMseHTBEkOx1tEX3Yh/67CHOPK6ihrmJRjULSCAwvj14677WkG0qT
        7COuiuLJW7wr4nYYQa+EzPAzxWSUxZ7vga+KLjBqeqkm0pttUvzjLNMUgzghEmohDlhhei
        YdJxam8rOiLsBK8F5Rt7wAPHwc3zQYeicMhrWYj+/04OMt+2YzWvs+v8vP1900mSbuNMUa
        F4mt7aFnA/RuP2aAi8FI26v7Havt2VjuUy73zzQrgyY6JWvsWCAT5TX9IZjc7VLorDKy3f
        /YgmTjXbgrgtHZy87OmgUAOxHnEFQZ965CsSdbYcurOl89yc4rtzvg8NPK0VIA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   John Watts <contact@jookia.org>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     Maksim Kiselev <bigunclemax@gmail.com>, aou@eecs.berkeley.edu,
        conor+dt@kernel.org, davem@davemloft.net,
        devicetree@vger.kernel.org, edumazet@google.com,
        krzysztof.kozlowski+dt@linaro.org, kuba@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sunxi@lists.linux.dev, mkl@pengutronix.de,
        netdev@vger.kernel.org, pabeni@redhat.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org, samuel@sholland.org,
        wens@csie.org, wg@grandegger.com
Subject: Re: [PATCH v2 2/4] riscv: dts: allwinner: d1: Add CAN controller
 nodes
Message-ID: <ZM8-yfRVscYjxp2p@titan>
References: <20230721221552.1973203-4-contact@jookia.org>
 <20230805164052.669184-1-bigunclemax@gmail.com>
 <ZM5-Ke-59o0R5AtY@titan>
 <2690764.mvXUDI8C0e@jernej-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2690764.mvXUDI8C0e@jernej-laptop>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2023 at 07:49:51PM +0200, Jernej Škrabec wrote:
> Dne sobota, 05. avgust 2023 ob 18:51:53 CEST je John Watts napisal(a):
> > On Sat, Aug 05, 2023 at 07:40:52PM +0300, Maksim Kiselev wrote:
> > > Hi John, Jernej
> > > Should we also keep a pinctrl nodes itself in alphabetical order?
> > > I mean placing a CAN nodes before `clk_pg11_pin` node?
> > > Looks like the other nodes sorted in this way...
> > 
> > Good catch. Now that you mention it, the device tree nodes are sorted
> > by memory order too! These should be after i2c3.
> > 
> > It looks like I might need to do a patch to re-order those too.
> 
> It would be better if DT patches are dropped from netdev tree and then post 
> new versions.
> 
> Best regards,
> Jernej

Agreed. Is there a way to request that? Or will the maintainer just read this?

John.
