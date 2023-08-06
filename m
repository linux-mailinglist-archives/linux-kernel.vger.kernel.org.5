Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1A2771669
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 20:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjHFSRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 14:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHFSRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 14:17:21 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DF01716;
        Sun,  6 Aug 2023 11:17:19 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe1e1142caso38029165e9.0;
        Sun, 06 Aug 2023 11:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1691345838; x=1691950638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D9NrrcIw0SRAawkmaiD2pvBC8NPzwAJf1+tu6UTui2g=;
        b=bwCDxkOvJdHTWCnVS/jZDuQf+7e2nRlUwM1/79NQcwKGGbL4KFGLufFeNMiYw0tXWB
         6Q0ApiKfI5KCOEZ2oBlmjmwSMUuGeIzXYPjKjCPV1HLTYTbBTzWaT8VjIANYTxYo2qtR
         XkwOKXAkeYLnAywIqUTEKOcpEesj7t5nPC4sZy1CzY9u/lCup77Jg+n20b4zPh6g7En1
         7wnvB0Ka9YQt7Tn48wBdF+LQe+1UHmZpwNtqZk5UYSPFthR/k2bRmL9viMypaBdtTlxt
         p5pAKRICsKMIRkaQGwnBPkQz+f0B4HyGzB5EE5u4wK2Hfpf/ZP+0azMuLJPHL6Ib/yBx
         Z/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691345838; x=1691950638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D9NrrcIw0SRAawkmaiD2pvBC8NPzwAJf1+tu6UTui2g=;
        b=Fj9yuQx+j0GXt52gv1XpMP9XiDA0VHV48gbtln7WdnniPSYpBGP9GzyaDV4Miv6iL+
         Jwy7Mx/fwK+udyzB3qYDodcmOr6kXNgRLaD4vyO+rqgnRX74qDDgOPGTFwFvMBn+kTD+
         FUhb7r4YqgFzg9E+gxYe+vFYmDRsotpJM3XbIbwqLrX8ithmN/AyguH6q1M/L7dyJ0Uy
         WPDbrmHqbGnzmluogU/X5lv71+MDGDLvE+KlqTr45xtbchxjqRhEw3JsqSWxvTEQQ8Cn
         A5VEhdJPFzraHGCUeRTQc6uHh7RF5lR7/XSbeXHrTJTwszQ+odIvtfqwtqEVjinGko++
         nUTg==
X-Gm-Message-State: AOJu0YzCuE6rBJIhg/56Q4hCwaUma1SivUT4qF4Jz9ynDYIe/ucw9vLE
        Cvz8yRl5ctd/GdTn0r8PIfToun98mpQ=
X-Google-Smtp-Source: AGHT+IGBfz5219P5gXXkticiosYBXpfsSfV/OW5qeGI9qz5x38kuGndJwpfhqnkK8Z0MWri8hJYyTg==
X-Received: by 2002:a05:600c:2155:b0:3fe:173e:4a54 with SMTP id v21-20020a05600c215500b003fe173e4a54mr5791276wml.17.1691345837709;
        Sun, 06 Aug 2023 11:17:17 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c22-7b51-7e00-0000-0000-0000-0e63.c22.pool.telefonica.de. [2a01:c22:7b51:7e00::e63])
        by smtp.googlemail.com with ESMTPSA id m8-20020a7bce08000000b003fbd9e390e1sm12664948wmc.47.2023.08.06.11.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 11:17:17 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-wireless@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jernej.skrabec@gmail.com,
        pkshih@realtek.com, ulf.hansson@linaro.org, kvalo@kernel.org,
        tony0620emma@gmail.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "Lukas F . Hartmann" <lukas@mntre.com>
Subject: [PATCH v2] wifi: rtw88: sdio: Honor the host max_req_size in the RX path
Date:   Sun,  6 Aug 2023 20:16:56 +0200
Message-ID: <20230806181656.2072792-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas reports skb_over_panic errors on his Banana Pi BPI-CM4 which comes
with an Amlogic A311D (G12B) SoC and a RTL8822CS SDIO wifi/Bluetooth
combo card. The error he observed is identical to what has been fixed
in commit e967229ead0e ("wifi: rtw88: sdio: Check the HISR RX_REQUEST
bit in rtw_sdio_rx_isr()") but that commit didn't fix Lukas' problem.

Lukas found that disabling or limiting RX aggregation works around the
problem for some time (but does not fully fix it). In the following
discussion a few key topics have been discussed which have an impact on
this problem:
- The Amlogic A311D (G12B) SoC has a hardware bug in the SDIO controller
  which prevents DMA transfers. Instead all transfers need to go through
  the controller SRAM which limits transfers to 1536 bytes
- rtw88 chips don't split incoming (RX) packets, so if a big packet is
  received this is forwarded to the host in it's original form
- rtw88 chips can do RX aggregation, meaning more multiple incoming
  packets can be pulled by the host from the card with one MMC/SDIO
  transfer. This Depends on settings in the REG_RXDMA_AGG_PG_TH
  register (BIT_RXDMA_AGG_PG_TH limits the number of packets that will
  be aggregated, BIT_DMA_AGG_TO_V1 configures a timeout for aggregation
  and BIT_EN_PRE_CALC makes the chip honor the limits more effectively)

Use multiple consecutive reads in rtw_sdio_read_port() and limit the
number of bytes which are copied by the host from the card in one
MMC/SDIO transfer. This allows receiving a buffer that's larger than
the hosts max_req_size (number of bytes which can be transferred in
one MMC/SDIO transfer). As a result of this the skb_over_panic error
is gone as the rtw88 driver is now able to receive more than 1536 bytes
from the card (either because the incoming packet is larger than that
or because multiple packets have been aggregated).

In case of an receive errors (-EILSEQ has been observed by Lukas) we
need to drain the remaining data from the card's buffer, otherwise the
card will return corrupt data for the next rtw_sdio_read_port() call.

Fixes: 65371a3f14e7 ("wifi: rtw88: sdio: Add HCI implementation for SDIO based chipsets")
Reported-by: Lukas F. Hartmann <lukas@mntre.com>
Closes: https://lore.kernel.org/linux-wireless/CAFBinCBaXtebixKbjkWKW_WXc5k=NdGNaGUjVE8NCPNxOhsb2g@mail.gmail.com/
Suggested-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---


Changes since v1 at [0]:
- We need to read all bytes if we split the transaction into multiple
  smaller reads. This is even the case when one of N reads reports an
  error. Otherwise the next read port call will return garbage (partially
  containing zeros, ...). A similar-ish approach can be found in the
  vendor driver, see [1] (specifically the call to sdio_recv_and_drop())
- Update the patch description accordingly

With a preliminary version of this updated patch Lukas reported off-
list: "i've been using this laptop for almost 3 hours with heavy wifi
usage and so far no problems"


[0] https://lore.kernel.org/lkml/169089906853.212423.17095176293160428610.kvalo@kernel.org/T/
[1] https://github.com/chewitt/RTL8822CS/blob/ad1391e219b59314485739a499fb442d5bbc069e/hal/rtl8822c/sdio/rtl8822cs_io.c#L468-L477


 drivers/net/wireless/realtek/rtw88/sdio.c | 30 +++++++++++++++++------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index 2c1fb2dabd40..553b7e68ca3b 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -500,19 +500,35 @@ static u32 rtw_sdio_get_tx_addr(struct rtw_dev *rtwdev, size_t size,
 static int rtw_sdio_read_port(struct rtw_dev *rtwdev, u8 *buf, size_t count)
 {
 	struct rtw_sdio *rtwsdio = (struct rtw_sdio *)rtwdev->priv;
+	struct mmc_host *host = rtwsdio->sdio_func->card->host;
 	bool bus_claim = rtw_sdio_bus_claim_needed(rtwsdio);
 	u32 rxaddr = rtwsdio->rx_addr++;
-	int ret;
+	int ret = 0, err = 0;
+	size_t bytes;
 
 	if (bus_claim)
 		sdio_claim_host(rtwsdio->sdio_func);
 
-	ret = sdio_memcpy_fromio(rtwsdio->sdio_func, buf,
-				 RTW_SDIO_ADDR_RX_RX0FF_GEN(rxaddr), count);
-	if (ret)
-		rtw_warn(rtwdev,
-			 "Failed to read %zu byte(s) from SDIO port 0x%08x",
-			 count, rxaddr);
+	while (count > 0) {
+		bytes = min_t(size_t, host->max_req_size, count);
+
+		err = sdio_memcpy_fromio(rtwsdio->sdio_func, buf,
+					 RTW_SDIO_ADDR_RX_RX0FF_GEN(rxaddr),
+					 bytes);
+		if (err) {
+			rtw_warn(rtwdev,
+				 "Failed to read %zu byte(s) from SDIO port 0x%08x: %d",
+				 bytes, rxaddr, err);
+			ret = err;
+			/* Don't stop here - instead drain the remaining data
+			 * from the card's buffer, else the card will return
+			 * corrupt data for the next rtw_sdio_read_port() call.
+			 */
+		}
+
+		count -= bytes;
+		buf += bytes;
+	}
 
 	if (bus_claim)
 		sdio_release_host(rtwsdio->sdio_func);
-- 
2.41.0

