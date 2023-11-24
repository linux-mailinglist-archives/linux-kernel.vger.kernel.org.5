Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0F57F8446
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 20:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346000AbjKXTZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 14:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345941AbjKXTZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 14:25:33 -0500
Received: from helios.alatek.com.pl (helios.alatek.com.pl [85.14.123.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A8B1BF8;
        Fri, 24 Nov 2023 11:25:39 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by helios.alatek.com.pl (Postfix) with ESMTP id DE5CA2CE00D3;
        Fri, 24 Nov 2023 20:25:36 +0100 (CET)
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10032)
 with ESMTP id bE0tyA43a6JX; Fri, 24 Nov 2023 20:25:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by helios.alatek.com.pl (Postfix) with ESMTP id 554EE2CE00D1;
        Fri, 24 Nov 2023 20:25:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 helios.alatek.com.pl 554EE2CE00D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alatek.krakow.pl;
        s=99EE5E86-D06A-11EC-BE24-DBCCD0A148D3; t=1700853932;
        bh=N9oNcNEz/+wUQVlPr2Fof+k+KhCs0HIeg5s/pAv6Gxo=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=YM4Yk35tldo7lFH8d6UM4t5DCS4Jf62jpH1bv4wpDXhh51Cxc5dwLL+J6oPqF/q5J
         O8kDG9C0GHFmxAlpQT9wvMroTgA+R+x0uw7gVncXnYfDZhxVM4Ui5VelCN/9TOruUu
         Bvaw9hqsuP3CXahlhTRJTUWfOtU/u4rTv/1jIJ5L2KbJWWsWeJgTyM849FNx9jLkJ9
         P4uWNNjVv2lovj6Fhpy36om6TpbotQ13sNeHFRFIflazeOQo9B/KECXXzfq4c9jAFD
         TlokJ8KD4UrjgPxxBjkyR+FGaVaXMgh9FtwZvpdU6yDPCtjds1kBvH8GORKDH6Otau
         Xgb1aCBDN1v+A==
X-Virus-Scanned: amavis at alatek.com.pl
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10026)
 with ESMTP id AeNaMHAkrmQn; Fri, 24 Nov 2023 20:25:32 +0100 (CET)
Received: from ideapad.. (unknown [10.0.2.2])
        by helios.alatek.com.pl (Postfix) with ESMTPSA id 11B052CE00D0;
        Fri, 24 Nov 2023 20:25:32 +0100 (CET)
From:   Jan Kuliga <jankul@alatek.krakow.pl>
To:     lizhi.hou@amd.com, brian.xu@amd.com, raj.kumar.rampelli@amd.com,
        vkoul@kernel.org, michal.simek@amd.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, runtimeca39d@amd.com
Cc:     Jan Kuliga <jankul@alatek.krakow.pl>
Subject: [PATCH v3 0/5] Miscellaneous xdma driver enhancements
Date:   Fri, 24 Nov 2023 20:25:24 +0100
Message-Id: <20231124192524.134989-1-jankul@alatek.krakow.pl>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series is pretty similar to the v1 version. I've named
it v3 because I've already sent a v2 patch as a reply to the message with
[PATCH 1/5]. The problem is, that this v2 patch is broken and
should be ignored. Sorry for that.

Jan

Changes since v1:
[PATCH 1/5]:=20
Complete a terminated descriptor with dma_cookie_complete()
Don't reinitialize temporary list head in xdma_terminate_all()
          =20
[PATCH 4/5]:
Fix incorrect text wrapping

Changes since v2:
[PATCH 1/5]:
DO NOT schedule callback from within xdma_terminate_all()

Here's the original message:

Hi,

This patch series introduces a couple of xdma driver enhancements, such
as two dmaengine callbacks, partial rework of a interrupt service
routine and loosening of dma_pool alignment requirements. I have tested
these changes with XDMA v4.1 (Rev. 20) block.

Jan
---

Jan Kuliga (5):
  dmaengine: xilinx: xdma: Add transfer termination callbacks
  dmaengine: xilinx: xdma: Get rid of duplicated macros definitions
  dmaengine: xilinx: xdma: Complete lacking register description
  dmaengine: xilinx: xdma: Rework xdma_channel_isr()
  dmaengine: xilinx: xdma: Ease dma_pool alignment requirements

 drivers/dma/xilinx/xdma-regs.h | 24 ++++------
 drivers/dma/xilinx/xdma.c      | 82 +++++++++++++++++++++++++++++-----
 2 files changed, 80 insertions(+), 26 deletions(-)


base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
--=20
2.34.1

