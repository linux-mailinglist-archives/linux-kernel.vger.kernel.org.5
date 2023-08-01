Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D85276AD83
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjHAJ3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjHAJ3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:29:38 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5EC30D0;
        Tue,  1 Aug 2023 02:28:22 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 25E2F40533;
        Tue,  1 Aug 2023 14:09:31 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1690880972; bh=uMTAAyeF3I0QRs1D9Thykfo5n67qdtlh32dyUvRJIoo=;
        h=From:Subject:Date:To:Cc:From;
        b=OxEUVgVQVKN3Ob4Ke4YweJl2Ii4OF0ssF67kNUqbFyB4iihMLpFMUNuNz/QrE8AI0
         ulPPEfIoiW4M1anM9CrNR6/eEdGmu3Uu0nDk2omPcI8ffJGOy7LbMZAeX3fpUEvnVa
         XshoavGmGd5VFS28W4dl9EGPELezLuYqLIV+eVrBGe28D7VgWUlf4p4QewRHx8qCgM
         9Z8MlfWNT1dMNfAMIQnzuWg1LhQN0pxqCoI9PqIrxy8MK4+AljYNkvIuFm/FMWaWQB
         R4CLGy+BTTgv6CFFpFlkP6fnpalHZBOMQLoLWUuQsRzEF/92eDDZLs+fNPJq2RZlgY
         W6RHhg5xExS1Q==
From:   Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v4 0/2] Add touch-keys support to the Zinitix touch driver
Date:   Tue, 01 Aug 2023 14:09:24 +0500
Message-Id: <20230801-zinitix-tkey-v4-0-b85526c5a474@trvn.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMTLyGQC/x2MQQqAIBAAvyJ7TjA1iL4SHcy2WgILlbDEvycdZ
 2AmQ0BPGGBgGTzeFOh0FXTDwO7GbchpqQxSSCV60fKXHEVKPB748M6o6merhLZQk8vjSunfjVM
 pH983IYteAAAA
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Srba <Michael.Srba@seznam.cz>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>,
        Rob Herring <robh@kernel.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=808; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=uMTAAyeF3I0QRs1D9Thykfo5n67qdtlh32dyUvRJIoo=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBkyMvLRP12n2hUqUGzi+JO2sGIYpVs4QgRq6A16
 d7ob2iFGOaJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZMjLywAKCRBDHOzuKBm/
 de4kEACqAXg9t94H1AUHUFZmC5n/bliq4NpGExfVh4w9rxsLq2Moc7XuXXfbbgzdu8cQ5H0hEC2
 obDpBEc4g3pq4hyQecdVUmsbliDxN5bNLLLf5fp7kOlfX/zh/OC21VoKdLoYqg5SyIBAyP2IVgl
 S6sDdh16qHSCWxH9SJGQv0vsD07T7T0TCPmJ1xZ8wtKwHCiKGssNpUwEvDEMIkOZjFtSZq2DTty
 Bq/geEdfTKQtPxCkJK0aIWAPC3X9aw8anSQANEX+5ma0txfdUDCfBZJGgmrzVlI7BXG0tEcwjFb
 e6QMJwXkipvjo0wY/a/zHkHk0gJk/LrVyWoZjyI5gBVNi87pnJrXwRA2FxbIEN/fxu/PVSdqgfh
 zl97hKVg1tY12Ip7hf2SQpXZQnnA4VOTCfg+CxvGHLSi2eC6Oq2RKQAMQ9EXLlHFLaLdGFwrD/4
 WDnZsyZL/KRZhTzC6tJ95Bj9Lvx6Vjnm2C2jOWusT4fqonEjN08DIBKRRIL+tGIH67ChXGWLgao
 ucLHBdOPjRE3tlIKc44YWgevUreAh0ULJRo5may+3T6xvW+mGQL49CRCLeT430u1+38kEasNUgP
 tq70cVH4OuLEMSTlnvzlJpBXRTXAv6upiJm6e7cffMy6ZPonOgMzpf/iEPns1XCGMaADKYL6TAl
 Z+zYqGgoiCq1UmA==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the touch-keys that can be present on some
touchscreen configurations.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
Changes in v4:
- The series was partially applied, these patches dropped.
- Link to v3: https://lore.kernel.org/r/20220106072840.36851-1-nikita@trvn.ru

---
Nikita Travkin (2):
      dt-bindings: input: zinitix: Document touch-keys support
      input: zinitix: Add touchkey support

 .../bindings/input/touchscreen/zinitix,bt400.yaml  | 10 ++++
 drivers/input/touchscreen/zinitix.c                | 61 ++++++++++++++++++++--
 2 files changed, 68 insertions(+), 3 deletions(-)
---
base-commit: a734662572708cf062e974f659ae50c24fc1ad17
change-id: 20230801-zinitix-tkey-5a3023bc304c

Best regards,
-- 
Nikita Travkin <nikita@trvn.ru>

