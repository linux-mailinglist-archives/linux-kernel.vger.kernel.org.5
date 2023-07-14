Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF218753BD5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 15:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbjGNNdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 09:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjGNNdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:33:40 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA909AA
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:33:38 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-5636425bf98so1051000eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689341617; x=1691933617;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YWY4YNS+EbmuNWWamzwc7m4BB3/3gxUR4DRrovzn/v4=;
        b=f3DPKrhUorft9itTcYsJbsBFgEJ+PhcsvkqKN1TbIoE9Ke8kLZI3yxiO3mV6hYDH5g
         CYfy/3dG3sVPORN3K5oC9aiXTa3y1ktGqq3JHonLc3E1zbDo/v6JSGOtMFFJ5RGDo5KF
         lWvzmP2+0JGy9Ije8woqxpzLtgu0ACzuFyziyHh4twjVNcDXldjWzFFJpCTSilqkOCug
         1FmAWOT1bH+rE1LWjkqrFWRUwqHHvC3OHanTyYNWYnJLSySR96nYKAN7pji2Z7V272iA
         yZDr87nsY/ks1VOJBUo8AOtzg5f0XyT7a4eyhRFSdfP6PVNMeBMwyo21Heoxygm3fJR/
         l90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689341617; x=1691933617;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YWY4YNS+EbmuNWWamzwc7m4BB3/3gxUR4DRrovzn/v4=;
        b=SHm5RFMS6ti0Xo0YE0IEjSTRCPi9bxgA24X/o0VUslL/dTyl6tJz1ZsSQNrDwkCa1V
         8N0SbwYa8zQaSIo0LTSsZ8NibetEoCVg/wObAs/+KualpdcSq0+gdDYkE1iQb3aHsUXH
         jPasZGul8R1cCucdSfHJg4jxZJUqG0s3sCb8EZVh2UzT++bAZsbfYKngIfWPdMyNhNq8
         n565ik9qtZS02CzD3q+HFL2P0jzOXmzkFPObUgUypClWIifOe4gMj6X67E1yhS4lwzM4
         VdmeVXKX6GI7PQPW/xdmH1k0gFgLScRdH8n0DePoFEmRU5DSl9HNRL3ROd5mKTPoZh/U
         ljRA==
X-Gm-Message-State: ABy/qLYCZCNmU7f9r+w383NmWi/99D+xUbrO63WxN8drDj38swTYSOtK
        5PY4bJz4HXGY31LMhMzauxg=
X-Google-Smtp-Source: APBJJlHSqNBy5iLs00S2rRV2fll3C/IB0bN9VX+6dGCtyNt9mnH9tTHFIKraxyRDB088WBcyYm0iCw==
X-Received: by 2002:a4a:621e:0:b0:566:fbfb:6278 with SMTP id x30-20020a4a621e000000b00566fbfb6278mr3713235ooc.4.1689341617371;
        Fri, 14 Jul 2023 06:33:37 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([187.19.173.165])
        by smtp.gmail.com with ESMTPSA id 123-20020a4a0d81000000b0056422cfb35csm3875784oob.40.2023.07.14.06.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 06:33:36 -0700 (PDT)
From:   arnaldo.melo@gmail.com
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0EAAC40516; Fri, 14 Jul 2023 10:33:34 -0300 (-03)
Date:   Fri, 14 Jul 2023 10:33:33 -0300
To:     linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        Jaroslav Kysela <perex@perex.cz>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/1 fyi] tools include UAPI: Sync the sound/asound.h copy
 with the kernel sources
Message-ID: <ZLFOrTE2+xZBgHGe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tldr; Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
  	[0] = "NORMAL",
  	[1] = "RANDOM",
  	[2] = "SEQUENTIAL",
  	[3] = "WILLNEED",
  	[4] = "DONTNEED",
  	[5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

---

Picking the changes from:

  01dfa8e969dbbc72 ("ALSA: ump: Add info flag bit for static blocks")
  e375b8a045873cf5 ("ALSA: ump: Add more attributes to UMP EP and FB info")
  30fc139260d46e9b ("ALSA: ump: Add ioctls to inquiry UMP EP and Block info via control API")
  127ae6f6dad2edb2 ("ALSA: rawmidi: Skip UMP devices at SNDRV_CTL_IOCTL_RAWMIDI_NEXT_DEVICE")
  e3a8a5b726bdd903 ("ALSA: rawmidi: UMP support")
  a4bb75c4f19db711 ("ALSA: uapi: pcm: control the filling of the silence samples for drain")

That harvests some new ioctls:

  $ tools/perf/trace/beauty/sndrv_ctl_ioctl.sh > before.ctl
  $ tools/perf/trace/beauty/sndrv_pcm_ioctl.sh > before.pcm
  $ cp include/uapi/sound/asound.h tools/include/uapi/sound/asound.h
  $ tools/perf/trace/beauty/sndrv_ctl_ioctl.sh > after.ctl
  $ tools/perf/trace/beauty/sndrv_pcm_ioctl.sh > after.pcm
  $ diff -u before.ctl after.ctl
  --- before.ctl	2023-07-14 10:17:00.319591889 -0300
  +++ after.ctl	2023-07-14 10:17:24.668248373 -0300
  @@ -22,6 +22,9 @@
   	[0x40] = "RAWMIDI_NEXT_DEVICE",
   	[0x41] = "RAWMIDI_INFO",
   	[0x42] = "RAWMIDI_PREFER_SUBDEVICE",
  +	[0x43] = "UMP_NEXT_DEVICE",
  +	[0x44] = "UMP_ENDPOINT_INFO",
  +	[0x45] = "UMP_BLOCK_INFO",
   	[0xd0] = "POWER",
   	[0xd1] = "POWER_STATE",
   };
  $ diff -u before.pcm after.pcm
  $

Now those will be decoded when they appear, see a system wide 'perf
trace' session example here:

  # perf trace -e ioctl --max-events=10
       0.000 ( 0.010 ms): gnome-shell/2240 ioctl(fd: 9, cmd: DRM_MODE_RMFB, arg: 0x7ffc0041d54c)         = 0
       2.444 ( 0.005 ms): wireplumber/2304 ioctl(fd: 47, cmd: TIOCOUTQ, arg: 0x7f16e9afea24)             = 0
       2.452 ( 0.002 ms): wireplumber/2304 ioctl(fd: 47, cmd: TIOCOUTQ, arg: 0x7f16e9afea24)             = 0
      11.348 ( 0.010 ms): gnome-shell/2240 ioctl(fd: 14, cmd: DRM_I915_IRQ_WAIT, arg: 0x7ffc0041ccf0)    = 0
      11.406 ( 0.037 ms): gnome-shel:cs0/2259 ioctl(fd: 14, cmd: DRM_I915_IRQ_EMIT, arg: 0x7f3cf69fdc60) = 0
      11.476 ( 0.009 ms): gnome-shell/2240 ioctl(fd: 9, cmd: DRM_MODE_ADDFB2, arg: 0x7ffc0041ce50)       = 0
      11.497 ( 0.019 ms): gnome-shell/2240 ioctl(fd: 9, cmd: DRM_MODE_ATOMIC, arg: 0x7ffc0041cdf0)       = 0
      12.481 ( 0.020 ms): firefox:cs0/3651 ioctl(fd: 40, cmd: DRM_I915_IRQ_EMIT, arg: 0x7f1c365fea60)    = 0
      12.529 ( 0.009 ms): firefox:cs0/3651 ioctl(fd: 40, cmd: DRM_I915_IRQ_EMIT, arg: 0x7f1c365feab0)    = 0
      12.624 ( 0.018 ms): firefox:cs0/3651 ioctl(fd: 40, cmd: DRM_I915_IRQ_EMIT, arg: 0x7f1c365fea30)    = 0
  #

Silencing these perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/include/uapi/sound/asound.h include/uapi/sound/asound.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/sound/asound.h | 81 ++++++++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/sound/asound.h b/tools/include/uapi/sound/asound.h
index 0aa955aa82463a63..f9939da4112272d4 100644
--- a/tools/include/uapi/sound/asound.h
+++ b/tools/include/uapi/sound/asound.h
@@ -274,6 +274,7 @@ typedef int __bitwise snd_pcm_subformat_t;
 #define SNDRV_PCM_INFO_DOUBLE		0x00000004	/* Double buffering needed for PCM start/stop */
 #define SNDRV_PCM_INFO_BATCH		0x00000010	/* double buffering */
 #define SNDRV_PCM_INFO_SYNC_APPLPTR	0x00000020	/* need the explicit sync of appl_ptr update */
+#define SNDRV_PCM_INFO_PERFECT_DRAIN	0x00000040	/* silencing at the end of stream is not required */
 #define SNDRV_PCM_INFO_INTERLEAVED	0x00000100	/* channels are interleaved */
 #define SNDRV_PCM_INFO_NONINTERLEAVED	0x00000200	/* channels are not interleaved */
 #define SNDRV_PCM_INFO_COMPLEX		0x00000400	/* complex frame organization (mmap only) */
@@ -383,6 +384,9 @@ typedef int snd_pcm_hw_param_t;
 #define SNDRV_PCM_HW_PARAMS_NORESAMPLE	(1<<0)	/* avoid rate resampling */
 #define SNDRV_PCM_HW_PARAMS_EXPORT_BUFFER	(1<<1)	/* export buffer */
 #define SNDRV_PCM_HW_PARAMS_NO_PERIOD_WAKEUP	(1<<2)	/* disable period wakeups */
+#define SNDRV_PCM_HW_PARAMS_NO_DRAIN_SILENCE	(1<<3)	/* suppress drain with the filling
+							 * of the silence samples
+							 */
 
 struct snd_interval {
 	unsigned int min, max;
@@ -708,7 +712,7 @@ enum {
  *  Raw MIDI section - /dev/snd/midi??
  */
 
-#define SNDRV_RAWMIDI_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 2)
+#define SNDRV_RAWMIDI_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 4)
 
 enum {
 	SNDRV_RAWMIDI_STREAM_OUTPUT = 0,
@@ -719,6 +723,7 @@ enum {
 #define SNDRV_RAWMIDI_INFO_OUTPUT		0x00000001
 #define SNDRV_RAWMIDI_INFO_INPUT		0x00000002
 #define SNDRV_RAWMIDI_INFO_DUPLEX		0x00000004
+#define SNDRV_RAWMIDI_INFO_UMP			0x00000008
 
 struct snd_rawmidi_info {
 	unsigned int device;		/* RO/WR (control): device number */
@@ -779,6 +784,72 @@ struct snd_rawmidi_status {
 };
 #endif
 
+/* UMP EP info flags */
+#define SNDRV_UMP_EP_INFO_STATIC_BLOCKS		0x01
+
+/* UMP EP Protocol / JRTS capability bits */
+#define SNDRV_UMP_EP_INFO_PROTO_MIDI_MASK	0x0300
+#define SNDRV_UMP_EP_INFO_PROTO_MIDI1		0x0100 /* MIDI 1.0 */
+#define SNDRV_UMP_EP_INFO_PROTO_MIDI2		0x0200 /* MIDI 2.0 */
+#define SNDRV_UMP_EP_INFO_PROTO_JRTS_MASK	0x0003
+#define SNDRV_UMP_EP_INFO_PROTO_JRTS_TX		0x0001 /* JRTS Transmit */
+#define SNDRV_UMP_EP_INFO_PROTO_JRTS_RX		0x0002 /* JRTS Receive */
+
+/* UMP Endpoint information */
+struct snd_ump_endpoint_info {
+	int card;			/* card number */
+	int device;			/* device number */
+	unsigned int flags;		/* additional info */
+	unsigned int protocol_caps;	/* protocol capabilities */
+	unsigned int protocol;		/* current protocol */
+	unsigned int num_blocks;	/* # of function blocks */
+	unsigned short version;		/* UMP major/minor version */
+	unsigned short family_id;	/* MIDI device family ID */
+	unsigned short model_id;	/* MIDI family model ID */
+	unsigned int manufacturer_id;	/* MIDI manufacturer ID */
+	unsigned char sw_revision[4];	/* software revision */
+	unsigned short padding;
+	unsigned char name[128];	/* endpoint name string */
+	unsigned char product_id[128];	/* unique product id string */
+	unsigned char reserved[32];
+} __packed;
+
+/* UMP direction */
+#define SNDRV_UMP_DIR_INPUT		0x01
+#define SNDRV_UMP_DIR_OUTPUT		0x02
+#define SNDRV_UMP_DIR_BIDIRECTION	0x03
+
+/* UMP block info flags */
+#define SNDRV_UMP_BLOCK_IS_MIDI1	(1U << 0) /* MIDI 1.0 port w/o restrict */
+#define SNDRV_UMP_BLOCK_IS_LOWSPEED	(1U << 1) /* 31.25Kbps B/W MIDI1 port */
+
+/* UMP block user-interface hint */
+#define SNDRV_UMP_BLOCK_UI_HINT_UNKNOWN		0x00
+#define SNDRV_UMP_BLOCK_UI_HINT_RECEIVER	0x01
+#define SNDRV_UMP_BLOCK_UI_HINT_SENDER		0x02
+#define SNDRV_UMP_BLOCK_UI_HINT_BOTH		0x03
+
+/* UMP groups and blocks */
+#define SNDRV_UMP_MAX_GROUPS		16
+#define SNDRV_UMP_MAX_BLOCKS		32
+
+/* UMP Block information */
+struct snd_ump_block_info {
+	int card;			/* card number */
+	int device;			/* device number */
+	unsigned char block_id;		/* block ID (R/W) */
+	unsigned char direction;	/* UMP direction */
+	unsigned char active;		/* Activeness */
+	unsigned char first_group;	/* first group ID */
+	unsigned char num_groups;	/* number of groups */
+	unsigned char midi_ci_version;	/* MIDI-CI support version */
+	unsigned char sysex8_streams;	/* max number of sysex8 streams */
+	unsigned char ui_hint;		/* user interface hint */
+	unsigned int flags;		/* various info flags */
+	unsigned char name[128];	/* block name string */
+	unsigned char reserved[32];
+} __packed;
+
 #define SNDRV_RAWMIDI_IOCTL_PVERSION	_IOR('W', 0x00, int)
 #define SNDRV_RAWMIDI_IOCTL_INFO	_IOR('W', 0x01, struct snd_rawmidi_info)
 #define SNDRV_RAWMIDI_IOCTL_USER_PVERSION _IOW('W', 0x02, int)
@@ -786,6 +857,9 @@ struct snd_rawmidi_status {
 #define SNDRV_RAWMIDI_IOCTL_STATUS	_IOWR('W', 0x20, struct snd_rawmidi_status)
 #define SNDRV_RAWMIDI_IOCTL_DROP	_IOW('W', 0x30, int)
 #define SNDRV_RAWMIDI_IOCTL_DRAIN	_IOW('W', 0x31, int)
+/* Additional ioctls for UMP rawmidi devices */
+#define SNDRV_UMP_IOCTL_ENDPOINT_INFO	_IOR('W', 0x40, struct snd_ump_endpoint_info)
+#define SNDRV_UMP_IOCTL_BLOCK_INFO	_IOR('W', 0x41, struct snd_ump_block_info)
 
 /*
  *  Timer section - /dev/snd/timer
@@ -961,7 +1035,7 @@ struct snd_timer_tread {
  *                                                                          *
  ****************************************************************************/
 
-#define SNDRV_CTL_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 8)
+#define SNDRV_CTL_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 9)
 
 struct snd_ctl_card_info {
 	int card;			/* card number */
@@ -1122,6 +1196,9 @@ struct snd_ctl_tlv {
 #define SNDRV_CTL_IOCTL_RAWMIDI_NEXT_DEVICE _IOWR('U', 0x40, int)
 #define SNDRV_CTL_IOCTL_RAWMIDI_INFO	_IOWR('U', 0x41, struct snd_rawmidi_info)
 #define SNDRV_CTL_IOCTL_RAWMIDI_PREFER_SUBDEVICE _IOW('U', 0x42, int)
+#define SNDRV_CTL_IOCTL_UMP_NEXT_DEVICE	_IOWR('U', 0x43, int)
+#define SNDRV_CTL_IOCTL_UMP_ENDPOINT_INFO _IOWR('U', 0x44, struct snd_ump_endpoint_info)
+#define SNDRV_CTL_IOCTL_UMP_BLOCK_INFO	_IOWR('U', 0x45, struct snd_ump_block_info)
 #define SNDRV_CTL_IOCTL_POWER		_IOWR('U', 0xd0, int)
 #define SNDRV_CTL_IOCTL_POWER_STATE	_IOR('U', 0xd1, int)
 
-- 
2.37.1

