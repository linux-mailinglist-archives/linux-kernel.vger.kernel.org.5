Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35F975BAB0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 00:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjGTWhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 18:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjGTWhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 18:37:21 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA05171B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 15:37:20 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f9fdb0ef35so2142438e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 15:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689892638; x=1690497438;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hDwVNaCwLkj+T7Bsxj7osVe4IR5sds5yMUqYgBnFTec=;
        b=RrpAlqUm0mabMdrW7xEK50l1GNF6iN49ca5j+EY9M/WgnCWiXIvFzGDu74LWDP9eVd
         hjw6NTvs9gFiwvKY3UTHybpIibi9dafuXULKm8ypdzSxXXKRlE5F5Kr0QdG4qc0Mhc3t
         Z1+AbQPZUhtokYv1qL/qSmCi195Raf3yd0xn1gyGbhFxuJs5oToufDDt84iI+mEHt25k
         vi8txd/Tfn/QhlWKD5cUAmnVFv9BnXXR4j0UNlEY+dgvO7FsQVaV5//uD2W2ic8Tmm7a
         E03K+sR9xFjetBixY26Zd15iuY39Q92GfWofhIXeQ9oCTPG2/OrKiJZkapn7K/IOYCAe
         RL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689892638; x=1690497438;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hDwVNaCwLkj+T7Bsxj7osVe4IR5sds5yMUqYgBnFTec=;
        b=IWBRp8r/iRjEP92WsrZ3U5IBABi3QaR0wKKT/AEnHhY3uAoPk/eWaKwbv3TcyjfseH
         VRefdinUlwTBSRauLdxgiTWLXNWi9RuPbzH3OYC5/cGST0M0IXnGjPdhrBVKjG7DljxX
         IcwxuKb46/E9GIdP0iEy/DRkuzoB9rF4OVDanNZOxdZx/sHlJ31iGwcnePID3fkOO+pv
         xrWr2adnHxaU8ZTvyiN/rsFQni5beKqHF5Hz+t0Z1Ixj4VN2CNsOMQ5iHtwBsfI5uHur
         Un/s5veUcMvWendIJFnoiK/f3+RzMEsFL38wyVYjWHtBciNFAYd/Ng64UEHSmlvGdOVJ
         gMng==
X-Gm-Message-State: ABy/qLayox2L62e7Qss6s/5PKng71AHaja+RRwVkcgqmN/6eNWe42JPu
        HdNhJr6NrqxauXiOH+wGYeww/+eP7Ly32vj/
X-Google-Smtp-Source: APBJJlGijby0oVBSlZQzPuE6wRs33kVNUMfK5HpKn/sbtkGkZX2707uwvvqV3FhTi9lLbUL+RHxxuQ==
X-Received: by 2002:a05:6512:3da7:b0:4fb:52a3:e809 with SMTP id k39-20020a0565123da700b004fb52a3e809mr75159lfv.28.1689892637988;
        Thu, 20 Jul 2023 15:37:17 -0700 (PDT)
Received: from tora (83.10.92.232.ipv4.supernova.orange.pl. [83.10.92.232])
        by smtp.gmail.com with ESMTPSA id v13-20020a19740d000000b004fbab4b7d45sm408232lfe.67.2023.07.20.15.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 15:37:17 -0700 (PDT)
Date:   Fri, 21 Jul 2023 00:37:15 +0200
From:   Alicja Michalska <ahplka19@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robbarnes@google.com, lalithkraj@google.com, rrangel@chromium.org,
        bleung@chromium.org, groeck@chromium.org,
        chrome-platform@lists.linux.dev
Subject: [PATCH] platform/chrome: cros_ec_lpc: Add DMI definition for
 post-Skylake machines running custom Coreboot builds
Message-ID: <ZLm3G5G6/gmLZwkn@tora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ChromeOS EC LPC lacks DMI match for newer machines, which
use "Google" DMI_SYS_VENDOR as opposed to "GOOGLE" in older models.
This patch adds DMI definition for MrChomebox's custom Coreboots builds,
which we (Chrultrabook Project) are using.

Signed-off-by: Alicja Michalska <ahplka19@gmail.com>
---
 drivers/platform/chrome/cros_ec_lpc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 500a61b093e4..6ac993be4eb1 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -533,6 +533,14 @@ static const struct dmi_system_id cros_ec_lpc_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Glimmer"),
 		},
 	},
+	/* DMI doesn't match modern machines running custom firmware */
+	{
+		/* MrChromebox's firmware */
+		.matches = {
+			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
+			DMI_MATCH(DMI_BIOS_VERSION, "MrChromebox-"),
+		},
+	},
 	/* A small number of non-Chromebook/box machines also use the ChromeOS EC */
 	{
 		/* the Framework Laptop */
-- 
2.41.0

