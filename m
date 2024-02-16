Return-Path: <linux-kernel+bounces-69179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2D4858571
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A6EB1F22054
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717431353E2;
	Fri, 16 Feb 2024 18:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUJFcnwO"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9061DFC1;
	Fri, 16 Feb 2024 18:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708108916; cv=none; b=pICBqRhaLznZxiLzf16hLy5mHCQn4lbFkEnze0zvEjjdH9KOwHjQ/i8tPgf9ZLVhTAf6KX7v2CjKhdwHx4CW3GqeR1mD8zGRD9YabG4SVbGUcHq5upd7u7W/iFUZuP5xsNInmJwVcR8RbBABUTdhguZ2PKn/uNo2En2ap0YuG9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708108916; c=relaxed/simple;
	bh=Zf7/xKVUtC3FLAgXvdomOnhF/wHgDc9OrVC5WgqEjok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KERtv4b3Srza5iI2Srv+Bu2tU7Bw8lkIeiOG18eMBKs2kQ2qwVagsgnvPcIY12BH+O65OMjeFgiNoR8BsBHCUuocX/1TkEjzG3ny937FeGsKlB3ATA59A/2ffmY2xQp51kgUZI0QFSJg+pqeD3qJoO8fcJAk2HVdD64YkuiynNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUJFcnwO; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1da0cd9c0e5so26474155ad.0;
        Fri, 16 Feb 2024 10:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708108915; x=1708713715; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XjQgdkE/jPZ++9MXgFHn+9XTMWAWyikiws9QFHGLfSA=;
        b=OUJFcnwO7S8RziH7/smI+f+R9/72Y3b7o2rggjFsmd0AhJus6bjUyrjAVFQweUn1QX
         C0s//Pc0V1F/BfUINMBTU/65s/fX4LoYamY6wW+Z1gUfh7/g27P7lFQ1XWTUrWkbsRYP
         oE8YqlcT4yBXa0hRREWjvgHTukr+jhUGaSSb4txk6bI/obWDGaGpznyvL6FADRHRHUAs
         2NOQaqlzWybI83gBK/Qj+tUvHbL1s42HCG7c+uw0HgxatSEvCiRtGoml+yJgXYcW9joa
         R7h4SZlmJ2q0TdgcGa5hQfbW7KMtjCLbb8NgPhNVqH7oYD2Oc15Ukp/2yrCtL5H+Z3L/
         B4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708108915; x=1708713715;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XjQgdkE/jPZ++9MXgFHn+9XTMWAWyikiws9QFHGLfSA=;
        b=o5sAc2uVYeemQeyxmkKmy0rs1bCeEEgvaXE7sTrTeCzJcGh7Edk7e+ZAy74wGhjbuj
         LgCl0e0jVPiK5WVyOaIgUcpEt8MttzT6gree4rEkPJdXE5xYfgq47nwQ/DNHNdIN2ACK
         7pycr4H6F2xMh1ow1yzVMewBHi/ctAy9PCJ9CnCbRHzg3Dx7VJYGzm44/ADd0lmY7K1h
         l8amLaaobHc2IRD4NZdfcvHPTqb5uantmoEQS8euP9B498zHTjyR4GPPy1I6ptgEO6+L
         iFbZSsaozUPbePQ2TQfeawAvc8wnDLMHLPetIIgBDu84z4wqmOF6quBMwVTm00UylS2e
         J+Fw==
X-Forwarded-Encrypted: i=1; AJvYcCVN7LPj+G0GI1e0BrypeDQOGLAgaGDJ/wCBtb4t6mg+xi7zgBqlBXOR3lWPmj8nkW9f/6eEehzZAet65VU3f7pxbusJy1s1xLJ+2jzOG78dT3ItmGHG4WN9Guem72W/QprYP7un
X-Gm-Message-State: AOJu0YyxsnRhJ2pMcWhMOsrcE4bOZROpyMOCxcw5vUnwzpRTuppnE/So
	xJqUo6Z/d8amrVGI4FjFfGzamNBr5n8ZXC6Z+06KgQ/+a4IbwXx2
X-Google-Smtp-Source: AGHT+IHdMFXim/u4KxeWeVJTCZ0KkraNd/DjUzriSD2xX/sF7NRPdtUWtrNXgTS3sajSEZupo6LydQ==
X-Received: by 2002:a17:902:ce8e:b0:1da:1fe7:cacf with SMTP id f14-20020a170902ce8e00b001da1fe7cacfmr9406297plg.25.1708108914685;
        Fri, 16 Feb 2024 10:41:54 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id jw6-20020a170903278600b001d9620dd3fdsm173858plb.206.2024.02.16.10.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 10:41:54 -0800 (PST)
Message-ID: <0e0ba573-1ae0-4a4b-8286-fdbc8dbe7639@gmail.com>
Date: Fri, 16 Feb 2024 10:41:52 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: sysfs: Do not create sysfs for non BQL
 device
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>,
 Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 horms@kernel.org, Johannes Berg <johannes.berg@intel.com>
References: <20240216094154.3263843-1-leitao@debian.org>
 <20240216092905.4e2d3c7c@hermes.local>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240216092905.4e2d3c7c@hermes.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/16/24 09:29, Stephen Hemminger wrote:
> On Fri, 16 Feb 2024 01:41:52 -0800
> Breno Leitao <leitao@debian.org> wrote:
> 
>> +static bool netdev_uses_bql(const struct net_device *dev)
>> +{
>> +	if (dev->features & NETIF_F_LLTX ||
>> +	    dev->priv_flags & IFF_NO_QUEUE)
>> +		return false;
>> +
>> +	return IS_ENABLED(CONFIG_BQL);
>> +}
> 
> Various compilers will warn about missing parens in that expression.
> It is valid but mixing & and || can be bug trap.
> 
> 	if ((dev->features & NETIF_F_LLTX) || (dev->priv_flags & IFF_NO_QUEUE))
> 		return false;
> 
> Not all drivers will be using bql, it requires driver to have that code.
> So really it means driver could be using BQL.
> Not sure if there is a way to find out if driver has the required BQL bits.

There is not a feature flag to be keying off if that is what you are 
after, you would need to audit the drivers and see whether they make 
calls to netdev_tx_sent_queue(), netdev_tx_reset_queue(), 
netdev_tx_completed_queue().

I suppose you might be able to programmatically extract that information 
by looking at whether a given driver object file has a reference to 
dql_{reset,avail,completed} or do that at the source level, whichever is 
easier.
-- 
Florian


