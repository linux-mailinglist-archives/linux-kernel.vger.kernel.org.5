Return-Path: <linux-kernel+bounces-163373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C778B6A0C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CD961C21006
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E152AD531;
	Tue, 30 Apr 2024 05:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agTzNsAh"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B127718AF9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 05:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714456166; cv=none; b=foUYSFSGGUWQJLVFsiMWokm5FE3tBolQ2isBZrK0hn0uVQjIDX9mCFcMD/z/CsxTGO/fcUxNIb+bfHI/rxpUcPBTQNRv7qKHtGyNONkQxuNFUJZrZaaS/6UkqS7xLWQyW0SXUOIIlMr4d3AtdZIYwcCYknHABAoq08AXFPoYgVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714456166; c=relaxed/simple;
	bh=LJCkRy43ZOcpOanvVlfAGA+Ge9c5U69r83g+SZYrUSo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dMd0CUZo2fez1+gUrhnwYKDdZ68Cp0GB5iN+gcRSp8OWMuY1LAbxhtFdQx78pkNB8tE8EWabeDZPfitn2dAl5qHEPuxouEZ+0aDZaN9WV3/gPIXl6NCSdXBi5QudwOrBvUnr8EX0AjAIXxh6jrDkwNtm/QPnVsNXMrKoDulef7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agTzNsAh; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ab48c1c007so1394873a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 22:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714456164; x=1715060964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SljHh8nVOvgn1gZ0Y4wkrixVJO3aQjOp1SSnC/CueB4=;
        b=agTzNsAhJnffqKw7gmTmmwsIZEL0dzFu+vF+RlH1lqlw0AJYbJ+E/wqBCrANIl53hT
         r//b6dSI7eGUc98IAWwN5OqlHV3s/F4hvKoBwBqukFXejzN2GSyB7TBuqnU7uEAuQ/4l
         1xfH1pRDJa3dhkYX69gSpQLonJNP/vnWBc0pW35KeAxWssBl0tr0O5G/trl8JCY+QDnl
         dPcNk2ii8A+DUe9Sjj9fcMLQk/JSWTilaFccn5kcdCPA9WDaJxb43kf5XqVZO5mWAcmo
         9OLXb8vsm7cPKmUFWa2ZRCSO0IWCAAMDzDXU8+omAIWwxK5dRGtr4fEZLgalPYxMbqEH
         fG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714456164; x=1715060964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SljHh8nVOvgn1gZ0Y4wkrixVJO3aQjOp1SSnC/CueB4=;
        b=i2CH8d7UikqOkQtMonzXbnulfsvzXQ0zfSCy0WMkgP35NLbznk9DesLs0J471g8Xw9
         BDpuLQZTtFAsKYYaGdaKW5PgYuLP/2QNbLpW9QVDmSnw4QsPMivW8cLteU6oIJ1rPBN9
         Kl6gLmJ5nB4a97hbg3KmLJoM55SbBFocPp2ywMAUziP3/uMG6+w9wR65UDWQ6nR/ACo+
         HR4Ye/pWUCG27s+YtediKTZs/mIF6Gd8hyEXUmgdAKuZIyx1KYk95nMh/OjFLLsa5g8s
         CX6yP264w47VoeOX1OmaDKUPx0uVPMuX6dwI/BrM5zRq4vmLefon4Rnx59s0hnKWxAHz
         EvBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVv4SQREIxmtm10v1by93X2UdoIxFcrTiG1ghhrcKI/sAeOCuJodUk7ecgebEK/WD/ScZ04RPLQODUf962pAquded/63OWmbpi+tDmo
X-Gm-Message-State: AOJu0Yxy/aeyfGQLPSsrKuV4fGDZ5RGZCNen1wy7Bt5Aj6ajKSs4Usv4
	oI2z+a/UO3+IhKYSma6adRVZxWzGyGbSDy8qW2Id3WXqqw9zXNx6
X-Google-Smtp-Source: AGHT+IFJUopCLTz2Sq4UVKcc9eCYZShU0z0giXYurZFVH2M5mNJ7RQRO8WICbAIOTeSGm2j37ZQKxw==
X-Received: by 2002:a05:6a20:7f86:b0:1ae:42c8:4f69 with SMTP id d6-20020a056a207f8600b001ae42c84f69mr13383293pzj.0.1714456164000;
        Mon, 29 Apr 2024 22:49:24 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id u12-20020a17090adb4c00b0029df9355e79sm20471652pjx.13.2024.04.29.22.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 22:49:23 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org,
	yury.norov@gmail.com
Cc: linux@rasmusvillemoes.dk,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2 2/2] bitops: Optimize fns() for improved performance
Date: Tue, 30 Apr 2024 13:49:12 +0800
Message-Id: <20240430054912.124237-3-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430054912.124237-1-visitorckw@gmail.com>
References: <20240430054912.124237-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current fns() repeatedly uses __ffs() to find the index of the
least significant bit and then clears the corresponding bit using
__clear_bit(). The method for clearing the least significant bit can be
optimized by using word &= word - 1 instead.

Typically, the execution time of one __ffs() plus one __clear_bit() is
longer than that of a bitwise AND operation and a subtraction. To
improve performance, the loop for clearing the least significant bit
has been replaced with word &= word - 1, followed by a single __ffs()
operation to obtain the answer. This change reduces the number of
__ffs() iterations from n to just one, enhancing overall performance.

This change speeds up the find_nth_bit() in the find_bit benchmark by
approximately ~1.26 times:

Before:
find_nth_bit:                  4254313 ns,  16525 iterations

After:
find_nth_bit:                  3362863 ns,  16501 iterations

The following microbenchmark data, conducted on my x86-64 machine,
shows the execution time (in microseconds) required for 1000000 test
data generated by get_random_u64() and executed by fns() under
different values of n:

+-----+---------------+---------------+
|  n  |   time_old    |   time_new    |
+-----+---------------+---------------+
|  0  |     29194     |     25878     |
|  1  |     25510     |     25497     |
|  2  |     27836     |     25721     |
|  3  |     30140     |     25673     |
|  4  |     32569     |     25426     |
|  5  |     34792     |     25690     |
|  6  |     37117     |     25651     |
|  7  |     39742     |     25383     |
|  8  |     42360     |     25657     |
|  9  |     44672     |     25897     |
| 10  |     47237     |     25819     |
| 11  |     49884     |     26530     |
| 12  |     51864     |     26647     |
| 13  |     54265     |     28915     |
| 14  |     56440     |     28373     |
| 15  |     58839     |     28616     |
| 16  |     62383     |     29128     |
| 17  |     64257     |     30041     |
| 18  |     66805     |     29773     |
| 19  |     69368     |     33203     |
| 20  |     72942     |     33688     |
| 21  |     77006     |     34518     |
| 22  |     80926     |     34298     |
| 23  |     85723     |     35586     |
| 24  |     90324     |     36376     |
| 25  |     95992     |     37465     |
| 26  |    101101     |     37599     |
| 27  |    106520     |     37466     |
| 28  |    113287     |     38163     |
| 29  |    120552     |     38810     |
| 30  |    128040     |     39373     |
| 31  |    135624     |     40500     |
| 32  |    142580     |     40343     |
| 33  |    148915     |     40460     |
| 34  |    154005     |     41294     |
| 35  |    157996     |     41730     |
| 36  |    160806     |     41523     |
| 37  |    162975     |     42088     |
| 38  |    163426     |     41530     |
| 39  |    164872     |     41789     |
| 40  |    164477     |     42505     |
| 41  |    164758     |     41879     |
| 42  |    164182     |     41415     |
| 43  |    164842     |     42119     |
| 44  |    164881     |     42297     |
| 45  |    164870     |     42145     |
| 46  |    164673     |     42066     |
| 47  |    164616     |     42051     |
| 48  |    165055     |     41902     |
| 49  |    164847     |     41862     |
| 50  |    165171     |     41960     |
| 51  |    164851     |     42089     |
| 52  |    164763     |     41717     |
| 53  |    164635     |     42154     |
| 54  |    164757     |     41983     |
| 55  |    165095     |     41419     |
| 56  |    164641     |     42381     |
| 57  |    164601     |     41654     |
| 58  |    164864     |     41834     |
| 59  |    164594     |     41920     |
| 60  |    165207     |     42020     |
| 61  |    165056     |     41185     |
| 62  |    165160     |     41722     |
| 63  |    164923     |     41702     |
| 64  |    164777     |     41880     |
+-----+---------------+---------------+

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---

Changes in v2:
- Change the loop in fns() by counting down from n to 0.
- Add find_bit benchmark result for find_nth_bit in commit message.

 include/linux/bitops.h | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 2ba557e067fe..57ecef354f47 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -254,16 +254,10 @@ static inline unsigned long __ffs64(u64 word)
  */
 static inline unsigned long fns(unsigned long word, unsigned int n)
 {
-	unsigned int bit;
+	while (word && n--)
+		word &= word - 1;
 
-	while (word) {
-		bit = __ffs(word);
-		if (n-- == 0)
-			return bit;
-		__clear_bit(bit, &word);
-	}
-
-	return BITS_PER_LONG;
+	return word ? __ffs(word) : BITS_PER_LONG;
 }
 
 /**
-- 
2.34.1


