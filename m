Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA69805047
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbjLEKgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235091AbjLEKgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 05:36:01 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AA5109;
        Tue,  5 Dec 2023 02:36:07 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c9e9c2989dso43959191fa.0;
        Tue, 05 Dec 2023 02:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701772566; x=1702377366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aU0vmmGkk5jZZzl83+7pZTLNraC38rsdaXbaqMF+jj8=;
        b=dfNKg7Bsak6WcwaRvWtTSAVu6DwAdr6SY+xe3ymi1KC6bV5jCKTa9iX1HuHaVaHp9e
         N/hoFj8SOJfxoUJ+UtTjy5E6HNaouC6ONf8EDxZEq8eUCqYFaKPD7VkSWOCa1qcqZ6SF
         FlNeuUJ8clFQapu87GOeup5DTY9AMsSSdPr/eQAnrO8y6hjdrsD5SIx8iCPjFqi3eDyK
         twSvn/yKC2mhLU1tg+HqtmWavHNyNpscJr2myKuyPUW8iFx/kU4s75KZ/xAddO5lKHx4
         gQNaauSZEP6pIEee9aYUJlS6I1eIzEfe9gFcD9mqSKe+KTWteWI5Pau90bU4sawl02VT
         qkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701772566; x=1702377366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aU0vmmGkk5jZZzl83+7pZTLNraC38rsdaXbaqMF+jj8=;
        b=e9sv8hDwx46U4bLxKc/JN2ojs63kAea2xGTRC5PlviKcU9LJQZ4zYfnb+d48Fyl2JW
         ExOSYdUfhGRmNXncjLrEdFIxQ4uBhtxyoKy0nWVffkzt1+L1+txtiWQM07+4nYeY+pne
         Fc750N1s3k5/3jor48vUhJeSApjJcS0VRFNjSNjR+8NLKIsRM+eN3UrxcnceEvoL11HX
         nYhrDQiqCFMWp1v37cStYvL6Sm7oUIiQLwkBgPSapvh5loxtm+S50To4lnL/mpKElrJ0
         3CX5E7XBrV/nBbAFkAnyvESYCp4jJgoC4YKT7aMG56U0IzkU/91nDnye7OtWkyEg7w1z
         ozTQ==
X-Gm-Message-State: AOJu0Yw6oWR9rLUMjTe8ltiByUgdA0ZkhYfFc1pQXEXbnBzb1yBOlI4v
        DxWiw/BY9x7GkDBLPp8e/wc=
X-Google-Smtp-Source: AGHT+IEyzagyInlkk1nPyBZ4FwyLEwY/Eu+fMNUrVKFjMERCNTvfyTC7suwpCzoymVY+rBHcqsbPYg==
X-Received: by 2002:a2e:9a94:0:b0:2ca:fa5:83ef with SMTP id p20-20020a2e9a94000000b002ca0fa583efmr844131lji.6.1701772565635;
        Tue, 05 Dec 2023 02:36:05 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id u8-20020a2e9f08000000b002c9f1436d86sm1029551ljk.92.2023.12.05.02.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 02:36:05 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>, openbmc@lists.ozlabs.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 02/16] net: pcs: xpcs: Drop redundant workqueue.h include directive
Date:   Tue,  5 Dec 2023 13:35:23 +0300
Message-ID: <20231205103559.9605-3-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231205103559.9605-1-fancer.lancer@gmail.com>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
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

There is nothing CM workqueue-related in the driver. So the respective
include directive can be dropped.

While at it add an empty line delimiter between the generic and local path
include directives.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/net/pcs/pcs-xpcs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index dc7c374da495..7f8c63922a4b 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -10,7 +10,7 @@
 #include <linux/pcs/pcs-xpcs.h>
 #include <linux/mdio.h>
 #include <linux/phylink.h>
-#include <linux/workqueue.h>
+
 #include "pcs-xpcs.h"
 
 #define phylink_pcs_to_xpcs(pl_pcs) \
-- 
2.42.1

