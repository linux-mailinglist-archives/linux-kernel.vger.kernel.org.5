Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A305F771431
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 11:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjHFJco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 05:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjHFJcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 05:32:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F059F3;
        Sun,  6 Aug 2023 02:32:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B8B060FFF;
        Sun,  6 Aug 2023 09:32:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E103C433CA;
        Sun,  6 Aug 2023 09:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691314358;
        bh=DXeugDAACdhg9l7C34Qgdlwo7dhx5GjmUFqTsipeB0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uVrbbOOcZGFF+EtxOnb9SfVeKmKrNXmA8pibv3fg5Z3hyc9Na7dG+RyOc53gKPp4c
         GvxkzrQuGSef/o6c8X8Owq6H/EYLh/39iq3oNfFMdy2OpSHF0ZkhXZ7RjvjA+ll8CN
         SG/QEXAdL9TQ+GqMo0nKrahCy60542cWlSIcvGHx65XoWuHDVEXptBEABaWg9vGf/I
         EMpNaZB9E1sa60Tkyzho8artbV7shsTOm5YyjhUxMvD3Y0ulJVQHTzEET+2Wco6bJP
         zjymIqMReAu1zCYaTvvljKVmrVYfSDQjDTquO3Nx9sPG+cudFchNEbdx5V60QzImjV
         OCdMF4euPk1sA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: serial: snps-dw-apb-uart: make interrupt optional
Date:   Sun,  6 Aug 2023 17:20:55 +0800
Message-Id: <20230806092056.2467-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230806092056.2467-1-jszhang@kernel.org>
References: <20230806092056.2467-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver fall back to poll style when there's no irq. "poll" still
looks better than no support.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 3862411c77b5..17c553123f96 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -117,7 +117,6 @@ properties:
 required:
   - compatible
   - reg
-  - interrupts
 
 unevaluatedProperties: false
 
-- 
2.40.1

