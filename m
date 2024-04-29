Return-Path: <linux-kernel+bounces-162942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0788B6287
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2C2A28456A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF6A13C3C0;
	Mon, 29 Apr 2024 19:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMbY5EEA"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941E817597;
	Mon, 29 Apr 2024 19:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419571; cv=none; b=Fnd1B3uxXn1wLHo6vARW8U/ZAE7rnt/sTfL0i9l3+xST8ZSxqs6TEcYe7iQOOnVdFJ+nFq8zd2jypWB+WV2K+5MFkOpQR6ASkS2LTYXC4RN0Um6tQS13n5aYnFzJBiyp4swv/37uD50hC/6nKei27cm3beYoFN3CEzhE+SOqTjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419571; c=relaxed/simple;
	bh=BajpZ5nliXd+HrVvKA2TL+65LWIHmhnw26BZ8As/d0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LMdN+0A2PuE8ACZFDOFoL5CX41Jk0W34tMhrQH7bG5xc7lFRosav9IQQlSYbEF8B7QAXmHnoQ4dIBD8yUfY/8gYgkQmTnUJqhIQhqnC/vS4dItq6bKoqo+CqKlhRbzDcC+ZvvzRcYup3qtLVmU/1THDICwz29Q2trxZrPIfXeD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMbY5EEA; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7d6bc8d4535so207560939f.2;
        Mon, 29 Apr 2024 12:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714419569; x=1715024369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OThLtlQLHmt6Xu/dLjE7jt3V84uDU3HgUSM9F2dF2XI=;
        b=RMbY5EEA8CUgYof2WYrnLMHd3VodmgTFBp4nxU9Zd2gNtFyK5PtdSisPQU6W0agng6
         q3mIj8+kYK7TJG9x5y5RgC5jt3/3tvHFCgPQAjAsylFqKNqgHLM3cGYOG7hF93K4yoRS
         DUMDI/rY07toBb2tLqxyZiCO570fjON/ha0OBDNaA7wjIWkswYU+5peNIEEyFXZrkTuj
         sTVH1J7H/RV4yVOeJUco/M5nJBwNWH/BwIaVRSQAsMVblt9QWbSfU4mj/RVmFgxqz++k
         KsH1Dn9zmV3GfoltX8AImzytmFkAQIzGzrgyR0q0XOvHgA+Y58D3QZ/USEabR+1Udo3v
         Zm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714419569; x=1715024369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OThLtlQLHmt6Xu/dLjE7jt3V84uDU3HgUSM9F2dF2XI=;
        b=pOdxnqEq6EgiO7gfRNAI8u7ZXQrmhgdA9poI0pMdZoGM5FCZGFbZ/Z45JWprkuzHJa
         0FCZ2sHdUneppfDSZK+hlKfdHLz+ce9DVhgsYD1TcEHcCVjkhQuphXfKrZU7YUO73fAe
         v+l5j96B2gFzfycPpcPVI/qztxq4sLu0FPnTRzUgQHaWabttjJV1mqtYhG6Rw5I2mOkW
         IK0KvN8a/2ALDC7BR6cwILxjxZHwcOkHoEpH5DVtBRbVzeRvpQbiXszfwwfTX0iHJF4D
         ZUi8XOkcKsqN9KdqJCICQ3RGnye+abk/0yUgr5Mw3jJ6aS/vwNgpcqiB1eFVN6U+rQQ5
         XCnw==
X-Forwarded-Encrypted: i=1; AJvYcCVDsH+/SkD5XhkmMIUZAfa9ACgR7iauq/Wt4XKjMveM9xHruifQdmim44ljoP0UTVWQAWY5nUqgKeRkYwIPjlpTHmidVNlGJa8q84KP9EqETeMMkAk/zGTv/7z6h5N1rSVuLyL7IcmV
X-Gm-Message-State: AOJu0YwltVTtig7Jl5zoQAaqTkjIQBXVtvxPELKrqrwoH5zGx7uwWApq
	HJPLnBhIbxCg/cSrdoI2WJAg6Yng2Ba7aN2aYZHwK2W6VfM7QqBy
X-Google-Smtp-Source: AGHT+IG8SYyWWKZD11FY0NPPG/D9eJB+PcSN6dz+CzhLKof+BDDE1ptiGYSje0vARpyD55y/WCWs2A==
X-Received: by 2002:a05:6602:14f:b0:7d9:6568:144e with SMTP id v15-20020a056602014f00b007d96568144emr14013964iot.8.1714419568763;
        Mon, 29 Apr 2024 12:39:28 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id y16-20020a056602165000b007de9f92dc57sm2325105iow.16.2024.04.29.12.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:39:28 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: ukaszb@chromium.org,
	linux-doc@vger.kernel.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v8 21/35] dyndbg: treat comma as a token separator
Date: Mon, 29 Apr 2024 13:39:07 -0600
Message-ID: <20240429193921.66648-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429193921.66648-1-jim.cromie@gmail.com>
References: <20240429193921.66648-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Treat comma as a token terminator, just like a space.  This allows a
user to avoid quoting hassles when spaces are otherwise needed:

 :#> modprobe drm dyndbg=class,DRM_UT_CORE,+p\;class,DRM_UT_KMS,+p

or as a boot arg:

 drm.dyndbg=class,DRM_UT_CORE,+p  # todo: support multi-query here

Given the many ways a boot-line +args can be assembled and then passed
in/down/around shell based tools, this may allow side-stepping all
sorts of quoting hassles thru those layers.

existing query format:

 modprobe test_dynamic_debug dyndbg="class D2_CORE +p"

new format:

 modprobe test_dynamic_debug dyndbg=class,D2_CORE,+p

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Co-developed-by: Łukasz Bartosik <ukaszb@chromium.org>
Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
---
 lib/dynamic_debug.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 31fd67597928..c1bc728cb050 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -290,6 +290,14 @@ static int ddebug_change(const struct ddebug_query *query,
 	return nfound;
 }
 
+static char *skip_spaces_and_commas(const char *str)
+{
+	str = skip_spaces(str);
+	while (*str == ',')
+		str = skip_spaces(++str);
+	return (char *)str;
+}
+
 /*
  * Split the buffer `buf' into space-separated words.
  * Handles simple " and ' quoting, i.e. without nested,
@@ -303,8 +311,8 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 	while (*buf) {
 		char *end;
 
-		/* Skip leading whitespace */
-		buf = skip_spaces(buf);
+		/* Skip leading whitespace and comma */
+		buf = skip_spaces_and_commas(buf);
 		if (!*buf)
 			break;	/* oh, it was trailing whitespace */
 		if (*buf == '#')
@@ -320,7 +328,7 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 				return -EINVAL;	/* unclosed quote */
 			}
 		} else {
-			for (end = buf; *end && !isspace(*end); end++)
+			for (end = buf; *end && !isspace(*end) && *end != ','; end++)
 				;
 			if (end == buf) {
 				pr_err("parse err after word:%d=%s\n", nwords,
@@ -592,7 +600,8 @@ static int ddebug_exec_queries(char *query, const char *modname)
 		if (split)
 			*split++ = '\0';
 
-		query = skip_spaces(query);
+		query = skip_spaces_and_commas(query);
+
 		if (!query || !*query || *query == '#')
 			continue;
 
-- 
2.44.0


