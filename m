Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0F57D2204
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 11:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjJVJGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 05:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjJVJGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 05:06:37 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72217F7;
        Sun, 22 Oct 2023 02:06:34 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40842752c6eso18679935e9.1;
        Sun, 22 Oct 2023 02:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697965592; x=1698570392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5HIRv2oD7/D1jucjGvQL5jQMiB85wI9QcaebvszLCvA=;
        b=LHiE1s8foJ9NjZoUmKUpFNodHbl4WaI6VytCBCHLMvVWtZQYj5V25DBQTUcJxrxg1A
         qWxCy/18PTNfin3HMEviuIUawUrlo+JZ0bZUj4wztdOlv0K+YDqKaxRmVuAJZiSPaH1y
         EKxRjUxulHuFnQYug4HulBrVPD85OjvjKzy5PyfMXxDobFgGJnFYVJa4AY1LypOO+dat
         7GsT3Y+XI1hQAxL61T871gQbihms4HRkfXkrrGdUjdn7pffbCUTX7EqnZhfR4fHa51Ce
         keLzSxe0BpG2BCpH1DWbNXZnuADeDiob95Xn2PcLmIC3ldSSoFn6f7+3AYdL3ETeWqFg
         l4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697965592; x=1698570392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5HIRv2oD7/D1jucjGvQL5jQMiB85wI9QcaebvszLCvA=;
        b=hARsNplWBZo0kC+4ugjxwlGUHxowq3NF12FInMZLUYiuNE9L1QcNkWeT/vYY6e3feT
         X0K26wWeDqw8zKO23tfovQLxV5OoFtFSMj8cnXWZQU9pvbYrJ1wHo3zzOL2qIGHn7Dpd
         cfwyDKyAoNO/5SlFAJIFY9GToEV0Y2O8Lekqs3kV3m0lAlwsByQUjZycgRLghqjeXv2R
         tEfWHBCy9fnQ/bJW0scQfT6X3HBwqvzuHBuPdNHa03j1A4bA3ckaa+AXaReVATeYHJB+
         dHCUUZ3D6fl5zDbpKRMbFRaZvwqhOKBbaOsvZvaisf42Ipzwu89xlUzd6QzOrIVGSJ+i
         JWBw==
X-Gm-Message-State: AOJu0Yw5OJ2ZaASPiLcvT8S7ElzYYNDriXxo61WVUJwbGvzMSRxx/0E7
        IoxVzXvLYNbXtmljLUqmPtT7V9Ry2yM=
X-Google-Smtp-Source: AGHT+IEinVL5vuZwNAuAA6+o6rdhHo9Q/iQgvrSsIQYB+vZM65R172162ktVid1u0MiCPiMVZN0sRA==
X-Received: by 2002:a05:600c:45cb:b0:401:daf2:2737 with SMTP id s11-20020a05600c45cb00b00401daf22737mr4946340wmo.30.1697965592277;
        Sun, 22 Oct 2023 02:06:32 -0700 (PDT)
Received: from localhost.localdomain (141.red-88-10-53.dynamicip.rima-tde.net. [88.10.53.141])
        by smtp.gmail.com with ESMTPSA id p3-20020a05600c468300b0040646a708dasm6423052wmo.15.2023.10.22.02.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 02:06:31 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-mips@vger.kernel.org
Cc:     john@phrozen.org, tsbogend@alpha.franken.de,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add myself as maintainer of the Ralink architecture
Date:   Sun, 22 Oct 2023 11:06:33 +0200
Message-Id: <20231022090633.792831-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Its been a while since I am making contributions to this architecture.
Hence add myself as maintainer.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
Hi John, if you are not ok with this please let me know. In other case
please ack this patch. I can add myself as Reviewer if you prefer to
maintain alone this.

Thanks in advance for your time!

Best regards,
    Sergio Paracuellos

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2894f0777537..406c26a6f5d8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17914,6 +17914,7 @@ F:	drivers/media/cec/usb/rainshadow/
 
 RALINK MIPS ARCHITECTURE
 M:	John Crispin <john@phrozen.org>
+M:	Sergio Paracuellos <sergio.paracuellos@gmail.com>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
 F:	arch/mips/ralink
-- 
2.25.1

