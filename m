Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FC47DCBAA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 12:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235240AbjJaLWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 07:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjJaLW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 07:22:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB337C1;
        Tue, 31 Oct 2023 04:22:26 -0700 (PDT)
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ehristev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2016D66073A5;
        Tue, 31 Oct 2023 11:22:25 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698751345;
        bh=djAAOqovNK5U4pm2iFI+7EFqr6L7/fVfFHoXOW50dNo=;
        h=From:To:Cc:Subject:Date:From;
        b=XMpExzntdRzxALiHC7V70Yz+1smHKA4Xwiu8aBiwYs6gRG6ZKYwB32MAsb1a027I0
         R81+5dyBJaluSNWPxITYvsS9Q9VvQqoxTKFCKhfWW5XTnwl6JOI2zGlUh/XBopZIIq
         vp50fQPYpV3uCGHB29j+QQE8h7jNUEUcH3X1v5BmXurbHGdNRx7ioVNDzdk3fXCbj6
         Cxe5BanCcpwMy6WGUSvmfl8q0NJSBDPe7PrUYLUVDaqNrffMdv6SYAtphulNO4l73y
         6z/h0U/PtmQmO4CGqHS5zwaSZ87YZPQ3rUSW1p0F3Vs1OoGwCfssYVtP3NuySlv3DG
         Yfg276B8w3NBQ==
From:   Eugen Hristev <eugen.hristev@collabora.com>
To:     sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PATCH] ASoC: SOF: sof-client: trivial: fix comment typo
Date:   Tue, 31 Oct 2023 13:22:18 +0200
Message-Id: <20231031112218.79136-1-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo s/depndent/dependent

Fixes: 6e9548cdb30e ("ASoC: SOF: Convert the generic IPC flood test into SOF client")
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
 sound/soc/sof/sof-client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/sof-client.c b/sound/soc/sof/sof-client.c
index 9dce7f53b482..54dca91255a0 100644
--- a/sound/soc/sof/sof-client.c
+++ b/sound/soc/sof/sof-client.c
@@ -176,7 +176,7 @@ int sof_register_clients(struct snd_sof_dev *sdev)
 		goto err_kernel_injector;
 	}
 
-	/* Platform depndent client device registration */
+	/* Platform dependent client device registration */
 
 	if (sof_ops(sdev) && sof_ops(sdev)->register_ipc_clients)
 		ret = sof_ops(sdev)->register_ipc_clients(sdev);
-- 
2.34.1

