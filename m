Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C886B7D199D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 01:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjJTXX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 19:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjJTXXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 19:23:52 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29013D69;
        Fri, 20 Oct 2023 16:23:50 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c50d1b9f22so18906361fa.0;
        Fri, 20 Oct 2023 16:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697844228; x=1698449028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xhWAgGK0TG28Y9dbvSoZSMOb85wa6hi070VtZ0aDXM=;
        b=WsxuE0TSh0Boeex3OAwIiqC8IZdl2bRmNY7g/T4V7oG49wNXKuxOdRtE/iQ/TR0w6g
         R7BLzAgQYUugEiGiKBLeaG8e0ozTj6Sy7f91ZI9VS3Ge8EuMXmY800AjbT2UssQFtW2d
         EBSDR2NpGgQ9keRfTJjr7VgucJ4NtaSS+CPOYvnyJLrnBPALc2rEowg0u/W77YMORSzB
         zOEUnBzkGNzU6JcuPad6dh79XQW6zXtqKnANPgpipLGiuP5xdbm14yuOKLHpAvJa9xyl
         6Ixz7u+qcUZql0XTMZ/KVeGyYv5P1My+EIcnSLl8IvJStWdvrutkpIYe+dib6+L2JBC3
         zQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697844228; x=1698449028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xhWAgGK0TG28Y9dbvSoZSMOb85wa6hi070VtZ0aDXM=;
        b=GJFrJqLnER6PRsAAmtgnRyxwvL5oH2690SKcNFZnAhGR3L6H7I6mBdP729F/H3N55s
         VcB5YOSqzWHPKHm7m80isPAmlE65m4i2ZZrq+symhnCWaxZk/lF2AfuFg84/exzY0PEn
         93Qqzrol0kLP32JPME8npqPQboVzqenoswuGpV0n4Ou2KGidgHJdPFTAkaMu7IDdmHAn
         XvRYGISKRMu2GFzaEuqzbhOGNvv45QCau9gIAcUQLVygRwz45FnSaALZHx+oQaUO6woB
         Z4JgWDbeuR6lCycE1XdRb9F9n73nsvKJJ4ZPoZwV6SgS32VI4nR2cbb3R+z/EdifkO95
         +n0g==
X-Gm-Message-State: AOJu0YxcfRxu5HwANXJNGdN3p/Q/OaXLp8J/okH5Lo6EqDRu2F2/qxo1
        eGe0xdQ3m70zQsmybW5CYNg=
X-Google-Smtp-Source: AGHT+IHrjAeBhMYFWXCuO9SFqEudVERTl67HkWwFQZR6Ixb+Eu6iGapsOJfS46ZJQHfoT7mKR9xDig==
X-Received: by 2002:a2e:7c15:0:b0:2c5:5926:de52 with SMTP id x21-20020a2e7c15000000b002c55926de52mr2231584ljc.53.1697844228180;
        Fri, 20 Oct 2023 16:23:48 -0700 (PDT)
Received: from HP-ENVY-Notebook.lan (81-229-94-10-no68.tbcn.telia.com. [81.229.94.10])
        by smtp.googlemail.com with ESMTPSA id s5-20020a05651c048500b002ba586d27a2sm567571ljc.26.2023.10.20.16.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 16:23:47 -0700 (PDT)
From:   Jonathan Bergh <bergh.jonathan@gmail.com>
To:     mchehab@kernel.org
Cc:     gregkh@linuxfoundation.org, error27@gmail.com,
        linux-staging@lists.linux.dev, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH 3/5] staging: media: av7110: Remove unnecessary whitespace before quoted newlines
Date:   Sat, 21 Oct 2023 01:23:30 +0200
Message-Id: <20231020232332.55024-4-bergh.jonathan@gmail.com>
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

Fixed multiple instances where whitespaces were placed before quoted
newlines

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/staging/media/av7110/av7110_av.c | 40 ++++++++++++------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/media/av7110/av7110_av.c b/drivers/staging/media/av7110/av7110_av.c
index 482dfc548b16..880fa8a314ba 100644
--- a/drivers/staging/media/av7110/av7110_av.c
+++ b/drivers/staging/media/av7110/av7110_av.c
@@ -150,7 +150,7 @@ int av7110_av_start_play(struct av7110 *av7110, int av)
 {
 	int ret = 0;
 
-	dprintk(2, "av7110:%p, \n", av7110);
+	dprintk(2, "av7110:%p,\n", av7110);
 
 	if (av7110->rec_mode)
 		return -EBUSY;
@@ -185,7 +185,7 @@ int av7110_av_stop(struct av7110 *av7110, int av)
 {
 	int ret = 0;
 
-	dprintk(2, "av7110:%p, \n", av7110);
+	dprintk(2, "av7110:%p,\n", av7110);
 
 	if (!(av7110->playing & av) && !(av7110->rec_mode & av))
 		return 0;
@@ -272,7 +272,7 @@ int av7110_set_volume(struct av7110 *av7110, unsigned int volleft,
 	unsigned int vol, val, balance = 0;
 	int err;
 
-	dprintk(2, "av7110:%p, \n", av7110);
+	dprintk(2, "av7110:%p,\n", av7110);
 
 	av7110->mixer.volume_left = volleft;
 	av7110->mixer.volume_right = volright;
@@ -323,7 +323,7 @@ int av7110_set_vidmode(struct av7110 *av7110, enum av7110_video_mode mode)
 {
 	int ret;
 
-	dprintk(2, "av7110:%p, \n", av7110);
+	dprintk(2, "av7110:%p,\n", av7110);
 
 	ret = av7110_fw_cmd(av7110, COMTYPE_ENCODER, LoadVidCode, 1, mode);
 
@@ -358,7 +358,7 @@ static int get_video_format(struct av7110 *av7110, u8 *buf, int count)
 	u8 *p;
 	int ret = 0;
 
-	dprintk(2, "av7110:%p, \n", av7110);
+	dprintk(2, "av7110:%p,\n", av7110);
 
 	if (av7110->sinfo)
 		return 0;
@@ -412,7 +412,7 @@ static void play_video_cb(u8 *buf, int count, void *priv)
 {
 	struct av7110 *av7110 = (struct av7110 *) priv;
 
-	dprintk(2, "av7110:%p, \n", av7110);
+	dprintk(2, "av7110:%p,\n", av7110);
 
 	if ((buf[3] & 0xe0) == 0xe0) {
 		get_video_format(av7110, buf, count);
@@ -425,7 +425,7 @@ static void play_audio_cb(u8 *buf, int count, void *priv)
 {
 	struct av7110 *av7110 = (struct av7110 *) priv;
 
-	dprintk(2, "av7110:%p, \n", av7110);
+	dprintk(2, "av7110:%p,\n", av7110);
 
 	aux_ring_buffer_write(&av7110->aout, buf, count);
 }
@@ -477,7 +477,7 @@ static ssize_t dvb_play(struct av7110 *av7110, const char __user *buf,
 {
 	unsigned long todo = count, n;
 
-	dprintk(2, "av7110:%p, \n", av7110);
+	dprintk(2, "av7110:%p,\n", av7110);
 
 	if (!av7110->kbuf[type])
 		return -ENOBUFS;
@@ -511,7 +511,7 @@ static ssize_t dvb_play_kernel(struct av7110 *av7110, const u8 *buf,
 {
 	unsigned long todo = count, n;
 
-	dprintk(2, "av7110:%p, \n", av7110);
+	dprintk(2, "av7110:%p,\n", av7110);
 
 	if (!av7110->kbuf[type])
 		return -ENOBUFS;
@@ -542,7 +542,7 @@ static ssize_t dvb_aplay(struct av7110 *av7110, const char __user *buf,
 {
 	unsigned long todo = count, n;
 
-	dprintk(2, "av7110:%p, \n", av7110);
+	dprintk(2, "av7110:%p,\n", av7110);
 
 	if (!av7110->kbuf[type])
 		return -ENOBUFS;
@@ -847,7 +847,7 @@ int av7110_write_to_decoder(struct dvb_demux_feed *feed, const u8 *buf, size_t l
 	struct dvb_demux *demux = feed->demux;
 	struct av7110 *av7110 = demux->priv;
 
-	dprintk(2, "av7110:%p, \n", av7110);
+	dprintk(2, "av7110:%p,\n", av7110);
 
 	if (av7110->full_ts && demux->dmx.frontend->source != DMX_MEMORY_FE)
 		return 0;
@@ -937,7 +937,7 @@ static __poll_t dvb_video_poll(struct file *file, poll_table *wait)
 	struct av7110 *av7110 = dvbdev->priv;
 	__poll_t mask = 0;
 
-	dprintk(2, "av7110:%p, \n", av7110);
+	dprintk(2, "av7110:%p,\n", av7110);
 
 	if ((file->f_flags & O_ACCMODE) != O_RDONLY)
 		poll_wait(file, &av7110->avout.queue, wait);
@@ -967,7 +967,7 @@ static ssize_t dvb_video_write(struct file *file, const char __user *buf,
 	struct av7110 *av7110 = dvbdev->priv;
 	unsigned char c;
 
-	dprintk(2, "av7110:%p, \n", av7110);
+	dprintk(2, "av7110:%p,\n", av7110);
 
 	if ((file->f_flags & O_ACCMODE) == O_RDONLY)
 		return -EPERM;
@@ -989,7 +989,7 @@ static __poll_t dvb_audio_poll(struct file *file, poll_table *wait)
 	struct av7110 *av7110 = dvbdev->priv;
 	__poll_t mask = 0;
 
-	dprintk(2, "av7110:%p, \n", av7110);
+	dprintk(2, "av7110:%p,\n", av7110);
 
 	poll_wait(file, &av7110->aout.queue, wait);
 
@@ -1009,7 +1009,7 @@ static ssize_t dvb_audio_write(struct file *file, const char __user *buf,
 	struct av7110 *av7110 = dvbdev->priv;
 	unsigned char c;
 
-	dprintk(2, "av7110:%p, \n", av7110);
+	dprintk(2, "av7110:%p,\n", av7110);
 
 	if (av7110->audiostate.stream_source != AUDIO_SOURCE_MEMORY) {
 		printk(KERN_ERR "not audio source memory\n");
@@ -1034,7 +1034,7 @@ static int play_iframe(struct av7110 *av7110, char __user *buf, unsigned int len
 	int progressive = 0;
 	int match = 0;
 
-	dprintk(2, "av7110:%p, \n", av7110);
+	dprintk(2, "av7110:%p,\n", av7110);
 
 	if (len == 0)
 		return 0;
@@ -1516,7 +1516,7 @@ static int dvb_video_open(struct inode *inode, struct file *file)
 	struct av7110 *av7110 = dvbdev->priv;
 	int err;
 
-	dprintk(2, "av7110:%p, \n", av7110);
+	dprintk(2, "av7110:%p,\n", av7110);
 
 	if ((err = dvb_generic_open(inode, file)) < 0)
 		return err;
@@ -1540,7 +1540,7 @@ static int dvb_video_release(struct inode *inode, struct file *file)
 	struct dvb_device *dvbdev = file->private_data;
 	struct av7110 *av7110 = dvbdev->priv;
 
-	dprintk(2, "av7110:%p, \n", av7110);
+	dprintk(2, "av7110:%p,\n", av7110);
 
 	if ((file->f_flags & O_ACCMODE) != O_RDONLY) {
 		av7110_av_stop(av7110, RP_VIDEO);
@@ -1555,7 +1555,7 @@ static int dvb_audio_open(struct inode *inode, struct file *file)
 	struct av7110 *av7110 = dvbdev->priv;
 	int err = dvb_generic_open(inode, file);
 
-	dprintk(2, "av7110:%p, \n", av7110);
+	dprintk(2, "av7110:%p,\n", av7110);
 
 	if (err < 0)
 		return err;
@@ -1569,7 +1569,7 @@ static int dvb_audio_release(struct inode *inode, struct file *file)
 	struct dvb_device *dvbdev = file->private_data;
 	struct av7110 *av7110 = dvbdev->priv;
 
-	dprintk(2, "av7110:%p, \n", av7110);
+	dprintk(2, "av7110:%p,\n", av7110);
 
 	av7110_av_stop(av7110, RP_AUDIO);
 	return dvb_generic_release(inode, file);
-- 
2.40.1

