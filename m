Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2F47781FE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 22:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbjHJUQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 16:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjHJUQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 16:16:46 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E402718
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 13:16:45 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe389d6f19so2031332e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 13:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691698603; x=1692303403;
        h=mime-version:message-id:date:subject:cc:to:from:user-agent:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LcP6/gihYI3kLBbBHFTF24IF50Lr5xUUX6ydg05FQlo=;
        b=Z0m1UJALxdYe5PXargYxue9zOzYJ4iErJqG/bWrieSJfM6seflBymkZCrykNpQ1/yz
         5l0USSHzC7N29x1eiv5fz+Qx7DJT3eqhyTBYJ3T2zq3GzEkoJ2GXZ3X5SH8V7c1u736F
         VTlhwEIY9xWhR4MdP1LicqeIo8k+9G3Z6U283UMVs84XT1SNpO+AMSgjkV5SYFt14JX5
         EKUqARHonbihU4k7wDbx/hkktnQr93kwjvLvWKdx9E07WCiMpdNMW6OL4F2C4oCTlrDT
         lCqZzG9+1UFjBjd8PLFi/EEjtdqh6Kx2+kIYxcCjwUF6BZw9Vn3cLU/iGy9sZrB9/OK0
         MIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691698603; x=1692303403;
        h=mime-version:message-id:date:subject:cc:to:from:user-agent
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LcP6/gihYI3kLBbBHFTF24IF50Lr5xUUX6ydg05FQlo=;
        b=ktylnG7LeaYzb0q34SN+R8v/mKuchNGhGcEeK8iQ32Gy6JwwfrRKH9B3oMOi/aZohG
         hfmhpzO/xzlXNSmbf/J4xywO2jF5XtBi8iLZcAVQVS8XnXsY8S71fdk0ALTtxhW1jEXU
         hh1B9PuvBwDaPutCVPtvGGUTXGq31YmQRQtvrEhFADmYvFuwiK+6HnIwdH/5GplRHn2O
         BMhLfyy7p5wwIVfFH5EzXT+Rm4bsfzRz4o/Tryj24L+OZ2mzy8JygdHnFk1wY5bt+2H5
         jMdx540S1NJA4UUebw/jVNrO4Z5ghuQsjnSq/TUmsxWlAsXD5XexSvGBZ6JzLO199XG+
         6Ujg==
X-Gm-Message-State: AOJu0Yx166YsIpND+WFXlo4NbDhA4J8anVRKO7DAKozV0biJzRWIfdaR
        UcM5HjlVbS6LBgjB1Sw1n0Y=
X-Google-Smtp-Source: AGHT+IGBU9UfpHwTi/scygTsLzy0bhD3BMlBgMDxm30Hk4qAdgwzFvCJplgp/nM5Csbv3WHlE//S8Q==
X-Received: by 2002:a05:6512:3710:b0:4f9:596d:c803 with SMTP id z16-20020a056512371000b004f9596dc803mr2443161lfr.53.1691698603236;
        Thu, 10 Aug 2023 13:16:43 -0700 (PDT)
Received: from razdolb (95-24-154-238.broadband.corbina.ru. [95.24.154.238])
        by smtp.gmail.com with ESMTPSA id x19-20020ac25dd3000000b004f864690901sm420781lfq.244.2023.08.10.13.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 13:16:42 -0700 (PDT)
User-agent: mu4e 1.10.4; emacs 29.1
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     <linux-kernel@vger.kernel.org>, <regressions@lists.linux.dev>,
        <dri-devel@lists.freedesktop.org>,
        <intel-gfx@lists.freedesktop.org>
Subject: [REGRESSION] HDMI connector detection broken in 6.3 on Intel(R)
 Celeron(R) N3060 integrated graphics
Date:   Thu, 10 Aug 2023 22:33:00 +0300
Message-ID: <87v8dmr6ty.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following is a copy an issue I posted to drm/i915 gitlab [1] two
months ago. I repost it to the mailing lists in hope that it will help
the right people pay attention to it.

After kernel upgrade from 6.2.13 to 6.3 HDMI connector detection is
broken for me. Issue is 100% reproducible:

1. Start system as usual with HDMI connected.
2. Disconnect HDMI
3. Connect HDMI back
4. Get "no signal" on display, connector status in sysfs is disconnected

Curiously, running xrandr over ssh like

    ssh qnap251.local env DISPLAY=:0 xrandr

makes display come back. drm-tip tip is affected as well (last test
2023-08-02).

Bisecting points at a4e771729a51 ("drm/probe_helper: sort out poll_running vs poll_enabled").
Reverting that commit on top of 6.3 fixes the issue for me.

System information:
* System architecture: x86_64
* Kernel version: 6.3.arch1
* Linux distribution: Arch Linux
* Machine: QNAP TS-251A, CPU: Intel(R) Celeron(R) CPU N3060 @ 1.60GHz
* Display connector: single HDMI display
* dmesg with debug information (captured on drm-tip, following above 4 steps): [2]
* xrandr output:

    Screen 0: minimum 320 x 200, current 1920 x 1080, maximum 16384 x 16384
    DP-1 disconnected (normal left inverted right x axis y axis)
    HDMI-1 connected primary 1920x1080+0+0 (normal left inverted right x axis y axis) 708mm x 398mm
       1920x1080     60.00*+  50.00    59.94    30.00    25.00    24.00    29.97    23.98
       1920x1080i    60.00    50.00    59.94
       1360x768      59.80
       1280x768      60.35
       1280x720      60.00    50.00    59.94
       1024x768      75.03    70.07    60.00
       832x624       74.55
       800x600       75.00    60.32
       720x576       50.00
       720x480       60.00    59.94
       640x480       75.00    60.00    59.94
       720x400       70.08
    DP-2 disconnected (normal left inverted right x axis y axis)
    HDMI-2 disconnected (normal left inverted right x axis y axis)```

I'm willing to provide additional information and/or test fixes.

[1] https://gitlab.freedesktop.org/drm/intel/-/issues/8451
[2] https://gitlab.freedesktop.org/drm/intel/uploads/fda7aff0b13ef20962856c2c7be51544/dmesg.txt

#regzbot introduced: a4e771729a51

--
Best regards,
Mikhail Rudenko
