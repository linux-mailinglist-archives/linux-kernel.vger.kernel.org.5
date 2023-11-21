Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E676B7F36FF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 20:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjKUT7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 14:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjKUT7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 14:59:06 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D46D1A1;
        Tue, 21 Nov 2023 11:59:03 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cf57430104so22804485ad.1;
        Tue, 21 Nov 2023 11:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700596743; x=1701201543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ksp0gscyzTzv7gMh3uW3pYf1M1qB9WxVG6lkj3p63HM=;
        b=CM/mZjknIViX/zgRQ/yXGDzpVhg+HWiDybYc5GLlGGoExlAx644XNHKHvdmtCXDJF1
         GLVHFDuB+rQ+kh1UgT3RZeGZCaq+gxBAKxJ1I1vOae30TSOqSf+GtAwq2cDD+61j5wdC
         yYffl/wiWFge62NhZP0PK0YyurtIStWIukA29FeqqvO6FSoGx1icXotk7sRguNFfZCR/
         dL2CUKp8nY4OvrzC8zhUDErmCzM4d8zfdxy40moKnxzgSr5s5f8whrfjmUgTFuxT5L0e
         X0mP2WJ3DmEYmYt5AO9508yXHobhp99hB7ydE6Kyl1cgEEMXZ+2GE4qNXMVKiCN1O/vA
         VsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700596743; x=1701201543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ksp0gscyzTzv7gMh3uW3pYf1M1qB9WxVG6lkj3p63HM=;
        b=hDPczU8bnTjaNv8TjHJ4eoznx6BU7aai1x0YR2mvkU0Upggx67KDwH2b+cWO5F+YS1
         Q3ArVihlaKfaVkSZIR8uCNxNS7UugHnNt2zqb0jTmMMiQjnDNvjcc9H4O0uSJQTpv9O7
         S4nkJRyxdomq4IoJLsZkV08NOkdjDWECAqr+Bvc/w1pZp44+gxIxU3G6784nCMOnNAWG
         NwrFKPkTp2GSXZlvrUgFabnhTBVsx51JMZMN6LYhdw3CLEt+hgEKWPZnO/+h7Q0bT1AX
         6YnJ66IdiGZLBKGxycVxVQzdJaP0HN8dbkrKqI3mEyamCdzWR0LlQByUp/kr6cd9uThT
         bRQQ==
X-Gm-Message-State: AOJu0YyhdPAgukZL+9cBVyHKwVUg86WhtmXhPhX3I+qtGHYwNQ0th2ic
        emqv8NLYKbijPntocznzG9o=
X-Google-Smtp-Source: AGHT+IFQpNt6hsKsku/HQD+vPEIpWTeUotmIGn0u0JP+YIjmbDjqW2tJTUIerT5z8sVEwPDtXCmAZA==
X-Received: by 2002:a17:902:e88f:b0:1ce:654a:81ef with SMTP id w15-20020a170902e88f00b001ce654a81efmr217635plg.18.1700596742968;
        Tue, 21 Nov 2023 11:59:02 -0800 (PST)
Received: from localhost.localdomain ([110.46.146.116])
        by smtp.gmail.com with ESMTPSA id u4-20020a17090282c400b001cc615e6850sm8310732plz.90.2023.11.21.11.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 11:59:02 -0800 (PST)
From:   SungHwan Jung <onenowy@gmail.com>
To:     "Lee, Chun-Yi" <jlee@suse.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>
Cc:     SungHwan Jung <onenowy@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add support for Acer Predator PHN16-71
Date:   Wed, 22 Nov 2023 04:58:14 +0900
Message-ID: <20231121195817.18128-1-onenowy@gmail.com>
X-Mailer: git-send-email 2.43.0
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

This series of patches adds support for Acer Predator PHN16-71 in acer-wmi
including platform profile, (thermal) mode key and fan speed monitoring.

The acer-wmi driver already includes fan control and turbo mode support
for gaming laptops that use predator sense app (version 3), but PHN16-71
operates in different way with new predator sense (version 4).
To distinguish from implementation for previous model, new implementation
for this device is marked with "v4".

SungHwan Jung (2):
  platform/x86: acer-wmi: Add platform profile and mode key support for
    Predator PHN16-71
  platform/x86: acer-wmi: add fan speed monitoring for  Predator
    PHN16-71

 drivers/platform/x86/acer-wmi.c | 367 +++++++++++++++++++++++++++++++-
 1 file changed, 366 insertions(+), 1 deletion(-)

-- 
2.43.0

