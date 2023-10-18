Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8257CD70D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjJRIxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJRIxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:53:06 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2737F9D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:53:05 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4065f29e933so67352195e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697619183; x=1698223983; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=geUEpwvi3+e4pwlZJkv1VdkNb71jcT4N9IHDjoo0hiw=;
        b=LpTtpeXfJ4aTxvCgA6cigOFUsrZ3dtvHPA/wKi9D0daNfVJ01m1veIuAFD72oRwifM
         4jBtV2jw9pi2nOBOVDuB91c+k54Mukx8VB2VyVJ4EMfy0pgem2cCbovQBJm9M2dhkifQ
         sBTOcbCZkbfIszxS2KlG4q9B5DiXHl2qfCHbY0T4HfCAPliF2mWs7Xx60bxy1H27u8aU
         jUU76WzqwoMX0D6m05upZOk6o2M6jIDuR1GO5fc9uWfvugpr3GDnclragkGzjIdDL+0s
         bEucDYBvDStWMgB7pJpUjQPv4ItbMSBlFJoZU/uu9Jjq4/D0WI9cekvvL4vCgHN1fEzk
         GLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697619183; x=1698223983;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=geUEpwvi3+e4pwlZJkv1VdkNb71jcT4N9IHDjoo0hiw=;
        b=W1fu/+hl87UuiJ9vqIcuo0dXW+VjjxA9cJPCdr0ASTV0JFGgiZMO8RoHHEwicm78yU
         +21hWsCI8Occ+h3chEV3fQQ/G3G9UI5ZRLX0YdrAzhxj+VH3Y9nDo68+4HD+wM5CpO0e
         gMjc8Kge5mYDyNgxWqFI+JLtHBv8FUJ8JZL03taqhugblmAyJBnp1kgFkpzW9KGA1K3v
         J7LKU+rRfpMD/LN6w/xKGaGyI8hZU10hyVYcXXgscrUBCkYLzEqKpoKwfK07a+orpOqM
         /PRj8PjGqOCZwKMQz2ECM/rVpkis42pVCSDs23KUb3NUAEJI8WnKa/XzztLciA4+DqaZ
         ANfw==
X-Gm-Message-State: AOJu0YztXnjJt8VbyBbiof0fXZDuZhalyF++wTYY0B2xh2OKJrK225e1
        gHvow8PUYl3VVpVu6QRGUCk=
X-Google-Smtp-Source: AGHT+IFe7N0r16SpcIn2ppSF9YwaBfMXR5p9HHAUkW/Z5SFuEG/gq5GT5k5JsnJNXPESx8hwfICsIA==
X-Received: by 2002:a5d:540d:0:b0:32d:9d99:d0a5 with SMTP id g13-20020a5d540d000000b0032d9d99d0a5mr3493755wrv.5.1697619183280;
        Wed, 18 Oct 2023 01:53:03 -0700 (PDT)
Received: from lab-ubuntu ([41.90.71.30])
        by smtp.gmail.com with ESMTPSA id r12-20020adfce8c000000b0032d9caeab0fsm1612082wrn.77.2023.10.18.01.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 01:53:02 -0700 (PDT)
Date:   Wed, 18 Oct 2023 11:53:00 +0300
From:   Calvince Otieno <calvncce@gmail.com>
To:     gustavo@embeddedor.com, outreachy@lists.linux.dev
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Calvince Otieno <calvncce@gmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH V2] staging: vme_user: replace strcpy with strscpy
Message-ID: <ZS+c7NtfEw5ne2Oj@lab-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch suggests using strscpy() instead of strcpy().

The advantages of strscpy() are that it always adds a NUL terminator
and prevents read overflows if the source string is not properly
terminated. One potential disadvantage is that it doesn't zero pad the
string like strcpy() does.

In this specific context, both strscpy and strcpy performs the same
operation without any functional difference.

The reason for this equivalence is that the driver_name string "vme_fake"
is shorter than the size of the fake_bridge->name array which is defined
as 16 characters (struct vme_bridge {char name[VMENAMSIZ];...}). Thus,
there is no risk of buffer overflow in either case. VMENAMSIZ variable
holds a constant value of 16 (#define VMENAMSIZ 16)

The null-terminated "vme_fake" string
(static const char driver_name[] = "vme_fake";) can be safely copied into
fake_bridge->name using either strscpy or strcpy.

While using strscpy() does not address any bugs, it is considered a better
practice and aligns with checkpatch recommendations.

Signed-off-by: Calvince Otieno <calvncce@gmail.com>
---
Changes in V2:
 - Make the commit message more clearer.
 - Remove the incident extra line change.

 drivers/staging/vme_user/vme_fake.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
index 0e02c194298d..8ab5b43c70a6 100644
--- a/drivers/staging/vme_user/vme_fake.c
+++ b/drivers/staging/vme_user/vme_fake.c
@@ -1091,7 +1091,7 @@ static int __init fake_init(void)
 	tasklet_init(&fake_device->int_tasklet, fake_VIRQ_tasklet,
 		     (unsigned long)fake_bridge);
 
-	strcpy(fake_bridge->name, driver_name);
+	strscpy(fake_bridge->name, driver_name, sizeof(fake_bridge->name))
 
 	/* Add master windows to list */
 	INIT_LIST_HEAD(&fake_bridge->master_resources);
-- 
2.34.1

