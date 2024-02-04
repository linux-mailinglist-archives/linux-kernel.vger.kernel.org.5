Return-Path: <linux-kernel+bounces-51663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFDA848E0B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E94C1C22189
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BF6224ED;
	Sun,  4 Feb 2024 13:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="M7Tk1yVt"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE2A224D2;
	Sun,  4 Feb 2024 13:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707053360; cv=none; b=Z7B15bt4Dw2LxK9JHx9Wf5B1iQM02SK5+ShDnWRzi8e7uZHtV30OGJ+BOYkkykuCIe7SjxnqHn9iXtf0JIS9Eirc7oBmofP0GCwQGCMAIvJtqFUe2EwJoECHVMHJPS/k8b5+gwKuyrBBaStqr2gWicoLAmXgx/RcZeyHzrDHH5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707053360; c=relaxed/simple;
	bh=JM+4cXRZO8fIkL2koBG39D9ifJnLbSeAqF3/Wh6APII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nhu8SeC49UQD0oDu9XphXz5YhYC9kgHXMsX5j3IbUWZuuep2ap1KT/8Uq3846RMK0SPIpQMKDSxGLWFti+DYcleJdjhrC7d/eaGwPJB58cu5YUPIRNReWI6b5GepO+ZYQ94RDj4e3U2Z1GzPSAb1FI6oV+Y2ia9aUJ793fFMEbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=M7Tk1yVt reason="key not found in DNS"; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bd4e6a7cb0so2447211b6e.3;
        Sun, 04 Feb 2024 05:29:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707053358; x=1707658158;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmTYu8gBuYUWmnBfvEGkbpRkd3FkMWxeuI8Kl4keTd0=;
        b=RyVAmDlNefBCq4tjZ6nOrgOisg8C1YxGQ4JZLMNWoJCxIyn8OgJ/u+KAX8qYP2YMpF
         QAeFmT2LXttOmWco6uRKAtQGzD4k2GGvcJeFGc1qSNuZlk1UKlD7/r0Oln3V1jNuc/FJ
         Deqxo1Z5qOudh3ImKxtNJtcSn0+rF8UU/pOPRCmjldLSNW/KmAy5WJCfzMXmhYuPzTuA
         7nZK9pYGMnaFi+OgXdEF0TW536v9FJXMq1jOzg0RdA1S+7LKXErAhbWygGWvpwFj/+4W
         x7ig07NXOc0WfKJDwaaNiq8LNV3OEIpHe2wWjdKtp/61OH15rU55p/n4+wIfSPVfY5Fq
         IjGw==
X-Gm-Message-State: AOJu0YzX7PjN+j4ljb/TFWXAQ260Y1B1t85nheL8MkLorqPHjaEPfwpv
	lELUPJN2z88eP8LGVT2EQlU322ZmQo6Pcvyylsi1KUeybgONDRq4
X-Google-Smtp-Source: AGHT+IF39EBQyvm4NeIzwqAue8ADbu7l2GappUv82mBZYtDZCHqU5GFkWOxFUGdih+bJoMNmu3rsCw==
X-Received: by 2002:a05:6359:4591:b0:176:b2af:9bf2 with SMTP id no17-20020a056359459100b00176b2af9bf2mr12917886rwb.15.1707053357931;
        Sun, 04 Feb 2024 05:29:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVdPilafCD3v+3ZlNZcMqfjhLfL+8L1kgNFk3pkiG+OL7mBsqsI5IjkOYNLI/Yh7cKK1HtQgcH8xqWIIpCJF68Zt/fkq0M3mRCGAlEQjEbvwqEpPNuWXUBmtEG9YK4espWmNj96eFxAA7lSOKHCSvyaKpwq1ZZ0F8MpAqxbtjLYS0EQsaxWRZXfVz7nJ9XjbDwvOOSY16E742HmTzHT9AbFANjD1hcCUBZfmyY5+qSmZBivaYKJnJ7fCS9HK7RpS3HFC3QYBgV+wxbf5HSFAgirWTQJc72cCm2dxNUhlPqBPmmQaHf4+mMn9Sg1+YXGhZhOzG+wUTnXSIodwBnlU0xRvlfS5OAkvPP+NPYNb762bAlNLTrYYV5zMg==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id x15-20020aa784cf000000b006e03ab56acbsm1110931pfn.217.2024.02.04.05.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 05:29:17 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707053355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TmTYu8gBuYUWmnBfvEGkbpRkd3FkMWxeuI8Kl4keTd0=;
	b=M7Tk1yVt7h/LWhmNfKETeCcmBqV1jWVrzlYkHykLu8x7W8Ajlb1Fo24OiPCn/y8O7xp65y
	ODFKKh6zcl25QgnagvEkOjiw320KToUntOwm7oAX+ia9NJgZXoOxxhNttnSXhtoTXv5X6p
	9W3r0Suk1Bqh0QAI+Jj3yPOjbVzxXUqSBiB8CNh0jYSiHjSw906OK54QK8kZx5k9kfAC6q
	0f4yudcQguKBMniiPUux0x1o3knDUUzAOcqx4jwuOoPiWN3+TiGqQXJLtfLvXPW9UOQBaU
	6jNdGwqctv1VLapFGeEFE0g7kAP8DSWJKUscTnwwJReNgiacuIWEttWnQ/R8YA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 10:29:39 -0300
Subject: [PATCH] perf: make pmu_bus const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-events-v1-1-c779d1639c3a@marliere.net>
X-B4-Tracking: v=1; b=H4sIAEKRv2UC/x3MSwqAMAwA0atI1hZiqRW9ioj4iRqQKo0WoXh3i
 8u3mIkg5JkEmiyCp8DCh0so8gymbXArKZ6TQaM2qNGo8ZZ+2mlw96kokLtEVbYsbKmtwRohhae
 nhZ9/2nbv+wFGCfgtZAAAAA==
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1072; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=JM+4cXRZO8fIkL2koBG39D9ifJnLbSeAqF3/Wh6APII=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv5FDsFeQSd95hVHg2Xt7JWSdjbrkmuuTZxM8m
 skW7iQDSuCJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb+RQwAKCRDJC4p8Y4ZY
 plGqD/0WMQItUAk9/5riaS0MIkoCues5IFu6j0B5m52VK0WGGVGZuFf/99aPDd6o18zipSQVk0Z
 c70I5Li5OrOqZ2oWmAd+MP8YHV8Vq9IX+MfRNIkxgWExrLczruCmR2SKwyX6PHounpvcCLrVQgL
 Y8UkIV4rDk/DkiuVNGa0H3iVrO/1poyhY0cf5SBkxeEfvKvvrw8+wgBOmuMzzRSufkQ/ka+qHm7
 qYqauNY02YK7gDUyjgVxQjDzI6qYfRZvzUgMEeO5zwzQxJJgNkRXBMhtFCAHb4pet3EsBfWFxlI
 PgiMWLzgceK7iG++temordVkRFEuXGVjLGoqSA411fokBmni1aRD9iNE3pTfkxY9aA87OGR0dlr
 RLr4XuPrq+GHKQ7WZG8TjA1NU9uENRqqZNdAkcpIGfjp183N7UGhZN/EuYYSVSgAP7oMQ0YZ2Q9
 k6+vJieazPSBXfVM7zv8MPRLGMIAed62BEuUxiw+BCONCpTDwm98mfPVR/zE2NikPnTUiCZC80E
 c5BS9KeQAsfRTuNnJxYl+Z6DAqhLhj6BRyCgc4ZT1kvakrStiTI9R2xmrTuozfmvz82WFD5XIDU
 hakLJrmxlV/V5eJj2mrqRUq7DcnI6wvQWgCL85QDMJEACVf15yYUSAefG7wvXkJASIoTcet6OnB
 sewoLtzylSVdykw==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the pmu_bus variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 59b332cce9e7..decd994bfca4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11434,7 +11434,7 @@ static const struct attribute_group *pmu_dev_groups[] = {
 };
 
 static int pmu_bus_running;
-static struct bus_type pmu_bus = {
+static const struct bus_type pmu_bus = {
 	.name		= "event_source",
 	.dev_groups	= pmu_dev_groups,
 };

---
base-commit: fdd041028f2294228e10610b4fca6a1a83ac683d
change-id: 20240204-bus_cleanup-events-765165264090

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


