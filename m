Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6F27F0666
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 14:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjKSN0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 08:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKSNZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 08:25:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FDCB7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 05:25:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5B6C433C7;
        Sun, 19 Nov 2023 13:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700400355;
        bh=MuFb6Jk9Fj76Lk+Y+AfZIu/0pw2dOjOHcPcPCdb0bN0=;
        h=From:To:Cc:Subject:Date:From;
        b=GOx03R5nPTBsQnissHt8HthhnhQrIwZoWcMEeXlxxS2qVhJ0T92DKCneDDOWYF7SB
         b0AbiMh+Wgvv0gQpynwxysouNqvSPBa9b6R7TZ/UTNnnxWC9Je7K7i9C9L29jQUsbC
         5yYbGYggAmUXZtIf6SLdAL9J2hAgwJddAaMsSzccRfztFCIG1+dKoSB+vJPsYJwCZv
         RgWZ9HmsvJv836LDg6p0o6oXZlA9vEDZOSyas29qY4PFjOeU7KAoj0vJOXMuRINu6E
         dma626QmB3gHpnc3w5pgxF6bUKdRDTePXrXU9Hqfktdxat0cMJnvR96iJiDE5LNwAZ
         /YfulcGiB8N+A==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH 0/2] nvmem: Add Sophgo eFuse driver
Date:   Sun, 19 Nov 2023 21:13:30 +0800
Message-Id: <20231119131332.999-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sophgo SoCs such as CV1800B contain eFuses used to store
factory-programmed data such as calibration values for the built-in
ethernet PHY.

As for CV1800B, HW automatically loads the eFuse content into CONTENT
base registers which are organized as 32bit values exposed as MMIO.

Currently, add read support for the eFuse. This is a preparation step
for supporting the built-in ethernet phy.

Since the clk support isn't mainlined, so cv1800b DT patches are not
included.

Jisheng Zhang (2):
  dt-bindings: nvmem: Add sophgo,efuses
  nvmem: Add Sophgo eFuse driver

 .../bindings/nvmem/sophgo,efuse.yaml          | 54 +++++++++++
 drivers/nvmem/Kconfig                         | 13 +++
 drivers/nvmem/Makefile                        |  2 +
 drivers/nvmem/sophgo-efuse.c                  | 97 +++++++++++++++++++
 4 files changed, 166 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/sophgo,efuse.yaml
 create mode 100644 drivers/nvmem/sophgo-efuse.c

-- 
2.42.0

