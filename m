Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2249770A7E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 23:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjHDVIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 17:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjHDVIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 17:08:06 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7790F5598
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 14:07:14 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-686d8c8fc65so1969176b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 14:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691183232; x=1691788032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FEsheO3i+HT5uw/jZO9+tyUmSgAmpT4RBKmVdn+zt9Y=;
        b=MbcqXgmgURNTb9/gZqb669uU3dqLJV9HcwqZn4T5sF5Ws5iVArgRTrt27V9qLBZxgv
         BbTxsDBfbFtHBZA9G/zHKsT6EazAsMO3fFO14Z3iCt4whJoEQtnLsR0ZQAa2JOwkEG/F
         6P5hZptRjK1kQinoF6CEemcdNqonYQqI+eqoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691183232; x=1691788032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FEsheO3i+HT5uw/jZO9+tyUmSgAmpT4RBKmVdn+zt9Y=;
        b=a2cqXENpjzWYtsyCmK2mhUgYsmNsjuevq9+Bv8Ds7jg3hn+lFfZgltHqTsgVpjZ/sk
         H45Yftruhzfoghoxgv1pcq9MOVa6xd/lV82z8IudJhowwTZbUCEYOkYd8U2VnE9zI+eN
         TIeVzUYMogI8yZDDYb3WA8304YhdznafBxvMWP7QdqtZD2L2lXlTcg40yNpV8ESuxFGa
         yPZu0AhcIZN1NYHToChVqkJQLQHh1/M4qzOVj02XMCOAuUbHsOwyNEx12skOMoFJzoEN
         M/EkF2+2PxJIhoLj5I7DXLIjM2AbroZMn29JO+hO+4lYC8jNIKIozRpuBMWh0CwPlAQI
         oLXQ==
X-Gm-Message-State: AOJu0Yxxj+rJMT/PQ8kOVzy9/WxStMxxrPEzxBs9jqlsofI04mwAPUqf
        KFhwZN82GpZ/HYND0Igkx3FBVQ==
X-Google-Smtp-Source: AGHT+IHep7ebzLJrmBCFhZqJ9B/HwBWs/2tGY0CKlI1vt5kyDas+U9VcbwaanW++1dZJasYOhqPZpg==
X-Received: by 2002:a05:6a00:248c:b0:63d:3339:e967 with SMTP id c12-20020a056a00248c00b0063d3339e967mr3357033pfv.19.1691183232385;
        Fri, 04 Aug 2023 14:07:12 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:e186:e5d2:e60:bad3])
        by smtp.gmail.com with ESMTPSA id n22-20020aa78a56000000b0068664ace38asm2037584pfa.19.2023.08.04.14.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 14:07:11 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jerry Han <hanxu5@huaqin.corp-partner.google.com>,
        Jianhua Lu <lujianhua000@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Ondrej Jirman <megi@xff.cz>, Ondrej Jirman <megous@megous.com>,
        Purism Kernel Team <kernel@puri.sm>,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Stefan Mavrodiev <stefan@olimex.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 00/10] drm/panel: Remove most store/double-check of prepared/enabled state
Date:   Fri,  4 Aug 2023 14:06:03 -0700
Message-ID: <20230804210644.1862287-1-dianders@chromium.org>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


As talked about in commit d2aacaf07395 ("drm/panel: Check for already
prepared/enabled in drm_panel"), we want to remove needless code from
panel drivers that was storing and double-checking the
prepared/enabled state. Even if someone was relying on the
double-check before, that double-check is now in the core and not
needed in individual drivers.

This series attempts to do just that. While the original grep, AKA:
  git grep 'if.*>prepared' -- drivers/gpu/drm/panel
  git grep 'if.*>enabled' -- drivers/gpu/drm/panel
...still produces a few hits after my series, they are _mostly_ all
gone. The ones that are left are less trivial to fix.

One of the main reasons that many panels probably needed to store and
double-check their prepared/enabled appears to have been to handle
shutdown and/or remove. Panels drivers often wanted to force the power
off for panels in these cases and this was a good reason for the
double-check. As part of this series a new helper is added that uses
the state tracking that the drm_panel core is doing so each individual
panel driver doesn't need to do it.

This series changes a lot of drivers and obviously the author can't
test on all of them. The changes here are also not completely trivial
in all cases. Please double-check your drivers carefully to make sure
something wasn't missed. After looking at over 40 drivers I'll admit
that my eyes glazed over a little.

I've attempted to organize these patches like to group together panels
that needed similar handling. Panels that had code that didn't seem to
match anyone else got their own patch. I made judgement calls on what
I considered "similar".

As noted in individual patches, there are some cases here where I
expect behavior to change a little bit. I'm hoping these changes are
for the better and don't cause any problems. Fingers crossed.

I have at least confirmed that "allmodconfig" for arm64 doesn't fall
on its face with this series. I haven't done a ton of other testing.


Douglas Anderson (10):
  drm/panel: Don't store+check prepared/enabled for simple cases
  drm/panel: s6e63m0: Don't store+check prepared/enabled
  drm/panel: otm8009a: Don't double check prepared/enabled
  drm/panel_helper: Introduce drm_panel_helper
  drm/panel: Don't store+check prepared/enabled for panels needing
    shutdown
  drm/panel: Don't store+check prepared/enabled for panels disabled at
    shutdown
  drm/panel: st7703: Don't store+check prepared
  drm/panel: rm67191: Don't store+check enabled
  drm/panel: sony-acx565akm: Don't double-check enabled state in disable
  drm/panel: Update TODO list item for cleaning up prepared/enabled
    tracking

 Documentation/gpu/todo.rst                    | 33 +++++-------
 drivers/gpu/drm/Makefile                      |  1 +
 drivers/gpu/drm/drm_panel_helper.c            | 37 ++++++++++++++
 .../drm/panel/panel-asus-z00t-tm5p5-n35596.c  |  9 ----
 .../gpu/drm/panel/panel-boe-bf060y8m-aj0.c    |  9 ----
 drivers/gpu/drm/panel/panel-boe-himax8279d.c  | 36 ++-----------
 .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 16 +-----
 drivers/gpu/drm/panel/panel-edp.c             | 34 ++-----------
 drivers/gpu/drm/panel/panel-elida-kd35t133.c  | 21 +-------
 drivers/gpu/drm/panel/panel-himax-hx8394.c    | 21 +-------
 drivers/gpu/drm/panel/panel-innolux-p079zca.c | 51 ++-----------------
 drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c  |  9 ----
 .../gpu/drm/panel/panel-jdi-lt070me05000.c    | 30 ++---------
 drivers/gpu/drm/panel/panel-khadas-ts050.c    | 35 ++-----------
 .../drm/panel/panel-kingdisplay-kd097d04.c    | 43 ++--------------
 .../drm/panel/panel-leadtek-ltk050h3146w.c    | 21 +-------
 .../drm/panel/panel-leadtek-ltk500hd1829.c    | 21 +-------
 drivers/gpu/drm/panel/panel-novatek-nt35950.c |  9 ----
 drivers/gpu/drm/panel/panel-novatek-nt36523.c | 12 -----
 .../gpu/drm/panel/panel-novatek-nt36672a.c    | 24 ++-------
 .../drm/panel/panel-olimex-lcd-olinuxino.c    | 45 +---------------
 .../gpu/drm/panel/panel-orisetech-otm8009a.c  | 17 -------
 .../drm/panel/panel-osd-osd101t2587-53ts.c    | 37 ++------------
 .../drm/panel/panel-panasonic-vvx10f034n00.c  | 42 ++-------------
 drivers/gpu/drm/panel/panel-raydium-rm67191.c | 21 +-------
 drivers/gpu/drm/panel/panel-raydium-rm68200.c | 38 --------------
 .../gpu/drm/panel/panel-samsung-atna33xc20.c  | 31 ++---------
 drivers/gpu/drm/panel/panel-samsung-s6e63m0.c | 25 ---------
 .../panel/panel-samsung-s6e88a0-ams452ef01.c  | 10 ----
 drivers/gpu/drm/panel/panel-samsung-sofef00.c |  9 ----
 drivers/gpu/drm/panel/panel-seiko-43wvf1g.c   | 45 ++--------------
 .../gpu/drm/panel/panel-sharp-lq101r1sx01.c   | 46 ++---------------
 .../gpu/drm/panel/panel-sharp-ls043t1le01.c   | 19 ++-----
 .../gpu/drm/panel/panel-sharp-ls060t1sx01.c   | 10 ----
 drivers/gpu/drm/panel/panel-simple.c          | 34 ++-----------
 drivers/gpu/drm/panel/panel-sitronix-st7703.c | 20 +-------
 drivers/gpu/drm/panel/panel-sony-acx565akm.c  |  7 +--
 drivers/gpu/drm/panel/panel-sony-td4353-jdi.c |  9 ----
 .../panel/panel-sony-tulip-truly-nt35521.c    | 18 -------
 .../drm/panel/panel-startek-kd070fhfid015.c   | 11 ----
 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c  | 19 ++-----
 drivers/gpu/drm/panel/panel-truly-nt35597.c   | 20 --------
 drivers/gpu/drm/panel/panel-visionox-r66451.c | 16 ------
 .../gpu/drm/panel/panel-visionox-rm69299.c    |  8 ---
 .../gpu/drm/panel/panel-visionox-vtdr6130.c   |  9 ----
 .../gpu/drm/panel/panel-xinpeng-xpp055c272.c  | 21 +-------
 include/drm/drm_panel_helper.h                | 13 +++++
 47 files changed, 131 insertions(+), 941 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_panel_helper.c
 create mode 100644 include/drm/drm_panel_helper.h

-- 
2.41.0.585.gd2178a4bd4-goog

