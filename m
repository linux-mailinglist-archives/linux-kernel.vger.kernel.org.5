Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED0A7D73A8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbjJYS46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbjJYS4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:56:51 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A56184
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:56:48 -0700 (PDT)
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 146B23FD3D
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 18:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1698260206;
        bh=FFiHmR7ukRwdZCsC7cixmRTY2MvrJS7s0z/YTGkE2iM=;
        h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type;
        b=GVfVIqtSVfF68mRlN07dL8QYEVZoifPqKoSGLylo/NO4lW+NAScV0MvEeUWunbS98
         KZZVgshmdNGOsDid6DormF6H15cklRcmRJIOMp8R+VgO8PaqgVcGZwHEekyu+Zammm
         Vu7T3pWdNuFa5WnLrveQDFwtDMWdIPsm9rIso2xT/XTCT+riOzz9lLhuw4gFQfQ+yS
         DU/ArEhbn30GFsJIsYaoftnKHvizE9EaL/YbJjE4m04H2S/A57VgT7KTXymHI1x4MJ
         gXkm0sW9JWQJzqmS4h3pe9KpFDtivBeVNQEvz4IWfhjCEaiQZkMi+QOACIxuzA8rn3
         dtTlPsjEp6nIw==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-41e3e4aa311so949421cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:56:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698260202; x=1698865002;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FFiHmR7ukRwdZCsC7cixmRTY2MvrJS7s0z/YTGkE2iM=;
        b=enGuCO5/HGTGn//1DImpTkRd9fhjz52Y/I6RgenKoxA3eN+YiOqkl62SuJFJHB1bBU
         1CU/SWwTnyPmrtXShaS0eskjqoz+9oaTfv3XL71gn5oLPgvvjLGJNheCF/mU4xHQo+QN
         B/toQ0Wxoo8ru6aBKEUr4ZwXnXBoeHPOaGqER0LYUCa/cIhvPsn36fAOgAj9DXXn0ht/
         xxdDsZPliq+VL3LKegto/+X8At/wTYcq8pz3p3aQXN1Q4aOMKB1Ec9cUD5+e/eLkYHme
         wMQG6JrHGA3UyvhkROvg5NVMatMr1zYjsGkNHgesKT32XEAVjljqegaq3gsVNbCid06f
         KanA==
X-Gm-Message-State: AOJu0YykHdYKvUnjBqs3FNmsgbl/WtYKeoHXuavSHi+Bfqau2v9t908D
        THNLpJNM86OAOJFyyGi4MgDnE0UtJx8tspBWmKlGFdaH6kYkTNMUDa9KU/gy2WEffuP+yqxldcY
        p9WxmaEBlb/UWr1hEM2aXnHPc/q4K2KVodWnMqHPGUpEt4jCfyGmdYcpJRQ==
X-Received: by 2002:a05:622a:14e:b0:41e:172f:6e78 with SMTP id v14-20020a05622a014e00b0041e172f6e78mr15135514qtw.29.1698260202167;
        Wed, 25 Oct 2023 11:56:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRHDA8d43i/0eqTtRETVi4ef1AAWHZvlYua8G+9qwUeJ5hvjbzmci7qiMP/aXUn13Et1Ecrw6N0+hOCNM2Ze0=
MIME-Version: 1.0
X-Received: by 2002:a05:622a:14e:b0:41e:172f:6e78 with SMTP id
 v14-20020a05622a014e00b0041e172f6e78mr15135502qtw.29.1698260201944; Wed, 25
 Oct 2023 11:56:41 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Oct 2023 11:56:41 -0700
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Wed, 25 Oct 2023 11:56:41 -0700
Message-ID: <CAJM55Z8DXDs6LT0JrTyEMp8V6BHvsjUW7aJ8Gj+fRGsasHAi_A@mail.gmail.com>
Subject: [PATCH 3/4] dt-bindings: cache: sifive,ccache0: Add sifive,cache-ops property
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This cache controller also supports flushing cache lines by writing
their address to a register. This can be used for cache management on
SoCs with non-coherent DMAs that predate the RISC-V Zicbom extension
such as the StarFive JH7100 SoC.

Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 Documentation/devicetree/bindings/cache/sifive,ccache0.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
b/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
index 7e8cebe21584..36ae6f48ce0b 100644
--- a/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
+++ b/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
@@ -81,6 +81,11 @@ properties:
       The reference to the reserved-memory for the L2 Loosely
Integrated Memory region.
       The reserved memory node should be defined as per the bindings
in reserved-memory.txt.

+  sifive,cache-ops:
+    type: boolean
+    description: |
+      Use this cache controller for non-standard cache management operations.
+
 allOf:
   - $ref: /schemas/cache-controller.yaml#

-- 
2.40.1
