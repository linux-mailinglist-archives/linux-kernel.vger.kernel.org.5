Return-Path: <linux-kernel+bounces-81925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D03E8867C50
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DC501F2577E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE2612C53E;
	Mon, 26 Feb 2024 16:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSoPquMV"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FF8127B4D;
	Mon, 26 Feb 2024 16:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708965874; cv=none; b=SDY5FZEXDwNj2VDU5Nw3wC8PG62FbCEzHyrpIlWjFL2VN3vmUBNa7IBfbNZZa8WCc5tb+gdgg6Z5XKjNJ5PYtP495KK7DrUlfZBSJ40NeAgKAart5YvfQqUhpY45d+rF2aY4Q/z3kF+V80gxhaEBkXfNoSVhaiFL/WY1dMD39dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708965874; c=relaxed/simple;
	bh=aQRyn1lfQR3DVLR+bsWK4QpTHl1fxujUVKb7Wo1fA14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I3WHZjd0KaMFQc+K8PKankWfL3d/8iaXdMthyiNFTd+yaup74F504MaTVJzo7VrmEQOn/MqrHhGVR/JvWfW/Q+r0RJpJbMW+M+F9kgtScFTBjsdPbyU64Tgf/prO0rYgj2K5TsZMm4/zuNra2MNMs2bqaLyQ/bGrR8H9dEUSCSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSoPquMV; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e478057f1aso1530713a34.3;
        Mon, 26 Feb 2024 08:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708965872; x=1709570672; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=zxugb9XdWaRgpdXTMD7tyXbqwf3R1DPNzl5uXjJ5AUc=;
        b=iSoPquMV0kbUue9AH3r+Wt1WL/omy5i+oKVV9HG6otuaDCInrCDZoz994iFQwHx6k0
         J6n4zN17mh3Eo1KuKSeOsy+laf9XY1+WDra/CEOH5gv5NUL7J/P3Wj0ffKjKADiHAygo
         Fn5oMN3c4bzs361KygvUTDo8KL9TQxgN6/XW+0ObP/rebKrEr8cTzgY1UB8nhUMweMfI
         7lwwCMSWAovNsFu/jPeVm4QGefNoJMNZiLjqMDpWv6xw/qpm/LO+aEX5XBbskD8+CMVs
         G+VCdupZYYuv6SIexuy7sMrYYt5zbvwi4GjeoV6tEKb7Mac+I80yULRIpjQ8xbVMQNqY
         rGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708965872; x=1709570672;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zxugb9XdWaRgpdXTMD7tyXbqwf3R1DPNzl5uXjJ5AUc=;
        b=prvDsJHH5fHgW/gP5TfIHANj/XLKu36EaUepbsaWMXs7y04olY1/9CnMzMTKKE/RPg
         KaJHNRGeUHpLDeG/XxFSSHZjjYtcrmdNzqPQwwHmFylcjglMdxTLVO6va1hTkfQ1aR4s
         kQKVzyxXBJpjzZsl/NGdHpFsRBOQCftnuEWM+CQenYouQz+i68QguwdAZ/OjUycNdfN8
         hyNSKSrgHPoks95PxPPoD02z770enQtAIql5aVZLzs+F9fbhKGr89nCgcTaE/WSQr3+p
         Uw1CPpLECTO8MMFixRprP8nrIQ1JDq0hWgNnsDc/Q+dX5scxB7Tp5e1dv8NkOdZ9mc/k
         X7OA==
X-Forwarded-Encrypted: i=1; AJvYcCXmhNZYur/Ae8OpXd82K9RAVdbP7qK5LjPF5Oz8kg5tfWRPg/NTKPJFmd7BP/a+loHXeZt4ZcQPF+txQTA080Z3kKkc1cDbVEAc8UT7
X-Gm-Message-State: AOJu0YxFqmn+lXaRUehnm/E9UVrmbG5llBmHs3K+wwBnuZw5qCtwSTyv
	cvduex3Gs55QWQQ1tZObFQqgZ4BkmzDYe0ZBWpsPEeYY7wzRiVB/
X-Google-Smtp-Source: AGHT+IG9x3hOE7qQugH6Z5nF3bOMJG5ivIFBA1dICvHrAcej/rtVq6js66yU3lhPGDq4nYWE5XZE7A==
X-Received: by 2002:a05:6358:281d:b0:17b:5b6d:ffa3 with SMTP id k29-20020a056358281d00b0017b5b6dffa3mr9522055rwb.5.1708965871968;
        Mon, 26 Feb 2024 08:44:31 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bv193-20020a632eca000000b005dc4da2121fsm4044441pgb.6.2024.02.26.08.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 08:44:31 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e11fea7a-e99e-4539-a489-0aa145ee65f0@roeck-us.net>
Date: Mon, 26 Feb 2024 08:44:29 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Content-Language: en-US
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Charlie Jenkins <charlie@rivosinc.com>,
 David Laight <David.Laight@aculab.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Morton <akpm@linux-foundation.org>, Helge Deller <deller@gmx.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Parisc List <linux-parisc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Palmer Dabbelt <palmer@rivosinc.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Russell King <linux@armlinux.org.uk>
References: <20240223-fix_sparse_errors_checksum_tests-v10-1-b6a45914b7d8@rivosinc.com>
 <7ae930a7-3b10-4470-94ee-89cb650b3349@csgroup.eu>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <7ae930a7-3b10-4470-94ee-89cb650b3349@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/26/24 03:34, Christophe Leroy wrote:
> 
> 
> Le 23/02/2024 à 23:11, Charlie Jenkins a écrit :
>> The test cases for ip_fast_csum and csum_ipv6_magic were not properly
>> aligning the IP header, which were causing failures on architectures
>> that do not support misaligned accesses like some ARM platforms. To
>> solve this, align the data along (14 + NET_IP_ALIGN) bytes which is the
>> standard alignment of an IP header and must be supported by the
>> architecture.
> 
> I'm still wondering what we are really trying to fix here.
> 
> All other tests are explicitely testing that it works with any alignment.
> 
> Shouldn't ip_fast_csum() and csum_ipv6_magic() work for any alignment as
> well ? I would expect it, I see no comment in arm code which explicits
> that assumption around those functions.
> 
> Isn't the problem only the following line, because csum_offset is
> unaligned ?
> 
> csum = *(__wsum *)(random_buf + i + csum_offset);
> 
> Otherwise, if there really is an alignment issue for the IPv6 source or
> destination address, isn't it enough to perform a 32 bits alignment ?
> 

It isn't just arm.

Question should be what alignments the functions are supposed to be able
to handle, not what they are optimized for. If byte and/or half word alignments
are expected to be supported, there is still architecture code which would
have to be fixed. Unaligned accesses are known to fail on hppa64/parisc64
and on sh4, for example. If unaligned accesses are expected to be handled,
it would probably make sense to add a separate test case, though, to clarify
that the test fails due to alignment issues, not due to input parameters.

Thanks,
Guenter


