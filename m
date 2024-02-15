Return-Path: <linux-kernel+bounces-67440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A85E8856B92
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEA64B25985
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A22137C5D;
	Thu, 15 Feb 2024 17:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="rpu7FVkZ"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D400136642
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 17:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708019359; cv=none; b=PsDJyeU+pz9Sz+6Kxzyypmm6I80fuLLchRoG6d1vlE8Iuj53pMCHnkdWkminepSX8agZkud3yfQw5BRNPJ98J6LyDjn2lxHq9YXI7gSzKndXRwEe/Br1Ni8VW2kEhnftlCCjtF2VOjnv0lHziB169JpWjN6g2XkPC7vncyQzyoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708019359; c=relaxed/simple;
	bh=U0JFFwyDzDAYTa90FsvXX1UBz6aubxIXT9g8ZeVH5ak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lNYHBI4128M6x1iiyIVIti1idAvdibMnZtHEyyDXfcNE7q7A9KjH5cd8gAkWuSnIHpzwRkEO7kjhSsjOgL+isfAZnLyaNORF9WyRe4xB7jKpGqu8fGx6ddIztmSg/20BhZKJhvfiM4Anj/ppXkJC+YInPzf5cNEZLXnRUsx+n6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=rpu7FVkZ; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-60790e62f90so11462247b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1708019356; x=1708624156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKJH/sdzxRbGj/GrO9+Z+lN1Jd7UdkMhb2otIV3stYQ=;
        b=rpu7FVkZjeXTTn0tuCxUMYdlZXaYCAz7kZmAt4/FpCpModUuA1RzgA+WXKxjrGayDs
         srClw+dFnH8ydeO02dneMrxTJp3+cMWlsVqHA1V2jPjysiu/w2bCd4kGIu7p/CyCki/c
         /gSZfyYXcXTIFNofflFvpEWimx2Fr/5XuClHJUKrXaOpUVAgCWXgINidOo1920ghvJtE
         XB8VaHlwKxmp534Kx1gDQ8n+vsP90U7DbJ0oIMlU3SMCAlDg1LyETNJiPg6rnIggneLM
         Oj9m8LjCEgYEBwsLMCnoTJ52O8KGYDIElZk9Xxau5v632YxYaIA7k922EDQZdyz7Q1+L
         GFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708019356; x=1708624156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GKJH/sdzxRbGj/GrO9+Z+lN1Jd7UdkMhb2otIV3stYQ=;
        b=BiyvhBXR5k7wSAIjN+VwhyN2wtBzs3JGLrAMRqdyaG5rIxMNGweBm6v0JiGO6p9nd1
         GEQE+fv11FiMqBZCK+v9d0FHUJn1p5OLrldkXGI9ZmNQmm9JsaZij3ynxf3FGQGCeBrP
         aopO7s0CFPNGH2DkLP21d4HvtETN08Yz23vTIuJknLntVeBzrxDFZxnshqnUZrp609qZ
         cXWelUlk76htbsn/RBqm5UQrIYkAm2IAvykN7vhoW4MX/xvWQHKNpLHUN/t15ArmeBdC
         gRTkFBvEhkzMxGoGtcLmVh5Sq3FfT1BLl+CFjXitsxS+5smEBHJB3ffhVh/6zXw3Rr36
         v6Kw==
X-Forwarded-Encrypted: i=1; AJvYcCW3lqsC0DUMLt7Yn+5ifB+8A1URA6htXavS7ogH/XRCRf/VyClF5rD31NYmCRtfYonM7FKM9fausJUacKQ0NEDx/gnpzTWKE0ibZWj9
X-Gm-Message-State: AOJu0YxgYsUwSjMei/1Gpd9AV8rlsPjl3lyurxYGMnNgaSIIwBr7J6XX
	DbR3FARQqlbXkR+JO0DPv4LWcGTa9cZu51XJubBK5VWU0Fw4TWByvkb17A9ITce5X/2o58F7V7w
	3OPfGwFhid6gw4bYRiBM1sFmtzGbYixRMjKs5
X-Google-Smtp-Source: AGHT+IHSyB1k8GhC13KtB+5SWdJ6jy0sE1GtxffnwM1CS5Lu2dBFvgzZ2TasOVbhoQJjk7j8YQNm4fSLvK7EYO7IrYk=
X-Received: by 2002:a0d:d817:0:b0:604:ac3b:a38b with SMTP id
 a23-20020a0dd817000000b00604ac3ba38bmr2362753ywe.14.1708019356510; Thu, 15
 Feb 2024 09:49:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215160458.1727237-1-ast@fiberby.net> <20240215160458.1727237-4-ast@fiberby.net>
In-Reply-To: <20240215160458.1727237-4-ast@fiberby.net>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 15 Feb 2024 12:49:05 -0500
Message-ID: <CAM0EoMmyGwA9Q=RibR+Fc41_dPZyhBRWiBEejSbPsS9NhaUFVQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: sched: make skip_sw actually skip software
To: =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llu@fiberby.dk, Vlad Buslov <vladbu@nvidia.com>, 
	Marcelo Ricardo Leitner <mleitner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 11:06=E2=80=AFAM Asbj=C3=B8rn Sloth T=C3=B8nnesen <=
ast@fiberby.net> wrote:
>
> TC filters come in 3 variants:
> - no flag (no opinion, process wherever possible)
> - skip_hw (do not process filter by hardware)
> - skip_sw (do not process filter by software)
>
> However skip_sw is implemented so that the skip_sw
> flag can first be checked, after it has been matched.
>
> IMHO it's common when using skip_sw, to use it on all rules.
>
> So if all filters in a block is skip_sw filters, then
> we can bail early, we can thus avoid having to match
> the filters, just to check for the skip_sw flag.
>
>  +----------------------------+--------+--------+--------+
>  | Test description           | Pre    | Post   | Rel.   |
>  |                            | kpps   | kpps   | chg.   |
>  +----------------------------+--------+--------+--------+
>  | basic forwarding + notrack | 1264.9 | 1277.7 |  1.01x |
>  | switch to eswitch mode     | 1067.1 | 1071.0 |  1.00x |
>  | add ingress qdisc          | 1056.0 | 1059.1 |  1.00x |
>  +----------------------------+--------+--------+--------+
>  | 1 non-matching rule        |  927.9 | 1057.1 |  1.14x |
>  | 10 non-matching rules      |  495.8 | 1055.6 |  2.13x |
>  | 25 non-matching rules      |  280.6 | 1053.5 |  3.75x |
>  | 50 non-matching rules      |  162.0 | 1055.7 |  6.52x |
>  | 100 non-matching rules     |   87.7 | 1019.0 | 11.62x |
>  +----------------------------+--------+--------+--------+
>
> perf top (100 n-m skip_sw rules - pre patch):
>   25.57%  [kernel]  [k] __skb_flow_dissect
>   20.77%  [kernel]  [k] rhashtable_jhash2
>   14.26%  [kernel]  [k] fl_classify
>   13.28%  [kernel]  [k] fl_mask_lookup
>    6.38%  [kernel]  [k] memset_orig
>    3.22%  [kernel]  [k] tcf_classify
>
> perf top (100 n-m skip_sw rules - post patch):
>    4.28%  [kernel]  [k] __dev_queue_xmit
>    3.80%  [kernel]  [k] check_preemption_disabled
>    3.68%  [kernel]  [k] nft_do_chain
>    3.08%  [kernel]  [k] __netif_receive_skb_core.constprop.0
>    2.59%  [kernel]  [k] mlx5e_xmit
>    2.48%  [kernel]  [k] mlx5e_skb_from_cqe_mpwrq_nonlinear
>

The concept makes sense - but i am wondering when you have a mix of
skip_sw and skip_hw if it makes more sense to just avoid looking up
skip_sw at all in the s/w datapath? Potentially by separating the
hashes for skip_sw/hw. I know it's a deeper surgery - but would be
more general purpose....unless i am missing something

> Test setup:
>  DUT: Intel Xeon D-1518 (2.20GHz) w/ Nvidia/Mellanox ConnectX-6 Dx 2x100G
>  Data rate measured on switch (Extreme X690), and DUT connected as
>  a router on a stick, with pktgen and pktsink as VLANs.
>  Pktgen was in range 12.79 - 12.95 Mpps across all tests.
>

Hrm. Those are "tiny" numbers (25G @64B is about 3x that). What are
the packet sizes?
Perhaps the traffic generator is a limitation here?
Also feels like you are doing exact matches? A sample flower rule
would have helped.

cheers,
jamal
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>
> ---
>  include/net/pkt_cls.h | 5 +++++
>  net/core/dev.c        | 3 +++
>  2 files changed, 8 insertions(+)
>
> diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> index a4ee43f493bb..a065da4df7ff 100644
> --- a/include/net/pkt_cls.h
> +++ b/include/net/pkt_cls.h
> @@ -74,6 +74,11 @@ static inline bool tcf_block_non_null_shared(struct tc=
f_block *block)
>         return block && block->index;
>  }
>
> +static inline bool tcf_block_has_skip_sw_only(struct tcf_block *block)
> +{
> +       return block && atomic_read(&block->filtercnt) =3D=3D atomic_read=
(&block->skipswcnt);
> +}
> +
>  static inline struct Qdisc *tcf_block_q(struct tcf_block *block)
>  {
>         WARN_ON(tcf_block_shared(block));
> diff --git a/net/core/dev.c b/net/core/dev.c
> index d8dd293a7a27..7cd014e5066e 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3910,6 +3910,9 @@ static int tc_run(struct tcx_entry *entry, struct s=
k_buff *skb,
>         if (!miniq)
>                 return ret;
>
> +       if (tcf_block_has_skip_sw_only(miniq->block))
> +               return ret;
> +
>         tc_skb_cb(skb)->mru =3D 0;
>         tc_skb_cb(skb)->post_ct =3D false;
>         tcf_set_drop_reason(skb, *drop_reason);
> --
> 2.43.0
>

