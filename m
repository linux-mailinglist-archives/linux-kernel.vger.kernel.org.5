Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791BE7D1997
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 01:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjJTXXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 19:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjJTXXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 19:23:48 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BF6D46;
        Fri, 20 Oct 2023 16:23:46 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c503dbe50dso21781421fa.1;
        Fri, 20 Oct 2023 16:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697844225; x=1698449025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ft8poZSombuD4W/Ja+9zHJlVT1MrHG6UJN71XEmxhrs=;
        b=bBmlnhePTWKOqHxKHFkqswkGtkHHFHObZkemZNO3jrxJN854MZcjm0zfKw8778GZkl
         pe607PeV3fe/QWzbiTCadyeVmAd1vXa5cDNA9vj1nX1Tq0TfObpcrE0lb4jOVLMdE+5y
         lmAIThfUGRLitH22EslSncY3IsvnIyl1QXU8GTQSOcvZ6j7pbDgW3KGVYxYHPYKz9Cph
         GtX6o+IK+CYtIIjm7qea8W/ZvS2sjlw7BeDhx0C0x+UycHZktlUW0iQaot5SqQEZMU6F
         fT2I/qHaNS0bSJ4w0Kev6yMBZckI38o8W9d2GtdWZ1UorN1LNFbJLjAQHRpiER5G+jqf
         ajmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697844225; x=1698449025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ft8poZSombuD4W/Ja+9zHJlVT1MrHG6UJN71XEmxhrs=;
        b=DlgFwCRSluY91mHst/k43EVS9SS/1QybHHmLnbCB9v4OvOu4/Quj5IaP0EfCuOX4fz
         SukJhSEEtkt1qRs6UfNk6SbdX44hQNMDvMirey6RZePpJ2s7HSgL/N5SlqCYu2Afv1w9
         UJfNRVLt3G5oEHb5W4qngN/+VDbyeKWBIh9K80l6ewb9eYUR3BdO71WEpC38wgXOopMy
         g2wgGD5gYIKgBusI8l1/dZf7+Fds/D3jrGeOY+bo3rn99zx7ZhCjzCk8E1HXpUqQkYB9
         S6ptm0XDIdnREKSFr3XqGM1KUzjB5FakVT1ecJ4j0uC9tlOu1pY0U3/ChgZMUGTBJe4U
         C5Xg==
X-Gm-Message-State: AOJu0YwoIcGL7A7osjoRa/urRAnxlWuWT5nELVsDUtWf8Dc235rjXMJT
        xZtj+pXsvsclfKNpRFnrEqY=
X-Google-Smtp-Source: AGHT+IH3qhg33gZLIJj1HkTZAlvQpIvBJf657LfTvsB7Eih1QmyOl5q1EkeSK6qH/+SGsoS0kavmCw==
X-Received: by 2002:a2e:a7c7:0:b0:2c5:1867:b0bd with SMTP id x7-20020a2ea7c7000000b002c51867b0bdmr1018904ljp.23.1697844224768;
        Fri, 20 Oct 2023 16:23:44 -0700 (PDT)
Received: from HP-ENVY-Notebook.lan (81-229-94-10-no68.tbcn.telia.com. [81.229.94.10])
        by smtp.googlemail.com with ESMTPSA id s5-20020a05651c048500b002ba586d27a2sm567571ljc.26.2023.10.20.16.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 16:23:44 -0700 (PDT)
From:   Jonathan Bergh <bergh.jonathan@gmail.com>
To:     mchehab@kernel.org
Cc:     gregkh@linuxfoundation.org, error27@gmail.com,
        linux-staging@lists.linux.dev, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH 1/5] staging: media: av7110: Fix missing newlines after declaration warnings
Date:   Sat, 21 Oct 2023 01:23:28 +0200
Message-Id: <20231020232332.55024-2-bergh.jonathan@gmail.com>
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

Fixed the following formatting problem:
 * Missing newlines after declarations

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/staging/media/av7110/av7110_av.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/staging/media/av7110/av7110_av.c b/drivers/staging/media/av7110/av7110_av.c
index 00dd6a7fea64..af3845406626 100644
--- a/drivers/staging/media/av7110/av7110_av.c
+++ b/drivers/staging/media/av7110/av7110_av.c
@@ -149,6 +149,7 @@ int av7110_av_start_record(struct av7110 *av7110, int av,
 int av7110_av_start_play(struct av7110 *av7110, int av)
 {
 	int ret = 0;
+
 	dprintk(2, "av7110:%p, \n", av7110);
 
 	if (av7110->rec_mode)
@@ -183,6 +184,7 @@ int av7110_av_start_play(struct av7110 *av7110, int av)
 int av7110_av_stop(struct av7110 *av7110, int av)
 {
 	int ret = 0;
+
 	dprintk(2, "av7110:%p, \n", av7110);
 
 	if (!(av7110->playing & av) && !(av7110->rec_mode & av))
@@ -320,6 +322,7 @@ int av7110_set_volume(struct av7110 *av7110, unsigned int volleft,
 int av7110_set_vidmode(struct av7110 *av7110, enum av7110_video_mode mode)
 {
 	int ret;
+
 	dprintk(2, "av7110:%p, \n", av7110);
 
 	ret = av7110_fw_cmd(av7110, COMTYPE_ENCODER, LoadVidCode, 1, mode);
@@ -408,6 +411,7 @@ static inline long aux_ring_buffer_write(struct dvb_ringbuffer *rbuf,
 static void play_video_cb(u8 *buf, int count, void *priv)
 {
 	struct av7110 *av7110 = (struct av7110 *) priv;
+
 	dprintk(2, "av7110:%p, \n", av7110);
 
 	if ((buf[3] & 0xe0) == 0xe0) {
@@ -420,6 +424,7 @@ static void play_video_cb(u8 *buf, int count, void *priv)
 static void play_audio_cb(u8 *buf, int count, void *priv)
 {
 	struct av7110 *av7110 = (struct av7110 *) priv;
+
 	dprintk(2, "av7110:%p, \n", av7110);
 
 	aux_ring_buffer_write(&av7110->aout, buf, count);
@@ -471,6 +476,7 @@ static ssize_t dvb_play(struct av7110 *av7110, const char __user *buf,
 			unsigned long count, int nonblock, int type)
 {
 	unsigned long todo = count, n;
+
 	dprintk(2, "av7110:%p, \n", av7110);
 
 	if (!av7110->kbuf[type])
@@ -504,6 +510,7 @@ static ssize_t dvb_play_kernel(struct av7110 *av7110, const u8 *buf,
 			unsigned long count, int nonblock, int type)
 {
 	unsigned long todo = count, n;
+
 	dprintk(2, "av7110:%p, \n", av7110);
 
 	if (!av7110->kbuf[type])
@@ -534,6 +541,7 @@ static ssize_t dvb_aplay(struct av7110 *av7110, const char __user *buf,
 			 unsigned long count, int nonblock, int type)
 {
 	unsigned long todo = count, n;
+
 	dprintk(2, "av7110:%p, \n", av7110);
 
 	if (!av7110->kbuf[type])
@@ -1039,6 +1047,7 @@ static int play_iframe(struct av7110 *av7110, char __user *buf, unsigned int len
 	/* search in buf for instances of 00 00 01 b5 1? */
 	for (i = 0; i < len; i++) {
 		unsigned char c;
+
 		if (get_user(c, buf + i))
 			return -EFAULT;
 		if (match == 5) {
@@ -1223,6 +1232,7 @@ static int dvb_video_ioctl(struct file *file,
 	case VIDEO_SET_DISPLAY_FORMAT:
 	{
 		video_displayformat_t format = (video_displayformat_t) arg;
+
 		switch (format) {
 		case VIDEO_PAN_SCAN:
 			av7110->display_panscan = VID_PAN_SCAN_PREF;
@@ -1483,6 +1493,7 @@ static int dvb_audio_ioctl(struct file *file,
 	case AUDIO_SET_MIXER:
 	{
 		struct audio_mixer *amix = (struct audio_mixer *)parg;
+
 		ret = av7110_set_volume(av7110, amix->volume_left, amix->volume_right);
 		break;
 	}
-- 
2.40.1

