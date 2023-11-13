Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BBF7EA3FF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjKMTwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjKMTww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:52:52 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDDB91
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:52:48 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cc3bb4c307so36539545ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1699905168; x=1700509968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zbxZc5kYpfeHxdLaFG3HUwJ3WjytSiN17Zx0BgO6L0s=;
        b=QFAoP2ADjDYsQLp/XmCDNygcPcW3JV9wTV17fBiCJFxpyqN3MOQcdqEk+UyRa1cbKo
         BhJKIokkc3bxo6o8OCwL7KUGeRDrz2DuaonfF1n6XNZ/BMatkIxnoKhhAx+Y9y2vgz+Q
         HmMm0gVw6/govFkjXOMBT/4upP78YjqYPc+ErCeDto7Fgsnb6XK4HnXHB/tI3j0UtjZj
         WUOscVtH653KYFEGGoej2t2vw7+/Lj7c2YQ2DSbnm6FqT3Hogcy82QMV0brf9XKwVvpD
         KVoF1nqAmWwwGVw24g9562S5AfuHghiX4IGxNh+4uBpRNzO7LVeMQ6oQUVrAlOY6Zrki
         1v1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699905168; x=1700509968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zbxZc5kYpfeHxdLaFG3HUwJ3WjytSiN17Zx0BgO6L0s=;
        b=TJru5GsOuocbAsN4bFiRwETaLmTaawtuL8pNGuueovGfi2CYKPYO60F8enHRFe5Ilf
         kBOX9zDdEbHB6fehoKCXmlr4ClGfD1nzYxSavXnfYEV9AZEZparyN7zKIIqKgZl1aGR1
         p+MZdnhXTTui/7ksowkgOZG1dcJmFKUn14l5Ll8jMsUQInbLtjC6YIedOxHvpKUsRCSK
         hsWhNgWh/fUjuhf91wRbRjmjZu+eQFy36t2aVGO8iBqS+XC3O3OBE7Ds9jomxr5rUXrF
         O7rGPggSntcaoFN+pe9aKbEhL8rV+vIvknDHIZoqveEK4XdPDrXnxK7mkxCo750CZJDq
         v+3w==
X-Gm-Message-State: AOJu0YzicmmZNAdG+Q7feOmMZW0DbEsUTf7wGTc5jjokyMfXIggn0CYw
        IDY4H1JLsHhNkMoh5DQOiFZOvg==
X-Google-Smtp-Source: AGHT+IGCV8s8p/yUxlbuLeV9km4Uj92Et8ZxUvFow97ZuMSoyQWE/b199TP6+j2Br1MX/rceG9X/5w==
X-Received: by 2002:a17:902:7241:b0:1cc:33f1:3f03 with SMTP id c1-20020a170902724100b001cc33f13f03mr246535pll.2.1699905168244;
        Mon, 13 Nov 2023 11:52:48 -0800 (PST)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id t7-20020a170902bc4700b001c9d968563csm4395815plz.79.2023.11.13.11.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 11:52:47 -0800 (PST)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 0/7] Staging: rtl8192e: Rename bool variables
Date:   Mon, 13 Nov 2023 11:59:03 -0800
Message-ID: <20231113195910.8423-1-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series renames bool variables to fix checkpatch warnings
Thank you in advance to reviewers
regards,
~Tree

Tree Davies (7):
  Staging: rtl8192e: Rename variable bSendDELBA
  Staging: rtl8192e: Rename variable bCurrentAMPDUEnable
  Staging: rtl8192e: Rename variable bAddBaReqInProgress
  Staging: rtl8192e: Rename variable bAddBaReqDelayed
  Staging: rtl8192e: Rename variable bUsingBa
  Staging: rtl8192e: Rename variable bOverwritePending
  Staging: rtl8192e: Rename variable bDisable_AddBa

 drivers/staging/rtl8192e/rtl819x_BAProc.c | 40 +++++++++++------------
 drivers/staging/rtl8192e/rtl819x_HT.h     |  2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c |  6 ++--
 drivers/staging/rtl8192e/rtl819x_TS.h     |  8 ++---
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 14 ++++----
 drivers/staging/rtl8192e/rtllib.h         |  2 +-
 drivers/staging/rtl8192e/rtllib_tx.c      |  8 ++---
 7 files changed, 40 insertions(+), 40 deletions(-)

-- 
2.39.2

