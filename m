Return-Path: <linux-kernel+bounces-154806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5A98AE145
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5A41286157
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B195555E45;
	Tue, 23 Apr 2024 09:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NF/L66M5"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE3E56B9D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 09:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713865582; cv=none; b=XcLjHMaFbFq5KIpd28U5PfoFU+hblq6QHyE/zSA8/YAp8PTHvLz6nCtnWHsHAZJuyuI68mhLmBcvRdJJWCZTI9qqXiacR8duzu70+KJFgp5gF1KzXejPqIITSTAlCnUzCa36OTb9YwXIt8+OBUvcagZ8qr6rkhguq17xlK0UYf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713865582; c=relaxed/simple;
	bh=NAZlEUTkNeX9oBhGuQf7WyWsRXvJx03hWitvIPh65SY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sdj/ZPBK7dlCxmEwbhucTQ9TvKuVBxNanEOoLvKVVbcZL7tMMzHEcHiaqW8FXdZCm3Mf3wez9YAgODp8b6UOtU5F5SGWhi/7H+g5T51/S+dHlDZJMwKMD0lA0l8wSKmNU9l/38nvdyFz4663IwwJ3JOiRAWbo1+0HrvM6MN3Sfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NF/L66M5; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6edc61d0ff6so5375890b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 02:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713865579; x=1714470379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVtlhO4s49xZU1ItPoCI7JLpDg0ZBrWqzgWF+JfN10w=;
        b=NF/L66M5ZfCO3oBmo21+zkET0x0hf/YzNw8sRxUxHxmylnaCrkB6mR1A+fu/6HT7yr
         F6/Y8SGboNsP8rIMAKi0K/o2j1v1mJsZw/vDxniYWqH+KU9BBQJSCiHO5rwfBzP0C2oK
         ZA6vzVKUDP661uAikFyivnvR7rfyRbAGBq8VmFxzxmhLExFfjAdvP5ZBd8T0YhkJyLl5
         LsMDwPTNxoN/ekzbd2SsjybV8ycmTG33S/+1wETqHp59ofhNr8UhO1SCjXdIFFfLAb3d
         mhTS/KYJImxtxHmREiEttH1NYKBD5Ah+9xGnI0wdXiKtVzQfe2psHxbw6S37kbEweOTO
         HfAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713865579; x=1714470379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yVtlhO4s49xZU1ItPoCI7JLpDg0ZBrWqzgWF+JfN10w=;
        b=GWsWP9bBSps0n+/dUlURIeUtsA8j+kqlsX4ksjBPRATimH/kizuNIFD32ERFtzokjz
         9n23wtbsTv2e6tlSXu44Sv/8QlzS3T2C1SOmvgFFvE6Wd7itMjnhOz7phxZvPoa84xoH
         Dr4NZnTcIA+jW1GV3tsD7MQ5WlX98oejc0inL7fl2AHSqjs2ByCxWPe7xLcU0CRK30s4
         K5HkD2MX10asB6IvThWhfgRnxRJEk4GEaXelbcUuex4oT0gigrp9vvotr3WKKIoktPYo
         RfwNtFacNk2zAmfwsoASiepsxPGH3MLQDGl3svM6O0mSU6Wt37ln5SoZHjPddKHxUq+H
         Syug==
X-Forwarded-Encrypted: i=1; AJvYcCUed0x4gG5y3RmpdhnQku/MLcSMACKPcQSEhdmkM3ow3hV8/J7eSMCayYDaDgBbUUd+IUSnN/KqILGQ9NDKz2K/DXI/68eU3Zch98Ho
X-Gm-Message-State: AOJu0YzRw8B3QCQhB0MHp4j2voGr9RL9dLDXlPNauXtoO9Ym4stUmlMJ
	JiAL1gFJAT1elssn7bg1wzAqZ8YDMRSRhn1JCN2R4z4G86XMy6nP9kYGVRO4
X-Google-Smtp-Source: AGHT+IEf8WRPrYdPf3as1sxPJI+z/s1TRXy5Vez+91vpeFVQd8HzW9/Uy4tUN6IGCeOvsjGo61E3Ig==
X-Received: by 2002:a05:6a20:7484:b0:1a7:3b4a:3e8 with SMTP id p4-20020a056a20748400b001a73b4a03e8mr16826796pzd.7.1713865579527;
        Tue, 23 Apr 2024 02:46:19 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.240.252])
        by smtp.gmail.com with ESMTPSA id fa19-20020a056a002d1300b006e57247f4e5sm9214399pfb.8.2024.04.23.02.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 02:46:19 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: baolin.wang@linux.alibaba.com
Cc: 21cnbao@gmail.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	hughd@google.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	wangkefeng.wang@huawei.com,
	willy@infradead.org,
	ying.huang@intel.com,
	ziy@nvidia.com
Subject: Re: [RFC PATCH 5/5] mm: shmem: add anonymous share mTHP counters
Date: Tue, 23 Apr 2024 17:45:02 +0800
Message-Id: <20240423094502.4080-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <CAGsJ_4xu4iL5pv7T1chyzGC2Vp9q1GwOp3wxb=bYMW-T-pj4dA@mail.gmail.com>
References: <CAGsJ_4xu4iL5pv7T1chyzGC2Vp9q1GwOp3wxb=bYMW-T-pj4dA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 2024/4/23 09:17, Barry Song wrote:
[...]
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index 26b6fa98d8ac..67b9c1acad31 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -270,6 +270,8 @@ enum mthp_stat_item {
>>          MTHP_STAT_ANON_SWPOUT,
>>          MTHP_STAT_ANON_SWPOUT_FALLBACK,
>>          MTHP_STAT_ANON_SWPIN_REFAULT,
>> +       MTHP_STAT_SHMEM_ANON_ALLOC,
>> +       MTHP_STAT_SHMEM_ANON_ALLOC_FALLBACK,
> 
> not quite sure about this. for 2MB pmd-mapped THP shmem, we count them
> as FILE_THP.
> here we are counting as SHMEM_ANON. To me, SHMEM_ANON is more correct but
> it doesn't align with pmd-mapped THP. David, Ryan, what do you think?

+1

IMO, shmem isn't actually file-backed, but it has file-backed-like
characteristics :)

FWIW, perhaps MTHP_STAT_FILE_ALLOC and MTHP_STAT_FILE_ALLOC_FALLBACK
would better align with PMD/PTE-mapped THP.

Thanks,
Lance

