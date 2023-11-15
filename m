Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F267EC0F7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 11:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbjKOKxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 05:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbjKOKxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 05:53:38 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F910E5;
        Wed, 15 Nov 2023 02:53:35 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AC412204E1;
        Wed, 15 Nov 2023 10:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1700045613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=nJlTjVsKvqAx1MhYNThg4ZiwuUl92g9J7t21qFU454A=;
        b=T5OUra8iaaEu/czuEVDvIjZCJxhUTMykkkKpHoBiOhUs+8dusly/UfxhxfH4Ox2ucEbhgM
        8knFx9+AQqnZfG62lEh+34nfcyC5izn+7zLwQ0XrNvkwkxKmGfhWjXfPuUS7FoYOYzWHQ+
        xcqZi4ofPahjA2h0AsPkIgxSAEl4BOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1700045613;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=nJlTjVsKvqAx1MhYNThg4ZiwuUl92g9J7t21qFU454A=;
        b=SCWWF6CPFX72r/CoFBBnQaHOQAL8xvDdECHe00FWN9sFGmC8nYTMlZZktjXVlj10QxiKhi
        tUJMQD0aZgepvDCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C73313587;
        Wed, 15 Nov 2023 10:53:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cKXAHC2jVGULXgAAMHmgww
        (envelope-from <jdelvare@suse.de>); Wed, 15 Nov 2023 10:53:33 +0000
Date:   Wed, 15 Nov 2023 11:53:31 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     linux-mips@vger.kernel.org, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@kernel.org>
Subject: [PATCH v2] stmmac: dwmac-loongson: Add architecture dependency
Message-ID: <20231115115331.19eb0c24@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.34; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -4.39
X-Spamd-Result: default: False [-4.39 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         RCPT_COUNT_FIVE(0.00)[5];
         HAS_ORG_HEADER(0.00)[];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         FREEMAIL_TO(0.00)[gmail.com];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.29)[74.63%]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only present the DWMAC_LOONGSON option on architectures where it can
actually be used.

This follows the same logic as the DWMAC_INTEL option.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Keguang Zhang <keguang.zhang@gmail.com>
---
Changes since v1:
* Enable build testing (suggested by Simon Horman)

 drivers/net/ethernet/stmicro/stmmac/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-6.6.orig/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ linux-6.6/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -269,7 +269,7 @@ config DWMAC_INTEL
 config DWMAC_LOONGSON
 	tristate "Loongson PCI DWMAC support"
 	default MACH_LOONGSON64
-	depends on STMMAC_ETH && PCI
+	depends on (MACH_LOONGSON64 || COMPILE_TEST) && STMMAC_ETH && PCI
 	depends on COMMON_CLK
 	help
 	  This selects the LOONGSON PCI bus support for the stmmac driver,


-- 
Jean Delvare
SUSE L3 Support
