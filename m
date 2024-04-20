Return-Path: <linux-kernel+bounces-152328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A228ABC73
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 18:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E99551C2111B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 16:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF758262A8;
	Sat, 20 Apr 2024 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvhU0K0i"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0225F7F;
	Sat, 20 Apr 2024 16:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713631430; cv=none; b=dQRyp2lp4Q/Iyow54yKkiVuqfZuB/OQoJuXf0Rl5yIL5EyLMHDBs0YidSYb2WCrLbx1l2fz9Uz3zu4Crzu+Y+xBsbgTRmPe100X44s0CKkeRxJzFBtEskwx2+hCMwJ67127uiXku72AiWXcZg4kYyI3A3RIf9vC2iH6RUoxmF9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713631430; c=relaxed/simple;
	bh=RVzFOdid7vonSEiYoTYTKg19n8GyJlUWp7TjiCFOFoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KdYBWIlhUZ1TlMTSzFn+Ov+kPIigrFtrVrlp3ThlV202/L1i0Djv/eGDFPnnkxge3hr/OraCYFNS994cmdHJXJ3/ojizQWcmHCdTbqUNyfZ5YKUS4SoGU8ln1UfSLPvz9uVY+NjsWZkxFBoSkafrRVITiPnn8P98uEAu+EBFSiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvhU0K0i; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6edc61d0ff6so3062291b3a.2;
        Sat, 20 Apr 2024 09:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713631428; x=1714236228; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kvYdXMP13MGyiW1mVJY4N9cxjffCsKZfWU34WoKhsJ0=;
        b=AvhU0K0iuIU28o5lkGDLzB9Ul0mTiXQSd9PNJoOA8kZPnlOhYr0hnLGxUt52T2BIo1
         t0zhI8Zl1p3GvZ/nhyw3eCSPcwjuVkgSNZz3qVIM/c7e6JFTQd5CtTeTAzlvXNzV2V25
         kraodc3hYwLyqxMrbvciS5ecw5M3afsVqnMnWcenCCWuj9QN/JByiNCmNdDb4bcsOd7b
         cUe3w7O8k3XIDvz31cPqPOb/nweDERQQgZVYbmfuIgFqAQ2AY0Ix3okwxUWnr36oHif9
         3VIKQM3IisTqA/Em5FCaXxqmA+24sJaOaKRMrvttXLlFcJUJPbHPutub8qXIPO6lDwtr
         w73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713631428; x=1714236228;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kvYdXMP13MGyiW1mVJY4N9cxjffCsKZfWU34WoKhsJ0=;
        b=tHtu/WefQwPA4DDGOcnQNgd8gJ/gGHwCdqndd1ICofd0yPwog3R1QbkITt/VGaSFLy
         qpfJfmsaSsL9ynQZNpdau80ePpaNLfhmAQ9F1VmUGSEfX1vqj7pyDpmlryxP9k5Aj/mx
         LnxyHclmCuNImdCA3gzcWa8cCDYTe7OjP9A7KMYElGXlK3Z+KJ5mDC1z0FhvG36o5roh
         sKISogpmWg0SraZWc1opnnXAndL3W1eCed9cuiTnlGF49OTbh9H4vXrD7ItUtEQnuwM2
         9U4MY/rc6TFfsrX9y1BDgkgChSkFeYsrtYXZHe9ZmVwbEXMz0ylAQ9cmiZrb0fbAMNtX
         agkg==
X-Forwarded-Encrypted: i=1; AJvYcCWWtFFOYkSeEdCfi4sUti0gxMPIWfp8f/ZAQhaVEU1y3hhrq8JDh6AMNHBvVQRAFSXb/OLiOMZBS2T2NNoxoDmkUA97aTif/0Ke1caN
X-Gm-Message-State: AOJu0Yx2uwIMP/XOPjhrr2i6D7IabfdLf+ke/c8qp6IKq5qwh+UFF53x
	eEsuqWhg1gqvWtqcM3jFF9pluM7qBGLTwexmHXCo6HK5DeceV2m1
X-Google-Smtp-Source: AGHT+IEBSLyjv69VE+HU94ZPJbY/HZQ5H2D4QeogLPtoXMThpPB3ay6ErZ8nDJzzbB0kDbsjK2SxEA==
X-Received: by 2002:a05:6a00:2e8f:b0:6ea:86f2:24fb with SMTP id fd15-20020a056a002e8f00b006ea86f224fbmr8138625pfb.25.1713631428164;
        Sat, 20 Apr 2024 09:43:48 -0700 (PDT)
Received: from ?IPV6:2402:e280:214c:86:2549:4e11:d9ed:4a8a? ([2402:e280:214c:86:2549:4e11:d9ed:4a8a])
        by smtp.gmail.com with ESMTPSA id p5-20020a634f45000000b005f05c88c149sm4939930pgl.71.2024.04.20.09.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Apr 2024 09:43:47 -0700 (PDT)
Message-ID: <7123a3b3-687a-4e8b-a59c-d3475c2a784f@gmail.com>
Date: Sat, 20 Apr 2024 22:13:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] remove identation for common path
To: Randy Dunlap <rdunlap@infradead.org>, heikki.krogerus@linux.intel.com,
 gregkh@linuxfoundation.org, neil.armstrong@linaro.org,
 dmitry.baryshkov@linaro.org, u.kleine-koenig@pengutronix.de,
 christophe.jaillet@wanadoo.fr
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com
References: <20240420145522.15018-1-prosunofficial@gmail.com>
 <98f301b5-0161-467a-be2f-d2554a2265a1@gmail.com>
 <04af9ead-8ef6-477e-98ad-c458e72f3108@infradead.org>
Content-Language: en-US
From: sundar <prosunofficial@gmail.com>
In-Reply-To: <04af9ead-8ef6-477e-98ad-c458e72f3108@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/04/24 21:53, Randy Dunlap wrote:
> 
> 
> On 4/20/24 7:59 AM, sundar.R wrote:
>> On 20/04/24 20:25, sundar wrote:
>>> Added check if pointer is null and removed identation for common path
> 
> In Subject and the line above, spell "indentation".
> 
Thanks for pointing it out. will fix the typo error.
And send the updated version.

Thanks,
Sundar

