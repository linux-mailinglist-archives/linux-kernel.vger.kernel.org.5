Return-Path: <linux-kernel+bounces-68781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0223685802C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABFC52825A8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF9612F581;
	Fri, 16 Feb 2024 15:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ezh8ad/P"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BED12F366
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 15:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096070; cv=none; b=tqrvsbSnlrwFouEdOIbPiRj54f5L2/nroAc8hzUkr6PrCSMxjB1/NAqp9AYtgfZcOKPcvt90YmwN9eCXosQgiMc33CKtkgVfQLyWSsaVJyaFX9/sW+9m5cHQZJpOfBJXidneuUflPTrdtf6s3T5veJFXSbZTrI1KQIeFZ/oJuAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096070; c=relaxed/simple;
	bh=dz57b6MPs4sjkEZDmmbKb7QUqIItUq3KGAxEbVI0qFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s7EakeSZRG0GHs0rhV2+e8OjlXm/6QNugM8WfjkBsUK5Gq9ow0RkLTTtSoo84Vt3SvMxM1tbeCRJJN8RSxhxfIwdGdngFx9M22LmaIdC3Y+Fbq31mb5mKO+OQuCQAaijlCiaLLWKklPaPDUSAZYyg4vYfedfRemGZnr223gNLLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=ezh8ad/P; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6078c4cadd7so20950257b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 07:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1708096066; x=1708700866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jABSvVFdybJnwFndUwOT4Ar5XFTLlUPXCxtIkhAdQUc=;
        b=ezh8ad/PZL8wcDMUYIoqRkQBVkl/aSQYKRcX41mw12cpmZfCKtTcWzy553N08pmnB0
         UtVBtswheddEUen7QKakG+mdEyBe7Rx9DK0Podh0iIvf7ahwva2SMldmz7sqCzqcWFMd
         Tt+6ebqpY5OrSqi5b+RsgHkLL3/jxyWbeSBu+wdxaEQja4sFmmUKTEzTexS0ckDScAnM
         9YUksyzQCnRpOgaziSLG2h5RbJmSsHk1KK9s0QPaLC76kZGtF+6r57yeAO7Srl4Lj243
         07Ho8KDSdHgH4oqi1jpG1IOuXEbg7lDmhB0tuDIZji+wHNdDebP8WeTks/JVbTd+29lx
         3lfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708096066; x=1708700866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jABSvVFdybJnwFndUwOT4Ar5XFTLlUPXCxtIkhAdQUc=;
        b=nrhY1KU4qN2XMMzOzOKieHp+gzNQE5tfVjhTaqwcsiAIEV7CFO8hgjWQ+my4dOuOCD
         GSETZusaaQQ6AsS4bmRAufGxOBn7ZPQW4hR36/dPZPuKdPksL65byvaRAZ1AWw7HzcQG
         U3AGcXAVeVgOkJP+aDDRgoXPo8UN8dnNQqbnc+/uw0ZKmCWWrPdRTlzfuHRYzluc6oz/
         U7r6r3QBv0lkcMj3NOk1VVlteHGiVFA6dG+U4w/xA1y5lx3ghYZmMAr7vxKDDYNDMkQ9
         QDpcWclTs9EnZAgpWBoOK1xyXZTnGrlL3dMqCV11WAn25TlpKmfYK/5OhevcgleHr4j5
         HK9g==
X-Forwarded-Encrypted: i=1; AJvYcCXEXB2B0+plTIoxywumFMSsd1mTX76hM7CQ2EOumtpj565JoXN4ksiIG50+PrIMUDQO4bvZx0G/DOD/l0DlI7sK2vV2Y6lksn2atQSp
X-Gm-Message-State: AOJu0YwpZuuMX3qghW6bhZw7PSmZrYoRRIAbOjIuSlNL4eompa4T8vsp
	ZeBQyE8YY2TAkw7snyBZDGLR97caz21qjwpJaLisHgnEykGohqTBAb4LfAJVu8okv3l+E0jP78U
	JcIdqfvWy6CW0EZ7iLA2Viw6yiw9ohA1jmla4
X-Google-Smtp-Source: AGHT+IH3Q1PhMiM2GSdEx5fJpTkjVFwL8omSuJrobSp1jQ0+iYRdL0Z4f0YYJ0+1/K8H/u7Bqh2bNCmwsszRw53c5XA=
X-Received: by 2002:a81:b041:0:b0:604:df1e:41ee with SMTP id
 x1-20020a81b041000000b00604df1e41eemr5087014ywk.46.1708096065912; Fri, 16 Feb
 2024 07:07:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215160458.1727237-1-ast@fiberby.net> <20240215160458.1727237-4-ast@fiberby.net>
 <CAM0EoMmyGwA9Q=RibR+Fc41_dPZyhBRWiBEejSbPsS9NhaUFVQ@mail.gmail.com> <Zc9bw8eHa5z_xh6Y@nanopsycho>
In-Reply-To: <Zc9bw8eHa5z_xh6Y@nanopsycho>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 16 Feb 2024 10:07:34 -0500
Message-ID: <CAM0EoMngVoBcbX7cqTdbW8dG1v_ysc1SZK+4y-9j-5Tbq6gaYw@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: sched: make skip_sw actually skip software
To: Jiri Pirko <jiri@resnulli.us>
Cc: =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llu@fiberby.dk, Vlad Buslov <vladbu@nvidia.com>, 
	Marcelo Ricardo Leitner <mleitner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 7:57=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Thu, Feb 15, 2024 at 06:49:05PM CET, jhs@mojatatu.com wrote:
> >On Thu, Feb 15, 2024 at 11:06=E2=80=AFAM Asbj=C3=B8rn Sloth T=C3=B8nnese=
n <ast@fiberby.net> wrote:
> >>
> >> TC filters come in 3 variants:
> >> - no flag (no opinion, process wherever possible)
> >> - skip_hw (do not process filter by hardware)
> >> - skip_sw (do not process filter by software)
> >>
> >> However skip_sw is implemented so that the skip_sw
> >> flag can first be checked, after it has been matched.
> >>
> >> IMHO it's common when using skip_sw, to use it on all rules.
> >>
> >> So if all filters in a block is skip_sw filters, then
> >> we can bail early, we can thus avoid having to match
> >> the filters, just to check for the skip_sw flag.
> >>
> >>  +----------------------------+--------+--------+--------+
> >>  | Test description           | Pre    | Post   | Rel.   |
> >>  |                            | kpps   | kpps   | chg.   |
> >>  +----------------------------+--------+--------+--------+
> >>  | basic forwarding + notrack | 1264.9 | 1277.7 |  1.01x |
> >>  | switch to eswitch mode     | 1067.1 | 1071.0 |  1.00x |
> >>  | add ingress qdisc          | 1056.0 | 1059.1 |  1.00x |
> >>  +----------------------------+--------+--------+--------+
> >>  | 1 non-matching rule        |  927.9 | 1057.1 |  1.14x |
> >>  | 10 non-matching rules      |  495.8 | 1055.6 |  2.13x |
> >>  | 25 non-matching rules      |  280.6 | 1053.5 |  3.75x |
> >>  | 50 non-matching rules      |  162.0 | 1055.7 |  6.52x |
> >>  | 100 non-matching rules     |   87.7 | 1019.0 | 11.62x |
> >>  +----------------------------+--------+--------+--------+
> >>
> >> perf top (100 n-m skip_sw rules - pre patch):
> >>   25.57%  [kernel]  [k] __skb_flow_dissect
> >>   20.77%  [kernel]  [k] rhashtable_jhash2
> >>   14.26%  [kernel]  [k] fl_classify
> >>   13.28%  [kernel]  [k] fl_mask_lookup
> >>    6.38%  [kernel]  [k] memset_orig
> >>    3.22%  [kernel]  [k] tcf_classify
> >>
> >> perf top (100 n-m skip_sw rules - post patch):
> >>    4.28%  [kernel]  [k] __dev_queue_xmit
> >>    3.80%  [kernel]  [k] check_preemption_disabled
> >>    3.68%  [kernel]  [k] nft_do_chain
> >>    3.08%  [kernel]  [k] __netif_receive_skb_core.constprop.0
> >>    2.59%  [kernel]  [k] mlx5e_xmit
> >>    2.48%  [kernel]  [k] mlx5e_skb_from_cqe_mpwrq_nonlinear
> >>
> >
> >The concept makes sense - but i am wondering when you have a mix of
> >skip_sw and skip_hw if it makes more sense to just avoid looking up
> >skip_sw at all in the s/w datapath? Potentially by separating the
> >hashes for skip_sw/hw. I know it's a deeper surgery - but would be
>
> Yeah, there could be 2 hashes: skip_sw/rest
> rest is the only one that needs to be looked-up in kernel datapath.
> skip_sw is just for control path.
>
> But is it worth the efford? I mean, since now, nobody seemed to care. If
> this patchset solves the problem for this usecase, I think it is enough.
>

May not be worth the effort - and this is a reasonable use case. The
approach is a hack nonetheless and kills at least some insects. To
address the issues Vlad brought up, perhaps we should wrap it under
some kconfig.

cheers,
jamal

> In that case, I'm fine with this patch:
>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>
>
>
> >more general purpose....unless i am missing something
> >
> >> Test setup:
> >>  DUT: Intel Xeon D-1518 (2.20GHz) w/ Nvidia/Mellanox ConnectX-6 Dx 2x1=
00G
> >>  Data rate measured on switch (Extreme X690), and DUT connected as
> >>  a router on a stick, with pktgen and pktsink as VLANs.
> >>  Pktgen was in range 12.79 - 12.95 Mpps across all tests.
> >>
> >
> >Hrm. Those are "tiny" numbers (25G @64B is about 3x that). What are
> >the packet sizes?
> >Perhaps the traffic generator is a limitation here?
> >Also feels like you are doing exact matches? A sample flower rule
> >would have helped.
> >
> >cheers,
> >jamal
> >> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>
> >> ---
> >>  include/net/pkt_cls.h | 5 +++++
> >>  net/core/dev.c        | 3 +++
> >>  2 files changed, 8 insertions(+)
> >>
> >> diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> >> index a4ee43f493bb..a065da4df7ff 100644
> >> --- a/include/net/pkt_cls.h
> >> +++ b/include/net/pkt_cls.h
> >> @@ -74,6 +74,11 @@ static inline bool tcf_block_non_null_shared(struct=
 tcf_block *block)
> >>         return block && block->index;
> >>  }
> >>
> >> +static inline bool tcf_block_has_skip_sw_only(struct tcf_block *block=
)
> >> +{
> >> +       return block && atomic_read(&block->filtercnt) =3D=3D atomic_r=
ead(&block->skipswcnt);
> >> +}
> >> +
> >>  static inline struct Qdisc *tcf_block_q(struct tcf_block *block)
> >>  {
> >>         WARN_ON(tcf_block_shared(block));
> >> diff --git a/net/core/dev.c b/net/core/dev.c
> >> index d8dd293a7a27..7cd014e5066e 100644
> >> --- a/net/core/dev.c
> >> +++ b/net/core/dev.c
> >> @@ -3910,6 +3910,9 @@ static int tc_run(struct tcx_entry *entry, struc=
t sk_buff *skb,
> >>         if (!miniq)
> >>                 return ret;
> >>
> >> +       if (tcf_block_has_skip_sw_only(miniq->block))
> >> +               return ret;
> >> +
> >>         tc_skb_cb(skb)->mru =3D 0;
> >>         tc_skb_cb(skb)->post_ct =3D false;
> >>         tcf_set_drop_reason(skb, *drop_reason);
> >> --
> >> 2.43.0
> >>

