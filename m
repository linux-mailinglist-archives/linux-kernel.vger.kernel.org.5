Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220A17FF35C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346216AbjK3PTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346190AbjK3PTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:19:42 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F76C10F0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:19:48 -0800 (PST)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 88FAC42241
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1701357586;
        bh=umcOEKGECYpQBlUdbsEVmcT1M/LVbcCDI05+VTUKHOE=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=bsIZfcxu6oOBMAxcaERG66KV7rpU3faN26czl6D3F3f7w/pLBBWnESFDUQDScqEaW
         OEByqrIKGnx8WhTHswd909isoHLLPOj+kzLkYdJOFJ3j5k135K1/vm6T5BEvwpPd5b
         tvWaB6dDsF4Md/vp71K8CZU8pyeTWT+efzB+66/FESBQ8mF7Ay/P/Xx3T8eoufbuc8
         JnyK8aJZHbKvlbmAuIbOIvPsSyv2mwbyInfeCNXX9Qfi2YzKBxiQgitFhi7/bhu2+i
         UIMVAcmkwqkpKQpJ6U1ZMhyUKXuGYWBQ4fGEz0LFGeYavIZNwXh5V9B2D+4jPDPfKp
         dmw6K54h17C4g==
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6cbcd3e9758so1102649b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:19:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701357585; x=1701962385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=umcOEKGECYpQBlUdbsEVmcT1M/LVbcCDI05+VTUKHOE=;
        b=r8WO6NoheixL8zdObzalGxRHNYuyqck5b9a6VL/XdMlCMLC96Nkix1Grz+ntoCx6qp
         bu1pNtsMz2Jsb+FwJAg1ID1N2IIYTInnCejeiBwZUlNJOj0gBjOCoKMV/CI3W4Jt3DZx
         8SJH3gxp31qbkPKpkqYPnHGmE2Kr2rRPrjGwZRnL0qiEJMkLWX6DYY5wHs54MEbFZG/x
         NB5rFGf2l66sKxd1n7ek5IhiJ3ERvsJCD5QG8Iz09J8f8NG1vdcO1YkepCBTeH8Rsvdb
         jhfHA2RBJk4LDyIoSQQQStxlT95qkPdRJbx2p0oHiskvgj3zyOkFvQ8Vg0Sa3FMKSO43
         TRMQ==
X-Gm-Message-State: AOJu0Yzl9coDdgi9zf7+A0Bv7/gxaItbX1ahxUc37Rv20l+OeL4aB1Q/
        6zW5eziXmYFOjiLoUTMTy5q0eFs8MBb9/gFiYCBdDw/VVo5HDP3jhjjN7/hOhp/62bQu7fYm4gE
        gxdhjmCKH5KD7UdSQ71SrfyLWa7dq40/kQ4euyiPY4Q==
X-Received: by 2002:a05:6a20:7f98:b0:188:290d:17dc with SMTP id d24-20020a056a207f9800b00188290d17dcmr23726547pzj.60.1701357585115;
        Thu, 30 Nov 2023 07:19:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEh65TpHQMiSKOAY4Ol//p0hGEk6OSzzktrSG601vYWHN3rGxFgZXjz0/38VtdY7gQaQkl+JA==
X-Received: by 2002:a05:6a20:7f98:b0:188:290d:17dc with SMTP id d24-20020a056a207f9800b00188290d17dcmr23726523pzj.60.1701357584835;
        Thu, 30 Nov 2023 07:19:44 -0800 (PST)
Received: from stitch.. ([80.71.140.73])
        by smtp.gmail.com with ESMTPSA id y125-20020a636483000000b005bd3d6e270dsm1356002pgb.68.2023.11.30.07.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 07:19:44 -0800 (PST)
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 0/8] Add JH7100 errata and update device tree
Date:   Thu, 30 Nov 2023 16:19:24 +0100
Message-Id: <20231130151932.729708-1-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the driver for the SiFive cache controller supports manual
flushing as non-standard cache operations[1] we can add an errata option
for the StarFive JH7100 SoC and update the device tree with the cache
controller, dedicated DMA pool and add MMC nodes for the SD-card and
wifi.

This series needs the following commit in [1] to work properly:

0d5701dc9cd6 ("soc: sifive: ccache: Add StarFive JH7100 support")

..and its parent for dtb_checks to pass.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/log/?h=riscv-soc-for-next

Changes in v2:
- Add Conor's ack on patch 1/8
- Add my SoB on patch 2/8
- Update commit message on patch 4/8

Emil Renner Berthing (7):
  riscv: errata: Add StarFive JH7100 errata
  riscv: dts: starfive: Mark the JH7100 as having non-coherent DMAs
  riscv: dts: starfive: Add JH7100 cache controller
  riscv: dts: starfive: Add pool for coherent DMA memory on JH7100
    boards
  riscv: dts: starfive: Add JH7100 MMC nodes
  riscv: dts: starfive: Enable SD-card on JH7100 boards
  riscv: dts: starfive: Enable SDIO wifi on JH7100 boards

Geert Uytterhoeven (1):
  riscv: dts: starfive: Group tuples in interrupt properties

 arch/riscv/Kconfig.errata                     |  17 +++
 .../boot/dts/starfive/jh7100-common.dtsi      | 131 ++++++++++++++++++
 arch/riscv/boot/dts/starfive/jh7100.dtsi      |  48 ++++++-
 3 files changed, 192 insertions(+), 4 deletions(-)

-- 
2.40.1

