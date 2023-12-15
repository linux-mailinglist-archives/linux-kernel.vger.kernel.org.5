Return-Path: <linux-kernel+bounces-842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A56578146F5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B787284913
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35B9250F9;
	Fri, 15 Dec 2023 11:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k2iOuIBf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C235C250FB
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 11:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40c3ceded81so5397065e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 03:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702639865; x=1703244665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rEy69qZmW3XqlCDv6jBLXXrKhWeJJEX+g6s1R+76Tfs=;
        b=k2iOuIBf7I5u/UkgRowru8U4irsxWwyiZ2zx348sggXpHGHYD/YGY+pXCe/t6jgfx2
         sYKuXW4/aVoDC55JksGQqI29EjQuyrpxxQpjGAzLHUbQ5PLUzzBrU/+yP7VDcZGJaD/n
         x3wxAod1hXT0niQ4Hh78ymiKJnvk8T5GySNhRo268CgfLgtZLDzjlct/uWgGPuuDU7PE
         FEAKnKAX/5V+5Q4LwsPm5/n85GuOhKK1vvl1u39C9BQb+TGA4UB6l7YGLyC9d1aG3PQB
         urDByBoqmRNWQGKvOdZTgjQlcwEc1bston6gNjcHm/oAuWPQV1Q1WkzGxHjyV3r6N9Cv
         wNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702639865; x=1703244665;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rEy69qZmW3XqlCDv6jBLXXrKhWeJJEX+g6s1R+76Tfs=;
        b=hDfITei0Y6YqgPpb2Y/74/lB5TCRGaK645RZIpwANQh0N+KVQyuhAJZ9bgbhfehmaQ
         GhwM0kO+uOUYFRUKVbN0Vfs0yCVrwNPBanrUua5lT+4oB9Hv5Q6l7np+QRPsSBbqeTRs
         8HSf0P8j3thJl99JPron7Y4XXLYxJi3WFeJfLYwHEBJF/N7G0V9eemGIpvsqZppOBMKd
         TB3/l8BIHa45zr6bg89CrM9Nap2Vw4/7Cg4KnhErOoGvdG3bnwjdpYEVQ2dSpd7x1nUr
         b+Mwdz87uSvz1x4NpRV2Z7UEua7CMJahjhC60ykbkefsJSDMlbmPTk04HOvr7Oc8xEKj
         LnSQ==
X-Gm-Message-State: AOJu0Yw+VHQjkTdALnNhPXN3xvODeNLKYTwWL23cnzzroArXSZ6AY/SU
	YkEWPhiwwlxXGEOviUGbz4ah4Jj5fg0nIhJGdUg=
X-Google-Smtp-Source: AGHT+IHtnwNRPkgGywj/lGcutwu9LSEZvn4Mw8FsA0QjxkJ9CRwSZJAB8r1jANp+rD9H0mn+EVM2HA==
X-Received: by 2002:a05:600c:501e:b0:40b:5e21:ec0d with SMTP id n30-20020a05600c501e00b0040b5e21ec0dmr6076582wmr.63.1702639864812;
        Fri, 15 Dec 2023 03:31:04 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id g13-20020a056000118d00b003333d46a9e8sm18545096wrx.56.2023.12.15.03.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 03:31:04 -0800 (PST)
Message-ID: <68f3f085-16a2-4065-ab72-c6ef22a47e6c@linaro.org>
Date: Fri, 15 Dec 2023 11:31:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] nvmem: fixes for 6.7
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
References: <20231215111358.316727-1-srinivas.kandagatla@linaro.org>
 <2023121517-dwindle-feminism-1c7e@gregkh>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <2023121517-dwindle-feminism-1c7e@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/12/2023 11:26, Greg KH wrote:
> On Fri, Dec 15, 2023 at 11:13:56AM +0000, srinivas.kandagatla@linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> Hi Greg,
>>
>> Here are two fixes in nvmem for 6.7, if its not too late could you queue
>> these for next possible rc.
>>
>> Thanks,
>> Srini
>>
>> MIME-Version: 1.0
>> Content-Type: text/plain; charset=UTF-8
>> Content-Transfer-Encoding: 8bit
>>
>> *** BLURB HERE ***
> 

Forgot to delete this.

> No blurb?

   ____  _     _    _ _____  ____
  |  _ \| |   | |  | |  __ \|  _ \
  | |_) | |   | |  | | |__) | |_) |
  |  _ <| |   | |  | |  _  /|  _ <
  | |_) | |___| |__| | | \ \| |_) |
  |____/|______\____/|_|  \_\____/

:-)


--srini

