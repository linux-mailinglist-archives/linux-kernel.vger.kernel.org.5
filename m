Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1F28134E3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573824AbjLNPgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573809AbjLNPgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:36:22 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB8E123;
        Thu, 14 Dec 2023 07:36:29 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-551ee7d5214so1490906a12.0;
        Thu, 14 Dec 2023 07:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702568187; x=1703172987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7aoTw4OzsLC4RfHyhEqd9IMSyhLj1y7UIdS2DuMa/Jw=;
        b=RjmpqTCpKZBYp+BtMtLQdkOxlJgT4ZjAXNx2+0DAPhHiQD7WSZNSw4JhlzhmVTwvR0
         jBSRDIG0XbeATgHIqCvecBoRKhLcajvpMDBDIc32QnfZdPcOI0g6VaviRnioJjfVrOLA
         0rI0uLK9vcRxIzSq4JfbsFyxIl+fPTxHQjds2FI4d7zjYspP/23zNt9OnSuAiKZN6AH6
         LXzA84WF1bzcHBMocyKaU0PIlVBALUd7lphRa0MwaAGopZOTmCPWCPTFMKvxv81LXG6c
         zZrZK6iYZu/FQJ7FDMMv+E8f4U4KmyrhqoPmaEn/m5Q7iTQqkl/AYKyGqM4jeGQ/JR42
         lriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702568187; x=1703172987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7aoTw4OzsLC4RfHyhEqd9IMSyhLj1y7UIdS2DuMa/Jw=;
        b=LOoZxEU3Gqa3PgvUMNJRvNa1afp4X0ufIiGOBE1FItQGPR6hcQq2M42hnUhj7UMf1y
         r1Ma7MX/+cpE/+K/tJkNoAE4QZjhPO+X8HymU7P7pnts0jvsL/wwiFcHe/TtvVr1ygk8
         p5/ZUkeue+PHB/4HuqRAvCK+DaOgrtox2coEnbsoXM7/gD41WM6r62/HRmknOmN0QFYn
         NaWCeMA3QiUHfKn/4g/XUE2TBLn1H1Sjig/2j/UPKeAkEfSFtZtzfATuBTmlyBz/3wB/
         U6n+yaRRZEtPUSjbxALGhJvNeFU4MkFIKdR8cQhzB6hdD152BwiRoFdbjPwovEYfNXSr
         UrWQ==
X-Gm-Message-State: AOJu0YwnaoFwlzXpocENptopouT/v61e7fAVX1gWGHQJyBg0A2R4kgkW
        BpjXazGfomzFvH9KaUtP3yI=
X-Google-Smtp-Source: AGHT+IGpJEjbt5Kw87AvVHEmj7Sqpfrh6cn5IZWW6q5OWiB43w0Gdk/CJyr7aaNhgpvuSEwj4xh7tw==
X-Received: by 2002:a50:9f4e:0:b0:551:c796:78d0 with SMTP id b72-20020a509f4e000000b00551c79678d0mr3884602edf.27.1702568187199;
        Thu, 14 Dec 2023 07:36:27 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id fd1-20020a056402388100b0055265d5f3c6sm910575edb.24.2023.12.14.07.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 07:36:26 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        u-boot@lists.denx.de,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH RFC] dt-bindings: nvmem: u-boot,env: add any-name MAC cells compatible
Date:   Thu, 14 Dec 2023 16:36:20 +0100
Message-Id: <20231214153620.23998-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

So far we had a property for "ethaddr" NVMEM cell containing base
Ethernet MAC address. The problem is vendors often pick non-standard
names for storing MAC(s) (other than "ethaddr"). A few names were
noticed over years:
1. "wanaddr" (Edimax, ELECOM, EnGenius, I-O DATA, Sitecom)
2. "et1macaddr" (ASUS)
3. "eth1addr" (Buffalo)
4. "athaddr" (EnGenius)
5. "baseMAC" (Netgear)
6. "mac" (Netgear)
7. "mac_addr" (Moxa)
and more ("HW_LAN_MAC", "HW_WAN_MAC", "INIC_MAC_ADDR", "LAN_MAC_ADDR",
"RADIOADDR0", "RADIOADDR1", "WAN_MAC_ADDR", "lan1_mac_addr", "wanmac",
"wmac1", "wmac2").

It doesn't make sense to add property for every possible MAC cell name.
Instead allow specifying cells with "mac" compatible.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
List of devices and their U-Boot MAC variables:
alphanetworks,asl56026) wanmac
asus,rt-ac65p) et1macaddr
asus,rt-ac85p) et1macaddr
belkin,f9k1109v1) HW_WAN_MAC + HW_LAN_MAC 
buffalo,ls220de) eth1addr
buffalo,ls421de) eth1addr
checkpoint,l-50) lan1_mac_addr
dovado,tiny-ac) INIC_MAC_ADDR
dovado,tiny-ac) LAN_MAC_ADDR + WAN_MAC_ADDR
edimax,ra21s) wanaddr
edimax,rg21s) wanaddr
elecom,wrc-2533ghbk-i) wanaddr
elecom,wrc-2533ghbk2-t) wanaddr
engenius,ecb1200) athaddr
engenius,ecb1750) athaddr
engenius,epg5000) wanaddr
engenius,epg600) wanaddr
engenius,esr1200) wanaddr
engenius,esr1750) wanaddr
engenius,esr600) wanaddr
engenius,esr600h) wanaddr
engenius,esr900) wanaddr
enterasys,ws-ap3705i) RADIOADDR0 + RADIOADDR1
iodata,wn-ac1167dgr) wanaddr
iodata,wn-ac1167gr) wanaddr
iodata,wn-ac1600dgr) wanaddr
iodata,wn-ac1600dgr2) wanaddr
iodata,wn-ac733gr3) wanaddr
iodata,wn-ag300dgr) wanaddr
iodata,wnpr2600g) wanaddr
moxa,awk-1137c) mac_addr
netgear,wax220) mac
netgear,wndap620) baseMAC
netgear,wndap660) baseMAC
ocedo,panda) wmac1 + wmac2
sitecom,wlr-7100) wanaddr
sitecom,wlr-8100) wanaddr

 .../devicetree/bindings/nvmem/u-boot,env.yaml | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
index 0006f022d0af..68214b96f5c9 100644
--- a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
+++ b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
@@ -67,6 +67,34 @@ properties:
         description: The first argument is a MAC address offset.
         const: 1
 
+patternProperties:
+  ".*":
+    allOf:
+      - if:
+          type: object
+        then:
+          properties:
+            compatible:
+              enum:
+                - mac
+      - if:
+          properties:
+            compatible:
+              contains:
+                const: mac
+        then:
+          description:
+            Ethernet interfaces base MAC address.
+
+          properties:
+            compatible: true
+
+            "#nvmem-cell-cells":
+              description: The first argument is a MAC address offset.
+              const: 1
+
+          additionalProperties: false
+
 additionalProperties: false
 
 examples:
@@ -90,6 +118,11 @@ examples:
             mac: ethaddr {
                 #nvmem-cell-cells = <1>;
             };
+
+            wanaddr {
+                compatible = "mac";
+                #nvmem-cell-cells = <1>;
+            };
         };
     };
   - |
-- 
2.35.3

