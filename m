Return-Path: <linux-kernel+bounces-46408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 014BC843F45
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86F8CB24E02
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD5078689;
	Wed, 31 Jan 2024 12:15:50 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B9F78669;
	Wed, 31 Jan 2024 12:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706703350; cv=none; b=Zw4CodwtEf3IrSeBVw76fsJjITxBscpXEeeE1pbfLVzmpZx+bH18dHuX5N+vpwLs60tRovOnZ0gsKy2W/r5WpzjgQ7fscYFcPcRobdA3wsrcYizichVnOVvzqBkrN95iLgbXgBO2f9rYE9NOSoSgvkxSGXVdDylrgsS+1zzXghI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706703350; c=relaxed/simple;
	bh=SCHvPf3JLIZ9T+a9jN4lmw6RHsyl9KyxaDHaABOqbQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jNQ0EN+q5CwsFX5hSHyJYLxNRO7N7HK02UlzvL8bbQ3+wYHDWbVJjpzl/x0b61SgyTXMTPS+bnWGL94mEcOYpm4koWhbQvdMiahpZBTBooYN+vdFBhIzRDPAIrzxnwLo7E/qjbJHv+eqzfGPIPYHARXNw15nMOc+01RMpZpg0Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40ee9e21f89so44453755e9.0;
        Wed, 31 Jan 2024 04:15:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706703347; x=1707308147;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x5QFTfLTaaaGrayqRozxrGYixRwFTqwWEY912YrsFIc=;
        b=MCRCYateA+0UZKhfVGr9f5GvsVXdrNhHZfUbh2tlFErdbrQ6HRvun5kQXmNv6fN9kX
         kXyQ0gmcx4e9DXFaU8Q7gEsyjZ1QajEwzJ4pFT92UBMMZB3Uox06efNXbQ8Q1nsuMunQ
         IiEu7lD7iT3RVAkpjDTwZt3YaXVrmriPmN/z+I9G4fLSNcK2EfV9ogrnzgoyMD5shmCr
         syOC3rzf6EG1mKPpty+jivdsu7jdRKtsrXoSj4IfVIYBriqv3Mkm0pBxqbHbuQhFvoNg
         SwqonLihxETCp7T6mTyYXTHw+egv2ls7tJ+tx+r+f2e7txRYE2E0U7y715d3dRwngRtH
         UI0A==
X-Gm-Message-State: AOJu0YxhiIp+PuEK8rWAWKd1m7jckXQFbM98DytPWI9kGzea0urWnK8r
	VVxUNY72HJkWptKrkvSJcq0JVVlBs40xdF1ruJTWCRVUl32tTkK2
X-Google-Smtp-Source: AGHT+IG2Cg6c+Hd8QOpiF9pcsGT4UzDUclCsGnV6czpSw3yP+Nwvl1W9VwySHo45kJpDZLAjK24LKg==
X-Received: by 2002:a5d:69ce:0:b0:33a:ed5a:5a14 with SMTP id s14-20020a5d69ce000000b0033aed5a5a14mr958145wrw.22.1706703346724;
        Wed, 31 Jan 2024 04:15:46 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id k7-20020a5d6e87000000b0033addeabd6fsm12647036wrz.18.2024.01.31.04.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 04:15:46 -0800 (PST)
Message-ID: <80b84147-e27d-4110-843f-700e738b50ad@kernel.org>
Date: Wed, 31 Jan 2024 13:15:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mxs-auart broken in v6.2 and onwards
Content-Language: en-US
To: Emil Kronborg <emil.kronborg@protonmail.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <miwgbnvy3hjpnricubg76ytpn7xoceehwahupy25bubbduu23s@om2lptpa26xw>
 <040064c5-c285-4e02-b545-47c5085f0068@kernel.org>
 <djtgk274iojly23xjb6kgx7ucgv6a4d23ix4vvr2cfskrkeb2r@uykelfkgrcg7>
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <djtgk274iojly23xjb6kgx7ucgv6a4d23ix4vvr2cfskrkeb2r@uykelfkgrcg7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30. 01. 24, 19:57, Emil Kronborg wrote:
> Hi,
> 
> On Tue, Jan 30, 2024 at 10:38 +0100, Jiri Slaby wrote:
>> Hm, the tx stop handling is weird throughout mxs. What about the
>> attached patch?
> 
> It seems to fix the issue, but I do not see any way to fix this just for
> mxs-auart.c without also changing serial_core.h, and thus affecting a
> bunch of other drivers.

Hi, the fix I sent to you does not affect any other driver. (Even when 
it touches serial_core.h.)

> Would reverting the changes from 2d141e683e9a
> ("tty: serial: use uart_port_tx() helper") for just mxs-auart.c be okay?

Nope.

> If so, I can do that, test it again, and send a patch.

I've sent proper patches to fix the issue. If you can retest, please add 
your Tested-by line in there.

thanks,
-- 
js
suse labs


