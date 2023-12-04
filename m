Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8ACD802B63
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 06:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbjLDFnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 00:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLDFnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 00:43:32 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931E3B3;
        Sun,  3 Dec 2023 21:43:38 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-58de42d0ff7so2475352eaf.0;
        Sun, 03 Dec 2023 21:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701668618; x=1702273418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kfXkJ8WdxxOvDNDkUc/lSpC/kRqYJbY1KuomsftLIqM=;
        b=MdJRuUq5+l8d+WkUTQdM2+9t0vHbpgCk8jFFa/4vEQiw4N/uX8i1cQpwR+p3e2yOtk
         9lSPPmdUW7/y6c88J0C2s8mcK/SdbAuJzB0f7sPZ6mjv5wPtoU8nRMKvHgicvzoHReCp
         mehxcwRKVRf0lgBEAfQSW2ptgapj3o8G89bOrcsUKo/RTheUmhJsxjLxpLL/M9teIJn/
         2bUydUmyvg6pY0Tr7POieOHe0TDAYuzQ7wr+6p9iFw5HVEMu+BIRpTHFH2Df3GoYRZGT
         DIol4LPLm02gTuWZ892DAnjB6XW3srVwjqkmmupWrlY49n4SxE5r/RhpnRz1zaKOtpW8
         7u7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701668618; x=1702273418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfXkJ8WdxxOvDNDkUc/lSpC/kRqYJbY1KuomsftLIqM=;
        b=DYmv6qFcqB+QJQGmoDSHSo31QeTvgPL8TiXGI/WeHO3+tynUZnTPsMYtYfnzHg/w75
         9vTRM7/+B8vjAmXURJYcH0BtLqO/Op5kDmKiAOOKqnTNYbKZ9NkcirnDSQXS84w8EvFQ
         T7pt5+7gwrJCfZdhb9eCjbwSLmdJNNd7t+iqRuqj2F29v0P5trDijOoxB4i1mczwQrs3
         w+ybWxiJdUz69XgDk4l/hVUEeDNMRUND/PZ0OXc3kIYP4vUqMxu3EOUxPm1M+wm/dCR8
         hSrBy+GAG3d/BvRONnWclX/PYD07znqj94GMXP4ikl48gYbjU9U/YcS5OHCbTUW4amOQ
         27/g==
X-Gm-Message-State: AOJu0YzoOLynLCg1dliJ7IER8clGLqKSy9OorVqP+O4y+oFD9T0ugWW6
        g5Jj23LhF5F8LaI0s8xXm+E=
X-Google-Smtp-Source: AGHT+IGazJkcb74hNfGOAloGtjoXXcRi4esq7e2idv8LVE/U9+E5O487mwYoNj9pXjPe5rEW3rweLQ==
X-Received: by 2002:a05:6358:50c6:b0:170:17eb:1e2 with SMTP id m6-20020a05635850c600b0017017eb01e2mr1323126rwm.37.1701668617662;
        Sun, 03 Dec 2023 21:43:37 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id b24-20020aa78718000000b006cb60b188basm6706655pfo.206.2023.12.03.21.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 21:43:37 -0800 (PST)
From:   Peter Yin <peteryin.openbmc@gmail.com>
X-Google-Original-From: Peter Yin <peter.yin@quantatw.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: arm: aspeed: add Meta Minerva Harma board
Date:   Mon,  4 Dec 2023 13:41:30 +0800
Message-Id: <20231204054131.1845775-2-peter.yin@quantatw.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231204054131.1845775-1-peter.yin@quantatw.com>
References: <20231204054131.1845775-1-peter.yin@quantatw.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Yin <peteryin.openbmc@gmail.com>

Document the new compatibles used on Meta Minerva Harma.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index e17b3d66d6e5..20e3be8d8c78 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -79,6 +79,7 @@ properties:
               - facebook,elbert-bmc
               - facebook,fuji-bmc
               - facebook,greatlakes-bmc
+              - facebook,minerva-harma
               - facebook,yosemite4-bmc
               - ibm,everest-bmc
               - ibm,rainier-bmc
-- 
2.25.1

