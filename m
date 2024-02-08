Return-Path: <linux-kernel+bounces-58850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D37AB84ED8E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C6A7281E64
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5732763110;
	Thu,  8 Feb 2024 23:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="L3n78pcm"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DBE537E5;
	Thu,  8 Feb 2024 23:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707434093; cv=none; b=ddlKvzXNusnz0WE9bqfRXwiHf+7g7j0ieVentkOG0dt1EgEveTKHB+skg/fpwCN+tSacJ4sX/jQAS5d5dK+kTrBOICuUd522d672MIn/gL9vQSdzpOeK0MhJOSbZqNZmmbXsENB1Z0poFxPO6t4SlSvTh98+dHkXeZaSA5MOTio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707434093; c=relaxed/simple;
	bh=yy60iKclSo3I7kupLIIW7Eb4iC2/mPynjDbi7rSIXPs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GthPIRtNP0otJOzH1KJpQ1OrWEzeOIwdvpVufS21dhiR63y8aW3D/JzJgyBbBCHf0jCNFoZFyEzA6HYuAUrIjswWUVY4Yd46CEx1mdGsfmx2R0wjYMxplaDpC3n68i8NzvHyHN2LFyb28shulQg4hPzMnwYVrLoTcevnAKxWNbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=L3n78pcm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 418MWNU3030202;
	Thu, 8 Feb 2024 23:14:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=o7vHP4LLBYG3S+3r5ZuU
	O0gEZ9lpoN/n15JMZp7r2rw=; b=L3n78pcmE8qwrYpvEEGi6AdCzwlrz0/oApnt
	P4C+agKIkJFC8TkHvhg3A2XgVOOU6F7ozdc5HdkSMIE8MrGtCLJ2WZ/mVLc78vn6
	Mk93i3hdknOE5Yye570GYfs1zZ7h3gfjW+pFyJKrmgcLyfnf4WKcmVBymSDgPRZG
	rdWb5ES/xApcBEnMAx88aMyiBiEFNrEpxOKiKZL8AVF+4cP/sX0niilGWolLtEWs
	coHqnPqQjixKIP8FiAl3iZpylTkaKNu8aEh9c0hSDQmO0pur9L7/aes5yO6as4T7
	d59y13/KoOPRre30rJxyQey5rxDqUh7e8Y6/XUXUBDdkYVyiCQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w4rk82k4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 23:14:24 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 418NEN1b013158
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 Feb 2024 23:14:23 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 8 Feb 2024 15:14:22 -0800
From: Wesley Cheng <quic_wcheng@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <broonie@kernel.org>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <konrad.dybcio@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v14 26/53] ALSA: usb-audio: Export USB SND APIs for modules
Date: Thu, 8 Feb 2024 15:13:39 -0800
Message-ID: <20240208231406.27397-27-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240208231406.27397-1-quic_wcheng@quicinc.com>
References: <20240208231406.27397-1-quic_wcheng@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mqwc83T7FKcEuXvUvAHEja6LlEPewGh4
X-Proofpoint-ORIG-GUID: mqwc83T7FKcEuXvUvAHEja6LlEPewGh4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_11,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402080131

Some vendor modules will utilize useful parsing and endpoint management
APIs to start audio playback/capture.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 sound/usb/card.c     |  4 +++
 sound/usb/endpoint.c |  1 +
 sound/usb/helper.c   |  1 +
 sound/usb/pcm.c      | 75 +++++++++++++++++++++++++++++++-------------
 sound/usb/pcm.h      | 11 +++++++
 5 files changed, 71 insertions(+), 21 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index ca4f3bc1b42d..7dc8007ba839 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -1061,6 +1061,7 @@ int snd_usb_lock_shutdown(struct snd_usb_audio *chip)
 		wake_up(&chip->shutdown_wait);
 	return err;
 }
+EXPORT_SYMBOL_GPL(snd_usb_lock_shutdown);
 
 /* autosuspend and unlock the shutdown */
 void snd_usb_unlock_shutdown(struct snd_usb_audio *chip)
@@ -1069,6 +1070,7 @@ void snd_usb_unlock_shutdown(struct snd_usb_audio *chip)
 	if (atomic_dec_and_test(&chip->usage_count))
 		wake_up(&chip->shutdown_wait);
 }
+EXPORT_SYMBOL_GPL(snd_usb_unlock_shutdown);
 
 int snd_usb_autoresume(struct snd_usb_audio *chip)
 {
@@ -1091,6 +1093,7 @@ int snd_usb_autoresume(struct snd_usb_audio *chip)
 	}
 	return 0;
 }
+EXPORT_SYMBOL_GPL(snd_usb_autoresume);
 
 void snd_usb_autosuspend(struct snd_usb_audio *chip)
 {
@@ -1104,6 +1107,7 @@ void snd_usb_autosuspend(struct snd_usb_audio *chip)
 	for (i = 0; i < chip->num_interfaces; i++)
 		usb_autopm_put_interface(chip->intf[i]);
 }
+EXPORT_SYMBOL_GPL(snd_usb_autosuspend);
 
 static int usb_audio_suspend(struct usb_interface *intf, pm_message_t message)
 {
diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 8f65349a06d3..9876abb80853 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -1513,6 +1513,7 @@ int snd_usb_endpoint_prepare(struct snd_usb_audio *chip,
 	mutex_unlock(&chip->mutex);
 	return err;
 }
+EXPORT_SYMBOL_GPL(snd_usb_endpoint_prepare);
 
 /* get the current rate set to the given clock by any endpoint */
 int snd_usb_endpoint_get_clock_rate(struct snd_usb_audio *chip, int clock)
diff --git a/sound/usb/helper.c b/sound/usb/helper.c
index bf80e55d013a..4322ae3738e6 100644
--- a/sound/usb/helper.c
+++ b/sound/usb/helper.c
@@ -62,6 +62,7 @@ void *snd_usb_find_csint_desc(void *buffer, int buflen, void *after, u8 dsubtype
 	}
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(snd_usb_find_csint_desc);
 
 /*
  * Wrapper for usb_control_msg().
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 08bf535ed163..3adb09ce1702 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -148,6 +148,16 @@ find_format(struct list_head *fmt_list_head, snd_pcm_format_t format,
 	return found;
 }
 
+const struct audioformat *
+snd_usb_find_format(struct list_head *fmt_list_head, snd_pcm_format_t format,
+	    unsigned int rate, unsigned int channels, bool strict_match,
+	    struct snd_usb_substream *subs)
+{
+	return find_format(fmt_list_head, format, rate, channels, strict_match,
+			subs);
+}
+EXPORT_SYMBOL_GPL(snd_usb_find_format);
+
 static const struct audioformat *
 find_substream_format(struct snd_usb_substream *subs,
 		      const struct snd_pcm_hw_params *params)
@@ -157,6 +167,14 @@ find_substream_format(struct snd_usb_substream *subs,
 			   true, subs);
 }
 
+const struct audioformat *
+snd_usb_find_substream_format(struct snd_usb_substream *subs,
+		      const struct snd_pcm_hw_params *params)
+{
+	return find_substream_format(subs, params);
+}
+EXPORT_SYMBOL_GPL(snd_usb_find_substream_format);
+
 bool snd_usb_pcm_has_fixed_rate(struct snd_usb_substream *subs)
 {
 	const struct audioformat *fp;
@@ -461,20 +479,9 @@ static void close_endpoints(struct snd_usb_audio *chip,
 	}
 }
 
-/*
- * hw_params callback
- *
- * allocate a buffer and set the given audio format.
- *
- * so far we use a physically linear buffer although packetize transfer
- * doesn't need a continuous area.
- * if sg buffer is supported on the later version of alsa, we'll follow
- * that.
- */
-static int snd_usb_hw_params(struct snd_pcm_substream *substream,
-			     struct snd_pcm_hw_params *hw_params)
+int snd_usb_hw_params(struct snd_usb_substream *subs,
+				struct snd_pcm_hw_params *hw_params)
 {
-	struct snd_usb_substream *subs = substream->runtime->private_data;
 	struct snd_usb_audio *chip = subs->stream->chip;
 	const struct audioformat *fmt;
 	const struct audioformat *sync_fmt;
@@ -499,7 +506,7 @@ static int snd_usb_hw_params(struct snd_pcm_substream *substream,
 	if (fmt->implicit_fb) {
 		sync_fmt = snd_usb_find_implicit_fb_sync_format(chip, fmt,
 								hw_params,
-								!substream->stream,
+								!subs->direction,
 								&sync_fixed_rate);
 		if (!sync_fmt) {
 			usb_audio_dbg(chip,
@@ -579,15 +586,28 @@ static int snd_usb_hw_params(struct snd_pcm_substream *substream,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(snd_usb_hw_params);
 
 /*
- * hw_free callback
+ * hw_params callback
  *
- * reset the audio format and release the buffer
+ * allocate a buffer and set the given audio format.
+ *
+ * so far we use a physically linear buffer although packetize transfer
+ * doesn't need a continuous area.
+ * if sg buffer is supported on the later version of alsa, we'll follow
+ * that.
  */
-static int snd_usb_hw_free(struct snd_pcm_substream *substream)
+static int snd_usb_pcm_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *hw_params)
 {
 	struct snd_usb_substream *subs = substream->runtime->private_data;
+
+	return snd_usb_hw_params(subs, hw_params);
+}
+
+int snd_usb_hw_free(struct snd_usb_substream *subs)
+{
 	struct snd_usb_audio *chip = subs->stream->chip;
 
 	snd_media_stop_pipeline(subs);
@@ -603,6 +623,19 @@ static int snd_usb_hw_free(struct snd_pcm_substream *substream)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(snd_usb_hw_free);
+
+/*
+ * hw_free callback
+ *
+ * reset the audio format and release the buffer
+ */
+static int snd_usb_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_usb_substream *subs = substream->runtime->private_data;
+
+	return snd_usb_hw_free(subs);
+}
 
 /* free-wheeling mode? (e.g. dmix) */
 static int in_free_wheeling_mode(struct snd_pcm_runtime *runtime)
@@ -1746,8 +1779,8 @@ static int snd_usb_substream_capture_trigger(struct snd_pcm_substream *substream
 static const struct snd_pcm_ops snd_usb_playback_ops = {
 	.open =		snd_usb_pcm_open,
 	.close =	snd_usb_pcm_close,
-	.hw_params =	snd_usb_hw_params,
-	.hw_free =	snd_usb_hw_free,
+	.hw_params =	snd_usb_pcm_hw_params,
+	.hw_free =	snd_usb_pcm_hw_free,
 	.prepare =	snd_usb_pcm_prepare,
 	.trigger =	snd_usb_substream_playback_trigger,
 	.sync_stop =	snd_usb_pcm_sync_stop,
@@ -1758,8 +1791,8 @@ static const struct snd_pcm_ops snd_usb_playback_ops = {
 static const struct snd_pcm_ops snd_usb_capture_ops = {
 	.open =		snd_usb_pcm_open,
 	.close =	snd_usb_pcm_close,
-	.hw_params =	snd_usb_hw_params,
-	.hw_free =	snd_usb_hw_free,
+	.hw_params =	snd_usb_pcm_hw_params,
+	.hw_free =	snd_usb_pcm_hw_free,
 	.prepare =	snd_usb_pcm_prepare,
 	.trigger =	snd_usb_substream_capture_trigger,
 	.sync_stop =	snd_usb_pcm_sync_stop,
diff --git a/sound/usb/pcm.h b/sound/usb/pcm.h
index 388fe2ba346d..be2dd9478982 100644
--- a/sound/usb/pcm.h
+++ b/sound/usb/pcm.h
@@ -15,4 +15,15 @@ void snd_usb_preallocate_buffer(struct snd_usb_substream *subs);
 int snd_usb_audioformat_set_sync_ep(struct snd_usb_audio *chip,
 				    struct audioformat *fmt);
 
+const struct audioformat *
+snd_usb_find_format(struct list_head *fmt_list_head, snd_pcm_format_t format,
+	    unsigned int rate, unsigned int channels, bool strict_match,
+	    struct snd_usb_substream *subs);
+const struct audioformat *
+snd_usb_find_substream_format(struct snd_usb_substream *subs,
+		      const struct snd_pcm_hw_params *params);
+
+int snd_usb_hw_params(struct snd_usb_substream *subs,
+				struct snd_pcm_hw_params *hw_params);
+int snd_usb_hw_free(struct snd_usb_substream *subs);
 #endif /* __USBAUDIO_PCM_H */

