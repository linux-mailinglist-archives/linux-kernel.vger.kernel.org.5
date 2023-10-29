Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EABA7DADEF
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 20:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjJ2TRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 15:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjJ2TRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 15:17:13 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7FEB6
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 12:17:10 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-32db188e254so2594060f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 12:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698607029; x=1699211829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ITSqca1evCzkzhn7N4VS98YhVKLbCaQ6LkheIXfd40c=;
        b=Wmbue4+qto/Mi+l2NczYEkPW2S0v48+Bc7RfKYfp+OaLJS3EFHETc6icE4tj83WoYA
         RAPho8/yVSSj+3yBZOPCiroo4dsvElbmxz88Ss5UL9CpTmhRo2HOjQCqmCAwIPxR0pHO
         0VD6+5PkqJRHlp4KqldJ2OV81x6aV3VD022ss7YM6ycPy5NylEcCwvaCoaPz8T5BdiR1
         2Gvn1z5g7I3uc5yhaMOCwCjCJURiUZVNpfSdoLkDNCjMwW7CxaJBpYOgn8dD0p8+RTHW
         gbx7cLCSvioly8/bxf+kZjpv10xOvchMYrJMh3ofX6RL2qZCWs2kuitLTlt9Xn+w49KO
         m8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698607029; x=1699211829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ITSqca1evCzkzhn7N4VS98YhVKLbCaQ6LkheIXfd40c=;
        b=ncuflcvoqeqRNpmWKRrJUeoUbeMWc69ztGH8jfxVqmAoivsHB7XDe8nqS6dIEi4AKx
         5z6hRvsibNwzAUzIEeKY27L/Epw7u2nNTwA1VzRyvoGs/H1y+qNLDiPqirV9sBa0myHH
         VaM5FGbV0iGHRD8ZBu+GACgA2bzhuk5jQ8DWlSH1n3AyBGGXHwouG03j/jA1EnPq9wqB
         5M7FKr1XVfYPkL52rBloduCz7HFjR2MeECMe/nPvN5VHNNCTWYq9oP74qZIDEbnA9jAk
         Vdm9UDY3/6W+kcAbq5f1A6w2yWD88LAfgWh8rKLmeD5F4VX5YYzWbvVid6LR8piokFwW
         JrLQ==
X-Gm-Message-State: AOJu0YzDM4K/RwwWmHt+UtPA4oLJmPyf38j2mhb4zFO2yr9i2RHg7oWx
        OQAJgwt+Xc8g+kOchKVE6CWh5sU7LEEGXeBi
X-Google-Smtp-Source: AGHT+IHXE2bjhwJPibipKZXXVYDAVNLrcQqlZkEYTJRNgF/vz2gBUtTk5/EHvKpgfBfIDriqLRKsMw==
X-Received: by 2002:a05:6000:1865:b0:32f:74ee:fcd4 with SMTP id d5-20020a056000186500b0032f74eefcd4mr7064455wri.2.1698607028509;
        Sun, 29 Oct 2023 12:17:08 -0700 (PDT)
Received: from nancy-1-2.. ([105.163.156.232])
        by smtp.googlemail.com with ESMTPSA id p1-20020a5d68c1000000b0032db8f7f378sm6483343wrw.71.2023.10.29.12.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Oct 2023 12:17:08 -0700 (PDT)
From:   Nancy Nyambura <nicymimz@gmail.com>
Cc:     nicydaniels@gmail.com, outreachy@lists.linux.dev,
        Nancy Nyambura <nicymimz@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rts5208: Replace strncpy() with strscpy() for appropriate string copying in rtsx_scsi line 524 warning: found by checkpatch.pl script
Date:   Sun, 29 Oct 2023 22:16:42 +0300
Message-Id: <20231029191647.44127-1-nicymimz@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Nancy Nyambura <nicymimz@gmail.com>
---
 drivers/staging/rts5208/rtsx_scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rts5208/rtsx_scsi.c b/drivers/staging/rts5208/rtsx_scsi.c
index 08bd768ad34d..52324b8ebbc7 100644
--- a/drivers/staging/rts5208/rtsx_scsi.c
+++ b/drivers/staging/rts5208/rtsx_scsi.c
@@ -523,7 +523,7 @@ static int inquiry(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	if (sendbytes > 8) {
 		memcpy(buf, inquiry_buf, 8);
-		strncpy(buf + 8, inquiry_string, sendbytes - 8);
+		strscpy(buf + 8, inquiry_string, sendbytes - 8);
 		if (pro_formatter_flag) {
 			/* Additional Length */
 			buf[4] = 0x33;
-- 
2.40.1

