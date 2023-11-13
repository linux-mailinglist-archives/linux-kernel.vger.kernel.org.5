Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACFCE7E9A68
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 11:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjKMKiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 05:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKMKiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 05:38:17 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1907CB;
        Mon, 13 Nov 2023 02:38:13 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cc2fc281cdso30237075ad.0;
        Mon, 13 Nov 2023 02:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699871893; x=1700476693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7icwEtB7jK89kNzAukZaN8SD/d7VobBjcqp8IeCkF/4=;
        b=O5rLrMN+95HiMKFjllYvueecY9+bqE6DtXhWl3cch4swL9NDdTWKoABNL1odKrAsIE
         iuqQ9FIpC8W+DlmHPrErvt7o6X07uTs1zYXbtjv9HgaS67brH1TmNQlIn0tVpLvTkjiB
         D6DR9ZZD86Thk9dVi1f9ufGM8MlKCRW9xRjAY7ccgReK68XaBGIvZuO4bacUqSI+WsF2
         Q0sTmh06uTPEAXsw8Ex5hXt5sbYQQHjRJE8mQTumE1DTEiumLLVdM4X82qISs3fZOobx
         7iaFtU/+P5XKvvT9RTtOQIB416Xvz/bgFd4e0RWRyUneWwOjR5WHJXOUPzNYNN9V++2+
         kS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699871893; x=1700476693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7icwEtB7jK89kNzAukZaN8SD/d7VobBjcqp8IeCkF/4=;
        b=Mrw18w+AdvcaGTWXgTpwXohFm0zQEnRb5lWwVKC0gZ82ycviCsSXTc/m4LqQp/nAMp
         fQ8KSdpBIq6NQC8NJb4LhSu0PnDyVzFWcD2zTTAaACfQwjh+9ntqMGq4U6XtdPQI2eVh
         eBgpvX3z5HUuLXaJnXECvSLg351fLTU0bqhcRFWXrPj9CL0ST+Ly12Dmrtvo+nBJPwzD
         HwOeSokyc7l+0peQkm6V5pE25BqFEFGB5vtkmO37h/u3DwxtCSqYHk8Ro+8ZP5SZUF/B
         xQLobFm2tAeEnc7rLf35IsViesVFYwqvrPEROzq+mHOSFbbivBSm2PzWlTDY57cuc2kU
         BOGQ==
X-Gm-Message-State: AOJu0YxUEeyPxQgLwjRS6loWfe/66oKJBKZaxRU1Sy9TAkl9YcEtLmDR
        Q317syldPsvNrEF0Wv/E32k=
X-Google-Smtp-Source: AGHT+IEKBFHR6EG+JMHY1a3JcODzZH4u5JepZ4yWWhSwBttqdjVudbw6e20EDMNopuyW0+2O9Pf4OA==
X-Received: by 2002:a17:902:dac9:b0:1cc:5dd4:7ce5 with SMTP id q9-20020a170902dac900b001cc5dd47ce5mr5671705plx.19.1699871893257;
        Mon, 13 Nov 2023 02:38:13 -0800 (PST)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id bb4-20020a170902bc8400b001c755810f89sm3752593plb.181.2023.11.13.02.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 02:38:12 -0800 (PST)
From:   Mia Lin <mimi05633@gmail.com>
To:     avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        KWLIU@nuvoton.com, JJLIU0@nuvoton.com, KFLIN@nuvoton.com,
        mylin1@nuvoton.com
Cc:     openbmc@lists.ozlabs.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mia Lin <mimi05633@gmail.com>
Subject: [PATCH v7 0/1] Compatible with NCT3015Y-R and NCT3018Y-R
Date:   Mon, 13 Nov 2023 18:38:06 +0800
Message-Id: <20231113103807.1036978-1-mimi05633@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since version 7:
  Fix the part number parameter checking issue.

Changes since version 6:
  Move the part number parameter to struct nct3018y.

Changes since version 5:
  Add global parameter to store part number.
  Remove unnecessary changes for easier reading.

Changes since version 4:
  Add an introduction bewteen NCT3015Y-R and NCT3018Y-R.
  Restore the initial value of err in nct3018y_rtc_set_time().
  Refine error messages to pinpoint the correct location.

Changes since version 3:
  Remove the comparison between DT compatible and chip data.

Changes since version 2:
  Add DT compatible to check the chip matches or not.

Changes since version 1:
  rtc: nuvoton: Compatible with NCT3015Y-R and NCT3018Y-R

Mia Lin (1):
  rtc: nuvoton: Compatible with NCT3015Y-R and NCT3018Y-R

 drivers/rtc/rtc-nct3018y.c | 52 +++++++++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 6 deletions(-)

-- 
2.25.1

