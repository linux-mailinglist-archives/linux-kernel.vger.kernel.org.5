Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC26B7CB874
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 04:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjJQCfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 22:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjJQCfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 22:35:51 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E7FF5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 19:35:49 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6b26a3163acso2892393b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 19:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697510149; x=1698114949; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=adVf8A3/crcNLY+ksyRtmx34jr6J2QTaDzuwLDhSC/s=;
        b=Lt33BIaF8M3vgXzAktzPeOCZQJtMzROIH0rTkEmU4WB4VyQgPZ5dICM7EiKGYH1un0
         MMCAb1TVsow8k1CYxK2tTi0Tuvrdwi9Sax/17qdvpnRfw5PRkai8pcdyeJeVwvZUpcxf
         1x+2eNJtO3oKXjmg4jhK31Peb+u7KDvHSeTRhLi/8oBPjuGMlN/7Z7CMHVHU0MEufMjw
         MZgoUNt0Oie9seAda+OT9yqxyKTwLoFz7wrAN9EiGjMZI3ryUUX8V3NuykPma3Cu9Een
         yg8bE5p0TEIslzbjNwbo1CWc3Ev2WrIqb+rPApcrhMam1Hfsj9Z5bIK+pVcNctwHadQB
         bfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697510149; x=1698114949;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=adVf8A3/crcNLY+ksyRtmx34jr6J2QTaDzuwLDhSC/s=;
        b=sJajkY0164ybtMY1plF9wLca59XFLInYkcE6Xhqyhx4s7xM/eMfrPT2RsrCiMLpA/F
         k657k2/jTR3GkJDjelTprfp9+BbUoWEroHg8HYLpZzKydaMJoPh4iL20Qp6bMEA7n7+G
         hbKCYAfF6r2+R6Qo+BO9dn2MrfOBZpvLx/sQfPkp2gIJSSbzb04k1fZye4CTkd7expmk
         k9nrP+p9NWLtxU4VEQF0SuQVnq91ie4JRhJesNx8Je3aE/VQ9F9wCMA39oCb+yOdkL4A
         0SA1dQOOodwCD9iHLisY/7e11uYqC3K6XxldchmiPdiBSvQ2jiVSmS0XsoY4s8IUwRYk
         SPQQ==
X-Gm-Message-State: AOJu0YzpUM9bWcLohg9HvQQutY12i5bzgvM8Uc+GICd6VmfDRfZshlEC
        t96Kwc8F0RkHTYh+JSsqwaE=
X-Google-Smtp-Source: AGHT+IGsxCdNX8EsBwdlLG99DRr/sy9DKnvwetQovuD3b+34tn5DtoIYTWI4DKjHRYl0JJQ2+vjVbQ==
X-Received: by 2002:a05:6a00:158f:b0:691:2d4:23b2 with SMTP id u15-20020a056a00158f00b0069102d423b2mr1185579pfk.15.1697510149277;
        Mon, 16 Oct 2023 19:35:49 -0700 (PDT)
Received: from ubuntu ([223.226.54.200])
        by smtp.gmail.com with ESMTPSA id x28-20020aa79a5c000000b0068fb9f98467sm248234pfj.107.2023.10.16.19.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 19:35:48 -0700 (PDT)
Date:   Mon, 16 Oct 2023 19:35:44 -0700
From:   Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
To:     Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: greybus: Modify lines end with a '('
Message-ID: <20231017023544.GA6684@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adhere to linux coding style. Reported by checkpatch.pl:
CHECK: Lines should not end with a '('

Signed-off-by: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
---
 drivers/staging/greybus/audio_manager_private.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/greybus/audio_manager_private.h b/drivers/staging/greybus/audio_manager_private.h
index 2b3a766c7de7..daca5b48b986 100644
--- a/drivers/staging/greybus/audio_manager_private.h
+++ b/drivers/staging/greybus/audio_manager_private.h
@@ -12,10 +12,9 @@
 
 #include "audio_manager.h"
 
-int gb_audio_manager_module_create(
-	struct gb_audio_manager_module **module,
-	struct kset *manager_kset,
-	int id, struct gb_audio_manager_module_descriptor *desc);
+int gb_audio_manager_module_create(struct gb_audio_manager_module **module,
+				   struct kset *manager_kset, int id,
+				   struct gb_audio_manager_module_descriptor *desc);
 
 /* module destroyed via kobject_put */
 
-- 
2.25.1

