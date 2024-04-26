Return-Path: <linux-kernel+bounces-159487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3968B2F3A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CBE21C21222
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 03:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F379678C78;
	Fri, 26 Apr 2024 03:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNTkAgzx"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A923C2F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 03:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714103520; cv=none; b=Skofc/66wbPtVypOBEA5Zv5AMw6CIHpn6BhSCyeL/MiEfu2I/x3pAxSWS+rBSk4B3wBFU3rMgw/PEi2CmgBZZ7VA4F7eeBee1fq+JAtCCw/IUVdOwbnhh9EBKHfYCYzT7FqKGG5cGn1LU8MNBXPml+cWKoDpcw7X72rSO2EmUe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714103520; c=relaxed/simple;
	bh=Agl6jIQP+f+VaD89kJ0MtzpuVKWoSfswrh7BK3+rgdU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k86UH6FIDNPJii5cLEK7RerTaS0pIrPD53IckF1QWGasU1WhKOgbwv8beZoFwymqcSfifZTdInqrftNJFq6h5qp80jPWRrneYJTx3MW+WRxrlsQnAzuvRBo6nT1Jn6wPyV+nkoFEtwuZ9d/uDrYeXiFs5teLNAzfzL5iKAqlsTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNTkAgzx; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2abae23d682so427851a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 20:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714103518; x=1714708318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YYBctK9BCSdC+a1wN554xTMNkuFQ9mQ5cD5Wfe9uAWM=;
        b=WNTkAgzxNPOeMSqByiuZlJnQ5dijkdv5uG53NjcmXbGvMazeHYcfkbQbhWMFOCxV1p
         X4zDRcADvBKdoaCBg+XswzK9/CPdyZtspDmBkJpQHJ4W9huIx8d1m8LnVFmznCmlyL1j
         8PCVm6V6RKjY5ZfxLYSngOjcvmds5dc9NX9Vyn8j22auYjocgmIYed/444hUkXk/fAz5
         4Lk3Q6/YRvOojXuCuJsi0Xgt4O1MFgBRwaJwtqOD/BX4euSorSksX98DCguSdxNnxa86
         j/POUjy9Fwk2okZ/fIZq1oeJn/fQtR+0RAZEu4gRJbnUBgcCpoC2C9A/rd1c8JBnJjxy
         L7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714103518; x=1714708318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YYBctK9BCSdC+a1wN554xTMNkuFQ9mQ5cD5Wfe9uAWM=;
        b=TfsH9HNyZuXCIsFGbvCfoYfbamj7BJvKUDb9ucPAYUFyJgbOZzabwMXAn05MguH1Qc
         orZedsstvllBoVEIQcXhozFSyhNRa39XwsJMpc0layQx6VZ1Dv2Foln41axd40M0Y5YS
         wYhNFDuOA2zTE/p8vrP4WtoIpwH5PRkHF4KOI2xaZKD/y3vFA/nVXpoByOtxws9GxKpH
         KOkPpz69wkm0Z/A+JRa6+83rmuyJ4VefobHzVTpFE2+KGzpIdokhnVkf7J6K5+FJNh4H
         gZRsJxB4pLPZIvOLoNyZN1QyvhF6LdDhPnB8LgNnY/YSDLIwD/96hwFnYcq9tiKl6nnm
         h+Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXDSso92nbIAer3zqdzZgVkEAtXciUgnXkE7y+062d/3K2rwOkDbxhoxxTRPwIQR1kN4zZ4M66n7ZQn+RQS3Lo7RWuTnj7yQKW7cWnb
X-Gm-Message-State: AOJu0YysVOJ4q+lQ+nrz9SPdf4SPX96BvldgLOcBEFAFLQ+pJoLdbG8s
	HY87SIJjlkqpoLdCjQrUNcovF2BXJOMOQPU0OjLLYJbPrJ2LrZHi
X-Google-Smtp-Source: AGHT+IFBmi+492z/VUG6gn+4SNXuR7IJX3uCRVFXXljFcc2SrqajlQaDB2AUxqDdgUVrHIPE+Ir80A==
X-Received: by 2002:a17:903:234b:b0:1e2:c544:9bb0 with SMTP id c11-20020a170903234b00b001e2c5449bb0mr1725359plh.0.1714103517967;
        Thu, 25 Apr 2024 20:51:57 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id t8-20020a170902e84800b001dd2bacf30asm14640227plg.162.2024.04.25.20.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 20:51:57 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: yury.norov@gmail.com,
	akpm@linux-foundation.org
Cc: n26122115@gs.ncku.edu.tw,
	jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] bitops: Optimize fns() for improved performance
Date: Fri, 26 Apr 2024 11:51:52 +0800
Message-Id: <20240426035152.956702-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This patch has undergone unit testing and micro benchmarking using the
following code:

static int test(void)
{
	unsigned int i, n;
	volatile unsigned long x, y, z;
	const unsigned long round = 1000000;
	ktime_t start, end;
	s32 time_old[65], time_new[65];

	for (n = 0; n <= 64; n++) {
		start = ktime_get();
		for(i = 0; i < round; i++) {
			x = get_random_u64();
			y = fns(x, n);
		}
		end = ktime_get();
		time_old[n] = ktime_us_delta(end, start);

		start = ktime_get();
		for(i = 0; i < round; i++) {
			x = get_random_u64();
			y = fns_new(x, n);
		}
		end = ktime_get();
		time_new[n] = ktime_us_delta(end, start);
	}

	for (n = 0; n <= 64; n++) {
		for(i = 0; i < round; i++) {
			x = get_random_u64();
			y = fns(x, n);
			z = fns_new(x, n);
			if (y != z) {
				printk(KERN_INFO "test failed!\n");
				return -1;
			}
		}
	}

	printk(KERN_INFO "test passed!\n");
	for (n = 0; n <= 64; n++) {
		printk(KERN_INFO "n = %u\n", n);
		printk(KERN_INFO "time old = %d\n", time_old[n]);
		printk(KERN_INFO "time new = %d\n", time_new[n]);
	}
	return 0;
}

 include/linux/bitops.h | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 2ba557e067fe..ffeb71e72154 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -254,16 +254,12 @@ static inline unsigned long __ffs64(u64 word)
  */
 static inline unsigned long fns(unsigned long word, unsigned int n)
 {
-	unsigned int bit;
+	unsigned int i;
 
-	while (word) {
-		bit = __ffs(word);
-		if (n-- == 0)
-			return bit;
-		__clear_bit(bit, &word);
-	}
+	for (i = 0; word && i < n; i++)
+		word &= word - 1;
 
-	return BITS_PER_LONG;
+	return word ? __ffs(word) : BITS_PER_LONG;
 }
 
 /**
-- 
2.34.1


