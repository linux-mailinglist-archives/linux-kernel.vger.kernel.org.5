Return-Path: <linux-kernel+bounces-15105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9D0822748
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 03:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95AAF1F22253
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB43E179AE;
	Wed,  3 Jan 2024 02:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLvVffDe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B821F1799D;
	Wed,  3 Jan 2024 02:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6dbb7d80df8so6867728a34.1;
        Tue, 02 Jan 2024 18:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704250709; x=1704855509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/a2j1/lHth7zs05WU5aYt/LfzS3M/wGNylwLFfEgkQ0=;
        b=mLvVffDeemap8bV5CQx9LsXW+V8ed5NeSVI2IIxJe1OP8p3jyprialiBEgf6blLGS3
         tvo2NeUmsBec6Rk+HJqUSF3Pc/m4TSlClCa+FHeFbkQvZ8s5e9XDazozjlm2S9QuaqJJ
         EJ/9KhWXzb+e23Zf/kUEZ5w5//Lw2zccWvDGV+K2khbrbLmYYPPGyml1RHu5LjxY/+Ql
         jJBz1H6x9VkRsTP6BlxbYnlGYKSMS+D6pEr5lN+fZi/H5he5mB9AoH66zmP1JZXGmZHn
         plIsPF909lPuEOABWAmaSNRBbuvu5k7JJNh5UTWGqb9LapAV52mRgYri5IKC49Du2Mzu
         nUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704250709; x=1704855509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/a2j1/lHth7zs05WU5aYt/LfzS3M/wGNylwLFfEgkQ0=;
        b=a1czJlaWJSzzOmT/vqP1ozmnrPpRWEXyGQHq9nMWdi4r4S0RanlHGhu2kpkGFfF0t6
         I7PJZZJXvhDv8tw32okUecehS72Ocsf2DRIX/Gk0n4Or7dnPOQyEithgnYt4acFprW1Z
         23AR9Az3efGjdeezhtCGUM3G5XiUVbhdJM0+Ast5eDJUJZUz4Mh+yNilq6VcB81MTqrS
         npu7w56OTW5ySdphyy+wYbUy7PMpVkbpkH23HZxx2uNCeIxQTpDYiZafPjRpbshUpu0F
         eoA2EGQXxUrCzObie7uAkLJ6Vw8lqadpHX2eXwra2XFuM0SVLaDygr1cg2cHVpxsU5Rz
         H83g==
X-Gm-Message-State: AOJu0Yxm/KUi4zQ5ILrfAG0fRYCWj5iiIn9F3/IPh7YorGJh9wRo3I5q
	gDKcApXGUuvk1i7BlYZ2vmY=
X-Google-Smtp-Source: AGHT+IFpg8o2SLVkvafPjMs9qtDK8eJP522pJiWlxctRpEYR82N3yz/UoeW+DRyVcdlGAEybzkOYvw==
X-Received: by 2002:a05:6830:3:b0:6db:fd12:8e9c with SMTP id c3-20020a056830000300b006dbfd128e9cmr9353263otp.5.1704250708788;
        Tue, 02 Jan 2024 18:58:28 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:a7d6:f37a:9130:cd96])
        by smtp.gmail.com with ESMTPSA id d6-20020a63fd06000000b005cd8ada89e5sm21168572pgh.70.2024.01.02.18.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 18:58:28 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	akpm@linux-foundation.org,
	chriscli@google.com,
	chrisl@kernel.org,
	ddstreet@ieee.org,
	hannes@cmpxchg.org,
	linux-mm@kvack.org,
	nphamcs@gmail.com,
	sjenning@redhat.com,
	vitaly.wool@konsulko.com,
	yosryahmed@google.com,
	zhouchengming@bytedance.com
Cc: linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH v4 2/6] mm/zswap: reuse dstmem when decompress
Date: Wed,  3 Jan 2024 15:57:59 +1300
Message-Id: <20240103025759.523120-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240103025759.523120-1-21cnbao@gmail.com>
References: <ZY1EnEefZsRTGYnP@gondor.apana.org.au>
 <20240103025759.523120-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>>
>> for CPU-based alg, we have completed the compr/decompr within
>> crypto_acomp_decompress()
>> synchronously. they won't return EINPROGRESS, EBUSY.
>>
>> The problem is that crypto_acomp won't expose this information to its
>> users. if it does,
>> we can use this info, we will totally avoid the code of copying
>> zsmalloc's data to a tmp
>> buffer for the most majority users of zswap.
>>
>> But I am not sure if we can find a way to convince Herbert(+To)  :-)

> What would you like to expose? The async status of the underlying
> algorithm?

Right. followed by a rfc patchset, please help take a look.

> 
> We could certainly do that.  But I wonder if it might actually be
> better for you to allocate a second sync-only algorithm for such
> cases.  I'd like to see some real numbers.

some hardware might want to use an accelerator to help offload CPU's
work. their drivers are working in async mode, for example, hisilicon
and intel.

I don't have the exact number we can save by removing the redundant
memcpy, nor do i have a proper hardware to test and get the number.
As Chengming is actually working in zswap, i wonder if you can test
my patches and post some data?

> 
> Cheers,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>

Thanks
Barry


