Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8477E71C6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 19:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345052AbjKISzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 13:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbjKISzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 13:55:02 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5513C1F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 10:55:00 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cc55bcd51eso1939805ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 10:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699556100; x=1700160900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oc8XKB87wQbvVWG32n2t+Y4HWDVG4F2xfYYjT2VaS4U=;
        b=d4voFKKNHmwa3kR4Rkw2u/8RWQW/IfOhw9/G6sQZXy5iWzRYQosXqIdFeljA9hR4ln
         jB8WioG8Kzcqtj+K124kNiPFtclFB/5VsdBIqdjd+Jh8Zu4xePatHoyg/5OGAkXwP81b
         AeeRgn5v+/d1t2mc0C4kDdPoffLzJmsWVrvO36/VvHXCzCx8xX/bhXThO0a91vOBrB8y
         QsG/+HJm6nSgRkdWCKiM1oVL1cTom7T5XdVU5VNEGQYIhU/LU3nHLlZg9LNZ31EuYB6p
         Fv/ngeymDqPLf2+eh6igssGrerJ8nbfP68ZPnUa/XjqSznVR5V4wiVDzdPe8Sv9sD/j2
         Yk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699556100; x=1700160900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oc8XKB87wQbvVWG32n2t+Y4HWDVG4F2xfYYjT2VaS4U=;
        b=NDjs6zyOpGKglG5fBKqDpzq5kdYb3C5ceE9YFWlTpxIuu1tVDWI51EY2TBdtPx99pV
         IQXy1P378utpKQ6ZmFFwHtVUROjaJbm+g9a3/of/ZpbvwEAzRQ5HbTuD02HSJENeAKie
         GyAhh2tkMjGhXokg+C9Tp4My/SIc9Ahhw8HnEBEcq0tYhu6jetYDexQsTKZghDMUmfd/
         qvAg5xLquh4hq0Uad20RGl3w2jo7MxN1jxzygVA3A6O4mydQ4AF0FiZE9VJ+v3dB8+mp
         FKIgeMMdg3aAszz4Y8FnZJK+v0SAL0ZSFPQSIbgFXpOuYZJfPMENHFD71+k+ibCxrZWq
         Z2Gg==
X-Gm-Message-State: AOJu0YzStt/U/VhszBDzSj5gdoiL6sD/nMR9Ovk+Fj6fowkMb0Hsvwzt
        DNbe0pmEtdFMUusnOprQ/bI=
X-Google-Smtp-Source: AGHT+IEpztjQzljXdJINa8TiA3AV4M8Z9qXo4fdBCG4xuIsFgmcJhHYl+Z7UYu0PyuQnE8wyfFehig==
X-Received: by 2002:a17:903:2281:b0:1cc:2b68:40ec with SMTP id b1-20020a170903228100b001cc2b6840ecmr6475275plh.4.1699556099887;
        Thu, 09 Nov 2023 10:54:59 -0800 (PST)
Received: from localhost.localdomain ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id w19-20020a170902d71300b001c61921d4d2sm3821837ply.302.2023.11.09.10.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 10:54:59 -0800 (PST)
From:   Kuan-Wei Chiu <visitorckw@gmail.com>
To:     bleung@chromium.org, tzungbi@kernel.org
Cc:     groeck@chromium.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 2/7] platform/chrome: Fix typo 'perod' in comment
Date:   Fri, 10 Nov 2023 02:54:34 +0800
Message-Id: <20231109185439.1535962-3-visitorckw@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231109185439.1535962-1-visitorckw@gmail.com>
References: <20231109185439.1535962-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'porod' with 'period' in the comment.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/platform/chrome/cros_ec_sensorhub_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_sensorhub_ring.c b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
index 568bbb64a389..ee1c3124d31a 100644
--- a/drivers/platform/chrome/cros_ec_sensorhub_ring.c
+++ b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
@@ -701,7 +701,7 @@ cros_ec_sensor_ring_spread_add(struct cros_ec_sensorhub *sensorhub,
  *           last_out -->
  *
  *
- * We spread time for the samples using perod p = (current - TS1)/4.
+ * We spread time for the samples using period p = (current - TS1)/4.
  * between TS1 and TS2: [TS1+p/4, TS1+2p/4, TS1+3p/4, current_timestamp].
  *
  */
-- 
2.25.1

