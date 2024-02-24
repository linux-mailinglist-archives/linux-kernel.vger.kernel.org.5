Return-Path: <linux-kernel+bounces-79342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA25862109
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C761CB24550
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4F7639;
	Sat, 24 Feb 2024 00:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="WeRmfAyK"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF95383
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 00:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708733480; cv=none; b=cp74F5M2/AVCuxCI6MZ/E5N5ZFLUFKUz0PcaDA/rfUE4jEmrDi32IUQ1gHjggrgHXY3T9W/NnfAaW+ldM/HUhcGmI20QhfWeZKQkclBXre4u/tFXaJybtd69wCPGrYmeuIvX34RM2oABeJAy9zFujYbMY8dpgcunfvOq6vDAtoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708733480; c=relaxed/simple;
	bh=EmHMoSZK0WuGciu+lQIOGWywM8sKtSCzetuHOBmJO3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yp9A+Zwng9fJXN1Tl2PkRXGpxXS+PKnHR+sXxy8uNkptVdlrLOR0NjMjzSs5E2Kqwe5RrNsz/UkVb331/pfiGbZLKLdM8+iXanabLnOgRei5P7auseKiUjRSP8hAz6qUoo9jfNqDjpbfF1HzcjtopeKFDY2n4DQAwX23+4DNnt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=WeRmfAyK; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dc3b4b9b62so12410195ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 16:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1708733477; x=1709338277; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=izsFz9KLnzRpfRkeqMeNoOMaxIuB4D7Eh5oZ4fPB27U=;
        b=WeRmfAyKKBukl8suo4TvX+R3d4UnDsbOSlL8X012pPdMJYQac10uRefltYn6lQj3lN
         NuOMqCkSCTkoxxd7WMusxCfNU5YRkV/mfR13FYtW40aPTKq9Mxiz2vtDpMrfS/8VCKqq
         di3HP/wvHxK0Z40mRYZMxzPzKHiq1lPmsYt75BqrM4tDccBDeDwKqSI45HVKXNYPMAyv
         Rr03YBCjPnxNBk6nkbXNlMxJGgnihO1lxUhRKC9L9Pg+Y3xFJojh5itvs4bum3Oqr5MV
         e3toQEbI/h6Ueg2Nxdfdo2PBgzqzLCI45G7vy4CsJgQj+Ucj37SKNbuf1uWW2lBF//gm
         BeFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708733477; x=1709338277;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=izsFz9KLnzRpfRkeqMeNoOMaxIuB4D7Eh5oZ4fPB27U=;
        b=TyzolqGczYZz+AkK4BpJRikBBg/hqb1clVPLknSRj5TC6+/dcBUaleLu+emK0MujCq
         FUssWiDVgQYgvMwPb0hPWymDsBjxgNbFWHtEQHWbEym5StleWX1NlYLncxRxkw8ZaEKa
         WWeLPWT5+M0w/p65J0o4IEhtiVXK6LL3OnqaFfYk3+DSLPqh2SJKI+T/ZXA0KsC1LF7z
         eGIeRam3N1ExyM/wu+uq2+bjQXNwer00HdfhRhTWPm+tMhHN54JRlM5WjF7SqrfDMAP8
         Xz4RmBuPpbYtUiwhOyU0axtYJF4zNi1yOFx0uSXstXtqTamQrj6B+/AGKYzNaWIsOm+6
         K2dw==
X-Forwarded-Encrypted: i=1; AJvYcCWkHYVPFmqZln1j0RunrM25KOWQwrT5lwRuElXe+FbIDaOM94Vt+B8+o7CvHIYNiQnADoGIXXuODh3LUiVnsoCmpDiOX5mEROkUpqdS
X-Gm-Message-State: AOJu0Yy71vvmi1FzYcjmTLuh6Go3wIZA3xQRm5/KtTOpm1IeITt1RCcw
	dr3l2lUCE7qZoOHlLqWXyZwYiV5smVjYrjrBUrGCQqz5NCW7YJ8tRyDsJAEXWKA=
X-Google-Smtp-Source: AGHT+IFHxQxKJZFlacj9KQWpZyTQE98KOlH/aRfLE0uUg41+zpY2X5AkjzJNuhFQe3edIC+qLKW61w==
X-Received: by 2002:a17:903:1d0:b0:1dc:6b26:d1cd with SMTP id e16-20020a17090301d000b001dc6b26d1cdmr1731889plh.2.1708733476723;
        Fri, 23 Feb 2024 16:11:16 -0800 (PST)
Received: from [192.168.20.11] ([180.150.112.31])
        by smtp.gmail.com with ESMTPSA id s128-20020a637786000000b005cfc1015befsm60929pgc.89.2024.02.23.16.11.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 16:11:16 -0800 (PST)
Message-ID: <e1eb76f4-3bea-4d53-818a-9505713a005c@tweaklogic.com>
Date: Sat, 24 Feb 2024 10:41:11 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2] iio: gts-helper: Fix division loop
To: Jonathan Cameron <jic23@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
 David Laight <David.Laight@aculab.com>, linux-iio@vger.kernel.org
References: <Zcn-6e-0-nh2WcfU@drtxq0yyyyyyyyyyyyyby-3.rev.dnainternet.fi>
 <20240216135812.07c9b769@jic23-huawei>
 <dfe6e5da-b104-4acd-b323-4a7fa980de88@tweaklogic.com>
 <20240217162724.767f2ab6@jic23-huawei>
 <65582213-1091-4877-ae83-c9450a3610fa@tweaklogic.com>
 <f1511679-0309-4aa6-bbfe-40d0d3374634@gmail.com>
 <20240219193254.2800e00f@jic23-huawei>
Content-Language: en-US
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <20240219193254.2800e00f@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/2/24 06:02, Jonathan Cameron wrote:
> On Mon, 19 Feb 2024 09:22:24 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> On 2/18/24 07:26, Subhajit Ghosh wrote:
>>> On 18/2/24 02:57, Jonathan Cameron wrote:
>>>> On Sun, 18 Feb 2024 01:09:33 +1030
>>>> Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:
>>>>   
>>>>> On 17/2/24 00:28, Jonathan Cameron wrote:
>>>>>> On Mon, 12 Feb 2024 13:20:09 +0200
>>>>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>>>>>> The loop based 64bit division may run for a long time when dividend
>>>>>>> is a
>>>>>>> lot bigger than the divider. Replace the division loop by the
>>>>>>> div64_u64() which implementation may be significantly faster.
>>>>>>>
>>>>>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>>>>>> Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
>>>>>>>
>>>>>>> ---
>>
>>
>>> As I understand that you have already applied this patch but still,
>>>
>>> Tested-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
>>
>> Thank you Subhajit! Your effort is _very much_ appreciated! :)
> I had to rebase the tree anyway to squash an unrelated issue, so
> I added the tag whilst doing so.
> 
> Thanks,
> 
> Jonathan
> 
>>
>> Yours,
>> 	-- Matti
>>
> 
You are welcome Matti and thank you Jonathan.

Regards,
Subhajit Ghosh

