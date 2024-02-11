Return-Path: <linux-kernel+bounces-60925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D99A850B0F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 20:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B65D1C21FDA
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 19:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE565D73A;
	Sun, 11 Feb 2024 19:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCr2wFxp"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB52AD2D
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 19:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707679122; cv=none; b=rwZimYDWc218DmuFwuY32fdUXH5d+hbJ9xH9uefZgrM2mnZdVoNEH8HoA2136InCP/xG0/dCtBwu4rQUuznkODSISPmDzg+JNi7WAtNYZXwnz00amqdHfY6lqjd5nyyJA5D3+AIeiUWrxLj/iM/nUtjpjniTWsNeS2O9Re/kaGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707679122; c=relaxed/simple;
	bh=09l88D3wdDMStgGJN63G2XYzcoiJ/QSRvkyCaSfdbWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gu9znuMGhR5keDhGMq33zrzHdBz1Lj/mIsZvJZNeIPPJeFD5mlaYzD9O6inFxOS7nRE85SjO210oPax7yy4tOaNrOm3ra3iXkwGwsRnyBbEeaL2KfpEiqrKcUSLp46PNt7bVMjOF2DbFYPP4ogSz7j6zv5Mp3Sbci3D3Xju0SGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCr2wFxp; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e2e452c852so252224a34.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 11:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707679119; x=1708283919; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=cRkVOjU7WU0Jq+yFh/n1COxy02/3/eY9g+NJ805i30A=;
        b=PCr2wFxpVGMKhlh8ingSTbdCE6wVfLQxiUwMDNliyxrbf17ufpn1IoUV3/vh1dxOWD
         p6SWDZJq0/gWrn8nSGQbx79p+AnjLNdyYq/9NTnCXUnndsGERr0tZ94PZu7RJO2ejwDI
         bc6jL1hx1EgEVaZaI9C5Gc0M5ZotKvziWSy6veiJnE9Uo6toWVnUd55qCa0FDau62roE
         S/1PzyxO4riAcB1fepV3oyjV5MIfzN41BiXgl82SbWqKKcVbzSioBtJSSg9Dqr4yi9j8
         ibOsGy1A/1YNhCxeRAX0WoZbkh3UsNiPrFapa4IvTBNT7FijBcpmm6MhEiX+s1xbIYuC
         BJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707679119; x=1708283919;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cRkVOjU7WU0Jq+yFh/n1COxy02/3/eY9g+NJ805i30A=;
        b=kZDbFekOxqJtf0AlRTt7iItfXjJi8EOC3IIhqog29uTs+WA++bMcajASdmO7QL2JsO
         8ivwYGBzwN4D5Pe4fvjhYoTcIZcEA85EgD61GnSHPDLHXHgLygz0xidpcmpb2ZLPLTdS
         wulNs89uyW0ZV2WCXZShrXIHywnrBF6oWO4cRHNKyRc26Ebf2DnLLInfakimY8FgHIx0
         er1g8+s85kECUORe10ZsfmZRL6BqFHdqoGC3vLEshueMwUSsDUhU3w2jdhN5hXlOEZIQ
         2D/WJgobWSS3ZsK2qpnqybUOgXrYr1mFbaOU1q6lsGYHfEgQpBm9seFxK3f2840yBhvq
         Ys8w==
X-Gm-Message-State: AOJu0YwFUzwgSId3y5Aae8OXUsjMWpxsXiEc9x0qtEE4pfqKnNHqE0px
	VGOGoRSZgaHLQkwkdhVcECp2jRlezztNG3YbfGxU9Nrp8MmMIkwO
X-Google-Smtp-Source: AGHT+IE4c/OGrdDcYbMKrnZd58gh+jTrUcsHZ0cMzGud9o15dFYw32Pbkh+FPJhWm/atXBZif4qkOA==
X-Received: by 2002:a05:6358:4316:b0:178:72b5:cf49 with SMTP id r22-20020a056358431600b0017872b5cf49mr8046308rwc.8.1707679119223;
        Sun, 11 Feb 2024 11:18:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVOmkKCs02gGqbJGmXFVmp6XfzhRwjc5br7emI/oSSCJRkLIJdBC13YW2FS6R2CBK/rKqhPvNveKu9uGlEmWsHqX5y9HVrOkm49vwK5XvW945433X53bFp8rJBtb0lyNHmhpR8fAFXUhXZTuKZDk6RhhUCFN31PTWC6ghY82lkA6SKNmqzw
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s65-20020a17090a69c700b00290f9e8b4f9sm5979544pjj.46.2024.02.11.11.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 11:18:38 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8dedf370-47e1-405d-85cf-53f3acfa16a0@roeck-us.net>
Date: Sun, 11 Feb 2024 11:18:36 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/2] lib: checksum: Fix issues with checksum tests
Content-Language: en-US
To: Charlie Jenkins <charlie@rivosinc.com>,
 David Laight <David.Laight@aculab.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20240207-fix_sparse_errors_checksum_tests-v6-0-4caa9629705b@rivosinc.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240207-fix_sparse_errors_checksum_tests-v6-0-4caa9629705b@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2/7/24 16:22, Charlie Jenkins wrote:
> The ip_fast_csum and csum_ipv6_magic tests did not have the data
> types properly casted, and improperly misaligned data.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

I sorted out most of the problems with this version, but I still get:

     # test_csum_ipv6_magic: ASSERTION FAILED at lib/checksum_kunit.c:513
     Expected ( u64)csum_result == ( u64)expected, but
         ( u64)csum_result == 16630 (0x40f6)
         ( u64)expected == 65535 (0xffff)
     not ok 5 test_csum_ipv6_magic

on m68k:q800. This is suspicious because there is no 0xffff in
expected_csum_ipv6_magic[]. With some debugging information:

####### num_tests=86 i=84 expect array size=84
####### MAX_LEN=512 WORD_ALIGNMENT=4 magic data size=42

That means the loop

	for (int i = 0; i < num_tests; i++) {
		...
		expected = (__force __sum16)expected_csum_ipv6_magic[i];
		...
	}

will access data beyond the end of the expected_csum_ipv6_magic[] array,
possibly because m68k doesn't pad struct csum_ipv6_magic_data to 44 bytes.

In this context, is the comment about proto having to be 0 really true ?
It seems to me that the calculated checksum must be identical on both
little and big endian systems. After all, they need to be able to talk
to each other.

Thanks,
Guenter


