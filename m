Return-Path: <linux-kernel+bounces-48904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEBC84630A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5922F1F259C8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304573FB15;
	Thu,  1 Feb 2024 21:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLdji2zT"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A38F3F8C8
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 21:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706824602; cv=none; b=Q7CIQl/dGZexGiLvuSyx8DrnAC2jrUgI2Ez2f4X7aJBTnkxFmEJNXrCkJ6Q4S7EFziif8fNAHOxMxMrXVOd10QkKflozRl5btGGGYuZpTcjz6FxCug4BLdyiJcdsUE1hpplBu3L6wU18Nf7QK6xN6rJ4yq7h7veAhQIlDhaVD6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706824602; c=relaxed/simple;
	bh=U3HRZu0hfYdAw3piq+fNS3Ph9tLvjEaJxmQ8IFz7O2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3I5mx5JJMjw4NBoYmewCk9D55yfXod6RgVuDFIOnKu7GmXwMDKuI8poKDsF/i9a/0zrIXizVV2upt7o9ZZxZutSV3XOGFQwcndNm1q7QZioUgS3cuOUsD8YFxqsN5uWnojppvlh8qghUBZy8RWMyqY5CQXhQ2HkZWpaccYNWIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLdji2zT; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e14b858785so840453a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 13:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706824600; x=1707429400; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fIppjMUeVlwOxKTD0ceP+Py3vPz42BK+5Be9y2b8mE=;
        b=jLdji2zTHqJHg71HEQ5SQyb1RxOu62tGG7l64FUP+xrSJf/wJK8qxSomz7JNaAGbuC
         UxUyPmMWU8brn80/QU5IRxfK/VHkeMwTTJJold5svN3/ai4egZJC7w69KPfrIuyATD6K
         1r4yyAZ1FXqnsqarp5/9XOWmETI8Axpx3XcVHqZKA0NxiX3xD+vHthYfqff8iCwymkRB
         Ty+WZHbAvr6AmuR0XL4Eb9g8cc3KeGiyFfUZmcxn0QEIrApARlvKCoirzBds+x8BAvUu
         Go1iIZ7sARTjkv0nfC+Zfu2GJmVGyCtrqMjKANKz8yGK6I27U+3A2IWGd7Ec3xgw55hY
         qTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706824600; x=1707429400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fIppjMUeVlwOxKTD0ceP+Py3vPz42BK+5Be9y2b8mE=;
        b=fLrGKVyOXeEJeTuAEyxo7twgBwdz1CPz0vD18QNYXt4lcHVvhl5SXXOUIiSGF56z5z
         IxkG6FGndLRKamSKqmrSn/MazG0P+4K5v7SMC4/e2F9iqX7b/1twV/dmHkPwTSES4cjt
         T9qR9ru437Jea5rBVYqV7H06ciJWhWNa31FNFH+hNNydP3g7aYt2Zf7f/sUeQa4s45Iw
         P10dQ9tYY2ls1KqAwWzmIptvhbfSvSxpIfUeHkBVVbyxsgBXUonVgpFJ7pFvgRzIaNTC
         ePP3tlbTP7Jb5SoMpwIjG5+5ElFitq+SEI4J/N8MhuY8mgrng6MRsVjXJ5mCq6uqMUV1
         wGEg==
X-Gm-Message-State: AOJu0YzGOZ4Jw35laRoEv+ORgUnAJT1JLYVMrT83vWmOep3hclMxZyZj
	lWHQcTEO3r3yO1aRJLP23SwSR+UJ6vUi1XspU2jzoVnww4rk5NWi
X-Google-Smtp-Source: AGHT+IH4ptqPl7FCLvPrQmIRXDF0ZoNIuZI2sd+z8xjzpcTkOaGTgGzTUZSxJdUlMoD/ijAN1jupFA==
X-Received: by 2002:a05:6830:1453:b0:6dd:e95f:c6f5 with SMTP id w19-20020a056830145300b006dde95fc6f5mr3720566otp.37.1706824600095;
        Thu, 01 Feb 2024 13:56:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVCtEt9h2O7d5c5NRKEguG6Y/bs6FpadrtgFWyzB6IgUj96+35b6MksaxXYCzBY4OpilROw5pVEjE/MeMGmnbSiLyMdYU2zytI8c8w+fqqqJMPL+DGBgg+Tqz5CIHdR5PlfRVaQuhYWzE9Apb5LOFgx16vdjRGNAMluy216WflaCbYRi5wRbJAGXFY3aFh6w5ouZ4Nag7KhRag3SUNN0ET/nfQtNo5X08qq5csgCY+EytD3RLczYMJ9bc2COHdBwo/PItGZlDzJ7xk/gqvHReHklI8LJn3TTb6TL/X0XJzCPA1BltQ56M2NeulHT6cTgxsfwSZWgLBLz20c+UcvAweCEG0lXRBt3OBWsUUQYSSg+430eQa/+qQ8cmS8wcZC
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id o24-20020ac841d8000000b0042a40e3ca9fsm171859qtm.85.2024.02.01.13.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 13:56:39 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailauth.nyi.internal (Postfix) with ESMTP id 5A64C27C005B;
	Thu,  1 Feb 2024 16:56:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 01 Feb 2024 16:56:39 -0500
X-ME-Sender: <xms:lxO8ZbyaKJv7gvc0hliwcH-83bWYdizYUbvncv4R-_ChwmgJxXEOnw>
    <xme:lxO8ZTTmlIA49MIq7CWABxWF82hf3WS8Q-mzFSciV9DGpmXpRqia-AawFwBvOiqu7
    _Fzex-HMP9bQEnALg>
X-ME-Received: <xmr:lxO8ZVUUic2LXoqY0gXIE4l076RB0msI4ALEKOHmg821qnLT_1bjLfBBFSIzAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduuddgudehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:lxO8ZVhy4WSJawKDGFnv-tfvCKvSDl809FFgwqniwJPybpCpVe292g>
    <xmx:lxO8ZdCDHHa68wecNBn7PaJTCe8yQlD5gAYnPgwPUKYPL8KVqG-YMA>
    <xmx:lxO8ZeKbN03xRktCxDaM2Xu5Dk-Eud6sv8lp4u932wJbrBV-pndGCA>
    <xmx:lxO8ZR6tVPMRZvlDDqWMc8hnzloYu05shy-8O0FEgnbG-Zp8PhTIWA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Feb 2024 16:56:38 -0500 (EST)
Date: Thu, 1 Feb 2024 13:55:32 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, peterz@infradead.org,
	mingo@redhat.com, will@kernel.org, longman@redhat.com,
	linux-kernel@vger.kernel.org, niuzhiguo84@gmail.com,
	ke.wang@unisoc.com, xuewen.yan@unisoc.com,
	Carlos Llamas <cmllamas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V2] lockdep: fix deadlock issue between lockdep and rcu
Message-ID: <ZbwTVPj7WU_Vu6D_@boqun-archlinux>
References: <1705477714-10467-1-git-send-email-zhiguo.niu@unisoc.com>
 <cc828212-9a90-430e-8719-e6b19bdab600@acm.org>
 <CAL0jBu-2jrhBzTo+ZneFMpsTsqUMLVQCYCAQKqd6BHjv3-kxhQ@mail.gmail.com>
 <1f1691cd-fcc8-4a0b-9d63-bff15c5a52ad@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f1691cd-fcc8-4a0b-9d63-bff15c5a52ad@acm.org>

On Thu, Feb 01, 2024 at 01:24:48PM -0800, Bart Van Assche wrote:
> On 2/1/24 11:48, Boqun Feng wrote:
> > raw_spin_lock_irqsave():
> >    lock_acquire():
> >      __lock_acquire():
> >        validate_chain():
> >          lookup_chain_cache_add():
> >            graph_lock();
> > 
> > Basically, every lock acquisition may lock the lockdep graph because
> > of dependency checking.
> 
> Wouldn't it be simpler to make __lock_acquire() return early if
> this_cpu_read(lockdep_recursion) indicates that the graph lock is held?
> 

Note that lockdep_recursion doesn't indicate graph lock is held, it
indicates we enter lockdep internal, which means if there was any lock
acquisition, __lock_acquire() would skip the check, so we don't go into
lockdep internal again, therefore avoid infinite recursion.

Regards,
Boqun

> Thanks,
> 
> Bart.

