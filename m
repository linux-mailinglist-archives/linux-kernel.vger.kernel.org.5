Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887E97BCBAE
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 04:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344288AbjJHCLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 22:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjJHCLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 22:11:07 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B072492
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 19:11:04 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3ae214a077cso2574856b6e.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 19:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696731064; x=1697335864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FMoyoDa/uZ/7MooKLfhy2actdhu9OzZKbzygeWHv0iY=;
        b=bXa688rX66CxObYP354MKB0EtQocmcTQhPfgMBY6d3po9Wry48vzHGHRIs6CAYCyzI
         rlap4dijTlxnDsz4R1totJynvtPP/mxhNCdavORaVMkUgNT5M7RIMmX7k6kZNnCVmtAe
         JRnhGgU36MNHJfl4Jjh0DX4VTnEsK+YgWzs6nw8zcby7RvzDSke4py+MWrPLcEOZ6Spg
         ncfWeonMbXdN3G+bmvsuf17PnLlT0TweixPhZgpibQ4lF5ChyOaQBfoIrxaHbHE3gEKp
         rZzLJinvT1fdq4iqMf9s2na4noJZfacNcIrModhM9uaHGpA+6ps+xR+NzECSGO3Nzl5x
         6BVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696731064; x=1697335864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FMoyoDa/uZ/7MooKLfhy2actdhu9OzZKbzygeWHv0iY=;
        b=P1vFmWq35LasV67Ypiw4MseQanXMi/ltL7JvNsirsEuUzUgnxEdEA207fxpipENF7c
         9JixmrN/RFS6FP5JxMAAmdRM5hHQDMsYLqB/hdb/k1gOG9H+w2/IAdmqnjsejbyMcuUR
         IMaozpkN9+SrXD4u9YjyDn0MFNTTl7hAqRI9jx9t42Uut6Xl+H1FBYvhlQu6s0a0beQV
         cpXXC+hHtY5hORumBFlrJiNJh4CcKDwrjkY8U62s2+zlM/CPdu8/QZ6srk/oDbVoFrxk
         +hMOX9a7C6hG4ZglBXgqmyMgM5+//LCPvWcZj5qG/87rAcLvCJ+3GO7pAxfHEICnVpOc
         AeDw==
X-Gm-Message-State: AOJu0YyRbZxmJt5iEn4/4u8+L/TgJ0Fll01N1xKNW3mNWl8FfMkAWe6k
        O+CmzUzHiohXXLcYM39SYco=
X-Google-Smtp-Source: AGHT+IHqeRsL2m3+2DgNGHjGQGf6G1YcEKSBGhcTjGMiBlbS1OmdEu7tiW5qB2rPt5auj3TMl/sbNw==
X-Received: by 2002:a05:6808:1448:b0:3af:7956:10d4 with SMTP id x8-20020a056808144800b003af795610d4mr15146943oiv.0.1696731063971;
        Sat, 07 Oct 2023 19:11:03 -0700 (PDT)
Received: from ubuntu.. ([223.178.246.252])
        by smtp.gmail.com with ESMTPSA id x8-20020aa784c8000000b00690fdeb5c0dsm3746125pfn.2.2023.10.07.19.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 19:11:03 -0700 (PDT)
From:   Pavan Bobba <opensource206@gmail.com>
To:     Pavan Bobba <pavanbobba206@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Pavan Bobba <opensource206@gmail.com>
Subject: [PATCH
Date:   Sun,  8 Oct 2023 07:40:52 +0530
Message-Id: <cover.1696729776.git.opensource206@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*** BLURB HERE ***

Pavan Bobba (3):
  staging: vt6655: Type encoding info dropped from array name "abyBBVGA"
  staging: vt6655: Type encoding info dropped from variable name
    "byBBVGACurrent"
  staging: vt6655: Type encoding info dropped from variable name
    "byBBVGANew"

 drivers/staging/vt6655/baseband.c    | 40 ++++++++++++++--------------
 drivers/staging/vt6655/channel.c     |  6 ++---
 drivers/staging/vt6655/device.h      |  6 ++---
 drivers/staging/vt6655/device_main.c | 24 ++++++++---------
 4 files changed, 38 insertions(+), 38 deletions(-)

-- 
2.34.1

