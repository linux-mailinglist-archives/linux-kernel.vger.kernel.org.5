Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDD475484C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 12:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjGOKsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 06:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjGOKs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 06:48:28 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253E13A86;
        Sat, 15 Jul 2023 03:48:27 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-992ca792065so386685366b.2;
        Sat, 15 Jul 2023 03:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689418105; x=1692010105;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rn5C5YBsaSogUUgEp4dzGB5xBo5qBNnix/jnrz9gqkM=;
        b=fDx9RWHqR3WdveXG/OlDdrTexq4fbNMPt2ZBSoL0Xwa6tCqLAuScCyfOnhhX1ac0ts
         ysauNt9TuGVshmSJpp5FWmLJP1S7eZv3nO5o3BkKAlr9SWOY4qDMxuGQTwjL9Ne5lEZ3
         vF2k0HrrOg5DSsIuQFpsnjMzvuJY1zJE1a95jfDi33rLE/Ohan1/JiD1h1Izom+IFNnc
         pvuiC0DnrG/+ow/XT250CZBIS9DlpHVnyCHBKFn2fTETBQPFuWbs4sCGk3feLD/NENCw
         Kh1Ms1RYHTE/kZLsebUXxFSmw9KEad17kJPeKU8q/wG1Xstw1s+uZjp1OXzZA6aTpAWp
         JYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689418105; x=1692010105;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rn5C5YBsaSogUUgEp4dzGB5xBo5qBNnix/jnrz9gqkM=;
        b=XooRytEg5uFPV6qv8HqzOuSVCzEnO/yoq/0uUhDTu9JMu475PEdK13LmLmjpmjPvhL
         hmkMtpMuUo507ddYNt8ZMcotZ9Fu3aCHXEPcDaHnFLje4CW5PF9QPeAHMlZ187SMhbCk
         omwhBk0RUn5wSgtC1/xXYh95Txe+pRrQgFWf7TnJLtaPKC5/I71Vu/FnDvfyv4CtXGDb
         UedZfFqJ6Jbb1zWqnaUizEoepEbcnvF2eydLlvJC0Y5U8CEFM2mS0XvR4GpYDEASwrkE
         e74PH2a18r2nadcVTv2jbQ/fYPD2g3gYJLvh6PV8AKmk1B/0TY7sWmCNI4Z6JQcAZEfl
         TLaA==
X-Gm-Message-State: ABy/qLaWeZL8svIyg5hXsGsQuet+FQptVxcmCB94PRbNX7dSjcbCUPEj
        wlsRKkKFA9QkkaxgCwUiYSI=
X-Google-Smtp-Source: APBJJlFwpbjDxF/L0eWHgxk3zF1ODVea2/iA4Nkl2naDwD6iIjyL37Vd+GItE2wutNZVuketriyBRQ==
X-Received: by 2002:a17:906:6884:b0:988:4dc:e3a3 with SMTP id n4-20020a170906688400b0098804dce3a3mr6496371ejr.31.1689418105356;
        Sat, 15 Jul 2023 03:48:25 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id d20-20020a17090648d400b00993feabdc6asm6642782ejt.157.2023.07.15.03.48.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jul 2023 03:48:24 -0700 (PDT)
Message-ID: <61c84262-cd98-1e60-d95b-9b0492083994@gmail.com>
Date:   Sat, 15 Jul 2023 12:48:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 1/2] dt-bindings: mtd: nand-controller: add
 nand-skip-bbtscan and nand-no-bbm-quirk DT options
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A NAND chip can contain a different data format then the MTD framework
expects in the erase blocks for the Bad Block Table(BBT).
Result is a failed probe, while nothing wrong with the hardware.
Some MTD flags need to be set to gain access again.

Skip the automatic BBT scan with the NAND_SKIP_BBTSCAN option
so that the original content is unchanged during the driver probe.
The NAND_NO_BBM_QUIRK option allows us to erase bad blocks with
the nand_erase_nand() function and the flash_erase command.

Add nand-skip-bbtscan and nand-no-bbm-quirk Device Tree options,
so the user has the "freedom of choice" by neutral
access mode to read and write in whatever format is needed.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Previous discussion:
[PATCH v3 3/3] mtd: rawnand: rockchip-nand-controller: add skipbbt option
https://lore.kernel.org/linux-mtd/1618382560.2326931.1689261435022.JavaMail.zimbra@nod.at/
---
 .../devicetree/bindings/mtd/nand-controller.yaml    | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/nand-controller.yaml b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
index f70a32d2d9d4..ca04d06a0377 100644
--- a/Documentation/devicetree/bindings/mtd/nand-controller.yaml
+++ b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
@@ -103,6 +103,19 @@ patternProperties:
           the boot ROM or similar restrictions.
         $ref: /schemas/types.yaml#/definitions/flag

+      nand-no-bbm-quirk:
+        description:
+          Some controllers with pipelined ECC engines override the BBM marker with
+          data or ECC bytes, thus making bad block detection through bad block marker
+          impossible. Let's flag those chips so the core knows it shouldn't check the
+          BBM and consider all blocks good.
+        $ref: /schemas/types.yaml#/definitions/flag
+
+      nand-skip-bbtscan:
+        description:
+          This option skips the BBT scan during initialization.
+        $ref: /schemas/types.yaml#/definitions/flag
+
       nand-rb:
         description:
           Contains the native Ready/Busy IDs.
--
2.30.2

