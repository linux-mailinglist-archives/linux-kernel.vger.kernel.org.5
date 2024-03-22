Return-Path: <linux-kernel+bounces-111689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8AB886FAA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47136284D44
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA1E4E1B3;
	Fri, 22 Mar 2024 15:16:24 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FCF3C17;
	Fri, 22 Mar 2024 15:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711120583; cv=none; b=KAKeM2x9LardCsyAQcN07SlQVLRAeXrvM6G0bAZ72vhNzpfBnv9kTWAl4nY7B91abGXCQxDn1LDOmfxnvTyP+yloiJOwcgz0d8HrvqXZU0Grd8nZ0/8ol5SID+bOG5heRpFZ7u6VMnLb/xfIlI6RhHToM8TeqnFI/In6mItoyGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711120583; c=relaxed/simple;
	bh=k6ZBqXOSOxwfvSpr3Zn2oOPOvUxMxZJnrUwc4UoCotY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRl7vAAbB5VGKJmYKF4MFlAs/uvWF1jrovrBA1iBj4D1KD4v9ickIpHuftzp9/SVWQSm2hXKHRj+dPvdKK7UpNBYfgcNXcRz6R9gyTHHfl3o5wzj5uHLKVLN1NwDyxhkFczkiSo8jRdL1qOu7YAPXnxbafqsTRiWBf3Eu1Hv5/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56b8e4f38a2so2951581a12.3;
        Fri, 22 Mar 2024 08:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711120580; x=1711725380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMb2IgPKyZnj/ue62em5Q9KAY8/Lp0+DnO65BTLg4OM=;
        b=CoJ9mIHihB2kA/XJyUiSefUz0qvTLupzv8EU44zZw8l1kvolD71JaqF/9x1Ks7dS8c
         tSpDrWBRqoyRWjumtaoB1OwtFcrFefSx7IL4mU9RMcNDHk9sgqUCRd3QBDwPssNhu7PX
         D3PTg+ZzNvB2LSDFaNRfA9QaKgIFYgQjmNVQYTC6WzrK6S/3tVthRsZXHs0K2oMBchwp
         teSTqCBZ/0heRYk4CPf8Ayd7EYpW6iuhGpjYdqgzsCb6wADBQRCyDnY/peqlEt67Grz1
         LhXCDVeww5oaGfaSY4BnmzlJLHaLVA44Bp0+J6s0kz07rf8UZFe1kpKfka66USAiYLq4
         7kow==
X-Forwarded-Encrypted: i=1; AJvYcCUzEcykoZ6I+tQ7lgSV4jvKqMFIl+3p7FXU7n9C7q9W1CzAnFbRpS/+1fCawgoXa2vIK+xaLQfXQcri76HFLhqKhFZlV6EEqlFurUEOzVo/efXRrat7Rwe5UWJSk/oHmVyKDahtNZsuEwOrJjA=
X-Gm-Message-State: AOJu0Yz7QHfnRH92h7ggbCZ8Qj22u+tIlAESQX0aBZqwwcBC81aKKS0o
	ctzuouInbJp9+pxa/yafmLeUbesKq2PaRoq7Akw+TKdfk3AOvj1ppzVlpg8O
X-Google-Smtp-Source: AGHT+IG19fJVfmLxYOcOEr80oE8P0l2x5mYegvQxSIpQMrvkuLrpfoVX+O792HS4x99bT+I74w91TA==
X-Received: by 2002:a17:906:1843:b0:a46:f958:2eb6 with SMTP id w3-20020a170906184300b00a46f9582eb6mr1801147eje.67.1711120580209;
        Fri, 22 Mar 2024 08:16:20 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-120.fbsv.net. [2a03:2880:30ff:78::face:b00c])
        by smtp.gmail.com with ESMTPSA id oz27-20020a170906cd1b00b00a473490aae8sm543234ejb.24.2024.03.22.08.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 08:16:19 -0700 (PDT)
Date: Fri, 22 Mar 2024 08:16:17 -0700
From: Breno Leitao <leitao@debian.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: Jeff Johnson <jjohnson@kernel.org>, kuba@kernel.org,
	keescook@chromium.org,
	"open list:NETWORKING DRIVERS (WIRELESS)" <linux-wireless@vger.kernel.org>,
	"open list:QUALCOMM ATHEROS ATH11K WIRELESS DRIVER" <ath11k@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath11k: allocate dummy net_device dynamically
Message-ID: <Zf2gwaEU4PQ+6GMe@gmail.com>
References: <20240319185735.1268980-1-leitao@debian.org>
 <871q85as8e.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871q85as8e.fsf@kernel.org>

On Wed, Mar 20, 2024 at 04:32:49PM +0200, Kalle Valo wrote:
> Breno Leitao <leitao@debian.org> writes:
> 
> > Embedding net_device into structures prohibits the usage of flexible
> > arrays in the net_device structure. For more details, see the discussion
> > at [1].
> >
> > Un-embed the net_device from struct ath11k_ext_irq_grp by converting it
> > into a pointer. Then use the leverage alloc_netdev() to allocate the
> > net_device object at ath11k_ahb_config_ext_irq() for ahb, and
> > ath11k_pcic_ext_irq_config() for pcic.
> >
> >  The free of the device occurs at ath11k_ahb_free_ext_irq() for the ahb
> > case, and ath11k_pcic_free_ext_irq() for the pcic case.
> >
> > [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/
> >
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> This crashes on my nuc x86 test box with WCN6855 hw2.0 when running
> rmmod, stacktrace below. I used tag ath-202403201010 from my ath.git
> tree as the baseline. Sorry that I'm not able to debug this further
> right now.

Thanks for the detailed log. I am trying to understood the issue, and I think
we are deferring a null pointer, which is likely net_device->dev_addr.

Here, dev->dev_addr seems to be NULL.

>   27:	83 e6 07             	and    $0x7,%esi
>   2a:*	42 0f b6 14 30       	movzbl (%rax,%r14,1),%edx		<-- trapping instruction

In this case, and I understand RAX seems to be dev->addr, and R14 is the
KASAN shadow:

	RAX = 0000000000000000
	R14 = dffffc0000000000 (CONFIG_KASAN_SHADOW_OFFSET)

So, we are clearly deferring a NULL pointer.

Now, why? Not sure yet.

