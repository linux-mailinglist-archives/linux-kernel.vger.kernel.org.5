Return-Path: <linux-kernel+bounces-81225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6A8867242
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACD3A1F2D4EE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25483200A0;
	Mon, 26 Feb 2024 10:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7PzBfJs"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C351DA37;
	Mon, 26 Feb 2024 10:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944810; cv=none; b=rycdXJEpSIbjy4LXadLZ9wJwuK0jAQpV9O7JGO53QuoJG1CXZih0Xue1IEdgmLss8xPs0mpquMPrcGGIRnrtle/6Z/2IjnwOiBr6GQRErEuaTzV2DbVty7myG3ETwc8DQvb2wf79tPX1aUZ/nNWbuyewBRNge/L9ykkD+QOjTk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944810; c=relaxed/simple;
	bh=MfMjSREicPDXRC/3aBTnncTM7gNapB8ABPtYerIMlIA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=deI7jONRoc4iK1BheaJN1O7/9Pt6tevZBu2VKdH//ClJQdofJV+DvIG+wwBnSixCJzVcWXzthHKVDaD+smthk9lhTbc661d7GclLqs1qsrBPMPsI8EG+v8gIbhA1/FU5GMZSuHTKhPDZj8mzipT2+nmXjjQaLcFTpWiLEuqKTfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7PzBfJs; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-412a4a932f4so6106185e9.0;
        Mon, 26 Feb 2024 02:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708944807; x=1709549607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WxImVZgrwHuDPLvTHCT/J1rnzl1rCH1Ccw5OGBwvHPM=;
        b=R7PzBfJsDaz8s4ebbFMOBi29olB4Q804x5i/YuENyYPh3ukOJurzrHmnVV/ZIZk5y5
         AUZp5u7jZWgF3IQRrZoZw2IjoMT5hKPQ2xmcQv2Uwl+FtT6w2GZ4lNAcSDkEz8R71kXN
         MhazCB3To/Y+E7plDtqOnHiF7qYcw9TuHo3j+SRiUYItkqbNQc+3ojYvxJSa0SrrE8g5
         n4N9hQW2j86CycxkUMepi4Pb+ZBLN5pBFIIsDS092oExmM/SO+EL6ncIypOIRctZuSwn
         ffP0DGx1EotUpI2ccoDbFftFHCwJrhHLv3CXteg4HZyWFenJyLkeVJFdpkQAzPp0lO8U
         88QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708944807; x=1709549607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WxImVZgrwHuDPLvTHCT/J1rnzl1rCH1Ccw5OGBwvHPM=;
        b=xGFdXVG64Q2gVsl2J1F8fR07S3B5N3xAGutdY949uZIw2ybrkoMiv54jdGz761MrjP
         PVFQjgkzZ42jb8V8oJwVX4/aUqEckpcTOtnDvm9Vx/N0WRBQ0OoJPBDJcmQG5+hBFE9d
         w8gqpBM5jHugvNdbNLWBrUOXhyWYPVxbPHgxQZV4Jx96BNgvn0Ssq8ZggsJaRYfOoDFZ
         6AEBReVEZwnopUxuR2tK92FJGjBVRjbnpFYwM/05e0b0VG7JrSZxCJLUnbY3j2xR5MQC
         N8ypjfj5xD4orT84eRjvDQzy6pdoXzCTCOS4bIsjEu5gNnwpqTnUgXqweJQfTbaDqQF0
         AFsA==
X-Forwarded-Encrypted: i=1; AJvYcCWQimkaG601L87evuTKiCx9FbYqeVXYUc3eY20yOAoklCJkQBZDwN5CTvBf+dO69FvHoHHDC8NkdtcaiKZEIXx62oe9SKdvjdMNw0dziC6m5MtDfIwY4mge01wMr7Z7DtZQ9fArf8wvA1jQjEZVdQ==
X-Gm-Message-State: AOJu0Yz8loiPI+FJT2dUVkjCioi1VOksFYRbaDBxAZ52bC1RGzHmWFAd
	fz9Ic+4XvPxB/ofBB8u1j7Sug87LBA8vWz41HW4LsW1Wy+B4vJWV
X-Google-Smtp-Source: AGHT+IFS46DdNEiDIIuLjUalKwqRgb8fMiohPHldcIt0jR12r1ZO9era2cs2BvZcIixNBzEHG1yWqg==
X-Received: by 2002:a05:600c:1f0f:b0:412:a4fc:219b with SMTP id bd15-20020a05600c1f0f00b00412a4fc219bmr1780452wmb.41.1708944807012;
        Mon, 26 Feb 2024 02:53:27 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id o25-20020a05600c379900b004129051a8f7sm11378892wmr.41.2024.02.26.02.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 02:53:26 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] perf test: Fix spelling mistake "curent" -> "current"
Date: Mon, 26 Feb 2024 10:53:26 +0000
Message-Id: <20240226105326.3944887-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a pr_debug message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/perf/tests/symbols.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/symbols.c b/tools/perf/tests/symbols.c
index 2fed6d67f50f..d208105919ed 100644
--- a/tools/perf/tests/symbols.c
+++ b/tools/perf/tests/symbols.c
@@ -85,7 +85,7 @@ static int create_map(struct test_info *ti, char *filename, struct map **map_p)
 		*map_p = find_module_map(ti->machine, dso);
 		dso__put(dso);
 		if (!*map_p) {
-			pr_debug("Failed to find map for curent kernel module %s",
+			pr_debug("Failed to find map for current kernel module %s",
 				 filename);
 			return TEST_FAIL;
 		}
-- 
2.39.2


