Return-Path: <linux-kernel+bounces-9808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FAF81CBB2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0DFBB2233E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C069A23747;
	Fri, 22 Dec 2023 15:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZL59rTyJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5FF23745
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40c41b43e1eso23237385e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 07:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703257423; x=1703862223; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AKSO9lLlrTdc5RcHnsdSDuaWJoa08Ko0rq0BxR4nKbI=;
        b=ZL59rTyJNs7DZWr2y91c/xBDledKfVPi3/f3hT1HH5GIxkyC/aAXsLgcQ0ZAAcNse1
         9wBkv7QoCfHgiXIliw7aHSYOMWYY8Az2yX0X0f6OgYa3TNx33jMewp6q8+cmDneaaPgz
         pCQ4yRGTKNysYQzK7XhcEgl9CYWSwvs1mmfisw56OXoYfhnum4IrbolY4cSLGjtZJ1vI
         Bj1EU0QBxg5qrtPTE7d/yNFISQd94gTUrEyySDRKj2tDk15T+/gfOsA2hUgahMx9dR6o
         Jfg+zXo0/lRi2ytOXEY+DP79piMz+oTyF7ktBbDU+34v3cThRmlyJLWWRW/0CfjdS7no
         YD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703257423; x=1703862223;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AKSO9lLlrTdc5RcHnsdSDuaWJoa08Ko0rq0BxR4nKbI=;
        b=WahtDCgmh8qI8H8VWppjT+s/Gfb3PyGtGekWDqKSjO+G0brzaSehNdpULfvum7o8Eq
         AZwo7IOO78humxM4AzJnLQ+3YOCMupi+LvoSgOzLT9ndmm6BRDrekuATiMlZ2mcSqZH3
         qbpUMF8KnEH2iOuvXwrL235JEQShVQEJj/4wDcDLTfqhDXCK8yy4ctP96ABMkJkGGamt
         pQeSfDTczqJ3VFxWlBd6i5PmhEIuKlbie4WvAEwpvaI9PcOL8jatXMAQk282G2TkNu1T
         fvvv67Hcf0s/T1FqO1XfvK1NoNfqtOHycckXJs/DuTr0qGn0E+Cu2WftAYnF6BQlwLWW
         IIPQ==
X-Gm-Message-State: AOJu0YyMbmJoxLSmjm60uWC0gEArrW+99UKdI/GcfNmXruqwGF7/abns
	JkN2vHiyd2rAWQju6Pqe5FWaTHW2JEzNMtpBSq5UBZuvLXE=
X-Google-Smtp-Source: AGHT+IHJv8OdUbI0uP+i86A10eBAYsPX+MtsX79WZHiqADGH/0kRZBJTJuGkWterpzgLWuO2QPaZPQ==
X-Received: by 2002:a05:600c:4453:b0:40d:2921:2a5d with SMTP id v19-20020a05600c445300b0040d29212a5dmr777818wmn.211.1703257422837;
        Fri, 22 Dec 2023 07:03:42 -0800 (PST)
Received: from [192.168.10.46] ([78.240.110.132])
        by smtp.googlemail.com with ESMTPSA id b2-20020a5d4b82000000b003367ff4aadasm4479292wrt.31.2023.12.22.07.03.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Dec 2023 07:03:42 -0800 (PST)
Message-ID: <fa8628c7-f49a-4226-b26e-ada31316b130@linaro.org>
Date: Fri, 22 Dec 2023 16:03:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] thermal/debugfs: Add thermal cooling device
 debugfs information
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: rjw@rjwysocki.net, lukasz.luba@arm.com, rui.zhang@intel.com,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20231219092539.3655172-1-daniel.lezcano@linaro.org>
 <CAJZ5v0j+F2uLauRqGZ1nvX3CsoA3+JXyzXFp5VtzvVTQTg6Yvw@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0j+F2uLauRqGZ1nvX3CsoA3+JXyzXFp5VtzvVTQTg6Yvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/12/2023 18:19, Rafael J. Wysocki wrote:

[ ... ]

>> +struct cdev_value {
> 
> I'm not sure about the name here.  I would rather call it cdev_record,
> because it consists of two items, the id and the value.
> 
>> +       struct list_head node;
>> +       int id;
>> +       u64 value;
> 
> This is kind of a union, but sort of in disguise.
> 
> Why not make it a union proper, that is
> 
> struct cdev_record {
>          struct list_head node;
>          int id;
>          union {
>                  krime_t residency; /* for duration records */
>                  u64 count; /* for occurrences records */
>          } data;
> };
> 
> which then would result in a bit cleaner code in some places below, if
> I'm not mistaken?

Can we stick to

struct cdev_record {
          struct list_head node;
          int id;
          union {
                  u64 residency_ms;  <----- ?
                  u64 count;
          };
};

?

The usage of the ktime_t will have a more important impact in the code.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


