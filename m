Return-Path: <linux-kernel+bounces-161219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A028B492C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 04:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 899BC282A8D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 02:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA8710FF;
	Sun, 28 Apr 2024 02:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pe5lSJYR"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217CCEC3;
	Sun, 28 Apr 2024 02:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714269971; cv=none; b=DXNGpD+oU2QoWH3uWqW06KWL6nzLTcN9VD6w9dQxUG8uUzs8B9PJdC0EeIhXy17dEv/K6fOLcT00kx1dGoms5xNG0sLIZ2z7SXDwLpRWk8w9QjTz7JjFSBhUJzUFvYeI6dbcI9IXB9x5vhWCUG4GPhngdGBqFRzFltp87wVbLRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714269971; c=relaxed/simple;
	bh=ng7UA1wMkoX0EkfTSyYAoFSCY+qn4UjiAXy3rtO3t8A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JgUk3RPEreNxlhuGxhVokK+nQTUWQyNqE7wgI7knPGw/w+hbgfw1v9Eu4jc+o78nfKG4wrle9WMIfdfLtskSsL74g7npkJNuv8Zv3Or0UkbEKt6Qxw8uUKM29ISXYOdi8p6KJpWcRCD7gxaqXCh61N9Qjh1CCwS+mT9icJJvWXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pe5lSJYR; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e8bbcbc2b7so31234215ad.0;
        Sat, 27 Apr 2024 19:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714269969; x=1714874769; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UVr/DsPFcrO1zzvU0JwqUmPsGbHr+7DKpdqoMyfPVh8=;
        b=Pe5lSJYRyRt2cF08AXULExQECgw3bv+pe6v+CMOqfDM/LYfv/GfvVAQkDH0+tMjGKr
         l9Vd3wQiU/rLtpmXoJmWB9tOOTJONMqUgZvw022/BEePftuTHiBtGlcfHXJ7OgcN/xgZ
         sOTnPqQGl8nwAqCnU6eUpxS6UsKAlC7wNjE8+HwRsqlyTgDFtJ3LynHE3dVCAhk5GMTB
         puV45Hh2zDjzXLVBxQdXAIMt47LstVrz1wxRv80qIaIbX/M0qBlM4fvhU25kYQVgcFRF
         yKyQml2NEX4ae8OkqbIl1mwvGZhaaTM/bxUPZvJe6jGFbyPJhNUa351ExsjwajYi2XqW
         H5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714269969; x=1714874769;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UVr/DsPFcrO1zzvU0JwqUmPsGbHr+7DKpdqoMyfPVh8=;
        b=fW7ekJu953MH91vhK7bP/tJR5luh/uJIYzGTEj5Pc407im2uRNfiIHSQKoxupyDtw2
         gHNBS2NvDd6UeGKZA7dDmWaZsf/1kxx4cjjZA3c8cH6m8CARElaVeni38dQyonshKrWq
         RcTKG9YqVXVazwRIuM6eQpTU3AHu9955wyxUlMAPJ5W/DsL7GmKGa4/EBY8BvYtndVyV
         /0Sieyb1UkW24KVCzwTjwYwMQJ1bNo4cn4+ktjTHNFDJikK2FMtddIwHmXjgf83ICwJJ
         PM4eIcL4G1pkNFw/jerzxzaeZ+4j1JmIY7qAxy+H3lR0lqjOVqlGtIBfjKB6GvSBaemQ
         dOxw==
X-Forwarded-Encrypted: i=1; AJvYcCWyriamwFfKrEw3Jc1lLYGjl7h9S42AZOlGjU4ZA/ZahhuOecZ40UzUIqKtJyJvehQSAZjcuZhbXLGGrJy4wcXTcs9C7V+JnvK+WV+4
X-Gm-Message-State: AOJu0YxtYwgwOdgRnUD2XDaxF2dQ++jisBRkq8AlY1K6mTmmamLywtV5
	AniFkmE8T6tR13oQSxlp0YELQE9OU8dLh5w+30j1CKl20DalpnVhaOo1cQ==
X-Google-Smtp-Source: AGHT+IEI5Ioi6VZREHu6xMA6dF8tohoFLcfdd3XXsgDg1psejZCJgNTvO5LXrzCV3vUQJ4JI/BbLjQ==
X-Received: by 2002:a17:902:a9c5:b0:1e3:d0fd:236c with SMTP id b5-20020a170902a9c500b001e3d0fd236cmr7263411plr.37.1714269968848;
        Sat, 27 Apr 2024 19:06:08 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:5ae9:912b:8980:d67c])
        by smtp.gmail.com with ESMTPSA id i5-20020a170902c94500b001eb3dae7ef1sm2246243pla.16.2024.04.27.19.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 19:06:08 -0700 (PDT)
Date: Sat, 27 Apr 2024 19:06:05 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Jason Andryuk <jandryuk@gmail.com>, Hans de Goede <hdegoede@redhat.com>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Input: try trimming too long modalias strings
Message-ID: <Zi2vDUZuVAEh4-yS@google.com>
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

Reported-by: Jason Andryuk <jandryuk@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/input.c | 85 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 70 insertions(+), 15 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index b04bcdeee557..947b514174e4 100644
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
 
@@ -1611,7 +1666,7 @@ static int input_add_uevent_modalias_var(struct kobj_uevent_env *env,
 
 	len = input_print_modalias(&env->buf[env->buflen - 1],
 				   sizeof(env->buf) - env->buflen,
-				   dev, 0);
+				   dev);
 	if (len >= (sizeof(env->buf) - env->buflen))
 		return -ENOMEM;
 
-- 
2.44.0.769.g3c40516874-goog


-- 
Dmitry

