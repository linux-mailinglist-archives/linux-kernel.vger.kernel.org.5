Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F3D7F92D9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 14:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjKZN1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 08:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKZN1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 08:27:51 -0500
X-Greylist: delayed 473 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 26 Nov 2023 05:27:56 PST
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.61.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57039CB;
        Sun, 26 Nov 2023 05:27:56 -0800 (PST)
Received: from mors-relay-8403.netcup.net (localhost [127.0.0.1])
        by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4SdTpp1VJkz7yTy;
        Sun, 26 Nov 2023 14:20:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bigler.one; s=key2;
        t=1701004802; bh=uVRzzBCF4paLxzieeLLtTwlIaakwDhPEHY3e2Bh7tG4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:From;
        b=Qsz8/KJWo3SBW7W1lXOhGiTa9bO/X1Ps9BA1+df9oYyX+g96m2liuR3QHDXwe85oF
         6ur5SoRZX5Sz1tLtrZCr58lCaFhV4AhE6TtJyhvaix1l3DjFJxNrnUSV+u+TZ7Fh4v
         4AmYrOcJJj9WejrVSF2V7/zDTIXcR3LTCHALLoLZeVXvXZkhtLAjP43fXO2JGhdVpl
         Vo5IyvASDOn7lzjzz9G2bD0Y9NMJ4lOBeQkUGpsBTegUPDwwnkwJV9gTvlGf2S6OJz
         xwzj2Cvv+/+eFmbRrLkBIJvxVFhRHK2CEhmwS2voLTjUgLZp3wFj9xZ/h2LI0BaxuO
         TinMd5A3KO79w==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
        by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4SdTpp16Rnz7yTr;
        Sun, 26 Nov 2023 14:20:02 +0100 (CET)
Received: from mx2fc6.netcup.net (unknown [10.243.12.53])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by policy02-mors.netcup.net (Postfix) with ESMTPS id 4SdTpn51W7z8sb3;
        Sun, 26 Nov 2023 14:20:01 +0100 (CET)
Received: from [192.168.1.24] (xdsl-188-155-37-14.adslplus.ch [188.155.37.14])
        by mx2fc6.netcup.net (Postfix) with ESMTPSA id 527D045332;
        Sun, 26 Nov 2023 14:19:56 +0100 (CET)
Authentication-Results: mx2fc6;
        spf=pass (sender IP is 188.155.37.14) smtp.mailfrom=benjamin@bigler.one smtp.helo=[192.168.1.24]
Received-SPF: pass (mx2fc6: connection is authenticated)
Message-ID: <c7a38307ac74a973e26ac820a0b98773262720bd.camel@bigler.one>
Subject: Re: spi: imx: Increase imx51 ecspi burst length fails on imx6dl and
 imx8mm
From:   Benjamin Bigler <benjamin@bigler.one>
To:     benjamin@bigler.one
Cc:     broonie@kernel.org, francesco@dolcini.it,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux@bigler.io, regressions@lists.linux.dev,
        stefan.moring@technolution.nl
Date:   Sun, 26 Nov 2023 14:19:56 +0100
In-Reply-To: <d795999676663a576f12f07a7013bee758fb781c.camel@bigler.one>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0
MIME-Version: 1.0
X-PPP-Message-ID: <170100479677.15558.18148883779792436293@mx2fc6.netcup.net>
X-Rspamd-Queue-Id: 527D045332
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: kYRkZ2AOFCC+H9Oy2v18BeW7JhyV9AINPEWKK4erKCUhXdA=
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I did some debugging and I think the problem is that in this case bits_per_=
word is 8. So in
spi_imx_dma_configure the buswidth is set to DMA_SLAVE_BUSWIDTH_1_BYTE. But=
 in
mx51_ecspi_prepare_transfer the BURST_LENGTH is now set to (spi_imx->count =
* spi_imx->bits_per_word
- 1)
before 15a6af94a2779d5dfb42ee4bfac858ea8e964a3f it was (spi_imx->bits_per_w=
ord - 1). Now the spi
transmits 4 byte per byte except for the first word. I added the following =
patch and it worked again

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 498e35c8db2c..f514966e2ada 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -659,11 +659,22 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx=
_data *spi_imx,
 		ctrl |=3D (spi_imx->target_burst * 8 - 1)
 			<< MX51_ECSPI_CTRL_BL_OFFSET;
 	else {
-		if (spi_imx->count >=3D 512)
-			ctrl |=3D 0xFFF << MX51_ECSPI_CTRL_BL_OFFSET;
-		else
-			ctrl |=3D (spi_imx->count * spi_imx->bits_per_word - 1)
+		if (spi_imx->usedma)
+			ctrl |=3D (spi_imx->bits_per_word *
+					 spi_imx_bytes_per_word(
+						 spi_imx->bits_per_word) -
+				 1)
 				<< MX51_ECSPI_CTRL_BL_OFFSET;
+		else {
+			if (spi_imx->count >=3D MX51_ECSPI_CTRL_MAX_BURST)
+				ctrl |=3D (MX51_ECSPI_CTRL_MAX_BURST - 1)
+					<< MX51_ECSPI_CTRL_BL_OFFSET;
+			else
+				ctrl |=3D (spi_imx->count *
+						 spi_imx->bits_per_word -
+					 1)
+					<< MX51_ECSPI_CTRL_BL_OFFSET;
+		}
 	}
=20
 	/* set clock speed */

Best regards,
Benjamin Bigler

