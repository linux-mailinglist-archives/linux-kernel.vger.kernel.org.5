Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C41802032
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 02:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjLCBSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 20:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCBSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 20:18:53 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB89611F;
        Sat,  2 Dec 2023 17:18:59 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-35d624b0415so3501785ab.2;
        Sat, 02 Dec 2023 17:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701566339; x=1702171139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nusgugflo5RySkjqtGLjEPISgz1GeZmnIMfzRmf6uYU=;
        b=kMaCalZt5XZ9Ald4x0byiG29s14del3wJTp2n3bRp2x/iIoyGxT4EDNtBvkoCfTK/C
         RKpEbIiL0dfhYICT8DaFJUpy4OuX5My7BCiXrDlPb0lczGfr9mRoX0mMAnJCoC9OjkdD
         4pA3RJ2Z1y60YUcLpyW3lfZZzhISXC9xSZ2H2PR0LIvDmoRxhCqDfYAyGSD6+BLuMeLH
         q+XHG8KoaaMCn4m6YpxMCOFj37Gne4fz+ZAdSMpkyVCjZmSPMtbQS5kT1ZJDnngI7ydy
         ZjpMFzl2TKbNGZnJF/jxeiZiavvsputsquspLPJKyz+o50CaKkmrxdw+vkPsoXsuprAz
         gJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701566339; x=1702171139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nusgugflo5RySkjqtGLjEPISgz1GeZmnIMfzRmf6uYU=;
        b=D3dMBM4nhCpHsGh7guOw09S7+CpETBO/RB1YiqFpsZfN/9bv/wPJ+BDgZq13xxc/1w
         DVtbi6QLuPzGqDbn9JD5ahXAKWDmpx+2OSOsk072+rEqT8gheTtNSJ08s2g9XS8t+yM3
         yvWZdr1o/hcQhSIAMbu868Z8gRcbbz06EisnfYXh+eUWUCtrFtm7GI9Dhl45cp9vcdxl
         qXVzZbF7Ju4S+IjMKCzHtnur7Yvik77070HvuERgUGmQ0xHgJBo/m9QPlVecjhLgW0sI
         wRxQXL8WGKEoiU9ciznyb5zUz5F+6Wfx9x0ZpZrFSHmB9O/zcHJhJSjA65NTmCI8ARSp
         TKBQ==
X-Gm-Message-State: AOJu0YwDw5FNmrz15F4rofmYygfWqR94ZQHvlmA/r+UbnTM1nbLW6gaJ
        Sqz1LpYx5qysiA+CThjkFi14k3ZvoTnHKPG4
X-Google-Smtp-Source: AGHT+IFZqoEv9fOUHT7XUHjy4g5PSQuYJcoOl/dnELMGUbFo6+YLWUxNg5D/lbMvaz5hb0XzftGHiQ==
X-Received: by 2002:a92:c683:0:b0:35d:4db2:4ed3 with SMTP id o3-20020a92c683000000b0035d4db24ed3mr2711090ilg.3.1701566338967;
        Sat, 02 Dec 2023 17:18:58 -0800 (PST)
Received: from TarXPS13Braves.flets-east.jp (softbank126126113136.bbtec.net. [126.126.113.136])
        by smtp.googlemail.com with ESMTPSA id i3-20020a1709026ac300b001bc930d4517sm5798621plt.42.2023.12.02.17.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 17:18:58 -0800 (PST)
From:   Tsung-Han Lin <tsunghan.tw@gmail.com>
Cc:     tsunghan.tw@gmail.com, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Dcoumentation/arch/arm64: fix typo
Date:   Sun,  3 Dec 2023 09:18:04 +0800
Message-Id: <20231203011804.27694-1-tsunghan.tw@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Should be 'if' here.

Signed-off-by: Tsung-Han Lin <tsunghan.tw@gmail.com>
---
 Documentation/arch/arm64/arm-acpi.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/arch/arm64/arm-acpi.rst b/Documentation/arch/arm64/arm-acpi.rst
index a46c34fa9604..e59e4505d0d9 100644
--- a/Documentation/arch/arm64/arm-acpi.rst
+++ b/Documentation/arch/arm64/arm-acpi.rst
@@ -130,7 +130,7 @@ When an Arm system boots, it can either have DT information, ACPI tables,
 or in some very unusual cases, both.  If no command line parameters are used,
 the kernel will try to use DT for device enumeration; if there is no DT
 present, the kernel will try to use ACPI tables, but only if they are present.
-In neither is available, the kernel will not boot.  If acpi=force is used
+If neither is available, the kernel will not boot.  If acpi=force is used
 on the command line, the kernel will attempt to use ACPI tables first, but
 fall back to DT if there are no ACPI tables present.  The basic idea is that
 the kernel will not fail to boot unless it absolutely has no other choice.
--
2.34.1

