Return-Path: <linux-kernel+bounces-17236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DC1824A43
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCA591C226F9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFA92C878;
	Thu,  4 Jan 2024 21:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RyjBMIql"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA852C87D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 21:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maheshb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbe053d5d91so1383463276.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 13:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704403482; x=1705008282; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YsAJCiIBvgndyLh0nU4MixTydeQR6acGfzT1miAC0JA=;
        b=RyjBMIqlE311DaqGjKy8LExpBMxE+BQp2X6F8mvzCH95q6TVq1tKDY0T54uYsB+5DP
         b0Z6IfUCXrj9WSq1O5DCiZLWC2oEXltk8NegwpqELO8BloDjjeiG9SQvijPnzQGJ90ra
         XOZLBtCzT7t65EX4DpnYDzgn/fTHcncyPgvr6Dx1PRLMqHZqUoBHRqrbjFQf7AeEz4Tx
         ePKE3F+zt6nZ3SeUP9DsqsirNN5uOHG2oyjpby+AjvyON4jGyX6u0wgw0+DiebrKOaE5
         omRjs0L/tdPO22I8DLCok5ETkYbNJF/X+/yg5+2T4xA6HbLvcYuLRTdYvet4Njd8XQPL
         qpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704403482; x=1705008282;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YsAJCiIBvgndyLh0nU4MixTydeQR6acGfzT1miAC0JA=;
        b=uwugIzTabKfCaSkLz1EdyuIbJuMqQNJ7BF/fP06SM4Yq5FvfG8psePuhg3j45svmgA
         fbJrZBP+0bGYjrwoMSSZ+v9jMj/WXRkqwPFUd5ixXC0cedgtehKN0GbDjRunIEDYJrfu
         VfQPgz1arpbTtbowV/lqfjldN0WJOgZzn1XnZ4dtA9lZSlvO0gPN0GvrYkZO8qCYaa9g
         T/a6MHEPgtDk+9J5HCSEtBeU1iWGxafshn6Jpf6q1TNjWpwGS3puW/HEreUObdXHdl0b
         vPeFkoi1E9D1Y9q9wEgHE5tXJcz1vPLACabt4JGNFIEJ4sE/hCAB4MXQUXoFF1efk0Mf
         YSqQ==
X-Gm-Message-State: AOJu0YxMco8iwAmm3AO26WoyAJdq18VG0naQw3Xgnj9iLaADeSGdLWZc
	KYf3w3/PmOgjoSxkudHWsyJp+2gfrQ2iwqDS4JY=
X-Google-Smtp-Source: AGHT+IHGUyHXVjIzF9I3UpGGe202gVTqGTWxOBA9wbyf98ZTRVjvXMqgV/cWw6j8j4Z4cTJlB395cEVW5BUY
X-Received: from coldfire.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2b7a])
 (user=maheshb job=sendgmr) by 2002:a05:690c:368b:b0:5de:9c9f:3ee4 with SMTP
 id fu11-20020a05690c368b00b005de9c9f3ee4mr625667ywb.6.1704403482530; Thu, 04
 Jan 2024 13:24:42 -0800 (PST)
Date: Thu,  4 Jan 2024 13:24:39 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.195.gebba966016-goog
Message-ID: <20240104212439.3276458-1-maheshb@google.com>
Subject: [PATCHv3 net-next 2/3] ptp: add ioctl interface for ptp_gettimex64any()
From: Mahesh Bandewar <maheshb@google.com>
To: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>, 
	David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>, Don Hatchett <hatch@google.com>, 
	Yuliang Li <yuliangli@google.com>, Mahesh Bandewar <mahesh@bandewar.net>, 
	Mahesh Bandewar <maheshb@google.com>, Richard Cochran <richardcochran@gmail.com>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"

add an ioctl op PTP_SYS_OFFSET_ANY to support newly added
ptp_gettimex64any() method

Signed-off-by: Mahesh Bandewar <maheshb@google.com>
CC: Richard Cochran <richardcochran@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>
CC: John Stultz <jstultz@google.com>
CC: Jakub Kicinski <kuba@kernel.org>
CC: "Willem de Bruijn" <willemb@google.com>
CC: netdev@vger.kernel.org
---
 drivers/ptp/ptp_chardev.c      | 37 ++++++++++++++++++++++++++++++++++
 include/uapi/linux/ptp_clock.h | 14 +++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 7513018c9f9a..f20d43c34aec 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -161,6 +161,7 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 	struct ptp_clock *ptp =
 		container_of(pccontext->clk, struct ptp_clock, clock);
 	struct ptp_sys_offset_extended *extoff = NULL;
+	struct ptp_sys_offset_any *anyoff = NULL;
 	struct ptp_sys_offset_precise precise_offset;
 	struct system_device_crosststamp xtstamp;
 	struct ptp_clock_info *ops = ptp->info;
@@ -378,6 +379,42 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 			err = -EFAULT;
 		break;
 
+	case PTP_SYS_OFFSET_ANY:
+		if (!ptp->info->gettimex64any) {
+			err = -EOPNOTSUPP;
+			break;
+		}
+		anyoff = memdup_user((void __user *)arg, sizeof(*anyoff));
+		if (IS_ERR(anyoff)) {
+			err = PTR_ERR(anyoff);
+			anyoff = NULL;
+			break;
+		}
+		if (anyoff->n_samples > PTP_MAX_SAMPLES
+		    || anyoff->rsv[0] || anyoff->rsv[1]
+		    || (anyoff->clockid != CLOCK_REALTIME
+			&& anyoff->clockid != CLOCK_MONOTONIC
+			&& anyoff->clockid != CLOCK_MONOTONIC_RAW)) {
+			err = -EINVAL;
+			break;
+		}
+
+		for (i = 0; i < anyoff->n_samples; i++) {
+			err = ptp->info->gettimex64any(ptp->info, &ts, &sts,
+						       anyoff->clockid);
+			if (err)
+				goto out;
+			anyoff->ts[i][0].sec = sts.pre_ts.tv_sec;
+			anyoff->ts[i][0].nsec = sts.pre_ts.tv_nsec;
+			anyoff->ts[i][1].sec = ts.tv_sec;
+			anyoff->ts[i][1].nsec = ts.tv_nsec;
+			anyoff->ts[i][2].sec = sts.post_ts.tv_sec;
+			anyoff->ts[i][2].nsec = sts.post_ts.tv_nsec;
+		}
+		if (copy_to_user((void __user *)arg, anyoff, sizeof(*anyoff)))
+			err = -EFAULT;
+		break;
+
 	case PTP_SYS_OFFSET:
 	case PTP_SYS_OFFSET2:
 		sysoff = memdup_user((void __user *)arg, sizeof(*sysoff));
diff --git a/include/uapi/linux/ptp_clock.h b/include/uapi/linux/ptp_clock.h
index da700999cad4..a3143df8de2b 100644
--- a/include/uapi/linux/ptp_clock.h
+++ b/include/uapi/linux/ptp_clock.h
@@ -158,6 +158,18 @@ struct ptp_sys_offset_extended {
 	struct ptp_clock_time ts[PTP_MAX_SAMPLES][3];
 };
 
+struct ptp_sys_offset_any {
+	unsigned int n_samples;		/* Desired number of measurements. */
+	clockid_t clockid;		/* One of the supported ClockID */
+	unsigned int rsv[2];		/* Reserved for future use. */
+	/*
+	 * Array of [TS, phc, TS] time stamps. The kernel will provide
+	 * 3*n_samples time stamps.
+	 * TS is any of the ts_type requested.
+	 */
+	struct ptp_clock_time ts[PTP_MAX_SAMPLES][3];
+};
+
 struct ptp_sys_offset_precise {
 	struct ptp_clock_time device;
 	struct ptp_clock_time sys_realtime;
@@ -226,6 +238,8 @@ struct ptp_pin_desc {
 	_IOWR(PTP_CLK_MAGIC, 18, struct ptp_sys_offset_extended)
 #define PTP_MASK_CLEAR_ALL  _IO(PTP_CLK_MAGIC, 19)
 #define PTP_MASK_EN_SINGLE  _IOW(PTP_CLK_MAGIC, 20, unsigned int)
+#define PTP_SYS_OFFSET_ANY \
+	_IOWR(PTP_CLK_MAGIC, 21, struct ptp_sys_offset_any)
 
 struct ptp_extts_event {
 	struct ptp_clock_time t; /* Time event occured. */
-- 
2.43.0.195.gebba966016-goog


