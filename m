Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4D17FC858
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346664AbjK1Vkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346486AbjK1Vkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:40:35 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4235D100
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:40:39 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-285b926e5deso3019388a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701207639; x=1701812439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQpgB0hpYD1c6hlujz/aWaKFzOCbCq1mG9ijFrvdnyY=;
        b=QKBAge7SioihvVYTJUi05Yn5Bn9zeEOnfUYcXt3FvjWfrjySzZRNsKb9E3gQUikNpE
         0VWMg4qMHdBvsMqsZEtXSNGLUByzNdV/d+Q0YxbyXZTChLYxKjE8+H13qpuZjm5hCB5v
         1RH/TcQydFs38goys7py72n3XAbLte1AHFJcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701207639; x=1701812439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQpgB0hpYD1c6hlujz/aWaKFzOCbCq1mG9ijFrvdnyY=;
        b=G5rhau3WcMLWQOst1mw3XFkMLAn7rpzz+cXvrIjYsYD7oR+asLlFH5B8GzgPLAFCyh
         X8Mq5dLhDFFnXjG/z1mD2apOgPswzvnH+DF3uFcr6JqWMCatAQql/UFq/z2EgcZOJHGH
         gYp7ICujYe6ew6h51LG+p84fjiyNkCcc0gwucMlkWKTIVSmbh4kRpjN0//07H0afZ9r9
         O3SST2h20rBp+ZucQzh4YqwGsU/KgNGT0jJR0f3Ig4WankQOsVDnv2HBlffGW3q67J9s
         zNQ7B95vyhA6H7mG6DnuNZWYX+efxKCLLdpJB7yPLxI3oBX3fVAdc72GLDeH/JHGyGIK
         buQQ==
X-Gm-Message-State: AOJu0YwLG826pr9IEBwKBNMTe9JdExf6FxiA3UvCSVb5HRCgy3/eit3I
        I18/xb7g6c6FUyRCA2yXeYTI5A==
X-Google-Smtp-Source: AGHT+IGdufnfU7w6XiSR48w3M0ObwdgFMLn6/XHezYmblLJU9cYVtIEIq/y+ik+j5vFBauLTdJDobA==
X-Received: by 2002:a17:90b:4c50:b0:285:8407:6152 with SMTP id np16-20020a17090b4c5000b0028584076152mr17639969pjb.8.1701207638788;
        Tue, 28 Nov 2023 13:40:38 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:fc3a:13ce:3ee3:339f])
        by smtp.gmail.com with ESMTPSA id ie24-20020a17090b401800b002609cadc56esm9634285pjb.11.2023.11.28.13.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 13:40:38 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Laura Nao <laura.nao@collabora.com>,
        Edward Hill <ecgh@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Grant Grundler <grundler@chromium.org>,
        linux-usb@vger.kernel.org, Simon Horman <horms@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH net v2 5/5] r8152: Add RTL8152_INACCESSIBLE to r8153_aldps_en()
Date:   Tue, 28 Nov 2023 13:38:14 -0800
Message-ID: <20231128133811.net.v2.5.I1306b6432228404d6e61b2d43c2f71885292e972@changeid>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
In-Reply-To: <20231128133811.net.v2.1.I77097aa9ec01aeca1b3c75fde4ba5007a17fdf76@changeid>
References: <20231128133811.net.v2.1.I77097aa9ec01aeca1b3c75fde4ba5007a17fdf76@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delay loops in r8152 should break out if RTL8152_INACCESSIBLE is set
so that they don't delay too long if the device becomes
inaccessible. Add the break to the loop in r8153_aldps_en().

Fixes: 4214cc550bf9 ("r8152: check if disabling ALDPS is finished")
Reviewed-by: Grant Grundler <grundler@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Added Fixes tag to RTL8152_INACCESSIBLE patches.
- Split RTL8152_INACCESSIBLE patches by the commit the loop came from.

 drivers/net/usb/r8152.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 26db3f6b3aa1..aca7dd7b4090 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -5803,6 +5803,8 @@ static void r8153_aldps_en(struct r8152 *tp, bool enable)
 		data &= ~EN_ALDPS;
 		ocp_reg_write(tp, OCP_POWER_CFG, data);
 		for (i = 0; i < 20; i++) {
+			if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+				return;
 			usleep_range(1000, 2000);
 			if (ocp_read_word(tp, MCU_TYPE_PLA, 0xe000) & 0x0100)
 				break;
-- 
2.43.0.rc1.413.gea7ed67945-goog

