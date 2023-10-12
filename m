Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A927C7A65
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 01:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443095AbjJLX3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 19:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443053AbjJLX3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 19:29:19 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23904A9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 16:29:18 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3af609c4dfeso904720b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 16:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697153357; x=1697758157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2PQzVbFzPaK/7j+0uEoI7g4sCbjf7855ArRv9lm1q1A=;
        b=DqXCU4pMbdxo7Le/T7qQqSOZdNdnG8IUKMVZeLtweJL9+x4OWO2UvvHGC/Wt9BJgqp
         DSAgTwUpetR6Kt3uaxBaIwDwsQAVkkruGtAK/jsESVeV+JZ7sFtW78JHfYNUTBp6oJQ0
         gHsIQcmCRfcknrf8DVZpY1dJqJy8yoQM1fIHKuX/1lvZyj6YIdC4hAIPjYygE47r7SEH
         mNiu5sYhn9d553ua2+21jb+yyRRaYUOi9RNpV9wahrUKF1Sh6+1/DBFFw2Bu31Y0lwii
         hjcNCeos5it9SQ9jbYjrTia0L1laWgXy/zkDUoXrZtwMv5jdHFnytMJi6F9IoBrfYr2Z
         sHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697153357; x=1697758157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2PQzVbFzPaK/7j+0uEoI7g4sCbjf7855ArRv9lm1q1A=;
        b=MpPeAzt+XaT6FBs/qHrOgUfM9qIr6F45WN3V6D0tlrNTpQpDBfo3/jSdoz5zXPIqEq
         ZHt/Jwar++lYMZyBzpsxIaF+DPUmbf4w6Gy1TBqEYzoSM2wWn3yH/Us/BTjlPmyJeEbW
         6MkLLRbaCqEsTRPOsAHudM4KBB9nJHmZEEN3/9cx9XWPf+i9tzmj0+dOStDH1lSCcHcY
         Q7kOS+ecpKVzW9IeBs2ntjJv4ieFnOAd5FMOM9xcVLLwtml14xUwslNz2ZtCHYXtvTLS
         PjkV/oxr/4w8AqNswpOzSljBpUHFX+r44ugPfQCnRhIDclN/RhjFczd/imBaUOAezAFA
         zS+g==
X-Gm-Message-State: AOJu0YwDy4fShuvAZlmBljMpQLqEqE+mjS10Ens3dAUZI/syf1c2DPVs
        wL2w9ywEiHXtmjELkF+0IR+juYXN5lUqMg==
X-Google-Smtp-Source: AGHT+IH6y78R4gypagB9eKwVM2UDqVio3PcPJNPwqL/9bWcgnOkEZB+C7vXkwYV45RImeq5Kj4hV3A==
X-Received: by 2002:a05:6808:1313:b0:3af:8050:369f with SMTP id y19-20020a056808131300b003af8050369fmr33008736oiv.6.1697153357378;
        Thu, 12 Oct 2023 16:29:17 -0700 (PDT)
Received: from Negi ([68.181.16.134])
        by smtp.gmail.com with ESMTPSA id z15-20020a056a001d8f00b006abd5f6802fsm3263319pfw.60.2023.10.12.16.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 16:29:16 -0700 (PDT)
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Micky Ching <micky_ching@realsil.com.cn>
Cc:     outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Soumya Negi <soumya.negi97@gmail.com>
Subject: [PATCH v2 0/2] staging: rts5208: Fix checkpatch macro warnings
Date:   Thu, 12 Oct 2023 16:29:04 -0700
Message-ID: <cover.1697152251.git.soumya.negi97@gmail.com>
X-Mailer: git-send-email 2.42.0
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

In the driver staging/rts5208, checkpatch.pl warns of possible precedence 
issues in the header rtsx.h because macro arguments are not parenthesized.
This patch set handles the respective macros differently(as needed) in 
each patch to fix the warnings. Patches can be applied in any order.

Soumya Negi (2):
  staging: rts5208: Refactor macros to static inline functions
  staging: rts5208: Remove macros scsi_lock(), scsi_unlock()
---
v2: No change since v1. Resending patch set because the patches were not 
delivered correctly on first attempt.

 drivers/staging/rts5208/rtsx.c | 24 ++++++-------
 drivers/staging/rts5208/rtsx.h | 66 ++++++++++++++++++++--------------
 2 files changed, 52 insertions(+), 38 deletions(-)

-- 
2.42.0

