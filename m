Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A088800B79
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 14:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378948AbjLANK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 08:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378931AbjLANKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 08:10:52 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F7B10E2;
        Fri,  1 Dec 2023 05:10:58 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 11E5B1C0009;
        Fri,  1 Dec 2023 13:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701436257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y6S+SeJyJSSx13s7SoQDTcyNB66xoOdwpxFSTRy/oEw=;
        b=gpz4Lq9mexHB7eDRII3Y6WaRbFaseHxKbbMWZeG4Ek0q2zRg6Mk4FdfLHoYKRsUCOKWgAU
        t6xERSduhW/g+qqZ/3nXnD1D+xuR3U7WzB6YiNjvywwbCIst5FeL4HQSpNQXGY9LFzGJxW
        eCPG9RunxECaIXDQtuh9VsJrPcGMpeBy/7QRfcFkiHjS33yAehHj8KDz6w/JN3/sr9voPl
        eWjQJdKaLq0f+DWJV2SeH8ym9uGywwYjapDKboD3N7T7IDj3GisHKgrPqEl1fHh5WZo8RJ
        L7NkjbPMyz18yXH7Dte2uGJAZfaVoZJpkMj69I9fjk/f/3BvKPhWec2+9EzXPQ==
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
Date:   Fri, 01 Dec 2023 14:10:43 +0100
Subject: [PATCH 2/2] docs: nvmem: remove function parameters (fixes
 hyperlink generation)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231201-nvmem-docs-kerneldoc-v1-2-3e8f2b706ce6@bootlin.com>
References: <20231201-nvmem-docs-kerneldoc-v1-0-3e8f2b706ce6@bootlin.com>
In-Reply-To: <20231201-nvmem-docs-kerneldoc-v1-0-3e8f2b706ce6@bootlin.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: luca.ceresoli@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding a parameter is not particularly useful here, and it is definitely
not done elsewhere. It also prevents the generation of a hyperlink to the
kernel-doc documentation. Removing the parameter to enable hyperlinks and
make the style coherent.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 Documentation/driver-api/nvmem.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/nvmem.rst b/Documentation/driver-api/nvmem.rst
index d5655b95c0f4..5d9500d21ecc 100644
--- a/Documentation/driver-api/nvmem.rst
+++ b/Documentation/driver-api/nvmem.rst
@@ -41,7 +41,7 @@ A NVMEM provider can register with NVMEM core by supplying relevant
 nvmem configuration to nvmem_register(), on success core would return a valid
 nvmem_device pointer.
 
-nvmem_unregister(nvmem) is used to unregister a previously registered provider.
+nvmem_unregister() is used to unregister a previously registered provider.
 
 For example, a simple nvram case::
 

-- 
2.34.1

