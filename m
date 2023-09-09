Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D35799A5F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 20:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237887AbjIISTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 14:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjIISTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 14:19:32 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CF61B0
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 11:19:27 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-401e6ce2d9fso8865935e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 11:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694283565; x=1694888365; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nmrZVxHXaLRpMM6rOmTmq9YaL32Ts5BcYnXcNL+bdlw=;
        b=fOCd4y+mEIpgBESPGGi3yKCpt9ZOftBp61FnUhcs/nRYLk0A6+3EnyqwrDW+a9rvjg
         qkNlvVRKEXvOJF2k3jK9MQRFMVpGZ0fL1cY/yxOIoVQu9KaZ64HSNS5oWDLpdcsyK/w2
         OAgdIg8zUlYQD1IRzbChE0Pi8X3IW2syVO3bHgGOfKKKQwUxZJrBH8uq7Nm5lu7bsILR
         tB1z1xdGy0dconF7SyZsPxUKC5YswgRktQytpgSmF4W1ph2easDihTfgjLgYqxFfIfRq
         T+2wFdFEHSSX+jMON2j2bjMnnn6xKyoATp2T59Yd7tHKvkVmR0GN6MaVg2OSk50IlUBB
         734Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694283565; x=1694888365;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nmrZVxHXaLRpMM6rOmTmq9YaL32Ts5BcYnXcNL+bdlw=;
        b=Avyfg/Blm682zEFYZd8rg+mPDV85Des5tXyv2o4zviWzfXLKmWlxRTsOtJzPtuBjF4
         VilwccXfFIhl6/UO+OhJGOoYfIKWkOKUBuJRiPq3MCll3RG14Zl0uYKvfEAC0H59sMrQ
         EZ1EkZAVtEi62eG1rqo0QM/1JrTgvvP37FVT7624ZmsEALnAVvPtykoPNmNwdR+LPFHP
         6R/PN2BVS/5AYsZ2ROC+7v2I9VGbI2Wf7I3u/UdLr390gy/yVdhIEUZgFLZHsc4Z23og
         S2LTDPHrarfJ0ZRpgX7yzojVP1IurYCv1PZgz84n4kNpKVUaEnJsJ65idQYlJb71tYpq
         DvlA==
X-Gm-Message-State: AOJu0YwlabLZ7Pp0o0IifOra7/A+lxw2h9eO2qcD11MqsHTSi1OFGjCq
        IJmXzx+BBbTiKR4sGJtHYTqbWrIE+umQIw==
X-Google-Smtp-Source: AGHT+IEMPxyBRvmMm4R+LH9p4X8d910dR48P0wuk8KscvWNtiGlushElfB2n7Jpi9n0RLEG9ZrUW5g==
X-Received: by 2002:a05:600c:1d0a:b0:401:c6a2:3cd5 with SMTP id l10-20020a05600c1d0a00b00401c6a23cd5mr4915477wms.2.1694283564957;
        Sat, 09 Sep 2023 11:19:24 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id r14-20020adfdc8e000000b003196b1bb528sm5397229wrj.64.2023.09.09.11.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 11:19:24 -0700 (PDT)
Date:   Sat, 9 Sep 2023 20:19:23 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] staging: rtl8192e: Use standard functions like
 ieee80211_is_beacon()
Message-ID: <cover.1694282907.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove useless equation in debug output.
Use standard functions like ieee80211_is_beacon().
Optimize code for improved readability.

Tested with rtl8192e (WLL6130-D99) in Mode n (12.5 MB/s)
Transferred this patch over wlan connection of rtl8192e.

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
 drivers/staging/rtl8192e/rtllib_rx.c          | 54 ++++++-------------
 drivers/staging/rtl8192e/rtllib_softmac.c     | 11 +---
 6 files changed, 22 insertions(+), 93 deletions(-)

-- 
2.41.0

