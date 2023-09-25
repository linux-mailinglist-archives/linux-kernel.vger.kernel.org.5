Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630487ACF8E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 07:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbjIYFnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 01:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjIYFnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 01:43:21 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59EDE8;
        Sun, 24 Sep 2023 22:43:14 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c127ac7255so85427761fa.0;
        Sun, 24 Sep 2023 22:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695620593; x=1696225393; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28NxZ+rgLDNAeJjBwfxzpAPSvGWfmS2MYsQ9559Q2CU=;
        b=hTodVOQnjIXEnR93kbAV/XQJDiyknecpXUnfi/+qluX0Gb9AZsA6JITesFLDAeaonz
         /siHZ/KMKx5X/MZuZqIqeznJy2PQbc70gV6/yPsehy4977t8nslQRPHnFY52UltBQjz3
         OWFnRLO5Hxvp9zM6Q6TsQQ1HFj2wIQHTNn8RD/rIseJ/7mcwjj7KxXZ753q4RNmc7HUd
         +xTzF3o6P0NimGem8kfWj/abpdJSRUotSRbvt2LM6klAzmqg344QcfpJeNiDBWu7PMOK
         OqkLUrEb/q1n5dA6cv99bEO4E5eOSbBpYaqPFXjlkfxGfODl5mHAdgglqYatTDL/ZQHN
         VSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695620593; x=1696225393;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28NxZ+rgLDNAeJjBwfxzpAPSvGWfmS2MYsQ9559Q2CU=;
        b=nsx27H2GiC9mEKVDTd85nPnIosQp5DuX6HxsYSeqeVRoHA0njnC6AEwwPc0Kd9BWf/
         wa7IGPHfedjKb5syeepuDRa6Be7nO22R01hMI50W45gfi+Bug5/7CbAwW6Ab7+p+iS44
         m+iksmQjAWWZzDbrXaA9aR5DlC3iIl5Sot8NRSp8xoMduLgsfbARLAxq8hNyraAnzjNm
         ofsIvPGX+dDqdgsgUdozJ9N3F6BFz83mrN6qQ4an1Y+KKYd9Kc6KgOc+fI1jQ1unMlVZ
         U6ZFNu0ua6ZW39gaqJozn5Gpvj2Txsw9LNbD/R9m1E5v2OqliU2SyDFjsm4nfK8Y9JyE
         /fAA==
X-Gm-Message-State: AOJu0YysflqPbPfnFzkfNInlyyB/4ERPHqcXRjAj9eNKOK5Vza5sFxh+
        4nKHHq7iSl30qHvjf9zp5AyxKXJfJaY=
X-Google-Smtp-Source: AGHT+IFfRtH6/ov3tCkVh6xX9A64r/ZytBBUvH8kItTSelsjtGyV02YGBCeFxfEJ5UkWkDyZZDeaVA==
X-Received: by 2002:a05:651c:b21:b0:2c1:5470:6cb8 with SMTP id b33-20020a05651c0b2100b002c154706cb8mr3214511ljr.35.1695620592672;
        Sun, 24 Sep 2023 22:43:12 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:5985:a031:1aef:cf7a])
        by smtp.gmail.com with ESMTPSA id g5-20020a17090670c500b009a13fdc139fsm5762878ejk.183.2023.09.24.22.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 22:43:12 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
        Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: adjust header file entry in DPLL SUBSYSTEM
Date:   Mon, 25 Sep 2023 07:43:05 +0200
Message-Id: <20230925054305.16771-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9431063ad323 ("dpll: core: Add DPLL framework base functions") adds
the section DPLL SUBSYSTEM in MAINTAINERS and includes a file entry to the
non-existing file 'include/net/dpll.h'.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference. Looking at the file stat of the commit above, this entry
clearly intended to refer to 'include/linux/dpll.h'.

Adjust this header file entry in DPLL SUBSYSTEM.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9aa84682ccb9..cfa82f0fe017 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6363,7 +6363,7 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	Documentation/driver-api/dpll.rst
 F:	drivers/dpll/*
-F:	include/net/dpll.h
+F:	include/linux/dpll.h
 F:	include/uapi/linux/dpll.h
 
 DRBD DRIVER
-- 
2.17.1

