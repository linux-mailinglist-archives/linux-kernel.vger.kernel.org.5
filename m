Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30377DCA5A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 11:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbjJaKGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 06:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJaKGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 06:06:39 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D612983
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 03:06:36 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6bd32d1a040so5548604b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 03:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698746796; x=1699351596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DzncjTyuGFW5TKPcprBNQRe7Jwt07iBenfFhkZIrVrM=;
        b=bx8MyHcEAysaOYF2f+vBSxiJaOquerK2priWYSqHClfR1WstgAifvp9aAYjWkpT84J
         iUtgVYRbqcpj0ny5LjqU1TGt3DnI6uvB3aYR4Gx2lzcVse33LdA6RDQnJX6YAc7ihedk
         2YzYok1dmz7s7c1YFccI13lKtlG10ngf4TCN7bTGmKbUUls5S9ZmFgRaUorF45DBjQ05
         KwI9kR6TQk3NHAocP99o5WuDe1cuZjTN7+wH2RNt7JFU7DtkOz3Jtgekw1HxIWS8ZSSb
         VRm94DoSwsz2mRT42kqdcoMpuAuFZzdTQaIuVWdPYiJtuZhJdHXd/AQVre+jRL/qwjFO
         vZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698746796; x=1699351596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DzncjTyuGFW5TKPcprBNQRe7Jwt07iBenfFhkZIrVrM=;
        b=e9Lxr0wOYK5SgPJz4lOkokKXhzioc6CEdc8yf0nUPLdPYoFKswZTrYSnu7HeteQK8g
         hiZSuetCtCdPSfgiywafck1abY0FaNahA3qHkk2s/qLihOWb1CCIIaFgwkY00BJxo0GZ
         UEDMcvyF218YYeZ8yr6IqhbCk/bZ1JBvAABl2qViW1hdm9bjKPdujZKr/4vgpbEFoLPh
         uyvNSujeQoV49RvwxXOoTAjTMkCtv8e0YBTbS7fFYlPspXdtyI5mnsi/6dAU1Geg7ejN
         ipyXLr1RzMFmVo+SndhbBE3lFAqK6/jDJ7TsCOw6LOYc331BYJprL6aKLeZLAJoREHO9
         dR2w==
X-Gm-Message-State: AOJu0YwExSfLUunSh5Oq/HDbC/tFsuZQc4563S/GhMnFvPtBe8u1e+gM
        0q9BJD71ZEa225jJhKNCLUQ=
X-Google-Smtp-Source: AGHT+IHRjDMYkqOd3qJtLBi0MoLRPYC0gpzUeVuvD6bBYVu2w1cw0Vz41r9oCptSvIjdYN3h/jjr8g==
X-Received: by 2002:aa7:904e:0:b0:6c2:cf23:3e25 with SMTP id n14-20020aa7904e000000b006c2cf233e25mr5158pfo.0.1698746796214;
        Tue, 31 Oct 2023 03:06:36 -0700 (PDT)
Received: from localhost.localdomain ([129.41.59.5])
        by smtp.gmail.com with ESMTPSA id gx26-20020a056a001e1a00b0065a1b05193asm915719pfb.185.2023.10.31.03.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 03:06:35 -0700 (PDT)
From:   Rohit Chavan <roheetchavan@gmail.com>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     Rohit Chavan <roheetchavan@gmail.com>
Subject: [PATCH] staging: vme_user: Added blank line after declarations
Date:   Tue, 31 Oct 2023 10:06:10 +0000
Message-Id: <20231031100610.5394-1-roheetchavan@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes below warning reported by checkpatch.
WARNING: Missing a blank line after declarations

Signed-off-by: Rohit Chavan <roheetchavan@gmail.com>
---
 drivers/staging/vme_user/vme_fake.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
index 7f84d1c86f29..c4acc010c37b 100644
--- a/drivers/staging/vme_user/vme_fake.c
+++ b/drivers/staging/vme_user/vme_fake.c
@@ -67,6 +67,7 @@ struct fake_driver {
 	unsigned long long lm_base;
 	u32 lm_aspace;
 	u32 lm_cycle;
+
 	void (*lm_callback[4])(void *);
 	void *lm_data[4];
 	struct tasklet_struct int_tasklet;
--
2.34.1

