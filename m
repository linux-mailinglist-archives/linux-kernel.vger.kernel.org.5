Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A96780EAD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378023AbjHRPLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378001AbjHRPKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:10:46 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D264E5F;
        Fri, 18 Aug 2023 08:10:45 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-76ce59842c1so63684285a.3;
        Fri, 18 Aug 2023 08:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692371444; x=1692976244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8zlnhq/o6XGARx6DO7O3eaqh/jbqXpWn/QZriO8og2g=;
        b=eDdwRUTO1jWRmsE2BqB7+QMWK3IdPtx4VRGUmDiF82KIEZBGWio4XmWQRkQDHdrvne
         ASG0lb83hW23/QTnMVGnk44+A4vi9yJZ8FGdEXZfvuc1Fab3qeBGtHO4RVs2y6Vu4p/2
         RAn+hbQCaX8rhNXo+TscsNYog5ECcDtHlIDDW7aqtQW7FTbg/MbupHCCbE/ynv5ycz5Z
         fUThx+hxySpuy3UL0IYNEk2peNEzYxDNPPZdq8hp6+DGLZiJnxfQUo3GpbkkV9umfoo6
         Xy8/mkIdQtXYrsTMDnhS6nWfgo8RhGIHbnmBk/bHXBm4Fc5OaCU/86qHzUz9QAb+Oy+Q
         b8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692371444; x=1692976244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8zlnhq/o6XGARx6DO7O3eaqh/jbqXpWn/QZriO8og2g=;
        b=dyrASHWJpTopoy9zkMUBI/aOhG+A/fyXWDZiX6WH3l5ers6kw9qGCaxoWDdZnGwdR4
         Smvwodcb+GzV2sOWNaavQjNPFQraU8sLETLo+ZpvThs5C8DwevKWoUrdLi87jObSuyeq
         SWciBSUljxMJKc7LyxHbSbyuCFWQudLMTpGhRikDYUYZOsV2Y1DpXwwr7yaRRTTkI4u7
         o/reqrJLHZx7pPZYpuZhozt061Vu7TkaCWN2skd6J1cgrG6BcE26jFAoU2zLCYqH3z4s
         p6H7eccmt8hAwSQS5N3KYvOpMvnCtZhLtfg9Jw4g0Rl50fX+I86OrzEmEbrS5W47psrp
         yNBQ==
X-Gm-Message-State: AOJu0YzCh9VuEKK6x/5Dbpf3pAFS1WxOn+Fgl88pYmJFyBB8IuAIhqsB
        I7RqZ5rECPyYEIoWNGtoOXkTnrMw0yc=
X-Google-Smtp-Source: AGHT+IFn4a7uKtaUKYd7wjBmREXmoRTDHo4vsQ5SIcwUMjVIL3fpL/a3r5ea8S2fwpTus9cgAII+0g==
X-Received: by 2002:a05:620a:454b:b0:76c:5952:7317 with SMTP id u11-20020a05620a454b00b0076c59527317mr4050632qkp.3.1692371444492;
        Fri, 18 Aug 2023 08:10:44 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id w3-20020a05620a148300b0076cbcf8ad3bsm576239qkj.55.2023.08.18.08.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 08:10:43 -0700 (PDT)
From:   Trevor Woerner <twoerner@gmail.com>
To:     drew@beagleboard.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] pocketbeagle device tree updates
Date:   Fri, 18 Aug 2023 11:10:33 -0400
Message-ID: <20230818151039.40566-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.41.0.327.gaa9166bcc0ba
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

A couple device-tree updates for pocketbeagle:

1) Update the LED information (the LED on the pocketbeagle is blue, so
   correct the information). Also the "label" property is deprecated so
   replace it with "color" and "function" properties.

2) Remove a dependency cycle.

3) Now that mainline supports the PRUs via remoteproc, update the pin
   information to enable the PRU pins and set their mode appropriately
   as per the silkscreen.

4) Add a missing mode setting for a GPIO pin.

v2:
- update the patches to remove the pinctrl-0 property early in the set
- patch 2 is new, patches 3 and 4 adjusted accordingly

Trevor Woerner (4):
  ARM: dts: am335x-pocketbeagle: update LED information
  ARM: dts: am335x-pocketbeagle: remove dependency cycle
  ARM: dts: am335x-pocketbeagle: enable pru
  ARM: dts: am335x-pocketbeagle: add missing GPIO mux

 .../boot/dts/ti/omap/am335x-pocketbeagle.dts  | 62 +++++++++++++++----
 1 file changed, 49 insertions(+), 13 deletions(-)

-- 
2.41.0.327.gaa9166bcc0ba

