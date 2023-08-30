Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4648578DE69
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241496AbjH3TC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243688AbjH3LaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:30:04 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3227D1B0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 04:30:01 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31dca134c83so2748967f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 04:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693394999; x=1693999799; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HeVnp6+dMLCahTFEnv2mqRZRz0x2Xyv/+Cdn1caRov8=;
        b=dY4QeMU8lTZI6ynDaXwNXk0VmQBzdBVAzs/I3P6o/VmYmC+allarbNwjNcxbRNeLR0
         Q78fIE2STET3GQpZA9fJuR/UcSKXPA4TYsoYYZvx6h+5PEVhTNiyR1zQT1eca7lN0OEr
         D3yN7y1cDGbEUiXi53JWNEQhn0xznv+JLmd7ccpSw5wbyksToZx4at7Q6JUiXPkyYEMq
         cuCXF/fbKZtRrhH32R6L02GuWUh6UIGAId6m9x9tjFB3lKV8Zo4wwQrRw1Wd2qGNaDO0
         nG1Dmp2H3F03duwZC72HsLmQst161OyXr59JNlQy2wvrE+zlh6YOY5kXXgsBlYgBu4Dp
         CXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693394999; x=1693999799;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HeVnp6+dMLCahTFEnv2mqRZRz0x2Xyv/+Cdn1caRov8=;
        b=CZq/0w8rrXZZR2FAo5sn+eu2Z5aFmDhuzjXnDmT30MHMUjEtYif8pP9Z7N+31hFHzD
         DZp9OYVUz5jnLEMPopqG0iEZovpayJtubDmQAfUF8m3nDUksHOcODVXkSyNF9+lG57C5
         3bLOAzJuJTF8FwwwIhbnDNIrqNNlPqtAriRtMuuWKFCsbRdyQuHH4cesCcsPxYNpaDwQ
         XWy1/Jwlqk6sYvNe/OYYlBlF0skBI1KWEYRoZR6AXEzyyHUdk5sq+mM78+V3RS+vc2H7
         oduyhtbcpuZDua19LJDaXCFW1RCaHGgJif1DMax7oCzXHqJg4pElpTOkxrBNA3EeGqv8
         wjmQ==
X-Gm-Message-State: AOJu0YzOj/cPIEnLCLwykCUUwbsC2TqHz3e8ajKD17YKBbcHMTtxG4ui
        9WBzgEmy7DEDr2feSdNMTd2pIA4r4s1gGw==
X-Google-Smtp-Source: AGHT+IGyoO44Uu/f7TuIuGzv0Vb43TqZU+jGwsOABGqlgchMxzq3Xguj5jA+dX0NyTf8Pn0T7/S9hw==
X-Received: by 2002:adf:fd0f:0:b0:31a:dcfa:c6bc with SMTP id e15-20020adffd0f000000b0031adcfac6bcmr1501071wrr.32.1693394999377;
        Wed, 30 Aug 2023 04:29:59 -0700 (PDT)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id f17-20020a1c6a11000000b003fed8e12d62sm2017759wmc.27.2023.08.30.04.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 04:29:58 -0700 (PDT)
Date:   Wed, 30 Aug 2023 12:29:57 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee@kernel.org>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        regressions@lists.linux.dev
Subject: mainline build failure due to ace6d1448138 ("mfd: cs42l43: Add
 support for cs42l43 core driver")
Message-ID: <ZO8oNb2hpegB6BbE@debian>
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

Hi All,

The latest mainline kernel branch fails to build alpha, csky and s390
allmodconfig with the error:

drivers/mfd/cs42l43.c:1138:12: error: 'cs42l43_runtime_resume' defined but not used [-Werror=unused-function]
 1138 | static int cs42l43_runtime_resume(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~~~
drivers/mfd/cs42l43.c:1124:12: error: 'cs42l43_runtime_suspend' defined but not used [-Werror=unused-function]
 1124 | static int cs42l43_runtime_suspend(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~~~~
drivers/mfd/cs42l43.c:1106:12: error: 'cs42l43_resume' defined but not used [-Werror=unused-function]
 1106 | static int cs42l43_resume(struct device *dev)
      |            ^~~~~~~~~~~~~~
drivers/mfd/cs42l43.c:1076:12: error: 'cs42l43_suspend' defined but not used [-Werror=unused-function]
 1076 | static int cs42l43_suspend(struct device *dev)
      |            ^~~~~~~~~~~~~~~

git bisect pointed to ace6d1448138 ("mfd: cs42l43: Add support for cs42l43 core driver")

I will be happy to test any patch or provide any extra log if needed.


-- 
Regards
Sudip
