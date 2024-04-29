Return-Path: <linux-kernel+bounces-163082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 656078B64E6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25BB7282E5A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71EE184120;
	Mon, 29 Apr 2024 21:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lO7nRQOa"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F881802CF;
	Mon, 29 Apr 2024 21:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714427446; cv=none; b=sT6Jaed57HmawAbhJ9Gj+ltEeSRUMiDvJt8tasRWWuZ/WuSFRFa+TJ5cttqfsbuVwIY9fRArli8jHLX0BCDtIJXYMJ43bhpsXGXxwU4VKSSob48SjbkAqVjznsPADlWH+AM9JPQF0R7+gaBL787IJVpiafaVKrr6cktoww1ctT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714427446; c=relaxed/simple;
	bh=qPCS9g/zZA8fp8fMlrE5hztv2c9oq3fHJ3Jltx972jw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kexbCogF6aPJfyrtV/H9rbI1pZ5aMAjLRhyqjG7RlNqbbJKxACRNyhHZbTWIjc5l8c2u+FHq60v/Qf3eRZpM2uQ6TF8/erZ4o5Y0RmzpaX2YWQob1xI+rA9fP+1RjTHiif/ZxRRDkoq30hCCO0wCfJL8slQMyGqds89r83ycEoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lO7nRQOa; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5f807d941c4so3890407a12.0;
        Mon, 29 Apr 2024 14:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714427444; x=1715032244; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=feq+on9ujG3HDJjQ/ipIbYLZ3xlr6YMjv8piL05aAW0=;
        b=lO7nRQOagCrvjlA+pl38XLhbftG6ERy9jb28/KpruCg8hc/8RuQUFe7pkeSwOpXURt
         Ah7XyvDELcVL7n4r4IbePggDOK8synaN8UQJiSl0zHUYAsismDvjPZgnM+66O6nNaQdL
         TmYvCPYs+IDp3x3DnyBQjrx87o/kbKmrKHhv0+RPzCycFQkAMUkpMR0p1nRnY7Px/4JF
         Pj4uoZhZ9hXiTuvnbQBIDG+zfyqzFwwc1MxWD8Q8VS0HrQ1VZNHcv6Y5bvyKOU985Cpv
         H9tNYwfkdkqNz3n074Mk3U6d5FvRLCw7Z2MNZBi/wtkUxoJqbSHDwbVNfiYoVLbqYybk
         RHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714427444; x=1715032244;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=feq+on9ujG3HDJjQ/ipIbYLZ3xlr6YMjv8piL05aAW0=;
        b=WM6tMaByW0E98sc0tzmoEIy1LDLHZzBZ1dbaRJTeZxDuupOpVgC3M2zBHJjr3P7zUl
         EtdadxKhCqDM24S9cs0TIJjoturDbxaojVQ1wFV3JIUKz+oCOpx5TTc1uLhCcjQW+6hP
         ulCndC8h5LiLDNhZ9HEcgV5S2EapnI0FGEfLJAOWInkW3baTkr/D//w3UEv86P6++dWe
         G8qdwmjtx9CdwnYzEbrSQB43qwnPuLnxWg1r26YjaaXqSQjj3LIfzRelo8HesRmAr53e
         gaRLBGE7Nyxe3iY1RnXFZg4p9q74pzT0+hq/0YWItzGmyj3pK4t0qzDoCkUlfV0oPLMs
         PJ/A==
X-Forwarded-Encrypted: i=1; AJvYcCX2GHw4OfABOVWHKYyukiL8HKMXlQHG08QeL91/DZPWCjbnAuq8ETLY/7/bWK3vOc26kDYHiVYdH9ez2scwEvUCq4eKg3tTKE8Mojsk
X-Gm-Message-State: AOJu0Yxlv9TKnpJGFE+l2Zjwpw//a37PFkOTqyhfi8hVqrRBb+a05fsF
	9at2ehOZSl3UeVHD0coIT6gyYK+fmrd/ALSMHpCP5pmr/cdoFOLsTEkHkA==
X-Google-Smtp-Source: AGHT+IErLsqPy0vjXi0q5KxNhYnnybrwPmUeCGDb2LSEMNlTb2bjDT9zznI5ns5uxoHZSDCoeC0fKg==
X-Received: by 2002:a17:902:e546:b0:1e5:b82:2f82 with SMTP id n6-20020a170902e54600b001e50b822f82mr17193351plf.42.1714427444190;
        Mon, 29 Apr 2024 14:50:44 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:f2d8:c41e:613b:df5a])
        by smtp.gmail.com with ESMTPSA id b14-20020a170902650e00b001e5e6877494sm21288518plk.238.2024.04.29.14.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 14:50:43 -0700 (PDT)
Date: Mon, 29 Apr 2024 14:50:41 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Jason Andryuk <jandryuk@gmail.com>, Hans de Goede <hdegoede@redhat.com>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Input: try trimming too long modalias strings
Message-ID: <ZjAWMQCJdrxZkvkB@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

If an input device declares too many capability bits then modalias
string for such device may become too long and not fit into uevent
buffer, resulting in failure of sending said uevent. This, in turn,
may prevent userspace from recognizing existence of such devices.

This is typically not a concern for real hardware devices as they have
limited number of keys, but happen with synthetic devices such as
ones created by xen-kbdfront driver, which creates devices as being
capable of delivering all possible keys, since it doesn't know what
keys the backend may produce.

To deal with such devices input core will attempt to trim key data,
in the hope that the rest of modalias string will fit in the given
buffer. When trimming key data it will indicate that it is not
complete by placing "+," sign, resulting in conversions like this:

old: k71,72,73,74,78,7A,7B,7C,7D,8E,9E,A4,AD,E0,E1,E4,F8,174,
new: k71,72,73,74,78,7A,7B,7C,+,

This should allow existing udev rules continue to work with existing
devices, and will also allow writing more complex rules that would
recognize trimmed modalias and check input device characteristics by
other means (for example by parsing KEY= data in uevent or parsing
input device sysfs attributes).

Note that the driver core may try adding more uevent environment
variables once input core is done adding its own, so when forming
modalias we can not use the entire available buffer, so we reduce
it by somewhat an arbitrary amount (96 bytes).

Reported-by: Jason Andryuk <jandryuk@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

v2: do not use entire available buffer when formatting modalias, leave
    some space for driver core to add more data.

 drivers/input/input.c | 108 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 91 insertions(+), 17 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index b04bcdeee557..045f4b62088a 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1338,19 +1338,19 @@ static int input_print_modalias_bits(char *buf, int size,
 				     char name, const unsigned long *bm,
 				     unsigned int min_bit, unsigned int max_bit)
 {
-	int len = 0, i;
+	int bit = min_bit;
+	int len = 0;
 
 	len += snprintf(buf, max(size, 0), "%c", name);
-	for (i = min_bit; i < max_bit; i++)
-		if (bm[BIT_WORD(i)] & BIT_MASK(i))
-			len += snprintf(buf + len, max(size - len, 0), "%X,", i);
+	for_each_set_bit_from(bit, bm, max_bit)
+		len += snprintf(buf + len, max(size - len, 0), "%X,", bit);
 	return len;
 }
 
-static int input_print_modalias(char *buf, int size, const struct input_dev *id,
-				int add_cr)
+static int input_print_modalias_parts(char *buf, int size, int full_len,
+				      const struct input_dev *id)
 {
-	int len;
+	int len, klen, remainder, space;
 
 	len = snprintf(buf, max(size, 0),
 		       "input:b%04Xv%04Xp%04Xe%04X-",
@@ -1359,8 +1359,48 @@ static int input_print_modalias(char *buf, int size, const struct input_dev *id,
 
 	len += input_print_modalias_bits(buf + len, size - len,
 				'e', id->evbit, 0, EV_MAX);
-	len += input_print_modalias_bits(buf + len, size - len,
+
+	/*
+	 * Calculate the remaining space in the buffer making sure we
+	 * have place for the terminating 0.
+	 */
+	space = max(size - (len + 1), 0);
+
+	klen = input_print_modalias_bits(buf + len, size - len,
 				'k', id->keybit, KEY_MIN_INTERESTING, KEY_MAX);
+	len += klen;
+
+	/*
+	 * If we have more data than we can fit in the buffer, check
+	 * if we can trim key data to fit in the rest. We will indicate
+	 * that key data is incomplete by adding "+" sign at the end, like
+	 * this: * "k1,2,3,45,+,".
+	 *
+	 * Note that we shortest key info (if present) is "k+," so we
+	 * can only try to trim if key data is longer than that.
+	 */
+	if (full_len && size < full_len + 1 && klen > 3) {
+		remainder = full_len - len;
+		/*
+		 * We can only trim if we have space for the remainder
+		 * and also for at least "k+," which is 3 more characters.
+		 */
+		if (remainder <= space - 3) {
+			/*
+			 * We are guaranteed to have 'k' in the buffer, so
+			 * we need at least 3 additional bytes for storing
+			 * "+," in addition to the remainder.
+			 */
+			for (int i = size - 1 - remainder - 3; i >= 0; i--) {
+				if (buf[i] == 'k' || buf[i] == ',') {
+					strcpy(buf + i + 1, "+,");
+					len = i + 3; /* Not counting '\0' */
+					break;
+				}
+			}
+		}
+	}
+
 	len += input_print_modalias_bits(buf + len, size - len,
 				'r', id->relbit, 0, REL_MAX);
 	len += input_print_modalias_bits(buf + len, size - len,
@@ -1376,22 +1416,37 @@ static int input_print_modalias(char *buf, int size, const struct input_dev *id,
 	len += input_print_modalias_bits(buf + len, size - len,
 				'w', id->swbit, 0, SW_MAX);
 
-	if (add_cr)
-		len += snprintf(buf + len, max(size - len, 0), "\n");
-
 	return len;
 }
 
+static int input_print_modalias(char *buf, int size, const struct input_dev *id)
+{
+	int full_len;
+
+	/*
+	 * Printing is done in 2 passes: first one figures out total length
+	 * needed for the modalias string, second one will try to trim key
+	 * data in case when buffer is too small for the entire modalias.
+	 * If the buffer is too small regardless, it will fill as much as it
+	 * can (without trimming key data) into the buffer and leave it to
+	 * the caller to figure out what to do with the result.
+	 */
+	full_len = input_print_modalias_parts(NULL, 0, 0, id);
+	return input_print_modalias_parts(buf, size, full_len, id);
+}
+
 static ssize_t input_dev_show_modalias(struct device *dev,
 				       struct device_attribute *attr,
 				       char *buf)
 {
 	struct input_dev *id = to_input_dev(dev);
-	ssize_t len;
+	size_t len;
 
-	len = input_print_modalias(buf, PAGE_SIZE, id, 1);
+	len = input_print_modalias(buf, PAGE_SIZE, id);
+	if (len < PAGE_SIZE - 2)
+		len += snprintf(buf + len, PAGE_SIZE - len, "\n");
 
-	return min_t(int, len, PAGE_SIZE);
+	return min(len, PAGE_SIZE);
 }
 static DEVICE_ATTR(modalias, S_IRUGO, input_dev_show_modalias, NULL);
 
@@ -1601,6 +1656,23 @@ static int input_add_uevent_bm_var(struct kobj_uevent_env *env,
 	return 0;
 }
 
+/*
+ * This is a pretty gross hack. When building uevent data the driver core
+ * may try adding more environment variables to kobj_uevent_env without
+ * telling us, so we have no idea how much of the buffer we can use to
+ * avoid overflows/-ENOMEM elsewhere. To work around this let's artificially
+ * reduce amount of memory we will use for the modalias environment variable.
+ *
+ * The potential additions are:
+ *
+ * SEQNUM=18446744073709551615 - (%llu - 28 bytes)
+ * HOME=/ (6 bytes)
+ * PATH=/sbin:/bin:/usr/sbin:/usr/bin (34 bytes)
+ *
+ * 68 bytes total. Allow extra buffer - 96 bytes
+ */
+#define UEVENT_ENV_EXTRA_LEN	96
+
 static int input_add_uevent_modalias_var(struct kobj_uevent_env *env,
 					 const struct input_dev *dev)
 {
@@ -1610,9 +1682,11 @@ static int input_add_uevent_modalias_var(struct kobj_uevent_env *env,
 		return -ENOMEM;
 
 	len = input_print_modalias(&env->buf[env->buflen - 1],
-				   sizeof(env->buf) - env->buflen,
-				   dev, 0);
-	if (len >= (sizeof(env->buf) - env->buflen))
+				   (int)sizeof(env->buf) - env->buflen -
+					UEVENT_ENV_EXTRA_LEN,
+				   dev);
+	if (len >= ((int)sizeof(env->buf) - env->buflen -
+					UEVENT_ENV_EXTRA_LEN))
 		return -ENOMEM;
 
 	env->buflen += len;
-- 
2.44.0.769.g3c40516874-goog


-- 
Dmitry

