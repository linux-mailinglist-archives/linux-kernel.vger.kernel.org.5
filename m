Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1497B7FF0C7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345722AbjK3NxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345662AbjK3NxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:53:12 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FF5194
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:53:18 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40b4746ae51so8037175e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701352397; x=1701957197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jh01jv92hxeQFdKwnZ6tYuBVwpT7Eew4yFfGBZjUiwI=;
        b=cy/xbd0J8scSqM4Wu2X/KNDq+OMGyhyXP+JvQ/wz3+aTupNXx2tQ8SAnzP2vf4Ecvv
         kanllvimBLsRhaEtroyFnZ41sCEs2mT2OMXei7Lu1VRPLBcqoSjvcSByE+Z/Ea6E5cJT
         CoBirg7AVmaO6GFCR5sAuFdGN2sXeurSjjiIhoFxIk8vLo0WT6gS2IJwLfjS9r/yiomJ
         KSxAwX6trlB9KcAwXX6r1KJWOcqy4YcIMbGClCwVG5ti/Q/wDv2UttKQ0EfSTmrxVJdO
         gJaOvlUULN2bsDkRwm/qzvcqYOt35JYITM7vHmbUXwoFWJp7csUo7h7MJr6s95GFFj2v
         Y90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701352397; x=1701957197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jh01jv92hxeQFdKwnZ6tYuBVwpT7Eew4yFfGBZjUiwI=;
        b=ZMMXIWNRKUlN/KCkXP6FGW2MFoVJW4MFwhXEJYCgxQew7BGDT4/knSFm/Y474kTvYQ
         mhK24+l9Osx283ILGJUUMK75XdysQIs8++wFSiQRKPwNDGd+Pz59UTJ/rN3R4IMaxHBa
         b60lG8Cq4A/5UMG5SLU872vGExIsGToD+Yt0WqYspJXDUgzHheEgMbc3jfHlGWH0YuQz
         bFrOcVFksqEo+nfMAyGZEDeB+5Pkla5vxJK/KdIcixtUSlr3pPpDnKTqr+rVSCq6Tyju
         7OQOvhE4oMq5Y9YJwNqWdRNBTM87LmlcZDPNN3m5kKoLjiEyYRsI27Nvli6m3kBAt2cd
         sTVQ==
X-Gm-Message-State: AOJu0Yx7QwQnfV2eSWBvmdkVrC7RvNuOxhm+UY/TQjN7BzZb4qbm32X6
        /hYL2VJEs4naGytX6gqe4wY=
X-Google-Smtp-Source: AGHT+IEF976W9C+TBiINnApwLKXkdnrj1vWlz3AoB5Xf89Xl5UkupYolRD853hMk18dqa8um34bxgw==
X-Received: by 2002:a05:600c:510f:b0:40b:37ec:41b3 with SMTP id o15-20020a05600c510f00b0040b37ec41b3mr16234824wms.31.1701352396704;
        Thu, 30 Nov 2023 05:53:16 -0800 (PST)
Received: from mfe-desktop.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.googlemail.com with ESMTPSA id d9-20020a05600c34c900b0040b2c195523sm5864573wmq.31.2023.11.30.05.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 05:53:15 -0800 (PST)
From:   marc.ferland@gmail.com
X-Google-Original-From: marc.ferland@sonatest.com
To:     krzysztof.kozlowski@linaro.org
Cc:     gregkh@linuxfoundation.org, marc.ferland@sonatest.com,
        jeff.dagenais@gmail.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] Add support for the ds28ec20 one-wire eeprom
Date:   Thu, 30 Nov 2023 08:52:27 -0500
Message-Id: <20231130135232.191320-1-marc.ferland@sonatest.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Ferland <marc.ferland@sonatest.com>

Hi,

Here is v3 of my ds2433 driver patch series, see [1] for v2.

Changes:
v3: Do not use in-reply-to when sending a new patch series.
v2: Incorporate suggestions from Krzysztof Kozlowski: drop the 'w1:
    ds2433: rename W1_EEPROM_DS2433' and 'w1: ds2433: rename
    w1_f23_data to w1_data' patches.
    Create a separate patch for the validcrc bitmap change (also suggested
    by Krzysztof).
    Fix build error: initializer element is not a compile-time constant.
    Rework the ds2490 patch and remove the ds_write_block changes: I
    have no way of reliably test this change with my current setup,
    and I did not experience any write failures. Let's not try to fix
    what already works.
    Rearrange commit order for a more logical order.
    Tested with the ds2433 eeprom.
    Rebased on v6.7-rc2.

[1] https://lore.kernel.org/lkml/20231127201856.3836178-1-marc.ferland@sonatest.com

Marc Ferland (5):
  w1: ds2490: support block sizes larger than 128 bytes in ds_read_block
  w1: ds2433: remove unused definition
  w1: ds2433: introduce a configuration structure
  w1: ds2433: use the kernel bitmap implementation
  w1: ds2433: add support for ds28ec20 eeprom

 drivers/w1/masters/ds2490.c   |  25 +++++-
 drivers/w1/slaves/w1_ds2433.c | 161 ++++++++++++++++++++++++++++------
 2 files changed, 157 insertions(+), 29 deletions(-)


base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
-- 
2.34.1

