Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE2F7F0954
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 23:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjKSWOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 17:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjKSWOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 17:14:34 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BDEF2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 14:14:30 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3316db2c5c0so501725f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 14:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700432069; x=1701036869; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6SgJuOVjQrC/WMtPUl/tqm5BE2EEMD5VGhqPFuJyEFI=;
        b=ZxoSZk9NbKYMPLuWZSRfjhRryGrr9+mDKcy5lKLk67/0EKuE9nQMIdDK3kzKxlEnjq
         MC+T3fvNkH5SnrBfYrPVLLUVTW91UrSdHz2AHSsBeav/B/bMQ9P3oNLjLKvjb60yR84w
         xzew5si5voU+32HR2Va6xFiUhOgXRv19cMYhKLL3uPTC5h2T3/1Pp6T5yz/2hqtLxYTK
         oHUuQHjocGtIx1KiHlDzcLkSQwKhPTLZZMMsInkeMwdYzJdi5UG+1HqomsN98riwPpq2
         H++1NXbRXf6YBJWzjaGiWIos144L2Id6G39eKYcXRPjhs54spisyye6rUVHwDI/UHUzY
         zWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700432069; x=1701036869;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6SgJuOVjQrC/WMtPUl/tqm5BE2EEMD5VGhqPFuJyEFI=;
        b=L3Y5h+oHTjvHMJfcmRV75xzRanrPu3QWr7s4bZW5mAZerk6c1gzn5drgXPyCWZlQOx
         1S4izpA0TRBNAXFvVz+EgNeUZ/ZYrnGv90lU0tIsLFlqHeua94+UO0s91gMtWmJLFNaQ
         hGwibmAC2odNSeuHr0LYx+eqAXIIS4odMfqWkNwxG+h5Vo8AGhmhC73gBwoZNrfUOt+R
         bBQpwYcSgXx437HGFnOl3VT5lIxy8bITFTkwTuelNIkM2xRRpsarb9Ylk3mkJIpgmOmx
         eJFwsEDBAzQsnWgup82wgUXTUtMjIHKI2oBC3k22PEQDJsCYNZlweWrdUIf+GJDtrz4R
         M7fg==
X-Gm-Message-State: AOJu0YzOcZPLIjCFdtCPJwnzMlimfcjAn6tuHzDOh8JZ0ttjvbIP/vTS
        sAPqQUQMNneNbDUQlM4qytLoXi+bCps=
X-Google-Smtp-Source: AGHT+IEyegCqaIrQIV6GnRAnVqg7b6ZHfV2HjHZUb4aEI8rW0ETQoTaYTyV9TW16Izy2dNLaWkJfUQ==
X-Received: by 2002:a05:600c:468f:b0:408:3a29:d7e8 with SMTP id p15-20020a05600c468f00b004083a29d7e8mr5056535wmo.3.1700432069001;
        Sun, 19 Nov 2023 14:14:29 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id f26-20020a7bcc1a000000b003fee8793911sm10923341wmh.44.2023.11.19.14.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 14:14:28 -0800 (PST)
Date:   Sun, 19 Nov 2023 23:14:27 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 00/14] staging: rtl8192e: IS_DOT11D_ENABLE() returns always
 false
Message-ID: <cover.1700431464.git.philipp.g.hortmann@gmail.com>
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

IS_DOT11D_ENABLE() returns always false. Remove dead code accordingly.

Tested with rtl8192e (WLL6130-D99) in Mode n (12.5 MB/s)
Transferred this patch over wlan connection of rtl8192e.

Philipp Hortmann (14):
  staging: rtl8192e: Remove unexecuted rtllib_extract_country_ie()
  staging: rtl8192e: Remove unused function dot11d_update_country()
  staging: rtl8192e: Remove IS_DOT11D_ENABLE(ieee)
  staging: rtl8192e: Remove unused function dot11d_scan_complete()
  staging: rtl8192e: Remove unused function dot11d_reset()
  staging: rtl8192e: Remove unused macros IS_EQUAL_CIE_SRC and friends
  staging: rtl8192e: Remove unused function copy_mac_addr()
  staging: rtl8192e: Remove unused variable dot11d_info->state
  staging: rtl8192e: Remove unused variables from struct rt_dot11d_info
  staging: rtl8192e: Remove unused variable country_watchdog
  staging: rtl8192e: Remove unused variable global_domain
  staging: rtl8192e: Remove unused function dot11d_init()
  staging: rtl8192e: Remove unused struct chnl_txpow_triple
  staging: rtl8192e: Remove unused variable bss_start_channel

 drivers/staging/rtl8192e/dot11d.c            | 93 --------------------
 drivers/staging/rtl8192e/dot11d.h            | 56 +-----------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c |  1 -
 drivers/staging/rtl8192e/rtllib.h            |  3 -
 drivers/staging/rtl8192e/rtllib_rx.c         | 31 -------
 drivers/staging/rtl8192e/rtllib_softmac.c    | 20 -----
 6 files changed, 1 insertion(+), 203 deletions(-)

-- 
2.42.0

