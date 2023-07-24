Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A9175F3F6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbjGXK4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjGXK4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:56:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD8690;
        Mon, 24 Jul 2023 03:55:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 210C261090;
        Mon, 24 Jul 2023 10:55:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3540C433C7;
        Mon, 24 Jul 2023 10:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690196158;
        bh=V93FsATGQZq3mYichbx3eTNdkqE25WFY/z76Vc1YDZ8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=DdIUSIyANh6xVb8UzU91hyDr1IjUOoh4kNO+pWXoEh1RVvH2xzH5P2J3inXWl3NH1
         srORuthKzd/VjYfTRCw2m7VHeQv7dOHZFdHEwfWcD77EhMzZgkQMoizKMcMoeAIFS6
         JdSPbEewf0aKQ7QaEJk75p0tbcpghew6B9+W1zG0qJn86NmoECpgJtYneUtNTog9b/
         GmVsNCq0JMiYd+Cf+rn59SiPq2ozzKcc/pIe+GlRpBI7/GGoSgkNLi4PWrCDhisNz6
         +SWZfhGTg7KDnOTFHw/NkipxjH3sk8mW07X1Dk4cFF16pygdfitrMYuN+7zFsfMI0h
         adPFo2MuSzNTw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Changhuang Liang <changhuang.liang@starfivetech.com>
Cc:     Jack Zhu <jack.zhu@starfivetech.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230630093056.46904-1-changhuang.liang@starfivetech.com>
References: <20230630093056.46904-1-changhuang.liang@starfivetech.com>
Subject: Re: [PATCH v6 0/2] Add JH7110 MIPI DPHY RX support
Message-Id: <169019615549.466601.16136359064453878299.b4-ty@kernel.org>
Date:   Mon, 24 Jul 2023 16:25:55 +0530
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


On Fri, 30 Jun 2023 02:30:54 -0700, Changhuang Liang wrote:
> This patchset adds mipi dphy rx driver for the StarFive JH7110 SoC.
> It is used to transfer CSI camera data. The series has been tested on
> the VisionFive 2 board.
> 
> changes since v5:
> - Rebased on tag v6.4.
> - Dropped patch 3. Because it depends on the submission of others, it will be
>   upstream separately later.
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


