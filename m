Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0AE773C3A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjHHQCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjHHQAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:00:53 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449D82722
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 20:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1691466539;
        bh=nrjRfO2+8JOw7uXLUstSS+xBnROqeg8OtCZsp2REDi8=;
        h=From:To:Cc:Subject:Date:From;
        b=nmikUyo6ANVQRpzNd5RQRw5eTFORUQs/zVrRNxOmjGfGT2LWUlo+kC3W9ZXC0wWRc
         Pl0NemD2/IytDHtKN7m3q99IHP3MX60ZZIk8ZTg6+EgFJhMCokCXo7y7ySL5DmaWQV
         rEPZkwceGYZ4QTYm+mw3HaltCbjOocDPPXjzMoOs=
Received: from stargazer.. (unknown [IPv6:2409:8a0c:2a4:2170:40dc:a500:81f0:2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 4A2AD659C0;
        Mon,  7 Aug 2023 23:48:55 -0400 (EDT)
From:   Xi Ruoyao <xry111@xry111.site>
To:     loongarch@lists.linux.dev
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH] loongarch: Remove spurious "source drivers/firmware/Kconfig"
Date:   Tue,  8 Aug 2023 11:48:36 +0800
Message-ID: <20230808034836.418485-1-xry111@xry111.site>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In drivers/Kconfig, drivers/firmware/Kconfig is sourced for all ports so
there is no need to source it in the port-specific Kconfig file.  And
sourcing it here also caused the "Firmware Drivers" menu appeared two
times: once in the "Device Drivers" menu, another time in the toplevel
menu.  This was really puzzling.

Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 arch/loongarch/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index e71d5bf2cee0..465759f6b0ed 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -662,5 +662,3 @@ source "kernel/power/Kconfig"
 source "drivers/acpi/Kconfig"
 
 endmenu
-
-source "drivers/firmware/Kconfig"
-- 
2.41.0

