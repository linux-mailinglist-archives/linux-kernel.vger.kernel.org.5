Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F9C7A27F3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237161AbjIOUT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237315AbjIOUTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:19:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881A73C29;
        Fri, 15 Sep 2023 13:16:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC22C433C7;
        Fri, 15 Sep 2023 20:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694808992;
        bh=nGXQTgrcs3KREIWY3zBQSQp1+XIT8pojI0mg2noKVnQ=;
        h=From:To:Cc:Subject:Date:From;
        b=lU1+XHUXZMAUFUqsXQSsCWZn+Uos3RB5wXCnDq9MbGB1AQW8Yjz153kXHq9JDHDux
         oyJ36pykFKv4/NmdromUyG1gfDJgVMkp21Rr+qTjY7C68fpabAt54ULJVlDpq7X8Ti
         U8mXKhd6tfQyIcE1ZDlr1KmYQkrANrN4qcIYLCvXD9oWadQdIu7srChOLtjs17efBx
         Fz2T4AroD88ycXuZ2ZELyInvT9zp5SV6oefZWwiATWrDnzCH2AT5OT/y+KvNlU9aJ4
         btd2tkIB1hl6o+YLESH/MQ0zCndF1ulhWXnYwWjGjbSnRM2gPuZDmGw44wlqIqBzWO
         5V/83jeoyrXdg==
Received: (nullmailer pid 4180862 invoked by uid 1000);
        Fri, 15 Sep 2023 20:16:30 -0000
From:   Rob Herring <robh@kernel.org>
To:     Damien Le Moal <dlemoal@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: ata: pata-common: Add missing additionalProperties on child nodes
Date:   Fri, 15 Sep 2023 15:16:20 -0500
Message-Id: <20230915201626.4180606-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PATA child node schema is missing constraints to prevent unknown
properties. As none of the users of this common binding extend the child
nodes with additional properties, adding "additionalProperties: false"
here is sufficient.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/ata/pata-common.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/ata/pata-common.yaml b/Documentation/devicetree/bindings/ata/pata-common.yaml
index 337ddf1113c4..4e867dd4d402 100644
--- a/Documentation/devicetree/bindings/ata/pata-common.yaml
+++ b/Documentation/devicetree/bindings/ata/pata-common.yaml
@@ -38,6 +38,7 @@ patternProperties:
       ID number 0 and the slave drive will have ID number 1. The PATA port
       nodes will be named "ide-port".
     type: object
+    additionalProperties: false
 
     properties:
       reg:
-- 
2.40.1

