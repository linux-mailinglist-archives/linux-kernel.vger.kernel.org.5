Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5FE7EAEE1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 12:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbjKNL2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 06:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbjKNL2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 06:28:31 -0500
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B62618C;
        Tue, 14 Nov 2023 03:28:27 -0800 (PST)
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:7e5d:5300::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id CCFD28A;
        Tue, 14 Nov 2023 03:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1699961307;
        bh=lrjb3R930ljOh7CG6OzT9YtZ8E6C5RvGiZF7BWI0Czk=;
        h=From:To:Cc:Subject:Date:From;
        b=i2zDDYZC8EPC8BEFy65MFEjsIxJ03THdyoC6In9bI35GQgj2GDVylCI90jpQQUyaG
         g62VNoIuweDGoDqx3OM2Pk2qTf8K6+DECM1BOFmlou5OuxqYH+xZUpgkUUfe93jpI4
         ivyFzPLjan9AHMqMJeTJK3IKaxEOpwl1xmCz/GTw=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>
Cc:     Zev Weiss <zev@bewilderbeest.net>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: [PATCH 0/2] ARM: dts: aspeed: Add ASRock SPC621D8HM3 BMC
Date:   Tue, 14 Nov 2023 03:28:20 -0800
Message-ID: <20231114112819.28572-4-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

These patches add a device-tree (and a tiny bindings update) for the
Aspeed BMC on the ASRock SPC621D8HM3, so that it can be added as a
supported OpenBMC platform.

Thanks,
Zev


Zev Weiss (2):
  dt-bindings: arm: aspeed: document ASRock SPC621D8HM3
  ARM: dts: aspeed: Add ASRock SPC621D8HM3 BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../aspeed/aspeed-bmc-asrock-spc621d8hm3.dts  | 316 ++++++++++++++++++
 3 files changed, 318 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-spc621d8hm3.dts

-- 
2.42.0

