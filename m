Return-Path: <linux-kernel+bounces-72059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A4885AE70
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60DD41F231E1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AEC56448;
	Mon, 19 Feb 2024 22:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FXkTiLs4"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC9255E74
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 22:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708381813; cv=none; b=ZY0xDP4DFH0QGKS+6DOvWTm9uu4LjfuGistt0gAUTvvId2ws/xwJEU1tCzWQddgTLvr4kNstYtX2LAziXgDRu42xwoHOU5Z4SHp5MlNzhuhkitCBmxxvit1urecFCzENc1fl2ne6IDm5jaWofqdVGBMc9tRgcHRiNGc5sEntZ6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708381813; c=relaxed/simple;
	bh=f2hrTzeMp3/5ZZdShKy+vFXbuUBET5Nt3bj74acNCPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fjFNfgNRuLzG/xmudTkCZGh2czvGedskxPMspKqvE6q3C5uftbf+BjUjkQB4c0BQKcSMI6kqVtcyipkZKW1KmljstKzKIG1+mZDdZhToXOQgDBkKAf8xbaStqXTjsGJg6WhaSyy+7DPK/5pJ0VytrdjwiDLKj7zmBCkMeA87P7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FXkTiLs4; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7c49c979b5dso77526639f.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 14:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708381811; x=1708986611; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=969xHt7y7axLrjO4JYSk6pwx8s3Y0OrJSlbAqE8gnOk=;
        b=FXkTiLs4mcWWvFO5cd9bg/YkApltQC2nGGdHE+DPwaBZ9z+tgzoz510xn3mY0nAKlf
         fRuwK+gDzIfFOIUM2eOhn0mEjFOycFMuUpB37+g8CuAkwxZ44IPrJ3MbirIGjBbKf6u4
         nOCFkk30PlNiLfgsi7fjE+t0Ur/L4vfXrTS/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708381811; x=1708986611;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=969xHt7y7axLrjO4JYSk6pwx8s3Y0OrJSlbAqE8gnOk=;
        b=FIQ2eDewNLxpS0Rw7b0djzQM2UUcPYAhxiAI3Rr1IHS5AU7ehTocPeHh2itgvTmwEy
         wUYKYYgxzQu6913NtMLrM2DGy9SlArv1xG6HrLLncjFU30eD8O3VAz4qQDCSaLgbbvRW
         zpBjw9lBouMnhVWzTUcBty2Jh5/wb1j776J4Q5uThXtLzsQuram5j1tX4ckGENDn0Xt2
         YoRbdQk6x+siv1AQemKZroQ1YiKIF0CjZPBbbXAfWuJkubt7uJCIgywqFxF1cFJtGj2r
         1MV1etcWbZtTT/nDAm29g0yBhWELjG7Ym+dyu9q8RoblY8C5EI0MkUIe2DMKwuN7tRj7
         z3Mw==
X-Forwarded-Encrypted: i=1; AJvYcCW2+Ny+dkDA2gtnDGV19i8EeZlzxpwqggodTiHg5Eqj3blw/T7TPoaY09UGmktoeJxcT++Ig0KQhrqbmPBhWsVX1qleHUK0c4uQanfH
X-Gm-Message-State: AOJu0YxUTUrT/pS2DhZnjHhCrZzPXOZpufe7Q2gWLkkMS2i9EsbIEB9P
	o70Qv/UEeO+D5UOtn1mXQ0QSQyL1FrYy0yj938Y1pJY5ajYSnOAjDOxoGC23Ljo=
X-Google-Smtp-Source: AGHT+IEpC4BUeiUDxHAjxZ9+WbEMpLXLwyifuJgH9FE2dEEBJkMIapPZBmdSJ/n0Vsn/cptTkiJHGg==
X-Received: by 2002:a05:6602:f15:b0:7c7:28f7:cc81 with SMTP id hl21-20020a0566020f1500b007c728f7cc81mr7909514iob.1.1708381810946;
        Mon, 19 Feb 2024 14:30:10 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id fx1-20020a0566381e0100b00473bc71d38dsm1764737jab.39.2024.02.19.14.30.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 14:30:10 -0800 (PST)
Message-ID: <cdc1cba0-4bd6-462e-bf88-c48d8aa00832@linuxfoundation.org>
Date: Mon, 19 Feb 2024 15:30:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/overlayfs: fix compilation error in overlayfs
Content-Language: en-US
To: Meng Li <li.meng@amd.com>, Andrei Vagin <avagin@google.com>,
 Huang Rui <ray.huang@amd.com>, linux-pm@vger.kernel.org
Cc: Nathan Fontenot <nathan.fontenot@amd.com>,
 Deepak Sharma <deepak.sharma@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Jinzhou Su <Jinzhou.Su@amd.com>, Perry Yuan <Perry.Yuan@amd.com>,
 Xiaojian Du <Xiaojian.Du@amd.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240219075029.2318383-1-li.meng@amd.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240219075029.2318383-1-li.meng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/24 00:50, Meng Li wrote:
> make -C tools/testing/selftests, compiling dev_in_maps fail.
> In file included from dev_in_maps.c:10:
> /usr/include/x86_64-linux-gnu/sys/mount.h:35:3: error: expected identifier before numeric constant
>     35 |   MS_RDONLY = 1,                /* Mount read-only.  */
>        |   ^~~~~~~~~
> 
> That sys/mount.h has to be included before linux/mount.h.
> 
> Signed-off-by: Meng Li <li.meng@amd.com>

Please resend with linux-kselftest on the cc

thanks,
-- Shuah

