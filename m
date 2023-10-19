Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521807CF4DB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345203AbjJSKON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345039AbjJSKOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:14:11 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8ADAB;
        Thu, 19 Oct 2023 03:14:09 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4083f61322fso11861985e9.1;
        Thu, 19 Oct 2023 03:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697710448; x=1698315248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IGUCtaetBy4DTIj7ObfcLLLAyE9bn8S8QtM2xGRSe0M=;
        b=JVbdojPWtVN063RMLzfL/gFjF1t4T3dkK4CqwgluozovFS5JXcFSnzddmc1HHuQ5GO
         gDf/Akgeh6jnAFKVd28jF9m0YkquBndOkYGLVJCtCCOJu8yO29Zulpg9bUp6eCZ5I+7F
         0ZyosdaajNcSn6ZLiM/6C+H2yQHEAJuSJT4/6UXXEMw/9td0zykNqTWbg466B04tKFPs
         F3aYVKXEvzDn10gNX89vIQv6GnpRQMnRb9jBDOYKU0VGj5SZzNx0Ncb6YTXJOD74wtza
         re0F+QKc/lsC2FjMNLYMN9MrnuJdXlTMQ2MuMItJQz67woNMnPa7kzuV+lh3H9nyMdyQ
         ep5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697710448; x=1698315248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IGUCtaetBy4DTIj7ObfcLLLAyE9bn8S8QtM2xGRSe0M=;
        b=O/9wDJe1U5Rl14YtI4O/glW1rhFswhy+lf6HwXyZm6BEGVjxmHHegM137jA7ITsbRM
         LV9DLHnedqoe92VuLJcSENZpetHgl2HpePxFiGttEZBUfzvOCdIHYEmvoDd2Ql0CZLYe
         odbxFIKihZKcWELG3E3LhF/GdS9LSUZwRYEKWhih9JYcpdRn92ibNRKvO9RXQebBL80f
         F9GR4BRoU/Uv3Vs+TmkPliUEa0qPk7cxEt9kO9oRGvJgprAKzCEm8AreQpdV3fI/0X0Q
         6JxQEWFMpHq39Y5K4ATzI7hNChOLvLksfPnXDrSr0oBZthw9l7ZzYTOB/I5wcCKkX6Lz
         Fu/g==
X-Gm-Message-State: AOJu0Yz9Tlfqv/SOJ83d2R4b5ytDYumS+pMi1SWVf5PkN7aC6g9kklsz
        xYpmIFlsPhPWi5GTvJId4A==
X-Google-Smtp-Source: AGHT+IHzEjL2ZofK/ahM41KnEDz2FgNb9Vtr//9lYhRkMtUZitajDwzkRFkzi1Y0FLbZVt3K6x+4uw==
X-Received: by 2002:a05:600c:a07:b0:408:3f64:6553 with SMTP id z7-20020a05600c0a0700b004083f646553mr1397018wmp.16.1697710447394;
        Thu, 19 Oct 2023 03:14:07 -0700 (PDT)
Received: from dorcaslitunya-virtual-machine.localdomain ([105.163.1.8])
        by smtp.gmail.com with ESMTPSA id l32-20020a05600c1d2000b00402f713c56esm4109300wms.2.2023.10.19.03.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 03:14:07 -0700 (PDT)
From:   Dorcas AnonoLitunya <anonolitunya@gmail.com>
Cc:     anonolitunya@gmail.com, outreachy@lists.linux.dev,
        julia.lawall@inria.fr, dan.carpenter@linaro.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] staging: sm750fb: Remove unused return values from functions
Date:   Thu, 19 Oct 2023 13:13:35 +0300
Message-ID: <20231019101348.22076-1-anonolitunya@gmail.com>
X-Mailer: git-send-email 2.42.0.345.gaab89be2eb
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modifies the return type of different static functions to void and
deletes unused return variables as the return value is being ignored 
in all subsequent function calls thus not useful to have a return type.

This improves code readability and maintainability.

Changes in v2:
- Ammend wording in cover letter.
Suggested-by: Julia Lawall <julia.lawall@inria.fr>
- Drop variable 'ret' entirely as it is unused.
Suggested-by: Julia Lawall <julia.lawall@inria.fr>, Greg Kroah-Hartman
<gregkh@linuxfoundation.org>, Dan Carpenter <dan.carpenter@linaro.org> 

Dorcas AnonoLitunya (2):
  staging: sm750fb: Remove unused return value in
    display_control_adjust_sm750le()
  staging: sm750fb: Remove unused return variable in
    program_mode_registers()

 drivers/staging/sm750fb/ddk750_mode.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

-- 
2.42.0.345.gaab89be2eb

