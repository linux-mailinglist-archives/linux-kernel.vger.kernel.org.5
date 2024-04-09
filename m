Return-Path: <linux-kernel+bounces-137587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC9B89E44B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BFCF1F22FD0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0664B15820A;
	Tue,  9 Apr 2024 20:21:54 +0000 (UTC)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE74E8562A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 20:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712694113; cv=none; b=ITZYS/9JaD5whGywYdojCtRNPOqASSEC8TL4bJf+ODXH3XXedexJfyIOvkTRPYl2kAh1zly2LqbVDARn1TVxEBtPxHDIUiGgSAw0v99uW0KXQHMs58KGMvmIBXZfB0uYYXxKabUkBkc2yWfhIv0xHA1Sr6c4XDqIONDE3AHNvwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712694113; c=relaxed/simple;
	bh=z05iIoX6+/nX+l3/VMT0gupT5isshor/+S4xstKqjLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B24FBII9conetRg4x3zcsB2JNv0xjyNG9lti8ZPB55sb1oKA1Zvfku2x0ibtQ59kEzQC6t3QqqoWqe4K2ZZRDJMAPIxfZwkAWSDgXDJDz0H5YhWWZjuXqQkMUAP9SfeB5hxraY+SXnqiUAzjcPM6ylXhU/V+uF5OCgEPF0Ht7Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d874b89081so5702471fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 13:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712694110; x=1713298910;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pEA7dHQgHE1uFqZ9aLUCdxhVQ2BEQSowcQOkzZwh8KQ=;
        b=lqYQ0/Hl9VSABR/jOclSkGdgIPQHtl60WQzfP9u7L+S0gfq8SC8rUaER35gHU8lF+V
         uWFoeu64oA//fXbhEm3x7CuEotI55zdrrLYcTZbUqpLX0nOVnfbtTV5Cgz3+cE3MZR7i
         PzCNMe65W5u8ao23SdA5OwPVYchD5SRw26sr97Qj04ChV5km/Dejy6jnFC1JwSVeGvsi
         P5Gmicxi+rZh7CjgDlhqCaohwHJu+QccGQEqUPH9Ft8/kd+9v9B4ylD6MJoAppkDkzv4
         sGAdkeJmwSUrtMfHO7tmzoFxMJ9Kfd3+M2kWlOxZx7VoSQv7yb8pp3yIhruobKrQf61O
         hXlA==
X-Forwarded-Encrypted: i=1; AJvYcCUU39JWXVK8GBNZdgGgvzUVSdlLQGV+7XcwOF10SzoVUQPdkQDX4sL3s5E1/rQYg11bx6YSOsYbGNGoknM9aktR8BJxCiaAmB1No88j
X-Gm-Message-State: AOJu0Yy+qWi4ywvTppYcg3rbvHRzx6iaBh5sBfehKvuZx7lqRdfqdZLb
	qZ1S/UABG5A01KnpkCcReTdRwIK3t+H3f6762LPlrPtJSEm8Z5y0
X-Google-Smtp-Source: AGHT+IHRCn26vGDmNKTaP3gt7MYF3CGzWIP/8l1UoEUzxQrqmG4j+DpgrF93Vgy/+PJxtO/b5lLdMg==
X-Received: by 2002:a2e:968f:0:b0:2d8:c62:5e20 with SMTP id q15-20020a2e968f000000b002d80c625e20mr519979lji.3.1712694109834;
        Tue, 09 Apr 2024 13:21:49 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id k16-20020a05600c1c9000b004166a8ad81bsm9512177wms.43.2024.04.09.13.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 13:21:49 -0700 (PDT)
Message-ID: <23a5c86c-9f68-4c13-832e-7cf4e6953639@grimberg.me>
Date: Tue, 9 Apr 2024 23:21:48 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] nvme-rdma: short-circuit reconnect retries
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Daniel Wagner <dwagner@suse.de>, James Smart <james.smart@broadcom.com>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
References: <20240409093510.12321-1-dwagner@suse.de>
 <20240409093510.12321-5-dwagner@suse.de> <20240409140054.GC20883@lst.de>
 <ZhVOcGMuBzC3nyMB@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZhVOcGMuBzC3nyMB@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09/04/2024 17:19, Keith Busch wrote:
> On Tue, Apr 09, 2024 at 04:00:54PM +0200, Christoph Hellwig wrote:
>> On Tue, Apr 09, 2024 at 11:35:08AM +0200, Daniel Wagner wrote:
>>> From: Hannes Reinecke <hare@suse.de>
>>>
>>> Returning an nvme status from nvme_rdma_setup_ctrl() indicates that the
>> Shouldn't this an be an a based on my highschool english.  Or does
>> Eeenvme count as a vowel?
> It depends on how you hear it when you read it. If you automatically
> expand the acronym, "Non-Volatile ...", then it should get the "a"
> article.
>
> If you instead try to pronounce "nvme" directly, it sounds like you're
> saying "envy me", like commanding everyone to acknowledge your
> awesomeness. Not sure if they had that in mind when deciding on the
> name, but it's kind of amusing. Anyway, pronounce it that way, it gets
> an "an". :)

:)

