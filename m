Return-Path: <linux-kernel+bounces-163616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 635EB8B6DB0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 949B61C2248F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55848127B64;
	Tue, 30 Apr 2024 09:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OoY7dubq"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A293A29A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714467822; cv=none; b=j7VtgA1PpDkcd4CqYKA8OkDKF7NazI+yppubY0VVi+/XhDW+OCwXnp1qpqQdssCKF4JXdRjKVkActfgP7WQVSYUYiQa7FzI5MA4NWT7yJ7KDfbg+f1/pxLjUaGfizYmc88P5ivoRoznlTOTAbhmD7s64C+pX7WOu6DAxEPp9PVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714467822; c=relaxed/simple;
	bh=3RgL84FOPHnRoABg8ARjy4GFMRNu9jyw4ulWXT0PlBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PwWr3zIBaog0/zgL04MwbInrPjjkfQIv9cdMJcu8qD0e6EjRJ+HXft1apUi6O4uyb7PTpHA8V4UHAWHcp2GyiD9dyujp1K8llaokAWWEIpxYYOXxgbr5Vr2DgJ4Awe/QG+tK6fFfla/vBd+Zv6A05J9LeGOwhZWS1M1/lE/b00w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OoY7dubq; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41b9dff6be8so27613095e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 02:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714467819; x=1715072619; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oMdIUTb8z2zsRNFkxCts+jZrF/FgbKs7WeVds8L8Wu8=;
        b=OoY7dubq0UX4u4opqxkbPWerdTccCfPy/oeUYyZ73bo2JyYo0YeATy01lWIkxB36qK
         wpiWGfKZc3lp77L2Eg2Sy2OnLDKK7kGnhcWJGOMlkPBMy+uMMNREtcld9Gq8h8zWofRE
         KsT7sCujSyC0nGnh3F9GD5WWTrXZmjMWsP+ePMe79kWuDcnB4eQiqzsrm3GV0bDnXUnE
         xkZWafoEpGQqEMywg7ygAJSqpEE7aZw7PAbFK2IEbVgtMC+X6aOB8iTZsHEV0rlU13pB
         O44DZYNwvcz1hAsAgqnIFTKe4e1CkS+RNqbUH86ZCfvihn01BxWBJ6GI66M8sIdm3gkp
         UdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714467819; x=1715072619;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMdIUTb8z2zsRNFkxCts+jZrF/FgbKs7WeVds8L8Wu8=;
        b=cg5pdRJvCDEgv82JGJgAH+QIlBZlrU242+V1Y3e+XZiGBReT7y/tgWNsWB3y7cegZ6
         /F3FiwX4ahc7dpD75Hn62u37+U1pDkvlwqwsgFunHjuAAnTtAcHirr3A87owWgp8joiO
         zESp8J9Gst3bY5GJaPfYJu0iUpqrAk5j0CRDi43sgBsNnE1l3djEFQXgK8rgRiFu7lTe
         URn0ibGn38DcjljQ5zVdkBjDiwMUJzZCfnCodGFXnwpLu7tRy11Xm8CQL3TirXvKy+Hb
         A6MKH5LCnzNZYTYfMyOXUnDRnXHTCo+QKbCP8fxubZ1zY6NLkT/rM5fLzxnw01o6tlqi
         mwkg==
X-Gm-Message-State: AOJu0YxTYKpzjc7KgWKQp3/EnhSUtj1+CgrAsyNJXNRXAhCCSlFMclza
	1t4k9iQUpMPcU0Xh+CUg0UAAp47g8Gj9gYW+ZSllctpgitGYcJaDuBpvj4Rhbn2b7veYtqRK8mZ
	1
X-Google-Smtp-Source: AGHT+IGfypXDGFYGRXnM/tjLph5dq4eqWb8RRnGSUfZJuUuvwbWyZXVGb0eqv2BLQjaxwjUJjcfvPw==
X-Received: by 2002:a05:600c:4f56:b0:419:f2a0:138e with SMTP id m22-20020a05600c4f5600b00419f2a0138emr9506014wmq.34.1714467819317;
        Tue, 30 Apr 2024 02:03:39 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id r10-20020a05600c458a00b0041bf512f85bsm10454652wmo.14.2024.04.30.02.03.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 02:03:38 -0700 (PDT)
Message-ID: <a987385c-d241-4527-acd5-31767c62317f@linaro.org>
Date: Tue, 30 Apr 2024 10:03:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] slimbus: patches for v6.10
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
References: <20240430085007.33607-1-srinivas.kandagatla@linaro.org>
 <2024043013-foil-pucker-4c7b@gregkh>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <2024043013-foil-pucker-4c7b@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 30/04/2024 09:56, Greg KH wrote:
> On Tue, Apr 30, 2024 at 09:50:03AM +0100, srinivas.kandagatla@linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> Here are few patches in slimbus for 6.10 that includes
>> - fixing autoloading.
>> - coverting driver remove to return void
>> - some timeout fixes on wait operation.
>>
>> Please note that, I have also included a fix at the start of this series
>> rather than sending another email thread. I hope that is okay with you.
>>
>> Can you please queue them up for 6.10
> 
> Shouldn't the first commit go to 6.9?  If so, why include it here?

Yes, first commit should go to 6.9, Do you want me to resend the series 
without that patch or are you okay to pick it this time?

I sent the fix with this series because it was just one patch, and we 
are almost near to rc7.


thanks for your help.

-srini
> 
> thanks,
> 
> greg k-h

