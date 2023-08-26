Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8AF7897B2
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 17:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjHZPTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 11:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjHZPSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 11:18:52 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB64172D
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 08:18:49 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1c4de3b9072so1273424fac.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 08:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693063128; x=1693667928;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nzTwOxodIrtEsdwkWuz0yOug+DzxDcAq1gfUgYKMZNE=;
        b=BQGH0YOfSriMoQqC274OlA/PRMd6iqmqKxPkF0utQK+Ock1Kw1Wi/gvJBhkpb2PGCb
         NuSMW2eJTA/WYU1ZK81TOh9RzBmINcJUafi9ZJPivjbKU/Fbv4CKQBzZSoEWnEHr4vMO
         hJQiBQnmQfJvhznt1w0RWDmhRSvmz5mbZZh1KTcXNefQupglJQqeh4p8iNx4Qo93Ss7L
         UqhKqxtIufTwJeq1jqjMzrfh0PJ9+1QbKNAXfTXVkOQeDH8kgYI8s2Hp8qFb8+PYJRs6
         tgT8hqVW61eWJ6NTrCg0nP1tp8NkW0mQwbwMfKYUmsqf2mJycbz8VeIoSI9J/x/iNoL9
         tpmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693063128; x=1693667928;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nzTwOxodIrtEsdwkWuz0yOug+DzxDcAq1gfUgYKMZNE=;
        b=bcmZPLKqxfTmr161arpw0B/hTQQDOP5o6t79ydc/E1SQcwtN6CSRoxI14n1lh/pixi
         8V7Zi87pAP0D/zhXwxy95qc4xF6+cYsL7v/v3htVibB4NVbun9GRdQzjULKdW5fgN3dI
         go9u8DxdDjJxUlICBuyFcDC9urwKuoSzKI38HHK4sTQm0b/kNO8HFXdaPMy+q1vuMrlt
         jrks2g5Bz9WNbANpKF/Bi3OcsTEl2fnxs1+Dubz1T1ws8BH07x8Q5m0eQdsLnb8h/NSg
         cDKhuvIcDuDKMXAxfflFaXxYAn+ZWexE6ZCEI/mXYFhvqIYx6xHRH85IdYa0Bb4iVAX9
         hNuw==
X-Gm-Message-State: AOJu0YycqGBgrquZWklGwkovINp447UX1Fr1XqChrFMcicPv1FEYamqz
        lmP1qANK94uNit5C/yZ0Slg=
X-Google-Smtp-Source: AGHT+IHiSLyTBDQGZWESnc9jAvslkvTW5INNTFaT6pxNLUkEBR7RbXXBUmhcGxY/LdEJwsCjM220iQ==
X-Received: by 2002:a05:6870:828d:b0:1bb:b025:3e87 with SMTP id q13-20020a056870828d00b001bbb0253e87mr6362102oae.58.1693063128213;
        Sat, 26 Aug 2023 08:18:48 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:82ea:8c7c:b784:3f92:988a])
        by smtp.gmail.com with ESMTPSA id e11-20020a0568301e4b00b006bcbffa5167sm1818255otj.76.2023.08.26.08.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 08:18:47 -0700 (PDT)
Date:   Sat, 26 Aug 2023 12:18:42 -0300
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v2 3/4] staging: vme_user: fix check unnecessary blank lines
 in vme_fake.c
Message-ID: <ZOoX0npoWDwBSDn0@alolivei-thinkpadt480s.gru.csb>
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

Fixed all CHECK: Blank lines aren't necessary before a close brace '}'
as reported by checkpatch to adhere to the Linux kernel
coding-style guidelines.

Signed-off-by: Alexon Oliveira <alexondunkan@gmail.com>
---

Changes in v2:
- Fixed summary phrase with tags to indicate commit order
in the patch series, noted by Greg KH

 drivers/staging/vme_user/vme_fake.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
index dbaf050f88e5..4258ed6033e7 100644
--- a/drivers/staging/vme_user/vme_fake.c
+++ b/drivers/staging/vme_user/vme_fake.c
@@ -584,7 +584,6 @@ static ssize_t fake_master_read(struct vme_master_resource *image, void *buf,
 					aspace, cycle);
 			done += 1;
 		}
-
 	}
 
 	if ((dwidth == VME_D16) || (dwidth == VME_D32)) {
@@ -770,7 +769,6 @@ static ssize_t fake_master_write(struct vme_master_resource *image, void *buf,
 				       aspace, cycle);
 			done += 1;
 		}
-
 	}
 
 	if ((dwidth == VME_D16) || (dwidth == VME_D32)) {
-- 
2.41.0

