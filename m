Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A400D7F5399
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 23:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbjKVWod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 17:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235257AbjKVWoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 17:44:23 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6642CD41;
        Wed, 22 Nov 2023 14:44:19 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3b83ed78a91so207100b6e.1;
        Wed, 22 Nov 2023 14:44:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700693058; x=1701297858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9DHIDd+1coJ1issLj7LfnrEV9ADKsNgebdRxQ/ZnRwA=;
        b=Qy5nlCWtWVuGHp4iTI6LJ7EGqK8wUV8yaw5BzuseilbUQGxUyvsjfeF3KuI5TSjlT9
         wUJvZvShfXuVJwQByR0hf3wlLwfAV+c5F35ohAl8aYq/0aHlHUmjKPWjw+PI3SWU0GoO
         wi5Fs9935CeaQHNu2CD3iypAT1s7Hlz8S6XeAb0yu5pjNvbJMTSJ0hene78BmMPNIURO
         rDkOgIRjqu3JdQ3sCx/I3HAo5g8yu4BiypGUEIqVlaNsTPFF6Wu8dBJdqkmlj+8ThZdZ
         +8cMN03D12acaHxYasJHpundUXKdMkCdXBmEkN6tYR0VH3fhzPfTDPv1XjrsdqQrX17G
         hMuQ==
X-Gm-Message-State: AOJu0YyKwZl5wy9gIkR47nvUjdR3tNRDwlxTxwF2JN/QUeZGKXY0rpMs
        JfoIkZxXA/snTGTOToYudRW9yFCzpg==
X-Google-Smtp-Source: AGHT+IH54k3Wt4YCyLNeCPNtxdcOcnzfdu9XRieLXF2USnfJqpXF8QjTk8RLDRkHS0d9SOXRDgqRrg==
X-Received: by 2002:a05:6870:5ccd:b0:1d6:5133:2f37 with SMTP id et13-20020a0568705ccd00b001d651332f37mr5144535oab.48.1700693058677;
        Wed, 22 Nov 2023 14:44:18 -0800 (PST)
Received: from herring.priv ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id j27-20020a02cb1b000000b0046675345998sm98374jap.96.2023.11.22.14.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 14:44:18 -0800 (PST)
Received: (nullmailer pid 2809289 invoked by uid 1000);
        Wed, 22 Nov 2023 22:44:16 -0000
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: perf: riscv,pmu: drop unneeded quotes
Date:   Wed, 22 Nov 2023 15:44:14 -0700
Message-ID: <20231122224414.2809184-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop unneeded quotes over simple string values to fix a soon to be
enabled yamllint warning:

  [error] string value is redundantly quoted with any quotes (quoted-strings)

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/perf/riscv,pmu.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/perf/riscv,pmu.yaml b/Documentation/devicetree/bindings/perf/riscv,pmu.yaml
index c8448de2f2a0..d01c677ad3c7 100644
--- a/Documentation/devicetree/bindings/perf/riscv,pmu.yaml
+++ b/Documentation/devicetree/bindings/perf/riscv,pmu.yaml
@@ -90,7 +90,7 @@ properties:
             bitmap of all MHPMCOUNTERx that can monitor the range of events
 
 dependencies:
-  "riscv,event-to-mhpmevent": [ "riscv,event-to-mhpmcounters" ]
+  riscv,event-to-mhpmevent: [ "riscv,event-to-mhpmcounters" ]
 
 required:
   - compatible
-- 
2.42.0

