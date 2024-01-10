Return-Path: <linux-kernel+bounces-22562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56810829FB7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8E531F2998D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDE64D134;
	Wed, 10 Jan 2024 17:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RGkElYkx"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E584D105
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 17:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d3ea8d0f9dso158375ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 09:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704909021; x=1705513821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ziX4iAyQd6HuMoejvtTa4o/24+LLm+GeIG6etI51RFw=;
        b=RGkElYkxQBgBJkizvSkQMJOVLAS/Rb/Kepoa5WqZhH2V+qYL2wa5vDpervBAc0M09E
         +mKHacKxWgjrRd3ILvbdSh3kF7xjtbLhnCGHY9bfw3IDz0X+nanlLW6ytJP7wvhAL2nX
         2Yy7angzUm+GDmpQ9p2M+ZDUURDMW2uK/+6WKyACxLauMlSdGTCL33YhydIYuGtPg4iG
         Ht+TCkNTNwMi75caTg0zZXPgXU2q3NdGfp/DRIAMre1qx1AimDHAoNRRGEo3CLkJ/Z5Q
         ZF7M0NxXVxhoAH6B2IP9PJIaG92fRzBTJ0eAQkPl0Z9vpLDFGM8MVQzImPFKgHBcjOIO
         LUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704909021; x=1705513821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ziX4iAyQd6HuMoejvtTa4o/24+LLm+GeIG6etI51RFw=;
        b=rJkfwluYrFcimfFb3aaDgLzHk+BQhJiROOq8/utInM1/P0LHNIxljaBYUAksmorsUr
         Ioz/kWvUxOdlDLu9ifeEPvWNMB9gXVotMQKIe/pvVwHiAUvmt1DTkHrhun5cCrUxQPZP
         44vHnAJtVlqcaKFXkGLF1G2Fg19S5FukrLH/+hIURL1WleuVefaeF93Mm+90VSZ3Xlt2
         U4ZC1ponoOLQ10+2dIOeOx2CHr7o13vD3omj1EDOBMaqmTgwLulkJUJuXN2dRmDMemd+
         6OGD5nU6vsl3gT8m4vqRM6S0O6KmHRYruJbKFnXegSkinPxKmpd4OfW3IsWlQsakXCKN
         xdtw==
X-Gm-Message-State: AOJu0YxzED97FJDX2nq6eE4roTCcZfmP5ddcxiDJqBa0wF3+KqOVNJoE
	LliOKbjCUAAhYiXLMRiB/vN58mPly/Gqzz5khCZRqJsyp3U/ZO3C7qAKVdex0mpVMPQPyIcNt9N
	ReiNUDD3mYqJWK8yRlDHQ+aawbC4/uv8dvLpBr7iCe7bc6NC4aw==
X-Google-Smtp-Source: AGHT+IEJ1kVbKPySZnD2kKeOBfKyCBhNXAuJLGSkzYysePXX7J9uu7bfnYGIqnXlWDnqA8f4ASaYZl73K0Ijv1kIfTA=
X-Received: by 2002:a17:902:da8c:b0:1d4:c2bd:eff1 with SMTP id
 j12-20020a170902da8c00b001d4c2bdeff1mr7544plx.8.1704909020628; Wed, 10 Jan
 2024 09:50:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220214505.2303297-1-almasrymina@google.com>
 <20231220214505.2303297-3-almasrymina@google.com> <20231221232343.qogdsoavt7z45dfc@google.com>
 <CAHS8izOp_m9SyPjNth-iYBXH2qQQpc9PuZaHbpUL=H0W=CVHgQ@mail.gmail.com> <20240104134424.399fee0a@kernel.org>
In-Reply-To: <20240104134424.399fee0a@kernel.org>
From: Shakeel Butt <shakeelb@google.com>
Date: Wed, 10 Jan 2024 09:50:08 -0800
Message-ID: <CALvZod4xbQr0gZdfXYNTaS11d2T2hHpXxi5Lfyt=y+TcDseOhg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/3] net: introduce abstraction for network memory
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mina Almasry <almasrymina@google.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, David Howells <dhowells@redhat.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 1:44=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
[...]
>
> You seem to be trying hard to make struct netmem a thing.
> Perhaps you have a reason I'm not getting?

Mina already went with your suggestion and that is fine. To me, struct
netmem is more aesthetically aligned with the existing struct
encoded_page approach, but I don't have a strong opinion one way or
the other. However it seems like you have a stronger preference for
__bitwise approach. Is there a technical reason or just aesthetic?

