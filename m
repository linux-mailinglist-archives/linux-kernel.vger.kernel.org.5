Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FFC7E3857
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbjKGJ5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjKGJ5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:57:52 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F14F3;
        Tue,  7 Nov 2023 01:57:50 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-581e5a9413bso3027090eaf.1;
        Tue, 07 Nov 2023 01:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699351069; x=1699955869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FEmyl1Kghqf1NFmsUhneaNM1whAWfSEyfRV9qa+1zHQ=;
        b=YvEwurqYMEPV3Z7fG0MGrLV4ldxNx3htDAWtndpdVtJJOFNR9v35SLtBWsKukw3YGF
         raUmgPhf/9nRK/c0gDUisVB71dQ0SCvcgEKaWn2Kt6BBHCgntGw05i5hJZJTEoCDE+2H
         loMnMiiMSbnL1NYYmUSTFNNYAzvhD8EAejdYebPNKr2xItBDmEnRAccUX9vGKT23bpWh
         D2AJ/EloY9WfMWzAjy/rmg9Nov+oYsPfgohwdX5fBzYYGY0Un0YhgNxG/X+TUStiCwer
         gyI73ghwgcPAy264MRF23MLTb2jawLyewJ9OctNuMBBIf4YL/8yD+FMs5QN8ByHAeHeA
         c1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699351069; x=1699955869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FEmyl1Kghqf1NFmsUhneaNM1whAWfSEyfRV9qa+1zHQ=;
        b=tHod+bPZUvzCRD0QQMAMFa6wkvuKI3/K1Ns4zcLf8N/tmPEO1Z5ihGwuHamnKrvatq
         VYOuB8Olc80Tngc2hx3zDMtvsjTqTJ2rambmZ9DkbSrfRuJujIfhHA1UdA5tGZq/QnoX
         yMaxrpevu4IKBa3IWeYstzX3RnYDKxF7lKS9SVCefj+3pYof4VuVMaQOeIvz0szNiFHM
         vcl86zP6mpEMN/fsZCeb0vIDlTZntdeKks9h5e71zioVG7idkXN2IXzaAXDsI6ueUo3J
         AkV+NqaNfMROBfIxv3IftPN8BU9fQS7TJKLewnAIlv+A3LXXJPw1bxwzz/gf00kvVRiS
         jvJg==
X-Gm-Message-State: AOJu0YyM8REAvuFF0CvoVsR5MYB2XS3HcFSFtImHNnon7upw0rMlpqZM
        cGt5SgY2S0nKCZvKPF0pmSk=
X-Google-Smtp-Source: AGHT+IEjP3cfB6RzvPIrx7HvLhSsNb5+H9spbid2pxKtkEGgfOdw26RhUypbJOBhO8NKUd1NC3OJ6A==
X-Received: by 2002:a05:6358:1904:b0:168:e0db:ce43 with SMTP id w4-20020a056358190400b00168e0dbce43mr31469455rwm.31.1699351069343;
        Tue, 07 Nov 2023 01:57:49 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e25d-e1ee-eb42-adf3-9163-f337.emome-ip6.hinet.net. [2001:b400:e25d:e1ee:eb42:adf3:9163:f337])
        by smtp.gmail.com with ESMTPSA id v13-20020a63f20d000000b0050f85ef50d1sm1078725pgh.26.2023.11.07.01.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 01:57:49 -0800 (PST)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, SeanHY.Chen.tu@genesyslogic.com.tw,
        kai.heng.feng@canonical.com,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V3 0/2] mmc: sdhci-pci-gli: GL975[05]: Mask the replay timer timeout of AER
Date:   Tue,  7 Nov 2023 17:57:39 +0800
Message-Id: <20231107095741.8832-1-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Victor Shih <victor.shih@genesyslogic.com.tw>

Summary
=======
Due to a flaw in the hardware design, the GL975x replay timer frequently
times out when ASPM is enabled. As a result, the warning messages that will
often appear in the system log when the system accesses the GL975x
PCI config. Therefore, the replay timer timeout must be masked.

Patch structure
===============
patch#1: for GL9750
patch#2: for GL9755

Changes in v3 (November. 7, 2023)
* Split patch in two patches. One patch for GL9750 and another for GL9755.
* Add fixes tag to corresponding patches.

Victor Shih (2):
  mmc: sdhci-pci-gli: GL9750: Mask the replay timer timeout of AER
  mmc: sdhci-pci-gli: GL9755: Mask the replay timer timeout of AER

 drivers/mmc/host/sdhci-pci-gli.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

-- 
2.25.1

