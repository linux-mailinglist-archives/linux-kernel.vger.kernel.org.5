Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41E17CB464
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbjJPUPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjJPUPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:15:07 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB3DA1;
        Mon, 16 Oct 2023 13:15:05 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso873104966b.2;
        Mon, 16 Oct 2023 13:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697487304; x=1698092104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FRniKyUz9iHO7Fz4n7LlSe4JaoEPWk/8N3r3s0S38yc=;
        b=UrS2WK899aTYX/5/k5bWoihbwZfs8AHdyNi1GfDzBaj0X4rD7342Zq3n0J2uKy9h6c
         3ZxP6e+DpXxLPKIOjI8uTdtBJzsjQDi6SzOB/YDjy4F4mf2KYz4sqAjHOGiwxjbe5E59
         5Kf3RC4wmQNeZ+q4lzwArvdqtMBQOEjsb4djbOJlGko+JrBvxAcnlqj45VkD+5egp/LY
         yZYQOZBge2rcHcmJORLvoCu9ob+wxjBb0jw686plrgeVBWythR7KaNMXppos1gHz/4KW
         ufuv7g2AwT7ZRVrxMZkW7jEScUKer+7+iK+4csIb4YMF2gjW6IFiZ2m/j0dROeQx5hv4
         pF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697487304; x=1698092104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FRniKyUz9iHO7Fz4n7LlSe4JaoEPWk/8N3r3s0S38yc=;
        b=VLCIceJla5zYzuDeFptg6n18kfTnnhnEa7//IrqZwnmVc2vVy50N9XbrIGsH2IfJ6L
         4wF/32K9N4bHQZ9ULIilSVxyYuFYP3MUQha5oR7hXd+MfRqeoIS6pOtbQJiC087WLLdA
         AZiEyZinQ0lPp8ttz/C1nKKGrNFUZeKqLS6+qoWJOa2goVfHy89xFpFfcp51ErT+QoW0
         Hwx/mWE17Je6U0hQPn6UcYeY5ySBhSBJAl2mAAVcWxv9D8h5wxYOjj7ShU/lwXZybEKg
         avLey1GvCeazIu0rVeizKlDIx1/gn8gGFXIQqEhYG1WMYP4fyA4icyTwSS+5mE0+fYOj
         Z28Q==
X-Gm-Message-State: AOJu0YymmWINBPWsW9g9jMyL2gJhSDiqBnQrn/az8XzHA6Fa+03aHtkJ
        BldMcM7im2fMHwj7th/Ep4UQYnRolN+S5xU=
X-Google-Smtp-Source: AGHT+IFqWbp0v+lRnIYAfoA8RbKDtJE6+FBX4X9Kzec6bIIB2oZpNU94+sLO+oRr4pQMPO6v2uYU3w==
X-Received: by 2002:a17:907:6d1d:b0:9be:5ab2:73c2 with SMTP id sa29-20020a1709076d1d00b009be5ab273c2mr104647ejc.58.1697487303797;
        Mon, 16 Oct 2023 13:15:03 -0700 (PDT)
Received: from dorcaslitunya-virtual-machine.localdomain ([105.163.1.143])
        by smtp.gmail.com with ESMTPSA id u26-20020a17090657da00b009b97521b58bsm4606055ejr.39.2023.10.16.13.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 13:15:03 -0700 (PDT)
From:   Dorcas AnonoLitunya <anonolitunya@gmail.com>
Cc:     anonolitunya@gmail.com, outreachy@lists.linux.dev,
        julia.lawall@inria.fr, dan.carpenter@linaro.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] staging: sm750fb: Renaming camelcase to snakecase
Date:   Mon, 16 Oct 2023 23:14:07 +0300
Message-ID: <20231016201434.7880-1-anonolitunya@gmail.com>
X-Mailer: git-send-email 2.42.0.345.gaab89be2eb
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renames various function names and variable names that were previously
in camelcase to snakecase to ensure consistent naming style throughout.
 This issues were highlighted by checkpatch.

Dorcas AnonoLitunya (5):
  Staging: sm750fb: Rename displayControlAdjust_SM750E
  Staging: sm750fb: Rename pModeParam
  Staging: sm750fb: Rename dispControl
  Staging: sm750fb: Rename programModeRegisters
  Staging: sm750fb: Rename ddk750_setModeTiming

v2: Ammended wording in commit messages for all files. 
    Suggested by Julia Lawall <julia.lawall@inria.fr>


 drivers/staging/sm750fb/ddk750_mode.c | 90 +++++++++++++--------------
 drivers/staging/sm750fb/ddk750_mode.h |  2 +-
 drivers/staging/sm750fb/sm750_hw.c    |  2 +-
 3 files changed, 47 insertions(+), 47 deletions(-)

-- 
2.42.0.345.gaab89be2eb

