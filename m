Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A48F781EC6
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 17:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjHTPkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 11:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjHTPkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 11:40:08 -0400
Received: from mxout4.routing.net (mxout4.routing.net [IPv6:2a03:2900:1:a::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2384481;
        Sun, 20 Aug 2023 08:40:01 -0700 (PDT)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout4.routing.net (Postfix) with ESMTP id 24D17100105;
        Sun, 20 Aug 2023 15:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1692545512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0ttFFnddrbDryzWp+rWK4n1Z6VL4bZZQrFTzcJyGs58=;
        b=w5JJ9w5khdAuJc2SElQWlR9qQ5wuEVb6rv0evDXW2Djfaf2G2fg2dBZKH04oRUL7gO8phb
        o5PuNHHGq8UODCZsXaXDz29Uuj1OlwB7K4vkEf48mmCHRPUQsvScQ5VqUT6gmLsHY73Yge
        l4jwrwCNRwm0q1GJODnnctW7gsJUkJA=
Received: from frank-G5.. (fttx-pool-80.245.78.65.bambit.de [80.245.78.65])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id 30220401CF;
        Sun, 20 Aug 2023 15:31:51 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Golle <daniel@makrotopia.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 0/3] mt7986 DTS fixes
Date:   Sun, 20 Aug 2023 17:31:32 +0200
Message-Id: <20230820153135.42588-1-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 4bbdd863-5dcb-4cc8-96d8-e32299f3a55c
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

It turned out that some SFP needs more power than the default 1W and
cooling-trips can be defined a bit better.

Frank Wunderlich (3):
  arm64: dts: mt7986: define 3W max power to both SFP on BPI-R3
  arm64: dts: mt7986: change cooling trips
  arm64: dts: mt7986: change thermal trips on BPI-R3

 .../dts/mediatek/mt7986a-bananapi-bpi-r3.dts  | 12 ++++++-----
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi     | 20 +++++++++++++++----
 2 files changed, 23 insertions(+), 9 deletions(-)

-- 
2.34.1

