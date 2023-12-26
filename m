Return-Path: <linux-kernel+bounces-11722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E5B81EAC8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 00:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 544982831EC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 23:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D357F4EF;
	Tue, 26 Dec 2023 23:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pig/ZVLX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9B65681
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 23:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-42786a44837so1033971cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 15:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703633724; x=1704238524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZ+VyiPmwTPUzp7gonixlKN6VYglweSWOvX0B9fYuA0=;
        b=Pig/ZVLXD93Dxf0FQZVmWS4c3zfEJHp22y6aq3hJK6TJPCZpE3s5DIjYp1KMwVQWNA
         mzJ1x8DSPQ0e3fh+Yqr26fOlFTA0L0zOrJRz+aTvyybKMtOf2hMbn6foBaeN2BgRvl+n
         daQgvBS9hydoSM9+jxcY5SoKtMhQx5ShHkbVxKKQeKVUNKUKe2eH08G/RsdfWUDZos1u
         98BZ9tiwy6fUEE20czQ/J1PCbQAv8Ebm0VlJ8aOTqe4O5EnpUry6Di5EsTty1wkaPVOx
         Ar1hX961iQlPaGEmPUQCeIKCLRJ7v/ZPOkxBptOOl3nMNiP0xiJTurmsgf1/dT2fJgrn
         7rLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703633724; x=1704238524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZ+VyiPmwTPUzp7gonixlKN6VYglweSWOvX0B9fYuA0=;
        b=pmYBPipxq9ZX/nkBleN2dY/M+d+P3PuSv6LRSEgPvUEFNR5b8SgLXIju8utWghAxFT
         nyDS2f4dE9/haMsBNYe12Zutvpcdi93/kQ1FblgYLzYZhUajW/ccP2a0My2lFj6xn/Wd
         xLV6cPYrdTXPtqXf8zR6w2bLsdJSKtioVTQ1xYE0H9DdoD8F+fX7myi9x5rEXSi4Z06W
         4TFdq4ewBZ+zPNnRc8oNF7lDti1Hz9BdEGRX7bhZUy6mlx3+81S3Lh68Zc7a3N/3ELA+
         /MXuYfI3obXZgUeAq01CBS/3rX+WBPhpsAZS4pNeSLScBw3eEHexwP9wdA1NGmLoEQtR
         i6Ig==
X-Gm-Message-State: AOJu0Yxph9JuiZVKaCbzMIwXKs2k/1sH5Rwpac9YrIl29iynceauLH2w
	u8waO2b6aSZpArtHSOpdSP7XD/zjGxnHtPi8gupIYn4v0Gb3
X-Google-Smtp-Source: AGHT+IHp0BTJOrpLyzI3EpLd2wSYU26gECySIQJni1tDfXxziq3Dk+T6Cq/RADc9KqlY9GR3mzqHTegHxmUUC9HsKO4=
X-Received: by 2002:ac8:590b:0:b0:427:e836:2549 with SMTP id
 11-20020ac8590b000000b00427e8362549mr101794qty.29.1703633723983; Tue, 26 Dec
 2023 15:35:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231226-verbs-v1-1-3a2cecf11afd@google.com> <fadeaa0b-e9d2-4467-97ad-63ba8f7d8646@infradead.org>
In-Reply-To: <fadeaa0b-e9d2-4467-97ad-63ba8f7d8646@infradead.org>
From: Tanzir Hasan <tanzirh@google.com>
Date: Tue, 26 Dec 2023 15:35:11 -0800
Message-ID: <CAE-cH4rc6gWNcsgm243i=dXQhaAQsC4gEz15GEWZO4HB7Vki3A@mail.gmail.com>
Subject: Re: [PATCH] xprtrdma: removed unnecessary headers from verbs.c
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Tom Talpey <tom@talpey.com>, Trond Myklebust <trond.myklebust@hammerspace.com>, 
	Anna Schumaker <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nick Desaulniers <nnn@google.com>, 
	Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2023 at 3:20=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Hi,
>
> On 12/26/23 13:23, Tanzir Hasan wrote:
> > asm-generic/barrier.h and asm/bitops.h are already brought into the
> > header and the file can still be built with their removal.
>
> Brought into which header?
Hi Randy,

Sorry for the poor explanation. I see that I left out the specific header.
The inclusion of linux/sunrpc/svc_rdma.h brings in linux/sunrpc/rpc_rdma.h
This brings in linux/bitops.h which is preferred over asm/bitops.h

> Does this conflict with Rule #1 in Documentation/process/submit-checklist=
.rst ?

Yes, this conflicts with Rule #1. A better version of this patch would be t=
o add
linux/bitops.h to this file directly. The main reason this patch
exists is to clear
out the asm-generic file since those are not preferred. I can do this by ei=
ther
including just linux/bitops.h or including both linux/bitops.h and
asm/barrier.h.
Would the second approach conform better with Rule #1?

Thanks,
Tanzir

