Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B6A77FEF7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 22:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354842AbjHQUX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 16:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354883AbjHQUXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 16:23:44 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A072E35B6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 13:23:37 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-34a91a25db9so268145ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 13:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1692303817; x=1692908617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ctD5tHxh8kgFl4uPzWKbzXoO7ZYmYJnR4HDtMsNhGnc=;
        b=W4ibDs5DBdEd4UQjK72PNxJMfP4ExYP+b1HbFVa4PxBF4Rzl2SucgPXGUyrhiJ/eP9
         Zcfan+GqPuCx9ifeHXAuy3BnUGlc+cXVRAovkDEG25XQfxSmjBbtYYRW15/+/q6r2ELu
         o13VLO7RRnc2X7lMotATsBKmCx1tHewpcHzpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692303817; x=1692908617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ctD5tHxh8kgFl4uPzWKbzXoO7ZYmYJnR4HDtMsNhGnc=;
        b=VGVFDLpLtv3ltwfYIBU6TbSMFrU+IrjKPfBXYMpaFQVZ2f15N0pHERgGtlclf6enRg
         Aj3Nw3v8pNltX/SyfLMXrs+PpetleJ9HjF3Z/L/6N1xcm9DKLRgoiwv0iR+XuiwGseqc
         kYkIkP/ns5jgP54kE5CkTW/AkqAlyIJXLFXufz6MUSCmrkzfsTw936HFBYxfJ1qRwQBe
         Qc3d0UXIEs0N7NTGhqrF0h1lpF8HIZqHsDckF5myvQZA+SPqgajxn1cuGevr7qLrBlaD
         54T9WAvgpgjdqAmZLzzUusashWLqQexsxbXEHE3/EtxcVq003zukNmTap6yRx6qzviU6
         3XfQ==
X-Gm-Message-State: AOJu0Yy2dkMRgiXCWeCJHjazf538DEWnIzb4w7o5O88QuptuGgUwbiE1
        Wy+8vjgBTV1cDWs7korvyloE6nKS4HhcdSrBbxk=
X-Google-Smtp-Source: AGHT+IH9443ew05VRXg9438t3UQ8u0XSyabqLN3iXPrEg4r6cnXlOhesTdal3Zsb0le9INBr3dk+5g==
X-Received: by 2002:a92:d488:0:b0:349:1d60:7250 with SMTP id p8-20020a92d488000000b003491d607250mr806977ilg.0.1692303817020;
        Thu, 17 Aug 2023 13:23:37 -0700 (PDT)
Received: from localhost.localdomain ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id t9-20020a056e02010900b00348ea1a31ccsm79014ilm.12.2023.08.17.13.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 13:23:36 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     trenn@suse.com, shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, zuraxt@gmail.com,
        temuri.doghonadze@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpupower: Add Georgian translation to Makefile LANGUAGES
Date:   Thu, 17 Aug 2023 14:23:35 -0600
Message-Id: <20230817202335.25060-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4680b734e729 ("cpupower: Add Georgian translation") added
new language support. This change didn't add "ka" to Makefile
LANGUAGES variable. Add it now.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/power/cpupower/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index dc531805a570..b53753dee02f 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -57,7 +57,7 @@ LIB_MIN=			1
 
 PACKAGE =			cpupower
 PACKAGE_BUGREPORT =		linux-pm@vger.kernel.org
-LANGUAGES = 			de fr it cs pt
+LANGUAGES = 			de fr it cs pt ka
 
 
 # Directory definitions. These are default and most probably
-- 
2.39.2

