Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483417A365F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 17:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235720AbjIQP2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 11:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbjIQP2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 11:28:00 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D0111F;
        Sun, 17 Sep 2023 08:27:54 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-313e742a787so2320902f8f.1;
        Sun, 17 Sep 2023 08:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694964473; x=1695569273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tt+2C7H8Lp9GSUddurKydQcPQn4TRhG9Hz2u3xUiVI4=;
        b=FWaHQzU9uco56v7WOUeq90gKntkqmDSyKs66uM6Kg/S2amqkPIUyIclhhS6GcDPsjz
         xP2LjMjD8YuKIb1Y8O70x/ibtbULSIqcY4C4MWoeehY1QxYgwk3HPouzPgOClX1tBYuh
         lb6pIco4+bCenG7e/7HEfQqc8SWSocq9q6H8EhN9okKV9NnNHpSG2YNyvSOjdWNMlBOi
         3SbrCM9oqCF/iDIwJWD4S3VVzWOpwd3WE+Ru2V9jzrqeo8Y+9hMUH4aVcquWfWZxLV19
         qnUMlujIdFe6E3cWJ/j/X8m5ex661ksIgMhtyUkdEJLhmHce3GODc+u0HwzW4gLyaIEJ
         d38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694964473; x=1695569273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tt+2C7H8Lp9GSUddurKydQcPQn4TRhG9Hz2u3xUiVI4=;
        b=xN8NDi+r7lZGxz4Lg6Lfrrqnw1vNi5Bu53uoTyK86HNXEppgmumUIEZPkndQH2/63N
         9wqUxPkljDU91tgq8nk3tVb87VmxPiy+Gy5S9wlqmaoOyjBrqUt8QfAhLYe/4BqNNTM3
         TszjSYR3VGoSo72wN8RwIZuG6ji6ftq6/qdMmSK0PFzozrRTPJmSju8pT6FqvThag20n
         613p6jjJW6YrdG/QAbj8o79m+kf7Kg9MGNBjEKYSKHDYFFRl+d33wbWf/eVAhBobVCXq
         nqVZ3tsVhdUp3zHlJ/fEMEo91apoUgU92aicUrPJyDdxeh1reOMALw/QsRYtvmQ18Gam
         Y/zA==
X-Gm-Message-State: AOJu0Yyq8VjNwlkj2/UtGcebjFDs7TQgVZ3Y6nmJZQJDow7ywmY6lZJ/
        w17wn5iMlsmyv2LJ2cIhrDuMyT7+mKVFBJCTfFE=
X-Google-Smtp-Source: AGHT+IHkShHz18zKi/aXxX7+Lx10bI9IqBtUuVptBljp1sNz+m3EcSRCzmtFJFgRBBd2X0z/D3WQgg==
X-Received: by 2002:a5d:60cc:0:b0:31f:db54:317e with SMTP id x12-20020a5d60cc000000b0031fdb54317emr6996605wrt.14.1694964472989;
        Sun, 17 Sep 2023 08:27:52 -0700 (PDT)
Received: from localhost.localdomain ([5.45.134.53])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c489700b003fe15ac0934sm7388865wmp.1.2023.09.17.08.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 08:27:52 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        conor+dt@kernel.org, linux-kernel@vger.kernel.org,
        abdelalkuor@geotab.com
Subject: [PATCH v5 14/15] USB: typec: Add status trace for tps25750
Date:   Sun, 17 Sep 2023 11:26:38 -0400
Message-Id: <20230917152639.21443-15-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230917152639.21443-1-alkuor@gmail.com>
References: <20230917152639.21443-1-alkuor@gmail.com>
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

From: Abdel Alkuor <abdelalkuor@geotab.com>

tps25750 status register is a subset of tps6598x status register, hence
a trace for tps25750 status register is added.

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
 drivers/usb/typec/tipd/core.c  | 10 +++++----
 drivers/usb/typec/tipd/trace.h | 37 ++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index dd3c76b57aaa..326c23bfa8e6 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -453,7 +453,11 @@ static bool tps6598x_read_status(struct tps6598x *tps, u32 *status)
 		dev_err(tps->dev, "%s: failed to read status\n", __func__);
 		return false;
 	}
-	trace_tps6598x_status(*status);
+
+	if (tps->is_tps25750)
+		trace_tps25750_status(*status);
+	else
+		trace_tps6598x_status(*status);
 
 	return true;
 }
@@ -1188,10 +1192,8 @@ static int tps6598x_probe(struct i2c_client *client)
 	if (ret)
 		goto err_reset_controller;
 
-	ret = tps6598x_read32(tps, TPS_REG_STATUS, &status);
-	if (ret < 0)
+	if (!tps6598x_read_status(tps, &status))
 		goto err_clear_mask;
-	trace_tps6598x_status(status);
 
 	/*
 	 * This fwnode has a "compatible" property, but is never populated as a
diff --git a/drivers/usb/typec/tipd/trace.h b/drivers/usb/typec/tipd/trace.h
index 739b0a2a867d..afa0875a9de5 100644
--- a/drivers/usb/typec/tipd/trace.h
+++ b/drivers/usb/typec/tipd/trace.h
@@ -91,6 +91,14 @@
 						      TPS_STATUS_USB_HOST_PRESENT_MASK | \
 						      TPS_STATUS_LEGACY_MASK))
 
+#define TPS25750_STATUS_FLAGS_MASK (GENMASK(31, 0) ^ (TPS_STATUS_CONN_STATE_MASK | \
+						      GENMASK(19, 7) | \
+						      TPS_STATUS_VBUS_STATUS_MASK | \
+						      TPS_STATUS_USB_HOST_PRESENT_MASK | \
+						      TPS_STATUS_LEGACY_MASK | \
+						      BIT(26) | \
+						      GENMASK(31, 28)))
+
 #define show_status_conn_state(status) \
 	__print_symbolic(TPS_STATUS_CONN_STATE((status)), \
 		{ TPS_STATUS_CONN_STATE_CONN_WITH_R_A,	"conn-Ra"  }, \
@@ -148,6 +156,14 @@
 		      { TPS_STATUS_HIGH_VOLAGE_WARNING,	"HIGH_VOLAGE_WARNING" }, \
 		      { TPS_STATUS_HIGH_LOW_VOLTAGE_WARNING, "HIGH_LOW_VOLTAGE_WARNING" })
 
+#define show_tps25750_status_flags(flags) \
+	__print_flags((flags & TPS25750_STATUS_FLAGS_MASK), "|", \
+		      { TPS_STATUS_PLUG_PRESENT,	"PLUG_PRESENT" }, \
+		      { TPS_STATUS_PLUG_UPSIDE_DOWN,	"UPSIDE_DOWN" }, \
+		      { TPS_STATUS_PORTROLE,		"PORTROLE" }, \
+		      { TPS_STATUS_DATAROLE,		"DATAROLE" }, \
+		      { TPS_STATUS_BIST,		"BIST" })
+
 #define show_power_status_source_sink(power_status) \
 	__print_symbolic(TPS_POWER_STATUS_SOURCESINK(power_status), \
 		{ 1, "sink" }, \
@@ -292,6 +308,27 @@ TRACE_EVENT(tps6598x_status,
 		    )
 );
 
+TRACE_EVENT(tps25750_status,
+	    TP_PROTO(u32 status),
+	    TP_ARGS(status),
+
+	    TP_STRUCT__entry(
+			     __field(u32, status)
+			     ),
+
+	    TP_fast_assign(
+			   __entry->status = status;
+			   ),
+
+	    TP_printk("conn: %s, vbus: %s, usb-host: %s, legacy: %s, flags: %s",
+		      show_status_conn_state(__entry->status),
+		      show_status_vbus_status(__entry->status),
+		      show_status_usb_host_present(__entry->status),
+		      show_status_legacy(__entry->status),
+		      show_tps25750_status_flags(__entry->status)
+		    )
+);
+
 TRACE_EVENT(tps6598x_power_status,
 	    TP_PROTO(u16 power_status),
 	    TP_ARGS(power_status),
-- 
2.34.1

