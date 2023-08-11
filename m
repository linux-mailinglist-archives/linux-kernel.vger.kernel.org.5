Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C668F779750
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 20:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236383AbjHKSu4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 11 Aug 2023 14:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjHKSuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 14:50:54 -0400
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0066E30E7;
        Fri, 11 Aug 2023 11:50:53 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-56d0deeca09so416391eaf.0;
        Fri, 11 Aug 2023 11:50:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691779853; x=1692384653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oubcwLdsx0/fnNdV78/C9MK8J3iL+g9Bj5rYT38DsAA=;
        b=l+1l/ke3QDbyuuq6UtlHUTnNxv1+LDTyPOX/JTSLmf3STcwn2ADMWvAF20y+6oD4eA
         JA/qhm8ov3IPrOhAsXfjAQBaHQcZuGsGCxab6HnIpj0OHbSYzRuoxL6YD105Lgexky4P
         hBtXm0eRfublqFFe9nDBjbXrYUyxM3+Pwm+0TLbhbxDeBjSWOazzC60+ufk5sbpPCCP+
         vitOiE3L/FC5V2M2eb+C4EXR2oKGIEyacS/TudLGGcgQUbtOKzgmHTWWfaM2LgTqdETN
         CS9iU3stf0er//JXQwU2SH0aLMCf0L95sukF8oKoDTVMOwLSg0+u2FhHNsxXvDwkM7jA
         uKbg==
X-Gm-Message-State: AOJu0YzU6WujHMU0UM5JG2PUjNiHqqmWR2GFGjY+aOhE8Q99zHeW/jej
        ORJ/UD55E/RmWXkyv95h1YdiY0f6X5IDk4q87aIAjwn3SK4=
X-Google-Smtp-Source: AGHT+IF8EzaBNGHBDiovrCMAMfG1dr7TSb78qimtM95NkvEKZVJhCmTZcQ8j9V/l69YzRILHr6R/wTht+b+wk3ny068=
X-Received: by 2002:a4a:e04e:0:b0:569:a08a:d9c5 with SMTP id
 v14-20020a4ae04e000000b00569a08ad9c5mr2274451oos.0.1691779853073; Fri, 11 Aug
 2023 11:50:53 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 11 Aug 2023 20:50:42 +0200
Message-ID: <CAJZ5v0jsb8ezbg9P_HqgY2Q8UqEwRuMUMs=COyiAF-carAYQJw@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v6.5-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.5-rc6

with top-most commit 4778e1288447d9f90d87df07d195dc89e290d973

 Merge branch 'pm-cpufreq'

on top of commit 52a93d39b17dc7eb98b6aa3edb93943248e03b2f

 Linux 6.5-rc5

to receive power management fixes for 6.5-rc6.

These fix an amd-pstate cpufreq driver issues and recently introduced
hibernation-related breakage.

Specifics:

 - Make amd-pstate use device_attributes as expected by the CPU root
   kobject (Thomas Weißschuh).

 - Restore the previous behavior of resume_store() when hibernation is
   not available which is to return the full number of bytes that were
   to be written by user space (Vlastimil Babka).

Thanks!


---------------

Thomas Weißschuh (1):
      cpufreq: amd-pstate: fix global sysfs attribute type

Vlastimil Babka (1):
      PM: hibernate: fix resume_store() return value when hibernation
not available

---------------

 drivers/cpufreq/amd-pstate.c | 10 +++++-----
 kernel/power/hibernate.c     |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)
