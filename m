Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3F37F3E6C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 07:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbjKVG4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 01:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjKVG4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 01:56:31 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5D619D;
        Tue, 21 Nov 2023 22:56:28 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ce95f96edcso30481615ad.0;
        Tue, 21 Nov 2023 22:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700636188; x=1701240988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfCjvC2TiWoEcnFFsAker1RGmc2mHOdv8vnoegXp8pA=;
        b=VLzm8hXWhrTGzMGG15zNvafELtMzKowuk/4vkj7qyxoL2ktyRF2XLJOYK7PtWMMvUB
         1T9AXpZDTvhUXlfkRqeWes3CGGPTp7VUvjzMNd/bKEBrm5BAYhsZ8FIyBKwuRXWo0kiU
         ZWuoKRhh06XaQNcKXKq4hVdUHAtPC7zPqGL5QN1A86TYY1MPG12C/zG6nC8WE4pAmVVZ
         Bp0i4R3Bbv46z0nDVxmEBxwVmuay4Pc4MXdHBQZEkrsUm/LsOfcqAYcyPIQqFd2HjCER
         t1KeYBJFBhe0YcGkJT/dW4P4NiQi5LLeO30tG7g1CCw9l/do8A+1HSPGbuf8ztRZWSSu
         UEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700636188; x=1701240988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZfCjvC2TiWoEcnFFsAker1RGmc2mHOdv8vnoegXp8pA=;
        b=AXB7AlmLtqtV6TKGyzPv7I5D6VjpzV5eYmEbiJf7xDID+RTJaOLn6oc/JQ0iUUBwVK
         SaTV93Vpf0imyKOpo+P1gZahKkAWO+6dzfBLyCOUi785EkWsYFRTspyYpmmQ4Pah/k/v
         wq4Wy0FjACsgwfYjEXEVmr9BYF9wI7j8Zo2nwAT4rX4h0298fvtbqBuQSVVp+Rd6OPjt
         rbUjV2L0r6hhU7Q2JAvaLnS6iZhWIfDuAOoKKHaeqWyn+2FdCpHOfeNIbTE75fDarphq
         CzTU9w7fIUPqnYI4XM1oaGTw/AzZqMF49fKj0swsddHvm8PlV1ZLRpm4/a9V8Qe5s3tB
         tOaw==
X-Gm-Message-State: AOJu0YxnT79KXLaUs/1fljbgbSi5hlGKRri8M4bgvA2hkhCRoI6lZ50f
        j6+3SctAHg4OsSND8JQ+I2w=
X-Google-Smtp-Source: AGHT+IHyXD7cyOCyvFGffOiU+mxSyt3lsfgKaW4XR9Jc9UyG9//r+jDsqpOFjPxfu1EICvKOAMdEFg==
X-Received: by 2002:a17:903:41c1:b0:1cc:665d:f818 with SMTP id u1-20020a17090341c100b001cc665df818mr1280698ple.68.1700636187631;
        Tue, 21 Nov 2023 22:56:27 -0800 (PST)
Received: from localhost.localdomain ([110.46.146.116])
        by smtp.gmail.com with ESMTPSA id x15-20020a170902820f00b001cf51972586sm701175pln.292.2023.11.21.22.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 22:56:27 -0800 (PST)
From:   SungHwan Jung <onenowy@gmail.com>
To:     "Lee, Chun-Yi" <jlee@suse.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     SungHwan Jung <onenowy@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Add support for Acer Predator PHN16-71
Date:   Wed, 22 Nov 2023 15:55:31 +0900
Message-ID: <20231122065534.3668-1-onenowy@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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

Changes in v2:
- fix typo
- remove redundant "if" statement

SungHwan Jung (2):
  platform/x86: acer-wmi: Add platform profile and mode key support for
    Predator PHN16-71
  platform/x86: acer-wmi: add fan speed monitoring for Predator PHN16-71

 drivers/platform/x86/acer-wmi.c | 364 +++++++++++++++++++++++++++++++-
 1 file changed, 363 insertions(+), 1 deletion(-)

-- 
2.43.0

