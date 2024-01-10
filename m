Return-Path: <linux-kernel+bounces-22835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E4382A3BC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 23:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 551C8289C98
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42D94F881;
	Wed, 10 Jan 2024 22:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2ebZWsb"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F042AE69;
	Wed, 10 Jan 2024 22:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-783195e57c7so306591685a.2;
        Wed, 10 Jan 2024 14:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704924045; x=1705528845; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQNHWwGHv1BR7NcjbT1UUV9pjYFn1oFVtE7FaHO24PU=;
        b=g2ebZWsb5MOmslfKDHZ8/etQvSQAmXZvjLt3xeWhBQBP3DQMFJEUp8uyFnaU7OR2+R
         FpbyZTCshmWR/YSp7hZyGPoGQaY2R2LJ5fQaEolgLLyMLejIsXqJ853OIEH7wttX4veW
         GpKJ19zmJmg4O9A4SRxzhr7MGFkGh3pumFYteBgK54I6pxV6vT8P2STnU/BY9Mn48OsG
         iqcpUefOOUE9TiqNuxcvwFXtUqX1QDjcskbnTs4myIPY8VCFDI/r7sTiCsahl6pTjNx2
         PYGgecEIPXPEOFPyBz0gqTYw7tzlBKcFssTKP5G/D8lyBZlq/DI2gFbuYEbXu3Q9kOSr
         BtGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704924045; x=1705528845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQNHWwGHv1BR7NcjbT1UUV9pjYFn1oFVtE7FaHO24PU=;
        b=hFcCXo+UbwZszWLaPjord6n5X6jKNcYGXSbpQjZmNsK/XxbmDrVQzxpso7s2WBaE0w
         nEcph2+nsCFK1vy3gSf4PZH5ZTyYcGOuIKM6lNwG78FQSgmEXSuzfj0AQcyL9XZ5/OM0
         LaQTHeHaXQMcZVewxbsfGD3ebPohZsD+jcrivp9C1U9otKb4/uWREHJgcGLNs4toFUYd
         FLLyupLhVpNZqNJLzug0IrV1RqmJEF9Rn0KuOY0PG83P4MDlSiOWjPTfsctHeyKxV8U8
         /FjaiDDmUwEebDG44tTSxRRFuiPh2QJtZROusHgS1WRP4dHEPF5gMSTgaAx4gIH5lPfL
         jFpQ==
X-Gm-Message-State: AOJu0YwAwZSBAylYAjXBQE8kg8whsKsV3A4AnSJwyFq0G0cZ6aqJ/XTe
	KM6lXgQtsC9IGYD2cICcTQA=
X-Google-Smtp-Source: AGHT+IFUIrL1dAXi6ergGzOc7fEKoRe5k/hU2s+fGJog242xj+MFcIOC1U5/LPvVXeVBLEUVsF93hw==
X-Received: by 2002:a05:6214:d65:b0:67a:a721:9e91 with SMTP id 5-20020a0562140d6500b0067aa7219e91mr134706qvs.66.1704924045288;
        Wed, 10 Jan 2024 14:00:45 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id j17-20020a0cf9d1000000b0067f678747ffsm2003463qvo.50.2024.01.10.14.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 14:00:44 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailauth.nyi.internal (Postfix) with ESMTP id 1FCB127C005A;
	Wed, 10 Jan 2024 17:00:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 10 Jan 2024 17:00:44 -0500
X-ME-Sender: <xms:ixOfZbFtzQwDIEckOFRARRJ8970Q4bmPHJi4yPcafuxDYtLE9d_GPQ>
    <xme:ixOfZYXWJuk4lAbzb5U2GwNnTev9TABAgyhUcNrRz9TEWvfbtIN-VY0xlj8-DPIri
    aNVjuGmqSt-5N13sw>
X-ME-Received: <xmr:ixOfZdIsQTrHOjU70r7dWXM7I0zVYKPrbPJxOqki3isHYB61z6EF-YL8vIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeiuddgudehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:ixOfZZEtgA4Z3ftWYEgfyaM_oBY2vXXbxtr-R9guGXK2eUJHebO-Yw>
    <xmx:ixOfZRVxc1EWC0TvcEZ8RER8T0WzMx1R7a-XT1ue47O1jKYLvHdGvQ>
    <xmx:ixOfZUOgAlzPludOxHkF9NCwxaDVe2dg2zjW2NRWZpX0wy-JT223IQ>
    <xmx:jBOfZdrtvJNow290I62PRbxVtVxfpTvcsqZd9puD6NFJYfvc43CwMw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jan 2024 17:00:42 -0500 (EST)
Date: Wed, 10 Jan 2024 14:00:41 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 1/3] cleanup: provide DEFINE_LOCK_GUARD_ARGS()
Message-ID: <ZZ8TiS9S6aRmtjna@boqun-archlinux>
References: <20240110203215.36396-1-brgl@bgdev.pl>
 <20240110203215.36396-2-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110203215.36396-2-brgl@bgdev.pl>

On Wed, Jan 10, 2024 at 09:32:13PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> This macro allows defining lock guard with additional arguments that
> can be passed to the locking function. This is useful for implementing
> guards for nested locking.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  include/linux/cleanup.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
> index c2d09bc4f976..921db45023bb 100644
> --- a/include/linux/cleanup.h
> +++ b/include/linux/cleanup.h
> @@ -246,5 +246,11 @@ __DEFINE_LOCK_GUARD_0(_name, _lock)
>  	static inline void * class_##_name##_ext##_lock_ptr(class_##_name##_t *_T) \
>  	{ return class_##_name##_lock_ptr(_T); }
>  
> +/*
> + * Helper for implementing guard locks with additional arguments passed to
> + * the locking function.
> + */
> +#define DEFINE_LOCK_GUARD_ARGS(_name, _type, _lock, _unlock, _args...)	\
> +DEFINE_CLASS(_name, _type, _unlock, ({ _lock; _T; }), _type _T, _args)
>  

First I think the name should really be DEFINE_GUARD_ARGS(), these
DEFINE_LOCK_GUARD_*() functions have different meaning. Also this should
really be a more generic case than DEFINE_GUARD(), so how about the
following:

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index c2d09bc4f976..4fcdcb478fd1 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -148,11 +148,14 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
  *
  */
 
-#define DEFINE_GUARD(_name, _type, _lock, _unlock) \
-	DEFINE_CLASS(_name, _type, if (_T) { _unlock; }, ({ _lock; _T; }), _type _T); \
+#define DEFINE_GUARD_ARGS(_name, _type, _lock, _unlock, _args...) \
+	DEFINE_CLASS(_name, _type, if (_T) { _unlock; }, ({ _lock; _T; }), _type _T, ##_args) \
 	static inline void * class_##_name##_lock_ptr(class_##_name##_t *_T) \
 	{ return *_T; }
 
+#define DEFINE_GUARD(_name, _type, _lock, _unlock) \
+	DEFINE_GUARD_ARGS(_name, _type, _lock, _unlock)
+
 #define DEFINE_GUARD_COND(_name, _ext, _condlock) \
 	EXTEND_CLASS(_name, _ext, \
 		     ({ void *_t = _T; if (_T && !(_condlock)) _t = NULL; _t; }), \

Thoughts?

Regards,
Boqun


>  #endif /* __LINUX_GUARDS_H */
> -- 
> 2.40.1
> 

