Return-Path: <linux-kernel+bounces-95416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 002F1874D5E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 947991F25A5E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5231292CE;
	Thu,  7 Mar 2024 11:26:18 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A23DDC9;
	Thu,  7 Mar 2024 11:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709810778; cv=none; b=Mp0iMOAiV0+iMGN2QxFWZTqVgCAWcho/cI0/x1tVXwcvT8Upv4dm6Rg7Q32zKtHqQU7IYsvUK10gbsa707Rbz6C06q8EPIDnu1M1WF2ZBoVMaPRqEyQ1TSmu7GOacQaycLYuikgaCwvED2ugv0jxzx2aPMFiC7zN4RmwtbHCpwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709810778; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DY6sHoZmK4UHF9iJ9oErclAe0GrPDhAXkeUab3VPEyDgLehfQxDov9CHyVO/I++mGaDqBRLGUEKuBTlmlOG3OPEoFt/8mlV9XVTfyMHeBDZrKuWEEewfzJ9Xv2lyiiT5N5pPmd5ov1/qZ0ieZtoqrVW5zVkqQLNu9acamfwMsAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-412b30be60dso570235e9.0;
        Thu, 07 Mar 2024 03:26:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709810775; x=1710415575;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=kGe0IzVgbFLqK6gRlG1ecnzHoOf85s3AuX1S70wsDkFsvufMyeh7KEkmg1SiQMY3v+
         5D35HhaRnn0Q9RgoFqUcl8ng6VLnkHyS9PkcLNSqXKriFQTCsyzu5C5Pxu+e4PL1DD7T
         p+XY9bE/1HnYOiCZOvx4E5N8nGW3N6zTSPWNyloaP1HJUnlQEWt+jiMwus8OPizpijRH
         v9xYDmu7dEzKVI7qPQIrzM8mQYHbd3fb+h4tIojD5AzigkTpu5U/jl12AMjk6sXrakrA
         cGdmDlMBuHtHkTZi918JLdJtzRgOb7PrNkVQNVG1E5n5fJoHDngXR/uobWlixptJJNlN
         p5KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWY7YH594A6nohkFnaRlsPzCLcw2KQT7Doq9ghGHbV1N62IMkRDiVFf0UlFB/r+nfBk9TtQfLFI1H2MHLCI6WmYu4zEdftW7J/nISBM
X-Gm-Message-State: AOJu0Yx0tJ615rQjWBSoNXzkIdlvLyUmxsesCPJ3blIGgJlchXusCtGW
	yjmJFHqAY0L1Cs+bM0kajlrhuJ22YDZ1UO0wSnaYr0RbxshA0WLE
X-Google-Smtp-Source: AGHT+IFm+7MxOu3fDpLkwzIcqHR9cgT2v8ltFU9iczqXmavVdH66t40nMcjz7U95lrybmjK45xN9Ug==
X-Received: by 2002:a05:600c:1d2a:b0:412:f887:644f with SMTP id l42-20020a05600c1d2a00b00412f887644fmr1205411wms.0.1709810774608;
        Thu, 07 Mar 2024 03:26:14 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id fb12-20020a05600c520c00b00412f81ba413sm2355351wmb.11.2024.03.07.03.26.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 03:26:14 -0800 (PST)
Message-ID: <e9fbe206-aac7-470e-9191-1949632e0304@grimberg.me>
Date: Thu, 7 Mar 2024 13:26:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] nvmet-fc: remove unused functions nvmet_fc_iodnum
 and nvmet_fc_fodnum
Content-Language: he-IL, en-US
To: Colin Ian King <colin.i.king@gmail.com>,
 James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240307110158.1981401-1-colin.i.king@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240307110158.1981401-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


