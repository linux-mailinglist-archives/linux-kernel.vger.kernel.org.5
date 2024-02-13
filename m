Return-Path: <linux-kernel+bounces-63446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCB9852FA7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2271F1F24EAF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18C539AE9;
	Tue, 13 Feb 2024 11:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POUtl1+C"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BE336AF0;
	Tue, 13 Feb 2024 11:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707824243; cv=none; b=IrAGGs0NbDASwQDPXnzSjO9rczG2V5i9gAFDhDPrNeG8exEKJ0Smr4kVK3cP4nECaQuR2gu5kE28fuIYEG/jPoIQXFIzoxiUqpBpOHn9F6xNdMXnvCDMvB88t+7h244rcY8MEdjLR90XmqhKswPRM47sgONXMYMPY40naklpFj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707824243; c=relaxed/simple;
	bh=kKQR8HXeMmDSy4PT6Nj6UWeXvxIX7kGT9uCHNeDoFuc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iDzs8ikF1HxiMuW3IWZb6rO+F8gH2AY3BhhIq8EalQFVEv3u1miVfmxv7iJxWdoxZANhLkLkxDvZuhJiEoXGuQUnWdW+tjAFDp0Ey+FTFLek+UrRhq8I4SafUGdSsyLxmdiWS43w1RqKcQn5jaHk4+4rt4RSex5QbxPv97I1JkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POUtl1+C; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-411a5a86078so8996385e9.2;
        Tue, 13 Feb 2024 03:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707824240; x=1708429040; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sQis1qvp/U8auXJAKP/yrBgCFkOt5KYyAk393lVPOdY=;
        b=POUtl1+C7ANH/0iRKU5dGspbAPaYwvAmL33wcTSy6meO31NCy8m2sSPtmzqb6xzPbb
         zgxrPtvvtu1QUuVNZCVcmYMCh2aTVSKgeBWtsJ9ETamao173SfAcSxa+Gl9EgtS8mC0L
         XFQPyAmpbaIksIDb4d/L8okC7RSV4pccPEYfLvVj0Y/yi6n03EmgDvFZxwLfXn3T/3jA
         ene4PR1i6nThJI6YK4ePDgZ5wm+UIPzDoc84RQu+jRrGFkLksLBZqnIQjaiQLHo684Uy
         8P8TLnrLMunWl/XLoX2h2OzonH/bs5COD4TKO11B3UnO+UztfhzWEbbFe9ag9JzkGHLX
         zizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707824240; x=1708429040;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQis1qvp/U8auXJAKP/yrBgCFkOt5KYyAk393lVPOdY=;
        b=nZKB0OZacTQJFHRWs7Wb1wW3koGy/4277Eikkhvk4YVFmgflskPsCc7y0dl5N1OhXp
         AC/gdN12wreit/XQyC3y/TuZLFmROIEZiCbItoKyFxy3t2cw52JpuUfssiBzKT/FinWQ
         txRdn/PcpFkSzw9J4CpvErcWMJkRzdeuhlf9vNoPgdp6NrnMfkAghk/rnYCxHf/MZFBI
         Sa9tIARXgh2gtaRR5rwol6CImfqm2cA6kCosS7ggpy6YXuq7ODEOjliGnVqTDJpKjdd6
         MK845McPcUq8VcYN5/0TYiadDtWrtXhaxoiVN8WFaM3Koxn/V+YABco3R8+5qL8ihedx
         r08w==
X-Forwarded-Encrypted: i=1; AJvYcCVtjx8Z0HlZtl0zVSGnIlf2I0sFxZO12wLCYYzn5WzzQinUAbcrjOEm+ISORj/yic2BEzIzB8sW+pgUGFSPq3UGQxXP270CS+Zj+z2Y
X-Gm-Message-State: AOJu0Yyu/mI/Z1OBIEyvaviV6Pq/n620zOa43aQW1lvsTL5INRGntBiJ
	xGZGTWf7MBRDrigc/yzyJt/nkRqw8UXz8VI+yHTU9wHHXVOiAzRY
X-Google-Smtp-Source: AGHT+IFK4Uezp+NtfTRO82kWqc1JFIQYUrKoKWoO8VA6xRW8Sfp6GwechICHtRD/UhF7cWc5l61FwQ==
X-Received: by 2002:a5d:4a04:0:b0:33b:615a:19b7 with SMTP id m4-20020a5d4a04000000b0033b615a19b7mr6889589wrq.22.1707824239404;
        Tue, 13 Feb 2024 03:37:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWYwXCX5Zan6qTGfNR6oFZZAnPtvBVbtDkgy46zuE6MWtOG79IXS1Xg9FMxBxaQ7ljLpjj5Ino1dZ5cTTXXzuRaRgAqN7nfmWbWCawfFsjD3OnIU+f1iKFB4NLJPwLZTuCKBi/Hl5A05/yKAyo/xndTcJhSqOrYindSC8FpLWr0mabO7E0cefKm8+Q9hCr0UdrUP3Any7Pb3YlzFxBMjLm5k9P7Slfu3WToV5gVxzRogu1S//5oFy3GHJRaTUp1wuhbbl0XSif73wXn1ehw4DLDyiU7eRD1jXG34FMDTzKKUw==
Received: from [192.168.8.23] (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id p16-20020adfcc90000000b0033b2497fdaesm9276695wrj.95.2024.02.13.03.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 03:37:19 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <fb3fb0b0-c11e-49a8-9a28-f3d3bb0fb6ee@xen.org>
Date: Tue, 13 Feb 2024 11:37:06 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: paul@xen.org
Subject: Re: [PATCH net 1/7] net: fill in MODULE_DESCRIPTION()s for
 xen-netback
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, Wei Liu <wei.liu@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 "moderated list:XEN NETWORK BACKEND DRIVER" <xen-devel@lists.xenproject.org>
References: <20240213112122.404045-1-leitao@debian.org>
 <20240213112122.404045-2-leitao@debian.org>
Organization: Xen Project
In-Reply-To: <20240213112122.404045-2-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/02/2024 11:21, Breno Leitao wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to the Xen backend network module.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>   drivers/net/xen-netback/netback.c | 1 +
>   1 file changed, 1 insertion(+)
> 

Acked-by: Paul Durrant <paul@xen.org>

> diff --git a/drivers/net/xen-netback/netback.c b/drivers/net/xen-netback/netback.c
> index fab361a250d6..ef76850d9bcd 100644
> --- a/drivers/net/xen-netback/netback.c
> +++ b/drivers/net/xen-netback/netback.c
> @@ -1778,5 +1778,6 @@ static void __exit netback_fini(void)
>   }
>   module_exit(netback_fini);
>   
> +MODULE_DESCRIPTION("Xen backend network device module");
>   MODULE_LICENSE("Dual BSD/GPL");
>   MODULE_ALIAS("xen-backend:vif");


