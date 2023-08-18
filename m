Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0757D780F8E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378308AbjHRPrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378303AbjHRPrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:47:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9693BF;
        Fri, 18 Aug 2023 08:47:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FC8C617A7;
        Fri, 18 Aug 2023 15:47:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB7AC433C8;
        Fri, 18 Aug 2023 15:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692373658;
        bh=UJoBya+wdS9sWcpW5mjYgKHW60p+meiYnGzDA/IaDSM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=L0yaXP2oATAqSCXMvSAwxjWzaZtukjl4iKkscqm2A8oU1zjn7aJixPofHhfHJP9yN
         uaCuFsmVhp6w1EH1ChEXwBOqFeUb1RC3++06i3gckcNbAy3E+xxMhnao9MeMECBDG8
         sTjWxwZyr6Eedz5nVfosqfa3RO0ayhTFqts4zQ/LoDbQYFNcGJCROLJhBqtfv04XOR
         7MoMelTOVBOSVuoEI82iwdag29oOvnxx5CEdNtu6ERgUe5kROxGygGgdmVaFYP70Mw
         rdW66MTmTXQfGmSw87ToXzz4yM1EZyLWnhfzX2jGJ1RUEAvAvzvTY5utV6uEU3W7rK
         z158YDZJ3YGSA==
From:   Lee Jones <lee@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nikita Travkin <nikita@trvn.ru>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
In-Reply-To: <20230815-aw2013-vio-v3-0-2505296b0856@gerhold.net>
References: <20230815-aw2013-vio-v3-0-2505296b0856@gerhold.net>
Subject: Re: [PATCH v3 0/3] leds: aw2013: Document interrupt and pull-up
 supply
Message-Id: <169237365663.1285443.14239471615825184081.b4-ty@kernel.org>
Date:   Fri, 18 Aug 2023 16:47:36 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2023 19:21:03 +0200, Stephan Gerhold wrote:
> AW2013 has an optional interrupt pin "INTN" which is used to report
> completion of started operations (e.g. power up or LED breath effects).
> The driver does not use it (yet) but it should be already described for
> completeness inside the DT schema.
> 
> Since the interrupt and I2C lines operate in open drain low active mode
> a pull-up supply is needed for correct operation. Unfortunately there
> is no ideal place to describe it in the DT: The pull-up needed for the
> I2C lines could be described on the I2C bus. However, the pull-up
> needed for the interrupt line belongs neither directly to the interrupt
> controller nor to AW2013. Since the AW2013 driver will be typically in
> control of the power management and interrupt masking it makes more
> sense to describe it inside the AW2013 device tree node.
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: leds: aw2013: Document interrupt
      commit: 9422bcf125b94e553c795af4f6c59d8e8fd8affa
[2/3] dt-bindings: leds: Document pull-up supply for interrupt and I2C
      commit: 2cccb179addedff6a5234e37237fc6b22d9217d4
[3/3] leds: aw2013: Enable pull-up supply for interrupt and I2C
      commit: baca986e1f2c31f8e4b2a6d99d47c3bc844033e8

--
Lee Jones [李琼斯]

