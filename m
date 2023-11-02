Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B5C7DFACA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 20:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345709AbjKBTRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 15:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjKBTRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 15:17:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F6F186
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 12:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698952606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=u5dyav2FpjU7LQKMZEdDExBNYby1YISH7oqQq8W6UzE=;
        b=hR8t0C3cNLigxyUaJFjH6qwfwQ+wPs6+QfvMYTLeqHsR5tnajeSR72RSZOIEfdtlTPFKEo
        R4anW/34Yd3Xg2u4Ak/SRTg3WDI03JihDHs5v451GzS1T6DFMFvxtuQHQ+OA4zl31Lxbbi
        a9UOK2uWOyfCouFet/IwBH566+pjVj0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471--fFCS7EXNoCL8ekHnHJ62w-1; Thu, 02 Nov 2023 15:16:43 -0400
X-MC-Unique: -fFCS7EXNoCL8ekHnHJ62w-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2c516a92fb2so2774981fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 12:16:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698952602; x=1699557402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u5dyav2FpjU7LQKMZEdDExBNYby1YISH7oqQq8W6UzE=;
        b=OZqDGaLl+gsoTfDILut6vK2YVsFOGim5gM8ldLbGMesSMTN4dSgi+lRpfLPD/sLnHR
         WvP4Dw3LdGd9JYu/66ExPfsSBSTTUYPIBpPBNRECtFIKZMbnyw2ADvmfj4ZZ8ydugHPm
         a8f5gQfRKP50kjMDO3ef6APflzLwFg/A1hohTd6Y96kLRC2tNNJktu9YC4NRs8wtkcWX
         9QnGSJDO1WCdRXh4pZCmfCGyXXf4hlb8d+ENQrnGlSjBNdREnjdo+tYu3kZdMPJNWvuI
         a7Rv7hDa81MO+ygCco5IDT5sggrPa4Vjm+iNsLZVvgpPsefbIcftQH0SxkLAgwhhnS6P
         7XAw==
X-Gm-Message-State: AOJu0YzNPcSAi0buvj5Ku87jklLrI1/qEj178L5VW2qhvp2VQT1GwARg
        zB+BXhCtO8t10wVyV6Z6sHvozr2Mw0sp0VFafMQaQVIpFyKLC9riNsZcRDHvxmBoo9A6/5BAFxf
        DRCRE67Rm27tfildPsnlXXKCn
X-Received: by 2002:a2e:9893:0:b0:2c6:f97c:cf21 with SMTP id b19-20020a2e9893000000b002c6f97ccf21mr1329966ljj.2.1698952601853;
        Thu, 02 Nov 2023 12:16:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/+J5ZI8Q+GWA2EmIhVapXLdftKHmNOwqZSWGlk/Qpep7VCISURdxsmrh90DiG9RGITcOxRQ==
X-Received: by 2002:a2e:9893:0:b0:2c6:f97c:cf21 with SMTP id b19-20020a2e9893000000b002c6f97ccf21mr1329948ljj.2.1698952601486;
        Thu, 02 Nov 2023 12:16:41 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32c5:d600:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id bg13-20020a05600c3c8d00b0040644e699a0sm75279wmb.45.2023.11.02.12.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 12:16:40 -0700 (PDT)
From:   Philipp Stanner <pstanner@redhat.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Schlabbach <robert_s@gmx.net>,
        Takashi Iwai <tiwai@suse.de>, Hyunwoo Kim <imv4bel@gmail.com>,
        Lin Ma <linma@zju.edu.cn>,
        Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Philipp Stanner <pstanner@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Subject: [PATCH] drivers/media/dvb-core: copy user arrays safely
Date:   Thu,  2 Nov 2023 20:16:34 +0100
Message-ID: <20231102191633.52592-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At several positions in dvb_frontend.c, memdup_user() is utilized to
copy userspace arrays. This is done without overflow checks.

Use the new wrapper memdup_array_user() to copy the arrays more safely.

Suggested-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/media/dvb-core/dvb_frontend.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/media/dvb-core/dvb_frontend.c b/drivers/media/dvb-core/dvb_frontend.c
index 9293b058ab99..93d3378a0df4 100644
--- a/drivers/media/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb-core/dvb_frontend.c
@@ -2168,7 +2168,8 @@ static int dvb_frontend_handle_compat_ioctl(struct file *file, unsigned int cmd,
 		if (!tvps->num || (tvps->num > DTV_IOCTL_MAX_MSGS))
 			return -EINVAL;
 
-		tvp = memdup_user(compat_ptr(tvps->props), tvps->num * sizeof(*tvp));
+		tvp = memdup_array_user(compat_ptr(tvps->props),
+					tvps->num, sizeof(*tvp));
 		if (IS_ERR(tvp))
 			return PTR_ERR(tvp);
 
@@ -2199,7 +2200,8 @@ static int dvb_frontend_handle_compat_ioctl(struct file *file, unsigned int cmd,
 		if (!tvps->num || (tvps->num > DTV_IOCTL_MAX_MSGS))
 			return -EINVAL;
 
-		tvp = memdup_user(compat_ptr(tvps->props), tvps->num * sizeof(*tvp));
+		tvp = memdup_array_user(compat_ptr(tvps->props),
+					tvps->num, sizeof(*tvp));
 		if (IS_ERR(tvp))
 			return PTR_ERR(tvp);
 
@@ -2379,7 +2381,8 @@ static int dvb_get_property(struct dvb_frontend *fe, struct file *file,
 	if (!tvps->num || tvps->num > DTV_IOCTL_MAX_MSGS)
 		return -EINVAL;
 
-	tvp = memdup_user((void __user *)tvps->props, tvps->num * sizeof(*tvp));
+	tvp = memdup_array_user((void __user *)tvps->props,
+				tvps->num, sizeof(*tvp));
 	if (IS_ERR(tvp))
 		return PTR_ERR(tvp);
 
@@ -2457,7 +2460,8 @@ static int dvb_frontend_handle_ioctl(struct file *file,
 		if (!tvps->num || (tvps->num > DTV_IOCTL_MAX_MSGS))
 			return -EINVAL;
 
-		tvp = memdup_user((void __user *)tvps->props, tvps->num * sizeof(*tvp));
+		tvp = memdup_array_user((void __user *)tvps->props,
+					tvps->num, sizeof(*tvp));
 		if (IS_ERR(tvp))
 			return PTR_ERR(tvp);
 
-- 
2.41.0

