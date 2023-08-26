Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3907C78992C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 23:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjHZVHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 17:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjHZVHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 17:07:24 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F8AE54
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 14:07:22 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-7a25184a648so721045241.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 14:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693084041; x=1693688841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hrAfmkDjeLWsX6v8VmGfNgFeSlaJo1JXSit4j9nwvGA=;
        b=kcQTr5Jpd9jT1NC48d4gY0ZSxjuAPNoixGNw5egGE94QLaPGA6AATPo0ETZjpUp82/
         cN6SPvOdG2X5f2HN1gqwldrrZ4NQaHf83FGsrAEJ9QL3yLYH9I5oEXwTdMfMw00oKWoL
         jqbt1YTAqEKzGRQVdTMRPuNtEdF5SHbS/eC93ca8fcjIyHcEETCjQVN8ZMoghjPdpsps
         qLXT1adgTe5cLplobWYPcNENSbxwWnNxf+5aSD2yw7zKu4xrBNIlwvvhBlgenordhD/a
         risIrDrPkz5cnQu2MZVYym7Gf6gGFbOyH8/VAI9QJbWoE4trCorb8TU3pudJiVW4ZOYD
         j1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693084041; x=1693688841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hrAfmkDjeLWsX6v8VmGfNgFeSlaJo1JXSit4j9nwvGA=;
        b=AaJtFtmqkPxYej9uQPVhj1Q6JwFs6eVcoNfUTak6XoIK0vMg9Mbd+wp5qK+XRzO6Pf
         E1FBo5LlCcjaVTpbP+tdhQ4amozZiCWSdQcbcPO6w9W5mlSB0sdQtuxX+nl4qF4H8YdN
         hShRAtTpHO2pjEDvfEeu+1rmxbqvjXpQnsbeYNSt/6BaPTAOjizFzTFnIqPlq0IrS+O8
         VIW+2EXn2wZD4bVHnpD/FJn+RjFDyS5Njgi8c4qmUTzrm5YIJy/xdGDDegqJQikDGCws
         TZixUgBR+vA7uTbJ1cyfJEa/Gx+qAMC02RFbLrmfFHejfN2Hhz93C5DsBCZH92uuU4qW
         /q6A==
X-Gm-Message-State: AOJu0Yw3+qSzFUhPdp9woSJ2sAabHohdNd52D7eigMJ6HWdIrzlwpJCf
        PS/nvPR/1JHGH7PLbX0qXE4=
X-Google-Smtp-Source: AGHT+IGQfg0jBs6IZALuLuHot3u3jTCGhWEcU0KsBE/fmeiitJ1eh6Sg1udyUlJcZDkBXFIqbwmUzg==
X-Received: by 2002:a05:6102:3a49:b0:44d:5053:11ce with SMTP id c9-20020a0561023a4900b0044d505311cemr16214941vsu.19.1693084041076;
        Sat, 26 Aug 2023 14:07:21 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:82ea:8c7c:b784:3f92:988a])
        by smtp.gmail.com with ESMTPSA id w3-20020a0c8e43000000b0064f50e2c551sm1488377qvb.1.2023.08.26.14.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 14:07:20 -0700 (PDT)
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Alexon Oliveira <alexondunkan@gmail.com>
Subject: [PATCH 0/4] staging: vme_user: fix checks reported in vme_fake.c
Date:   Sat, 26 Aug 2023 18:05:14 -0300
Message-ID: <cover.1693082101.git.alexondunkan@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal of this series is to fix all warnings related to
aligment of open parenthesis, lines not ending with '(',
unnecessary blank lines and unnecessary space after a cast
in the vme_fake.c file, as reported by checkpatch to adhere
to the Linux kernel coding-style guidelines.

Alexon Oliveira (4):
  staging: vme_user: fix check alignment of open parenthesis in
    vme_fake.c
  staging: vme_user: fix check lines not ending with '(' in vme_fake.c
  staging: vme_user: fix check unnecessary blank lines in vme_fake.c
  staging: vme_user: fix check unnecessary space after a cast in
    vme_fake.c

 drivers/staging/vme_user/vme_fake.c | 72 ++++++++++++++---------------
 1 file changed, 35 insertions(+), 37 deletions(-)

-- 
2.41.0

