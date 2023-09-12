Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762AE79D988
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 21:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjILT2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 15:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjILT2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 15:28:05 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EE718D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 12:28:01 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-401d61e9fecso18433425e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 12:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694546880; x=1695151680; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ruTPSjX5I+z1vbTXALsdSF4OmeUSujoWTMjNVvMqPrw=;
        b=sM2NRhqPkQIm/j8cBeg46zrvDCzLFSHRuZ/6SMerNrTYvgFvr6j+Zs48uPvTnTfAbA
         3TX/op10CtQJ4iHAxmgeh4gzdEerheyrYaXob39sHscpmaLurp0EYHPjRrhTn/aQpDTW
         FczpE1H767V7/PNc5IiRAMajOZSJ0TBh+bFhJl3RgzRAkd45OF3M3QSK2DUOWPYtaMUR
         WhhqMO2ie8dOL6NlInvbTCrRSs4nZuWdefjSudEY/3qYzZSGk7YKxCbgt24ucIwt70vP
         d/ASMl1S6dJwu5CIJGeGgM75oMwgIDZWxwoZjpehYVJ0f5pYDqno4RBB55hpnH0J6KlD
         qERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694546880; x=1695151680;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ruTPSjX5I+z1vbTXALsdSF4OmeUSujoWTMjNVvMqPrw=;
        b=Dmk5O/Nax8uK3xmrz4FbQCBory50oEFTF5Re35KFQRwmJd52jMDzqjpiPuiwkhywNG
         yeuYBPO7o1ES4EYDaDu7RDvwEbk5ubFDv/Ng9jF69M+IvJhPvxxzV7eKpzh9l7TGdJHS
         OxlR4d2zsgcU2HaIDKR9J0wOovvTH2GlRLXHWR1x4mkan96xglqU+XZg0lAWmIWJOfzA
         tJVRdPHbpUuEXrsyT5ESaCJ9jFSClqm63KwLJk6Noa5tx5p+b5kp6aGHukBB8r3T61xf
         nPBe8HrLWhyAS+GyIkoWnPtclucM9rnXNRNvke+K/RIb43WlNbYUu5jc4QpGjh9Xec2Y
         pZWg==
X-Gm-Message-State: AOJu0YxJ0MiyVMdK6oRsksadpBmOMAh8Bs75+6twdNJAA+FmclpbZZBN
        MKO6dnpeqEbIndPEUTPKoLUlQd+4/FEZaw==
X-Google-Smtp-Source: AGHT+IGMK4b0WtqbjV1wbaE7LGmvJ9YiMhF6Ll1MmsFrSFl5QxYKlmXC/3efJ+R2kQ33d5ayKgxMGg==
X-Received: by 2002:a05:600c:3c8f:b0:401:faf5:85c3 with SMTP id bg15-20020a05600c3c8f00b00401faf585c3mr354591wmb.0.1694546879670;
        Tue, 12 Sep 2023 12:27:59 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id m24-20020a7bce18000000b003feee8d8011sm16859103wmc.41.2023.09.12.12.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 12:27:59 -0700 (PDT)
Date:   Tue, 12 Sep 2023 21:27:57 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] staging: rtl8192e: Use standard functions like
 ieee80211_is_beacon()
Message-ID: <cover.1694546300.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove useless equation in debug output.
Use standard functions like ieee80211_is_beacon().
Optimize code for improved readability.

Tested with rtl8192e (WLL6130-D99) in Mode n (12.5 MB/s)
Transferred this patch over wlan connection of rtl8192e.

---
v1->v2: Only patch 4/8 was changed
        Take wrongly removed definition of fc back in.
        

Philipp Hortmann (8):
  staging: rtl8192e: Remove useless equation in debug output
  staging: rtl8192e: Use standard ieee80211 function in rtllib_rx_mgt()
  staging: rtl8192e: Use standard function in
    rtllib_process_probe_response()
  staging: rtl8192e: Use standard function in
    rtllib_rx_check_duplicate()
  staging: rtl8192e: Use standard function in softmac_mgmt_xmit()
  staging: rtl8192e: Replace rtl92e_disable_irq with rtl92e_irq_disable
  staging: rtl8192e: Replace rtl92e_enable_irq with rtl92e_irq_enable
  staging: rtl8192e: Remove rtllib_get_payload()

 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  6 +--
 .../staging/rtl8192e/rtl8192e/r8192E_dev.h    |  2 -
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  | 18 -------
 drivers/staging/rtl8192e/rtllib.h             | 24 ---------
 drivers/staging/rtl8192e/rtllib_rx.c          | 53 ++++++-------------
 drivers/staging/rtl8192e/rtllib_softmac.c     | 11 +---
 6 files changed, 22 insertions(+), 92 deletions(-)

-- 
2.42.0

