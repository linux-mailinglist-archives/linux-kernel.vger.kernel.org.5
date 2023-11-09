Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F1A7E71C9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 19:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345131AbjKISzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 13:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345074AbjKISzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 13:55:14 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7773C39
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 10:55:11 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cc28719cb0so2562775ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 10:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699556110; x=1700160910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g73QTqa4YTCeJuDnfMTOW8eVS9xm1gIdRDmG7TjF/yc=;
        b=d4XcI6rYNEjzmAg6o3bmaCuSdUurfS2jJCcL14QV6ZwpsD8CfSayTzYA4wXDK9jZ35
         XKt7U9tW0OYccqIXMQXqZviXpRaasJheJHrj/nd2OtMMQ3/HnebhLU06iLBXbU5mBg2s
         oG4gPmmzjDzUm/jZEEa1deEpBoNfeslFxTkApoRNzsXeNzPhsxRzH8eIUITSJ7/oGbkg
         AWDx8jLN0BviY2SvLVNx4oLPpl2LnawQJM5Mt93EE0aIE9m0hA6BLNLVAAJ9p8IRFdHl
         9LrHZoSE4pwzsVhzZ4tDqpUvnChXoQHuGooAVtWTqdhsG1PTv1iCCfp/PCt/zZRDVFjZ
         i+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699556110; x=1700160910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g73QTqa4YTCeJuDnfMTOW8eVS9xm1gIdRDmG7TjF/yc=;
        b=skH0IbrDDwbJ/ktxAfvipJg8jLUun2JTZr9sr7Jj+2Cy+79cgDTcdcwZCn7mcMjQNn
         0hamEPekXQiYQqnjNRnxusaPfSZLHybp3jpA4APPp+T24Gp5osCFO9DEOLQBI4QLVL5T
         nR8DGGlij/baQr0/bRK0NsOIl1fpHJ3zA7cYXUBSuIWV3WgU52B5bR2bUGH6DtUYqtcX
         G9xFHE7eFNYnuQ+Wl0tRvPKl+aHnBLaUZDUEruLc+d5qjXm2fcy8PC/84TO9xGA15q+C
         6RIoD+siOr6B3BKMAIYN0b7hXP7rMNYxhzpSWGrWJxuO/WLpSomX6VXZyILxdIJpt22r
         0t0A==
X-Gm-Message-State: AOJu0Yz3PMkIpaaZFhH0vzeAUCXGXznfzOZBZGPHNj3FPOppM2nStMM8
        eePmrtRgQhFbgL+LzSHapi8=
X-Google-Smtp-Source: AGHT+IFxZxc4RDzX6HRIMX0zhVB50kMciGdcCmsIWNygaa4MSMM4LrRdrVRhjg7PMLTFpkHhpXk5eQ==
X-Received: by 2002:a17:902:c943:b0:1c7:5581:f9c with SMTP id i3-20020a170902c94300b001c755810f9cmr6369880pla.0.1699556110547;
        Thu, 09 Nov 2023 10:55:10 -0800 (PST)
Received: from localhost.localdomain ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id w19-20020a170902d71300b001c61921d4d2sm3821837ply.302.2023.11.09.10.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 10:55:10 -0800 (PST)
From:   Kuan-Wei Chiu <visitorckw@gmail.com>
To:     bleung@chromium.org, tzungbi@kernel.org
Cc:     groeck@chromium.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 5/7] platform/chrome: Fix typo 'kifo' in commet
Date:   Fri, 10 Nov 2023 02:54:37 +0800
Message-Id: <20231109185439.1535962-6-visitorckw@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231109185439.1535962-1-visitorckw@gmail.com>
References: <20231109185439.1535962-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'kifo' with 'kfifo' in the comment.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/platform/chrome/cros_ec_sensorhub_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_sensorhub_ring.c b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
index 92faf701b8f0..6c2aa2651e5f 100644
--- a/drivers/platform/chrome/cros_ec_sensorhub_ring.c
+++ b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
@@ -595,7 +595,7 @@ cros_ec_sensor_ring_spread_add(struct cros_ec_sensorhub *sensorhub,
 			} else {
 				/*
 				 * Push first sample in the batch to the,
-				 * kifo, it's guaranteed to be correct, the
+				 * kfifo, it's guaranteed to be correct, the
 				 * rest will follow later on.
 				 */
 				sample_idx = 1;
-- 
2.25.1

