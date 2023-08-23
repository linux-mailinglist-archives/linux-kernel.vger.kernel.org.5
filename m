Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CA6785912
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjHWNU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbjHWNU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:20:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E44E78;
        Wed, 23 Aug 2023 06:20:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 784FB66287;
        Wed, 23 Aug 2023 13:19:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FAB1C433CA;
        Wed, 23 Aug 2023 13:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692796744;
        bh=OvhIgHZmORNVFi07F01ZpcKqdw0vzuMy5UHAeo7OqEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GsNnBmyhVMn7ydJeXv+04oBIi8+t+UBbIV1WfVTVptD1nJGHfYr5Zb1JCWSoLTZun
         pdJCuhTO8fLiV7ryRY2DJJCE8XNocPVCyfiWJSo4MTLUgBVsGk4kKr8UTdfmDROFtq
         Ad4yZioJ3vs4ML6CxK4dtneFlUC6a/qURrhtnNf4NeuG609O00yvuG37MKh75rL58k
         KbAIwsppMgv+fdnDzyHkAGgbDdGjeCwyz8wvevFjPdpYQV6KDSR8JmaBL2hy5xQ2Jx
         xZ9vTxcCmoCQDiijUHghe1pK+GvF2ByAsGsrFxqh+g4H/LVF9L9oHtV3pSV4XIzWTK
         f3tvm6XhHO1fQ==
Received: (nullmailer pid 2200303 invoked by uid 1000);
        Wed, 23 Aug 2023 13:19:01 -0000
Date:   Wed, 23 Aug 2023 08:19:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Walker Chen <walker.chen@starfivetech.com>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        Jose Abreu <joabreu@synopsys.com>,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v2 4/5] riscv: dts: starfive: pinfunc: Fix the pins name
 of I2STX1
Message-ID: <169279674097.2200246.2480753930062149907.robh@kernel.org>
References: <20230821144151.207339-1-xingyu.wu@starfivetech.com>
 <20230821144151.207339-5-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821144151.207339-5-xingyu.wu@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 21 Aug 2023 22:41:50 +0800, Xingyu Wu wrote:
> These pins are actually I2STX1 clock input, not I2STX0,
> so their names should be changed.
> 
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---
>  arch/riscv/boot/dts/starfive/jh7110-pinfunc.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

