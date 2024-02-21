Return-Path: <linux-kernel+bounces-74343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 081BC85D303
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9636D1F219C1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3143D0BF;
	Wed, 21 Feb 2024 09:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O/SXI0pn"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5EF3B781
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708506261; cv=none; b=uFYVNCA/bb5tyfoQsTRp0831SJKeQvMTVHnygvFLqiLsjdrepLhmqkZAppNdW/vSyxHWBSZ5GuJP3CyfQsniAjS4lkefjLqkpyJ4fmxkv5YWjfAwrR8LEbHwgzPHBAcgfBVKDxauiNY2g3lJbI7Yz08IFARyWqkSpwnicstdvyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708506261; c=relaxed/simple;
	bh=Zdda7Z51JmZWl++mrYVxmWkJ9CzTUizlHDqG7DrA8Qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BObSEeTsBiziyTLK0OsjsfJhuCc+/Ab+mFncU5Zk1h0j09okPJDmmDdDslD2YNA2uoXn0D+0L2iY5MU6F7BMhxdcTj2RzsSnQMF+MRhlbyqmEaiQ5iSak9pK+JinEcBGLZZWEXQDI+bAiFCZkGgZrcJ7E+7OYddW3Pj9kmZGx5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O/SXI0pn; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3394b892691so3473076f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 01:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708506258; x=1709111058; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PiEdifBXlbnyWblY09aSfoICLBbwdqMUIhM217sZ8bg=;
        b=O/SXI0pneaTLx2kJMf0Mhg2hufkizYbJvvLpwJRUN/LyCKbVnpj8raLayF8IbQswvr
         DErmIchmPbmdWbKto8NnO7SGZbIEKz+HGCcy2Wff4KQOKTsnofYFEqIlo4FLhF7jQTmQ
         Nx6s1xYEjNzRoF5DdJPvPaQMOX91kXqR4Dqvijua2EKEagSR+/2/0EoeXhWK2D6DZHZ6
         rd7ijN0ODNufKdheea4gFNMVqmtImM3vUXCAPR/m0lVF734DtwcIMTHkUBomFPnAtnhE
         tse0wcw1VZk2mhODLXorRsagqSFAcl2jvUsF2SK375a6qk7HRyJ4LRbBCiUrjhJFJmn+
         BFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708506258; x=1709111058;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PiEdifBXlbnyWblY09aSfoICLBbwdqMUIhM217sZ8bg=;
        b=p264SZHlYd2P2wXFd9xha0LfTUqYHbIBrez9hX2j/NaUVsY4E6cTUrtxEj2W7XT/7b
         bvrKj5z+dRVplGZ6Uevlc0pX5+37k2Tra8A9Ue7AwAq2ai51p8c+IrxfidLSzf3qzPbH
         mt5nC4h99KDG1f41AZyTq8Ak9f47c/ld91qqRVnTYiUb5IIocOMAwWCR1iGQWfzyJstW
         rawfMHLNmJ4KYlo5fjsFleRrr7dq2Df0RXSK1G80ZSMa6R5k1jfo0i/pDb00ZaUidCXd
         CsaVm/4/jKMvhBy6Ztlxs2VK2cn2VSPqR3SgUVu/6qsBvvocV5Xo0xcMk0uL1VnwuLqQ
         7hsg==
X-Forwarded-Encrypted: i=1; AJvYcCUG4HE3db4gMywDfS1lsasnLYwQMtpwTMYycTR9myJz2nCyuVa0gxX8tWGYLlnmOsNt6sy4xuq5lIYtPBK/z7OTuukv871/S2v/IsGQ
X-Gm-Message-State: AOJu0YydHa2gVy9UbV5zTIT/5ZdXJr+i6WxhiJD0tdY6kKJTXSk8T7U2
	WL+TQa3GVT4wRuf2z1EbkyKAcipS83xU7zrhSrSRtmCgHnthj4+jfeUQ9t53FASudfNil8S4eYe
	7
X-Google-Smtp-Source: AGHT+IHUSRlWWbsveuuOuWZDPXOkupYSiALK9CZwYRJSGQcRVc0UBKqwNs5oJrOFSmZTjWE31EBP1w==
X-Received: by 2002:a5d:5748:0:b0:33d:32f2:dcac with SMTP id q8-20020a5d5748000000b0033d32f2dcacmr9350526wrw.33.1708506257911;
        Wed, 21 Feb 2024 01:04:17 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id n14-20020a5d420e000000b0033d282c7537sm13626523wrq.23.2024.02.21.01.04.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 01:04:17 -0800 (PST)
Message-ID: <4cbac15d-115b-437d-a622-f9aa40187ddd@linaro.org>
Date: Wed, 21 Feb 2024 10:04:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource: arm_global_timer: fix non-kernel-doc comment
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
 linux-arm-kernel@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>
References: <20240115053641.29129-1-rdunlap@infradead.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240115053641.29129-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/01/2024 06:36, Randy Dunlap wrote:
> Use a common C comment "/*" instead of a kernel-doc marker "/**"
> to prevent kernel-doc warnings:
> 
> arm_global_timer.c:92: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   * To ensure that updates to comparator value register do not set the
> arm_global_timer.c:92: warning: missing initial short description on line:
>   * To ensure that updates to comparator value register do not set the
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


