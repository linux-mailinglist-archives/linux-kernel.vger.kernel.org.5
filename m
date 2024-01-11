Return-Path: <linux-kernel+bounces-23783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF2F82B1A5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 752041F22679
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C6D4CB47;
	Thu, 11 Jan 2024 15:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TbagtFyR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D254CB25
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704986659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vs3W/eIl/UfBRYysYHDeM31hEkWplA1eoKt9Zckovpk=;
	b=TbagtFyRA9L/jMDgOAIieXE1clsteD1jyD4oRXnrAj5wTJMoaLegr/cdA6tVE705hrHj+N
	GSXM29v07MFlLab8qlk7HHlc1hNIPlgHnwPgNJF/0umhLX189uAxU38pUXhMRB2Mn9SLi2
	Q+46/la8SKj8OoAcOdJO65kup/btCO0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-J-qWI7-qNOSXhf2e1Dnlkw-1; Thu, 11 Jan 2024 10:24:18 -0500
X-MC-Unique: J-qWI7-qNOSXhf2e1Dnlkw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40e479a51e4so21570755e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 07:24:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704986657; x=1705591457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vs3W/eIl/UfBRYysYHDeM31hEkWplA1eoKt9Zckovpk=;
        b=K/SmIXcKVxOprJOV3HRV+VFqE7VkfeL00e6Ejkq6jwfMCdl2vAjc7IZ6ltTxbpzsb1
         8UVcY8Ms4+PRwM3sWyk78t/5HLex4Zt7LtOgAZ98uqg9e6uLPVc9L6DE6KvGEQRDOYGm
         09iBL1ATz5mjUKhAbVrHM/NCH188UaJvaKIhXMd4+5fRRxSQcI4S/SIjfjZaOLMT4jet
         FwLPXlavnwjCWasn6wjOlQ5iqbCiolOyEGU5eAFZiHu+5IjaTm55OlrXvoy+ZHTYJUtU
         sklE2C3fnQD4VyCNj7b/uBAip8zMhSrUPY2HqSAcV5/EyZSfnYYFQRRPfeUWvkAevBI5
         Gz3A==
X-Gm-Message-State: AOJu0YxqgFNESnFsqJ4HkD8myX2LJgyslBkZhapbgfPcsrVvrnilHRGn
	ZLgxzjc8AiM8hmE/+ZTf+w/Z8r5uGfnN/r32xGGiKsd+U/MtCiMEEmwxsjkqkT14BbXSXKAyIA0
	5J7IpXpl9lU2j0ltno5Cj+Tc8eubACfIT
X-Received: by 2002:a05:600c:4683:b0:40e:557d:a5a7 with SMTP id p3-20020a05600c468300b0040e557da5a7mr590206wmo.160.1704986657454;
        Thu, 11 Jan 2024 07:24:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxESPHos7/n5zRPY3mgQMa4Pf5PjJBeFOGJLM+EmwwuQBdUSMJQtx7cgMBMyr6y0aUIqB2og==
X-Received: by 2002:a05:600c:4683:b0:40e:557d:a5a7 with SMTP id p3-20020a05600c468300b0040e557da5a7mr590196wmo.160.1704986657110;
        Thu, 11 Jan 2024 07:24:17 -0800 (PST)
Received: from p1.home ([2001:bb6:9663:8600:ef47:6102:2ccd:b7e7])
        by smtp.gmail.com with ESMTPSA id v17-20020a5d43d1000000b0033760ad2eabsm1455177wrr.69.2024.01.11.07.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 07:24:16 -0800 (PST)
From: Eric Curtin <ecurtin@redhat.com>
To: airlied@gmail.com
Cc: dhowells@redhat.com,
	hpa@zytor.com,
	jhubbard@nvidia.com,
	linux-kernel@vger.kernel.org,
	pinskia@gmail.com
Subject: Re: [PATCH 00/45] C++: Convert the kernel to C++
Date: Thu, 11 Jan 2024 15:24:14 +0000
Message-ID: <20240111152414.35517-1-ecurtin@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAPM=9tzNEbJxVtusYLQqvzo14-CW_Nbo65L7Jfb4dF_JM1PBTQ@mail.gmail.com>
References: <CAPM=9tzNEbJxVtusYLQqvzo14-CW_Nbo65L7Jfb4dF_JM1PBTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> You don't just need coding standards, you need a compiler that refuses
> to compile that stuff.
> 
> If you want C++ to do what Rust could do, then you need the compiler
> to stop the stupid before you can even write it, otherwise people will
> still write the bad stuff and code review won't catch it all.

Completely agree with this by the way, if you could turn off features
easily via C++ compiler flags, etc. and make usage of the unwanted
features throw errors. There is a subset of C++ that would have been
useful in the kernel many years ago.

I think the C++ committee is coming around to this way of thinking with
profiles. But it should extend to more than just memory safety features
of course.

Some of the things I like about C++ over Rust:

- C++ interop with C is easier, you can just intertwine C and C++
  together out of the box once your code is compiling with C++.
- It's already on the majority of platforms, even legacy ones.

But Rust is nice for other reasons.

But yeah something like this would need to be done like the Rust integration
effort and be an opt-in thing for new code, if it was done.

> 
> Can we get memory safety with C++ now? and also stop people coding C++
> like it's 1994?
> 
> Kernel C has kinda become a thing without enforcing it, but C wasn't
> really stopping anything bad, so having C that isn't quite kernel C
> get into corners isn't that bad, but introducing C++ without any
> history of kernel C++ is just asking for everyone to do their own
> special things and defend their usage of every corner of the language
> because they wanted to learn it.
> 
> Dave.


