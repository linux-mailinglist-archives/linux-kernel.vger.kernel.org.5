Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB76A7F9C25
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjK0I5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjK0I5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:57:46 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B468E125
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:57:52 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-4ac05ca3935so1137846e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701075471; x=1701680271; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q3a/gp0k8Xr24VWAVkFjnZAQbXQVNc8sm8eV5Fej3d0=;
        b=yufLAChDj9RN7rEs7pvz37PwOkjlxXw2veCZBn/kT8ZeGDOsQdKerKh5evKH8dvbXM
         gqS0SBq4QiEyHlkbQHswNW1sOvl0n1yaj6qdh5yTsb5tMVnNZ3X4Re2Q4o4BL9P+S3sj
         jDtjUtswG4m7sodXvxUL74b827RytT5IlFTL7Rsi+mAE6abTnzqxB85xpQM5SKufD7I/
         VcTva3Ats9RaonsQyK1EKcu2+eYpwL90EaGt/eu54yd5yQADh5jt1u4VLC6EyFjpea6/
         WeE4Sm2+HMUUujjORkDWIJwN1Tdc9oVkZz8393bodcB7KetcwJa2OZzxKvN29P7zyGm+
         gtJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701075471; x=1701680271;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q3a/gp0k8Xr24VWAVkFjnZAQbXQVNc8sm8eV5Fej3d0=;
        b=IyEwi/7cdvVa/4Ai43ODRxgxC8NE23rkdRv8f+EoQCJ2avlOGd5JppvW6a5VFgQvqf
         PIjYEzX8MRxWv9XYf7g8jxgDgy4x4fZ8tnBsGic5qnf1nZiTVmfePGwn9FikIg1UQ37a
         2gB++ybZ2Iu4s7B1v5zFAgpuag4SLWxYN5Yin+HzHuwf45dh1KPqkIEQ4QbjY0XGK9uH
         pSaaCoOh/Js88wYYBOdlZjPOZ2ObeU4cmcz55QemkMzRCxLk3Saeq0RY8Yqie/p3T17i
         HqIPyr//sjYZq1d5MI47I9SjMKP1cvtGWaABhaU1mW1b/6GrWNwGnJlN4Z5FUtEoV0ta
         2a8Q==
X-Gm-Message-State: AOJu0YwyyN2LKsnh1/hBVzdZGSYQ6qtcZsI+2FFXQo/4IzaAeInkZ62G
        a9EpdmyuNLDWRQzYjtdSmM7ynj3zoIXR4pF8k/rPGx9xdp0oep8l77o=
X-Google-Smtp-Source: AGHT+IFv95af33s1Ivrbna3UuLQx1RVxE1lA8CxAKNGR1f+9OlWM5+Mw0oXtBMJb+qYB4sJZRWgnDMtvK5EbVnJyJ9Q=
X-Received: by 2002:a05:6122:3106:b0:496:2e22:29e3 with SMTP id
 cg6-20020a056122310600b004962e2229e3mr11176649vkb.1.1701075471346; Mon, 27
 Nov 2023 00:57:51 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 27 Nov 2023 14:27:40 +0530
Message-ID: <CA+G9fYsM4Aa1smp2Xahf=z2WOGpXsAC3GzUW06HJN9pucm837Q@mail.gmail.com>
Subject: parisc: bug.h:71:17: error: invalid 'asm': operand number out of range
To:     open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        linux-parisc <linux-parisc@vger.kernel.org>,
        regressions@lists.linux.dev
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Helge Deller <deller@gmx.de>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parisc tinyconfig built with gcc-11 failed on mainline v6.7-rc3.

git_describe: v6.7-rc3
git_repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline

parisc:
  build:
    * gcc-11-tinyconfig

In file included from lib/math/int_log.c:14:
lib/math/int_log.c: In function 'intlog2':
arch/parisc/include/asm/bug.h:71:17: error: invalid 'asm': operand
number out of range
   71 |                 asm volatile("\n"
         \
      |                 ^~~


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Links:
 - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.7-rc3/testrun/21323529/suite/build/test/gcc-11-tinyconfig/log
 - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.7-rc3/testrun/21323529/suite/build/test/gcc-11-tinyconfig/history/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2Yk9c7RsS6V5pdDdOYzHSrlpZQk/

--
Linaro LKFT
https://lkft.linaro.org
