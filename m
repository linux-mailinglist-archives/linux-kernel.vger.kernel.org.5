Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C2F78BAF8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 00:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbjH1W0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 18:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjH1WZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 18:25:54 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA88413D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 15:25:51 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-594e1154756so40498437b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 15:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693261551; x=1693866351;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=whuv4S/qXJ8VQLIk5LEoFSmpFljXlYmrEoJuQBk2GD4=;
        b=aEdfAKE2aENnO6tvTzasPUqknc7wJ6diEIJLvmUQxxJpKywDYrFsVaCYoE3h51sd7c
         H+oNWaX4aq3A9uIj9bL7KrPvklouBN4OyA/O+XRgrZAULDLLXXawVpiMY5oabbtF/wrO
         T4Y17/d+q5j7Mm+T/22mbRuV9bHjI2eqFaVVdQSE7hMYmEMWSjjjJb5MbTTUnpKCk0Xu
         7xk5D3xPPMOUz/9r1kmavYv+JGeABhxJbcya7t+GEsGBOZ0ciJaeoY4ZWJy299oj0ESY
         qDYS3ugO2ay3oFwjN3PzQ/KJQjiYf+YEkyAwmBnSaJWMkXK+sjdejHWq2+Umb4RQ3ZHZ
         Q89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693261551; x=1693866351;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=whuv4S/qXJ8VQLIk5LEoFSmpFljXlYmrEoJuQBk2GD4=;
        b=NiX0gr6jXT1FhbyxvQJ6NV2ti+AOsOqaTC6p8JNoOw1dmjbJ5ROste9ypqF50NJtPQ
         w2/6Xz6ENq72UR1iKk36ggb5Js+jmiqfa7BMJ9tHkPAZafdXzNjyaBNLaxStFrdLZhEr
         CCOhNeZ+GVycBWECEmH9TvawIGvDKJJDm5/wkcl7f3w7S0uzBXQVoMs0HenhrKBkfQ9B
         QUF/XXRHTARHnh9jxEHTVMwUW7jwEcGNDf4jTvoTksJHQwZ1aRMykeQRA5khF9rleWl6
         bnoNGD22dlp4aIl6BJvlQVRM4FbUsDoSFU0iQi8IRbnlNnQu0y+4SclpcaKSLntwVOE8
         whwg==
X-Gm-Message-State: AOJu0YxrfVSbzjNUvM+sl6GHItppGNwQ9/yLSA3mPgTnLSXp3cOxaYE+
        +23AUSNSLPn+UgA+B6HenMqPz5c3NnwVMeA7b48=
X-Google-Smtp-Source: AGHT+IE7Nhcb/ZUZVQuQ5+u99sOJ9CdIHBMpQ83N0Fim/iD9z8v4Zjz9mkQBdpgoc9W3GrUHfZjMtDEsE8i0aeHVjQI=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:b64:7817:9989:9eba])
 (user=ndesaulniers job=sendgmr) by 2002:a81:7653:0:b0:586:5d03:67c8 with SMTP
 id j19-20020a817653000000b005865d0367c8mr899523ywk.3.1693261550964; Mon, 28
 Aug 2023 15:25:50 -0700 (PDT)
Date:   Mon, 28 Aug 2023 15:25:46 -0700
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOoe7WQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDCyML3eLk4sz4tPyiksy0Sl3LNIsUI3PLpDTLxEQloJaCotS0zAqwcdG xtbUAr2FdoF4AAAA=
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=eMOZeIQ4DYNKvsNmDNzVbQZqpdex34Aww3b8Ah957X4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693261549; l=1211;
 i=ndesaulniers@google.com; s=20230823; h=from:subject:message-id;
 bh=TGWROu4XNrgfx+3UVHqDnOnYYRlkH/LvjbNZAKHZcUI=; b=XYoq8WEHFYZk0OilZBxoZZDH9/jZiqs7gMqgs5QyaYYkDOElw0g9B4HqjTu1AEVRVmw6fBvvf
 Ta1Q02qYmpODS2FmJeLM2eUD1tbl9vpZGTd9Fq02p9gFPekMg5OCxXH
X-Mailer: b4 0.12.3
Message-ID: <20230828-scsi_fortify-v1-0-8dde624a3b2c@google.com>
Subject: [PATCH 0/2] scsi: fix 2 cases of -Wfortify-source
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Hannes Reinecke <hare@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     Tom Rix <trix@redhat.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang-18 has improved its support for detecting operations that will
truncate values at runtime via -wfortify-source resulting in two new
warnings (or errors with CONFIG_WERROR=y):

  drivers/scsi/myrb.c:1906:10: warning: 'snprintf' will always be
  truncated; specified size is 32, but format string expands to at least
  34 [-Wfortify-source]

  drivers/scsi/myrs.c:1089:10: warning: 'snprintf' will always be
  truncated; specified size is 32, but format string expands to at least
  34 [-Wfortify-source]

When we have a string literal that does not contain any format flags,
rather than use snprintf (sometimes with a size that's too small), let's
use sprintf.

This is pattern is cleaned up throughout two files.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Nick Desaulniers (2):
      scsi: myrb: fix -Wfortify-source
      scsi: myrs: fix -Wfortify-source

 drivers/scsi/myrb.c |  8 ++++----
 drivers/scsi/myrs.c | 14 +++++++-------
 2 files changed, 11 insertions(+), 11 deletions(-)
---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230828-scsi_fortify-9f8d279bf9aa

Best regards,
-- 
Nick Desaulniers <ndesaulniers@google.com>

