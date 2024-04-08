Return-Path: <linux-kernel+bounces-135981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3389689CE89
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 00:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D811C283538
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C738228389;
	Mon,  8 Apr 2024 22:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlpXbQUq"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAE617745
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 22:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712616283; cv=none; b=Jt+n5kKzG8HrTanB8TBpGBN1IkSLMzo0+iTGnnjZN83+R+toYOb+qL05WRYKIqonoU7MZ3ml+CEhuP4SFgKrM/aB3+fEjqB+eesQmiJM7MLjcb91dS+O6RIh6p4x9Iy+R2s8Tc6R0kmmTLlF6CrMyA+SWUP6XTrDjzwXjoehxlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712616283; c=relaxed/simple;
	bh=+/3t9ECBsy9ODFlP5YpFi+yWmEkcPNa80UvzDk2CLnE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EByVUuqcDV/c7gfJRPxZUXQA724BoIu43UJou+7vrohMF3P6dj6jdXRGcfG96nH3VzmYvFIKsxs5xtWXcbWwSuCrncg6ttEYLgAsSivYhpAJGyg3/ZYKqdqkIAhDuqgA5vtgKNRBaOrMn3sGW+jA3u9ah1lS98Kcj8hQ5WwHsNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlpXbQUq; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ecff9df447so3761239b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 15:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712616281; x=1713221081; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CKZc4c8lA2wcnIkG9X93w8id7DRu1ED4YOIT0xR9IFU=;
        b=WlpXbQUqGyCTKFTTIpTuZdcopQXAkOhEZbL5uqxDz0uAxrCGNXTU5shyBux2UKNO6x
         iw25bQNuo1294yQXZrJCxCUNOtpBSpjDm89mWXX22V7A1LxTWJfHLecana3e107UmxyL
         EBWla1M7Zeoi2zdSWYGrbZliyzehX7U473dyiDnrAiPGhIsE0RqlUtK7+U6t6xmkkWda
         Gd13AuaYz4EWKAoxEMfOSjdKCCv9x3s0i40e/QWHiDw7YgSuBZbZjjb1ygBJ3wSNrvfv
         oOLAN/nfq+DJYmKxrdB+hlwg3PeFqV6nxcQV/pVALrAa4fPByZRpdxjxtkY9/qxbwerY
         s2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712616281; x=1713221081;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CKZc4c8lA2wcnIkG9X93w8id7DRu1ED4YOIT0xR9IFU=;
        b=lzXNsOhaeZZL7/8X4y00JSwmRmPJO/W40QBz0IXSdnqAncl7K/j+ivWlqaUOSRL8s5
         6oBB9TeC3z4Ne8u+Ii32UGRbTalKAmBI3Tjbqb0oV9KY8xpkCBCXWtWr2h1fWwYrHgGK
         O4YIrv/BVxBimCodnfNNwJiZWyifwRrMLqbNK3tQrDhW4hf3LyBQLmcvPjLGHkkr/AT5
         1n92PwZ5fpH5gAlBkWVH20gqN2ewQF54sXYOJfrLJylwd0Xw/Ys1U5VE+n1wkbFyiIHN
         cgpGy/eLrNqUNI1/S7FRmyomUoWJW7q3kckolmTC3uvGqVlFbePotZQ0cT9khEc89F+v
         w2mA==
X-Forwarded-Encrypted: i=1; AJvYcCUo4HOSgjJFIdVW5NZkUjRSR8FS0kXryRcQKBy8Sd83hp95l6DkkvVAVwkvGuYS/Je826kvNwS5gtvcwLbp5A8fWYvgJwWVBZCHdaRr
X-Gm-Message-State: AOJu0YyeCqSaeKHCckyJB13MM4qVIJUoNpNT/xFdLvcjRLxb7owByMeV
	FDWYv0Tq/pfgIY0t8kNK0E7OlIQPX+IQ4vSd5lMp86eg9vCqbwg39QMp4rPY3nwlCQ==
X-Google-Smtp-Source: AGHT+IEQ6x5BfJgpVcqBxhQ0jHQpLc5V1u824p3HKlh4QMBlx8Di6OTQ0/e9hWxZu5kSqTeI1bVx+w==
X-Received: by 2002:a05:6a20:c901:b0:1a7:6ca9:2925 with SMTP id gx1-20020a056a20c90100b001a76ca92925mr5739021pzb.59.1712616281303;
        Mon, 08 Apr 2024 15:44:41 -0700 (PDT)
Received: from jc-ubuntu-dev-korn-1 (c-98-210-1-68.hsd1.ca.comcast.net. [98.210.1.68])
        by smtp.gmail.com with ESMTPSA id m6-20020a17090a34c600b0029be7922b32sm9623026pjf.26.2024.04.08.15.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 15:44:40 -0700 (PDT)
Date: Mon, 8 Apr 2024 15:44:40 -0700
From: Jackson Chui <jacksonchui.qwerty@gmail.com>
To: Jackson Chui <jacksonchui.qwerty@gmail.com>
Cc: Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [Patch v2] staging: greybus: Replace gcam macros with direct dev log
 calls
Message-ID: <ZhRzWNiak1qOdJLL@jc-ubuntu-dev-korn-1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reported by checkpatch:

CHECK: Macro argument 'gcam' may be better as '(gcam)' to avoid
precedence issues

Inline standard calls to 'dev_*' kernel logging functions, in favor
of 'gcam_*' macros, to clear up gcam-related logging.

Signed-off-by: Jackson Chui <jacksonchui.qwerty@gmail.com>

---
Changes in v2:
  - Inline 'dev_*' logging functions, over wrappers and macros
    to just use the standard call.
  - Remove 'gcam_*' macros, since they are no longer used.
---
 drivers/staging/greybus/camera.c | 58 +++++++++++++++-----------------
 1 file changed, 27 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
index a8173aa3a995..b8b2bdfa59e5 100644
--- a/drivers/staging/greybus/camera.c
+++ b/drivers/staging/greybus/camera.c
@@ -180,10 +180,6 @@ static const struct gb_camera_fmt_info *gb_camera_get_format_info(u16 gb_fmt)
 
 #define GB_CAMERA_MAX_SETTINGS_SIZE	8192
 
-#define gcam_dbg(gcam, format...)	dev_dbg(&gcam->bundle->dev, format)
-#define gcam_info(gcam, format...)	dev_info(&gcam->bundle->dev, format)
-#define gcam_err(gcam, format...)	dev_err(&gcam->bundle->dev, format)
-
 static int gb_camera_operation_sync_flags(struct gb_connection *connection,
 					  int type, unsigned int flags,
 					  void *request, size_t request_size,
@@ -232,8 +228,8 @@ static int gb_camera_get_max_pkt_size(struct gb_camera *gcam,
 
 		fmt_info = gb_camera_get_format_info(cfg->format);
 		if (!fmt_info) {
-			gcam_err(gcam, "unsupported greybus image format: %d\n",
-				 cfg->format);
+			dev_err(&gcam->bundle->dev, "unsupported greybus image format: %d\n",
+				cfg->format);
 			return -EIO;
 		}
 
@@ -241,18 +237,18 @@ static int gb_camera_get_max_pkt_size(struct gb_camera *gcam,
 			pkt_size = le32_to_cpu(cfg->max_pkt_size);
 
 			if (pkt_size == 0) {
-				gcam_err(gcam,
-					 "Stream %u: invalid zero maximum packet size\n",
-					 i);
+				dev_err(&gcam->bundle->dev,
+					"Stream %u: invalid zero maximum packet size\n",
+					i);
 				return -EIO;
 			}
 		} else {
 			pkt_size = le16_to_cpu(cfg->width) * fmt_info->bpp / 8;
 
 			if (pkt_size != le32_to_cpu(cfg->max_pkt_size)) {
-				gcam_err(gcam,
-					 "Stream %u: maximum packet size mismatch (%u/%u)\n",
-					 i, pkt_size, cfg->max_pkt_size);
+				dev_err(&gcam->bundle->dev,
+					"Stream %u: maximum packet size mismatch (%u/%u)\n",
+					i, pkt_size, cfg->max_pkt_size);
 				return -EIO;
 			}
 		}
@@ -275,13 +271,13 @@ static const int gb_camera_configure_streams_validate_response(struct gb_camera
 
 	/* Validate the returned response structure */
 	if (resp->padding[0] || resp->padding[1]) {
-		gcam_err(gcam, "response padding != 0\n");
+		dev_err(&gcam->bundle->dev, "response padding != 0\n");
 		return -EIO;
 	}
 
 	if (resp->num_streams > nstreams) {
-		gcam_err(gcam, "got #streams %u > request %u\n",
-			 resp->num_streams, nstreams);
+		dev_err(&gcam->bundle->dev, "got #streams %u > request %u\n",
+			resp->num_streams, nstreams);
 		return -EIO;
 	}
 
@@ -289,7 +285,7 @@ static const int gb_camera_configure_streams_validate_response(struct gb_camera
 		struct gb_camera_stream_config_response *cfg = &resp->config[i];
 
 		if (cfg->padding) {
-			gcam_err(gcam, "stream #%u padding != 0\n", i);
+			dev_err(&gcam->bundle->dev, "stream #%u padding != 0\n", i);
 			return -EIO;
 		}
 	}
@@ -340,16 +336,16 @@ static int gb_camera_set_power_mode(struct gb_camera *gcam, bool hs)
 
 	ret = gb_camera_set_intf_power_mode(gcam, intf->interface_id, hs);
 	if (ret < 0) {
-		gcam_err(gcam, "failed to set module interface to %s (%d)\n",
-			 hs ? "HS" : "PWM", ret);
+		dev_err(&gcam->bundle->dev, "failed to set module interface to %s (%d)\n",
+			hs ? "HS" : "PWM", ret);
 		return ret;
 	}
 
 	ret = gb_camera_set_intf_power_mode(gcam, svc->ap_intf_id, hs);
 	if (ret < 0) {
 		gb_camera_set_intf_power_mode(gcam, intf->interface_id, !hs);
-		gcam_err(gcam, "failed to set AP interface to %s (%d)\n",
-			 hs ? "HS" : "PWM", ret);
+		dev_err(&gcam->bundle->dev, "failed to set AP interface to %s (%d)\n",
+			hs ? "HS" : "PWM", ret);
 		return ret;
 	}
 
@@ -435,7 +431,7 @@ static int gb_camera_setup_data_connection(struct gb_camera *gcam,
 			   sizeof(csi_cfg),
 			   GB_APB_REQUEST_CSI_TX_CONTROL, false);
 	if (ret < 0) {
-		gcam_err(gcam, "failed to start the CSI transmitter\n");
+		dev_err(&gcam->bundle->dev, "failed to start the CSI transmitter\n");
 		goto error_power;
 	}
 
@@ -470,7 +466,7 @@ static void gb_camera_teardown_data_connection(struct gb_camera *gcam)
 			   GB_APB_REQUEST_CSI_TX_CONTROL, false);
 
 	if (ret < 0)
-		gcam_err(gcam, "failed to stop the CSI transmitter\n");
+		dev_err(&gcam->bundle->dev, "failed to stop the CSI transmitter\n");
 
 	/* Set the UniPro link to low speed mode. */
 	gb_camera_set_power_mode(gcam, false);
@@ -507,7 +503,7 @@ static int gb_camera_capabilities(struct gb_camera *gcam,
 					     NULL, 0,
 					     (void *)capabilities, size);
 	if (ret)
-		gcam_err(gcam, "failed to retrieve capabilities: %d\n", ret);
+		dev_err(&gcam->bundle->dev, "failed to retrieve capabilities: %d\n", ret);
 
 done:
 	mutex_unlock(&gcam->mutex);
@@ -723,22 +719,22 @@ static int gb_camera_request_handler(struct gb_operation *op)
 	struct gb_message *request;
 
 	if (op->type != GB_CAMERA_TYPE_METADATA) {
-		gcam_err(gcam, "Unsupported unsolicited event: %u\n", op->type);
+		dev_err(&gcam->bundle->dev, "Unsupported unsolicited event: %u\n", op->type);
 		return -EINVAL;
 	}
 
 	request = op->request;
 
 	if (request->payload_size < sizeof(*payload)) {
-		gcam_err(gcam, "Wrong event size received (%zu < %zu)\n",
-			 request->payload_size, sizeof(*payload));
+		dev_err(&gcam->bundle->dev, "Wrong event size received (%zu < %zu)\n",
+			request->payload_size, sizeof(*payload));
 		return -EINVAL;
 	}
 
 	payload = request->payload;
 
-	gcam_dbg(gcam, "received metadata for request %u, frame %u, stream %u\n",
-		 payload->request_id, payload->frame_number, payload->stream);
+	dev_dbg(&gcam->bundle->dev, "received metadata for request %u, frame %u, stream %u\n",
+		payload->request_id, payload->frame_number, payload->stream);
 
 	return 0;
 }
@@ -1347,15 +1343,15 @@ static int gb_camera_resume(struct device *dev)
 
 	ret = gb_connection_enable(gcam->connection);
 	if (ret) {
-		gcam_err(gcam, "failed to enable connection: %d\n", ret);
+		dev_err(&gcam->bundle->dev, "failed to enable connection: %d\n", ret);
 		return ret;
 	}
 
 	if (gcam->data_connection) {
 		ret = gb_connection_enable(gcam->data_connection);
 		if (ret) {
-			gcam_err(gcam,
-				 "failed to enable data connection: %d\n", ret);
+			dev_err(&gcam->bundle->dev,
+				"failed to enable data connection: %d\n", ret);
 			return ret;
 		}
 	}
-- 
2.34.1


