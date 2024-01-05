Return-Path: <linux-kernel+bounces-17532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C405824EED
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB934284FD7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 07:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFE56ABB;
	Fri,  5 Jan 2024 07:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKu2zwOB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AE8747A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 07:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50ea9daac4cso1433323e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 23:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704438435; x=1705043235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tZCwqmMcpVw5DoaGJK5pGXOUlg8HDlZYwX21/6+Ztyk=;
        b=cKu2zwOBaW7oQLZkIpP+SPBLgljRH/NK2igsrKnK3SajZD63CQyI1jFw9nMUHeUK57
         mX8eOcztJe2VMDwPskRpzUKFqzHlmkBgOw99Exn0JosYFJyjAcolIiQ+1KqPgDo1HMwQ
         9bknBFWnqv8hCU36Kc0/fq6JqmfVTOFyZfF3eiZ1DmLN+7WodKB4qJBs4Z8MvyOoj+gH
         BL2DaCL0T7M7A/LWEwaqVFyQnfn+WEsNFJzLtFq+xDtNHZZ6Vj1Z46a/vfNLW2D+ixfQ
         GYvc7aLRHfLbERu5FHu5qgboWZrthwBXEE2dUEtg+Uqlw9ckFYsUhBZH4Nk64wJaVXnv
         TBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704438435; x=1705043235;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tZCwqmMcpVw5DoaGJK5pGXOUlg8HDlZYwX21/6+Ztyk=;
        b=ST/4JyN/CJtzFmn1wRPwiXtxWSnuxyJNdpGeBYRW3RqqC51D/RBJRR4F2yB/UwjvGq
         t/YVqHXQ9KBWRwrr+jLb5vwCP5hHgvEU3ESKwfM/Rz45AOPFLItCeqn6zafwpqGYfvlg
         uaVo9R01fD4H9wPyfdoZDqXP+Bxam4A+Xju2ahzliRS7zeIKS9k1ZaGUkG8GHxJhD+b1
         eX7Dz9vC06lhQe3RVkPaS1A6M7dLWlAsbyTRt2uQSYzhAaJYgWG3DksSVi2KUB7x5MA3
         7ku+0P+YQTHcXB5f6yO6pMmuQP+qVxRm8msrS4yO2m2XV2ftFqBZxvQaKkW8Qjj3tBzq
         WDCg==
X-Gm-Message-State: AOJu0YxVqtMZpH27h3JgucHh4T+RnFJYVVb3OfkLe5lb8reA+x06f9WD
	K6e2cbp4wQTCEVKzh3WfHbAhocn+PWcrXw==
X-Google-Smtp-Source: AGHT+IGTH5AlGgPEiEJsNhzZtPETFR0cHfWpgC5+IldWkVVVvZCn7qsNRZUbxOkHfMXD/m5Q0hNwnQ==
X-Received: by 2002:ac2:4ecc:0:b0:50e:3e13:e142 with SMTP id p12-20020ac24ecc000000b0050e3e13e142mr696610lfr.118.1704438434762;
        Thu, 04 Jan 2024 23:07:14 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f8:1500::7? (dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::7])
        by smtp.gmail.com with ESMTPSA id o3-20020a056512230300b0050e9a8057f6sm151851lfu.259.2024.01.04.23.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 23:07:14 -0800 (PST)
Message-ID: <d32e0d41-28b8-423a-a8c6-76cae934d7e3@gmail.com>
Date: Fri, 5 Jan 2024 09:07:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regulator: event: Ensure atomicity for sequence number
Content-Language: en-US, en-GB
To: Naresh Solanki <naresh.solanki@9elements.com>, broonie@kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>
Cc: linux-kernel@vger.kernel.org
References: <20240104141314.3337037-1-naresh.solanki@9elements.com>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240104141314.3337037-1-naresh.solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Naresh,

On 1/4/24 16:13, Naresh Solanki wrote:
> Previously, the sequence number in the regulator event subsystem was
> updated without atomic operations, potentially leading to race
> conditions. This commit addresses the issue by making the sequence
> number atomic.
> 
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>

Maybe this deserves a Fixes tag?

Other than that this looks great - Thanks!

Yours,
	-- Matti


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


