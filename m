Return-Path: <linux-kernel+bounces-162059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2ECB8B5562
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9B021F21FD4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D548E179AB;
	Mon, 29 Apr 2024 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DtnhMIe7"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A0DA937
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 10:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714386784; cv=none; b=CusMrx5CVU8CS4G1/H2hVFKAa3mTBw4US8Q5m9dv6jYmmlKAZG8g2bW5VhJ3kZ8JUP3McyEs4Pb55JHb6AV5RlGhqKs40nZ6xmeS7RuIAah66ZshstLeYguf2ZL2LQ2QysdQmaJHH+1ue0jV0whk8qtrodj+7qUKGTMgJL+wptc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714386784; c=relaxed/simple;
	bh=z0Ip73Oq7JlEyErkx4LsdMIFywya1Q4jKa7bAbSZeD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFkyl2d30N3kCvTv6uJeeZnvs9Ifkc1CVIZBVlV5aV1mSpawa51uEL7ZNhQSfiCS9goaK+jtequp6FMwMpVgydKAD4Xhc/2YcTx56FuBVr76MHTGWS7q996M36nQX6EvmMJqc9lXLb/lrlfSMGydOTFE0IXEbhY/vMAsjcVwlRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DtnhMIe7; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a58c89bda70so343986066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 03:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714386781; x=1714991581; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GOU5F1NGvFs0bAJKPOpovNJQxbGpDe7agzDlwsoZt9I=;
        b=DtnhMIe7FJKb+tph/I4TU/8q+JbOiWAirJVRIgu7tUz+M57hdZXKrURpJkkDouEkH7
         2ROGRwJ0k72KM4diSg1g16P8HFFOcrp11sGHhI2/vfzva/LGFVjv13u66sH6fJKY7KNk
         Z5S41n8OJA40uzv19kwefRj26hNSu2XZfPwEMI/RUAqYi27SpShvgNrQYYpuzfZO5s7x
         ExN+pbSzCimffWW+HfAZrHIgG3e4KR3ZSGhUV23Tz4RFDRUZha571dk2kfJ5cl20Bdj8
         Snr4EF1dqNbmM3i+V0aNTWGClMtpbIkeevSgqwxPNaeciaArPLFMVHgkL2JTfhhukQx+
         dWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714386781; x=1714991581;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOU5F1NGvFs0bAJKPOpovNJQxbGpDe7agzDlwsoZt9I=;
        b=qBgiH+3J4QCM0PjF0NUK88Bc0VR9CArkclRwlKG1b7948wfM/VuXSJ6+2dRbSeE28n
         CL/bqV6h/8B8cHPKzraZNkPwUsRMSiyRMBh100C1Z2e01DvISiibioAdTy7Crr9SDfm8
         5myIbKApxlET+TQnpDUzPBFlwaGpspoU3OuG++K5q/Lga0X1mS69s/iXjQs1h257ehx4
         ZE2Jv9bPxr6Qn41MIC+QAWed+7LZ7pNRQzsu5kdInn08s0VFXPxXU5ygJMPi/8FHtleX
         P0POhbaWgD9dAicgbklzACnWMRVfLKC2fpotBr5c/NoCf+Ni6yEX1rFiMY0QJs1MlA38
         u2Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUxqAaW5OaOJUSS9jQeC5sMz20Lu4eRYEC6GJhjST+GNQnd1f+r3uI7JWgo1uKtu2Z9NbR2wF6kvICBGyOY5hTnoKI/Alru4g7J7NhQ
X-Gm-Message-State: AOJu0Ywo0r9DBXgMI3TrPgw3RPWfhChTTphGvP08CD7ZEO6YljnmRtNd
	WF+QXpuVNL7DYBaqSgu/81d+ZDbF1BVnaxWvYVuQXl8nPG+NK2S4mLPHK6+fIZY=
X-Google-Smtp-Source: AGHT+IGL1whmMFAwvGEtnLi5B9HGyCOJ5rCv/QBcu0MkZGGUULuE//bsrooaCcaofkuAPuzYaV5fYQ==
X-Received: by 2002:a17:906:4788:b0:a58:849f:4d18 with SMTP id cw8-20020a170906478800b00a58849f4d18mr8300393ejc.35.1714386780784;
        Mon, 29 Apr 2024 03:33:00 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id z13-20020a170906434d00b00a51e5813f4fsm13950947ejm.19.2024.04.29.03.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 03:33:00 -0700 (PDT)
Date: Mon, 29 Apr 2024 13:32:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "dave@stgolabs.net" <dave@stgolabs.net>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] cxl/region: Fix missing put_device(region_dev)
Message-ID: <856b5986-6f04-4aaa-ba35-fa5e6f3ebc2a@moroto.mountain>
References: <20240429013154.368118-1-lizhijian@fujitsu.com>
 <20240429013154.368118-2-lizhijian@fujitsu.com>
 <df5830dd-d822-4c11-9cce-3775dff0113b@moroto.mountain>
 <cd20f733-3523-490c-8bc1-73b7300f18b8@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd20f733-3523-490c-8bc1-73b7300f18b8@fujitsu.com>

Btw, I assume you're doing some kind of static analysis?  Looking for
missing NULL checks is very tricky and I haven't found a way to do it
well except for looking at failed allocations.  Allocations have to be
checked.

There are so many other functions where we leave off the NULL check
because the caller knows it can't fail.

regards,
dan carpenter


