Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D4E7A6626
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 16:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjISOGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 10:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbjISOGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:06:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD78AF5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 07:06:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79ED2C433C7;
        Tue, 19 Sep 2023 14:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695132362;
        bh=Au0tYJFBzY+b2GsyFowbgzsLK8RD3H1TYDFRNcAe8aQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=bb3RpRnosGQRe7O+/hqhAtRwc3ryWG0yyv9fCDNvGyZqpJEDQQnJ54MoYQMEHzGcr
         pfk6NxUheGN4cjj879cpOw8jd+88SzE9gXAm6NwV1/5+Gww/N5jbylOh7aLl/v4Swm
         87yn1PLi1dVzREyCiPWVQ/q7jZ5VLA4nVQP8wRpnOLpAZXwbfNl7RQzJMV6TS8zaNr
         qlCNDm+Lj+qdshB/bOrr4b4whaAua03RHRDpGNSSCDYkyUfzRZZv2m0ZBl7O7X9rUa
         KKRU0PYKErNrtsm1CPQePeY9ZMxX5rcPIphRJsDBeW/+VJYB0ftxpbGZvl9cSFuixp
         T3hReSUIhNO1w==
From:   Lee Jones <lee@kernel.org>
To:     Lee Jones <lee@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Woody Zhang <woodylab@foxmail.com>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <tencent_E54C7156F583E15FFE320E576E3389C39A08@qq.com>
References: <tencent_E54C7156F583E15FFE320E576E3389C39A08@qq.com>
Subject: Re: (subset) [PATCH] mfd: cs42l43: Fix Kconfig dependency
Message-Id: <169513236122.3230275.16216498057995173457.b4-ty@kernel.org>
Date:   Tue, 19 Sep 2023 15:06:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Sep 2023 19:41:00 +0800, Woody Zhang wrote:
> MFD_CS42L43 depends on REGMAP_IRQ as it uses devm_regmap_add_irq_chip.
> Otherwise the build may fail with following log.
> 
>   AR      drivers/built-in.a
>   AR      built-in.a
>   AR      vmlinux.a
>   LD      vmlinux.o
>   OBJCOPY modules.builtin.modinfo
>   GEN     modules.builtin
>   MODPOST Module.symvers
> ERROR: modpost: "devm_regmap_add_irq_chip" [drivers/mfd/cs42l43.ko] undefined!
> 
> [...]

Applied, thanks!

[1/1] mfd: cs42l43: Fix Kconfig dependency
      commit: 9ef4dc24eb85f9e95ef183d09ae622b8efc34783

--
Lee Jones [李琼斯]

