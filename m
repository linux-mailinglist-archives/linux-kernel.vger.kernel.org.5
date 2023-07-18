Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F86E75868E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 23:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjGRVJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 17:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjGRVJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 17:09:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60221BC6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 14:09:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF86B60F6B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 21:09:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BBCC433C8;
        Tue, 18 Jul 2023 21:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689714561;
        bh=N6XTQEhb2xZTZVgodkQXohG4i3IDBfEIFKImePH/pAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OcckALaLmpk8OVUaLOAeipOiQDNX5C9Rljb+6GAw6rS8xnJJRufq1TpshQLfYPyzK
         v7AHFivWg1WNu2NFBK479Pdd0Oy3U8CXl8H28Dz3Nk/V92DPkKogRK0AjlDAb9tIGn
         zHm+w0X57/B5qa2do3wYXCy4mVdFkiil1VR2DuH0M5H9+g7j58/6ADiNGjhYGALlSm
         xL8xybCTYvLdaCyQf+Ls8p7bXPWm/8uSk4iN4kwRjAVP3FFe85OmxLEpQrNzUXImvl
         xnIu/+qpOXnAYNbkfOavaUdAVZlUyR5N0msz/Gj/iWjHcR+x0JNmguEH/sRzx0OVvk
         GHFPuGwVYB6XA==
Received: (nullmailer pid 1830812 invoked by uid 1000);
        Tue, 18 Jul 2023 21:09:19 -0000
From:   Rob Herring <robh@kernel.org>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: sti: Drop unused includes
Date:   Tue, 18 Jul 2023 15:08:40 -0600
Message-Id: <20230718210839.1824792-2-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230718210839.1824792-1-robh@kernel.org>
References: <20230718210839.1824792-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several includes are not needed, so drop them.

Signed-off-by: Rob Herring <robh@kernel.org>
---
This depends on patch 1.

 arch/arm/mach-sti/board-dt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-sti/board-dt.c b/arch/arm/mach-sti/board-dt.c
index ffecbf29646f..488084b61b4a 100644
--- a/arch/arm/mach-sti/board-dt.c
+++ b/arch/arm/mach-sti/board-dt.c
@@ -4,8 +4,6 @@
  * Author(s): Srinivas Kandagatla <srinivas.kandagatla@st.com>
  */
 
-#include <linux/irq.h>
-#include <linux/of_platform.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 
-- 
2.40.1

