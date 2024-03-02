Return-Path: <linux-kernel+bounces-89500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A9686F141
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 17:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38A73B2110F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 16:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C688F1B5B1;
	Sat,  2 Mar 2024 16:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hZbh0UKz"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538BC18658
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 16:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709396707; cv=none; b=UkVW9ungBe8rHG/5y8hmDDTg/9R50KOh5icPWNjJxQ+CSVmtMn5sLYyNwGRjNH1FyksetiJT34hdV4Dwct7FV4K6FHV7stODYhNapvFrODUlYaYPy1C2PHE1GehdPW4TPcv1GqgskEvDLu+wsWYFpeZrmBu9rpyz1dLPFG0O3WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709396707; c=relaxed/simple;
	bh=ax2pzfvmcmFNuOiFOXT2F9aLf150ScjWSfyPfKGcvE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=usD2JCKNfEleEbGffFnQSTc2SrdgxkE7rlfJgHdpCF/bbI6ovhGn0AUfhK1VL/WUT/nkI6NyVHO1uEuW8RagBQfvYs+3+ZUKx9EjjBXXZn+12d58VYLdJ5aJtwlruxrSc7yP4dDpPg3TUNyptzoxImFr+24SNgXeCKjuTJwqrVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hZbh0UKz; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5131a9b3d5bso3343942e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 08:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709396703; x=1710001503; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gauo3pk3rCFxPPbYZzn140W+ByB2BogRzdThf+5NKvQ=;
        b=hZbh0UKzdPWCMI0a3WdiYMXJhCjk9xnWQnT9Pp4O5EyYJ+BDbahJ+xLdiwsVlkSk9h
         sJOEdYdeaokflyU1gkfWY4H/5Y+U9IS48z2oNfK2t+IjTn9j4w70dgKTrlLXHxHl2uIm
         wPhHMsK/fYEPWkoF/cDWNH493nqZZQGP4XyTIVqaJqIKw5PDOjDBL0cjP0xOg/z1ZSRj
         Vlh9cMJRHc34G741S60Vx6E8Lfc3VrbrPnIbREqYLp5otl5JZtyz4CWmP0KzIywDJ77O
         yZsKLtaQW9cpGmXsvu+cfFKpAIGZ3ZDOBwup6pD2TCogPdKDVksK1FPAUYYXr1/hPbiy
         6v6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709396703; x=1710001503;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gauo3pk3rCFxPPbYZzn140W+ByB2BogRzdThf+5NKvQ=;
        b=OubUPiWxFsYQ6sUC+ujqDA5PVJBFslWKrxcZLacxq3qHPvLkZSgDkArtBsdcTHLev3
         OjX+UddkYRxWMBLvS5ybBQ2SZnTsa4Fg7cvf0eyNnwIpC/r37VX2bV2O06kxDLmESFkm
         BzWvP5pOMiYISwBDyYLQW6cBWagg9bpQ3SXVg5bZ0tnEALSnwOb/yPdJD2mHU5hk8BiU
         zHT/Ik4CscqfDKoi3pIw3hS0YloWDImiQp7n3tblJslYJ9bAPK/T79qrsQ0oijoUNqb2
         25AFoSLYg1NKUXy9LSITFD2QMSNVinHqDXZR3/WBTz7uiTGvYoAUqkS9JwmAZGQmfE7U
         jnaA==
X-Forwarded-Encrypted: i=1; AJvYcCVKTshAF62Da3h5GAZDClJNsfWIsxz4S6z0TTmULr/Tw1NM7PIuxs4WfEVlO8NiJ5ueEK76ViPiVy/UpymqWFcPUQMyHH6B2c756MIX
X-Gm-Message-State: AOJu0YwmqkkI94m5Jpk54K/EW6O1GYl6XSXb32UuCuc/IL8T32iGOszR
	V/Kj+SYYWfPyA0OhF5SKczylSlYC+tM9JrxuJgYYGQW2NV/gf3M4+oswtlVaUwY=
X-Google-Smtp-Source: AGHT+IFK0r1k7ZusdDAuMFoSXmd8jVLZof8k6Wq6YRDfkURoXuCn9ZoU/5LE1AVq/pFntl7C5bIwcg==
X-Received: by 2002:ac2:4281:0:b0:513:1a38:2406 with SMTP id m1-20020ac24281000000b005131a382406mr3632341lfh.13.1709396703491;
        Sat, 02 Mar 2024 08:25:03 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id dj27-20020a05640231bb00b005667b411c38sm2285148edb.65.2024.03.02.08.25.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Mar 2024 08:25:02 -0800 (PST)
Message-ID: <c1a2021a-2a84-4edf-988d-09e18e7ff7f5@linaro.org>
Date: Sat, 2 Mar 2024 17:25:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memory/omap-gpmc: fixup wrongly hierarchy of the
 sub-devices
Content-Language: en-US
To: Brock Zheng <yzheng@techyauld.com>, Roger Quadros <rogerq@kernel.org>
Cc: Andreas Kemnade <andreas@kemnade.info>, Tony Lindgren <tony@atomide.com>,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
References: <6fftq2zlkpaf7xptyff6ky63cinr76ziyvdbm5jhj2apubr5vf@l4gvbdax3l2e>
 <f45b3195-38a9-4c49-b873-01e5a0b275a3@kernel.org>
 <20240301133809.0d26865e@aktux>
 <f59c9450-2784-46fa-afc9-4f194055cb24@kernel.org>
 <laqqencookmgwesfaetd5xw5wfmjdffmjvyjitapfehmu7zy5y@k7gsdexf3jcv>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <laqqencookmgwesfaetd5xw5wfmjdffmjvyjitapfehmu7zy5y@k7gsdexf3jcv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 02/03/2024 00:57, Brock Zheng wrote:
> Hi, all
> 
> Sorry for the wrong mail Content-Type. My Neomutt is not configured correctly.
> Updated info here:
> 
> On TI-AM335x，my FPGA under GPMC local-bus can not work on 6.x kernel.
> 
> GPMC <--> FPGA  <--> sub-devices....
> 

I don't know what to do with this. Apply this patch yourself and check
the result - is this what you want in commit msg?

Best regards,
Krzysztof


