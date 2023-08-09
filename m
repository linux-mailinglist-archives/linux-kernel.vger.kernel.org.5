Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1720D77570C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 12:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjHIK1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 06:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjHIK1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 06:27:34 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9F81FDF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 03:27:32 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 249CA40E01A3;
        Wed,  9 Aug 2023 10:27:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2KBEy6rtFKNz; Wed,  9 Aug 2023 10:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691576848; bh=hHwZiO3cl0WSFwWrnTAhlEen22AC22m/lmz1TtfKTSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hnTDEu1ARH6tQaTAZQzbygpVqchv0YBfnr8WruS5viuS5vk4i9cRU3nuvSxywq1Os
         1or3Qp2hS/ttSMDosQ+95K/83F2zFI+lRuCieyShn17/WsALWh8JprQTZ8WvJ9VgbJ
         d79fljmMx+Lok0oEb6OnJl2AzuEFedw4LrWwi0eIkIMiNsmLiyha2GCnmHZcsP7jy2
         dixr8XrhXZlzOEx0sFUVHhy32REPfMm/Rsob6/Bvi0faQEuhUwhQ67QI5W46Wf3xIl
         t+Q3PJ2LnAHcenxq/uaDG4NA0KtzJCKT4llm1mNWGoDQJduuoemchZut21g1f6Eh57
         D2MWRa5OKYvd3VNUG/ooIzK7j0Zpmn6BgFSRZlfVm/2kPHHOoygsWrjOKyUsk07qzK
         vVIkN1ZvsozRhB/SIGHgQYccjKAHunTb+Koo2BA/JPgOVVctQ9LMnwdDRPtcMHR0Jt
         NhqpemUEWpDHkTSpf092fEDml7ZbisItj7gWKOOsRZ/Yp8DrG+RNJqo1xfbndBOWOm
         NU4dF9z5eH5yot1Alkzat3MHYOV5aLRiWESdnaefinyb5Uw6iBAPbZsBPfvvcjGpN6
         7ga7vc7vRaLJzXzHbCW/uwMIBy8XVrjzPEYMZ0kOJnFnlHQxexYSGShdKmdhmC7XlA
         X8MXYGr2+5s/YYvZ5L43j/AA=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9972440E01A1;
        Wed,  9 Aug 2023 10:27:24 +0000 (UTC)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/3] Documentation/hw-vuln: Unify filename specification in index
Date:   Wed,  9 Aug 2023 12:26:58 +0200
Message-ID: <20230809102700.29449-2-bp@alien8.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809102700.29449-1-bp@alien8.de>
References: <20230809102700.29449-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Most of the index.rst files in Documentation/ refer to other rst files
without their file extension in the name. Do that here too.

No functional changes.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 Documentation/admin-guide/hw-vuln/index.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/index.rst b/Documentation/=
admin-guide/hw-vuln/index.rst
index a7d37e124831..aeee8bff5f82 100644
--- a/Documentation/admin-guide/hw-vuln/index.rst
+++ b/Documentation/admin-guide/hw-vuln/index.rst
@@ -13,11 +13,11 @@ are configurable at compile, boot or run time.
    l1tf
    mds
    tsx_async_abort
-   multihit.rst
-   special-register-buffer-data-sampling.rst
-   core-scheduling.rst
-   l1d_flush.rst
-   processor_mmio_stale_data.rst
-   cross-thread-rsb.rst
+   multihit
+   special-register-buffer-data-sampling
+   core-scheduling
+   l1d_flush
+   processor_mmio_stale_data
+   cross-thread-rsb
    srso
    gather_data_sampling.rst
--=20
2.41.0

