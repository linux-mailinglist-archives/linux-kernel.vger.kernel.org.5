Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DEF7E84D9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 22:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345964AbjKJU5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235747AbjKJU5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:57:22 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C92250B9;
        Fri, 10 Nov 2023 01:50:15 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5446c9f3a77so3152146a12.0;
        Fri, 10 Nov 2023 01:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699609814; x=1700214614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oJNlMvbde7lnPoy+KN4RWxD1Ppfgvo+k6ZiBdq4htqI=;
        b=S03Im9IXa8GGVHxfJvQ8b6p8t26OulL+PDkX41J7zjZwM2hDuIcuG1SFAnAdhOeaH7
         3E3zcWYUkRfIm1q3UhNQClLFhwb95YbtzQuT6uLB7D2aCdlCmFhPlHaneJMdMv1SJTqi
         qqp08XvcpuHW9v3bkbODoA68PlzyQRpU0qWregsYv0Ce0khqbhdQ/EUb9V22xRgc70je
         XObxsOtVeaMII3Ff/eKZZkc/vF+JYJ18QpP+LPE4ernYUwFj1nND3wjRgVZIRF2ljFiU
         y9HHR/PFLgly7MO/j/OmM4UzDUnhFan8Us6OmwpGoPYRKgtjas0Ap+u98M7/JjcwvtzE
         fQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699609814; x=1700214614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oJNlMvbde7lnPoy+KN4RWxD1Ppfgvo+k6ZiBdq4htqI=;
        b=aZ/mWYErsKrOtvuYYVy9fiSFjvCZoVON+RFmPxaAMP/pLEFb7VKlEXKpHisi7VKau6
         xqbJeAg+HNG5ttNpwzZk3u4+HNO6YlWBrnDPDFDXICBYEg3Zh7rVs3a/tl6V8IQW1OCB
         fzX0PX/XTcv2dGG7WfdOsDRgDchguQmHeEXF6O+j7maLRem2h2lrYggm2aMwzIhBfYrU
         yA/pRnz2HvTx9b9HFZJWerVl8Q7+ica9FqHn5qO6A3q/G378cZL9RYDoqFWmGaTM/I66
         0N4uDcxgr51smFO90sjuMz0tVm51h62NVBm3NSpvV6tWx0SVxifHUANNCHaEHaOL7B29
         PsbA==
X-Gm-Message-State: AOJu0YychDnUfqZB0bVSKTWaoWf7TUt9VCyVAjT5yG64E2BGcIRT5ZNo
        wH49A7GRQKUYXAP+uW/eFx4=
X-Google-Smtp-Source: AGHT+IGAfVXOwoHXM1HDmbp7yJAOb44BosarbcsCmEb1AH0XKxg6Z2ED04RDg+geXGJLVJrS+07BRQ==
X-Received: by 2002:a17:907:9384:b0:9e4:651f:60d0 with SMTP id cm4-20020a170907938400b009e4651f60d0mr3532024ejc.9.1699609814123;
        Fri, 10 Nov 2023 01:50:14 -0800 (PST)
Received: from localhost (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id cq4-20020a170906d50400b009e5f2e02e68sm803707ejc.222.2023.11.10.01.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 01:50:13 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Fixes for v6.7-rc1
Date:   Fri, 10 Nov 2023 10:50:08 +0100
Message-ID: <20231110095013.655597-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.42.0
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

Hi Linus,

The following changes since commit 40592064a1a536adcced4ffea435c392eb9e7192:

  pwm: samsung: Document new member .channel in struct samsung_pwm_chip (2023-11-03 12:00:41 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-6.7-rc1-fixes

for you to fetch changes up to d27abbfd4888d79dd24baf50e774631046ac4732:

  pwm: Fix double shift bug (2023-11-10 09:20:55 +0100)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Fixes for v6.7-rc1

This contains two very small fixes that I failed to include in the main
pull request for v6.7-rc1.

----------------------------------------------------------------
Dan Carpenter (2):
      pwm: samsung: Fix a bit test in pwm_samsung_resume()
      pwm: Fix double shift bug

 drivers/pwm/pwm-samsung.c | 2 +-
 include/linux/pwm.h       | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)
