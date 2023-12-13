Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5F4811A11
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378871AbjLMQv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235215AbjLMQvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:51:25 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3BEDD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:51:31 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a1cc518c5bbso227203366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702486289; x=1703091089; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a/V4SViSQX7vA1insSL2knptZhi5hxD300GNJth/+14=;
        b=I1ATGzUmzY0bY4cWo0iv0U2VyXUHKA9AK1lZ8Hk1+n/AK1bio0DsOHAaex/D1miUzG
         eKPRVT30gNhqfwkasjISzUw9KTuwTDg2O07DMyTyRPNVCsL7RLtc8vJ2QjTqmuDIvZi0
         c6OdqQAVDRbFpxyGw7BZ/EBNWJxcdbH/XnmoQ/mAPO6CAXenckC0UYTZri3aFNA7l1lZ
         kcJiOY5naakuYJjFE+54BY+Zf3vyE0y8cVsqo+oy1b623UWFZbgc6qeIPZa2wUUNZmzP
         kb/Exfhr63istGgXH5Nt22y6Mco3Pq+sGq9NM/dKdyOiCfTQWI2j7g8yhEIYwVkuZBIN
         BMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702486289; x=1703091089;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a/V4SViSQX7vA1insSL2knptZhi5hxD300GNJth/+14=;
        b=QiXc166yD5FdYZuBXcj1Bt+CIKl9IAsM6a/X6fRyQkNRdO75siTUcTKGKbz7zOsG7/
         T984QCobSQcF6HXndo3Zsc/k6LlJcO5zhdri9xaAYU2YYmCIdOhW1DSNWkMhN496ezod
         D/6nkhQ/sidBdL4o/v5ukfJik9+FBC7JHHVbpnz+mrJ4fnteHG+8i8vFy62Vq/UY7aoE
         f1o/8df5gilLn1PT3EkuZ4tDu3tSBUt0gXoiXoVNLeTglDNwOkrbiHuaQ94zPzREYAdM
         iR5UYc515cOO5FMqaNJ/lB/LvPNNn3I/hC5DwuHrIV8fojr5Ssh8HF2CRh//UhIziNP1
         ySHg==
X-Gm-Message-State: AOJu0YwmU6JUpfw+j8ZgpnjCwGGVHKYSdYFE63iNxy0KhWwMzYuPXxCs
        1C+ZCw65vHN2L7JpVKPeMstWy3/LaTI=
X-Google-Smtp-Source: AGHT+IE9njAwIJUhmwH7QLB+W/LK10H+t1DdunnMzWH8iljEb1D85yxLQf1A/fBndBdwWCYqkoZ2hw==
X-Received: by 2002:a17:907:c317:b0:a1d:5c72:3be2 with SMTP id tl23-20020a170907c31700b00a1d5c723be2mr8744283ejc.7.1702486289471;
        Wed, 13 Dec 2023 08:51:29 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id uv8-20020a170907cf4800b00a1d232b39b9sm8000778ejc.184.2023.12.13.08.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 08:51:29 -0800 (PST)
Date:   Wed, 13 Dec 2023 17:51:27 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] staging: rtl8192e: Remove variable nMaxAMSDUSize and
 further
Message-ID: <cover.1702406712.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused or unchanged variables.

Tested with rtl8192e (WLL6130-D99) in Mode n (12.5 MB/s)
Transferred this patch over wlan connection of rtl8192e.
Tested in b,g,n mode and n mode in channels 2, 9, 13

Philipp Hortmann (10):
  staging: rtl8192e: Remove variable bCurrent_AMSDU_Support
  staging: rtl8192e: Remove unused variable nMaxAMSDUSize
  staging: rtl8192e: Remove constant variable self_mimo_ps
  staging: rtl8192e: Remove constant variable peer_mimo_ps
  staging: rtl8192e: Remove constant variable forced_short_gi
  staging: rtl8192e: Remove unused variable ht_info->amsdu_support
  staging: rtl8192e: Remove variable ht_info->mpdu_density
  staging: rtl8192e: Remove variable ht_info->RT2RT_HT_Mode
  staging: rtl8192e: Remove constant variable reg_rt2rt_aggregation
  staging: rtl8192e: Remove constant variable reg_rx_reorder_enable

 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  5 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  |  1 -
 drivers/staging/rtl8192e/rtl819x_HT.h         | 11 ---
 drivers/staging/rtl8192e/rtl819x_HTProc.c     | 77 ++++---------------
 drivers/staging/rtl8192e/rtllib_tx.c          |  5 --
 5 files changed, 17 insertions(+), 82 deletions(-)

-- 
2.43.0

