Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810CB7D199A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 01:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbjJTXX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 19:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjJTXXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 19:23:51 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D03ED51;
        Fri, 20 Oct 2023 16:23:48 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c518a1d83fso22203451fa.3;
        Fri, 20 Oct 2023 16:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697844227; x=1698449027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2cKCGbV0vjVRHvgIodkiCSt+6sE3RRNYirzep6QnKc=;
        b=NrL+PeRrHj8biSV/KxFZ4yyOr1NRjh+rHXW57cbU/pmwSBHnp0c7t63gNZov2DKaFw
         kx1EA+bd3xZKXovy8R4ioFf21t2getGh6vqkq6VqJmviAKEK0M2tdhSMNO3kvkZiSWwU
         j2S/o8tSrYpOKniZ0dzGV7X/1ytmpZt/3LdZ+ooJOzKiNDakeOc5fOaKSXJGqmNcP3gk
         HmDez/0uN0LsTIJut6hon2HtPSNDLSgQ9iKB4BgL8wnIKqOgbysRAyJCz73s5Z26huG6
         044NIaUJB6J37FNtcBycjO2CPXxOpVKqLBAPaqtVrrLCXlGUd36IPXkBG7cM2/5Hi/s2
         ogdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697844227; x=1698449027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B2cKCGbV0vjVRHvgIodkiCSt+6sE3RRNYirzep6QnKc=;
        b=vdMrpUB/9u5JV7KdT+lACslbvl0jY3iGiUiUUxSq7vNt01Jh70V4a0m7tulIw36z9M
         utMlerFa3PHXySg+Kkjnj6UQ3dGkNLJDNGOpOR3QMZ3OpPb87twUWb+IAvUpqeybOS7s
         fDWgeJ+S0p+Q0R+Pt2NxuMgm+cuxv2seMS2kmFxzVoLaRsW/YGB1dtYAWJyttOco2YFx
         RV6Z88EOYGyCLdPEYLdnUxT2fBM1OWNw7z1tYnuFPFviBtA5siaQ2bagX68YUDW/wRg0
         whMcFjY6YXuAKgRJLQJjJKcvr3YrbdRpa2i/8OcVJRz4MaRFuyGubmWRLmkE4rukG9hs
         6n/w==
X-Gm-Message-State: AOJu0Yy8ATBzX3cYi4YfQvcDFeDReLGa0a9aKneTaS9XWSmSXv9S2vJT
        4ty1FQk/aCIhkGWochWhiKWEUILNxY1byg==
X-Google-Smtp-Source: AGHT+IFcn7s7tuoU0sEQV2uEqN5iFp1iooMeOLw0apoa4WejNIcewDVjx69zk51z+QHdQHwzZ44Vog==
X-Received: by 2002:a2e:a167:0:b0:2c5:12ae:adb3 with SMTP id u7-20020a2ea167000000b002c512aeadb3mr2257618ljl.44.1697844226406;
        Fri, 20 Oct 2023 16:23:46 -0700 (PDT)
Received: from HP-ENVY-Notebook.lan (81-229-94-10-no68.tbcn.telia.com. [81.229.94.10])
        by smtp.googlemail.com with ESMTPSA id s5-20020a05651c048500b002ba586d27a2sm567571ljc.26.2023.10.20.16.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 16:23:46 -0700 (PDT)
From:   Jonathan Bergh <bergh.jonathan@gmail.com>
To:     mchehab@kernel.org
Cc:     gregkh@linuxfoundation.org, error27@gmail.com,
        linux-staging@lists.linux.dev, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH 2/5] staging: media: av7110: Fix various whitespace checkpatch errors
Date:   Sat, 21 Oct 2023 01:23:29 +0200
Message-Id: <20231020232332.55024-3-bergh.jonathan@gmail.com>
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

Fixed the following checkpatch errors relating to whitespaces:
 * extra whitespace after '~' symbol
 * remove whitespace before/after parentheses for switch statement and
   function parameters as well as after switch keyword
 * ensure whitespace before '{' braces
 * remove whitespace between function name and '(' parentheses
 * ensure whitespace after ',' commas in parameter lists

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/staging/media/av7110/av7110_av.c | 28 ++++++++++++------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/media/av7110/av7110_av.c b/drivers/staging/media/av7110/av7110_av.c
index af3845406626..482dfc548b16 100644
--- a/drivers/staging/media/av7110/av7110_av.c
+++ b/drivers/staging/media/av7110/av7110_av.c
@@ -241,8 +241,8 @@ int av7110_pes_play(void *dest, struct dvb_ringbuffer *buf, int dlen)
 		sync |= DVB_RINGBUFFER_PEEK(buf, 2) << 8;
 		sync |= DVB_RINGBUFFER_PEEK(buf, 3);
 
-		if (((sync &~ 0x0f) == 0x000001e0) ||
-		    ((sync &~ 0x1f) == 0x000001c0) ||
+		if (((sync &~0x0f) == 0x000001e0) ||
+		    ((sync &~0x1f) == 0x000001c0) ||
 		    (sync == 0x000001bd))
 			break;
 		printk("resync\n");
@@ -599,7 +599,7 @@ static int find_pes_header(u8 const *buf, long int length, int *frags)
 	while (c < length - 3 && !found) {
 		if (buf[c] == 0x00 && buf[c + 1] == 0x00 &&
 		    buf[c + 2] == 0x01) {
-			switch ( buf[c + 3] ) {
+			switch (buf[c + 3]) {
 			case PROG_STREAM_MAP:
 			case PRIVATE_STREAM2:
 			case PROG_STREAM_DIR:
@@ -644,9 +644,9 @@ void av7110_p2t_write(u8 const *buf, long int length, u16 pid, struct av7110_p2t
 
 	c = 0;
 	c2 = 0;
-	if (p->frags){
+	if (p->frags) {
 		check = 0;
-		switch(p->frags) {
+		switch (p->frags) {
 		case 1:
 			if (buf[c] == 0x00 && buf[c + 1] == 0x01) {
 				check = 1;
@@ -712,7 +712,7 @@ void av7110_p2t_write(u8 const *buf, long int length, u16 pid, struct av7110_p2t
 		c2 = find_pes_header(buf + c + add, length - c - add, &p->frags);
 		if (c2 >= 0) {
 			c2 += c + add;
-			if (c2 > c){
+			if (c2 > c) {
 				p_to_t(buf + c, c2 - c, pid, &p->counter, p->feed);
 				c = c2;
 				clear_p2t(p);
@@ -798,7 +798,7 @@ static void p_to_t(u8 const *buf, long int length, u16 pid, u8 *counter,
 
 	while (c < length) {
 		memset(obuf, 0, TS_SIZE);
-		if (length - c >= (TS_SIZE - 4)){
+		if (length - c >= (TS_SIZE - 4)) {
 			l = write_ts_header2(pid, counter, pes_start,
 					     obuf, (TS_SIZE - 4));
 			memcpy(obuf + l, buf + c, TS_SIZE - l);
@@ -896,7 +896,7 @@ void dvb_video_add_event(struct av7110 *av7110, struct video_event *event)
 }
 
 
-static int dvb_video_get_event (struct av7110 *av7110, struct video_event *event, int flags)
+static int dvb_video_get_event(struct av7110 *av7110, struct video_event *event, int flags)
 {
 	struct dvb_video_events *events = &av7110->video_events;
 
@@ -1135,11 +1135,11 @@ static int dvb_video_ioctl(struct file *file,
 	unsigned long arg = (unsigned long) parg;
 	int ret = 0;
 
-	dprintk(1, "av7110:%p, cmd=%04x\n", av7110,cmd);
+	dprintk(1, "av7110:%p, cmd=%04x\n", av7110, cmd);
 
 	if ((file->f_flags & O_ACCMODE) == O_RDONLY) {
-		if ( cmd != VIDEO_GET_STATUS && cmd != VIDEO_GET_EVENT &&
-		     cmd != VIDEO_GET_SIZE ) {
+		if (cmd != VIDEO_GET_STATUS && cmd != VIDEO_GET_EVENT &&
+		     cmd != VIDEO_GET_SIZE) {
 			return -EPERM;
 		}
 	}
@@ -1367,7 +1367,7 @@ static int dvb_audio_ioctl(struct file *file,
 	unsigned long arg = (unsigned long) parg;
 	int ret = 0;
 
-	dprintk(1, "av7110:%p, cmd=%04x\n", av7110,cmd);
+	dprintk(1, "av7110:%p, cmd=%04x\n", av7110, cmd);
 
 	if (((file->f_flags & O_ACCMODE) == O_RDONLY) &&
 	    (cmd != AUDIO_GET_STATUS))
@@ -1433,7 +1433,7 @@ static int dvb_audio_ioctl(struct file *file,
 
 	case AUDIO_CHANNEL_SELECT:
 		av7110->audiostate.channel_select = (audio_channel_select_t) arg;
-		switch(av7110->audiostate.channel_select) {
+		switch (av7110->audiostate.channel_select) {
 		case AUDIO_STEREO:
 			ret = audcom(av7110, AUDIO_CMD_STEREO);
 			if (!ret) {
@@ -1642,7 +1642,7 @@ int av7110_av_register(struct av7110 *av7110)
 	spin_lock_init(&av7110->video_events.lock);
 	av7110->video_events.eventw = av7110->video_events.eventr = 0;
 	av7110->video_events.overflow = 0;
-	memset(&av7110->video_size, 0, sizeof (video_size_t));
+	memset(&av7110->video_size, 0, sizeof(video_size_t));
 
 	dvb_register_device(&av7110->dvb_adapter, &av7110->video_dev,
 			    &dvbdev_video, av7110, DVB_DEVICE_VIDEO, 0);
-- 
2.40.1

