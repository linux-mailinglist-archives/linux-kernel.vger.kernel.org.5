Return-Path: <linux-kernel+bounces-24440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B09482BC8F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44A74287A7E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 08:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F1254BC3;
	Fri, 12 Jan 2024 08:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P3VLK2j1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20825537E5
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 08:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705049837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vW+ol7ud7h2MuKyZ+oGhxDOCyS1XZwRHB+bOAM3iCFI=;
	b=P3VLK2j11ucm7KcubtGtoRbw6DAk76QGQwjPJ+LsWBllkY+v4K/V8rDi0A+FCQc9NKbboZ
	ka8hTQzn3VHSxESk6O5FGCDmE5PpHb/gdVo/qSaNm8L1RnoCZbufFeIDW24wYPUDqoDeza
	nSAhrwRVlwhNMA0rtjO2EkhCLmSsgBs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-6I4He00BMzSWhxmVjdnftg-1; Fri, 12 Jan 2024 03:57:15 -0500
X-MC-Unique: 6I4He00BMzSWhxmVjdnftg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40e41740b6eso53690495e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 00:57:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705049834; x=1705654634;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vW+ol7ud7h2MuKyZ+oGhxDOCyS1XZwRHB+bOAM3iCFI=;
        b=R4F/j1m8h9QFsJKk8OGCMM9iR7o7W+rg4ACm8CfJAh3xh0emiDfW6TuJdCSHMxJSyB
         qYKnDwaR+1QgMYVLMIlSodVmcN/PY+yPqMDnu+9ujUUKRNpzZygtyqNsPA++pb7vrwah
         R6Fz84GlBFRs0m/nMHAfaj35+IfNh/IzgChx7eb+LJIkMVFRQg7Cfs+XMqDnZYohCPVN
         sM5ijUdzXnUyQVXaYHkh5oXNpCSIw6SwLyiKAqM90JpQXiYg9y7bKhxlopQOjWrz03uj
         xwTtwFbI0DrbZ3EZk7tc2Pp1Gb7BNoHIqmj/IpbUU0Of4jBeQMHFJQkNKdwlaHoeXgdp
         xGYA==
X-Gm-Message-State: AOJu0YwwKPyO34rEJjoD70LKruPjZBfq2nIeW0PYjS5W4KHIhCK6JSNC
	+LstD7Pt51A04OBUEgFoCsvyekIMDAdCD/oTrX0AZvI/WV6dIp/B+hNrD6RCSA7NVaO4qgE4CI3
	8jPNpTHMZf5DcYC8WHBOCMTYO1S8nNWrN
X-Received: by 2002:a05:600c:a44:b0:40e:5381:a3f4 with SMTP id c4-20020a05600c0a4400b0040e5381a3f4mr542348wmq.132.1705049834479;
        Fri, 12 Jan 2024 00:57:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhoDkKX8I8gR/mGochqiZZrxkHpZlM0KzkKbRYLswMrqn5HM0RW8oybzkuEb4sCSClxaKzdg==
X-Received: by 2002:a05:600c:a44:b0:40e:5381:a3f4 with SMTP id c4-20020a05600c0a4400b0040e5381a3f4mr542338wmq.132.1705049834079;
        Fri, 12 Jan 2024 00:57:14 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:5200:12dd:5a7f:d73:45df? (p200300cbc705520012dd5a7f0d7345df.dip0.t-ipconnect.de. [2003:cb:c705:5200:12dd:5a7f:d73:45df])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c458700b0040e483aa5d1sm8836316wmo.24.2024.01.12.00.57.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 00:57:13 -0800 (PST)
Message-ID: <511e07da-9b34-4707-8f5a-f1e534c4445a@redhat.com>
Date: Fri, 12 Jan 2024 09:57:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] userfaultfd: avoid huge_zero_page in UFFDIO_MOVE
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: sfr@canb.auug.org.au, peterx@redhat.com, aarcange@redhat.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzbot+705209281e36404998f6@syzkaller.appspotmail.com
References: <20240112013935.1474648-1-surenb@google.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240112013935.1474648-1-surenb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.01.24 02:39, Suren Baghdasaryan wrote:
> While testing UFFDIO_MOVE ioctl, syzbot triggered VM_BUG_ON_PAGE caused
> by a call to PageAnonExclusive() with a huge_zero_page as a parameter.
> UFFDIO_MOVE does not yet handle zeropages and returns EBUSY when one is
> encountered. Add an early huge_zero_page check in the PMD move path
> to avoid this situation.
> 
> Reported-by: syzbot+705209281e36404998f6@syzkaller.appspotmail.com
> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
> Applies cleanly over linux-next, mm-stable and mm-unstable branches
> 
>   mm/userfaultfd.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 216ab4c8621f..20e3b0d9cf7e 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1393,6 +1393,12 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct *mm,
>   				err = -ENOENT;
>   				break;
>   			}
> +			/* Avoid moving zeropages for now */
> +			if (is_huge_zero_pmd(*src_pmd)) {
> +				spin_unlock(ptl);
> +				err = -EBUSY;
> +				break;
> +			}

As an alternative (and more future proof?) just reject anything that is 
not an anon folio as well?

Anyhow, this should handle the issue at hand.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


