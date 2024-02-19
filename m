Return-Path: <linux-kernel+bounces-70913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BAC859DE6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C115128214A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFED20DC3;
	Mon, 19 Feb 2024 08:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R3W1h9R1"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1732209E
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 08:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708330438; cv=none; b=trM1+kRykfvZz5F6Z+HMInKBeE+MQjTFDckUnJzsgADpFL2LBWePYfp52Ht2qYqGGZjzS3HB3FchRABUmuko+OnjLlpOklIBOvnmOH3Ka53jdQKmaoa0QfNrg+NqQ+NSyKcrvY/W+eZsAeQsD7fPR1Acg9AeH6c/uyloLHg61FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708330438; c=relaxed/simple;
	bh=L4LDe6/2pjSy98QopaS+9Ub807rsKp5R4F3WNI3CNGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S924dHUlxJuL90fEoOj+6C2K4C9Tk9NKLZy6dtX4UkhPn/MLztNncSZwpTuNNpJzqbyIzFBg+KLM4+fqc5Vx6ZsGz9ss7ZF0wx9Shq1KGRQU4myiwYBlYHWCTIatlCuSMBQsF8V8IaI6DdLZNc22GP9sfxfxZicPOt6WMqU2PNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R3W1h9R1; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e43ee3f6fbso994348b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 00:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708330436; x=1708935236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Faazju06esA/iLDjRJkBakC+phNkJjgF7OASCw5VQPg=;
        b=R3W1h9R1qI8HzpQIMu6DhKDUPZxprb9YWZ6T82lfiiyk/zYbqg/svWlfDbGa0fLiJE
         U3sVoxv6m18RXFs/O2aCg3ixjBgep5FIt6Wmy8eDlSKkCDbHquP6srB7hYAZGjDCrLp2
         WGoRA0Nj84HmTyE+qaiBjVNVcfBi0kZ4eczzUzyjFXqI4vrH6ovHalrSi15F4aQqR4RG
         lGUtDM7HlYi0Ox8eAgAlYglwpYrBuISzh8bw37aQ09XAssbB+tSGgeZxeV6iEFON/GrE
         FRQ40bjxfBMF/iDOdgZU1VcvtlkhpNhIsUbvegSABP5oyx9ze2uqVrDLOd2wzd0iWWg3
         0jqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708330436; x=1708935236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Faazju06esA/iLDjRJkBakC+phNkJjgF7OASCw5VQPg=;
        b=LCUqFuUZg5/yOikEOENgA8FuESGxHFBTXCaVgo2oZjzD8RvXqEv3RSf0ZIyKg3saJO
         A+MPH+ZByEzCTaUlfWiPuRiMzMYVP61GNfuhHL33pfoH/jQ0jQr50P5c15ZiN4LgixlX
         4eRBYwi47dZ9jsWcqwM92mQhguBJ3CTdAmoc3CU9STGQWfrH4/1JIr0MstTtVoufP30v
         Zm2h5aRSsbzOJXwxrS/2dOoqJdpAbwulQjYq7h8jolFFaqVJisPPCY7Hc3wywtnWcf1Y
         fnKVeOt38acsQzODThWCyRgFACDknXsOUKX2qDh8/uvh5dAaMgyqqaqOEiNng9meBSZw
         QcZw==
X-Forwarded-Encrypted: i=1; AJvYcCVnybRYdmaHHHgQ4zKou55eddkv2aj9XUQ/1r+RP8+JT1Z9qt2qhYdTR3AHK8X6YVi28etR3kAGv+XhctnexcQeFCWeVUaPGoSr8QPv
X-Gm-Message-State: AOJu0YxItlzM7WLKCTv4DGep5mGauAEh3HK4OqPKS/GJevxCewSeGL5A
	VOrSz6r7RvKrwcqMKOBIWMYNC0lRxrwXE5nYajmLyjYEQlmLMDmosqn2CjrJnWCPPrF0FA5iZvp
	21XgrLSe/1Q2p5Ul6ED6HnFxVFFBowzysTofxDg==
X-Google-Smtp-Source: AGHT+IH4P+EJqjGg42FcH2qCVt4SYGQoiN23N28i6N69kj3qRf3djQwdq4QgJyosAwKqXUVruDAnLuKYd+zMJmCKyQA=
X-Received: by 2002:a05:6a20:d38f:b0:19e:367a:2ca9 with SMTP id
 iq15-20020a056a20d38f00b0019e367a2ca9mr14536523pzb.8.1708330436239; Mon, 19
 Feb 2024 00:13:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <64955b50602fc64e2d3c7d4a92a1f9459e8c7ead.1708120036.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <64955b50602fc64e2d3c7d4a92a1f9459e8c7ead.1708120036.git.mirq-linux@rere.qmqm.pl>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 19 Feb 2024 09:13:44 +0100
Message-ID: <CAKfTPtAvcRvdHQ2OY4cej26dXt_y5LbtYh=OGWxfbQunh-Juww@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched/topology: loop properly when clearing flags
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	Len Brown <len.brown@intel.com>, "Joel Fernandes (Google)" <joel@joelfernandes.org>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 16 Feb 2024 at 22:55, Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qm=
qm.pl> wrote:
>
> Fixed commit introduced sched_group::flags and a loop that was supposed
> to clear groups' flags if the child sched_domain was deleted.  The
> iterating part was missing.
>
> Fixes: 16d364ba6ef2 ("sched/topology: Introduce sched_group::flags")
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---
>  kernel/sched/topology.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 10d1391e7416..75b1a18783c2 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -767,6 +767,7 @@ cpu_attach_domain(struct sched_domain *sd, struct roo=
t_domain *rd, int cpu)
>                          */
>                         do {
>                                 sg->flags =3D 0;
> +                               sg =3D sg->next;
>                         } while (sg !=3D sd->groups);

This has been discussed here
https://lore.kernel.org/all/20230523105935.GN83892@hirez.programming.kicks-=
ass.net/T/#m0881c3e17954dc6e23f81216873e721f8395e554

and here
https://lore.kernel.org/lkml/20230617081926.2035113-1-linmiaohe@huawei.com/

and the right solution would be to remove the while loop but  for
whatever the reason, this has never been resend with an updated commit
message

>
>                         sd->child =3D NULL;
> --
> 2.39.2
>

