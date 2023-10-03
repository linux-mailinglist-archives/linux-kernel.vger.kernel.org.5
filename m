Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D367B5E46
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 02:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238911AbjJCAer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 20:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjJCAei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 20:34:38 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3740CA1
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 17:34:35 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-694f3444f94so263224b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 17:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696293274; x=1696898074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5aF3XmMYuXB9m+K+yR4UudzmAD6ahXZqfX5b3PlkQE=;
        b=IytwKypdFdUkI8XLCrk8w3O0hr8I2t72AyHHEWFlg897Se2Ngtm8B/uJ9S1H3KKh7S
         HS53rojFm/iBjoscCiBHmnHpAPaF+GYQC/hsLetXemp7Edj2IcnLBCFZaF0XbSnYsL95
         Qwd+M4SFEmqf/l06NNu1ftVIRLpu7QUrsu/KE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696293274; x=1696898074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5aF3XmMYuXB9m+K+yR4UudzmAD6ahXZqfX5b3PlkQE=;
        b=GaI6auzW7s+kiqXm3XvL00asAJltysRxkh1SrIgD5IoEyTSh9IH2or7t55lhpJoRZt
         nIZm2M0anU3Qt1/kLCCHDj+SqjPFSSLY90fEQBVAlOMa7g1bIbNjGVaRpPetz0U5g15Y
         dorJ4RfneIAzOirA5HpJngreINpMZz4SgLBcwRcyMMZCD5XyTkil9v2HotUvHba8bXxR
         2YnsGNMpIdlZnMpI7tccGzWLHy8xa6XEe13j/0KgNhJX4dqW1mrVAVswiyYBVEPSyjlE
         snOqVfRSwz+0IpMkn/muB2baBcrhgF2AE1end0z8nfMeCrDeLELi8v4lD05LabrwEurW
         073w==
X-Gm-Message-State: AOJu0Yzl/fwItTroZxMRVTr9y8r22OCTr030PtqENENKQO5L5ufZ3qvR
        pNvg0X4UHt+TELWM5H+6OKGmnw==
X-Google-Smtp-Source: AGHT+IENc/i97QiaKLX8ED7u8WLA/M8LbyfJtn+ap0kJa0WKwfajkcwqigch9jifv0DXhEQbmHsRWg==
X-Received: by 2002:a05:6a00:b87:b0:693:3d55:2ba6 with SMTP id g7-20020a056a000b8700b006933d552ba6mr16207301pfj.9.1696293274608;
        Mon, 02 Oct 2023 17:34:34 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:11a:201:f676:8db:8677:aefe])
        by smtp.gmail.com with ESMTPSA id bm2-20020a056a00320200b0068a13b0b300sm101368pfb.11.2023.10.02.17.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 17:34:34 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        chrome-platform@lists.linux.dev,
        Prashant Malani <pmalani@chromium.org>
Subject: [PATCH 3/4] platform/chrome: cros_typec_vdm: Mark port_amode_ops const
Date:   Mon,  2 Oct 2023 17:34:27 -0700
Message-ID: <20231003003429.1378109-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231003003429.1378109-1-swboyd@chromium.org>
References: <20231003003429.1378109-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark this struct of functions const so it moves to RO memory.

Cc: Prashant Malani <pmalani@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/platform/chrome/cros_typec_vdm.c | 2 +-
 drivers/platform/chrome/cros_typec_vdm.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_typec_vdm.c b/drivers/platform/chrome/cros_typec_vdm.c
index 20515ee0a20e..3f632fd35000 100644
--- a/drivers/platform/chrome/cros_typec_vdm.c
+++ b/drivers/platform/chrome/cros_typec_vdm.c
@@ -142,7 +142,7 @@ static int cros_typec_port_amode_vdm(struct typec_altmode *amode, const u32 hdr,
 			   sizeof(req), NULL, 0);
 }
 
-struct typec_altmode_ops port_amode_ops = {
+const struct typec_altmode_ops port_amode_ops = {
 	.enter = cros_typec_port_amode_enter,
 	.vdm = cros_typec_port_amode_vdm,
 };
diff --git a/drivers/platform/chrome/cros_typec_vdm.h b/drivers/platform/chrome/cros_typec_vdm.h
index 95a6a75d32b6..631bd2ce4b00 100644
--- a/drivers/platform/chrome/cros_typec_vdm.h
+++ b/drivers/platform/chrome/cros_typec_vdm.h
@@ -5,7 +5,7 @@
 
 #include <linux/usb/typec_altmode.h>
 
-extern struct typec_altmode_ops port_amode_ops;
+extern const struct typec_altmode_ops port_amode_ops;
 
 void cros_typec_handle_vdm_attention(struct cros_typec_data *typec, int port_num);
 void cros_typec_handle_vdm_response(struct cros_typec_data *typec, int port_num);
-- 
https://chromeos.dev

