Return-Path: <linux-kernel+bounces-132586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C6E8996E1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5205C289750
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A554013DDB1;
	Fri,  5 Apr 2024 07:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQmioRG7"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A5D12D20D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 07:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712303224; cv=none; b=CyLGgA8KDLZjrcn7Anz4CWwir8J56zkecxHivEq8wDs4A54Ot05YyBOqO4bs656BmidxgdNpn/wYln0batFZiiyMe0lNeq1DNaYj0S14Gmhm0wG+AnYBUiJoDEeF8aES+WFZjOgqj2G8DU0EDhK7f5XfKujw8XqtLn7GPDB3qYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712303224; c=relaxed/simple;
	bh=sAja2W8tdOD+sRzkzExkWlXBX/F6AdCmTbElyysLym4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iEWlnbMPoL2548cqeL+x0RH19fU7MZ+VOdbixbrZFGk7uAFPHMMDwVZbSXaDmsLPZ05w6EU7w/srka8ZKa3yapKgN8NzBMrd3veQ6zGsQyI7pDx+W22B778A1fVb4Orzh1E+5JYzP4wdkuw0Ht5KqajwnDb7zVtjCwReH7PULJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQmioRG7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4162b7f18b6so9595895e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 00:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712303221; x=1712908021; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7++/ztIz/hTa+TXzbNPpItS8PqkiLz9qd/xmbL8Ftrk=;
        b=KQmioRG7KkUTiQ+SHOD1OkFfoUdBREICXLkp7bBcEXFq/89TZkj9/OUjP5Hb+M+ceO
         n/IY7fvYOcBhgQF0ybdfGP1CGyEgb4eTXLHjjVB/aCTIXi8z+rEkCqINu5z66tVD9sRo
         yqrzgQW2wzuDOOHwCFvt8kL8po45fBjfMiqjJ3GjI3bdYzuZQQ+njH5cwavVvHZbN3Id
         V7fFy4SJMrCT2KOTRFJQwCygJrYpCMI9yPTJnqRJ1H+H9GzaaPNGPocoTlxjtIJitJma
         OHLGJx25I9aenEpL3E+nsIFisg91MeBdcCqngg9M2zbMfHsGQ99f1xn4Ze67X8aBmQKt
         6N7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712303221; x=1712908021;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7++/ztIz/hTa+TXzbNPpItS8PqkiLz9qd/xmbL8Ftrk=;
        b=wcladdo/fl1/4zNovr15PjCX3Izhul8STYXXG3OiParcyVBwBPAfpdGYdYyty3dtrR
         xiMS2Wk9JbaCLyDpWjhOKYiIvYux2iQuwhVXMrkE1uVGuU+t1xOCbdCayJ66g6kg2lA6
         1GBM50M9IJcad3HUiIgKDy+uB6wRUOXFNvOsHj6M/PsC0Nd9fTwZFFzjGBn8sKSgg7o+
         In0W9sgWDO/pSYKFMAvRhIYqIBY24NnE9m43/Xr/yeCECNCnYOzHRBVoTRYt3/BW6JFo
         xKjhxnscjsB5hY4ZQhrb9U6FaTmdV55ve4xUT2GXZw0urClR2kYld74njWmmK7Bfmfa0
         Z2Aw==
X-Forwarded-Encrypted: i=1; AJvYcCW9FqCe3a2cr+S40tqtuM9cbPK/GMSWNCREsnzaiaciZOg/dI3p3HaZEfuGCSRZyhJDD8RHfx58eGlpUYik1ea8hkTZKD3ufnEYHPZd
X-Gm-Message-State: AOJu0Yy5H6ldXz1oBcr8T433qU1C1u4g8jeniXyUTQqVfkfEqdm2ITWh
	C+W5+iBExe5u44HI2M6rSHTVWhGx1f/Q7nfgl+R0Sf+r8TBNzfD9
X-Google-Smtp-Source: AGHT+IHRcg5+bHJr5XkLLgn2JhotFiPzweqk1f09U8ddNLz1uFizxoTin3HUZbfFFfVwAXnXlpztCA==
X-Received: by 2002:a05:600c:19d1:b0:412:dcab:7c79 with SMTP id u17-20020a05600c19d100b00412dcab7c79mr530879wmq.10.1712303221502;
        Fri, 05 Apr 2024 00:47:01 -0700 (PDT)
Received: from ?IPV6:2a06:c701:737b:ef00:2bdf:f41a:ebd1:fb2c? ([2a06:c701:737b:ef00:2bdf:f41a:ebd1:fb2c])
        by smtp.gmail.com with ESMTPSA id v9-20020a05600c470900b0041568e91c41sm5440953wmo.41.2024.04.05.00.47.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 00:47:01 -0700 (PDT)
Message-ID: <9f9d1d2b-dd8c-4325-abb4-4933d7e709ce@gmail.com>
Date: Fri, 5 Apr 2024 10:46:58 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] staging: pi433: Remove duplicated code using the
 "goto" error recovery scheme.
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: gregkh@linuxfoundation.org, hverkuil-cisco@xs4all.nl,
 andriy.shevchenko@linux.intel.com, robh@kernel.org, felixkimbu1@gmail.com,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240402111414.871089-1-ikobh7@gmail.com>
 <20240402111414.871089-6-ikobh7@gmail.com>
 <068f3705-9f9b-4d61-be50-a131b9598703@moroto.mountain>
Content-Language: en-US
From: Shahar Avidar <ikobh7@gmail.com>
In-Reply-To: <068f3705-9f9b-4d61-be50-a131b9598703@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/04/2024 19:46, Dan Carpenter wrote:
> On Tue, Apr 02, 2024 at 02:14:13PM +0300, Shahar Avidar wrote:
>> pi433_init had "unregister_chrdev" called twice.
>> Remove it using goto statements.
>>
>> Signed-off-by: Shahar Avidar <ikobh7@gmail.com>
> 
> Your commit message needs to mention all the other changes you made,
> especially the bug fix.  I feel like you're doing too many changes
> really.  Just use the gotos to clean up but don't re-order the calls.
Thanks again for your inputs.
I've reverted some of the changes & split the 5th patch.

> 
> You need to add a Fixes tag.
> I've added the "Fixes" tag, so as the "Reported-by" tag, naming you.

>> ---
>> v2->v1:
>> Followed by Dan Carpenter's <dan.carpenter@linaro.org> comments:
>>          - Remove empty "fail" goto tag.
>>          - Reorder pi433 init & exit calls so they have reverse order.
> 
> Keep the init calls the same.  Re-order the exit calls.  It's a bit of
> a gray area if you can re-order the exit calls in this same patch.  Do
> it in a separate patch just to be safe.
> 
>>          - Add "unreg_spi_drv" goto tag.
>>          - Check "debugfs_create_dir" return value.
> 
> No.  This is wrong.  Debugfs function are not supposed to be checked.
> https://staticthinking.wordpress.com/2023/07/24/debugfs-functions-are-not-supposed-to-be-checked >
Great blog post again. I'm learning.

>>          - Update "if" statments for consistency.
> 
> I like this cleanup, but it's not worth the effort.  Just leave it
> as-is unless you really really need to change it.  Do it in a separate
> patch.
Reverted.

> 
> What qualifies as One Thing Per Patch is a bit of gray area.  Greg tends
> to want things split up into tiny patches.  You have to know your
> maintainer.
> 
> regards,
> dan carpenter
> 
-- 
Regards,

Shahar


