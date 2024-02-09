Return-Path: <linux-kernel+bounces-60063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E3984FF67
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD4F8B21FC9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165CB21350;
	Fri,  9 Feb 2024 22:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AH2VCc+2"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3452623B1
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 22:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707516464; cv=none; b=FUkZzvz7c/8TUxQPN0tYT5p3TMp/+0q0UnDbDpW2mCwWiN+9lA7h+UgU+bofBktoDx9JSGJUuX3WqgRr9BxtX6pnI1H7Zma3y9xmEYH9GGbVABTKpW4QolpHimXYDJm8tCTZ7xUAsmZvSTKpov0W1GaJPhzpAvWnyzI/5jV0r/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707516464; c=relaxed/simple;
	bh=A9S+JDynS14da0ksFdqnlTCXxeLjED+23yYu8dpU5dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t5EPnYlc7XysyuMx3tf/BOhUyFDJF41Ywtlb8MtphX2LfpVc7u9m5/AiLYzCFMkW9ah2uRbdf2xh0wTIHP5CDxM4UZSIhNnPpM+Udga5F7gr9MX57vnqHbrjYNFdj/wwo6PTrJYo1TggV1MjLoHWfOkh8VMj3mTVSlu8vVEys1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AH2VCc+2; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc6d8f31930so1191728276.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 14:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707516461; x=1708121261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=kcEXYBPsaJTxtaNGcDlRM2taCEkZpdmAw9qOdzF59mg=;
        b=AH2VCc+2dytm0DrVhF8Gz+OZ2zs3vm0OK2FAZfQtQxykS7DGyHCqTGPIqIwS1Og65k
         juYN94CHtDjX5J5OCpcdTP52m572mrf8DXf05udgdH78UhgiooD+Z0i9K9m3lOdYfGq6
         0m4x5wTzQ0B5V/qfjPAyOeU3TSLwIkOQHFqEDnZD8VsR4SbOXwetqDozxYv9bAUmo8sN
         XsEY1PrZqURXlrGhuzw2aaRViDpYUvIR1u4fE2kuRqTts8SEP0kvlm1m7/tHI5ziI0j1
         fhQuUxe3wtLgTE+WErRSm3vX2SJLgW/re1ltncAWrtPlNOjQqteXwg5601JvsIlddfzP
         i7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707516461; x=1708121261;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kcEXYBPsaJTxtaNGcDlRM2taCEkZpdmAw9qOdzF59mg=;
        b=Ex5SwYI3Zotc3pfPeos37XgyfK1aNYewPy03qBSw23r8I0SmFbSLn+Y5y50GNA6j6F
         slt4v9si3DeJiMK3U+FwJ/wJ64sa6QafBGiABsgdHvEJwngxEp9o8qbne9lQ++tIrPAq
         vKM7dFoKPSz1uymLScJLVz5zvpX+oyloBoubajlI7tzvRX76rSV64NWrQ7UbPle57K/j
         fKXDw2l+it5iL0yEF3HD0OaaENngEslTP3d1Bv22pqBEckxNA6jKcM+l4fkbJofoMQU6
         WGn/fWwwqX9XoUqtwnXBZb+fnPChlardDfyTW6+6750rTwXbmbJMwQWGZ7c5lAD+Sx7s
         rKHw==
X-Gm-Message-State: AOJu0YwwkZ1mdYht7EAdY6WfYybBWlg/VnXyMchqmVDMeLISDczaxZUm
	oDRNPyEkyg6BtXi9bKAXsXf4oxkFkYQi0/4Bkl6fQ7dLQL3/BvmhFbMHImO2
X-Google-Smtp-Source: AGHT+IEAQyqlnqT55bo5MEMaG0e/IvJN8D0OHXPA/fk1V+XXwOJ4c2PmFHKcoUJbDtqLjZ/SGwPWXA==
X-Received: by 2002:a05:6902:15c7:b0:dc6:5570:898e with SMTP id l7-20020a05690215c700b00dc65570898emr489147ybu.17.1707516460985;
        Fri, 09 Feb 2024 14:07:40 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p191-20020a2574c8000000b00dbd15c3b753sm343754ybc.46.2024.02.09.14.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 14:07:40 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7d077da1-e792-4570-914e-5c26de420c43@roeck-us.net>
Date: Fri, 9 Feb 2024 14:07:38 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] regmap: kunit: Ensure that changed bytes are actually
 different
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org
References: <20240209-regmap-kunit-random-change-v2-1-be0a447c2891@kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240209-regmap-kunit-random-change-v2-1-be0a447c2891@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mark,

On 2/9/24 13:33, Mark Brown wrote:
> During the cache sync test we verify that values we expect to have been
> written only to the cache do not appear in the hardware. This works most
> of the time but since we randomly generate both the original and new values
> there is a low probability that these values may actually be the same.
> Wrap get_random_bytes() to ensure that the values are different, it is
> likely we will want a similar pattern for other tests in the future.
> 
> We use random generation to try to avoid data dependencies in the tests.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Mark Brown <broonie@kernel.org>

This is actually worse than v1 because hw_buf[6] isn't used anywhere.
Making sure that the values in the val[] array don't match the values
in hw_buf[6..7] doesn't add any value.

With this change, and the patch below applied on top of it:

      # raw_sync: EXPECTATION FAILED at drivers/base/regmap/regmap-kunit.c:1329
      Expected &hw_buf[2] != val, but
          &hw_buf[2] ==
           fb  16  cf  93
          val ==
           fb  16  cf  93
      # raw_sync: EXPECTATION FAILED at drivers/base/regmap/regmap-kunit.c:1330
      Expected &hw_buf[4] != val, but
          &hw_buf[4] ==
           fb  16
          val ==
           fb  16
          not ok 1 flat-little
      # raw_sync: EXPECTATION FAILED at drivers/base/regmap/regmap-kunit.c:1329

[ lots of those ]

FWIW, I had struggled with the re-use of val[0] for two different tests
(on hw_buf[2] and hw_buf[4]) myself. The only solution other than making sure
that it neither matches hw_buf[2] nor hw_buf[4] I came up with was to use a
separate variable for the accesses to hw_buf[4] (or hw_buf[6] in the old code).
Something like the second patch below, applied on top of your v2.

Guenter

---
diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index 85e02f86b14c..67cc3239f478 100644
--- a/drivers/base/regmap/regmap-kunit.c
+++ b/drivers/base/regmap/regmap-kunit.c
@@ -1284,6 +1284,14 @@ static void raw_sync(struct kunit *test)
         hw_buf = (u16 *)data->vals;

         get_changed_bytes(&hw_buf[6], &val[0], sizeof(val));
+       // Let's cheat.
+       // Remember, the above code doesn't look into hw_buf[2..5],
+       // so anything might be in there, including the values from
+       // the val[] array.
+       hw_buf[2] = val[0];
+       hw_buf[3] = val[1];
+       hw_buf[4] = val[0];
+       hw_buf[5] = val[1];

         /* Do a regular write and a raw write in cache only mode */
         regcache_cache_only(map, true);

---
diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index 85e02f86b14c..d2cf510f86f0 100644
--- a/drivers/base/regmap/regmap-kunit.c
+++ b/drivers/base/regmap/regmap-kunit.c
@@ -1269,7 +1269,7 @@ static void raw_sync(struct kunit *test)
         struct regmap *map;
         struct regmap_config config;
         struct regmap_ram_data *data;
-       u16 val[2];
+       u16 val[3];
         u16 *hw_buf;
         unsigned int rval;
         int i;
@@ -1283,17 +1283,17 @@ static void raw_sync(struct kunit *test)

         hw_buf = (u16 *)data->vals;

-       get_changed_bytes(&hw_buf[6], &val[0], sizeof(val));
+       get_changed_bytes(&hw_buf[2], &val[0], sizeof(val));

         /* Do a regular write and a raw write in cache only mode */
         regcache_cache_only(map, true);
-       KUNIT_EXPECT_EQ(test, 0, regmap_raw_write(map, 2, val, sizeof(val)));
+       KUNIT_EXPECT_EQ(test, 0, regmap_raw_write(map, 2, val, sizeof(u16) * 2));
         if (config.val_format_endian == REGMAP_ENDIAN_BIG)
                 KUNIT_EXPECT_EQ(test, 0, regmap_write(map, 4,
-                                                     be16_to_cpu(val[0])));
+                                                     be16_to_cpu(val[2])));
         else
                 KUNIT_EXPECT_EQ(test, 0, regmap_write(map, 4,
-                                                     le16_to_cpu(val[0])));
+                                                     le16_to_cpu(val[2])));

         /* We should read back the new values, and defaults for the rest */
         for (i = 0; i < config.max_register + 1; i++) {
@@ -1305,10 +1305,10 @@ static void raw_sync(struct kunit *test)
                 case 4:
                         if (config.val_format_endian == REGMAP_ENDIAN_BIG) {
                                 KUNIT_EXPECT_EQ(test, rval,
-                                               be16_to_cpu(val[i % 2]));
+                                               be16_to_cpu(val[i - 2]));
                         } else {
                                 KUNIT_EXPECT_EQ(test, rval,
-                                               le16_to_cpu(val[i % 2]));
+                                               le16_to_cpu(val[i - 2]));
                         }
                         break;
                 default:
@@ -1318,8 +1318,8 @@ static void raw_sync(struct kunit *test)
         }

         /* The values should not appear in the "hardware" */
-       KUNIT_EXPECT_MEMNEQ(test, &hw_buf[2], val, sizeof(val));
-       KUNIT_EXPECT_MEMNEQ(test, &hw_buf[4], val, sizeof(u16));
+       KUNIT_EXPECT_MEMNEQ(test, &hw_buf[2], val, sizeof(u16) * 2);
+       KUNIT_EXPECT_MEMNEQ(test, &hw_buf[4], &val[2], sizeof(u16));

         for (i = 0; i < config.max_register + 1; i++)
                 data->written[i] = false;
@@ -1331,7 +1331,6 @@ static void raw_sync(struct kunit *test)

         /* The values should now appear in the "hardware" */
         KUNIT_EXPECT_MEMEQ(test, &hw_buf[2], val, sizeof(val));
-       KUNIT_EXPECT_MEMEQ(test, &hw_buf[4], val, sizeof(u16));

         regmap_exit(map);
  }


