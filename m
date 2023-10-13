Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB847C9186
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 01:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbjJMXrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 19:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbjJMXrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 19:47:31 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27154C9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 16:47:29 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-57e40f0189aso1414289eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 16:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697240848; x=1697845648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r89DHYNFueYR4hgHMDPSPQFhhiG/h3pT42UPfUI4Rls=;
        b=cl7tUULvjPs3bgr/tGYI8Xfn/lvfYqXoT3+luUwnDz/QSrcL9Qo3PirdFQA8xKK+e8
         Yd0IPnQZA+wExu69LNe3Jf3U75XLfguJqjhjYwahYE4uH2KIrpVM0VPPZ2PxC65Kg+GB
         eBWUdNadXY4lt+aTJfFgVA0r7MOUeqvcXjHhmUBXJWWnn+8zRyxhPBc9dIBzKDg03rA6
         MU31A+FEnxoxsN7rVIp7+Dx4nAEheo2Evzb4kCH8DlCLbOD+8D6By470GBTCY1P/7DzL
         5SMAaISgkpHQAG+h7D2pntUc8p0cfQ0BKTpwCE2eiQKkaw7Tev6BJNmfYQ2l9LGd249f
         FFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697240848; x=1697845648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r89DHYNFueYR4hgHMDPSPQFhhiG/h3pT42UPfUI4Rls=;
        b=HlJczW2Wf/WFnrLJpvRkEH2eYa9mXhAO00dax68PLHyo0K7x8bz+n9NkVVux4Ecdme
         KuPVnCHZQMiRSb+rIEAhfeU7v7beqm4VCW+RWm70rJRLLdEwxaXHBImhIeueAOX53l0v
         i6sy9FQrmgtDpYIls6wszU4uwfauI5AVydBsVrkgs58sHGfObsc42JeicQAJ3O47XkA1
         2A93E3hRKhIdr8OugLPSjFfW+mZ6o0hDBpoqTKIUg2ULvxuW/y2hMXplIkl4n6TgMdpJ
         Z9I+PEpPbhupOBnkhudAFLFCIhO8OU/Bcs1wpC38+9P7xcn4khumkR8ASnSooVwKN90P
         rtiw==
X-Gm-Message-State: AOJu0YwVWheEqAOETwYsQYfAM3hqeRMnXT7xLhIP+DLA6lKn/ExHhxQG
        ghOFveKUr0Y5Xct4zbcwlHWTPgIAoO86HA==
X-Google-Smtp-Source: AGHT+IHpm9L9w26cR56Xl0+1a/XfcF/QkUYxetvJQ0A+dROfp7mUBHZhBJzlpVkHR1SOBSjca4y1Cw==
X-Received: by 2002:a05:6358:785:b0:143:82e0:8cbc with SMTP id n5-20020a056358078500b0014382e08cbcmr32934611rwj.1.1697240848301;
        Fri, 13 Oct 2023 16:47:28 -0700 (PDT)
Received: from Negi ([68.181.16.134])
        by smtp.gmail.com with ESMTPSA id f6-20020a637546000000b0057c29fec795sm3909355pgn.37.2023.10.13.16.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 16:47:27 -0700 (PDT)
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Soumya Negi <soumya.negi97@gmail.com>
Subject: [PATCH 1/4] staging: vme_user: Correct spelling mistakes in comments
Date:   Fri, 13 Oct 2023 16:47:13 -0700
Message-ID: <f41caa8e7c987fdc010942838117fece8151affe.1697240381.git.soumya.negi97@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697240381.git.soumya.negi97@gmail.com>
References: <cover.1697240381.git.soumya.negi97@gmail.com>
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

Fix misspelled words in vme.c. Issue found by checkpatch.pl

Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
---
 drivers/staging/vme_user/vme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
index 5960562dcd96..80083ea0fb53 100644
--- a/drivers/staging/vme_user/vme.c
+++ b/drivers/staging/vme_user/vme.c
@@ -1603,7 +1603,7 @@ EXPORT_SYMBOL(vme_lm_get);
  * @callback: Pointer to callback function called when triggered.
  * @data: Generic pointer that will be passed to the callback function.
  *
- * Attach a callback to the specificed offset into the location monitors
+ * Attach a callback to the specified offset into the location monitors
  * monitored addresses. A generic pointer is provided to allow data to be
  * passed to the callback when called.
  *
@@ -1638,7 +1638,7 @@ EXPORT_SYMBOL(vme_lm_attach);
  * @resource: Pointer to VME location monitor resource.
  * @monitor: Offset to which callback should be removed.
  *
- * Remove the callback associated with the specificed offset into the
+ * Remove the callback associated with the specified offset into the
  * location monitors monitored addresses.
  *
  * Return: Zero on success, -EINVAL when provided with an invalid location
-- 
2.42.0

