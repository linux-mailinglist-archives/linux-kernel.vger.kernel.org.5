Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A477C9189
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 01:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbjJMXrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 19:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbjJMXrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 19:47:45 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37BCFF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 16:47:39 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6b709048d8eso518715b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 16:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697240859; x=1697845659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTNR+WS914Vji3aQakd2kNaBruSlecf8tdbR1KSMoAo=;
        b=UdPY1Wep1kJMBqauzckKKWdnfbXJwm2QJP6flegaqgaLiqTEnw58IWEMgOd/FBI4wj
         IxOCH45LvS92G/9ZNOmaHY81EA1DKiVVyk/RqZVsO8pr5Y2+Hy2ZFVsR/OjmfweaQ4+P
         4u13I4wBeq4ruLfG0ZHwbbB6F8wGGRKbLbYhLh48zflCx6iM/oJPBO81LFxZ6gI0S+Cv
         EDkgX37bR+tA//fyFDSKjhv0b5pn6UEfTYEmZQ/aouh+cMtT49bIH0SdbF6xt767njJ5
         2CAyowktaUE5496+GEiVoZokmHVvdx9CQxlyBnCC4byTVCMsIx2NZEgXb3Vu97EDH6CX
         7A7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697240859; x=1697845659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jTNR+WS914Vji3aQakd2kNaBruSlecf8tdbR1KSMoAo=;
        b=UOg1PP7F99dGmzWZx/S/dJJNr4PmKPOhNOdQ803lshmyrdT+/iYymO1ct7SRf/JnPj
         u15W9mXR74xKpPYjnokhHURdd4MIDfneEfrpnHE9WGIOKZZIzjEenThxTVjEBhqPAb6s
         4r2yRL9lAZeKEkUjwH91UAHjGFhFak936+LZhLNvgsV5Q2hGUZlIsATGA7ilsavk6R3q
         /FtwbwdVc9xwS1xWV5LBTH/eAMlT/9L6GTsnTDu/sArQM2uwiD3idmOEHN4xmxCyYKFO
         4IYlo9WKT40qFdnQFJm3kManVtO4w27Uen5SjiVAb2ewhwIvXxcAntyhdT5q2Mc/wbWo
         3lLA==
X-Gm-Message-State: AOJu0YxWsYg1cWaAeFUEuH1aGlHhY+qLOoE6tMDOjLjtFZhspJ5b6+CF
        As7uuEtWzAJlkxvyMBaAkb8=
X-Google-Smtp-Source: AGHT+IGWGPF7YLEtx0WelXz4wF5QFqi6DXSq4StYn8DrWTIIvYtYAQ5UsSU2sTES3Jvw3RePX9jg4Q==
X-Received: by 2002:a05:6a20:7d86:b0:15e:d84:1c66 with SMTP id v6-20020a056a207d8600b0015e0d841c66mr32466718pzj.52.1697240859019;
        Fri, 13 Oct 2023 16:47:39 -0700 (PDT)
Received: from Negi ([68.181.16.134])
        by smtp.gmail.com with ESMTPSA id e19-20020a170902f1d300b001bb750189desm4411615plc.255.2023.10.13.16.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 16:47:38 -0700 (PDT)
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Soumya Negi <soumya.negi97@gmail.com>
Subject: [PATCH 3/4] staging: vme_user: Add spaces around '*'
Date:   Fri, 13 Oct 2023 16:47:15 -0700
Message-ID: <81181dcc1ffa648f32cbe3c4ec8731e66349e450.1697240381.git.soumya.negi97@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697240381.git.soumya.negi97@gmail.com>
References: <cover.1697240381.git.soumya.negi97@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add space around * operator to adhere to Linux coding style. Issue found
by checkpatch.pl

Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
---
 drivers/staging/vme_user/vme.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vme_user/vme.h b/drivers/staging/vme_user/vme.h
index faa9816046a9..fbcbd0204453 100644
--- a/drivers/staging/vme_user/vme.h
+++ b/drivers/staging/vme_user/vme.h
@@ -87,7 +87,7 @@ extern struct bus_type vme_bus_type;
 #define VME_NUM_STATUSID	256
 
 /* VME_MAX_BRIDGES comes from the type of vme_bus_numbers */
-#define VME_MAX_BRIDGES		(sizeof(unsigned int)*8)
+#define VME_MAX_BRIDGES		(sizeof(unsigned int) * 8)
 #define VME_MAX_SLOTS		32
 
 #define VME_SLOT_CURRENT	-1
-- 
2.42.0

