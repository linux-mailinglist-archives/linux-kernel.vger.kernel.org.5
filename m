Return-Path: <linux-kernel+bounces-155509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A158AF356
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C569B23BD4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3711713CA81;
	Tue, 23 Apr 2024 15:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQRESpf9"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CBA13C687;
	Tue, 23 Apr 2024 15:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713887952; cv=none; b=kXQE0wR0n6mOCRlUVW3qGCCn7Vxpaj8FjKIkCXa5/cxADD4TeJ1NNu8a5Du7RrHlCH4D7Hk7Hkj0xmPfslPKyBnbVCkJa0wx6nkeCknDC9P3WxiNTXB4r5EEskrKKgwaiJDgorwWnh6qqh+cYQ0Jx+2Q9SNFfDmRFRXwMJSwmGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713887952; c=relaxed/simple;
	bh=+dHg90q3kt5uzx8OUAOnQDThLKxLvvuczBS3PMadXeE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=J6vtxteCpvd9cWjIj6zvx2hlGWIJaiinTYQCXIYZPHt5N8XhsF5jrmzixJZcAt6uERqn191cybGVGJBq20jh1t+ZQe9jRMy7HpsnAfBEhWttNpf0UIfGJOOiHOMWsdus7+OFcebsOVmu4G48egJYSREXqcUPNvK1SV/lLjw2a1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQRESpf9; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e3c9300c65so50043945ad.0;
        Tue, 23 Apr 2024 08:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713887950; x=1714492750; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5YhrAGWDia8r0qfX9pD7CKdUw7GJuUdNgtQ0L7MN4Cs=;
        b=UQRESpf9vTq65HPIPdlQbYuytkXYb9Jra66vCdlIGgXkn9TPV/6ZTZZXqzAGVtWsAD
         dVwS9zCiB87SegrQUYwfjQSq5075kJHmpv/m7AUb+BkrkgYngRo9zlCjgH9An6GIxIKX
         BVUJ5+Oj+ZNXV1KpOCwfjgknJv7Msl8WcSLj0nuHKV8bDf9b+1nlJ78RQRsMS4b7T4D5
         q9SvD2rYw2RhsocOAYOsPAnEWbMAyHryubenGLWault3zhT0XxzZOYJ6dxqGBr1R3bA0
         IDkVR3NXUoT0GHbmjoQOQxZjnvsL5Y6DYPAmy1vOpqHwP8+acp5DtTv0Hm+RYNfCJ6YL
         Petw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713887950; x=1714492750;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5YhrAGWDia8r0qfX9pD7CKdUw7GJuUdNgtQ0L7MN4Cs=;
        b=teNkk281LUPw5fjw1nq/PWrg4GFI+0DeYb02QxxV+hOTWpOg6mz4sXyl+dQrlH8DV1
         HBYGc0962QG+w6eX1QMjZoA1NvsvtC6fskxxu9ogmLHS2RzH4AquTC85p9Q64MrY2uK9
         EA7DT6O39utKhJGSMhY+er1XscvwYRuQIOW5KBqf8PrY2enA7hpImXefxSQyqBlI8KG6
         sXfrPBU3z6dgr0CbLPCP45P9Ujm7EOmlXfs8b2fjPjrWED3fud2riDX4rGnj47RM5ooC
         g1A+E3MdX8SFLCA4my9t1V4+NRcOB+LET9a77si/Bz7HClaUD11VLPaT4MJSBfeLzEhn
         Uh8A==
X-Forwarded-Encrypted: i=1; AJvYcCWA82+6Fy85I2Pqf8K7ervHvqtggd/Y5Ouq5dKWAz0BYMHtEvmGfzhMfrr76XjKjsJAxZeMftD5Dma943Pt4c1yAT+uAVUVv7RkPC0N++8MHaIzg9CQeaEBHvXjIDrMO6NgmKewzRLs
X-Gm-Message-State: AOJu0YwDLEOpfzvCxiCRLhrtsQNXIXIDTHQPk8xANK3/8CLD56MI/zlb
	hYUucOuXoNXUhjFQH/jNLD5woelJXzfT5X/Dl3bH9xIYWJwabiKc
X-Google-Smtp-Source: AGHT+IH9bRCZSmUrzBavbSbB17corXaTmlQapmIBS3WHle9DmmLT+18JEktcMbp95Q+ylvXP5bVLgg==
X-Received: by 2002:a17:902:d349:b0:1e4:9c2f:d4f7 with SMTP id l9-20020a170902d34900b001e49c2fd4f7mr11377056plk.28.1713887950359;
        Tue, 23 Apr 2024 08:59:10 -0700 (PDT)
Received: from [10.0.2.15] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id b15-20020a170903228f00b001e4928c8026sm10215639plh.13.2024.04.23.08.59.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 08:59:10 -0700 (PDT)
Message-ID: <b1078bb2-bea1-4b32-9b4b-4c62e02e3ef4@gmail.com>
Date: Wed, 24 Apr 2024 00:59:05 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: carlos.bilbao@amd.com
Cc: Avadhut.Naik@amd.com, bilbao@vt.edu, corbet@lwn.net,
 elena.reshetova@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, rdunlap@infradead.org,
 Akira Yokosawa <akiyks@gmail.com>
References: <109e7532-6265-4476-93ea-34fb0b209691@amd.com>
Subject: Re: [PATCH v2] docs/MAINTAINERS: Update my email address
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <109e7532-6265-4476-93ea-34fb0b209691@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Carlos,

On Tue, 23 Apr 2024 10:19:14 -0500, Carlos Bilbao wrote:
> In the near future, I will not have access to the email address I used as
> maintainer of a number of things, mostly in the documentation. Update that
> address to my personal email address (see Link) so I can continue
> contributing and update .mailmap.
> 
> Link: https://lore.kernel.org/all/BL1PR12MB58749FF2BFEDB817DE1FE6CBF82A2@BL1PR12MB5874.namprd12.prod.outlook.com/
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
> 
> Changes since v1:
> - Update .mailmap
> 
> ---
>  .mailmap                                                  | 1 +
[...]

> 
> diff --git a/.mailmap b/.mailmap
> index 1eb607efcc6e..4bac5578426a 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -113,6 +113,7 @@ Brian Silverman <bsilver16384@gmail.com> <brian.silverman@bluerivertech.com>
>  Cai Huoqing <cai.huoqing@linux.dev> <caihuoqing@baidu.com>
>  Can Guo <quic_cang@quicinc.com> <cang@codeaurora.org>
>  Carl Huang <quic_cjhuang@quicinc.com> <cjhuang@codeaurora.org>
> +Carlos Bilbao <carlos.bilbao@amd.com> <carlos.bilbao.osdev@gmail.com>

I'm afraid this won't do what you'd expect.
Entries in .mailmap should look like:

  Full Name <new address> <old address>

See gitmailmap(5) and git-check-mailmap(1) for further info.

HTH, Akira


