Return-Path: <linux-kernel+bounces-31444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA3D832E69
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AE711C242D9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C2756755;
	Fri, 19 Jan 2024 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxNMatrF"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2413D56456;
	Fri, 19 Jan 2024 17:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705686867; cv=none; b=jtDR2h6xTPqWwGQ7hpGu2U2fH3leUO8z5g9w8HcpROL+za4Abr+YOn+aH9JYNkp9tNs9DKfE6eEveP03Agj1wvD6AfSnjJ1CDgP3WtyGp+pfLhaz9wIjRvxE2aFqLRLRu8MgFgPOzGUv84s1OKS/SAsYx0jpCwVo+LjKt/a4svQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705686867; c=relaxed/simple;
	bh=E0z97uQ6yQPm/3szsLRhIGYBlbGjnL4leaNypuoRZ4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J4/mlXSapKFzloNbLzIWFijWCDjmEcrF7XRxT6sQkSY78c3ZrpWiEVbJU6J+AjGvO4uHDZK2bsaXtlm3fThE1aHcauHLnf28gJsGBKTjmG5EkQ9LA9z6+F+9ObtX3cnUtqfwlaS37ycDBNgIL9TQ4850UBWX3ff/uUwzbzCv1ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxNMatrF; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-28e84e3767cso831865a91.0;
        Fri, 19 Jan 2024 09:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705686865; x=1706291665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Zv3sJhlHlawedPmG8t62+Jm0am+4Wi3ALNw69cqMe4=;
        b=kxNMatrFTdvCzvtLLX75Dv4GhrjAKqGVM0CBRWRfNjNg6pW16lv3mjHPcC/BwFqN4t
         5iv+Z2mjtHBMyeo76Ini7BTFXy7DSRrfmicke+qXsYsziKvSjgaQRB/cLBFsv6gMcQVs
         hsjeBDUgN5V8sStOai3eF1EtcnaF2NBaYYf5lTY6Qo7DnRlod7ukQXCa0KSPcGFIlggF
         fWoBxzAJS7FLJK5gHTKuFbe5ful8jf0+r/K71SdQYzEGaNoE5SqRrDlQIINJPHdafmKk
         jvvQ8ZLhGZYv4/3sB6+uJb95DaGh1uphXrAqvW+KT8CFMfT54puMab0QOrJcXMx9w/ZN
         EriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705686865; x=1706291665;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Zv3sJhlHlawedPmG8t62+Jm0am+4Wi3ALNw69cqMe4=;
        b=nVmbb1acruuwpLSv2Jhwdh4GiQ/Lk22ctbCgKHP2110slr7Q04vMlzbHyx43zceWby
         YO9s1eceo9BWUVdvpSioRQgztJKCkVuLsrDBIDOO/PCh9JkMH/79g2CLJPPAwssvBwXh
         x8g2nqdl5txS7BE6ERTulGeBEg7N2ECT/8xyVdz62fz7RtXx9Bqz1CMhX1OJrYKTLYo5
         ut7kdcX+otHezNyunCJost6vaYP1b9dmTnvA5I9ujuubSZk/McgPewqmhADy2o48sbCs
         BPTj2Au5d6+WTDuE6+/RR1w24upwS1VDHMUlbDQTx94i4GEMeG3nueJnPp5+O6W7PIFf
         sgZQ==
X-Gm-Message-State: AOJu0YzisieZ4ydAqz6sZRgQlt2V899+LqKnOJREVZR+SRcmh94KCeOZ
	2wpPubFUKgyc1/d7Fi4Ro5/jegwJRR1axieUGS9Qs7PH7If11UjxIcIYANXa
X-Google-Smtp-Source: AGHT+IH3yc+KsmyVzIA817/J0FFbh+6fxvetf5lw7ZFjFiSvUiMZXLpmZpPSERhyKxjhP/6goWrCuQ==
X-Received: by 2002:a17:90a:b391:b0:290:56f0:800b with SMTP id e17-20020a17090ab39100b0029056f0800bmr1097695pjr.44.1705686865369;
        Fri, 19 Jan 2024 09:54:25 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id nb17-20020a17090b35d100b00290394b25d5sm2953663pjb.22.2024.01.19.09.54.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 09:54:24 -0800 (PST)
Message-ID: <dd69de97-155f-441b-a640-b35c5a7d40ab@gmail.com>
Date: Fri, 19 Jan 2024 09:54:24 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MIPS: fw arc: Fix missing prototypes
Content-Language: en-US
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240119133634.96420-1-tsbogend@alpha.franken.de>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240119133634.96420-1-tsbogend@alpha.franken.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/19/24 05:36, Thomas Bogendoerfer wrote:
> Make ArcGetMemoryDescriptor() static since it's only needed internally.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian


