Return-Path: <linux-kernel+bounces-17316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D67A824BAB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 00:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A28C5286336
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 23:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B9C2C6BB;
	Thu,  4 Jan 2024 23:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dXzU8xE1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B8F2D036
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 23:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7bb5be6742fso13969539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 15:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704409608; x=1705014408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b3dqk0Ff5KxkGnHBKa5j/udiyY23Ohwl6jdUCl4DaB4=;
        b=dXzU8xE1lqQl2K7qBNp3a3sUpSqmuTJxjsd4bnp3v497vyejefnaPCwiohBtsBc/0f
         FKWeuorH/FAvl5raJJYxDNmer4qPEFy2AV6asWQm+8kSLhQd6WXxCsw8tDboeKaHz7jT
         A0p2zzkqyZW3j5Dktq5cHhtZ0nrEpOe1cGZDtaAUsqffDykLlILtJ5a4WOr3AKvvdiId
         dBx1NWOhTFBO6WHzD4rJlDEKdKNhWWTEsnbQWKKYrYd5XjTmhREOmqo/kHaZsJCw13OB
         pmDkJubfmaPu+BMU32t7bz4J3XdVTp1F0DBRe6g6GFU6QmJqDuWphshDVGmNuZ+Yurbk
         gzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704409608; x=1705014408;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b3dqk0Ff5KxkGnHBKa5j/udiyY23Ohwl6jdUCl4DaB4=;
        b=nDRou/Xmcl3Yv5/lDx9MjM14rMt0kqZocn83G5QNockSdXt+FPv4raUaK80GKs/pzo
         mOZlZjVY6BXuCICnGEvmmI4/QYWfK28/qJxZ8fQVyG+u+Wt8icdguEaKwS1EVLF/nRr6
         L2Kc8uHcUfCeg1odC7NIMS0Aofx7gswx2Am4AoZ4Puqmr+MNeq8d/28ugiMSwevIpqcS
         vyTo30anBfZN7Ps8rbfytFys9IM8g6XBtwkf0IG1kze1G/kZGrFZzHqsN+0MwgLmKk1T
         GxWitZZ2wL45kTYLRpQHAEfJh7OK1dSoeK4cayD63+8VlknN6QduawE7gStDQ+m3LCg0
         HHtw==
X-Gm-Message-State: AOJu0YzWLzGA+rjMod/pBOd0Fc4UJOgPCUA2sStTx6vWQOydCsQ7BB4o
	h6L04EqsXwMIPwmZ9FcX+Nte50KZrh4oebS/3tiA1D9k0MLuDg==
X-Google-Smtp-Source: AGHT+IGgccmdncGNoX+25kh9DYA4Gbp7Q5ZjvFowunHoL6hvtLSnc3FlWD4tNyBMo/lEb+prYIa2fA==
X-Received: by 2002:a92:c56a:0:b0:35f:b1d8:433f with SMTP id b10-20020a92c56a000000b0035fb1d8433fmr2502382ilj.3.1704409608642;
        Thu, 04 Jan 2024 15:06:48 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id b1-20020a63eb41000000b005aa800c149bsm199646pgk.39.2024.01.04.15.06.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 15:06:47 -0800 (PST)
Message-ID: <3de0c147-0a6e-47ad-90dd-cc624da6200b@kernel.dk>
Date: Thu, 4 Jan 2024 16:06:46 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-cgroup: clean up after commit f1c006f1c685
Content-Language: en-US
To: Daniel Vacek <neelx@redhat.com>, Tejun Heo <tj@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240104180031.148148-1-neelx@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240104180031.148148-1-neelx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/4/24 11:00 AM, Daniel Vacek wrote:
> Commit f1c006f1c685 moved deletion of the list blkg->q_node
> from blkg_destroy() to blkg_free_workfn(). Clean up the now
> useless variable.

I'll fix up your commit this time, but please take a look at
your title and tell me if you think it's a good one? Not
very descriptive, is it.

-- 
Jens Axboe



