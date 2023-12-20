Return-Path: <linux-kernel+bounces-6797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62343819DB5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E52F287ACA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0680421357;
	Wed, 20 Dec 2023 11:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQrNWZNt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECD021343
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 11:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d3eb299e2eso5136445ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 03:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703070692; x=1703675492; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CW8QHigc7u7A+LxPdR2yYff29cC2tGJrVqzNJzM3nrI=;
        b=UQrNWZNtcjEyeiNgs4cc89W5M9d5oXxG+bwhunfaUsrBl9/Sw8bTAyibva9iyKpqj5
         htkGBYhsM5YzwZGnNhMAU+dM68jxu2JuQpMksjmF7okr64xUnyofebIuqcDXHDhCM6TY
         RdywH3ZG836/oo8xcwRNeEn8oihT33CVxPsNop5oS/j+OEJb96MYtn2JJNutkCO81FnM
         njGDF7jyG4lLckkq8KeGYESDJnTasyAbSI9wydWj23s+ZNNyvz1jLmAHPXNiqD8gS/Sa
         fV1K698vonnSb8KZDHhBOT0YKFRkObkoORVUS/msX+DGDGs1SrAZuDW+lxzCb+Tbh0NY
         0TpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703070692; x=1703675492;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CW8QHigc7u7A+LxPdR2yYff29cC2tGJrVqzNJzM3nrI=;
        b=kfoH6VJiLpzrSlthbUZkRVyFENpDoItEgFInb+2F6FPV2jg+qy4iZSrsiBrxsnm1Hr
         ER9aGPcybdsPaBGFUxkA5TdcOP0rO7Zth044wpIj8RM6mioIIHyDBzd2AaPNH8VPM9bC
         wl1AQzYZTyGxeKu2dQ0ypmShTXfcLAxZMXABzy7MAKayKYrCwS7Kd8+DCMl/ZFg51OxA
         I0wtcKsYzHp8lgyCv8gLRt9EXEmHa4yRYuN/hxnp2JdGdb4WXuIYgJOsPqKkxM/Bi/dx
         7UKgEOAyTVAFnBpOxdW8FN054M4S64otUZa03FxRZc+hqEnoP/AIuyScR4sUQEzuLw5z
         +fHg==
X-Gm-Message-State: AOJu0YyZSqanPAzZYECY8aYgNyJ7SlCVgGGj0d/3PZ4PNox3xKpKNAHx
	8sjkR6unxpP02eRl/3QlJQQ=
X-Google-Smtp-Source: AGHT+IGpcm3ixSliatDE5AEQWq865kgGOdLVdZhDB9BzNjLdE46gUA+YSII+K9jbur9v6K3pU26NBg==
X-Received: by 2002:a17:902:8bc6:b0:1d0:c942:37c4 with SMTP id r6-20020a1709028bc600b001d0c94237c4mr10322705plo.52.1703070692228;
        Wed, 20 Dec 2023 03:11:32 -0800 (PST)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id b16-20020a170902d51000b001d365153d09sm11871707plg.184.2023.12.20.03.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 03:11:31 -0800 (PST)
Message-ID: <846e883c-e3ae-426f-83e3-38e357e53ef3@gmail.com>
Date: Wed, 20 Dec 2023 18:11:25 +0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Automatically update drm CI dependencies?
Content-Language: en-US
To: Helen Koike <helen.koike@collabora.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux DRI Development <dri-devel@lists.freedesktop.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Maxime Ripard <mripard@kernel.org>,
 David Heidelberg <david.heidelberg@collabora.com>,
 Dorine Tipo <dorine.a.tipo@gmail.com>
References: <ZXrNI9Pqln9HVYVc@archie.me>
 <1844c32e-13f9-4225-88a7-1c621a3bfc75@collabora.com>
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <1844c32e-13f9-4225-88a7-1c621a3bfc75@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/19/23 23:43, Helen Koike wrote:
> Hi,
> 
> On 14/12/2023 06:38, Bagas Sanjaya wrote:
>> Hi all,
>>
>> I'm referring to dependabot PR on torvalds.git GitHub mirror [1]. I know
>> that PRs submitted there are not accepted (the repo is essentially read-only
>> mirror), hence this mail question.
>>
>> In summary, dependabot submitted automated PR that bumps package versions
>> in `drivers/gpu/drm/ci/xfails/requirements.txt`. In this case, pip was
>> upgraded to 23.3.
>>
>>  From my experience, such automated PRs can pollute commit history (in
>> some GitHub projects these PR kind can contribute up to half of total
>> commits since the beginning of project). And in some projects, dependabot
>> PRs are automatically merged without any maintainer intervention.
>>
>> Does such PRs (when submitted to LKML these will be patches) make sense
>> for DRM subsystem?
>>
>> Thanks.
>>
>> [1]: https://github.com/torvalds/linux/pull/807
>>
> 
> imho I rather not having this automated patches, but I would like to hear the opinions from others.
> 

But why? Did you mean that making the CI always depends on latest version
of dependencies create another maintenance variable (and may constantly
broke CI)?

Confused...

-- 
An old man doll... just what I always wanted! - Clara


