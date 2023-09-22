Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD43C7AB2AC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 15:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbjIVN30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 09:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjIVN3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 09:29:24 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FD9E8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 06:29:19 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4053e6e8ca7so2047205e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 06:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695389357; x=1695994157; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TVLvJ+dOPpuR79o+2fomapIC7IP8zBabO9ASUwcyNOw=;
        b=A7WBsh8lGrq+2mW/YOTUTRCFI0nkcmKATy26molmxDOiobs7vmJ76rSBJnc2GY3t+Q
         9mQTkPOrHeYWFovgpNiZdtvpxnWzHugXctN9ZFchUE8uLWsVfPFDKoOZxrlv9mkxkyRC
         1We1Br95EFzh5Td79lzjquM1Uv3kVX0RsttrVd1WNC7i9l3dobctjq6nFFhtjoq+9o1Q
         Guk+Tz1047nZCQo+GGzROnw/TFFkOtVmhCD3/qlIVfM9IGmlU5n34PVadrX62zm5FhXL
         aFRPprhMAbp3ua+6KMxfj6NmAuWEwoeWRynGurbIjAEFA4ouZS6Dbph6STud+WoiACmL
         Yg3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695389357; x=1695994157;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TVLvJ+dOPpuR79o+2fomapIC7IP8zBabO9ASUwcyNOw=;
        b=fIANI91j+778/cyX1XVLrOfSzfPWzpmdGm3iCmxW/qxnE8LKEndRvplx0/SJUHbV7K
         Gy7j7CWm2ZJeOZ7akkoacxokVeWvMHch+9KmfxAJJClUQNCQCLhnvonr5zeUb/QIXHjo
         jIR0HIMliTJXxY4niPSRj5DhsZ1ly3sxdka8MuArr0EfIA9dyjtZyhFOlzjoj1AGQNYY
         bHaB5a3727IrGyTMVJ86k/pyr0rn43SBW9fATr6gDzlAKB4nNhmcHJV46TU7z2++VY0d
         5zSQeLNjN3WW9baNnwfaMr3qo3X7QfSvd1wu55sFintKVPhSykHM1m+LZxwTVnbkKr8I
         Us3Q==
X-Gm-Message-State: AOJu0YzJu28ErCaMfYV7WL2GqdNJC9VebEEpw/ZzbhJe2AdjDeplwOU+
        JA8B9m5dE+pNBLyNX5QzzZw=
X-Google-Smtp-Source: AGHT+IFuUHm0KscA5Acf+Cq9svi9Nx9WdrlevWXm4I2gzt3CA3G5jow7/GUNA2BqyxxfLkYiHF6CEw==
X-Received: by 2002:a05:600c:1c20:b0:405:358c:ba75 with SMTP id j32-20020a05600c1c2000b00405358cba75mr3962139wms.0.1695389357176;
        Fri, 22 Sep 2023 06:29:17 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id z12-20020a5d654c000000b0032148618cc4sm4464524wrv.29.2023.09.22.06.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 06:29:16 -0700 (PDT)
Date:   Fri, 22 Sep 2023 15:29:15 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] staging: rtl8192e: Remove mode IW_MODE_ADHOC functions
Message-ID: <cover.1695387832.git.philipp.g.hortmann@gmail.com>
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

Remove unsupported mode IW_MODE_ADHOC because this mode is only partially
coded in the driver. This patch series removes the unused functions.

Tested with rtl8192e (WLL6130-D99) in Mode n (12.5 MB/s)
Transferred this patch over wlan connection of rtl8192e.

Philipp Hortmann (7):
  staging: rtl8192e: Remove mode IW_MODE_ADHOC from rtllib_tx.c
  staging: rtl8192e: Remove mode IW_MODE_ADHOC from rtllib_rx.c
  staging: rtl8192e: Remove mode IW_MODE_ADHOC from rtl_core.c
  staging: rtl8192e: Remove mode IW_MODE_ADHOC from rtl_cam.c
  staging: rtl8192e: Remove mode IW_MODE_ADHOC from rtllib_softmac.c
  staging: rtl8192e: Remove delayed_work start_ibss_wq
  staging: rtl8192e: Remove rtllib_stop_send_beacons

 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  44 +--
 .../staging/rtl8192e/rtl8192e/r8192E_dev.h    |   1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.c   |  61 +---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  |  22 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    |   2 -
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c    |   6 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c    |   5 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c     |  64 +----
 drivers/staging/rtl8192e/rtl819x_TSProc.c     |  21 +-
 drivers/staging/rtl8192e/rtllib.h             |  23 --
 drivers/staging/rtl8192e/rtllib_rx.c          |  38 ---
 drivers/staging/rtl8192e/rtllib_softmac.c     | 264 +-----------------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c  |  10 -
 drivers/staging/rtl8192e/rtllib_tx.c          |  11 +-
 14 files changed, 22 insertions(+), 550 deletions(-)

-- 
2.42.0

