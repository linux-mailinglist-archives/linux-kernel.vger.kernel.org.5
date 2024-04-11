Return-Path: <linux-kernel+bounces-140274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F02978A116D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6983A1F280AA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEFB146D47;
	Thu, 11 Apr 2024 10:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUPod8+r"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8041664CC0;
	Thu, 11 Apr 2024 10:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712832234; cv=none; b=oDK5/IHfUaHXw3nv6Q2jHy+azmR1RJ9rTugeC1sxIMuTZc7b68woLsNGcKEzrjJejlx2q1Sgmr82m2ptiwguyPAVHs5gWM0iePrahyLWcRujPB77OS5WF+xuMWgcBxUN8mba83P9rQoqdl7SptGf6fDbyJ6e+2u3l2scXHklIuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712832234; c=relaxed/simple;
	bh=sF1QdEzB4+79Ul3csFZ7HCaZU7ZqVllCaS9cSmm1YRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MyXjO9kACWBRDD/e8HkldH55oGrf6+yxnv2bnMyMBVoZfIvOsfL2pifVbADHvZZqAlQWZf2nrOGgh5PfDo5rOTKFV0FIZ209anbLqkHNojRNwYE9/tAuFWdoA2qbCiSC/62+vFFFDORHLxP9ssSu9sI58TpDWjIMMW6QiepCvXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUPod8+r; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-417d029bee7so5102905e9.1;
        Thu, 11 Apr 2024 03:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712832231; x=1713437031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lZnfyjtIT3oMZRJBF5vD8DE1B6KGKzMNst0HGwqZHrY=;
        b=cUPod8+ruEDTQ7q+NwU3FgU87/E6tqxJGEaOZRPvI/IApCBKNdINUHueDx4394WA9t
         WAdYKfMYZtt9+4qAS5Bt5AgGb51ARHC8SleCkuEGzxFdUKW9dY51n8YnSDS018OTgfOp
         NoNbsb0Em/Bg0ZvEmuWXZL5Sul+x9gJ28YvEtcfFjvUO6IEtgphirNb9/sMQzk6kZLv7
         gWKxAdzn8NqvB9Bqe0qYgHC+MO15poAU9lxKSJgW9RjeGR8w+EIDM/oDFf7A/3uNQlJv
         u82IEkqmnT9WqLD7caMeFyNGqrdlTm7jsoogZ8KIf7z5cMbo+c81AK34uTnuw64MwAy+
         59jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712832231; x=1713437031;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lZnfyjtIT3oMZRJBF5vD8DE1B6KGKzMNst0HGwqZHrY=;
        b=kiE5hzBe65l+ZndNk6EGOPPnMBDHFSlXBARtypb11fsaiLGgsRJGKYywzA7G4CA1Pn
         QJOnVvrtRDZnjhOOQLQCbH+y/6TmNsMn3kieb1v29t2si1Ey88x2RJM7emFcJYIn1szP
         sbhZB+ULt0npIIo4k6zcmYoSNDmkYBOrpYf6ifEUQTN/dw83rapk/KdtOBcG9AE2oEtu
         l7d9ARgkAP1AM0FtZFXoMoxmUZwkoESPTEblo8IAroFiE4Zyd/VR/Lx+mn5BfBsaFZSM
         hp5aTvyj1CA2aBzU6Z5PLqXQ1qZrnWWmBAGP67bKC9mxu/PfohTPZ3S8ZvQxxs/QveYb
         qzgg==
X-Forwarded-Encrypted: i=1; AJvYcCW+ADnEkqTDTTZjDyGtAgR6QkbE7oFktScAzhiAc3Ymo6zrkj02n5M1jq+iKXFf9dh9okkj6MndcLwxLzdyhZ+iI66WAw08VlXNc/Rc71Tuoj1MGAIVMSqBjbVQl140G0vbogoe8hVymvL6HMhsRp+VbRXIBPH+PshHjeTDQsPdZgkTZuko
X-Gm-Message-State: AOJu0YyARpCSbZ/SoH4joX4yf+NF9dUTFHnNZ2jhbB/2FNUvs9wbLVGm
	BGSYxrlKAlK5pLqCArpQUXDEx7TxDncCLJdjEJBA6tDKWsBcIkjQ
X-Google-Smtp-Source: AGHT+IGN2GMFqd9FOV0kra1xu4P5IN/AfV9m1iCLs3mIOn4B1HgTRjbh1WA09kLOCmvFxVKFpmmvQw==
X-Received: by 2002:a05:600c:4ec8:b0:417:d624:d009 with SMTP id g8-20020a05600c4ec800b00417d624d009mr1056093wmq.5.1712832230565;
        Thu, 11 Apr 2024 03:43:50 -0700 (PDT)
Received: from [192.168.0.101] (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.googlemail.com with ESMTPSA id g16-20020a05600c311000b00417e31724c3sm706829wmo.13.2024.04.11.03.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 03:43:50 -0700 (PDT)
Message-ID: <3011ca26-08d4-4b4e-847e-d68c0751f98d@gmail.com>
Date: Thu, 11 Apr 2024 11:43:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] tipc: remove redundant assignment to ret, simplify
 code
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Tung Quang Nguyen <tung.q.nguyen@dektech.com.au>
Cc: Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "tipc-discussion@lists.sourceforge.net"
 <tipc-discussion@lists.sourceforge.net>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240411091704.306752-1-colin.i.king@gmail.com>
 <AS4PR05MB96479D9B6F9EC765371AA8A588052@AS4PR05MB9647.eurprd05.prod.outlook.com>
 <ce0a63fc-1985-4e25-a08b-c0045ae095f4@moroto.mountain>
Content-Language: en-US
From: "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <ce0a63fc-1985-4e25-a08b-c0045ae095f4@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/04/2024 11:31, Dan Carpenter wrote:
> On Thu, Apr 11, 2024 at 10:04:10AM +0000, Tung Quang Nguyen wrote:
>>>
>> I suggest that err variable should be completely removed. Could you
>> please also do the same thing for this code ?
>> "
>> ...
>> err = skb_handler(skb, cb, tsk);
>> if (err) {
> 
> If we write the code as:
> 
> 	if (some_function(parameters)) {
> 
> then at first that looks like a boolean.  People probably think the
> function returns true/false.  But if we leave it as-is:
> 
> 	err = some_function(parameters);
> 	if (err) {
> 
> Then that looks like error handling.
> 
> So it's better and more readable to leave it as-is.
> 
> regards,
> dan carpenter

I concur with Dan's comments.

Colin

