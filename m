Return-Path: <linux-kernel+bounces-9319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4090E81C402
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 729531C2385D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32A3B65F;
	Fri, 22 Dec 2023 04:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zLMIO8DW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD375B64A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 04:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40d3b2c8517so19565e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 20:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703219747; x=1703824547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cq4h5QboZhQMj+vS/GDQCzDFv690LhM1wOxTfWStork=;
        b=zLMIO8DWhrVVtCQE74Vg350ik6sWZARg93R7XLHDdE43/sNp2SGHwdAt7UlAfXlMXy
         I6xV2cTqt+/FDN/5gX8Rlg4gsEjgZKd3we8+orNOXj7+kJXeAUIU6EuW6e55/9sgVYmV
         PtHHDytUggYsXb3w8jfT79hWB8TC99e1SQ7JYNGei518tXXsuJymzOtXsBNo3Ow9kzd0
         4TZDhvTsXdYgsNBB1zB8w8DvTaqSSqUB+a9SKq9wVbwN8xSMlSljUHV7VU7+fdTHgl6h
         t+Kcpz2+O7Njq0Un5rqXRF93rfbloARj2gTdyR41VJnxJ8ZrjKZ/bQtx8E4JfeZCVqAl
         04xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703219747; x=1703824547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cq4h5QboZhQMj+vS/GDQCzDFv690LhM1wOxTfWStork=;
        b=c+A9wvtU+s2FeozfhiiOD7s7OqS2SRUjcs/CukxU9hvIrkFMrkEMtt4wMmRcfYSxy2
         Z9EvgYNrhuxhsIOGhj1lhIiOTdDYkt4CMPnebzuETYkoES307Yr0zzF4/uMcmH+DZrW4
         5PfP/IVDyjt4SDzeVJYIVKMrnVj35rQU5uO9uAT3Ly5ALf299T1fzs5IK5CRWsCP+4A/
         UgB185a4oCR89XKCk87Dw7gI6Pwo/xCCT1F8Ny5bQyX5VM1vfryvv8VEaKi0j7U9kDlW
         pcgpct2o+wY4FYHu8Cl6lKvNeSqWmlBC2OFyriK0dc5g6SZkkVrxYNmjDpCv1vW1Pw9M
         h7og==
X-Gm-Message-State: AOJu0YwWKn2I6OisERLL00sr1sUsc6n+vi/ZUoVQnNaoPPrQP2TrvT8W
	3Q0D7920TEwlYMtrgcImV6CoHEJlUTCOwZ5+mWGe9pVoUTF/
X-Google-Smtp-Source: AGHT+IH3A6tFn5oze2k72i8bTIzJgmGOBYyk1ho+xIQoseIyv5aMevL4rl58JQRQLxjH0DWWp9+vQqCfI3ccWSJwSko=
X-Received: by 2002:a05:600c:210d:b0:40d:3ab7:86e0 with SMTP id
 u13-20020a05600c210d00b0040d3ab786e0mr39640wml.3.1703219746675; Thu, 21 Dec
 2023 20:35:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJj2-QGqDWGVHEwU+=8+ywEAQtK9QKGZCOhkyEgp8LEWbXDggQ@mail.gmail.com>
 <20231222024458.12441-1-henry.hj@antgroup.com>
In-Reply-To: <20231222024458.12441-1-henry.hj@antgroup.com>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 21 Dec 2023 21:35:08 -0700
Message-ID: <CAOUHufZwXBs4x7GeawrjZNEwTBdV=mf-DYrZuF4j=10URHwQTw@mail.gmail.com>
Subject: Re: [RFC v2] mm: Multi-Gen LRU: fix use mm/page_idle/bitmap
To: Henry Huang <henry.hj@antgroup.com>
Cc: yuanchu@google.com, akpm@linux-foundation.org, 
	=?UTF-8?B?6LCI6Ym06ZSL?= <henry.tjf@antgroup.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	=?UTF-8?B?5pyx6L6JKOiMtuawtCk=?= <teawater@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 7:45=E2=80=AFPM Henry Huang <henry.hj@antgroup.com>=
 wrote:
>
> Thanks for replyting.
>
> On Fri, Dec 22, 2023 at 07:16=E2=80=AFAM Yuanchu Xie wrote:
> > How does the shared memory get charged to the cgroups?
> > Does it all go to cgroup A or B exclusively, or do some pages get
> > charged to each one?
>
> Some pages get charged to cgroup A, and the other get charged to cgroup B=
.

Just a side note:
We can potentially "fix" this, but it doesn't mean this is a good
practice. In fact, I think this is an anti-pattern to memcgs:
resources should be preferably isolated between memcgs, or if a
resource has to be shared between memcgs, it should be charged in a
predetermined way, not randomly to one of the memcgs sharing it.

