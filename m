Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140DD7CD57E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 09:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjJRHaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 03:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjJRH36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 03:29:58 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCDCEA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 00:29:55 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32799639a2aso5634210f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 00:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697614194; x=1698218994; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v9a7EhTcnuVErJIJLl6Y1jE7dAmfjsMLP+DUxRdBE+8=;
        b=VFxvavqfeci4M+nNlGxfyOh8UkUZAHsTPv1lvLywOW7J5GSbW6aeoixpqrDSDLBKA7
         39zbzSY4wWrRbxvSESA/uHwhvqttNAe0DVO3lLNwMDP7F8xQWMjUQ8G+JEsM+G3Sz2OT
         uzpj7aj0wxymiQnSr9UbtlGV0FD/BY0QLg8kehi5fz7qjKu5zDhAIjlXe4bdGXZIZYch
         7ujEFhtQtwEranbnD0ZHEw3o3KALdeGIkrzWMFV5YdUrgTxHeh6JQ3N/tKasinQ76k1E
         LS/S5UGdClYxyGqCxWFZ2bwWx21wlTH6rw1QX0hN5jdg43H07hkzXL9RvdpqePlXaIN1
         nhhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697614194; x=1698218994;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v9a7EhTcnuVErJIJLl6Y1jE7dAmfjsMLP+DUxRdBE+8=;
        b=hwRyODNA3Xf9BMvf/WSjlRoaom9Uzyc3lW558MQM8vKVZdurPcb/f+B6mwlUd+mhI7
         7dXJdmeDsRnAok7+icymdTzfkvpjIMB2lcdsNe3rlT2/h6qCyfMR9gu64Xt9wTndWSIe
         PXegT3dgUz/64ss4SLeKFliYqofCv4w8g4Zpyte4AUpF+dvVwzqQddCX1+pmq8r11vzz
         b5q9Bvo460Un7Kb8KPdQJG0gNMPRCKTw4T4RYUGs2iT9HyJNGQvDbeL+sZw6psaqTjzR
         QfEGGLV8tAsVFwRTx2ubc2tpwpptdqypuHlgYCLJlG0OgM+eb+4Fpk8EJM85+1SI4Xhu
         TxLg==
X-Gm-Message-State: AOJu0YxYrMl4oTFtHZG9CBe6yIwG5LwoMZAevPaNJk6jvwaAP14PGqDP
        jNiArubs/1n4Zoy+jxGCapMIAtZgTcNTxA==
X-Google-Smtp-Source: AGHT+IHIco7uXA0ujhajo5mzcqn0yCAOoYZMKn1q9reSjX91mlhmCR2Fy6h7OFmivNokbx0NI+Z/lg==
X-Received: by 2002:adf:fd10:0:b0:31f:ea18:6f6b with SMTP id e16-20020adffd10000000b0031fea186f6bmr3745788wrr.19.1697614193839;
        Wed, 18 Oct 2023 00:29:53 -0700 (PDT)
Received: from lab-ubuntu ([41.90.71.30])
        by smtp.gmail.com with ESMTPSA id j17-20020a5d5651000000b0032d8f075810sm1441518wrw.10.2023.10.18.00.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 00:29:53 -0700 (PDT)
Date:   Wed, 18 Oct 2023 10:29:51 +0300
From:   Calvince Otieno <calvncce@gmail.com>
To:     gustavo@embeddedor.com, outreachy@lists.linux.dev
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH] staging: vme_user: replace strcpy with strscpy
Message-ID: <ZS+Jb2rQWbOIIQ42@lab-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch suggests using strscpy() instead of strncpy().

The advantages of strscpy() are that it always adds a NUL terminator
and prevents read overflows if the source string is not properly
terminated. One potential disadvantage is that it doesn't zero pad the
string like strncpy() does.

In this code, strscpy() and strncpy() are equivalent and do not affect
runtime behavior. strscpy() simply copies the known string value of the
variable driver_name into the fake_bridge->name variable, which also
has a fixed size.

While using strscpy() does not address any bugs, it is considered a better
practice and aligns with checkpatch recommendations.

Signed-off-by: Calvince Otieno <calvncce@gmail.com>
---
 drivers/staging/vme_user/vme_fake.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
index 0e02c194298d..09b05861017a 100644
--- a/drivers/staging/vme_user/vme_fake.c
+++ b/drivers/staging/vme_user/vme_fake.c
@@ -67,6 +67,7 @@ struct fake_driver {
 	unsigned long long lm_base;
 	u32 lm_aspace;
 	u32 lm_cycle;
+
 	void (*lm_callback[4])(void *);
 	void *lm_data[4];
 	struct tasklet_struct int_tasklet;
@@ -1091,7 +1092,7 @@ static int __init fake_init(void)
 	tasklet_init(&fake_device->int_tasklet, fake_VIRQ_tasklet,
 		     (unsigned long)fake_bridge);
 
-	strcpy(fake_bridge->name, driver_name);
+	strscpy(fake_bridge->name, driver_name, sizeof(fake_bridge->name))
 
 	/* Add master windows to list */
 	INIT_LIST_HEAD(&fake_bridge->master_resources);
-- 
2.34.1

