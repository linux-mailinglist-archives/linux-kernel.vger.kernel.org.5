Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048357AA88A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 07:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjIVFuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 01:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjIVFui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 01:50:38 -0400
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC52192;
        Thu, 21 Sep 2023 22:50:27 -0700 (PDT)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout3.routing.net (Postfix) with ESMTP id 7FED06054A;
        Fri, 22 Sep 2023 05:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1695361825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ED86tK2Vq5XtLhncWzK58V3rGjhhsqFD9oGClRJ2Dh4=;
        b=PL76FSDw0gaIlL/uJGUDHHikS5oxLaHQL7QHNsmEVb+rm5Kggsq0ktcU0LSQSHIvuL8xN8
        gb54hh3sd7nJHtaNdWWi1ecR6c+09KosP+k4tkMnhOxa4z9VsLd7nD+5gpXZxv+ubuMANP
        +/+RX6U42D1H4PMsM/xvKZKJsNdWXAg=
Received: from frank-G5.. (fttx-pool-217.61.149.125.bambit.de [217.61.149.125])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id 6847B4021D;
        Fri, 22 Sep 2023 05:50:24 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/4] add LVTS support for mt7988
Date:   Fri, 22 Sep 2023 07:50:16 +0200
Message-Id: <20230922055020.6436-1-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mail-ID: 3c8c9fa6-0274-4355-a868-cc9d80e6d39d
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

This series makes allows soc specific temperature coefficients
and adds support for mt7988 which has a different one.

Frank Wunderlich (4):
  dt-bindings: thermal: mediatek: add mt7988 lvts compatible
  dt-bindings: thermal: mediatek: Add LVTS thermal sensors for mt7988
  thermal/drivers/mediatek/lvts_thermal: make coeff configurable
  thermal/drivers/mediatek/lvts_thermal: add mt7988 support

 .../thermal/mediatek,lvts-thermal.yaml        |  1 +
 drivers/thermal/mediatek/lvts_thermal.c       | 89 +++++++++++++++----
 .../thermal/mediatek,lvts-thermal.h           |  9 ++
 3 files changed, 82 insertions(+), 17 deletions(-)

-- 
2.34.1

