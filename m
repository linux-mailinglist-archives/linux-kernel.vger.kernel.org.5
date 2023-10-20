Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC237D15D5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 20:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjJTSdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 14:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjJTSdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 14:33:44 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A164D55
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 11:33:43 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5ad5178d1bfso834619a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 11:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697826823; x=1698431623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EcCoCnk9B62V6W1dXZGbI6iky0FmIyOXScS0LvYk/mI=;
        b=PC4oRf2Q/HgIoOlK5c6fHLiowOgOimF3PzRTDrj7FXKIC6von0mFLjEv3IQDNGiK+Y
         c/AwR9SRa1uhwxgi7/HQUBX+IM/lZagfcxY8KCPaysma9PO4uxjgpDVHShTxhKWshcUa
         emKqZVauZQlYy1T59ohwEWC36iAyJM1RSRuE2CQtrSd0bRHjT+kyUsp42YGatDSqJkyz
         vXP+wQGXW2mXfNxGJ93kmhFFIADp2x8sgh00c9KKJPwDSJln4kiqkc1uLavMy7QJgEoO
         qA/Em2BrD2172zbXuX2EsCNEm/PSnG0arLYRRQ2KUByoH70IwyocMDxh0UAtgKYsEAdk
         L7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697826823; x=1698431623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EcCoCnk9B62V6W1dXZGbI6iky0FmIyOXScS0LvYk/mI=;
        b=BJggkK8C54UbHMSa9e8brygMXcbwYM89Yq+WzQhBOZhK3KSPPGN4oB6SQHC8thYf7G
         p+FVOICSQWXtDYfxo0PVsRP66kHvRmNQAW0sCg+x0XBqtZah2Vad8sYYp2uuvGIe78ki
         1vzGi8hXhEXInbyvwT5zbIHkQmFNynzp8JIKcxL2zgcNWf/9LbnRq4vRRO6hi1DPcbeW
         Huw8ktxosYSXRdrFH5gH91IaQ6sCO/0sek5OimxTn8jycbzOEJgMxn/9F5QOJ8gUJNLj
         HJGHmh0xjcAcuQxpgFiugywtrm3Oejx2E1kdTy+1UJDf0594rNHHTbWbmmjK77b74Dui
         rrhA==
X-Gm-Message-State: AOJu0YzSbq5PZhr9ou0TMyW08IS8O/Q6UPRjOENxKcsmaX06YbJYIIbr
        7SS1PiFVXeoW7Y0IBRo5/AppQ5hLN84=
X-Google-Smtp-Source: AGHT+IH6T5wMeFr695iPhHYkDuFGqPi8lU+CGKV5b6CRsZKYjJ0uO5pDfqtPf7vTh0/lEBeSaj4GjA==
X-Received: by 2002:a05:6a20:4326:b0:179:f79e:8615 with SMTP id h38-20020a056a20432600b00179f79e8615mr2802657pzk.52.1697826822724;
        Fri, 20 Oct 2023 11:33:42 -0700 (PDT)
Received: from fedora.. (c-73-170-51-167.hsd1.ca.comcast.net. [73.170.51.167])
        by smtp.googlemail.com with ESMTPSA id z14-20020aa7990e000000b006b4ac8885b4sm1911345pff.14.2023.10.20.11.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 11:33:42 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 0/5] Some khugepaged folio conversions
Date:   Fri, 20 Oct 2023 11:33:26 -0700
Message-Id: <20231020183331.10770-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset converts a number of functions to use folios. This cleans
up some khugepaged code and removes a large number of hidden
compound_head() calls.

---
v3:
  Address filemap_lock_folio() returning ERR_PTR
  Fix uninitialized variable warning
  Some minor rewording

Vishal Moola (Oracle) (5):
  mm/khugepaged: Convert __collapse_huge_page_isolate() to use folios
  mm/khugepaged: Convert hpage_collapse_scan_pmd() to use folios
  mm/khugepaged: Convert is_refcount_suitable() to use folios
  mm/khugepaged: Convert alloc_charge_hpage() to use folios
  mm/khugepaged: Convert collapse_pte_mapped_thp() to use folios

 include/linux/memcontrol.h |  14 ----
 mm/khugepaged.c            | 137 ++++++++++++++++++-------------------
 2 files changed, 68 insertions(+), 83 deletions(-)

-- 
2.40.1

