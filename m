Return-Path: <linux-kernel+bounces-94332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 051F7873D85
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B47562839BD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E2613BADE;
	Wed,  6 Mar 2024 17:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mSqbE/Tc"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D602E135401
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 17:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709746106; cv=none; b=MrVFsnxTQ58aQi8k8imHWzHH/d+Qu8/sokYvPAVFxXSOVWZ4z8Kw8dCsy5kkofnEsHEn7uGzIp03+tuZ8GZBJZk60XNhrf+YpkdNotaiUZTCFgToIHKs1sr8b/5GUAgy9bl42JmXbPDtBosRvDtyoaykMY5vrCd77WvX+he6ELU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709746106; c=relaxed/simple;
	bh=Ghvs4v77iQQAei2ZZ6uDRzDVbGBXuG2zwoIeqAMdXAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X7f4cy1FlpLRYy0Sv07/lRnqLYpqpO6qiENOiSMjVzJhkz1K9OmWEzJSFcfLpV/RFym6i4uNKZwYoxe9JktyN3EaI/7Sqws76dY/PrSXnVpLeS006t76g2Tj/G1rh76D/r1gZm7xNcAt45Q2Azv24UIE1MFN9CeXCCEYGEjpBoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mSqbE/Tc; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-566b160f6eeso15432a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 09:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709746103; x=1710350903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9KodEne8KoAKjyIJo45iuD1jcQ25Lud0hklaomu97I=;
        b=mSqbE/Tc3iKRKAOlNhS1KajldC+YZNhZoImFi6KIiNMJHIvV/YGRR0DvlEb1Mxesrg
         NgYlRYfF3cBq79uEttIC9NIDLCA/CwxoIhGePjQq5eoGsys2+Xix5KpLxX0LaG7NDMib
         /0RCD6BWgjcppnVN22iFbd30BYACPVgn6wvzlcj92zJYsU94/t/jrTx2C0oh+dtHJR2t
         hMyUpx5fkTKD1Hy2s60BYxRnNP2cFQu3kHY2rH22OpihRwbH0mi+EpNFGNGXdAAxT8kS
         l6KjWVKZ6T54l1xPlCBFewuagokys9TzPDrXtj6ayXuvXfIBxceD8I5+S0sZj27I1nzO
         yrvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709746103; x=1710350903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9KodEne8KoAKjyIJo45iuD1jcQ25Lud0hklaomu97I=;
        b=wPgV6D6nJ2YtS52j00gomJX133b8m9eco0P3vAoOiysTqVL8KhOwwzM3vuDOqflTGF
         C9Jr1M3Ge0S4FKE6oHCmNrqVpj7q6VbU4FvsT+FAMwNRmOWRXjuZy07xjUYrbcZpDeoF
         l+GmPYhsh+K76gyTRbZ0tgiqJ2O49q+qbC+u9HIF2KgtKtlx6QD35XQzspHycXcrITIm
         C3K/CyFSmvLbIlPlbL6JK0IbDFt97ETyfSDj2S+OoIwdNe7N7N+xPCucXI5n+VWaFmyY
         5TfTQX/yVUGnPlub/EpYU8nGFzi/jn1vVpC8G0qbcubmcXpPsnH0W7JxPpHqnfAgJJsN
         PtVA==
X-Forwarded-Encrypted: i=1; AJvYcCUn7Bx34njMBafj1IoBOgWoKa/Ux7d+xl6SIaDjS6p4kiiWAciHSRmZKUiLVI9lPNN+ZC3N/0wx0btaaY8cQ10NMoQLOZayf7WSshdr
X-Gm-Message-State: AOJu0YwMmbS8PHZzaOFgECpfPoy8fXIY/cjxsG2veUNeNg+du2llEx/6
	mLiVlhVHkhRqsSj/s+X+fT92OHptfjqy3tZb04A0J9I79EpoJMsgzKrGxYPa6ZchdSivIYeBPBy
	P7ihQidCQMRAZmh28RflUaBjVDDx82g6IL1Wi
X-Google-Smtp-Source: AGHT+IHnNtaMgf1oa5P9omQGhKnc6U5AuSPId+mAS/2wEyyxbq2B9XLRNBZ/kNpYHe8+c66dcpBJTdAzKzTpJdifaEU=
X-Received: by 2002:aa7:d5d0:0:b0:566:a44d:2a87 with SMTP id
 d16-20020aa7d5d0000000b00566a44d2a87mr27047eds.0.1709746103008; Wed, 06 Mar
 2024 09:28:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226022452.20558-1-adamli@os.amperecomputing.com>
 <CANn89iLbA4_YdQrF+9Rmv2uVSb1HLhu0qXqCm923FCut1E78FA@mail.gmail.com>
 <a8de785f-8cc3-4075-a5f2-259e20222dcb@os.amperecomputing.com>
 <CANn89iJAKEUu_Fdh0OC-+BJ+iVY0D2y0nAakGLxWZ8TywDu=BA@mail.gmail.com> <11588267-c76d-f0ac-bf98-1875e07b58cb@os.amperecomputing.com>
In-Reply-To: <11588267-c76d-f0ac-bf98-1875e07b58cb@os.amperecomputing.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 6 Mar 2024 18:28:09 +0100
Message-ID: <CANn89i+SiQXeDCKp9yjTz6ReQKxfHn6vHLcWFbCjjW14BiyAbQ@mail.gmail.com>
Subject: Re: [PATCH] net: make SK_MEMORY_PCPU_RESERV tunable
To: "Lameter, Christopher" <cl@os.amperecomputing.com>
Cc: Adam Li <adamli@os.amperecomputing.com>, corbet@lwn.net, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com, 
	yangtiezhu@loongson.cn, atenart@kernel.org, kuniyu@amazon.com, 
	wuyun.abel@bytedance.com, leitao@debian.org, alexander@mihalicyn.com, 
	dhowells@redhat.com, paulmck@kernel.org, joel.granados@gmail.com, 
	urezki@gmail.com, joel@joelfernandes.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	patches@amperecomputing.com, shijie@os.amperecomputing.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 6:01=E2=80=AFPM Lameter, Christopher
<cl@os.amperecomputing.com> wrote:
>
> On Wed, 28 Feb 2024, Eric Dumazet wrote:
>
> >> __sk_mem_raise_allocated() drops to 0.4%.
> >
> > I suspect some kind of flow/cpu steering issues then.
> > Also maybe SO_RESERVE_MEM would be better for this workload.
>
> This is via loopback. So there is a flow steering issue in the IP
> stack?

Asymmetric allocations / freeing, things that will usually have a high
cost for payload copy anyway.

Maybe a hierarchical tracking would avoid false sharings if some
arches pay a high price to them.

- One per-cpu reserve.    (X MB)

- One per-memory-domain reserve.  (number_of_cpu_in_this_domain * X MB)

- A global reserve, with an uncertainty of number_of_cpus * X MB

Basically reworking lib/percpu_counter.c for better NUMA awareness.

