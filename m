Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A768875775D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjGRJC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbjGRJCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:02:49 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04355E6F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 02:02:44 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4tJJ2cC3zBR1P3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 17:02:40 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689670960; x=1692262961; bh=bT02sggsVqEAB0NLYnxjWOz/iex
        6u/qOqO+aB6iEZec=; b=XeCN7LNNT+bD68lvt00mqgR/ax6BJYqASKBME+gA1fA
        zvsz25xPxqTY3EJ6JC1hJ/J5A6LSJFpLwEzcTy5daIF/j4uzsI643DBlRIBOWhQ1
        ZMcfyQEY2GcJvA1nX16usJS4niQopD8d9dlSOQFGXeAftvNoLQ/32cNNcFH2HuK4
        IlJ85eU9pH1Q3Z6F7HdEcePL7oc6LzQEftON2Ot5+/FYal3o8SHeGB/H783cqhGQ
        pbBMO2zHFvTad+E7B1Og36Hm0YTo3vKLIFJCbfndy1aDa0tfLRZoUu578I/uKBpy
        1ijWcI6FiYYFaHKKjzC2N5yjzHAxXRsXwtCztLYOHaQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id whCVEyeEeR0w for <linux-kernel@vger.kernel.org>;
        Tue, 18 Jul 2023 17:02:40 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4tJH5vvWzBJBfd;
        Tue, 18 Jul 2023 17:02:39 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 18 Jul 2023 17:02:39 +0800
From:   hanyu001@208suo.com
To:     agust@denx.de, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, andriy.shevchenko@linux.intel.com,
        bhelgaas@google.com, kw@linux.com, mika.westerberg@linux.intel.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platforms: 52xx: Remove space after '(' and before ')'
In-Reply-To: <tencent_ADAD5C6DD5F9824047356B25D53801910A06@qq.com>
References: <tencent_ADAD5C6DD5F9824047356B25D53801910A06@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <c5c33e6e390f6784b5599b8ea13b8e01@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch fixes the following errors detected by checkpatch:

platforms/52xx/mpc52xx_pci.c:346:ERROR: space prohibited after that open 
parenthesis '('
platforms/52xx/mpc52xx_pci.c:347:ERROR: space prohibited after that open 
parenthesis '('
platforms/52xx/mpc52xx_pci.c:348:ERROR: space prohibited before that 
close parenthesis ')'

Signed-off-by: Yu Han <hanyu001@208suo.com>
---
  arch/powerpc/platforms/52xx/mpc52xx_pci.c | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pci.c 
b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
index 0ca4401ba781..452723f8ba53 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pci.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
@@ -343,9 +343,9 @@ mpc52xx_pci_fixup_resources(struct pci_dev *dev)

      /* The PCI Host bridge of MPC52xx has a prefetch memory resource
         fixed to 1Gb. Doesn't fit in the resource system so we remove it 
*/
-    if ( (dev->vendor == PCI_VENDOR_ID_MOTOROLA) &&
-         (   dev->device == PCI_DEVICE_ID_MOTOROLA_MPC5200
-          || dev->device == PCI_DEVICE_ID_MOTOROLA_MPC5200B) ) {
+    if ((dev->vendor == PCI_VENDOR_ID_MOTOROLA) &&
+         (dev->device == PCI_DEVICE_ID_MOTOROLA_MPC5200
+          || dev->device == PCI_DEVICE_ID_MOTOROLA_MPC5200B)) {
          struct resource *res = &dev->resource[1];
          res->start = res->end = res->flags = 0;
      }
