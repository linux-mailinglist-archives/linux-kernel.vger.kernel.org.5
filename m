Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFAB7BBF73
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 21:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbjJFTEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 15:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbjJFTEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 15:04:34 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA9B83
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 12:04:32 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9ae3d7eb7e0so92048966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 12:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696619071; x=1697223871; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Eu4wF2/IYoKy9UH3IkMZDQw3vL3PojhT6UzwC/bQBs=;
        b=nGGOY2ZjHtU5jQSNgGFLTtCRcstmlm9Di2Q+8aX9wmI4RlB4oGIwIrQ42QbbrDxSAj
         yf9PSnfW2OC+P9yTV3P4YFs9TSw3oiYZFz1zwZOo9rq1eEuPXooQdtVDVdKbdp/MrRhS
         6Er4oSKsE79vWOOSTvl0fXQ6E8GdBG4ZL6TUZHmE85y2GAI8lSRKtD/xddMacBzIb7Lj
         Yl4uZA0uaqxZ/mli2fmFG/trgAcwLcQM9HzDAuV6KIG0H8n4d5TnsgGValJn/oLjHSY4
         t69GnNoXTbQ9bHXO8MAsXpJEfd70cBfuFMPVqlPkeA1f0ZaJEFhuwxAT5sb5jQ5rWXeS
         jFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696619071; x=1697223871;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Eu4wF2/IYoKy9UH3IkMZDQw3vL3PojhT6UzwC/bQBs=;
        b=nkDQKSI3+d9u7yMuG6UDgiyZwEELaWDb1Ep/B3OnmBeWrmMfu+3Dywxs6W4x39hm4P
         SvvmPZ88WH3TqpU1EGejnKOrzJ2WkEK5y742ZHAFOHtVqAbap7ffsC0koC0KAOqPBawQ
         X8J1ZUpfihFeXIiVwRSfjVfmLZ9u34NbQnjqskWbgKETyMAqSKRUzBb5BSZe/6aKLUfX
         7vrKES/C8Y/OpQ6f2NA0vxeejLFGCGwsz1QLNGwlVJd1FM5q56nteQSNMafWwhM5M2DT
         hZOLltJVBhh2k6nGPVKqgqyr0nv9pDuVikg60ElgQ/liZL9EGEHV/ra4LkhzuJ4hyMO0
         rGZA==
X-Gm-Message-State: AOJu0Yyph/ZGaeK7NK+rIZmhtwyecTL27Jxoev36dM/si9C5vVfesToC
        MLqMagtkx0mGZ6SeQyUgR/A=
X-Google-Smtp-Source: AGHT+IEIIwF0bbR6veI9TiOA0mHMQOF0jB6Fo2wpY0RjT2X0RlYRBCw8jTWk6NRtKSKTcae7tMJtfA==
X-Received: by 2002:a17:906:100c:b0:99c:5711:3187 with SMTP id 12-20020a170906100c00b0099c57113187mr6705865ejm.6.1696619070743;
        Fri, 06 Oct 2023 12:04:30 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id qb40-20020a1709077ea800b009b9af27d98csm1876680ejc.132.2023.10.06.12.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 12:04:30 -0700 (PDT)
Date:   Fri, 6 Oct 2023 21:04:28 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] staging: rtl8192e: Remove last private functions from
 iw_handler_def
Message-ID: <cover.1696548527.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux kernel authors consider "wireless tools" package deprecated. The
"wireless extension" is also deprecated. Remove private functions of 
"wireless extensions" that can only be accessed by "wireless tools" from
driver.

Tested with rtl8192e (WLL6130-D99) in Mode n (12.5 MB/s)
Transferred this patch over wlan connection of rtl8192e.

Philipp Hortmann (10):
  staging: rtl8192e: Remove function _rtl92e_wx_set_force_lps()
  staging: rtl8192e: Remove function _rtl92e_wx_set_lps_awake_interval()
  staging: rtl8192e: Remove constant variable reg_max_lps_awake_intvl
  staging: rtl8192e: Remove function _rtl92e_wx_adapter_power_status()
  staging: rtl8192e: Remove constant variable ps_force
  staging: rtl8192e: Remove function _rtl92e_wx_set_scan_type()
  staging: rtl8192e: Remove unchanged variable active_scan
  staging: rtl8192e: Remove function _rtl92e_wx_set_debug()
  staging: rtl8192e: Remove unused variable rt_global_debug_component
  staging: rtl8192e: Remove unused file rtllib_debug.h

 drivers/staging/rtl8192e/rtl8192e/rtl_core.c |  11 --
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h |   2 -
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c   |   3 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c   | 145 -------------------
 drivers/staging/rtl8192e/rtllib.h            |   4 -
 drivers/staging/rtl8192e/rtllib_debug.h      |  49 -------
 drivers/staging/rtl8192e/rtllib_module.c     |   3 -
 drivers/staging/rtl8192e/rtllib_softmac.c    |  11 +-
 8 files changed, 3 insertions(+), 225 deletions(-)
 delete mode 100644 drivers/staging/rtl8192e/rtllib_debug.h

-- 
2.42.0

