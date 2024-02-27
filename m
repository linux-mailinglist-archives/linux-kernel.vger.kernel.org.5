Return-Path: <linux-kernel+bounces-83977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD9A86A0DB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CAF41F241D1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC6B14C5B6;
	Tue, 27 Feb 2024 20:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GytqlouE"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FBA134B1;
	Tue, 27 Feb 2024 20:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709065902; cv=none; b=MC22VCC9TTspw4bA9VunJeusAdbfK0/ifjcOcLHLY1wc/xc1W4hggmpUiacQ0qsq54z+PwtXv+8UzBo+w4QKKZgffuGOrRPpSW4M82puX6WdhYpTrkJb2KWGNVm5sB7DJtyJeMqGsGR7ciYlXeC/pHiaz2Rsf4oUWv35hdFCzzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709065902; c=relaxed/simple;
	bh=G6yKE1THFhG6N9U45yHLmmavHahr/jJrUURUvgErM9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G/VK+9Y+OBDUHrNtp0GDuFv8ezifVsEuVqC5tkMMgW6cDNCW73kAWbOAKLIEo0mavIWeS44g6ND13EHeQpDH0cFb11JpNq0DWSuQJbzSAWpAHtIjy3jLY7CHBs9BC3dd69SE+incilzKwzLysjnx7VyoCQo4Um2wdLP/tpB8JKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GytqlouE; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e43ee3f6fbso4310880b3a.3;
        Tue, 27 Feb 2024 12:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709065900; x=1709670700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=sSYRDIf7PMa1i1v/+zGirvQOYT4gXK0xwaNIYHe2l1Y=;
        b=GytqlouEGtTbwT2E6z23MY5QWCQdyPguAv8dW4CueNq/plxCR3IrwXYscjmg3NfuXJ
         lYwTnej2XYMbzJskTWKW64A56fMkdvATElt5JP4ewMB0bI0LSNnzIuaQ7bFtAHbakjqw
         crF7tUxLw9rSrp2E6VZvGJ92VxldJac8ZHp1JAu7IUnBW9KPUh92jfCAjOWERM+0tfeU
         tE01t0vD4xVivVK/2nD9tk7ZOxM5LDOus1TiCxOZuncQIjZkANuHwFuDJ5RWVBLvOoKX
         q7/0RgXviGRNaLs2rK4w+Fp2a/HpgCYSJ6t7tn8goMbQbFYfZuWnG0BB/OHbT3M/+Ln9
         b91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709065900; x=1709670700;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sSYRDIf7PMa1i1v/+zGirvQOYT4gXK0xwaNIYHe2l1Y=;
        b=FIgy1tEAYzkTJjXxXj3qLLS/Ug7Xo/N+rx0h4X8gQFSetKgfzI6kzpzUiB2POxaEqj
         pF4PaHzTGDg8FOrPTQB7sZsD6bHweunDSGQ5EGmEWYbHagVtk6bJiY3Q9eWW+dtj4DzH
         vdxsMzcGIpWECp4PyxDeA5/1VpwpyXNckvqAnGQR1dvzOEJy5iUSz6MQgdiKST+w99q3
         YyRXWUIC2hEXqQMEIpkB/nAyscsZIc8Y4SvU4xZSGqlfhEz88hVdB9S6ijr6Vcmiq56y
         DBkY3DGKmzDgTv7qyVzLWTW2BbLpmwmeYAs9O1rJTfK4QlOdyep/x3pGj4ZqjpCfxXSH
         RT2w==
X-Forwarded-Encrypted: i=1; AJvYcCVhdopmgXowkyDHJCAm30Qw08ad9HlkBJCaNR54qmkQeyN3TCVeAas+2a5uy97HxmzzuoNWQLNI2A1dzAt12uf1rh7Z4QT9EEBQFiyVznVnoM1znfTLqP4J7cTC/AGU8/+ooJOQ/ZFNGR2V
X-Gm-Message-State: AOJu0YyvXxdpFJcQXlBlX9QoLBRLUzLEYkgJGy6uaPLJWOzm72MGRYaN
	z/dJH3vOm+7cWn1NhaS8n9Q2DGHWfyNvkEVtEStIg79dm2aOALgdEA+HTKa/
X-Google-Smtp-Source: AGHT+IFVo5BdTY83PWZQqEM8jO+608zjzUgiArqwCj+UrJUJgZzWDN0DmgiI1GEgAAAMDRmR4GIHMA==
X-Received: by 2002:a05:6a21:1799:b0:1a0:ef1e:a658 with SMTP id nx25-20020a056a21179900b001a0ef1ea658mr3592183pzb.11.1709065900169;
        Tue, 27 Feb 2024 12:31:40 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u19-20020a631413000000b005dc89957e06sm6219112pgl.71.2024.02.27.12.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 12:31:39 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <faa17d09-15de-48e5-ad25-c43a69d0df49@roeck-us.net>
Date: Tue, 27 Feb 2024 12:31:38 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] parisc: More csum_ipv6_magic fixes
Content-Language: en-US
To: Helge Deller <deller@gmx.de>
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 Charlie Jenkins <charlie@rivosinc.com>, linux-parisc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240227185334.2697324-1-linux@roeck-us.net>
 <d1a6fe49-19f9-433e-b275-209b59155193@gmx.de>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <d1a6fe49-19f9-433e-b275-209b59155193@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/27/24 12:14, Helge Deller wrote:
> On 2/27/24 19:53, Guenter Roeck wrote:
>> IPv6 checksum tests with unaligned addresses resulted in unexpected
>> failures.
>>
>> Expected expected == csum_result, but
>>      expected == 46591 (0xb5ff)
>>      csum_result == 46381 (0xb52d)
>> with alignment offset 1
>>
>> Oddly enough, the problem disappeared after adding test code into
>> the beginning of csum_ipv6_magic().
>>
>> As it turns out, the 'sum' parameter of csum_ipv6_magic() is declared as
>> __wsum, which is a 32-bit variable type. However, it is treated as 64-bit
>> variable in the assembler code.
> 
> Nice catch!
> That kind of bugs is actually the reason why I start to prefer
> C-code over inline assembly, even if C might perform slower.
> 
> I've applied that patch to the parisc git tree, but do you think
> you can come up with a better patch title, e.g.
> "strip upper 32bits of sum in csum_ipv6_magic()" ?
> 

Sure. My initial fix was way more complicated, and I didn't update
the description after I figured out what was actually going on and
found the simpler fix. I'll resend.

Thanks,
Guenter


