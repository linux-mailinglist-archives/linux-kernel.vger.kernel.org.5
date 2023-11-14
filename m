Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891DE7EAECB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 12:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbjKNL1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 06:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjKNL1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 06:27:35 -0500
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B79CC;
        Tue, 14 Nov 2023 03:27:31 -0800 (PST)
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:7e5d:5300::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id F22898A;
        Tue, 14 Nov 2023 03:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1699961251;
        bh=5M+pCx4Fen2Behvs2e4Id/PtAlxPW61twvTyrlTpuu8=;
        h=From:To:Cc:Subject:Date:From;
        b=kQHkJNbpAMvwbfrZZpJLnmCVYViYbt1PjXP+EaHC4P3pV+wtNc1TeVcwaRicx00Wx
         Esxfl+qpy6z7hFuhTKHesdngFuURMUHweVmYB62BwQEIUI/HEgaKFlQrSky41e59sl
         ytUSG36Ow2lfJmiwVoJscHdFAvEao4BIrJUb0gH4=
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
Subject: [PATCH 0/2] ARM: dts: aspeed: Add ASRock E3C256D4I BMC
Date:   Tue, 14 Nov 2023 03:27:23 -0800
Message-ID: <20231114112722.28506-4-zev@bewilderbeest.net>
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
Aspeed BMC on the ASRock E3C256D4I, so that it can be added as a
supported OpenBMC platform.

Thanks,
Zev


Zev Weiss (2):
  dt-bindings: arm: aspeed: document ASRock E3C256D4I
  ARM: dts: aspeed: Add ASRock E3C256D4I BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../aspeed/aspeed-bmc-asrock-e3c256d4i.dts    | 314 ++++++++++++++++++
 3 files changed, 316 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dts

-- 
2.42.0

