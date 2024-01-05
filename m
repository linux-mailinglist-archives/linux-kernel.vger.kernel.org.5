Return-Path: <linux-kernel+bounces-17996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C4E825691
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94BAD284270
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF5C2E63B;
	Fri,  5 Jan 2024 15:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O27dA7G/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742AA2E626;
	Fri,  5 Jan 2024 15:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6da55cc8e78so1230389b3a.0;
        Fri, 05 Jan 2024 07:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704468483; x=1705073283; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ktHGS+j6BB2fCkp0Q1Ok9aJQ6HsRlIXcJkVo6gtPf5s=;
        b=O27dA7G/170/Y+lVJgsVtfzu/wIsVQLYaObFvu/XTNqJ+ZQGqIV+tMa7rA5qviVy5E
         DkMC13e3QgnMMG0ZkSQ7mtfp6mU5bObuxN4VIjMQkrFKpArPD0ujIauOamMl2wGJc6Jw
         WfUdEvKNs6fjNrjyBlYMQTC68zMKB0IgI3Np0/E3paoOuL51W0QedmJTducz7n0aShQQ
         cmr65qKutrqNixh7GYRnfYSsLmYUERbtnpsBdJQHTfQe+dy8XDukCDQGI/AQBpjai2uy
         7SLUdBly9c6ehJOmIs+tMGK0oJgsAFyCs44o3GDW3YUAWUevf5wmyp/0AxOZUFZ731cU
         6leQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704468483; x=1705073283;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ktHGS+j6BB2fCkp0Q1Ok9aJQ6HsRlIXcJkVo6gtPf5s=;
        b=QAFDq126nxJPvrmDnwtee1hx5geR9uKj+fi2JFirHF5lMmvNCqwpa+Q+/gMCM3ECAy
         O2mGmJqQXL1Ze8NbIK3Dk/P5hYFXGTvFd0ja4dfLuD/LLn3ux7QtMU1z/kM4e++I30dY
         KF3TlEb6aYgxLcDEusXkSOK8HKv27AfHy+TjjPvVLx3OGLbRCdNjshF055aJElHD5TPD
         7bz0gYsBkf89AsQ1E1Vxthi1aA73CzeG+8tlodlHWagTQsLWTZTq7oit4wl85N/9FI4o
         LNEIkjJrYFWUQ6iVcQu9iqa5zuXDakL/p41ED+heSq0dmIShy+9mwDiyFf5pLW07elrv
         X4YQ==
X-Gm-Message-State: AOJu0Yx2GI8r3IWk2uai3lg0APPAdf60tuVO21o0mNqpIENu/+KSNrak
	Cg06/6IFLhFCPbrzwTcbGEo=
X-Google-Smtp-Source: AGHT+IH8p3k4ac8NQNc+kFJS+pH0O4w5XDqyG53RzmOtCMOURUe9FSLw2f4tOz7YL7GUpuB0ytCUcw==
X-Received: by 2002:a05:6a00:4b01:b0:6d9:aa5e:3969 with SMTP id kq1-20020a056a004b0100b006d9aa5e3969mr2525870pfb.40.1704468482705;
        Fri, 05 Jan 2024 07:28:02 -0800 (PST)
Received: from ?IPv6:2605:59c8:448:b800:82ee:73ff:fe41:9a02? ([2605:59c8:448:b800:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id h20-20020a056a00231400b006dabdfabe12sm1518428pfh.193.2024.01.05.07.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 07:28:01 -0800 (PST)
Message-ID: <3f382fdcacc10cf897df9dc7f17c04271839d81a.camel@gmail.com>
Subject: Re: [PATCH net-next 1/6] mm/page_alloc: modify
 page_frag_alloc_align() to accept align as an argument
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org,  pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton
	 <akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, 
	linux-mm@kvack.org
Date: Fri, 05 Jan 2024 07:28:00 -0800
In-Reply-To: <20240103095650.25769-2-linyunsheng@huawei.com>
References: <20240103095650.25769-1-linyunsheng@huawei.com>
	 <20240103095650.25769-2-linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-03 at 17:56 +0800, Yunsheng Lin wrote:
> napi_alloc_frag_align() and netdev_alloc_frag_align() accept
> align as an argument, and they are thin wrappers around the
> __napi_alloc_frag_align() and __netdev_alloc_frag_align() APIs
> doing the align and align_mask conversion, in order to call
> page_frag_alloc_align() directly.
>=20
> As __napi_alloc_frag_align() and __netdev_alloc_frag_align()
> APIs are only used by the above thin wrappers, it seems that
> it makes more sense to remove align and align_mask conversion
> and call page_frag_alloc_align() directly. By doing that, we
> can also avoid the confusion between napi_alloc_frag_align()
> accepting align as an argument and page_frag_alloc_align()
> accepting align_mask as an argument when they both have the
> 'align' suffix.
>=20
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> CC: Alexander Duyck <alexander.duyck@gmail.com>

This patch overlooks much of the main reason for having the wrappers.
By having the in-line wrapper and passing the argument as a mask we can
avoid having to verify the alignment value during execution time since
it can usually be handled during compile time.

By moving it into the function itself we are adding additional CPU
overhead per page as we will have to go through and validate the
alignment value for every single page instead of when the driver using
the function is compiled.

The overhead may not seem like much, but when you are having to deal
with it per page and you are processing pages at millions per second it
can quickly start to add up.

This is essentially a code cleanup at the cost of some amount of
performance.

