Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F3D7E4713
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 18:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343864AbjKGRdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 12:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235139AbjKGRdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 12:33:23 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008A8121;
        Tue,  7 Nov 2023 09:33:20 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2800229592aso5450067a91.2;
        Tue, 07 Nov 2023 09:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699378400; x=1699983200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OfvBeM19p1hbFY3xaolUZcqgGO7w8iDi+t8l9XRgS0A=;
        b=a33X0WKZ6Hi/BaC3lOwHyZAEqyretTfnXc49WJfEFswAeDxbDKm1bEFKvAHoeIi/av
         nYX1Bhl1NMVBcOpawyuazSlCErrroeU7sKuuEHtiqn8X513Vdre8rxMOSkGGrtYan58m
         Fj2l5xn0/Ewp5c/l+zCgbc9wZO1GlUkyLZLWhTBqziB7Mt8NTisO/Fb75qgRR0m/UlTI
         ONaiHAdYkCFNSo4PZbeXqMa/hHPjndjIQJXqV4AAFhwTr0lhC9nC6afZKOOwF54Jhk+Z
         gC2IMZCjuMQowXKLzDvLP4+Ybg7vVxUj9P/OL3azd7vYVv70WnMOhelPQLPGjBHdz+Cr
         oFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699378400; x=1699983200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OfvBeM19p1hbFY3xaolUZcqgGO7w8iDi+t8l9XRgS0A=;
        b=NAB6I4xmz699MNcTAek5i6SJBGARtezmdr2Nvf72PVKL9ELetNHJ1forXEY8cKvi/X
         yVKI103og0jiDKstF8iO6qmPYrshTHkncHDz3hlvneerNmptMWi0Z9+7QHFY5kONUBAL
         9I2lJGwKSRxDUX46pHX1rmKPXrbgAD2F0VhMsII34TYsyn9ypCKyFSpx5T1Ah/JZAkBV
         9sVLpgw5nbnalaLVduz2x7TWD9Z0mmJUWiPAeWB3vkdhh3b1WLn9D6LKxQdEg3iKRhf0
         EIX34x+vU8opnXn4QLKZqReNJA+wiDoy/0MtYWjEzAILbn3/BbL+0RD7/5QVL9TvZiAE
         c2IA==
X-Gm-Message-State: AOJu0YyvgcFU+JnA+64SV97t56m5ysBK8xf4jaCY9rOgWIevQcj5E8wv
        CqkOjXEiAElfEoKT/PPLsNUOVRt7iulp92dR
X-Google-Smtp-Source: AGHT+IGR3+HJYG52VcNjUg0FdvJh9y+cC7+ByeGqBIax5M2hvjKP6JYJ9GFht6qdSvm4/gNZEHkltA==
X-Received: by 2002:a17:90b:3eca:b0:280:f534:6b9c with SMTP id rm10-20020a17090b3eca00b00280f5346b9cmr6194419pjb.21.1699378399965;
        Tue, 07 Nov 2023 09:33:19 -0800 (PST)
Received: from archlinux.srmu.edu.in ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id a13-20020a170902b58d00b001c9db5e2929sm103116pls.93.2023.11.07.09.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 09:33:19 -0800 (PST)
From:   Anshul Dalal <anshulusr@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Anshul Dalal <anshulusr@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: add asair
Date:   Tue,  7 Nov 2023 23:00:53 +0530
Message-ID: <20231107173100.62715-1-anshulusr@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aosong Electronic Co., LTD. is a supplier for MEMS sensors such as AHT20
temperature and humidity sensor under the name Asair

Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 573578db9509..df3204f9dda6 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -143,6 +143,8 @@ patternProperties:
     description: Artesyn Embedded Technologies Inc.
   "^asahi-kasei,.*":
     description: Asahi Kasei Corp.
+  "^asair,.*":
+    description: Aosong Electronic Co., Ltd.
   "^asc,.*":
     description: All Sensors Corporation
   "^asix,.*":
-- 
2.42.0

