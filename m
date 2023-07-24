Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09EB75F3F9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbjGXK4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbjGXK4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:56:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCB4F3;
        Mon, 24 Jul 2023 03:56:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 071E261024;
        Mon, 24 Jul 2023 10:56:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E88C433CC;
        Mon, 24 Jul 2023 10:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690196164;
        bh=fmxnvoejdFZOpBQwVOto+Rn/EHV8CKg6qU0x1MUF2xM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=EZnVcVivr/FPKlzIEyof3xHDAFfW1CbOTVmMEFbTeCL+apzC/e8ez2TqyHjNRfyEE
         j5rqL9caI/ujW654SwJu62g+oF1e9h6tvr6zcQhWaxYXWwi6nqB/7x/6VcP1WE00+U
         jUWq2tGHhTCSFNc5GOUEOSqnw0d/QGjOKuCA0QF1s8Y1xolvNUUGs5gMj9O7B+CLJ2
         bxNHpXmvrOJ7uEgTazU+7PtSbder2jP96zDxcdG0dwOUAwz/3frHxEmBO4znSMpyQY
         xjzTI7n2Hx2+S7q22BVSsTaGfWJHyDvRUAxnQD/SE799dalaqhBR+JfF7iGU1Z1u2N
         G+OGRbtdi8N4Q==
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Roger Quadros <rogerq@kernel.org>,
        Changhuang Liang <changhuang.liang@starfivetech.com>
Cc:     Minda Chen <minda.chen@starfivetech.com>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230718070803.16660-1-changhuang.liang@starfivetech.com>
References: <20230718070803.16660-1-changhuang.liang@starfivetech.com>
Subject: Re: [PATCH v7 0/2] Add JH7110 MIPI DPHY RX support
Message-Id: <169019616097.466601.2000211184274688881.b4-ty@kernel.org>
Date:   Mon, 24 Jul 2023 16:26:00 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Jul 2023 00:08:01 -0700, Changhuang Liang wrote:
> This patchset adds mipi dphy rx driver for the StarFive JH7110 SoC.
> It is used to transfer CSI camera data. The series has been tested on
> the VisionFive 2 board.
> 
> This patchset should be applied after the patchset [1]:
> [1] https://lore.kernel.org/all/20230629075115.11934-1-minda.chen@starfivetech.com/
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: phy: Add starfive,jh7110-dphy-rx
      commit: ae07a9a865a4eb30223c21eae70ddb189da6ee9a
[2/2] phy: starfive: Add mipi dphy rx support
      commit: f8aa660841bca12aed51c967ed9bdaf1d97996ed

Best regards,
-- 
~Vinod


