Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B7780BCA6
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 20:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjLJTH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 14:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjLJTHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 14:07:55 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27C4ED
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 11:08:01 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-67abd1879c0so25474536d6.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 11:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702235281; x=1702840081; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=adzOKgwESdnl6ILP955Ezto6DuxWXcPvJ6gVSnWyjOY=;
        b=CRNSQcQVn9dw5MxK7EKgjMmhqnoS4PMdQjqcsZIZ96hJ5fPVGZXCVLVBvJLZ5NIDZW
         17QMle6ZodJpKdTukls9BCQdxjbq++nfmHOZftChPVfueLdSWHS/pPU4UA6jY1J5V4W+
         11DKqF8ytU0w0Eqx3H3yZIreVy18kN8VdL5eQTcrps4AKSFwt8Qbd3Qw1glkQk5JuKW2
         7/nlisq3hRYqXh2qElk6Wtjg/Tcid14J05SF1MFh60hnFdln/cwHP55Ffk9ZcJcRlwc0
         KMUDiF2u5+Xq/sWW2XqrQnW6cyrJoa0u/tuuAP6wS81EwUbZyqIB1O6ceomcR2Upa369
         6dkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702235281; x=1702840081;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=adzOKgwESdnl6ILP955Ezto6DuxWXcPvJ6gVSnWyjOY=;
        b=U3CppqmsKrVmJTssbnIPohuvMaLIcXzaT61HAoTVIaSXI2Xn6QZd5oSwWklIkYMzSx
         17lQWb56jRSmxxSBvwVqk4ax1WpvGOfsu8AFOFvfaxOdDyYYPHLltkRIADw4JAQUSaUZ
         hCfiedntqWitUAKZONVuDPhPjuOOesSEJiHyszqf+wl7GO888Ul4pD1hGEFfyvRQg8vN
         cNFn1i0RLDo0s1pVSIxDuaant5MUlmODPuT9RLG2ZeOYeCDL1u6HYkvFuzZpC0W4NEgu
         myASNz/ejvjbFiTsLZhXO2TpsITC6lPeDIvtIu2mx5/T77oWcjT9zRp6cixn6xp9VdpJ
         hCAQ==
X-Gm-Message-State: AOJu0YwgiFJuXCA+Ia+Lk9+tNbl4NlBzlhcxMDhPeuY6y7O2Z4S3Q5F5
        1E2L2RCH+VhjuvxM/mNjGQjRTRLQfuZtBQ9E8Jd37x0Wt88=
X-Google-Smtp-Source: AGHT+IE6MS1wEs0W4w2nTC2af13yLIF1lCTWdFUvyVc0XfXpi9pxAFEHKyGNCJEaoBN63KCDPDGwMu0cniSKkP9h4k0=
X-Received: by 2002:a0c:d644:0:b0:67a:bc4f:341f with SMTP id
 e4-20020a0cd644000000b0067abc4f341fmr4016993qvj.83.1702235280672; Sun, 10 Dec
 2023 11:08:00 -0800 (PST)
MIME-Version: 1.0
From:   Chris Rankin <rankincj@gmail.com>
Date:   Sun, 10 Dec 2023 19:07:50 +0000
Message-ID: <CAK2bqVLVfBOGcj326grzz2b2PMcTmuj44a5yhWh1H1Z9ch3JCA@mail.gmail.com>
Subject: Does 6.5 kernel require different userspace to 6.4 kernel?
To:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a truly ancient i586/UP/32 bit PC (for historical reasons) that
happily runs Linux 6.4.16. However, when I tried to upgrade it today
to run Linux 6.5.13, I discovered that both its console and its
networking froze almost immediately after it had booted. There is no
sign of any oops in any of the logs. My first thought was that memory
corruption had crashed the kernel, except that the SysRq interface
still works correctly.

The PC's userspace has not changed at all; I have only upgraded its
kernel from 6.4.16 to 6.5.13. And restoring the 6.4.16 kernel restores
correct operation. However, I cannot identify any clue as to what
could be wrong with my 6.5.13 kernel. Can anyone suggest anything that
may have changed between 6.4 and 6.5 that could be causing this
please?

Thanks for any assistance,
Cheers,
Chris
