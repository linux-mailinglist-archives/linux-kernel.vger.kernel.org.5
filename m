Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E907D73A4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbjJYS4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjJYS4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:56:48 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD4A128
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:56:46 -0700 (PDT)
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3CA74420BD
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 18:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1698260201;
        bh=8ZSwQnx25XWx6H9WHSt+QTyzglk67NwsJMp2gzIlTF8=;
        h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type;
        b=GbSibbBa4tVV4lVnR4ybd+F6PQMPvKKZ5DeCzoKJR/k4MluYb4SBVGIajztDgGuzd
         6xcVCO+19QNcDzGIxgjWhDVBTOy5ZMPrccTz36LVLKuQKorMXyKLhlLC816vGW1N3v
         y65JZFHzh5Mc4UjSdUHBLz8HKvMnzzGpIUtGIPDERyrZIBnX8NPXbFEQFoooTeyDtv
         7pypIWSn46kLQ96qOo/K+IZopZvVHLv7UIxT2xLaSY3XUlx9tMCFCPNh5SWUK18qr5
         7zCDW880PnJvottTIcOmhFMzdLumBYFxE91QUGmcaN/lWAMbLfm/pX465jiiXwVD0j
         bUW0iZILaVDwg==
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-41cb6df5c7bso1682401cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698260200; x=1698865000;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ZSwQnx25XWx6H9WHSt+QTyzglk67NwsJMp2gzIlTF8=;
        b=CMNFvFUR1ihbo/qmWjMdgyESaOPzPfKTfTC802HzKx9hfre7TPhnCHUFxhX3XXZqLn
         RJv6+6iHyYmdIJve4AcjFNPOniirRUPNzkziqJPxzaRy3JtPQ3wQ0aoliGGZOomuWZyE
         K6lgMhCoiK7t6/dG7024MjT3G9NkHtv+0Yw+hBu5MuXJV0YV5j5kaCoaLKXMsxg6utYo
         0WzwkSSSevHGDTBTnoQBNBecKHi1ynz2aLo+FZVJ6Yu2zoqALUctcjDvPUIg3NmdKG1O
         hsdF5XJcKfkAasJ95swvFjZVFxnCWx66PA84F+Tq+52sJ/X26JvpJf22jveekoi5BwyQ
         fffg==
X-Gm-Message-State: AOJu0YxJkkHR8RRKOddaqKYHO9d3KE2QNSV0wL+619jjQ1VpdcetZsGP
        Tm34VHf1g6kJlglJSfQBjP6ZX3JtOdp/OaoIwVhX/rjT3raFxMfW34rmSfSqXG08YB3bp4z87kE
        RMs2TIglK6k7vya2KkLtcjmyFLtg1pX38K6oZj5jnNbgZbNRDe0SC3osOpA==
X-Received: by 2002:a05:622a:1b9f:b0:417:bd2c:2683 with SMTP id bp31-20020a05622a1b9f00b00417bd2c2683mr17944695qtb.19.1698260200206;
        Wed, 25 Oct 2023 11:56:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJTkG3zv5DTeWRvY1y/BasKIXcM7hXfHiMkDTcbRf8mjI+q0VqgB+zstaBrwJ9z4uKKWXR3bFMed8oDTtI7W0=
MIME-Version: 1.0
X-Received: by 2002:a05:622a:1b9f:b0:417:bd2c:2683 with SMTP id
 bp31-20020a05622a1b9f00b00417bd2c2683mr17944683qtb.19.1698260199921; Wed, 25
 Oct 2023 11:56:39 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Oct 2023 11:56:39 -0700
From:   emil.renner.berthing@canonical.com
Date:   Wed, 25 Oct 2023 11:56:39 -0700
Message-ID: <CAJM55Z_U9R6R_t1g5KANV5hQwP91TcHYKGwbnHxXXs5fm0y7Yw@mail.gmail.com>
Subject: [PATCH 2/4] soc: sifive: ccache: Add StarFive JH7100 support
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

This adds support for the StarFive JH7100 SoC which also features this
SiFive cache controller.

Unfortunately the interrupt for uncorrected data is broken on the JH7100
and fires continuously, so add a quirk to not register a handler for it.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/soc/sifive/sifive_ccache.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/sifive/sifive_ccache.c
b/drivers/soc/sifive/sifive_ccache.c
index 3684f5b40a80..676468c35859 100644
--- a/drivers/soc/sifive/sifive_ccache.c
+++ b/drivers/soc/sifive/sifive_ccache.c
@@ -106,6 +106,7 @@ static void ccache_config_read(void)
 static const struct of_device_id sifive_ccache_ids[] = {
 	{ .compatible = "sifive,fu540-c000-ccache" },
 	{ .compatible = "sifive,fu740-c000-ccache" },
+	{ .compatible = "starfive,jh7100-ccache", .data = (void *)BIT(DATA_UNCORR) },
 	{ .compatible = "sifive,ccache0" },
 	{ /* end of table */ }
 };
@@ -210,11 +211,15 @@ static int __init sifive_ccache_init(void)
 	struct device_node *np;
 	struct resource res;
 	int i, rc, intr_num;
+	const struct of_device_id *match;
+	unsigned long broken_irqs;

-	np = of_find_matching_node(NULL, sifive_ccache_ids);
+	np = of_find_matching_node_and_match(NULL, sifive_ccache_ids, &match);
 	if (!np)
 		return -ENODEV;

+	broken_irqs = (uintptr_t)match->data;
+
 	if (of_address_to_resource(np, 0, &res)) {
 		rc = -ENODEV;
 		goto err_node_put;
@@ -240,6 +245,10 @@ static int __init sifive_ccache_init(void)

 	for (i = 0; i < intr_num; i++) {
 		g_irq[i] = irq_of_parse_and_map(np, i);
+
+		if (broken_irqs & BIT(i))
+			continue;
+
 		rc = request_irq(g_irq[i], ccache_int_handler, 0, "ccache_ecc",
 				 NULL);
 		if (rc) {
-- 
2.40.1
