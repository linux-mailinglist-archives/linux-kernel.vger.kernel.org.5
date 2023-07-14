Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BBF753DF9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 16:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235883AbjGNOpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 10:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbjGNOpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:45:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45447213F;
        Fri, 14 Jul 2023 07:45:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFED361D27;
        Fri, 14 Jul 2023 14:45:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C58C433C7;
        Fri, 14 Jul 2023 14:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689345943;
        bh=DGbd0VWtacVrAzm6zW6x+FrQbCSf5aCaCOwo48a615k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BaU6WuOYZ0qIb0SGT+qZ7g+1HDR1xa6fwdGlCBrv+juQ3mUwbywqWoMw55ThCYVpE
         EgLRU7fZxJUGskYxdVBe27myjZt+7xXjarUSP51q9fu23KOJFuaTiq6mAoR48oe+Z9
         yS+Ty74blHdkrLGfbgHfhtHezDQlRDjlIL5B+B1Jt9xc7SHjHrUYe07gjg7fM3Phhy
         ut1FcAlTG7ooKHCYtXQiFSX/ZwlnvC2Lh4eKmJh1/hFSGeoxOrhthzUr6milR/nZDD
         uo7BtjbyFdhcn0kCK1q/om+8KnS7PDAszSQsyZ1u3bAvCWue6VCMEr7Hvi19Vz4Utf
         rmJcyL5hRbOwg==
Date:   Fri, 14 Jul 2023 20:15:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Changhuang Liang <changhuang.liang@starfivetech.com>
Cc:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] phy: starfive: Add mipi dphy rx support
Message-ID: <ZLFfkhnxZbRS7s9y@matsya>
References: <20230630093056.46904-1-changhuang.liang@starfivetech.com>
 <20230630093056.46904-3-changhuang.liang@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630093056.46904-3-changhuang.liang@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-06-23, 02:30, Changhuang Liang wrote:
> Add mipi dphy rx support for the StarFive JH7110 SoC. It is used to
> transfer CSI camera data.
> 
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  MAINTAINERS                                 |   7 +
>  drivers/phy/Kconfig                         |   1 +
>  drivers/phy/Makefile                        |   1 +
>  drivers/phy/starfive/Kconfig                |  13 ++
>  drivers/phy/starfive/Makefile               |   2 +
>  drivers/phy/starfive/phy-starfive-dphy-rx.c | 230 ++++++++++++++++++++
>  6 files changed, 254 insertions(+)
>  create mode 100644 drivers/phy/starfive/Kconfig
>  create mode 100644 drivers/phy/starfive/Makefile

This need rebase as files exist now

-- 
~Vinod
