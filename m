Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24B57CBFFA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbjJQJ4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234752AbjJQJ4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:56:19 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE108E;
        Tue, 17 Oct 2023 02:56:17 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ca82f015e4so11727185ad.1;
        Tue, 17 Oct 2023 02:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697536577; x=1698141377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=II5ImvwdoBMhhhMCFXImAhFo00DMG1iqmwoAQFMbYKQ=;
        b=RWVCN4Jjr1VIGgoLRiqK86hQgxOh7ce5R/0rw3JlDtn7A+bywFHic1uxxgxGYPRlWi
         Ze579sWsdflM68fXZbv/7hS158dxi+57VU1vdLJwTOGOUwxYjEKlsGYbXVoyenH9vHSb
         8OM6LMj2Li44vLsgoR5o5c/F/OF2ITNonZZi6vi2P3Y1UTx5IvQ2AIzLYnE37HwKarcq
         3AKtYjMrY/M+7qHRzYcxFMTP3F4ExQ5eJ/jmNSz7ublx2MUg1PKaJ0SBiIKa1LW5k3ID
         npEwm89q/pXcfuYHhSidZu0ItDrDP65rl+7d3lYeL2AhgzlCxd8wxp+XtPUZlbZfNs1l
         nEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697536577; x=1698141377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=II5ImvwdoBMhhhMCFXImAhFo00DMG1iqmwoAQFMbYKQ=;
        b=Eb1/vFyN3MjijwL4je/S0ry8oBXaK+sE8QxkHNK51vOGdonHnER7v8sEgbZ6MmlrWy
         affvugsCqnNGndpzoOJWmm5BZS569qRaDcWS57RTCTMRWt4EBOTNO+4vlRO66dkSkVXQ
         mmjn181F+iVojS+jNlhpWA81bugLbGGPdz+K58iwXrP0YgOtO7Wqjx1qeQtmpLCrZfIu
         zjauA3Pwox7z04PdO6a3k8lBmeMpXW7ajyVb47uz47lE9wNwYcogrxIGpdqMpe7Q3tYn
         LPUaZR39X7r+QeEa/aq/MN3TXEklakK3JMKUcRDHbfJ20XJlax8w6b/A8G9OonJeGTXX
         ivFA==
X-Gm-Message-State: AOJu0Yx2WoJsJJ7O7RCK56Nl0kRLS29nCD+Kcrk6sSnKGwf+WHWFHpkZ
        E2l3cauCs5aBNRuuoefOm+k=
X-Google-Smtp-Source: AGHT+IHl8aH5z1fRJj+bRkw4KcEr8kjTvGrxewOfNJ6cgfFk2bgq3HJwemtiLHhwldqoVoCR3GJ74Q==
X-Received: by 2002:a17:903:482:b0:1c5:8401:356c with SMTP id jj2-20020a170903048200b001c58401356cmr1501720plb.62.1697536577232;
        Tue, 17 Oct 2023 02:56:17 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id u14-20020a170902e5ce00b001b86492d724sm1093343plf.223.2023.10.17.02.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 02:56:16 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 9AA8B8097A1C; Tue, 17 Oct 2023 16:56:12 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux CoreSight <coresight@lists.linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] Documentation: ABI: coresight-tpdm: Fix Bit[3] description indentation
Date:   Tue, 17 Oct 2023 16:56:08 +0700
Message-ID: <20231017095608.136277-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1727; i=bagasdotme@gmail.com; h=from:subject; bh=yngM08kD1bzp4K9abSD6QBPMAVhUl302WD9sewUK0GQ=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDKl6kR2mbhujGj/U6Fss1bo86zyTY9wxy42rpwh+Shf/P V9Wfv/CjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEyk/gIjw03ZqUHp7JlXZ0rs 2W3U3eC0pUU+/xPvs54i/9AChQCFDEaGHatSmTe/y3ne9eTDxOcZx5kCfp770sh3/1CmSvMks8N HmQA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
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

Stephen Rothwell reported htmldocs warnings when merging coresight tree:

Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm:48: ERROR: Unexpected indentation.
Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm:48: WARNING: Block quote ends without a blank line; unexpected unindent.

Fix indentation alignment for Bit[3] list entry in dsb_mode description to
silence above warnings.

Fixes: 535d80d3c10fff ("coresight-tpdm: Add node to set dsb programming mode")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20231017143324.75387a21@canb.auug.org.au/
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
index f07218e788439d..4dd49b159543b6 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
@@ -54,8 +54,8 @@ Description:
 		Accepts the value needs to be greater than 0. What data
 		bits do is listed below.
 		Bit[0:1] : Test mode control bit for choosing the inputs.
-		Bit[3] : Set to 0 for low performance mode.
-				 Set to 1 for high performance mode.
+		Bit[3] : Set to 0 for low performance mode. Set to 1 for high
+		performance mode.
 		Bit[4:8] : Select byte lane for high performance mode.
 
 What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_edge/ctrl_idx

base-commit: 90a7371cb08d7e542fa4f283c881973bba09f23b
-- 
An old man doll... just what I always wanted! - Clara

