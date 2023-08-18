Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62AED780988
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 12:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359694AbjHRKE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359657AbjHRKD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:03:58 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F23422A;
        Fri, 18 Aug 2023 03:03:37 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-689fa6f94e1so570630b3a.1;
        Fri, 18 Aug 2023 03:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692352959; x=1692957759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KWK94KLa+RXOTyZSYZJIvaS/n+OcRc5XJNe1k7WdNQ=;
        b=gMMVhkMKPJJSWmiu5Iv5hHM6xQ+TavjtCJRKx0J8rq9QbbN0F9Qmd/JRQy8sQZ/V/U
         RSY2Widy/jbHNPUsaJiRvgDIMID8emxp0F0+i4s0Iu2khtqgyOSACLg87Qu6FDYoysBU
         4Pp4cfNBNu9YYzAOBL0JQZvBcsiP3CKYg/QRDTTDtYCUOM2wtyLcMQ+A+0AtcsjtzhS6
         ss90rfourMaF+aRUdnluGhMaVUnjS60476t2p9x6kiC0y3EAqFXnyF6ZyeHtpYWq9cC0
         JMblyRGp7MPMSTrMfNbSE745cofFKP2KhUXAT8qvyZWjW85NrTzpAqJT1UTMKRVr1GeF
         iocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692352959; x=1692957759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KWK94KLa+RXOTyZSYZJIvaS/n+OcRc5XJNe1k7WdNQ=;
        b=X3W36149CxStw3b6rdJGwtcdviXJElx+8/Z7cr3DlOKV+LuvIHJ0vM+oU9ODKA+uxO
         VUEE4qrRcPVuB782eY3W39xVXm/4aOGBhAPgetlRc1ex9s2jadQPA7/ojwUuFS02MIe1
         cr7GMAa8GkzZluROMG0Dq7lLXTe2Vz1ohAv9OBTYBcEjCIW3IQbnBLAjUio7JSZBhMcN
         supALZCzFM1b9qAkqunMXdM9Cg2AQRJ3JYQNHkqoZinfw6e3W//ur2zUJ/Hp4PARqCkx
         0p0NeZTtI+FcKBibD50LrCOZVYEwVal3JIdVY36NthvCqnz/TyriYP4GtVA3a6DvS01U
         qxhg==
X-Gm-Message-State: AOJu0Yzk8QSlnMV1UT6RT4CzRg0XYgy4GWsnVbmvEmzQczyWaApOvo5y
        H9K1At874HTpEDRoTDZCDhY=
X-Google-Smtp-Source: AGHT+IFlOFiz7+RenRilmo87F5TDyoGhohNkEiWoEto9J1+TeqK4RljpZ5l3AU9O19Txma0zh/viOg==
X-Received: by 2002:a05:6a00:2d85:b0:682:4c9f:aa0 with SMTP id fb5-20020a056a002d8500b006824c9f0aa0mr2494762pfb.29.1692352958784;
        Fri, 18 Aug 2023 03:02:38 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e25c-55ec-ad14-f925-5202-a39b.emome-ip6.hinet.net. [2001:b400:e25c:55ec:ad14:f925:5202:a39b])
        by smtp.gmail.com with ESMTPSA id n22-20020a62e516000000b006870ccfbb54sm1180649pff.196.2023.08.18.03.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 03:02:38 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>
Subject: [PATCH V10 03/23] mmc: core: Announce successful insertion of an SD UHS-II card
Date:   Fri, 18 Aug 2023 18:01:57 +0800
Message-Id: <20230818100217.12725-4-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230818100217.12725-1-victorshihgli@gmail.com>
References: <20230818100217.12725-1-victorshihgli@gmail.com>
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

From: Ulf Hansson <ulf.hansson@linaro.org>

To inform the users about SD UHS-II cards, let's extend the print at card
insertion with a "UHS-II" substring. Within this change, it seems
reasonable to convert from using "ultra high speed" into "UHS-I speed", for
the UHS-I type, as it should makes it more clear.

Note that, the new print for UHS-II cards doesn't include the actual
selected speed mode. Instead, this is going to be added from subsequent
change.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Updates in V10:
 - Modify the commit message.

Updates in V7:
 - Drop MMC_TIMING_SD_UHS2 in favor of MMC_TIMING_UHS2_SPEED_A in
   mmc_card_uhs2 function.

Updates in V4:
 - Make mmc_card_uhs2() take struct mmc_host* as in-param.

---

 drivers/mmc/core/bus.c  | 4 +++-
 drivers/mmc/core/host.h | 7 +++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index bd761e2858f1..e1760fc66d1e 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -344,7 +344,9 @@ int mmc_add_card(struct mmc_card *card)
 	if (mmc_card_hs(card))
 		speed_mode = "high speed ";
 	else if (mmc_card_uhs(card))
-		speed_mode = "ultra high speed ";
+		speed_mode = "UHS-I speed ";
+	else if (mmc_card_uhs2(card->host))
+		speed_mode = "UHS-II speed ";
 	else if	(mmc_card_ddr52(card))
 		speed_mode = "high speed DDR ";
 	else if (mmc_card_hs200(card))
diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
index 48c4952512a5..9f6e5e31dfea 100644
--- a/drivers/mmc/core/host.h
+++ b/drivers/mmc/core/host.h
@@ -89,5 +89,12 @@ static inline bool mmc_card_sd_express(struct mmc_host *host)
 		host->ios.timing == MMC_TIMING_SD_EXP_1_2V;
 }
 
+static inline bool mmc_card_uhs2(struct mmc_host *host)
+{
+	return host->ios.timing == MMC_TIMING_UHS2_SPEED_A ||
+	       host->ios.timing == MMC_TIMING_UHS2_SPEED_A_HD ||
+	       host->ios.timing == MMC_TIMING_UHS2_SPEED_B ||
+	       host->ios.timing == MMC_TIMING_UHS2_SPEED_B_HD;
+}
 #endif
 
-- 
2.25.1

