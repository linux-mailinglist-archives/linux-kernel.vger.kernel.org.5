Return-Path: <linux-kernel+bounces-13590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 049D782087A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 21:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E6BF1F21E1E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 20:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCBAC2C5;
	Sat, 30 Dec 2023 20:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lovj0WIv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E1AC2D0
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 20:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d41555f9dso80220985e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 12:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703968656; x=1704573456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=itikjIwB1sCUuAZ3lDFPb9OE+d4cZQdLiVdEcoOoW5I=;
        b=lovj0WIvvgsvgwEzVooMrh8Qp5tPTd2yIbebTQrkJy1j3SqNWuMufLA6+zrOJZQ6MM
         Nx82T0sFuXMJMUsAp9rDE6wYzfET6lr8TeW5RYRTAyBNx/RMo6LKC/K9GJxw02JILgHT
         e484g38S3gE+agKLc3Fcs4FJ+1mtwNlv1B2fNEH+m8cn9phO+B5x+7BS4xGdKEagSyFF
         A+5+5bWrd+xZUn6+0BBkv89hoPtzSSjt1IjtI+Jwr3yuW/CVGv9XnSjokJbrXRDZvNPI
         6eCrIos2NdPB3FSoBzaVWZiceprchmrqyAIF2U10Y+rATW+DLcj6eejkA3A2VSexeAqq
         sugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703968656; x=1704573456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=itikjIwB1sCUuAZ3lDFPb9OE+d4cZQdLiVdEcoOoW5I=;
        b=UX/SDhxmIuCpWANRopODAgnEqBRRz6vYRMty8PUueF+Gzht48I3I6a9mLrvCVRIaqO
         gZCAv7SJpq6elhES8LyHeFEpf8NSEcFbw/N/gCfUV/KbCxuiKgbxiGAJDPou8Cn3145P
         YRWru+DEA1mzn0Kk9F2AopYfXdOQ6YtsPd9h4k5piyrmZQnVvmVpq/d9eBiyQ5Sh7d4Y
         iWz7tkxOPsMnZs8dCJVhE8JT3D7HwMYSFhFbts6dBki2Ws00pNAJgIIjbDKJRcRAPziw
         SaD+Hbgjp14YCJURtBB3/6NBjsAT83nL7TpXeOED1pMI1xCPG0oGF2JDqhIMdrzlLH+1
         Fzqw==
X-Gm-Message-State: AOJu0Yzs75bon86kDa2QFiOjGBe6VSyb0su9JZN7qU6B4yiTbOiA4vjk
	dAPBpAtL0DRfUy6qx94bz6M=
X-Google-Smtp-Source: AGHT+IE4Xvo0YQm/n/3Y3fXaF+6a1JP5EDtkalhsBFuleCrQh/WvLu5kVF1RJGHyVueQDZBZ9Q0cuw==
X-Received: by 2002:a05:600c:211a:b0:40d:6221:869b with SMTP id u26-20020a05600c211a00b0040d6221869bmr2495399wml.135.1703968655476;
        Sat, 30 Dec 2023 12:37:35 -0800 (PST)
Received: from gmail.com (195-38-113-95.pool.digikabel.hu. [195.38.113.95])
        by smtp.gmail.com with ESMTPSA id p2-20020a05600c1d8200b0040596352951sm44158182wms.5.2023.12.30.12.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 12:37:34 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sat, 30 Dec 2023 21:37:32 +0100
From: Ingo Molnar <mingo@kernel.org>
To: David Laight <David.Laight@aculab.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'peterz@infradead.org'" <peterz@infradead.org>,
	"'longman@redhat.com'" <longman@redhat.com>,
	"'mingo@redhat.com'" <mingo@redhat.com>,
	"'will@kernel.org'" <will@kernel.org>,
	"'boqun.feng@gmail.com'" <boqun.feng@gmail.com>,
	'Linus Torvalds' <torvalds@linux-foundation.org>,
	"'xinhui.pan@linux.vnet.ibm.com'" <xinhui.pan@linux.vnet.ibm.com>,
	"'virtualization@lists.linux-foundation.org'" <virtualization@lists.linux-foundation.org>,
	'Zeng Heng' <zengheng4@huawei.com>
Subject: Re: [PATCH next 4/5] locking/osq_lock: Optimise per-cpu data
 accesses.
Message-ID: <ZZB/jIvKgKQ2sV7M@gmail.com>
References: <73a4b31c9c874081baabad9e5f2e5204@AcuMS.aculab.com>
 <bddb6b00434d4492abca4725c10f8d5a@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bddb6b00434d4492abca4725c10f8d5a@AcuMS.aculab.com>


* David Laight <David.Laight@ACULAB.COM> wrote:

>  bool osq_lock(struct optimistic_spin_queue *lock)
>  {
> -	struct optimistic_spin_node *node = this_cpu_ptr(&osq_node);
> +	struct optimistic_spin_node *node = raw_cpu_read(osq_node.self);
>  	struct optimistic_spin_node *prev, *next;
>  	int old;
>  
> -	if (unlikely(node->cpu == OSQ_UNLOCKED_VAL))
> -		node->cpu = encode_cpu(smp_processor_id());
> +	if (unlikely(!node)) {
> +		int cpu = encode_cpu(smp_processor_id());
> +		node = decode_cpu(cpu);
> +		node->self = node;
> +		node->cpu = cpu;

This whole initialization sequence is suboptimal and needs to be 
cleaned up first: the node->cpu field is constant once initialized, so 
it should be initialized from appropriate init methods, not runtime in 
osq_lock(), right?

Eliminating that initialization branch is a useful micro-optimization 
in itself for the hot path.

Thanks,

	Ingo

