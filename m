Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB9D7F128C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjKTL5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjKTL5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:57:39 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BE1A2;
        Mon, 20 Nov 2023 03:57:35 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40836ea8cbaso13385625e9.0;
        Mon, 20 Nov 2023 03:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1700481453; x=1701086253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wlRM7s7AwJA6jQyeAzn6w32c4a5iZMAHFFyfe3I5QmU=;
        b=HdLVKroHtY2CZQ0pXiFpnOXUvn6lh4uHrgbfO6NuDrLs2JER7K0L1cSsoY5TyIxqHl
         v023miMr4rBYintXOUMKYUgfQwBEUrC5NSK+ZOnWfsj3baVNqCBbsLG1QasMQaHTxQHM
         zSfDRaFsud29nLsnBtQnLSuYzdd4h8nLTDsaJDwS53CnNcr8+/o3oBftxGRHwAugcmn+
         vbl4HAfvYB6+WCj3+XgcoGokv3Wc80s2/EB2aTxpKy/Pwriqs8cIXNfgPtK/6tmySy5c
         DrE7Z9oIRDEAOT4r6azLvZLytv93rNdYaYYm07H4o0mufjSHJakEFLpjJ3Sv2knf1voB
         yG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700481453; x=1701086253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wlRM7s7AwJA6jQyeAzn6w32c4a5iZMAHFFyfe3I5QmU=;
        b=E6dY/mY9qaDrevwAWxyjRxrQrbIVET7y2H8I4ysF62Pno5b8nhUh5S2RsycT/hTzvM
         Q6SSqTU0Mafq4Br9abpclGWYGPBRMxiYB88EcpeskmtKjOlPJZV1xQwq3MNbug5nWZQ+
         EId4IaOE/mWA/4BxXDoIo0/unLMksWu2WlQveEiTxp4M4OYzFtSBbDFNgNAPc70MFzpB
         zoKhc6X/pDnL9v84lL25pCAnznND8DlxOw/JJ5lNGHXhDA1HLmDikbb008S7dYzgyGBP
         aR2hwiWoiO5Jk2o+ZK8tmLhdvD7Y3MLiNJIRjicwGv6RT1ATJlvU1VlfdXw23KwMHY++
         aMIw==
X-Gm-Message-State: AOJu0YwKDXx3Z/BNw7oMRMtC1DYi+LxL0yzE9if7UkcDuwAHnVItPMYg
        djGYic68jQtZIa08D7u/KS8JCFCxquk=
X-Google-Smtp-Source: AGHT+IHEIwHg7IkYNWnHYgq6LARx+aHWJhyL4OTkjM5joRlRC++kgOnEm66BG8nqkmNK396J5byWxQ==
X-Received: by 2002:a05:600c:81e:b0:40a:463c:1de0 with SMTP id k30-20020a05600c081e00b0040a463c1de0mr5862005wmp.34.1700481453133;
        Mon, 20 Nov 2023 03:57:33 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-91c1-d400-0000-0000-0000-0e63.310.pool.telefonica.de. [2a02:3100:91c1:d400::e63])
        by smtp.googlemail.com with ESMTPSA id r14-20020a05600c35ce00b004094d4292aesm13149635wmq.18.2023.11.20.03.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 03:57:32 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-wireless@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jernej.skrabec@gmail.com,
        pkshih@realtek.com, ulf.hansson@linaro.org, kvalo@kernel.org,
        tony0620emma@gmail.com, lukas@mntre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3] wifi: rtw88: sdio: Honor the host max_req_size in the RX path
Date:   Mon, 20 Nov 2023 12:57:26 +0100
Message-ID: <20231120115726.1569323-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Changes since v2 at [2]:
- Don't initialize err to zero as that intiial value is never used.
  Thanks Ping-Ke for spotting this!
- Add a comment explaning why we need to continue reading but still
  have to return an error to the caller of rtw_sdio_read_port()

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
[2] https://lore.kernel.org/linux-wireless/20230806181656.2072792-1-martin.blumenstingl@googlemail.com/


 drivers/net/wireless/realtek/rtw88/sdio.c | 35 ++++++++++++++++++-----
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index 2c1fb2dabd40..0cae5746f540 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -500,19 +500,40 @@ static u32 rtw_sdio_get_tx_addr(struct rtw_dev *rtwdev, size_t size,
 static int rtw_sdio_read_port(struct rtw_dev *rtwdev, u8 *buf, size_t count)
 {
 	struct rtw_sdio *rtwsdio = (struct rtw_sdio *)rtwdev->priv;
+	struct mmc_host *host = rtwsdio->sdio_func->card->host;
 	bool bus_claim = rtw_sdio_bus_claim_needed(rtwsdio);
 	u32 rxaddr = rtwsdio->rx_addr++;
-	int ret;
+	int ret = 0, err;
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
+
+			 /* Signal to the caller that reading did not work and
+			  * that the data in the buffer is short/corrupted.
+			  */
+			ret = err;
+
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
2.42.1

