Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9EC79D33C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235862AbjILOHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235600AbjILOHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:07:43 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CFD10D0;
        Tue, 12 Sep 2023 07:07:40 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d9443c01a7336-1c336f5b1ffso47532575ad.2;
        Tue, 12 Sep 2023 07:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694527659; x=1695132459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4rRBJhCHj2aVj7Yvl5LQyb1ciYT6RtfI0V079W7e6g=;
        b=dalCJ6clmXKsesSyb38z/xF6iSuEFNjUpNsl9ZbGjGGYd1N8L91q21kVTO6UmooaYz
         +MO8+hu3hguvWarihbyoPVoNRuu4QwkcAYyvYq5xM8lNR4oaTc0Z31QAguuzmf/HLGEs
         St4MW8g/gocokh+56QGjnfgMra09WTvEuOPDgBYrMs3rjXEr9/wbjENwIAZCuUo668cv
         RyA/zP1Pwzzrh6Qv1qE4Mx23MPloueeGBvameL9sjCaCy/oHePBcozio7v8I9jv7C7Yi
         V0nvx5Vp71JCys+eVsnqiLvw1DnIopPoH7/hlmD2uAjSjUEqsiJGGhw5NlY4O0QY8Cup
         Z6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694527659; x=1695132459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4rRBJhCHj2aVj7Yvl5LQyb1ciYT6RtfI0V079W7e6g=;
        b=itZ8UAkV3JsbLtVX3YyCN9zrrmfm3CayGzribSEsYZnqGx87bFEE1QmtV4LFEYDBnf
         zVIVZVrEIB2+qDfl0KtBB7RvZwGwNybUj/cVE2iGQPN0RAcAEWJZG6AMom15DRH5R9rX
         yoOYF0TlIkcycnYm9KMVzqUqYzkmJHwWzpj9w4SQ4BzsNX5bDWh9uSnQ01sY4Q58qnY2
         m916FX41Fa2Li8YbUntuLyVuVCrsCZWe8H9IllVi6Gk2CE43NLctqB7F2GTUpYAtku51
         fKJCiz25foVIm4dfY+fXwmeD8HsdqtZ9NF3DX4w7ZVi8Oj5+NIiSpnIxI9PvjWw9oA2B
         YULA==
X-Gm-Message-State: AOJu0YwtPXllnrx1SorBC8qNPjV2qYZVZXGoipu6wkTPwmV4QrzUFHTQ
        gnQqCb6NHzvH42cq2qhB0HE=
X-Google-Smtp-Source: AGHT+IFWTBYbUY5zopbPyW+WFsVD6ZVUxCAYNogYZ9qUdRB2H7c8kbzzmj/lSMSXn8XUW+yZ4zMKkw==
X-Received: by 2002:a17:903:32d0:b0:1c3:3461:75b5 with SMTP id i16-20020a17090332d000b001c3346175b5mr16649939plr.0.1694527659305;
        Tue, 12 Sep 2023 07:07:39 -0700 (PDT)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id jb11-20020a170903258b00b001ae0a4b1d3fsm6357762plb.153.2023.09.12.07.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 07:07:38 -0700 (PDT)
From:   yangchen.openbmc@gmail.com
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        joel@jms.id.au, andrew@aj.id.au, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     patrick@stwcx.xyz, Jerry.Lin@quantatw.com, Eddie.Chen@quantatw.com,
        EasonChen1@quantatw.com, yangchen.openbmc@gmail.com
Subject: [PATCH 1/2] dt-bindings: arm: aspeed: document board compatibles
Date:   Tue, 12 Sep 2023 22:05:31 +0800
Message-Id: <20230912140532.3797736-2-yangchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912140532.3797736-1-yangchen.openbmc@gmail.com>
References: <20230912140532.3797736-1-yangchen.openbmc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Chen <yangchen.openbmc@gmail.com>

Document the new compatibles used on the Facebook Minerva Chassis
Management Controller (CMC).

Signed-off-by: Yang Chen <yangchen.openbmc@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 68f717670f78..749ee54a3ff8 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -79,6 +79,7 @@ properties:
               - facebook,elbert-bmc
               - facebook,fuji-bmc
               - facebook,greatlakes-bmc
+              - facebook,minerva-cmc
               - facebook,yosemite4-bmc
               - ibm,everest-bmc
               - ibm,rainier-bmc
-- 
2.34.1

