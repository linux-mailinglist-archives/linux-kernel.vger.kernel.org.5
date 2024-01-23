Return-Path: <linux-kernel+bounces-34855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B40C783885E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BFC6B24A7A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E564F53E2E;
	Tue, 23 Jan 2024 07:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="elGjg72i"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737406121
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 07:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705996553; cv=none; b=N1HkubHQvZB4a1f7yb8sRrNTu1LLNvVox7HVBPz73x6oH5EHVZZp9s2j3vsWhtMFfLckfIok7HucfvL7ituL3sAzsDaPq5OxF48hG7+Pkt/tQ/pNGVjWH41xPqTmpadd6DT5G2vydxNtOUyd4TMN1Ep9nz4Hu8yOZaF99wSC+Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705996553; c=relaxed/simple;
	bh=rMGf+CVc1XpOboA/v5hnPFBLZuvKbP8V2WzhkUVFjJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AdARO2r7tjOHxq1n30/pj+r5WmLhsDf7TQoagiLMkPPJ/96buZBNrFF+epOHkQcPCJmmIiQqDmnMbXPNl1MwTXObx+YhDYwnjvtoGt8mMA6+n8N5GHnpw0mIqoLSvG+lY9/Rx/GjQ+xQ7pVYx3eptJ6H+rUBt6J/yczjS3CM8S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=elGjg72i; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cdeb954640so44384681fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 23:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1705996548; x=1706601348; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TcDZ9mN+FRhUYNa88zGuloBXNab4ChQevtTM4gkLaHM=;
        b=elGjg72idNRYQE6o04kBl6eJWZhk7gMZ3D//pQiiDNlEgeNyCeeKMRipWiHknYd/eA
         bEDgwCKkT0/83ikHRWiUNq2LHrpOhFzqe5AyvqCR/L/HVkuGBLBGd1XMPcQ5vShWxG/K
         6gA17/9szoraGXDG+6qQQ97TgBa/DAhWrkYtoCefjEiS0XSj1N2dDsyySHolukS1l6uE
         XXYwy/K7O6PO99rnlUjK2PnkJfh/gIEHso/OUSXJy2AsECgl54vBA9ge0RAFifNV1Ptl
         wKh9XfosC9cgRJVJBpkbe87hB0CMqc3h/+0OEsepqANi4S5+gI/dSpJMKgvOHebs36vc
         lVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705996548; x=1706601348;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TcDZ9mN+FRhUYNa88zGuloBXNab4ChQevtTM4gkLaHM=;
        b=hOUd/XwgAzpHnaHRC/oi1jwumOgj00KD/T0QrTClJOveM/cFpWKMgbKXwu5TkJ2IDJ
         GULDR2LIZH7IS+yrpxBc3bbV26WZ1vpBBS47g7ZTa0vNM4G5DmQ3DXQ56ZqZwQvOdbSr
         3I017G5mVxovaZ/EYbWWapz7aRNaRaxMMNvoBDe1c/WydPPQSDEC3KxQ9w+fniFpmimn
         +aJQ2hwV2Gr5WmbV4D5uwIs/0snU/CS4qHwXy7Hcot/cqaELqDTvGpR98TGMvBSrxh19
         HScmfYXQjihwx7i9OY/KPwwZgWZN5UPT+TOXzUA8NMHcRT8hZCK0ujqlc1Pj42p9E1qO
         AcUQ==
X-Gm-Message-State: AOJu0YyhxT+Kn7exuu3B33MFQ7XAtI6o2m0/zP7TstOTfB76OPUEybf1
	AVCDwhsfo44Dq2m9z62t27EQo5EZETADnytuHzsN6xfTm0kHgCOO4kXo91Fr5A==
X-Google-Smtp-Source: AGHT+IGOFZkXrAicjcWyVjNqJjubZsBeK8Mb6x8RXvRNYGfYb5g2wOo5JsA3FPRz9L6sUcwYs42zyg==
X-Received: by 2002:a05:651c:b0c:b0:2cf:124b:a2aa with SMTP id b12-20020a05651c0b0c00b002cf124ba2aamr266588ljr.2.1705996548598;
        Mon, 22 Jan 2024 23:55:48 -0800 (PST)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id a8-20020a029408000000b0046edc723291sm1426989jai.78.2024.01.22.23.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 23:55:48 -0800 (PST)
Message-ID: <35ff4947-7863-40da-b0e7-3b84e17c6163@suse.com>
Date: Tue, 23 Jan 2024 08:55:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 80/82] xen-netback: Refactor intentional wrap-around test
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>
Cc: Wei Liu <wei.liu@kernel.org>, Paul Durrant <paul@xen.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 xen-devel@lists.xenproject.org, netdev@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-80-keescook@chromium.org>
From: Jan Beulich <jbeulich@suse.com>
Autocrypt: addr=jbeulich@suse.com; keydata=
 xsDiBFk3nEQRBADAEaSw6zC/EJkiwGPXbWtPxl2xCdSoeepS07jW8UgcHNurfHvUzogEq5xk
 hu507c3BarVjyWCJOylMNR98Yd8VqD9UfmX0Hb8/BrA+Hl6/DB/eqGptrf4BSRwcZQM32aZK
 7Pj2XbGWIUrZrd70x1eAP9QE3P79Y2oLrsCgbZJfEwCgvz9JjGmQqQkRiTVzlZVCJYcyGGsD
 /0tbFCzD2h20ahe8rC1gbb3K3qk+LpBtvjBu1RY9drYk0NymiGbJWZgab6t1jM7sk2vuf0Py
 O9Hf9XBmK0uE9IgMaiCpc32XV9oASz6UJebwkX+zF2jG5I1BfnO9g7KlotcA/v5ClMjgo6Gl
 MDY4HxoSRu3i1cqqSDtVlt+AOVBJBACrZcnHAUSuCXBPy0jOlBhxPqRWv6ND4c9PH1xjQ3NP
 nxJuMBS8rnNg22uyfAgmBKNLpLgAGVRMZGaGoJObGf72s6TeIqKJo/LtggAS9qAUiuKVnygo
 3wjfkS9A3DRO+SpU7JqWdsveeIQyeyEJ/8PTowmSQLakF+3fote9ybzd880fSmFuIEJldWxp
 Y2ggPGpiZXVsaWNoQHN1c2UuY29tPsJgBBMRAgAgBQJZN5xEAhsDBgsJCAcDAgQVAggDBBYC
 AwECHgECF4AACgkQoDSui/t3IH4J+wCfQ5jHdEjCRHj23O/5ttg9r9OIruwAn3103WUITZee
 e7Sbg12UgcQ5lv7SzsFNBFk3nEQQCACCuTjCjFOUdi5Nm244F+78kLghRcin/awv+IrTcIWF
 hUpSs1Y91iQQ7KItirz5uwCPlwejSJDQJLIS+QtJHaXDXeV6NI0Uef1hP20+y8qydDiVkv6l
 IreXjTb7DvksRgJNvCkWtYnlS3mYvQ9NzS9PhyALWbXnH6sIJd2O9lKS1Mrfq+y0IXCP10eS
 FFGg+Av3IQeFatkJAyju0PPthyTqxSI4lZYuJVPknzgaeuJv/2NccrPvmeDg6Coe7ZIeQ8Yj
 t0ARxu2xytAkkLCel1Lz1WLmwLstV30g80nkgZf/wr+/BXJW/oIvRlonUkxv+IbBM3dX2OV8
 AmRv1ySWPTP7AAMFB/9PQK/VtlNUJvg8GXj9ootzrteGfVZVVT4XBJkfwBcpC/XcPzldjv+3
 HYudvpdNK3lLujXeA5fLOH+Z/G9WBc5pFVSMocI71I8bT8lIAzreg0WvkWg5V2WZsUMlnDL9
 mpwIGFhlbM3gfDMs7MPMu8YQRFVdUvtSpaAs8OFfGQ0ia3LGZcjA6Ik2+xcqscEJzNH+qh8V
 m5jjp28yZgaqTaRbg3M/+MTbMpicpZuqF4rnB0AQD12/3BNWDR6bmh+EkYSMcEIpQmBM51qM
 EKYTQGybRCjpnKHGOxG0rfFY1085mBDZCH5Kx0cl0HVJuQKC+dV2ZY5AqjcKwAxpE75MLFkr
 wkkEGBECAAkFAlk3nEQCGwwACgkQoDSui/t3IH7nnwCfcJWUDUFKdCsBH/E5d+0ZnMQi+G0A
 nAuWpQkjM1ASeQwSHEeAWPgskBQL
In-Reply-To: <20240123002814.1396804-80-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23.01.2024 01:27, Kees Cook wrote:
> --- a/drivers/net/xen-netback/hash.c
> +++ b/drivers/net/xen-netback/hash.c
> @@ -345,7 +345,7 @@ u32 xenvif_set_hash_mapping(struct xenvif *vif, u32 gref, u32 len,
>  		.flags = GNTCOPY_source_gref
>  	}};
>  
> -	if ((off + len < off) || (off + len > vif->hash.size) ||
> +	if ((add_would_overflow(off, len)) || (off + len > vif->hash.size) ||

I'm not maintainer of this code, but if I was I would ask that the
excess parentheses be removed, to improve readability.

Jan

