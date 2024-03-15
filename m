Return-Path: <linux-kernel+bounces-104806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2582287D3F6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 489EE1C228C5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7EA5025A;
	Fri, 15 Mar 2024 18:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WppRtxd+"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2A350A72;
	Fri, 15 Mar 2024 18:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710528589; cv=none; b=E6KNhmJFg7gItBAk7vycjq4Cda2cwfEfmHg58F+3pyGPStKEbfEs9FSUDXOwVsKale7YTiiZ1JFzWp8GjSqsCFGKRRBZPke8dr4KAvV0zPqLnkYn4/RM5DGjxo398rcs1DsCl3pburgfAPUawaK/IT7eR+PNzl6nf8oqJ2co4Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710528589; c=relaxed/simple;
	bh=/1iqh7q7JkmCXPD680/u5QdHu62Glan8gqqqOipKj8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gKuukNx76YaWaIGO7XhLJrRhJwYyVeZQHjatWA6i6hLxgcM8KCtCCvcEB1Uqkb/r/RGTGAraHfSZxuhwD/DjaC9AyyhKL7yXpPpDS+dCNZHB4ZNVN2x1GeUWh7e+8kHvO1WOKnRi5pfSRj9G89iIz2ByJpKUCq0ZYfA9KZOS0VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WppRtxd+; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5a21859a4b8so1108171eaf.0;
        Fri, 15 Mar 2024 11:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710528585; x=1711133385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0yWXrzwVMKSKKedkMOfXRJscJkRhDPTzhMhPeSYFEA=;
        b=WppRtxd+LC6Ma/TzULo2MNZAluYWqShIBsIFB/VIqtK+TcasNiDoVwW1ImQeQjlfaf
         ikLS3ageQi9mg1MY7IjkdjojoPAxIsRyf013l5tcrT724zx9qWEvzoFP2niH4T8lNEUj
         dIxRXIfl6k0fLQ3HqhQ3uN/A8p4GRnI+Y08kRfpe/GXt5xKCSnoiOb0bymy+zotMN7Xs
         UnoEpprso3419yfezGuiYNZ5DHvcTedsxH7vSqDRrJU9CouA/3klMG7rb2fKlcV6/6Lz
         Hw0pUmo7beXbhDPSBSm2P5b0fBDGsQ/y5J7pDfAtszZAn1QqVe8eH7CrNshA1yShx9WO
         DTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710528585; x=1711133385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0yWXrzwVMKSKKedkMOfXRJscJkRhDPTzhMhPeSYFEA=;
        b=tBDOe4U1xiJ9pz0zeCmqXQS/w1Spdbt4M103nWr4Sc5Oa++Dmjp2r3NnNn9mgG15+3
         u3JK3qbsokU++VabLXeaftHi0UmOK4QqEetVLQERylfd156diEuFIWTeeSatz54R+k+N
         F28CoVntyPbSIU0av/bxFhRYSCTcRVtNriJAgUaLiPebGurS1abU9erhsoEOkVmIC0T5
         C8HsyXdnPgitTDhg0inX9ubC1VegsHTgxkylSrtIdIVWcp7oSMEV/bl0X03xqmzdNc5V
         EesWxNU7dE3PHLIPxit27BPRPmAIU6CaWdrKh8nJ+VTvklsI8EsiLnfeSNeVX2TKqFQ5
         7YIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsP5H6e5IZEDkK2kY5j7na9muld6oi3xqMfWlK+dkH/6hUkDM4RPMr3yO2HjdupaGSnDN4R6ynsU3QNsw9gUyKallsZSaJpo++EWJGStdcnX4DbyTKp0IziNo5KYIyEe7cUseq/EnURtTJC4BwIxETuch0jX3//eBF1mDU5+Qgliwf+Q==
X-Gm-Message-State: AOJu0Yw/41nHDyTao3iqcP7vtPfgvvZb4W7LuFwAPt8+zj0q4HOWucWk
	S4P1mh5MeGY9IPvYf6zMAaXKAqz0tWXCXD65SVVKRsm8uMsibjB/O8JJ0v4PdrF65g==
X-Google-Smtp-Source: AGHT+IFg3xw+0ZVudlfm5n/W4rF1HiiD1YucYUMdRXsV4US1Q/BNo5ENea/QqSt1LEy1pQccA1e6fg==
X-Received: by 2002:a05:6870:d251:b0:222:3792:d968 with SMTP id h17-20020a056870d25100b002223792d968mr5680859oac.4.1710528585135;
        Fri, 15 Mar 2024 11:49:45 -0700 (PDT)
Received: from toolbox.iitism.net ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id f17-20020a056a0022d100b006e6cc998be8sm3580784pfj.207.2024.03.15.11.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 11:49:44 -0700 (PDT)
From: Ayush Singh <ayushdevel1325@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Ayush Singh <ayushdevel1325@gmail.com>,
	jkridner@beagleboard.org,
	robertcnelson@beagleboard.org,
	Vaishnav M A <vaishnav@beagleboard.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	greybus-dev@lists.linaro.org
Subject: [PATCH v3 2/8] w1: Add w1_find_master_device
Date: Sat, 16 Mar 2024 00:19:00 +0530
Message-ID: <20240315184908.500352-3-ayushdevel1325@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240315184908.500352-1-ayushdevel1325@gmail.com>
References: <20240315184908.500352-1-ayushdevel1325@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add helper to find w1_master from w1_bus_master, which is present in
drvdata of platform device.

Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
---
 drivers/w1/w1.c     |  6 +++---
 drivers/w1/w1_int.c | 27 +++++++++++++++++++++++++++
 include/linux/w1.h  |  1 +
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index afb1cc4606c5..ce8a3f93f2ef 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -673,9 +673,9 @@ static int __w1_attach_slave_device(struct w1_slave *sl)
 	sl->dev.of_node = of_find_matching_node(sl->master->dev.of_node,
 						sl->family->of_match_table);
 
-	dev_set_name(&sl->dev, "%02x-%012llx",
-		 (unsigned int) sl->reg_num.family,
-		 (unsigned long long) sl->reg_num.id);
+	dev_set_name(&sl->dev, "%s-%02x-%012llx", sl->master->name,
+		     (unsigned int)sl->reg_num.family,
+		     (unsigned long long)sl->reg_num.id);
 	snprintf(&sl->name[0], sizeof(sl->name),
 		 "%02x-%012llx",
 		 (unsigned int) sl->reg_num.family,
diff --git a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
index 3a71c5eb2f83..2bfef8e67687 100644
--- a/drivers/w1/w1_int.c
+++ b/drivers/w1/w1_int.c
@@ -242,3 +242,30 @@ void w1_remove_master_device(struct w1_bus_master *bm)
 	__w1_remove_master_device(found);
 }
 EXPORT_SYMBOL(w1_remove_master_device);
+
+/**
+ * w1_find_master_device() - find a master device
+ * @bm:	master bus device to search
+ */
+struct w1_master *w1_find_master_device(struct w1_bus_master *bm)
+{
+	struct w1_master *dev, *found = NULL;
+
+	list_for_each_entry(dev, &w1_masters, w1_master_entry) {
+		if (!dev->initialized)
+			continue;
+
+		if (dev->bus_master->data == bm->data) {
+			found = dev;
+			break;
+		}
+	}
+
+	if (!found) {
+		pr_err("device doesn't exist.\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	return found;
+}
+EXPORT_SYMBOL(w1_find_master_device);
diff --git a/include/linux/w1.h b/include/linux/w1.h
index 9a2a0ef39018..24269d0dd5d1 100644
--- a/include/linux/w1.h
+++ b/include/linux/w1.h
@@ -242,6 +242,7 @@ struct w1_master {
 
 int w1_add_master_device(struct w1_bus_master *master);
 void w1_remove_master_device(struct w1_bus_master *master);
+struct w1_master *w1_find_master_device(struct w1_bus_master *master);
 
 /**
  * struct w1_family_ops - operations for a family type
-- 
2.44.0


