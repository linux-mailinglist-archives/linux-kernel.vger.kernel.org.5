Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D218C7D7C61
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 07:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343868AbjJZFnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 01:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbjJZFne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 01:43:34 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8CC1A6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 22:43:30 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507f63fcbf6so151067e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 22:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698299009; x=1698903809; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZDrfNzJFy46QmelTeNDlluLSuWGgn7i99bhsTcEDtjI=;
        b=VGnahLKAgQd7S/3y71nFizTewzsIo0+Iwkp7lhSOd4CurNc7uTwvmCbZyR/rvoWqIB
         aF/kVG+7GSCX/PPEhw34b78E4pG1NFjctF4oFxpHMDVj2GHZ1XNCbv1MSN2kshdy6yrt
         qhOhroMwLkzaMnn6zpGqV3MIhWNalt1AwYM89I92zjQ5HGQkSZb+EuF6va3NrBV4U2T8
         La1397SdSbHzLMXlQcKa7Wz6ywl24PI+BUiN2XYoRlye7JRimcx3SDFrOPMs0kHZ6xrI
         D9K0mBSpdBx0chm1y8j8eLJL0mIrE9Xf0RKpcbIcHR9HoEbt7MH6OLTSvdokUwFXkB5Q
         8ZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698299009; x=1698903809;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDrfNzJFy46QmelTeNDlluLSuWGgn7i99bhsTcEDtjI=;
        b=vtu9pjzC3sQZ3iJtMQBxea8rxTFCG9iqBtCuzsXOYRI65iqYt5Os4zIN1K1j3bMcHR
         QAQoWeqxk1HJTxa21IzHaZ+H8QwPc8qDWqcFpLad9sJHknZ9PCvdNanAZ6F3Cqg9vrwt
         6a9G4bCOXT0XVswseBJrCLDv3N4GbYVCZ7CRAlBNJJ2U/tTeG1nS4qZSgdDFCMOGb299
         yJhXpt9xyaYtAQyPX6C2H84KDgChjU77fln/xAsuAbxduahSuxVEimIlOKgUJBFLzGQh
         OGs1pFEo6fRhY+Jgc37PnbmnlJbDpNjD7QZWzzzeC0a9eakrWP3ZqB03L2I9OCDV3+9O
         T0wQ==
X-Gm-Message-State: AOJu0YwBKa/pUDWOaAI2LNh/ralXcATiki/WjFzYfkwhLJ7bkYlWBrbp
        OPBRfz0aVLTfOxPbmVvTu+c=
X-Google-Smtp-Source: AGHT+IGeR7SZkubWeLWD1BuxNOZShZptn62n6yLXEXds7HHclU9x2fXX3/21XC0OsqU+oGQQd3l7Dw==
X-Received: by 2002:a05:6512:3a93:b0:503:65d:50c6 with SMTP id q19-20020a0565123a9300b00503065d50c6mr11832855lfu.4.1698299008632;
        Wed, 25 Oct 2023 22:43:28 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id e13-20020a50ec8d000000b0053e775e428csm10605787edr.83.2023.10.25.22.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 22:43:27 -0700 (PDT)
Date:   Thu, 26 Oct 2023 07:43:26 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] staging: rtl8192e: Convert array rx_ring[] to rx_ring
Message-ID: <cover.1698295861.git.philipp.g.hortmann@gmail.com>
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

Remove some functions that always return false or zero.
Remove a loop that is always executed one time and convert arrays to variables.
Remove some unused constants.

Tested with rtl8192e (WLL6130-D99) in Mode n (12.5 MB/s)
Transferred this patch over wlan connection of rtl8192e.

Philipp Hortmann (10):
  staging: rtl8192e: Remove HTIOTActIsDisableMCS14()
  staging: rtl8192e: Remove HTIOTActIsDisableMCS15()
  staging: rtl8192e: Remove HTIOTActIsDisableMCSTwoSpatialStream()
  staging: rtl8192e: Remove HTIOTActIsDisableEDCATurbo()
  staging: rtl8192e: Remove loops with constant MAX_RX_QUEUE
  staging: rtl8192e: Convert array rx_ring[] to variable rx_ring
  staging: rtl8192e: Convert array rx_buf[][] to array rx_buf[]
  staging: rtl8192e: Convert array rx_ring_dma[] to variable rx_ring_dma
  staging: rtl8192e: Convert array rx_idx[] to variable rx_idx
  staging: rtl8192e: Remove unused constants starting with MAX_RX_QUEUE

 .../staging/rtl8192e/rtl8192e/r8190P_def.h    |   2 -
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |   2 +-
 .../staging/rtl8192e/rtl8192e/r8192E_phyreg.h |  62 +--------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  | 131 ++++++++----------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h  |  10 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c     |  37 -----
 drivers/staging/rtl8192e/rtl819x_Qos.h        |   1 -
 drivers/staging/rtl8192e/rtl819x_TS.h         |   1 -
 drivers/staging/rtl8192e/rtllib.h             |   1 -
 9 files changed, 67 insertions(+), 180 deletions(-)

-- 
2.42.0

