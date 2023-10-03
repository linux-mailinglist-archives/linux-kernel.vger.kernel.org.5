Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BE97B71C4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240919AbjJCTdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 15:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240909AbjJCTdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:33:05 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55844CE
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 12:33:02 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9ae65c0e46fso53935966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 12:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696361581; x=1696966381; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HTn6J1jkDkGPJuOyaFZiPoWiCLl873wqp1f1gByRkbY=;
        b=Ja5ibe8tQmNippVt09/yQ84Gb5tTbIQO/wN1xPPVG40XxQWBBrJecK5qWJE86PSOrp
         GEh2G9jqS5CZPfH7MlbQCm7eKx6LYZIAlbUxIFRAEz7+6agscghB8BF5BjCjPgP7EWkb
         +FrBhGh8KbQVo499vIejE5vbq0DvkL+iA6mUZNBo9oZPGn0jw7gOWwsYIdZBNAP+R4TB
         ZVonXd/1DbAWyt05x6VGLX9XUKx+8j8JLLoLCBq4n8pWUpdWGKqiEdmPKs9CLurGt6/R
         Wfi+Wgijscskccgp0lSF6cJ4XSQKOD0he+eCPutpOYryhNxgpnAgBj7hKdctTuFeqmHn
         V3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696361581; x=1696966381;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HTn6J1jkDkGPJuOyaFZiPoWiCLl873wqp1f1gByRkbY=;
        b=HhEuv59M9A6vDIIvDJ2H1gNLVgdTY5xb8qnQEtAxX3VMG6Gpn8o1JuW4vdlMJJ4rYX
         NRzPc8q/Zs5ktcyqS0TM9ENrMf8xaHkDtd4jiKY9uHi99y0WVEPyY5MOGrCz/F9DTYMv
         M03JThaRNbvDT2pQH/xV2eBZ39xv0yRfM77Ofi4KF/gaWvg3CjaN0Y+3tH2/I7HNyNvM
         A1Y1Rmb8qoAbIPlVGy5t7pi1v/W+lAvK8PzTGxD98fIRLAPytc4CefzTVzS6nTwRsIQc
         0JhGORZGg1jOw4T/74DwVuDTeHYx0subnxBuv9T/vcVXspAVztkE/3FBkQQd6G/HDjRu
         NLfw==
X-Gm-Message-State: AOJu0YzUzB1bz8tqnhJBlHkTSApCwHYaAir5mKMqcGf1kmNyOotxnbVD
        18wYK0EYh7zMibZekoHnbVM=
X-Google-Smtp-Source: AGHT+IFt1x8zPA9cFLiJgAdBDaNjnJqrerrvSGn7e48IZfzP41wCL4Db+tCT9LVP4IhdZvpkOmoBaA==
X-Received: by 2002:a17:906:7389:b0:9b2:71f2:bd11 with SMTP id f9-20020a170906738900b009b271f2bd11mr96402ejl.4.1696361580483;
        Tue, 03 Oct 2023 12:33:00 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id y9-20020a17090614c900b009a1a5a7ebacsm1492247ejc.201.2023.10.03.12.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 12:33:00 -0700 (PDT)
Date:   Tue, 3 Oct 2023 21:32:58 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] staging: rtl8192e: Remove functions rawtx and promisc
Message-ID: <cover.1696360403.git.philipp.g.hortmann@gmail.com>
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

The Linux kernel authors consider "wireless tools" package deprecated. The
"wireless extension" is also deprecated. Start to remove private functions
of "wireless extensions" that can only be accessed by "wireless tools"
from driver.

Tested with rtl8192e (WLL6130-D99) in Mode n (12.5 MB/s)
Transferred this patch over wlan connection of rtl8192e.

Philipp Hortmann (11):
  staging: rtl8192e: Remove function _rtl92e_wx_set_rawtx()
  staging: rtl8192e: Remove equation in function rtllib_xmit_inter()
  staging: rtl8192e: Remove function rtllib_start_monitor_mode()
  staging: rtl8192e: Remove unused variable raw_tx
  staging: rtl8192e: Remove unused parameter mesh_flag
  staging: rtl8192e: Remove function _rtl92e_wx_set_promisc_mode()
  staging: rtl8192e: Remove function _rtl92e_wx_get_promisc_mode()
  staging: rtl8192e: Remove constant variable fltr_src_sta_frame
  staging: rtl8192e: Remove constant variable promiscuous_on
  staging: rtl8192e: Remove constant variable net_promiscuous_md
  staging: rtl8192e: Remove constant variable bToOtherSTA

 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |   5 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  |  13 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c    | 107 +---
 drivers/staging/rtl8192e/rtllib.h             |  18 +-
 drivers/staging/rtl8192e/rtllib_module.c      |   1 -
 drivers/staging/rtl8192e/rtllib_rx.c          |  72 +--
 drivers/staging/rtl8192e/rtllib_softmac.c     |  55 +-
 drivers/staging/rtl8192e/rtllib_softmac_wx.c  |  32 --
 drivers/staging/rtl8192e/rtllib_tx.c          | 476 +++++++++---------
 9 files changed, 262 insertions(+), 517 deletions(-)

-- 
2.42.0

