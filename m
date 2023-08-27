Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAB178A12C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 21:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjH0Tdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 15:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjH0TdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 15:33:14 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1B4C6
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 12:33:11 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6bd3317144fso2153983a34.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 12:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693164791; x=1693769591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hrAfmkDjeLWsX6v8VmGfNgFeSlaJo1JXSit4j9nwvGA=;
        b=mDUWt8SCZ1zQzTOlBmBQG44QpsxPWbmCJ1jzAQS+NXrQmFAOGHUYBf7/FQyhX7Rabm
         nkJ7jVDE4qN7K29ax84fxHSIEsMAGj76FE9bRRnkPL4YHTNB7Za5Qq70k72ET476kJK5
         kn8DNJOTRkeNhXJCiwHsP679WyYo5AGxIMa0g+f3JcCtHqCO2oAywAXuNUHCdZf6MWKL
         wQNKUPcMvIezI7/BSJ98YVDnhYFGNsMNvM6ZK3fxclWXXCSp5bv0ffGIi4OGu1tehq9E
         NXqYNQuQPPiG694NZzG6g68teAm80orvBIVCnMbl5xmy16ZHQThddoPL1nvl4Y6zvKnI
         wL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693164791; x=1693769591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hrAfmkDjeLWsX6v8VmGfNgFeSlaJo1JXSit4j9nwvGA=;
        b=YBySKfQicq3RiotVowFzjyCZccy3tF1ubOqXYHY4eQ8WmDpeWKhYiFr+NbAZjjOXP9
         UxOWTRxK1yUBBLy4rnzfWRgGHQXD1eRFmwyqeboMehCEAuzGVdCmthxZlHOw8FlfxAs7
         eGpQsn6XJmD1rXnprIDqLs42sM6bt4ITw+WtNLmfmOJUxBLuRb38eV0XRkp/c4D5lASO
         hgr5YRCAz09w8DsJUF64gHAIKzuIZHAUeSvw0rO710gb7DRoctKt4a1onOEd9DIT046s
         Sv9uWqJQZtskee7Mou/4yav3ffjhAPxTtMs2iRzBUK5FyqyAi8XgsB8bfz4Hp4QJwZtm
         a/wA==
X-Gm-Message-State: AOJu0Yy9t9FUdBtR5IJzpznYz69DYmEh8G6rJOu/KEZU6Fvdq+NMLRls
        TgHWAKkAkG5Q09zyuCjhJa4=
X-Google-Smtp-Source: AGHT+IEjka/+VDKBRuPl/I58rzTsE4cLX6zW7HtFlTr0vDBD4+zQeVcSMY3O31H4NuOtdmZNJc8czg==
X-Received: by 2002:a9d:7d98:0:b0:6b9:1af3:3307 with SMTP id j24-20020a9d7d98000000b006b91af33307mr12166928otn.17.1693164791248;
        Sun, 27 Aug 2023 12:33:11 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:82ea:8c7c:b784:3f92:988a])
        by smtp.gmail.com with ESMTPSA id l8-20020a9d7348000000b006b96384ba1csm1640272otk.77.2023.08.27.12.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 12:33:10 -0700 (PDT)
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Alexon Oliveira <alexondunkan@gmail.com>
Subject: [PATCH v4 0/4] staging: vme_user: fix checks reported in vme_fake.c
Date:   Sun, 27 Aug 2023 16:32:48 -0300
Message-ID: <cover.1693164540.git.alexondunkan@gmail.com>
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
