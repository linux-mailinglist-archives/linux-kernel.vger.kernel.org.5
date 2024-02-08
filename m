Return-Path: <linux-kernel+bounces-57591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A536984DB1E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7E8A1C211A1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5477F6A337;
	Thu,  8 Feb 2024 08:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbswsTdN"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1086A02E;
	Thu,  8 Feb 2024 08:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707379919; cv=none; b=hb7GCfAbJH/kModMW+55F1xOIQiRJ25BR0U8P5EcKuc/s3vpNInMF9wJIU04HiN/ohizTJGpoabdvJgAhawUZUZ8cJ/0CfgUTflcfFxIoAw7FDoE+jB1t6nkmw+QUT+k9dTSdTeL5p/eIjlh2aFbmYUIuDrN9SvixJngPmaPejY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707379919; c=relaxed/simple;
	bh=r2gDOJZsfcEKcNeXFgVU4/d8DvY6q/9pRPxUslnQm+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rOxbfn0wAClHj6QfGKzrK4mIfX7V8y9F9FDPLde6IgPSsOx0pjjVoTaKjKiqHrz4+Rn+Q+80IjxFEwqCDZzY/L1dInna8eSWrTsgUwv3EmQvarAj1l6A2GesffnJdgNFomFUnMpEIcZRycdmw6xwydepe0p8BQZjnKMzqKVnmgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbswsTdN; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d94323d547so14096635ad.3;
        Thu, 08 Feb 2024 00:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707379916; x=1707984716; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+EzGcEGSGki041mX/q4WVvvLib1LrKkmNOXMbNSMe9k=;
        b=AbswsTdNrXW4JOEzBSKCm3xLFTEk1LoZKKxB7RDsrmvXD9Hsr42BwqAg5rS7d8Ab7u
         2TVbCwmRTkq5hX5TgAxAIpg5tRonx3bTCOgzsIanaypTU7h5jJzr6rRGfi8UibsZ0VFV
         eGvceRd8j09rQ1DROAKg8wW3+1RD7kIGG9zqiOdXZ9Cy8+WPMDo2If7ecZGa3cY0qiGV
         bblBNjwshQbDfNAaGKvZxY3rexEgQo3teaS6QlBHj2EhYR4P6qHp7/RKdWo/pVKnXEXk
         ddhpdczEW/rCli/lzBNU3BQJWd/bQXBA9xlLZfW7Lavlu+mGzOFOY6kDVWvJ7Vee6usq
         uRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707379916; x=1707984716;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+EzGcEGSGki041mX/q4WVvvLib1LrKkmNOXMbNSMe9k=;
        b=qMqckgOMI9N0vSdo+alGV5nkaSXhWv85dXOkjGn3tlNDrLMswtEbTcpwNchQPZjB7j
         bGvrGMbzKLTeg7W/0/1xTHnKzbN8IB7rlLWg61ZWLrSlWSInJsgQXcrEJZodbl1HKqiF
         B2UseILIoUlXUswLxN2GSZAUlpTJs6dNuZFASi0jfdQvofkZVlexYugDsdqvZOlWrZOg
         Co3zoeFiKYRyR9/VtsXP78oBT8Wv9Mp2qCFFSmYXKCYF92K3KM5d54/zRPGGRMWEZIlO
         +6H+7sO5N2wJSXwUn0OESM4YL0DYDc4eV8fOAyKV6ztLXZfptiYHv9sc3YwvJbL6NKK8
         ZH8Q==
X-Gm-Message-State: AOJu0YxnkJezFiNjzGZ1T+6394hJlJnuaehTU7+Hg7D9uTZNLaIU91ES
	fmJxKUcG3IxLSa0GrKqV89H42c5+yuZg8q+h2zFFLZwRFugfXwwr
X-Google-Smtp-Source: AGHT+IG5rt3u2UGwyrRiwP0jDNepsx1EaHecgtVzojFLKjbioIlru7dTmEcioRvKo7tRDyS8TaYb7A==
X-Received: by 2002:a17:902:ead1:b0:1d9:6381:a4b3 with SMTP id p17-20020a170902ead100b001d96381a4b3mr6541505pld.36.1707379916398;
        Thu, 08 Feb 2024 00:11:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVM0Eei7B+s2xu7LIQ5YQ3htmsre/Zi1BiMcqbTuBhg1gCskj5rTO6VTnGufF83HLSNCtEAExblGgFcT8yp/ZF3LR5ZEDEeAYrVsobqzAxjQGDoYqbhVmCV4nyw38q4NiyLY56twVdxK0e2AFytP+cpdv3aFE6RFHGg23dfp3TvQKGM5XgDRhwP
Received: from [192.168.50.127] (42-98-185-035.static.netvigator.com. [42.98.185.35])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902748400b001d8e5a3be8asm2764386pll.259.2024.02.08.00.11.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 00:11:55 -0800 (PST)
Message-ID: <bab0d763-2907-4412-8075-a7ebb25081c0@gmail.com>
Date: Thu, 8 Feb 2024 16:11:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "f2fs: stop allocating pinned sections if EAGAIN
 happens"
To: Chao Yu <chao@kernel.org>, Wu Bo <bo.wu@vivo.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240205031415.557879-1-bo.wu@vivo.com>
 <793fd834-fe28-4647-b2cf-0012acb95b43@kernel.org>
Content-Language: en-US
From: Wu Bo <wubo.oduw@gmail.com>
In-Reply-To: <793fd834-fe28-4647-b2cf-0012acb95b43@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/2/5 11:54, Chao Yu wrote:
> How about calling f2fs_balance_fs() to double check and make sure 
> there is
> enough free space for following allocation.
>
>         if (has_not_enough_free_secs(sbi, 0,
>             GET_SEC_FROM_SEG(sbi, overprovision_segments(sbi)))) {
>             f2fs_down_write(&sbi->gc_lock);
>             stat_inc_gc_call_count(sbi, FOREGROUND);
>             err = f2fs_gc(sbi, &gc_control);
>             if (err == -EAGAIN)
>                 f2fs_balance_fs(sbi, true);
>             if (err && err != -ENODATA)
>                 goto out_err;
>         }
>
> Thanks,

f2fs_balance_fs() here will not change procedure branch and may just 
trigger another GC.

I'm afraid this is a bit redundant.

>

