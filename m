Return-Path: <linux-kernel+bounces-12174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5471881F0ED
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 18:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B21351F22FF0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A1A4652F;
	Wed, 27 Dec 2023 17:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="AtIwFBfy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C74A46521
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 17:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5e75005bd0cso48638337b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 09:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1703698449; x=1704303249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IysQ2MBjWZmGcQMU+hbJajsPx5O73ApG75Uxt6wnIcw=;
        b=AtIwFBfy2BTdyoXp6Bqs+Zdba1w7bFrDbh4RdV7l6y/n/zq3H+uf3hfftFpnhMhC+o
         oqj17Z3KNxBsqf3GfSRttK3HsvOUhMCiNlZzzvyIvqW1azRxxYgfF9YwcWw8h9RKUTqG
         nz4R7nMvwYgO7Q93ObNZyLn1oV4B7w2rMG9YuEljIWeWye/Z4irgVwl6GPO539mZT8Zj
         jteNZJRiSdvIuUARcaNFue/XtIcGrW3+LBi3jzBzjaUSXeANtkhG2bYKg16HNn4X3YID
         hTh27KV8aqdkYjThJ41JxEB16Y3ZNBqseCPUoPfOJAxaDGTIMr/uBTbyN04+tCpyV06D
         VcNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703698449; x=1704303249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IysQ2MBjWZmGcQMU+hbJajsPx5O73ApG75Uxt6wnIcw=;
        b=OEpYUWqU0W12TwoRcYFOFhlnXABXEpb5Osn3Fx5cqsSE6i0CXBjCAHXR2rnlcmAN35
         rcZtB+DRgaTyVB0XqtDlnCEhdMYGKWrJznYxYNwEbwVO9rcR8WbiUCBi+4u7Zg5wsGCY
         Lo8UPIXULs43pU21p93XBIqCFEksX7osO5XJZ7PW8HYMjQhETXUw477Jj8ZSF0pUmFKI
         ibNfZDuFCizhybRLezaSEMYR3YXvkTo2yNZ4XdWxyutsTmmzHfUDUqxwegDGzZhEjCMS
         M9tp0awWWzrOxFjjcpHL0v8Kcl7HCrTk/yIOLlVUXzWI6NU/RYrRPI5uYSTA37d0N+uw
         qmFA==
X-Gm-Message-State: AOJu0YzJetUGqZr5tp8RxKmz6hsy5pjDCJT94PnhTYaF2LfdgdsRJd0Q
	MvPoG1gXOZielMaZMQXFQvMP1SRKHz25/nbPhhvLEKnd0+E4
X-Google-Smtp-Source: AGHT+IGppupe9O9CWsASpOZ2IytM7UdTc/lbiLp6dvILqyh0v8BaMHzLIIfpOTslFO6fCe6sc0vuOseqzKtLegQc7rc=
X-Received: by 2002:a05:690c:470d:b0:5ea:1eb8:24aa with SMTP id
 gz13-20020a05690c470d00b005ea1eb824aamr4775756ywb.69.1703698449069; Wed, 27
 Dec 2023 09:34:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231224165413.831486-1-linma@zju.edu.cn> <CAM0EoMm8F3UE3N-PBZmJHQpYYjiV23JKf6jGsvzzWs0PBd+AWQ@mail.gmail.com>
 <6aab36aa.56337.18ca3c6af7a.Coremail.linma@zju.edu.cn> <CAM0EoMmBp6SWDGhPkusnx0jh4y=1k9ggS+5UpV+0MtEccDgyXw@mail.gmail.com>
In-Reply-To: <CAM0EoMmBp6SWDGhPkusnx0jh4y=1k9ggS+5UpV+0MtEccDgyXw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 27 Dec 2023 12:33:57 -0500
Message-ID: <CAM0EoMm5ruiBfJC1C+Jvz=vuKz03e_KOS_jgbS7ETkSfV-SKDA@mail.gmail.com>
Subject: Re: [PATCH net v1] net/sched: cls_api: complement tcf_tfilter_dump_policy
To: Lin Ma <linma@zju.edu.cn>
Cc: xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 12:02=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> On Mon, Dec 25, 2023 at 8:39=E2=80=AFPM Lin Ma <linma@zju.edu.cn> wrote:
> >
> > Hello Jamal,
> >
> > >
> > > Can you clarify what "heap data leak" you are referring to?
> > > As much as i can see any reference to NLA_TCA_CHAIN is checked for
> > > presence before being put to use. So far that reason I  dont see how
> > > this patch qualifies as "net". It looks like an enhancement to me
> > > which should target net-next, unless i am missing something obvious.
> > >
> >
> > Sure, thanks for your reply, (and merry Christmas :D).
> > I didn't mention the detail as I consider the commit message in
> > `5e2424708da7` could make a point. In short, the code
> >
> > ```
> > if (tca[TCA_CHAIN] && nla_get_u32(tca[TCA_CHAIN])
> > ```
> >
> > only checks if the attribute TCA_CHAIN exists but never checks about
> > the attribute length because that attribute is parsed by the function
> > nlmsg_parse_deprecated which will parse an attribute even not described
> > in the given policy (here, the tcf_tfilter_dump_policy).
> >
> > Moreover, the netlink message is allocated via netlink_alloc_large_skb
> > (see net/netlink/af_netlink.c) that does not clear out the heap buffer.
> > Hence a malicious user could send a malicious TCA_CHAIN attribute here
> > without putting any payload and the above `nla_get_u32` could dereferen=
ce
> > a dirty data that is sprayed by the user.
> >
> > Other place gets TCA_CHAIN with provide policy rtm_tca_policy that has =
a
> > description.
> >
> > ```
> > [TCA_CHAIN]             =3D { .type =3D NLA_U32 },
> > ```
> >
> > and this patch aims to do so.
> >
> > Unfortunately, I have not opened the exploit for CVE-2023-3773
> > (https://access.redhat.com/security/cve/cve-2023-3773) yet but the idea
> > is similar and you can take it as an example.
> >
>
> Sorry, still trying to follow your reasoning that this is a "net issue":
> As you point out, the skb will have enough space to carry the 32 bit
> value. Worst case is we read garbage. And the dump, using this garbage
> chain index,  will not find the chain or will find some unintended
> chain. Am i missing something?
>
> Can you send me a repro (privately) that actually causes the "heap
> data leak" if you have one?
>

To clarify what triggered me is your tie of this as an exploit and
quoting CVEs. Maybe not so much net vs net-next.

cheers,
jamal

> cheers,
> jamal
>
>
> > > cheers,
> > > jamal
> > >
> >
> > Regards
> > Lin

