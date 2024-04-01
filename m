Return-Path: <linux-kernel+bounces-126658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CF5893B06
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6461DB218C0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 12:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5583E494;
	Mon,  1 Apr 2024 12:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="fEIS6676"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC3437168
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 12:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711975182; cv=none; b=m66S9TvcKJ43g9UKVR7OsbAFWSiMjcnhCh3xc1EzPA3xgTe6Gv97S9UR5VsNpUnRtclvbtXtIttD72cwwTxbeb7YrmBqfaoGAT5YlV5EMISJXSMbv/u5ngqc+pQ8TVlTtq9y4tJNBTI3YSByz/YxhkrM9PEFjR7eglUONZ3lcy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711975182; c=relaxed/simple;
	bh=4dIUD4SFfz0KSuYeHWu2YBwd/u60LXMWHEiGpv+uimY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=moied1GoVmtDcBvOiPriNMJMLJfqifa+3tCOXm9m/ozDMjmJlOXetTgnaiqBcDnd0B4RUz6lRYDJ+6H4HqJKk1QqQU9IWvNIsfJeupV1RtLUTK0Whj9/JuQXQdM+8umIfPWfUTdmQ5Myrt+7ssSlJinL4f0N/QfRcLzRIoN1vN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=fEIS6676; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3417a3151c5so2725384f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 05:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1711975177; x=1712579977; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H2EUwRDkkeNDukcge3a1iBvqeXFfUokc8SHBEfVM2e0=;
        b=fEIS6676hQ9MTImdGyLXC78qGVcwKFeLVWWndpy5OKdqyNeyXwfkWpfKH6pQCyQqyh
         2rynjQvk23wWwnilJLDL4GAm+C43Q5SoojpH3n6eHiDN9QBHiajeskj7bfnHs0lNoPpN
         gNnh+eTWV/QbyDMs3wbKU4eFOiSx6q++aEVzkQ4HJzkOHjUkFXSaRC0+Yx2Ax61kuzJa
         tdlv04D4lDAadloXhN0S+BTmnAP17N17mk3wOrq97sJlGl44QvV1kcNr82NYcZzq/eIn
         0WPZ2tyZ1cRGxrUr7+Cyb6dMLZwZvzD79QkCRjWTnyTXHvKz+qnEdEbda/FD76/HbxQo
         +rYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711975177; x=1712579977;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H2EUwRDkkeNDukcge3a1iBvqeXFfUokc8SHBEfVM2e0=;
        b=ERSpsLm58S4Tz0ETWasJDz80nKLl1CblVjpUHucGnj1ClB7ivTVVT2IbLjt6460zi9
         +QHP7+Lwqgj2SS9t0rjakHLq3bWfd0KJzFwDRY/VJG1/1UevHUKqcBHNLeJBGEp3XCwf
         FudZYv8OCbWDQ9JpqnMk1fU6JVjcaqRlR9FfREFcqy+Pz89bWKlNE185dqruUSW1IX0y
         r+Uf6l0fkVJs8CyPG58PLYQa51HI6Ali3mk3xdmHofv51Wxd6Z7yAo2itp2Rs/FvihX9
         MLhKkQNMso82kjt8hYEsq1fBi3ZFbviwcnpufoMncaGSHvoEQdXoKZ0IR4IJw8fJFG8J
         53eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzCghO2LZL5AC7FYnFeBbJ+uvcL5VuGer9QlxPQwtf3zVhJohB9EPrEWXC9RRif3tQ2kX6mSZnOZMxktLhkyDHiGSDzPwwYwYToa+2
X-Gm-Message-State: AOJu0Yz07qIL6FTPTn9olmaWfPAvizFk5k/y5LDSv6GhvqGM5gLYqUDR
	AYhWCZYmlWW0wHnWTjcYxI9uc8RJDA1U7LMuy3ZqBfNFoQ5dRGVlU9XNK9hXAu4=
X-Google-Smtp-Source: AGHT+IEUsV4QyGJ5s7eoDrQbcC+vTg7j36Tkp+hsSatBFYgXS89bO8YfYY7FFaMQJP+SiVLtsTp+Kg==
X-Received: by 2002:a5d:598e:0:b0:343:4c43:b38a with SMTP id n14-20020a5d598e000000b003434c43b38amr2695374wri.17.1711975177452;
        Mon, 01 Apr 2024 05:39:37 -0700 (PDT)
Received: from [192.168.0.101] ([84.65.0.132])
        by smtp.gmail.com with ESMTPSA id ck5-20020a5d5e85000000b0034349225fbcsm4284757wrb.114.2024.04.01.05.39.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Apr 2024 05:39:37 -0700 (PDT)
Message-ID: <9a063c39-6d2f-43c3-98b3-e4f8c3c6e9c4@ursulin.net>
Date: Mon, 1 Apr 2024 13:39:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-buf: Do not build debugfs related code when
 !CONFIG_DEBUG_FS
Content-Language: en-GB
To: "T.J. Mercier" <tjmercier@google.com>,
 Tvrtko Ursulin <tursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com
References: <20240328145323.68872-1-tursulin@igalia.com>
 <CABdmKX3V3HGA4mNQvqHqhcLqyr-A5kJK8v9vmuDybRvV-KsiOg@mail.gmail.com>
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <CABdmKX3V3HGA4mNQvqHqhcLqyr-A5kJK8v9vmuDybRvV-KsiOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 29/03/2024 00:00, T.J. Mercier wrote:
> On Thu, Mar 28, 2024 at 7:53 AM Tvrtko Ursulin <tursulin@igalia.com> wrote:
>>
>> From: Tvrtko Ursulin <tursulin@ursulin.net>
>>
>> There is no point in compiling in the list and mutex operations which are
>> only used from the dma-buf debugfs code, if debugfs is not compiled in.
>>
>> Put the code in questions behind some kconfig guards and so save some text
>> and maybe even a pointer per object at runtime when not enabled.
>>
>> Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>
> 
> Reviewed-by: T.J. Mercier <tjmercier@google.com>

Thanks!

How would patches to dma-buf be typically landed? Via what tree I mean? 
drm-misc-next?

Regards,

Tvrtko

