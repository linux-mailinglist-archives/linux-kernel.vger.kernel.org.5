Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7889376F350
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 21:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjHCTSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 15:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjHCTSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 15:18:33 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8D43588
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 12:18:32 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-63cf4827630so7273116d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 12:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691090311; x=1691695111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ts6rrtwhBM2kYXMJoEZ7KylMiXLVCmUPUbMXJv/yhU=;
        b=fTqyalQenUN1t45e9GTCSvQ8TWEj8y18XgWwBIYXB3+kyZHWijF1OiWlajlarNFKCk
         8DAVjj+eExSg7xLd5z8BCTwBEoPaEUb5/UrAWy3Wwk35ol8RQEfa16xf5TIXv65+tqJm
         GxBNRxIJ/O1/SW1unMSRY8SM9LQUKJ/vb+lrW7Asz2ORs/VhYMT+R5twogtXZ8ZWlcbd
         Uq7X3mmuI9Vuc+gbQ2/rvgYPLw//Xm/es1tfAXWfuGuVu+rc7n5dt6y2nmjm4mJpyzRC
         2oMg8ADLKeBKmGATsAue2GDaKmk+NJIEiOvzynXrw0KytpH2j392DCfXPKyvxyBQNkOp
         pJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691090311; x=1691695111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ts6rrtwhBM2kYXMJoEZ7KylMiXLVCmUPUbMXJv/yhU=;
        b=LR1mLPrEgpo+d7oDsCO0wmbu8l+bUJWnwKx9Rx9NnVmeQ8vXvlCHXOAsW0hBRqWD5/
         /3PDwdaU/rpf4+OsXkUHchJ8g5xXn3FfwJ9A3+mfHOXiLzUfdPM93v1L7Pjfhr2wVVUY
         mG+OMnahZtYjuMze31kjW6fLOQRTYTgnnNMNy2m+Suddw9I+kPbzteysKDsp2Y+oU8TI
         +5DV5BibwtfPFbRFvjRYmGg1NtYUW2GcCqnViM3L637q3dN10be+x51s6HnHJLUIaAAc
         89OHLl2PfPenq+G48nmLfwe98730I6w6irQqVMa2BIZl2XCjxDjD8KXR9ySy3WBykBU8
         SdhQ==
X-Gm-Message-State: ABy/qLZYmauZ+bo03JQPkiIpA9IlDoViv+zvkRUgoOJxaQGqQYc05+w1
        Tiz+rxprbTBp0ha75l17pX2HPRzfcMA=
X-Google-Smtp-Source: APBJJlFAfKFMamd38vA4pGHTVaEbttFOnWJ4f/GCBc6pgk8vkFMmpPu0rakJapwMeXtO0xcbUac4dw==
X-Received: by 2002:a0c:b3d8:0:b0:63d:3bde:658e with SMTP id b24-20020a0cb3d8000000b0063d3bde658emr16280469qvf.42.1691090310678;
        Thu, 03 Aug 2023 12:18:30 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id n20-20020a0ce494000000b0063762ab2f90sm108897qvl.83.2023.08.03.12.18.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 12:18:29 -0700 (PDT)
From:   Trevor Woerner <twoerner@gmail.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] general defconfig cleanups
Date:   Thu,  3 Aug 2023 15:18:14 -0400
Message-ID: <20230803191821.36793-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.41.0.327.gaa9166bcc0ba
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

Drop config options from defconfigs whose code has been removed.

Trevor Woerner (4):
  arch/arm/configs/omap2plus_defconfig: drop removed options
  arch/*/configs/*_defconfig cleanup: drop CONFIG_IP_NF_TARGET_CLUSTERIP
  arch/arm/configs/*_defconfig cleanup: drop CONFIG_USB_MUSB_AM35X
  arch/*/configs/*_defconfig cleanup: drop CONFIG_NFT_OBJREF

 arch/arm/configs/keystone_defconfig        | 1 -
 arch/arm/configs/multi_v7_defconfig        | 1 -
 arch/arm/configs/omap2plus_defconfig       | 8 --------
 arch/loongarch/configs/loongson3_defconfig | 2 --
 arch/mips/configs/ip22_defconfig           | 1 -
 arch/mips/configs/malta_defconfig          | 1 -
 arch/mips/configs/malta_kvm_defconfig      | 1 -
 arch/mips/configs/maltaup_xpa_defconfig    | 1 -
 arch/mips/configs/rm200_defconfig          | 1 -
 arch/powerpc/configs/ppc6xx_defconfig      | 1 -
 10 files changed, 18 deletions(-)

-- 
2.41.0.327.gaa9166bcc0ba

