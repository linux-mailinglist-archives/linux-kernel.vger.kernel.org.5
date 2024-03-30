Return-Path: <linux-kernel+bounces-125585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 923ED89290B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 04:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E3D8B22226
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 03:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764F87482;
	Sat, 30 Mar 2024 03:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikJq0UNv"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD15E6FCA;
	Sat, 30 Mar 2024 03:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711770174; cv=none; b=GibU7U8kOG2IWmstob7vwNAVZKdLhylsKUoCb/eF+uiFizjx7f7VE+OThy9rowmhjmRzrvvV8jOp3pzf3JCbJyMmLjOUjF2WwQHoo3ZmdTPU8QR0XFSVhy9aef1fk7RudU3KCRql4Z35e4DYjHUsL8REgs22k2kreh8qX3o4744=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711770174; c=relaxed/simple;
	bh=6LZDg9AGzn+18w9JxnNUfCqimi2ku7OLKcBAfPtPVho=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LWcUKcw9UWbrbxX7aEspgoVwbX2fDE4hliEIKEHuEdppDaU8uMRvu6Acun1dMhmvuvN1msEluY/ZNdl/7rN+R+QYntMysan5S3NzE09LSk1TUVKBqlEps6gCUl4/7AHZ7dIxFK6Vg9TLOakWY6XI5ny+wWFMhR+6y/SIPzDelj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikJq0UNv; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5d8b70b39efso1946660a12.0;
        Fri, 29 Mar 2024 20:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711770172; x=1712374972; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7eK8Zgv2EhfHCDXrRMiPvvB5f0GCwGnM8ahhB988ODM=;
        b=ikJq0UNvcUAgHmg5WxZ+Wu8FOb7HXSYOJngH8HgPgoogEPwEytRxeb7mUtHBeJfVcV
         yRfhe2SWnLJ7+EER6510nOLLWcYSDfSTz8GJb++qxZqr0DfdxRU9t6V5C7Apfw7m85xq
         jw/3bGtTv/k+s5nDqv8oszQSgRYI6V/D6HKIHaDW+nI6Z3T6RKoA8nePB7GOYlAqC+gt
         Fz6OimQ4208JnZP+WK/GRe0FAtho4kQTaxXle+cWKbKvQhzub7qVLXe97VNZTnmZHwmj
         cHCM12pOHrESGgKVlUrg3U/UmL5g77c5YKkCoJf7v5ieedeTLfOa2CMUH6/RDDFqNROB
         NFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711770172; x=1712374972;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7eK8Zgv2EhfHCDXrRMiPvvB5f0GCwGnM8ahhB988ODM=;
        b=Dnbgl4Ch0xc4LYFl083vIxXm23mE2uFojBs68UuMRPPiExdmGv4SyNHIYWY+WQW9ur
         Gx4v8cpajKjNDdAyFDbR8wy2kCDh0ZkF5cs/BSRz4UotWgqQErHGKPiiZUkLnwPYyWaM
         xwOG3G5+J4LAcF+Hrc20XXm3dhyYmevyhtJLQUDTzMHkMddeiE5+wPzUuPUO+hT9Wlo2
         q91ZvrAnNTS986fMAvPEyy1sLA3HsHsRBDf93X5IeDZk5KbPgx4BwEwQpxAVEh7JfL5b
         U36M0IFBUcqPueLf1/dj57W+FK34FPonzwukIa4fwC5DtIVUkY2Z3TqmSKZwdZhuGR6f
         IVnA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ4iMpuWcFi+b9B2O5MW1IvSNOUwUZZkoz9B7oSJYZ8Zt+1HhmHmLAdUDxR5eCNpWnk2lelIoWsx93lXErtHUJv/w/TMeUbfqXysu9aVAo4NXq8Ly7DwtDVsLyVbzj6Yd2AAVa/pVm
X-Gm-Message-State: AOJu0YzmQkc4+Bee7iZZWc1RSiuX/6juA5OuI0ZSl09bD2bHZT6dtDur
	DAbV5c9IM4b+bvLKszAV3iFZ+waQCvZ8hRZOSqyKfA0/xO9fA7pS
X-Google-Smtp-Source: AGHT+IHAXoLb+nPFUDEvaW5M8v4dfY8CJEkYn86kGpRDeawOoSSXbCym4HLbLuSb9Du35p3GP0Fb7A==
X-Received: by 2002:a05:6a20:549f:b0:1a6:f8cf:1e23 with SMTP id i31-20020a056a20549f00b001a6f8cf1e23mr3351963pzk.41.1711770172099;
        Fri, 29 Mar 2024 20:42:52 -0700 (PDT)
Received: from ?IPV6:2600:8802:b00:ba1:cc2b:c45f:1699:a1c3? ([2600:8802:b00:ba1:cc2b:c45f:1699:a1c3])
        by smtp.gmail.com with ESMTPSA id ev9-20020a17090aeac900b002a03d13fef5sm5849162pjb.7.2024.03.29.20.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 20:42:51 -0700 (PDT)
Message-ID: <4e014c33-44d7-483c-a9be-b24bb82cd1aa@gmail.com>
Date: Fri, 29 Mar 2024 20:42:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v2 1/5] clk: scmi: Allocate CLK operations dynamically
To: Cristian Marussi <cristian.marussi@arm.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com,
 vincent.guittot@linaro.org, peng.fan@oss.nxp.com, michal.simek@amd.com,
 quic_sibis@quicinc.com, quic_nkela@quicinc.com, souvik.chakravarty@arm.com,
 mturquette@baylibre.com, sboyd@kernel.org
References: <20240325210025.1448717-1-cristian.marussi@arm.com>
 <20240325210025.1448717-2-cristian.marussi@arm.com>
Content-Language: en-US
In-Reply-To: <20240325210025.1448717-2-cristian.marussi@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25/03/2024 14:00, Cristian Marussi wrote:
> SCMI Clocks descriptors expose an increasing number of properties, thing
> which, in turn, leads to a varying set of supported CLK operations to be
> associated with each clock.
> 
> Providing statically pre-defined CLK operations structs for all the
> possible combinations of allowed clock features is becoming cumbersome and
> error-prone.
> 
> Allocate the per-clock operations descriptors dynamically and populate it
> with the strictly needed set of operations depending on the advertised
> clock properties: one descriptor is created for each distinct combination
> of clock operations, so minimizing the number of clk_ops structures to the
> strictly minimum needed.
> 
> CC: Michael Turquette <mturquette@baylibre.com>
> CC: Stephen Boyd <sboyd@kernel.org>
> CC: linux-clk@vger.kernel.org
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

