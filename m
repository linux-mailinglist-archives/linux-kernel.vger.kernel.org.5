Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD40876ECF1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbjHCOnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236986AbjHCOnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:43:16 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81C730D2
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 07:42:31 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id 5b1f17b1804b1-3fe182913c5so6729355e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 07:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691073750; x=1691678550;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0ejXtVjO9uaTmaPpKPCMPrm2Yr8xE8g5nBELmFhSIvc=;
        b=eclzpD56PAvuFmNsITeQ3TfHQrMtVUwZTr94wlpz582WaX1/EGrXcEoUcROygX07ZA
         MoXJNvUp1vUJpQPhTufbiLoa6dCNqMGR+1ghn7bq0gJW+AIkr3ByMXAlRcH0OCPdL+UD
         4DCg9aUolAXKTpm5MqQhQvIXzhR/JeXGIopYb8FnLXzrBS/0iQTAvA806Fxpcycphnrv
         P2KYfsCzqpRx4i+ykt7RuQvrbsA/dAXtSpe/nrqmvPNG1oHmjpRg1yeNAjwbCZDhvvEm
         pVzneh4RP1j7mUIctLjMDIK/3ANqW5aBn8LPm7tnsPG7wOgxQ+exofEebAa6eaiknLT4
         KnLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691073750; x=1691678550;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ejXtVjO9uaTmaPpKPCMPrm2Yr8xE8g5nBELmFhSIvc=;
        b=Fi6w5BJpylGjSBHNaK8w+LiQcypQgkN8qZ+ev+aoWKxyK97THUbA4X8Xgnb1yvUgOy
         Zq6bik8w2DorgmSIkxgOpmb1IZ0Xp4enWQJvWsJfsoQxvMxdsJR6F9Hy8H7lsHMwujdv
         vFBBe4IFgFks9NqMrwu467Hg/e6y7zNG1N16+VxN8XUlbMTXnsMo4/TM/acUuIhz7elc
         8afI3x4NH7o0SPWQtRqUilW4x2/xXMlC+mGM0Qz0U+Cq9qtTMBPXLBbbye7BuWWvmxf4
         L3+TEjNHU6h9stVtLIHCzISGEgzBCSJhNr9LSp7K7N3llOQZFnR1vg/KSP6GEeZ0ghYj
         +4Hw==
X-Gm-Message-State: ABy/qLawF3GZFp1DmrGgRV1p/AU8LfWWu4QVyZhRiHIpVGcw5XOQVRxv
        exGnVFQ+laUnKIVkRBZB6pBnlfqZmkc=
X-Google-Smtp-Source: APBJJlHoRP9t97M7xyqZGKQN0/CPF7nCzoPK8aCSenB+Cx/LKVYYj2MS/G6vKOM7eOcGqD5bDkjkz9P1bO8=
X-Received: from nogikhp920.muc.corp.google.com ([2a00:79e0:9c:201:2d82:fa1b:ad60:64b])
 (user=nogikh job=sendgmr) by 2002:adf:f6c8:0:b0:314:182c:1a2b with SMTP id
 y8-20020adff6c8000000b00314182c1a2bmr50766wrp.4.1691073750119; Thu, 03 Aug
 2023 07:42:30 -0700 (PDT)
Date:   Thu,  3 Aug 2023 16:42:27 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230803144227.2187749-1-nogikh@google.com>
Subject: drivers/gpu/drm/bridge/samsung-dsim.c link error
From:   Aleksandr Nogikh <nogikh@google.com>
To:     aford173@gmail.com, l.stach@pengutronix.de, inki.dae@samsung.com,
        jagan@amarulasolutions.com, m.szyprowski@samsung.com,
        airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     syzkaller@googlegroups.com, dvyukov@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We've been seing the following linker error on arm64 syzbot instances:

ld.lld: error: undefined symbol: phy_mipi_dphy_get_default_config_for_hsclk
>>> referenced by samsung-dsim.c:731 (drivers/gpu/drm/bridge/samsung-dsim.c:731)
>>>               drivers/gpu/drm/bridge/samsung-dsim.o:(samsung_dsim_init) in archive vmlinux.a

Steps to reproduce on the latest linux-next:

$ git checkout next-20230803
$ wget -O '.config' 'https://raw.githubusercontent.com/google/syzkaller/master/dashboard/config/linux/upstream-arm64-kasan.config'
$ make CC=clang ARCH=arm64 LD=ld.lld CROSS_COMPILE=aarch64-linux-gnu- olddefconfig

This also prints:

WARNING: unmet direct dependencies detected for GENERIC_PHY_MIPI_DPHY
  Depends on [n]: GENERIC_PHY [=n]
  Selected by [y]:
  - DRM_NWL_MIPI_DSI [=y] && DRM_BRIDGE [=y] && DRM [=y] && COMMON_CLK [=y] && OF [=y] && HAS_IOMEM [=y]
  - DRM_SAMSUNG_DSIM [=y] && DRM [=y] && DRM_BRIDGE [=y] && COMMON_CLK [=y] && OF [=y] && HAS_IOMEM [=y]

$ make CC=clang ARCH=arm64 LD=ld.lld CROSS_COMPILE=aarch64-linux-gnu- -j$(nproc)

The kernel should have still compiled fine even despite the message above, right?

Could you please take a look?

-- 
Thank you!
Aleksandr
