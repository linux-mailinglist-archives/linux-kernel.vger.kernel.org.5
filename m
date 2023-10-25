Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9457D73A1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjJYS4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjJYS4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:56:42 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1ED111
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:56:39 -0700 (PDT)
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E49FF413B6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 18:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1698260196;
        bh=mHXboaNJIGHxi+UlmtLed78yOAC0VPZ0YehEIDaxN1E=;
        h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type;
        b=mSwJTRqPUDuB9Cbsm/H81//bvmf/MJkQ7U8itZO/UsQGJHT9gID2S9tVyOfsgBHa3
         fY7P50OjPshUVa1xcDHLcdSRWCb2dykVgzBql5N3lzmFHllnunf+1+IYqGhaDgmzz/
         UUsTKo7UpTWblDlIvmC8UJj0lojgEdVTuIRb4Rsc8BL2DOMBw/ydE20eupR5Nk7v33
         2rXSQVe9GQBmpLy4AVzkHmFc///qMG84hmFXEVkJAX5F9crm757cx/Cpu9FOj5NZiH
         Sh6jByraasPa/ZNPavtWtFbqVIuGKJaCJicNUUFOtQ96M41BfKa3BKrJyM9MxzdxJB
         rvUdAddropy7g==
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-41e3e4aa311so948551cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698260196; x=1698864996;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mHXboaNJIGHxi+UlmtLed78yOAC0VPZ0YehEIDaxN1E=;
        b=T+/WgEDdFwUh3vW8dzvPxwa6VRpgQZwNSvELDm0GI1h7gG2r3G7wwX6ZvYrR9i0Tye
         EtTadhxejrKhbRbSGcUDFhheVw3DB9+yIpKaqvDaHGYvC+uP/5DzYn4+i1EaiTr6ZOKE
         MljrV+IWXPOhkuavifY8srK0GuFxDGw9BU+adGUupTaE42TLbLaJdaxVk37OA/Syd0oT
         o5GvOTNMj1jnIqY2fNfRmS7iabLMP5oAPptRZzDMETtclxomNRaE1qd7qyPFrI/lTTpy
         G3SWESu6LGWKbIdnjeb3RuQCMjC+GcIk2FCBcjyizf+I+AeHrPrRBF+BEkpZNsmq/jC7
         tBrg==
X-Gm-Message-State: AOJu0Yz3MvqiY7ilALiXzXjMlp0oFz51+6WJG34ziRGoT2VwuCQ3OmX9
        Anw5Dv//sub8FFKpIKcLnN6tiH19oQlVXPaTtZNs0kwr0Mf9rkkJ3tlNlPrJaLV9U0t5Tq2PRPb
        vcNhxwlUTpns11m1d3GjHiy8c/gm+9s3qiNkxFlaZY5yuuwhx7TIlVF5bhw==
X-Received: by 2002:a05:622a:58f:b0:41c:dd0f:7fd0 with SMTP id c15-20020a05622a058f00b0041cdd0f7fd0mr16782235qtb.33.1698260195956;
        Wed, 25 Oct 2023 11:56:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEE4M1NetKOJlGLn7AZ6e2f6yRI6UKMiMDq2jGuECMu4wY5zIvO7J/wSp3z+d2ubuRtJQGpZkpSUkWzhyn4AYY=
MIME-Version: 1.0
X-Received: by 2002:a05:622a:58f:b0:41c:dd0f:7fd0 with SMTP id
 c15-20020a05622a058f00b0041cdd0f7fd0mr16782228qtb.33.1698260195765; Wed, 25
 Oct 2023 11:56:35 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Oct 2023 11:56:35 -0700
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Wed, 25 Oct 2023 11:56:35 -0700
Message-ID: <CAJM55Z_pdoGxRXbmBgJ5GbVWyeM1N6+LHihbNdT26Oo_qA5VYA@mail.gmail.com>
Subject: [PATCH 0/4] soc: sifive: ccache: Add StarFive JH7100 support
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the StarFive JH7100 SoC to the SiFive cache
controller driver. The JH7100 was a "development version" of the JH7110
used on the BeagleV Starlight and VisionFive V1 boards.  It has
non-coherent peripheral DMAs but was designed before the standard RISC-V
Zicbom extension, so it neeeds support in this driver for non-standard
cache management.

Emil Renner Berthing (4):
  dt-bindings: cache: sifive,ccache0: Add StarFive JH7100 compatible
  soc: sifive: ccache: Add StarFive JH7100 support
  dt-bindings: cache: sifive,ccache0: Add sifive,cache-ops property
  soc: sifive: ccache: Support cache management operations

 .../bindings/cache/sifive,ccache0.yaml        | 11 +++-
 drivers/soc/sifive/sifive_ccache.c            | 56 ++++++++++++++++++-
 2 files changed, 64 insertions(+), 3 deletions(-)

-- 
2.40.1
