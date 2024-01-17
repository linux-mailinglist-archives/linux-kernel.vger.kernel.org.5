Return-Path: <linux-kernel+bounces-29068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAADF8307D1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 953B8282543
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C088B210ED;
	Wed, 17 Jan 2024 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FfACNuUR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A18A210E6
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 14:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705500943; cv=none; b=NCTI+7F83xCkMWiudB1WZM9E6tNVV4OxA/aEyH74nx8JAwfXmoUNr7nHFO8QerzPd3vLKIRKHWYuClCfevwvFsMeNIPK/tjNxXdKgluE+rqYgb/SRni6G5c52J24/t5vXRqk4HcbuL+HcD3doX8NmDYxpb7yqpAov3j0RtKFH/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705500943; c=relaxed/simple;
	bh=j8SVQYElp3DIy4MCNlTIDmWKXaPYLtJlocZAT7UlUn8=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:Autocrypt:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=Rb9hYRjvtO2j+ChPx3ubZbrUcnqGUj1s2/lOhiERXmHphoXHnKTGEEHgHyZ7d+Kru5NkpoBUfWuxvh33D7E5iyDf8uojVPPCJq11+ranuOoVmWuY05zC2uptk619moiOxanqavSQFT9NhdEzgsdaMm22f4PdXW1cLd6f8NZfO8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FfACNuUR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705500941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NLEm9WfM2DVRRgM1uRSj01N/k52OujYb4SOVH5GrqWA=;
	b=FfACNuURxAGSF6E7UhLhtUHvaQoGkZPtyLXWaNZGtkei3NRnXO0+jJP6yMIVWjeP7fXaNl
	ADCPeGVroLlHZCKsUv3O77HPRhRYYVoSYmzZOp/7+W7yOwUb6XOEWppTTBXab5doR+gBKm
	/z720jLeI+8I2Ztk9urxKQf5etO11Cg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-96fHAsGMPVayHMfX4XoeZw-1; Wed, 17 Jan 2024 09:15:39 -0500
X-MC-Unique: 96fHAsGMPVayHMfX4XoeZw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40e6f3c5730so31715135e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 06:15:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705500938; x=1706105738;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLEm9WfM2DVRRgM1uRSj01N/k52OujYb4SOVH5GrqWA=;
        b=Q0BNpqBFEzeumLuvB5OM/W9xSDdVscwkjsW1IJhQI+Y9Haf7OLwk7u+4QpOad+H8vZ
         KG6Gyswb5xzkF1yPEPXRZpgk1UHOINA+jlQoTwDRsg6hBouMDog9B2vsO44A2+Dyu/5l
         3KCeyj1k2fH5TuUwgQI+HBnleizHaaAFSUpURj/BEZP1p0Am3RDbmuzTfpkb02BOqrlu
         Ds7wOYNGETKH9XYTGaAnoU+axBQu7pDL9n/OuZCdPNZxb4awLrxZX9U0JZr7CPJNXyQM
         UUybZ83DRXLB86HifYKNDVQAjz6Fa24c19seWHKnMbKoKjiljW3dfc6qnNoispYtVKck
         3bPQ==
X-Gm-Message-State: AOJu0YwNcdqedyZNBmM9rrr69CmMdjR24C9EEKNNglvyuLVnesE8QoUU
	P/w6M5AoKVts5p5rvDdsGMeMuIZ6AfWDjEOU6gPWxXc/IK2KJCASkq6eRVKRHEMFNG0+hG0+0BO
	ekm1IKc0OIartxz0YC/f5jRCHxpz+hVUi
X-Received: by 2002:a05:600c:21da:b0:40e:490f:a5c2 with SMTP id x26-20020a05600c21da00b0040e490fa5c2mr3372250wmj.31.1705500938486;
        Wed, 17 Jan 2024 06:15:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1T/ZoS/zZDYOa/MhhrPH+4XjSsuZLdvSzfI32yPU+TSOGwyiNFKnz1CeDpKNQgleCJqCYLA==
X-Received: by 2002:a05:600c:21da:b0:40e:490f:a5c2 with SMTP id x26-20020a05600c21da00b0040e490fa5c2mr3372243wmj.31.1705500938067;
        Wed, 17 Jan 2024 06:15:38 -0800 (PST)
Received: from ?IPV6:2003:cb:c70b:b700:5a87:3a7a:c28d:2cff? (p200300cbc70bb7005a873a7ac28d2cff.dip0.t-ipconnect.de. [2003:cb:c70b:b700:5a87:3a7a:c28d:2cff])
        by smtp.gmail.com with ESMTPSA id i17-20020a05600c355100b0040d5f466deesm22505101wmq.38.2024.01.17.06.15.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 06:15:37 -0800 (PST)
Message-ID: <97843013-7e06-449c-8418-3890657b2e26@redhat.com>
Date: Wed, 17 Jan 2024 15:15:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Debug: mm: meminfo reports 222GiB of AnonPages but sum of RSS in
 ps is barely 400MiB
Content-Language: en-US
To: Karim Manaouil <kmanaouil.dev@gmail.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
References: <CA+uifjNcZbb6=9-o9_cWCMyXRFZPHhyvWS2mys-YhfP9gaJ75w@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CA+uifjNcZbb6=9-o9_cWCMyXRFZPHhyvWS2mys-YhfP9gaJ75w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.01.24 12:39, Karim Manaouil wrote:
> Hi,
> 
> My system says that 231GiB is used out of 251GiB, but when I try to find the
> processes using this memory in htop or ps, I find nothing. In fact, the sum
> of RSS memory across all processes listed in ps (both user and kernel process)
> is barely 400MiB.

Hi,

which kernel are you running? Which debug options are enabled in the config?

> 
> A look at Meminfo shows that 222GiB of memory is AnonPages.
> With the help of `numastat -m`, it is inactive anonymous, more precisely.
> 
> I am really baffled and I have no idea who is using my memory?!!
> 

If it would only be "used", I would have suspected PCP lists. But if the 
memory shows up as AnonPages in /proc/meminfo, that memory should 
actually still be mapped into some MM.

> Here is what `free -h` is reporting.
> 
> karim@luna:~/mem_debug$ free -h
>                total        used        free      shared  buff/cache   available
> Mem:           251Gi       231Gi       1.1Gi        52Mi        21Gi        20Gi
> Swap:          119Gi        75Gi        43Gi
> 
> And this is meminfo:
> 
> karim@luna:~/mem_debug$ grep AnonPages /proc/meminfo
> AnonPages:      222998596 kB

IIRC, the last one to drop mm->mm_users will call exit_mmap(), which 
will unmap all pages (making AnonPages go down) and free the memory 
(making used memory go down).

Maybe we have something call mmget(mm) but never mmput(mm)? Are you 
running any OOT drivers or "special" hw?

-- 
Cheers,

David / dhildenb


