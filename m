Return-Path: <linux-kernel+bounces-147855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F4B8A7A96
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAB5E1F2229B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A3C5680;
	Wed, 17 Apr 2024 02:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mx4DaGaJ"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80ECC7F8;
	Wed, 17 Apr 2024 02:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713321113; cv=none; b=piAhk+OHFnFhMHQ1mEqTciX9YWwP7V+tmSsBVFM2iVSlsQBF3sr0ddCuXUw6RPcLNlCh0ye9XQY+0g7HsQfD726PT9T0EcP2hPcNr+wcPuEvucNClEFuL3h1cY1nFy76Fco2ei220k8izeJ73VNtwjZI/+F0P6LVzFe8Dv9fdGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713321113; c=relaxed/simple;
	bh=Bdjzekcy0eGckzdChAQ1WLyEcYZJNaqrGH6nC/2iSUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Le62P6pXZZyALnlFrMCMw/UiSQNx1kOXuzJwbMyrWuLWGzcgOSV1ISyJSTYVF+Y/8xOdxCCGgUsrU0reyWcyJ4N6pNVYNaxkfsFAT/4TYGNzPSqGOAHNln9uWgeB0djLLNu40WJGY5IaFaqbyuLX1wGO+KogxHg0oS1d6fFU0rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mx4DaGaJ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-570441bc23bso1588346a12.0;
        Tue, 16 Apr 2024 19:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713321110; x=1713925910; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLxzFgXT3MHB159K1sbDGa/EUJR7X/HFjnuDr4sEUno=;
        b=mx4DaGaJ7XC4BGfIiWz/ibYYgZX81oYuTM9p8fx0TvPyBiqIAi7TzFADpOivlBGKf+
         /1OVn77nh6e7klTCMI+O4y7zLOTL+zfanvTBkfcY3weErhhGS0F3VPWPZphqEhm5lq0+
         e9mblRWnOk+uA5kUzRASI/T5IQvDVRIh01WQABom/XOGi7yYlqrmZ09FxfM1YlSp1oTI
         xTD3q6GSxBlgXhSvLkCMrrdQFMUbC57dQEkOijFEVdddLoWoJ/8To0vFfReIZF4agaCU
         ffiZfl90KJfIAht4MlTOFq2pIBvmFKONYbJqnv98nIwFIIgKZVAhZViqg3MrRj+wJ+iN
         3WWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713321110; x=1713925910;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sLxzFgXT3MHB159K1sbDGa/EUJR7X/HFjnuDr4sEUno=;
        b=awsPk3f9fbP96dSoYKg2OxXuI9oANyJ0F7NrRIRXZfumLqD3HO/LYHX3v0I41RfvUD
         5PXHYkoo/GKEtwNMiK2OQrGn/mNLpFEQaVlPI+pUXx4t5syWbyI+dUe+vrOP7o8R53td
         f/ki4T+vFMWsNdfDvu6LdAD3OqoyNfHA5yuKVg8xlXPPPOsCaG+sqrSqcUYix2jsTFMO
         ycg7I/sA77fXh7gO+PzZoF66vuIR1tUn6m6oT+LCpiNPrPoUakDLBIu0gIhRjiBxmv00
         9ZB26HDlGyM7i6fEQembQWES6YJVbZfhEe4zA+Qo0pokOKnpEniYAIlmrceLvwhPIWEr
         Pi3A==
X-Forwarded-Encrypted: i=1; AJvYcCUYOeOGXS6oampVWBFEgH5pmfIXiSfUYz+eXCzK9ri8G0fGaCUgZ758qUsCPrhyI6QkemCsBmWY04TFbvrQhugnc2tDaEbkTKrWW0cxnx9x5hgxJ01zIA4ez6KkxLRWRxfUwC22gR9kAQ==
X-Gm-Message-State: AOJu0YwgnnEoz1ICSy2vWSi/OR++pA9gdzKCHwnBjIY5yz6YJep5nmra
	6RCUD0xSLSQKjK0mjE4j1MnIR+jCo/ksZgAJ37Vy3LWiaX6bWPd+voeP9FOf
X-Google-Smtp-Source: AGHT+IG1ofJ/hLCDgOPDzSCQq51uNaCKrfcQLvF5/n8mz4DFU14PSiIxYZGV04kc10i/EV/WUsy98Q==
X-Received: by 2002:a50:c302:0:b0:570:7e4:8e9e with SMTP id a2-20020a50c302000000b0057007e48e9emr7402448edb.15.1713321109214;
        Tue, 16 Apr 2024 19:31:49 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id cn22-20020a0564020cb600b0056e34297cbasm6686274edb.80.2024.04.16.19.31.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2024 19:31:48 -0700 (PDT)
Date: Wed, 17 Apr 2024 02:31:47 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: skseofh@gmail.com, robh@kernel.org, saravanak@google.com,
	akpm@linux-foundation.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Daero Lee <daero_le.lee@samsung.com>
Subject: Re: [PATCH] memblock: add no-map alloc functions
Message-ID: <20240417023147.ybefdy6fn5drvq5w@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240415142448.333271-1-skseofh@gmail.com>
 <Zh1HP8IWWjexAUKN@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh1HP8IWWjexAUKN@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Apr 15, 2024 at 06:26:55PM +0300, Mike Rapoport wrote:
[...]
>> +	
>
>This changes behaviour of internal function, what effect will it have on
>the users?
>
>>  	if (!base)
>>  		return -ENOMEM;
>>  
>>  	*res_base = base;
>>  	if (nomap) {
>>  		err = memblock_mark_nomap(base, size);

Mike

One question may not directly relevant to this thread.

NOMAP doesn't apply to all arch? I took a look into the direct mapping
function on x86, memory_map_top_down(). It seems iterate all available pfn
instead of skipping NOMAP range. 

>> -		if (err)
>> -			memblock_phys_free(base, size);
>>  	}
>>  
>>  	kmemleak_ignore_phys(base);
>
>-- 
>Sincerely yours,
>Mike.

-- 
Wei Yang
Help you, Help me

