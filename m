Return-Path: <linux-kernel+bounces-134318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7435089B043
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 12:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD72EB21520
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A013317984;
	Sun,  7 Apr 2024 10:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpseAZlt"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5A828F7;
	Sun,  7 Apr 2024 10:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712484055; cv=none; b=bIwFDwstudFWql5P7d6ivdmM5ZUAZoaDblfLzLWVThOZqLXmXZDYjjQFK0gjfg7eeMnYV5VhpDUTIur28KwADJr8Y3v6hAijUEM6FA6Yc9IUfZ+Ugmn/CAtVppz5Dvm4FKAHrOPOPLNFb3GbL4uZC02pBh8SFlgG2T4ijjGU9Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712484055; c=relaxed/simple;
	bh=ByMEChKTSywVRP1Ji7rY2dbnqTmlvm/cGcZyZedWd8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tioHbTLIj0RaUh8dU/8SjeNxfBmHV9GkQJxg+lp0Wto1HEuS7Lxmqb0q8qGUdLsZSvV7Bmt+6voCnqfu/eqPzXa/VBQ4acCJnTKc1WCD6Qg4HCcc6hDNoHYz2eVOmyIkbDJEZrXjSWdCCpM6Zyc7uQjreYI8E8dGU2ej13nsKd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OpseAZlt; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a46f056c29eso116089566b.1;
        Sun, 07 Apr 2024 03:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712484052; x=1713088852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3pHjvq8glgmeFWgr/CWtk5Kt0WHetidx4d5rVwt2tD4=;
        b=OpseAZltKJvf684TTUEQBLMS3yCe6bTYCSmDD4vubY5kZ/RdYFIBXIXX32+AW0zw2Q
         UbappVLPCZDn2qo58x4k1oDA5I//mGRAY3nsIHZf6eHN5QM7kmslfj245CEVonhZKsBk
         9ITJIc4uLZkFmO6Be/Dy/bzBqTk7/EbEvzRNWu+11SmaToEzQfgiqOkWDomugvbqhVBq
         SeDmIpglmoxOmyBg8NpwJEvRvwAJPX6IUJmBgbnn+zD+DH5OXW3s/WAM87XH4onpKlYX
         SEik4Nqx5woHZOb1uvCSgzbNI8T0JZF2YPFI3Xas2V7R8ubxMH5agnO4Lzrtc1H9DQPD
         cCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712484052; x=1713088852;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pHjvq8glgmeFWgr/CWtk5Kt0WHetidx4d5rVwt2tD4=;
        b=BJwuFo6HNz3QiHdRVi+ADo1z/MvOQ1672hUq/4v24Vt+jDv7Y8eoyBPXltXXtKa6nv
         mVdOJF64/NV89jWYHeAoX7mw5Bqdo9CTGIwROQbjzDYO2iCOERBa+FxSk5nmv+5ElGQz
         /u40XcyIbNVQ3uuKS9barrwyG3vtZwTNVKZ2ZxiNf1NPD9deTk899iAjPcqJnQe04n5s
         6GAQLrbqhzU7E/qeC3AjPU3B+Txr4zhxhBjSCrsEBoq+8pQTs3P8m+7b+TY2HxqOSUQ3
         pZ2QSR/2mS8KKONV2X9HdRmio9OQB5pgkK3aXf5nc6x12VkoqqgX7QtnDs8ja28a+MeK
         Btsw==
X-Forwarded-Encrypted: i=1; AJvYcCV0HBzdA49oEwRoGgd+Yp4ldRWV8Pqyh/DHU8A+Xrzy19cngpNojXUkwDBQDbpgyM8iv0RHEtNqBnSiMQrUxLIk+9Bjrbb/G6wY2/8eJ7HA0wuSWG19IZNFc2drgMebTG1qoDim
X-Gm-Message-State: AOJu0YzXK4BkOj28CgLujYBUYLHoMx1FyR+KG3fyUQCbxa4wVfOZxk52
	PUp0K+EMM9rduQ+vKWHiJYoN2xznV4BIOWqSPiH4kyRYkmjKVV3B
X-Google-Smtp-Source: AGHT+IHxSE3qi+b9pADBsgPhGzUxnyktMjqDToDuQFNKVCkzx8DxNqQOx2lc8neK8nG2J7zeZGSaVg==
X-Received: by 2002:a17:907:72c2:b0:a4e:4ed4:5efb with SMTP id du2-20020a17090772c200b00a4e4ed45efbmr5026080ejc.3.1712484052496;
        Sun, 07 Apr 2024 03:00:52 -0700 (PDT)
Received: from [192.168.1.2] ([91.86.182.228])
        by smtp.gmail.com with ESMTPSA id dm14-20020a170907948e00b00a4e24d259edsm2938716ejc.167.2024.04.07.03.00.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 03:00:52 -0700 (PDT)
Message-ID: <9089eeac-fbe8-4676-8d2c-93820c524802@gmail.com>
Date: Sun, 7 Apr 2024 12:00:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.8.4
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: torvalds@linux-foundation.org, lwn@lwn.net, jslaby@suse.cz,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 stable@vger.kernel.org
References: <2024040409-attentive-raffle-d9bc@gregkh>
 <2024040409-disliking-mammogram-096d@gregkh>
 <41c2bdd3-9b66-404a-aecb-8633d4aa98fb@gmail.com>
 <762f7ace-7fee-4f61-823b-54a1b7d5bdce@gmail.com>
 <2024040629-bullfight-wind-54f0@gregkh>
 <0a716f53-5c88-42e7-b183-fb8ae4d4959c@gmail.com>
 <2024040734-tattling-bubbling-fcf0@gregkh>
Content-Language: fr-FR
From: =?UTF-8?Q?Fran=C3=A7ois_Valenduc?= <francoisvalenduc@gmail.com>
Autocrypt: addr=francoisvalenduc@gmail.com; keydata=
 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
In-Reply-To: <2024040734-tattling-bubbling-fcf0@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

It is this option: support for Microsoft hyper v emulation in the 
virtualization menu. It was added with this commit:

commit b4f69df0f65e97fec439130a0d0a8b9c7cc02df2
Author: Vitaly Kuznetsov <vkuznets@redhat.com>
Date:   Tue Dec 5 11:36:26 2023 +0100

    KVM: x86: Make Hyper-V emulation optional

If I enable this option, there is no problem to run windows guests with 
QEMU.

Best regards,

François Valenduc

Le 7/04/24 à 11:48, Greg Kroah-Hartman a écrit :
> On Sun, Apr 07, 2024 at 11:36:23AM +0200, François Valenduc wrote:
>> While bisecting, I noticed there is now a new configuration option in
>> KVM (support for Microsoft hyper v emulation) which is thus needed for
>> Windows guests.
> What config option is now needed?  So there's no problem anymore, right?
>
> thanks,
>
> greg k-h

