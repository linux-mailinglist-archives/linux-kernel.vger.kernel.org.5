Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA0A769CDE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbjGaQhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjGaQhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:37:32 -0400
X-Greylist: delayed 817 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 31 Jul 2023 09:36:55 PDT
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E462702;
        Mon, 31 Jul 2023 09:36:55 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C808F2C5;
        Mon, 31 Jul 2023 16:36:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C808F2C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1690821387; bh=vT9+AdeVvhBOv2Sa89E+y1k/NCghCUjoEhjX3awobsU=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=PUd0WzC3pMwP2yuVngqdFIeoxUAIY3w3F3IYhmYoXZAgpAFsC2XUfm24zxmkkYh3Y
         1Bv/fELc8rknnCcqQzBSnCa4DZo2Bt0vi8izGXaXZYK6n8pWe79UF2Jg99NYMLIQaZ
         XktX579Hjb1xKvGUm7ZDA57mqPqNRJ/PI/DXJTutBFM4QOY1hmtZoaog5c5u4gPEF/
         LfrGghcSHtRX/rtIS/2p8YQyK/PrLA+BjE35RDWYTcgZp/3P34chG0gCbZUbSVdkCl
         7gFYyfnnhtUO9spxXF7Y27Ti2buKO2V6+rYS+I0tkT0qvpCeNAbn0wnVYwFHvsKtGr
         nHlrJOjvEUKqA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Costa Shulyupin <costa.shul@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Costa Shulyupin <costa.shul@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Wu XiangCheng <bobwxc@email.cn>,
        Paul Cercueil <paul@crapouillou.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH] docs: move mips under arch
In-Reply-To: <20230725043835.2249678-1-costa.shul@redhat.com>
References: <20230725043835.2249678-1-costa.shul@redhat.com>
Date:   Mon, 31 Jul 2023 10:36:27 -0600
Message-ID: <87pm48ca2c.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Costa Shulyupin <costa.shul@redhat.com> writes:

> and fix all in-tree references.
>
> Architecture-specific documentation is being moved into Documentation/arch/
> as a way of cleaning up the top-level documentation directory and making
> the docs hierarchy more closely match the source hierarchy.
>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  Documentation/arch/index.rst                                  | 2 +-
>  Documentation/{ => arch}/mips/booting.rst                     | 0
>  Documentation/{ => arch}/mips/features.rst                    | 0
>  Documentation/{ => arch}/mips/index.rst                       | 0
>  Documentation/{ => arch}/mips/ingenic-tcu.rst                 | 0
>  Documentation/devicetree/bindings/timer/ingenic,tcu.yaml      | 2 +-
>  Documentation/translations/zh_CN/arch/index.rst               | 2 +-
>  Documentation/translations/zh_CN/{ => arch}/mips/booting.rst  | 4 ++--
>  Documentation/translations/zh_CN/{ => arch}/mips/features.rst | 4 ++--
>  Documentation/translations/zh_CN/{ => arch}/mips/index.rst    | 4 ++--
>  .../translations/zh_CN/{ => arch}/mips/ingenic-tcu.rst        | 4 ++--
>  MAINTAINERS                                                   | 2 +-
>  12 files changed, 12 insertions(+), 12 deletions(-)
>  rename Documentation/{ => arch}/mips/booting.rst (100%)
>  rename Documentation/{ => arch}/mips/features.rst (100%)
>  rename Documentation/{ => arch}/mips/index.rst (100%)
>  rename Documentation/{ => arch}/mips/ingenic-tcu.rst (100%)
>  rename Documentation/translations/zh_CN/{ => arch}/mips/booting.rst (92%)
>  rename Documentation/translations/zh_CN/{ => arch}/mips/features.rst (65%)
>  rename Documentation/translations/zh_CN/{ => arch}/mips/index.rst (79%)
>  rename Documentation/translations/zh_CN/{ => arch}/mips/ingenic-tcu.rst (97%)

Applied, thanks.

jon
