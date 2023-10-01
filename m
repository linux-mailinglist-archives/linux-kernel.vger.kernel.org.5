Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41E87B47A5
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 15:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbjJANn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 09:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjJANnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 09:43:55 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C07891
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 06:43:52 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9ae3d4c136fso419564366b.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 06:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696167831; x=1696772631; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FWdo0Xen3j1Z5vpJFXzKckOo4KzL4gSS+suSALE7N7s=;
        b=OouGPLxx6j16480ZyIPkliilYDwa+ufr9jVPalgmmPVsylHlpEmRG13kGUhLEsQ4Tq
         LwSN/MmyPHlQ9iIEgmFIvCtUpJ1ug6S+fvbznWkGTRL2q3BSB2dwxaLemf+sGgPfxJY3
         N3OoNgworp9qDzID49X8+3QH7UgaTia03C44alk3O0vwiDDAytxhJbQ96d2w8pKQy1Gw
         D/x6k1aKBViwQ3jQ2PPCnzeUPHstTGMkESH51FZsjv3N1c2cIfWNlyoLXq0M0fJSf+wd
         g+rzS0BZE/o4t1OcLphTUXm9Dwa2onKb2GSJMpMAD9qYs79jyN0ZLwWg1hsLZTtH/H/i
         tG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696167831; x=1696772631;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FWdo0Xen3j1Z5vpJFXzKckOo4KzL4gSS+suSALE7N7s=;
        b=Jz0rgW0NxzVV179LUS4y01HEwdb8rmM7ojHDw+ELUG0JcefOFpfGIPESmM68fSuBmC
         LAOS/x4nfgV0gF8i/fUNPse1HXTt9TtEOA/jNxEXt7DKuYMQKKQ+rx/zuCNuPWo2AyBr
         XfbGSMNFmv/t6J+pxmB90l4mhuYVxeEbvm9P0ehKYBozs3SFN8aXWdv4CdinkKARyDks
         Z2OHN7EiqrgS+HUYWq6Kod+V5mQ/Z6YefnAnLCh6NjlieUMzogRJJTn6l6x2RonzWo9/
         IHsACmeFVOPHT6YEoTAhD/G0sF8tzao1wpZpyck3G9HNmwFnbWYrc3srbTTbRP3SNcQr
         f9QQ==
X-Gm-Message-State: AOJu0Ywfb+/47fNqXTGMPbDRjZBojtj9TNRaW/B/eqt3SQZkiKrpiZN1
        CORFP+rAEnRLqtkKf4K1dyI=
X-Google-Smtp-Source: AGHT+IGJGDepRSWl8XWYqnjABUG4wibQ/FteSnWEM1qITlmjBWrSE9kTGtNocO5auiwqLEYGWOtfWg==
X-Received: by 2002:a17:906:2098:b0:9a1:f96c:4bb9 with SMTP id 24-20020a170906209800b009a1f96c4bb9mr8720043ejq.6.1696167830793;
        Sun, 01 Oct 2023 06:43:50 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id qk8-20020a170906d9c800b0099bd1ce18fesm15753463ejb.10.2023.10.01.06.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 06:43:50 -0700 (PDT)
Date:   Sun, 1 Oct 2023 15:43:48 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] staging: rtl8192e: Remove broken function
 _rtl92e_if_silent_reset()
Message-ID: <cover.1696165351.git.philipp.g.hortmann@gmail.com>
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

When the function _rtl92e_if_silent_reset() is called the variable
priv->rst_progress is set to RESET_TYPE_SILENT.
Since priv->up is always true the function is left at "if (priv->up) {"
without resetting. Now the function _rtl92e_if_silent_reset() is like
deactivated because the equation at the very beginning is false:
"if (priv->rst_progress == RESET_TYPE_NORESET) {"
This leads to a state where the driver hangs in the reset state and
cannot go forward.
In 30% of the cases the wlan is disconnected and cannot reconnect. The
rest of the time it continues working but no reset is done at all.
Further requests for reset are ignored. Remove broken function that
has never worked.
Some related cleanups are included.

Tested with rtl8192e (WLL6130-D99) in Mode n (12.5 MB/s)
Tested r8192_private_handler with:
	sudo iwpriv wlan0
	sudo iwpriv wlan0 forcereset 1
Tested channel switch.
Transferred this patch over wlan connection of rtl8192e.

Philipp Hortmann (11):
  staging: rtl8192e: Remove ibss_maxjoin_chal
  staging: rtl8192e: Remove dead code from _rtl92e_if_check_reset()
  staging: rtl8192e: Remove RESET_TYPE_NORMAL
  staging: rtl8192e: Remove broken function _rtl92e_if_silent_reset()
  staging: rtl8192e: Remove unused variable rst_progress
  staging: rtl8192e: Remove unused variable reset_in_progress
  staging: rtl8192e: Remove unused parameter from _rtl92e_sta_up()
  staging: rtl8192e: Remove unused parameter from _rtl92e_up()
  staging: rtl8192e: Remove unused variable is_silent_reset
  staging: rtl8192e: Remove unused variables priv->reset_count and
    reset_cnt
  staging: rtl8192e: Remove r8192_private_handler
    _rtl92e_wx_force_reset()

 drivers/staging/rtl8192e/dot11d.c             |   3 -
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 100 ++++++------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  | 147 ++----------------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h  |   5 -
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    |  54 +------
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c    |  18 +--
 drivers/staging/rtl8192e/rtllib.h             |   2 -
 drivers/staging/rtl8192e/rtllib_softmac.c     |  10 +-
 8 files changed, 66 insertions(+), 273 deletions(-)

-- 
2.42.0

