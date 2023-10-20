Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841AC7D199F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 01:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbjJTXYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 19:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjJTXX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 19:23:58 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9739AD7E;
        Fri, 20 Oct 2023 16:23:54 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c51682fddeso27615921fa.1;
        Fri, 20 Oct 2023 16:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697844232; x=1698449032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGRsKfkSWDnEn2JQQ9Vic5ujLknS138ZJ2S7yseoneg=;
        b=hQ/J7CcxH1E1UUk2p4qRLSNMKrtasio11zaKJAIg+J40C+0s7OBDujpSGhAcSVYKpT
         xUzyEa2Ok6noZLZVycXzr+5L0Sn6eMPl0fPzu3cvrEpBVvo685almepc8Q6H5HJmoSWl
         IcUvu2tErjnhSvNhrb46OVBtDmjSNpanCoOjrkDIkjAhckLyiPXq2sF08/PJ8EYmvRPF
         v2QwJ9qdfNbsWQXR6djbZltuquuYvCjcvdlP2jjKjI1bZct2hv/3AmwYsYI2YXIVswBp
         HD2qlmBPGnINXKZ6De6nvAzDAbdB/G5eQ8oj+Ig97ZoKVgFiQmKUbWZEb1kF3goylwzD
         2kSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697844232; x=1698449032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iGRsKfkSWDnEn2JQQ9Vic5ujLknS138ZJ2S7yseoneg=;
        b=bC+fKBJaupM/aFbeipqBhoErohd5R1Q3bENcxHyitxbaeSQPCofBEcuGzBAfhF6daz
         ZKKB5yM7Z938pg1CPgWkuP1GpeG798fpyaEn4s/43CIgtZ31+Ay8dxcaZRDQ0WaAyF7j
         Sy77BfxNPGcPgsrA053mIqsWvxuWEQEJNbMutu5QiCJTYsfskXXgJ1iDey9/mZ8cf9jA
         D/4DQzJoGQJU7mc2sAjZHphPTp0cCLnqXvOuyXrYAiCW0IFmdfqkBDGmVuc+hfI5MqkW
         3EeYTDyGN9uf0y6vFLrr8465JeZLu+oiE+T+I4s7S8oFe3HOCMbczDSLk/rkRAmPoNNb
         GitQ==
X-Gm-Message-State: AOJu0YyxwUXjB6d/MLRe0BfFmeRypEVmZcHLrCQJ+fN3Er5dwls8OAHZ
        rNdZKwMlVkv6a6+Td1OAs9s=
X-Google-Smtp-Source: AGHT+IFOfc56kvRMQKU4YI4wz+SHLZ4jJDaGRbsm2bxm03UdaXXNTuz7Unljg/pDXKD5leXRpPmG2w==
X-Received: by 2002:a2e:9194:0:b0:2c0:a0d:1f0a with SMTP id f20-20020a2e9194000000b002c00a0d1f0amr2138271ljg.18.1697844232420;
        Fri, 20 Oct 2023 16:23:52 -0700 (PDT)
Received: from HP-ENVY-Notebook.lan (81-229-94-10-no68.tbcn.telia.com. [81.229.94.10])
        by smtp.googlemail.com with ESMTPSA id s5-20020a05651c048500b002ba586d27a2sm567571ljc.26.2023.10.20.16.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 16:23:52 -0700 (PDT)
From:   Jonathan Bergh <bergh.jonathan@gmail.com>
To:     mchehab@kernel.org
Cc:     gregkh@linuxfoundation.org, error27@gmail.com,
        linux-staging@lists.linux.dev, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH 5/5] staging: media: av7110: Fix various formating issues
Date:   Sat, 21 Oct 2023 01:23:32 +0200
Message-Id: <20231020232332.55024-6-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231020232332.55024-1-bergh.jonathan@gmail.com>
References: <20231020232332.55024-1-bergh.jonathan@gmail.com>
MIME-Version: 1.0
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

Fixed the following remaining formatting issues:
 * ensure balanced whitespaces around '&' symbol
 * fix irregular whitespacings in variable assignment statement
 * fix suspect identation after if statement
 * fix instances were trailing statements after case statements were
   not on a newline
 * fixed a block comment to use '*' on succesive lines
 * Remove unneeded braces {} for single line conditional statement

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/staging/media/av7110/av7110_av.c | 29 +++++++++++++-----------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/media/av7110/av7110_av.c b/drivers/staging/media/av7110/av7110_av.c
index 82d4c02ae3ef..bdef95244121 100644
--- a/drivers/staging/media/av7110/av7110_av.c
+++ b/drivers/staging/media/av7110/av7110_av.c
@@ -241,8 +241,8 @@ int av7110_pes_play(void *dest, struct dvb_ringbuffer *buf, int dlen)
 		sync |= DVB_RINGBUFFER_PEEK(buf, 2) << 8;
 		sync |= DVB_RINGBUFFER_PEEK(buf, 3);
 
-		if (((sync &~0x0f) == 0x000001e0) ||
-		    ((sync &~0x1f) == 0x000001c0) ||
+		if (((sync & ~0x0f) == 0x000001e0) ||
+		    ((sync & ~0x1f) == 0x000001c0) ||
 		    (sync == 0x000001bd))
 			break;
 		printk("resync\n");
@@ -297,10 +297,10 @@ int av7110_set_volume(struct av7110 *av7110, unsigned int volleft,
 		return 0;
 
 	case DVB_ADAC_MSP34x0:
-		vol  = (volleft > volright) ? volleft : volright;
-		val	= (vol * 0x73 / 255) << 8;
+		vol = (volleft > volright) ? volleft : volright;
+		val = (vol * 0x73 / 255) << 8;
 		if (vol > 0)
-		       balance = ((volright - volleft) * 127) / vol;
+			balance = ((volright - volleft) * 127) / vol;
 		msp_writereg(av7110, MSP_WR_DSP, 0x0001, balance << 8);
 		msp_writereg(av7110, MSP_WR_DSP, 0x0000, val); /* loudspeaker */
 		msp_writereg(av7110, MSP_WR_DSP, 0x0006, val); /* headphonesr */
@@ -367,8 +367,8 @@ static int get_video_format(struct av7110 *av7110, u8 *buf, int count)
 		if (p[0] || p[1] || p[2] != 0x01 || p[3] != 0xb3)
 			continue;
 		p += 4;
-		hsize = ((p[1] &0xF0) >> 4) | (p[0] << 4);
-		vsize = ((p[1] &0x0F) << 8) | (p[2]);
+		hsize = ((p[1] & 0xF0) >> 4) | (p[0] << 4);
+		vsize = ((p[1] & 0x0F) << 8) | (p[2]);
 		sw = (p[3] & 0x0F);
 		ret = av7110_set_vidmode(av7110, sw2mode[sw]);
 		if (!ret) {
@@ -1059,13 +1059,16 @@ static int play_iframe(struct av7110 *av7110, char __user *buf, unsigned int len
 			continue;
 		}
 		switch (match++) {
-		case 2: if (c == 0x01)
+		case 2:
+			if (c == 0x01)
 				continue;
 			break;
-		case 3: if (c == 0xb5)
+		case 3:
+			if (c == 0xb5)
 				continue;
 			break;
-		case 4: if ((c & 0xf0) == 0x10)
+		case 4:
+			if ((c & 0xf0) == 0x10)
 				continue;
 			break;
 		}
@@ -1073,7 +1076,8 @@ static int play_iframe(struct av7110 *av7110, char __user *buf, unsigned int len
 	}
 
 	/* setting n always > 1, fixes problems when playing stillframes
-	   consisting of I- and P-Frames */
+	 * consisting of I- and P-Frames
+	 */
 	n = MIN_IFRAME / len + 1;
 
 	/* FIXME: nonblock? */
@@ -1542,9 +1546,8 @@ static int dvb_video_release(struct inode *inode, struct file *file)
 
 	dprintk(2, "av7110:%p,\n", av7110);
 
-	if ((file->f_flags & O_ACCMODE) != O_RDONLY) {
+	if ((file->f_flags & O_ACCMODE) != O_RDONLY)
 		av7110_av_stop(av7110, RP_VIDEO);
-	}
 
 	return dvb_generic_release(inode, file);
 }
-- 
2.40.1

