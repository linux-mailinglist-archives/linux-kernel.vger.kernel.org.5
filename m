Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152157A8811
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbjITPUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234602AbjITPUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:20:30 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5775DCE;
        Wed, 20 Sep 2023 08:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:subject:date:message-id:reply-to;
        bh=rkPvlf3H1P9ACxQK+FGe3o7kq/gw7tnfk6uZjZgiHwQ=; b=w23Jc7vJrj8ES1UxKOLvc2DyYu
        FFzyWbYr0w6Iq8z+LLkAe6/SaXIpzd2E7ABJkzlg9NPXLocnxTvdbD/cc5KvMA3KKJjHGZKE1QevG
        /OS3YVFgoIlfT1bBYZ6JazmSCpZT0z/mn0fPNCYXi5hqb8LqPTUTN3a4Yuna72wOgyuY=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:43190 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qiyzx-0008Co-4O; Wed, 20 Sep 2023 11:20:17 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, hvilleneuve@dimonoff.com
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, hugo@hugovil.com
Date:   Wed, 20 Sep 2023 11:20:11 -0400
Message-Id: <20230920152015.1376838-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 0/4] serial: sc16is7xx: device tree improvements
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Hello,
this patch series improves DT properties naming and handling, and converts
sc16is7xx bindings from text to YAML.

Patch 1 make sure we use the device_property APIs when configuring irda mode.

Patch 2 is in preparation for patch 3, to make sure we recognize
"nxp,irda-mode-ports" DT property as well as the (soon to be) legacy property
"irda-mode-ports".

Patch 3 adds a vendor prefix to irda-mode-ports property.

Patch 4 is the actual conversion of bindings to YAML.
Conversion to YAML has been suggested by Andy Shevchenko during review for
another patch series for the sc16is7xx:
Link: https://lkml.org/lkml/2023/5/25/743

Thank you.

Hugo Villeneuve (4):
  serial: sc16is7xx: use device_property APIs when configuring irda mode
  serial: sc16is7xx: recognize "nxp,irda-mode-ports" DT property
  dt-bindings: sc16is7xx: add vendor prefix to irda-mode-ports property
  dt-bindings: sc16is7xx: convert to YAML

 .../bindings/serial/nxp,sc16is7xx.txt         | 118 ----------------
 .../bindings/serial/nxp,sc16is7xx.yaml        | 126 ++++++++++++++++++
 drivers/tty/serial/sc16is7xx.c                |  40 ++++--
 3 files changed, 156 insertions(+), 128 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
 create mode 100644 Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml


base-commit: c980248179d655d33af47f0b0bec1ce8660994c6
-- 
2.30.2

