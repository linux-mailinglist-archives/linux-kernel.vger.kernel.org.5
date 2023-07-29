Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30409767CEC
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 09:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjG2Hwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 03:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjG2Hwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 03:52:32 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086504204
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 00:52:31 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-991f9148334so71538966b.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 00:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690617149; x=1691221949;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zoAPj2M3hi4bdO/fWeB5BuSeElF79ScevXlfk+QIpO4=;
        b=icsCPy3mJGjc95NaYiTJ2GuAdfNOWD46mYmZmgxXvFiCXdpEto5GImrjx+PDYSNnds
         3zQeuFAPeTyue0Q+uCuxmhvnH4+fXKZtP1X7z+6eOU31CttVipcXCc75QhXX9zb1Nffh
         BloHocv6X4xxRvmEOoOQoNOvDnO06cHOliJMRRhb8eyT7LyJBm+tZkacaipsvn+sMK2M
         K9zixa7zgP5swO1iJMmSAtcfCF4K7Wg/7VU7ECUMP+pdryenVhQRX0shNTnr+d4z+mkA
         ytN37SAhm9tpT+O9mozGP7fHjvUxoEBg4vbY0cjYMUXiA1aG6wQXC61rkII1SHuw3j4w
         ZYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690617149; x=1691221949;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zoAPj2M3hi4bdO/fWeB5BuSeElF79ScevXlfk+QIpO4=;
        b=LuECbFB/B3R4SaPNoCXUd8hehJIYri+B1Ya/leuDJkoEAbzFC9lKWPWzirnd2plugQ
         9U/qfGgfp7VCSR59XuncVB5Y8HUEEyhhVEZeHgJ+FH1z6txr9I8sglmM2qMLlDXkI3Xe
         fJB6wmKAPLLnIkH7124CxrN0CrpK2zVv/xhn0g0+IoFLZ4JbRP1RpASveoNGaMGL9XzH
         nvMNBXJvYEU8ksBPEqYFu5KIlFu7tQMX94UQHqCl1jk4taZ1J24uF0zzdLRTiSAfXXoU
         eiYBmgOmR7CKwGCefFvEf+tccdIy2ZDPe6vFMz8VpTPUy5O/5tHgRdL5MJ5QJl2+zWxK
         TWQQ==
X-Gm-Message-State: ABy/qLZjtKTWrTWL1QO9OiDfc2Y346t08z2Zs1O6tB8BSqCkHwCDgNr0
        Bt+2EAx12N3/sMU9sDm3c9ThUW2hiFU=
X-Google-Smtp-Source: APBJJlHvS+trp8ocHMc8PrnLwEL9Vu4+4JgyuTshEJyxbzHoM7w+oi1OEFsWVyN69tnVvFxME/h05A==
X-Received: by 2002:a17:906:73dd:b0:998:bac1:3bdd with SMTP id n29-20020a17090673dd00b00998bac13bddmr1351403ejl.2.1690617149157;
        Sat, 29 Jul 2023 00:52:29 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id ga15-20020a170906b84f00b00992d0de8762sm2992791ejb.216.2023.07.29.00.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 00:52:28 -0700 (PDT)
Date:   Sat, 29 Jul 2023 09:52:26 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] staging: rtl8192e: Remove unused variables starting
 with p_intb
Message-ID: <cover.1690615475.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused or constant variables and empty functions.

Tested with rtl8192e (WLL6130-D99) in Mode n (12.5 MB/s)
Transferred this patch over wlan connection of rtl8192e.

Philipp Hortmann (10):
  staging: rtl8192e: Remove unused variable p_intb
  staging: rtl8192e: Remove unused variable intb in _rtl92e_irq()
  staging: rtl8192e: Remove empty function rtllib_rx_Master()
  staging: rtl8192e: Remove empty function rtllib_rx_Mesh()
  staging: rtl8192e: Remove unused variable is_mesh from
    rtllib_send_probe
  staging: rtl8192e: Remove is_mesh from rtllib_send_probe_requests
  staging: rtl8192e: Remove is_mesh from rtllib_start_scan_syncro
  staging: rtl8192e: Remove is_mesh from rtllib_softmac_scan_syncro
  staging: rtl8192e: Remove is_mesh from rtl92e_set_swcam
  staging: rtl8192e: Remove DefaultKey from rtl92e_set_swcam

 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  2 +-
 .../staging/rtl8192e/rtl8192e/r8192E_dev.h    |  2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.c   | 17 +++++++---------
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.h   |  3 +--
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  |  5 +----
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c    | 12 +++++------
 drivers/staging/rtl8192e/rtllib.h             |  2 +-
 drivers/staging/rtl8192e/rtllib_rx.c          | 14 -------------
 drivers/staging/rtl8192e/rtllib_softmac.c     | 20 +++++++++----------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c  |  4 ++--
 10 files changed, 29 insertions(+), 52 deletions(-)

-- 
2.41.0

