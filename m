Return-Path: <linux-kernel+bounces-1228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C320E814C0F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2E761C21205
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FDB3A8DB;
	Fri, 15 Dec 2023 15:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="L5kNojg/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A74F3A8D8
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 15:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7b70c2422a8so10955039f.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 07:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1702655236; x=1703260036; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TJTjZ2LKnEtLWC+kauLUb5LEqoi8/7GQrDSjK7UmCYI=;
        b=L5kNojg/fEAODooJ9PJJRUqQs3fWmxBu5b7rRxCEYyhCnrQG1+lYbLVSF1iz3U556X
         3S5uksYFcxDACz4MRiJv4HpEP3PaaSqkDn3TO4ZH4trrw/+Lr1lX4ikqJhCaDrA69TTR
         DcMl9XXCyga01L0Br+hIz8bDy/0ArvXKFA66B+LuqYLiiM2jCZhnrHWF3oUiP46NC+cD
         kKw1NbIVWhB5Yu4tAitS4CVjsAmF0Ifaj7zGs6BQzzJqzjVELdeHHQOnQ5TylIvm2CM8
         +JvuYl7SNpkBL0KX4ULu1mYvreh6kBVLu0zSdLsQQ/SjUxHIbF5VLZYfd8tGYCgNtUMi
         9TWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702655236; x=1703260036;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TJTjZ2LKnEtLWC+kauLUb5LEqoi8/7GQrDSjK7UmCYI=;
        b=l13TgWIUMtYi6lgWXOWDsT51cnj1dKfCHqvId6FqQ7T6Vz4K4pvCH30Cg0plWyOCdo
         M9F8StquaY2NdO5YSinPkp6vC/6tDzGKeAiRuLNAcePWTbNAccesyMFBYn78zw7SrgbM
         733jtFZnKWtuGwNQXJBdMRtYW8B7S8ftYHMDtKfKlgc/Z64lbwqPqyGaWuta0AbObOUD
         0QtGiWa3IBLjqwqgPZjCp82hsDD8yTMNa47YJArvD1aJmLzSeJIoZbCxuAcvryM/2AaB
         Z5hdjWHC7lnYBrUyrAOnjpyiCv9uJH2ttjznun+L8Mvo5Bqqr8H2duBKIAKB8WgOv1mZ
         jAOw==
X-Gm-Message-State: AOJu0Ywbmu4kVNU9BLRU/dX+anoPVDhp9dgjhyXTGzHeQIvDWJafq+BH
	Scni63GzgEKo7Vyp8IAKmOeGeg==
X-Google-Smtp-Source: AGHT+IG0U7nkXghg7Z9Nq4CYNFJs5ngKP4jjAdJG59JhG93mEjkTG4OfsnJN8JSdSYAT7iAP0tAL8Q==
X-Received: by 2002:a6b:e70c:0:b0:7b7:fe4:3dfa with SMTP id b12-20020a6be70c000000b007b70fe43dfamr19925870ioh.2.1702655236711;
        Fri, 15 Dec 2023 07:47:16 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id o6-20020a05660213c600b007b6ea31bb14sm4391348iov.34.2023.12.15.07.47.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 07:47:16 -0800 (PST)
Message-ID: <107ff087-92de-4be5-a205-610376d41d72@kernel.dk>
Date: Fri, 15 Dec 2023 08:47:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RERESEND 10/11] splice: file->pipe: -EINVAL for
 non-regular files w/o FMODE_NOWAIT
Content-Language: en-US
To: =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <2cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
 <25974c79b84c0b3aad566ff7c33b082f90ac5f17e.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <25974c79b84c0b3aad566ff7c33b082f90ac5f17e.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/14/23 11:45 AM, Ahelenia Ziemia?ska wrote:
> We request non-blocking I/O in the generic implementation, but some
> files ? ttys ? only check O_NONBLOCK. Refuse them here, lest we
> risk sleeping with the pipe locked for indeterminate lengths of
> time.

A worthy goal here is ensuring that _everybody_ honors IOCB_NOWAIT,
rather than just rely on O_NONBLOCK. This does involve converting to
->read_iter/->write_iter if the driver isn't already using it, but some
of them already have that, yet don't check IOCB_NOWAIT or treat it the
same as O_NONBLOCK.

Adding special checks like this is not a good idea, imho.

> This also masks inconsistent wake-ups (usually every second line)
> when splicing from ttys in icanon mode.
> 
> Regular files don't /have/ a distinct O_NONBLOCK mode,
> because they always behave non-blockingly, and for them FMODE_NOWAIT is
> used in the purest sense of
>   /* File is capable of returning -EAGAIN if I/O will block */
> which is not set by the vast majority of filesystems,
> and it's not the semantic we want here.

The main file systems do very much set it, like btrfs, ext4, and xfs. If
you look at total_file_systems / ones_flagging_it the ratio may be high,
but in terms of installed userbase, the majority definitely will have
it. Also see comment on cover letter for addressing this IOCB_NOWAIT
confusion.

-- 
Jens Axboe


