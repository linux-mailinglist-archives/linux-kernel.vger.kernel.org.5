Return-Path: <linux-kernel+bounces-89190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEABC86EBC0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 903CB1F23D56
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAC05916C;
	Fri,  1 Mar 2024 22:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVTwwBxn"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AB55D750;
	Fri,  1 Mar 2024 22:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709331505; cv=none; b=RL7SVH9dM4b8Lnavzq3RUR3RCaUKR5JpjIbXIoJznKhiSjsfEVkeLda+90BTqc4TOvK9trO60ZeOkB3a0TsuX7n4c0seFWfPUATCKhVWgX5jJ1B77Bhn2f9I/pbhAxDv0i5Uf+HU0afNAHzGXLVPJV3SkDkaskTAsadnDWRbSlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709331505; c=relaxed/simple;
	bh=uXM915q/jgE2mr1r6Kmy1ijhQ1VyMY2aqb2scH6K9jo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q1z6zg9b5gXULbs4184wJ/ZiZId0u/Zd0dGCozV2GvF1hN/zXfUweWVgWYFlmNqrFqyoxRqJE0cA19gBBtewV38U5IaV1pPHSFC2c4tFzGp2ilBMZlKS/xCi6mIkcQszD+3nlT3UjpYTQyewe2GX80NUodADmSRa2wokVTcwnE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVTwwBxn; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a44cdb2d3a6so18278866b.2;
        Fri, 01 Mar 2024 14:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709331502; x=1709936302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81KI0+qdfK3ZHf++P129aHWPYoB3eKSzWQe3DkfQMFE=;
        b=AVTwwBxnU1ezdEX2OrY4yYu4EkRy66dXfwPIGxa/LQEGHxQIxKbMJJs3aqimCx48aS
         FnHgTEzRU7ea3j9JV2Umu6Wlp0xmxMmKIC7YxKj0GaLU/psn1B6CQvKEE/qcHbTZCBro
         S7dCW3/gUpJodxzlw4wHIJkWcO1FJovWDRW+37cBVkaUkMEHCHF34wTwCZIqYq0zJH0p
         KfD12TWzT+d9Waj2OEJCVGccUbY0FXVL+cfnuG29OJOctMXGiElYE0lzUPB7oeuNGIB5
         I7fO0xyd/EdVMuas9nq05HbJrivx+zFcvs5efKM3s777w7/RyLjZKt99CQjmg7EHPL60
         dlBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709331502; x=1709936302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81KI0+qdfK3ZHf++P129aHWPYoB3eKSzWQe3DkfQMFE=;
        b=WteueFgxMjorQPdZpqlg+ezQLhrMF7K/sVwDtpPk10fLu2oKXxV55/YC1G9HWeCBkI
         obIVpQXRjcbOvU5et3LMI8sMTSTj3BJlBRKAVGsP49eIDX5e7F8UIbpXuTHQFlQ7a27V
         pmQXjCYumVJFNm5BwSu4TWeocycVN8Z5HoXO8X+joryEYJOG+TRTt8ENAQzKhuHZF/4w
         icZMistM4QMhfjlKF8QdOrOGlQCZ6g/nTGphV0OGaSRoppf5fCrtSZa4ol5Oybn8PHiB
         Xwqto0Q0YxFacdT/5y9a/cr7RyHnAyFPP59eaSWg8SFbw9/HrxmekUCzfwdeFIMGQPEi
         NyMA==
X-Forwarded-Encrypted: i=1; AJvYcCVnGjJFo7uIg7KRezj8sEFwsHCprI82uV0U2sHUO/3EvLrlQL31FOdXDrkg07hI1hUtgTTptPX83myM+dI7N8YAWaijgLUMsyb/qDXS
X-Gm-Message-State: AOJu0YzGy/gtdacpxvaORvhn5hkvX3VghoGAL+dqZ7pJ1DHSGqfnzifm
	r0u+zQ0yhK13JT2lAQYyb8Sqhvne6wf6EdB7OCHfvfUiVsVsguC/F1Z2rmwz0dE=
X-Google-Smtp-Source: AGHT+IHv7DNO6cSOzlppqVmrxf/azzfNGFjWqIOuh/eDtW/kyfn/qmpb6uRL8n8p40X4slf+WJhYcg==
X-Received: by 2002:a17:906:f355:b0:a43:a12b:1951 with SMTP id hg21-20020a170906f35500b00a43a12b1951mr2270723ejb.2.1709331502188;
        Fri, 01 Mar 2024 14:18:22 -0800 (PST)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id g16-20020a17090613d000b00a3f480154a3sm2091122ejc.65.2024.03.01.14.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 14:18:21 -0800 (PST)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 14/16] net: dsa: Define max num of bridges in tag8021q implementation
Date: Fri,  1 Mar 2024 23:16:36 +0100
Message-Id: <20240301221641.159542-15-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301221641.159542-1-paweldembicki@gmail.com>
References: <20240301221641.159542-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Max number of bridges in tag8021q implementation is strictly limited
by VBID size: 3 bits. But zero is reserved and only 7 values can be used.

This patch adds define which describe maximum possible value.

Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
v6:
  - resend only
v5:
  - added 'Reviewed-by' only
v4:
  - introduce patch

 drivers/net/dsa/sja1105/sja1105_main.c | 3 +--
 include/linux/dsa/8021q.h              | 5 +++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 6646f7fb0f90..6e22d7a6bfa3 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -3156,8 +3156,7 @@ static int sja1105_setup(struct dsa_switch *ds)
 	ds->vlan_filtering_is_global = true;
 	ds->untag_bridge_pvid = true;
 	ds->fdb_isolation = true;
-	/* tag_8021q has 3 bits for the VBID, and the value 0 is reserved */
-	ds->max_num_bridges = 7;
+	ds->max_num_bridges = DSA_TAG_8021Q_MAX_NUM_BRIDGES;
 
 	/* Advertise the 8 egress queues */
 	ds->num_tx_queues = SJA1105_NUM_TC;
diff --git a/include/linux/dsa/8021q.h b/include/linux/dsa/8021q.h
index f3664ee12170..1dda2a13b832 100644
--- a/include/linux/dsa/8021q.h
+++ b/include/linux/dsa/8021q.h
@@ -8,6 +8,11 @@
 #include <net/dsa.h>
 #include <linux/types.h>
 
+/* VBID is limited to three bits only and zero is reserved.
+ * Only 7 bridges can be enumerated.
+ */
+#define DSA_TAG_8021Q_MAX_NUM_BRIDGES	7
+
 int dsa_tag_8021q_register(struct dsa_switch *ds, __be16 proto);
 
 void dsa_tag_8021q_unregister(struct dsa_switch *ds);
-- 
2.34.1


