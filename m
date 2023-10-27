Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5A37D92A7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345532AbjJ0IwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbjJ0IwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:52:15 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C157BBD
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:52:13 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-5842a7fdc61so1022850eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698396733; x=1699001533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jGtdoF3Mg7AoYJ9tjtSPgKmP1BQAIZoXCYmDSYtFg1k=;
        b=Dxw+K6zmct2sq+gpOiu94e34/etbQDuI2XQLaFf+7kK2NxDKc8AtzMQMTi2hjEkS5h
         lXAMbkxmOQyEAN5BoBZlULpPp+lJJxCoJ0yTqAaGoLMq8uOmbSJhjl/9sLA1PbMIz31M
         fRN9RWp3fxfbQMyedpuHHwSGKHhLtAdWmY120blk5Ds7RGoZuhbab1LjJQ8PudQCt0Yn
         HLrOmIImYqIHLbvFwYEnhvB+6cfvt2PjukUFWwonM70bW14mQv7bvjHun2w47pvQLkyY
         bDO05LFQfKJuQQj0sBpcd59G/T3rOVDx2ntAk5xkvH0eKP0D9if8GVpPZ73lC5TgUSYy
         w4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698396733; x=1699001533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jGtdoF3Mg7AoYJ9tjtSPgKmP1BQAIZoXCYmDSYtFg1k=;
        b=UmPDYVAQV2W/fxb8ikNWOB0uXaX4MP8PhtHKHIn7XFIgFjgkXM3ZBKzL6vlSSA3Mn3
         VSfpy0O1Kg4cHPx83Z05nmEz6VeJLGgQkP+h7S8un8kzmqqrejycEYoohfaOUK/H/OJR
         qRfzwFCUfpmtlyrtSDfp/3SMQxmMQZL9CGN0NypjqyyUP3dFkoqhjb2TRnf8Fvo+JP5g
         2B/+NShqX9OxW6MV/+duluB41dMWU/i+fVci+jSoHjC7SylVo4pnWd8xyVAr+xuLcCrY
         xh8hRlmLxqIhePWDSJ1D4FVfG5bWwr+Vtkh60crOqrHg8NgrBzVgBe8ZNE7vGj24gR4L
         z/tQ==
X-Gm-Message-State: AOJu0Yw7ILIj1nOB6NjD5kD33958g9Iag7g21vVAy+PBdZTIbeZDwfb6
        VxjXVpyAYQy4whWMlkwcGvA=
X-Google-Smtp-Source: AGHT+IGLKq5DWDrOjVEC/Es+Ak/cnKAMw9mDYOyYLHjNpKFJaj8Px8YmkssY1ph706/HxFdcJF/iAg==
X-Received: by 2002:a05:6358:e490:b0:168:ec55:d164 with SMTP id by16-20020a056358e49000b00168ec55d164mr2664694rwb.25.1698396732904;
        Fri, 27 Oct 2023 01:52:12 -0700 (PDT)
Received: from ubuntu.. ([122.174.106.169])
        by smtp.gmail.com with ESMTPSA id h12-20020a63b00c000000b0055c178a8df1sm698825pgf.94.2023.10.27.01.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 01:52:12 -0700 (PDT)
From:   Pavan Bobba <opensource206@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Pavan Bobba <opensource206@gmail.com>
Subject: [PATCH 00/10] Type encoding info dropped from array and function names in NIC driver
Date:   Fri, 27 Oct 2023 14:21:49 +0530
Message-Id: <cover.1698396278.git.opensource206@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset series consist of fixes to issues found by checkpatch

Pavan Bobba (10):
  staging: vt6655: Type encoding info dropped from array name
    "cwRXBCNTSFOff"
  staging: vt6655: Type encoding info dropped from function name
    "s_vCalculateOFDMRParameter"
  staging: vt6655: Type encoding info dropped from variable name
    "pbyTxRate"
  staging: vt6655: Type encoding info dropped from variable name
    "pbyRsvTime"
  staging: vt6655: Type encoding info dropped from function name
    "CARDbSetPhyParameter"
  staging: vt6655: Type encoding info dropped from variable name
    "byPacketType"
  staging: vt6655: Type encoding info dropped from function name
    "CARDbyGetPktType"
  staging: vt6655: Type encoding info dropped from function name
    "CARDvSetRSPINF"
  staging: vt6655: Type encoding info dropped from function name
    "CARDbUpdateTSF"
  staging: vt6655: Type encoding info dropped from variable name
    "byRxRate"

 drivers/staging/vt6655/card.c        | 118 +++++++++++++--------------
 drivers/staging/vt6655/card.h        |  10 +--
 drivers/staging/vt6655/device.h      |   2 +-
 drivers/staging/vt6655/device_main.c |   8 +-
 4 files changed, 69 insertions(+), 69 deletions(-)

-- 
2.34.1

