Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811737D721D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 19:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbjJYRJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 13:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbjJYRIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 13:08:51 -0400
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622E3111
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:08:46 -0700 (PDT)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout3.routing.net (Postfix) with ESMTP id E17B4625F9;
        Wed, 25 Oct 2023 17:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1698253723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0665A9x6QlRYnS9Etes7tT5/Mif1F5zTWwPvutSrAPg=;
        b=rvm/NFkLEWSsqXzjols28RiFyiBk3ob7Vu3l+nD0eM5i8ATrLKUYssp+YNqtdh1TCha588
        rMyUaLd8CMGOuKBZHHew6GTy+oisu+5lNgCXvIeXh1qpdZtkDrR0bR1WzCo0txtZX521nA
        tl1P6mEWEdf4N2WqWfL+vbpxwZR3W90=
Received: from frank-G5.. (fttx-pool-217.61.159.50.bambit.de [217.61.159.50])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 1092A3607E4;
        Wed, 25 Oct 2023 17:08:42 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Golle <daniel@makrotopia.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v2 0/5] mt7986 DTS Patches
Date:   Wed, 25 Oct 2023 19:08:27 +0200
Message-Id: <20231025170832.78727-1-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 17890061-734c-4475-9c1d-3c0bf0eeb55e
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Hi,

i collected the open dts patches for mt7986 to make it easier for mtk
maintainer to pick them up.

so the following patches/series are superseeded:

- Fix emmc hs400 mode on mt7986
  https://patchwork.kernel.org/project/linux-mediatek/list/?series=761293
- mt7986 DTS fixes (for thermal and sfp)
  https://patchwork.kernel.org/project/linux-mediatek/list/?series=777712
- arm64: dts: mediatek: add dtbs with applied overlays for bpi-r3
  https://patchwork.kernel.org/project/linux-mediatek/patch/20230916083214.7059-1-linux@fw-web.de/
- arm64: dts: mt7986: add overlay for SATA power socket on BPI-R3
  https://patchwork.kernel.org/project/linux-mediatek/patch/20230901072730.13571-1-linux@fw-web.de/

updated the dtbs overlay patch to make it better readable based on 
arm64/boot/dts/ti/Makefile and squashed 2 patches from the thermal-zone
series.

sidenote for angelo: after this series only the thermal driver patch is
open from the list i've sent to you if this goes through your tree.

regards Frank

Eric Woudstra (1):
  arm64: dts: mt7986: fix emmc hs400 mode without uboot initialization

Frank Wunderlich (4):
  arm64: dts: mt7986: define 3W max power to both SFP on BPI-R3
  arm64: dts: mt7986: change cooling trips
  arm64: dts: mt7986: add dtbs with applied overlays for bpi-r3
  arm64: dts: mt7986: add overlay for SATA power socket on BPI-R3

 arch/arm64/boot/dts/mediatek/Makefile         | 27 +++++++++++++
 .../mt7986a-bananapi-bpi-r3-sata.dtso         | 39 +++++++++++++++++++
 .../dts/mediatek/mt7986a-bananapi-bpi-r3.dts  | 12 +++---
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi     | 24 ++++++++++--
 4 files changed, 93 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sata.dtso

-- 
2.34.1

