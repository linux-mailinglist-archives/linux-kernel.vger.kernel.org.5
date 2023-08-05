Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41692770F58
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 12:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjHEKpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 06:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjHEKpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 06:45:45 -0400
Received: from out-94.mta1.migadu.com (out-94.mta1.migadu.com [IPv6:2001:41d0:203:375::5e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCDC468C
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 03:45:43 -0700 (PDT)
Date:   Sat, 5 Aug 2023 20:42:59 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1691232338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FpB0D3mxI9kO/4n6kQP6vW7np01C4MPqEWX1agkDUuM=;
        b=gHfgjkGCHQ9obOeEfPj+rXReZOqs6s5Y3WfqT1BD5VbUn7wfUCTkIR1nmCvI4aTXO4b9Q3
        x+yNXqQkoCwG0YtlsPF7gPzZWnB93RJw0EnB+NnPGg6ABVyL8ZZXLwV29Dj/y6xwiVttd7
        ybaOzUh12C2oICB8d1EHO0Aof1e+7NaFFGwEJCWbGP3MVS01sQWOVFB/2zZI7TKQ4Bfwt6
        xk86AXc6c/yH/a6l5Cp5yhrQOqQpOqooqL6QHJB6DjVsgyzZN5SqVOv0ePnOFZrptXlCsu
        iB4nR3ob1y3DOFsDGM2FBZJGhI8GDfeLAD67J9k6P8RccZgR1A8N/z2bwUMAAQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   John Watts <contact@jookia.org>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     linux-sunxi@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mkl@pengutronix.de
Subject: Re: [PATCH] riscv: dts: allwinner: d1: Specify default CAN pins
Message-ID: <ZM4nswDuc5YBfEyV@titan>
References: <20230731023701.2581713-1-contact@jookia.org>
 <3248110.44csPzL39Z@jernej-laptop>
 <ZMyZ5kZSiiJHtdeS@titan>
 <5696365.DvuYhMxLoT@jernej-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5696365.DvuYhMxLoT@jernej-laptop>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 04:39:41PM +0200, Jernej Škrabec wrote:
> If you don't mind, please do.

Just to clarify, something like this:

                can0: can@2504000 {
                        pinctrl-names = "default";
                        pinctrl-0 = <&can0_pins>;
                        compatible = "allwinner,sun20i-d1-can";
                        reg = <0x02504000 0x400>;
                        interrupts = <SOC_PERIPHERAL_IRQ(21) IRQ_TYPE_LEVEL_HIGH>;
                        clocks = <&ccu CLK_BUS_CAN0>;
                        resets = <&ccu RST_BUS_CAN0>;
                        status = "disabled";
                };

I couldn't find any dtsi files that put pinctrl stuff at the top.

John.
