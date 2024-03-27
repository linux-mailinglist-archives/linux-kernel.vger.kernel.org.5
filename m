Return-Path: <linux-kernel+bounces-121993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7724888F072
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D1729C539
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EDB15383D;
	Wed, 27 Mar 2024 20:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pc2TFeKJ"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72899153825
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 20:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711572309; cv=none; b=lFk+LcAH/Jm9Lz00CWEDHDSKPdKkB3JDZdDqtcn45ngW4Dkb4Zy+x72ZUDvE+YrtvkhtRldlZbuCQgQurn6WQ0ZCF1ciBD1sTqWi3r5us3rP4LmQopTx9GKa/nPoRgMiWqchwqPLRnc9E66c10N8T8M8aw1Li3iYW1QN2Byf1FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711572309; c=relaxed/simple;
	bh=ixlQO8RhdhUN1tbGRAkp9VE+RvI6opNhiyfhNSwEC3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JIs2KKGh9WvdvWPWnwIlLqPxrfXelN2KW39+wOLIskEbQFVclmSeWfQ7Jvf3gEVNabgelrnLnAiD+b/YA7LGHiMlWaLMgTfLvG3lbgbLI+26CHmLq91pbjLwGIcyIET05TNq3PUcXl+gb+AoYYIMmwhxX6Q0sZSoxNvlIWsltwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pc2TFeKJ; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51381021af1so331526e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 13:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711572306; x=1712177106; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+2J9nLYy8J8+z61AU5rT+2SBf2QX560BYXoYuI1hBjk=;
        b=Pc2TFeKJ8ldJaZ9+SyMk56f3LWeLcI/ARtIM0ws89r1/Sg0dsMmATfxIW7oSiZdgaI
         o+GQAWBuLQ8c7TxsSK9wllF0OATlljvkxFEKQ2o5FeXK9nbl3JoQdHBxfWRerz3mXGBE
         2lYtFgujAbYcWeLqqXVYIQCSt+5YTfAI2YN5p+llH51BzQELyi9nzLd5UITbWCAMn2x0
         FOwJ1U7nUVhFiUmCZZHcSRLRnTe8W3xyHPriS7q5checZI0N4Zwl2UZ0q8Ltc0wwL62S
         A9qwAAvnTVHVe151EmNF+Dt3APYSlhVaZx5R/4cq4deZ+Aspi/9dNlZjLpWuznW1eHTU
         FsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711572306; x=1712177106;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2J9nLYy8J8+z61AU5rT+2SBf2QX560BYXoYuI1hBjk=;
        b=kKyy9hTFr9Mrmy6FfGtl0Ghgxh1a/Wx8iHnSRW3IXmo3MTqiF3/LcLnI0ijrTOUdH7
         Xjp09qOftnLTFRI/XKKZC50VMjIOkSzYRcIcSPxf/7efSI6IxbngawwxxotHnKUIhvbw
         7svKfKWA1WkT5yAQtBIdzU/ACKMebe7OvO4S8D4VwfxBsximCgaGlQA3hkEX32oab8BS
         ut9zDPsMohFlhsiXMs2eCEdBCnxsqWhGSLbpn/Oc7An/wI26e41bUA7jeJTbjWtcwoDW
         Vunoro34NkMvPsmhf1AVs0AEZtrDFJeGOGPLzUR8uOQ/0gqWSXMYKTgs+S00+bhWWXEb
         5LCg==
X-Forwarded-Encrypted: i=1; AJvYcCWZ6ueUJbR7lNBza4oHntQDLySZFqg2FYhhsAkT5OkUQVDTJUU3uBp0KQOU+KyFMcZS9qxenv/JGW9/q184cPOEMcCwvMTlRKJtgaEF
X-Gm-Message-State: AOJu0YxbpTMVWwnubxrzRELcnBj6udT042jw0Nn+QUfQOxrnq16XvtLD
	9/Wd/Ngo8kiSDl8XDRUWxr0+T1x6MhDiqJ6eYEG2dSqbTZ0IVktBuxY7ihHb50s=
X-Google-Smtp-Source: AGHT+IGfBkN+SAs/zalXM4Oy4+YH1jeEVyBY7k6hLb2bWBypLcMmycOlj2HkShqeaNWqgvqtOBQSkQ==
X-Received: by 2002:ac2:4983:0:b0:515:ad80:c227 with SMTP id f3-20020ac24983000000b00515ad80c227mr524205lfl.56.1711572305575;
        Wed, 27 Mar 2024 13:45:05 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id q16-20020a170906389000b00a46a643b6fbsm5940969ejd.15.2024.03.27.13.45.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 13:45:05 -0700 (PDT)
Message-ID: <e0586d43-284c-4bef-a8be-4ffbc12bf787@linaro.org>
Date: Wed, 27 Mar 2024 21:45:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: cmd-db: map shared memory as WT, not WB
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Douglas Anderson <dianders@chromium.org>, Rob Clark <robdclark@gmail.com>
References: <20240327200917.2576034-1-volodymyr_babchuk@epam.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240327200917.2576034-1-volodymyr_babchuk@epam.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27.03.2024 9:09 PM, Volodymyr Babchuk wrote:
> It appears that hardware does not like cacheable accesses to this
> region. Trying to access this shared memory region as Normal Memory
> leads to secure interrupt which causes an endless loop somewhere in
> Trust Zone.
> 
> The only reason it is working right now is because Qualcomm Hypervisor
> maps the same region as Non-Cacheable memory in Stage 2 translation
> tables. The issue manifests if we want to use another hypervisor (like
> Xen or KVM), which does not know anything about those specific
> mappings. This patch fixes the issue by mapping the shared memory as
> Write-Through. This removes dependency on correct mappings in Stage 2
> tables.
> 
> I tested this on SA8155P with Xen.
> 
> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> ---

Interesting..

+Doug, Rob have you ever seen this on Chrome? (FYI, Volodymyr, chromebooks
ship with no qcom hypervisor)

