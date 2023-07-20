Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06AA75AAC7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjGTJ3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjGTJ3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:29:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026EF39617;
        Thu, 20 Jul 2023 02:16:06 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2B1A2660707E;
        Thu, 20 Jul 2023 10:16:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689844564;
        bh=VQVHxYOM6hnehsm7LQCNWxsE21hJxKDbC6hCV2WtWBU=;
        h=From:To:Cc:Subject:Date:From;
        b=RhAaqN6XdmcSyWwQMcFmjpM+D8oocH0N+atGU5/kU0zIyNRZXT1kIAVdjI5YAL05I
         cnbBBswGoAMR8KSZE56+43VpxUr7vkxHRUK0hi931bw9X/TQb6kUU2jkCi8YmwFn4U
         c2mz2kbc+561elz6OGj342ASa/nrYoq54XOb4z9SFisboXnD3gFScqI8CjNUW5gNCw
         ED/cUiJFpZ39r+yooLTph6lqXVYTQgJNhUQnoXCErmdUQ/A834Hh6Fnal0vRI6hFep
         tqy66NCviG/BIbc1Jz42Lc8Q1fc5pHPzxdmu8M3KGdqcCqLCYk4st8GKuEv0dsG4tv
         BfZ9cS7ujml5g==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 0/3] MT6795 Helio X10 and Xperia M5: Display support
Date:   Thu, 20 Jul 2023 11:15:56 +0200
Message-Id: <20230720091559.86406-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds DSI display support for the MediaTek Helio X10 MT6795
and also adds support for the specific DSI display and its backlight,
found on the Sony Xperia M5 smartphone.

AngeloGioacchino Del Regno (3):
  arm64: dts: mediatek: mt6795: Add support for display blocks and
    DPI/DSI
  arm64: dts: mediatek: mt6795-xperia-m5: Add display backlight support
  arm64: dts: mediatek: mt6795-xperia-m5: Add DSI Display and its vregs

 .../dts/mediatek/mt6795-sony-xperia-m5.dts    | 101 +++++++
 arch/arm64/boot/dts/mediatek/mt6795.dtsi      | 252 ++++++++++++++++++
 2 files changed, 353 insertions(+)

-- 
2.40.1

