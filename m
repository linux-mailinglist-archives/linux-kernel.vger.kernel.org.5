Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5977BFF64
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbjJJOeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbjJJOeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:34:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D7FA4;
        Tue, 10 Oct 2023 07:34:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C87C433C9;
        Tue, 10 Oct 2023 14:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696948458;
        bh=XXxLYNlJGJE1fcAJSa2x2HJ6+ENG33tyodHKbEy0sq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GgYAEA7Av8rnOyEw96ImHS7wD51asHs8Ge49zGDxasZyeKcOvUC0x2pWogvhRvswb
         DEg0Fp969ZFRmyuIqKjzMo0ZWTjdnXCtSzxQq09hbwlAnMryjLpG3cSpO7ODz+8d7n
         IIHnvICBYaU7xLElyJUfnjUmidIkTMAK/FiTsvCGGZnyX28zZ2LuH55D+sAlGaPl7G
         h3ornoya1Azqbrl36U83sMK+g1NZ/Wy+z74JDUL1CWDERiOO2SGcp4eaJ7lYQSQzsh
         737LL40PAFbKRZih1ynTvLpZoaOi/kLSzb2MsuRwQyQoXs2FQQ72oaOy9crLwN8aV1
         RZEKHFrvoBO0w==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/2] MIPS: lantic: Remove unnecessary include of <linux/of_irq.h>
Date:   Tue, 10 Oct 2023 09:34:06 -0500
Message-Id: <20231010143406.974591-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010143406.974591-1-helgaas@kernel.org>
References: <20231010143406.974591-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

arch/mips/pci/fixup-lantiq.c requires nothing from <linux/of_irq.h>, so
remove the include of it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/mips/pci/fixup-lantiq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/pci/fixup-lantiq.c b/arch/mips/pci/fixup-lantiq.c
index 8f5fb98b3984..13009666204f 100644
--- a/arch/mips/pci/fixup-lantiq.c
+++ b/arch/mips/pci/fixup-lantiq.c
@@ -4,7 +4,6 @@
  *  Copyright (C) 2012 John Crispin <john@phrozen.org>
  */
 
-#include <linux/of_irq.h>
 #include <linux/of_pci.h>
 #include <linux/pci.h>
 
-- 
2.34.1

