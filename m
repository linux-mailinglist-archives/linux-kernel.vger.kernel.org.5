Return-Path: <linux-kernel+bounces-11186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC09081E2EC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C56F62825A9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 23:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3982207B;
	Mon, 25 Dec 2023 23:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="jG7OVV88"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6F61EB2D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 23:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-da7ea62e76cso3047058276.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 15:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1703545466; x=1704150266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SgsWbYJzU0bg8sCq7jflJ+MhyDFskXV4wMBcQPJnz0=;
        b=jG7OVV883Ms6x3AedPFjn5CAnm+SU1oHkUtoalDJA7tdshpYApKV+tLaBkyMy0romm
         an9bOd9c2dhnuUZyPha5rKaDLjj+zrGhBpDRw+5AiIZMKimTkU7qv/j+lK+ycGZfd/vS
         rt31pMfaci/0jzEeoMWHrHWDwhsuyhlW9L0qhQ4EIilTmpyG+tzEGlE/8bbelqNyNiNR
         0IiOLwk5xI30Ma9jUCD+N230+acxLXxj0KAM16n2WJzsnhdgZTqhwDSRciC1GJzQ57vw
         Ugh+61F5Orb8JEFPPfnGIeGdHcl0n/cLFkORZ+V2qjAXmmqnd8jzOuDh2ZWmg5MAN7Zz
         t7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703545466; x=1704150266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/SgsWbYJzU0bg8sCq7jflJ+MhyDFskXV4wMBcQPJnz0=;
        b=L7Ri5Kt/gD2b61LmGodwWJy6WIv47AQTjtHDt01pzj11vPg8lLAC577x4ggYo3x2IN
         R15uAMh2qFfchp1A2qNuCHcfmEjk7s3uiOdshHQN+p+Pajp4GH+Zby4EGLluLpiFZ+qr
         rPEui6zEYCupt8s6kr5bdCKKVAErUGmjVLR+U6T8faBZWBDbsG4k5HnZJUcF5ua/wqSx
         rdJOBqoKQpdtk3ffpGXFIYktAr7Yc2L6NYrxQi5cpuSOXUs6EkGuVAfMPRVYKCbvXFbb
         FPeYPT+7nlacEy69ee5vi3hyARoRCmYPzyzmQCJphooiKaLGBEhloyGWRLK6p7arh2uO
         tneQ==
X-Gm-Message-State: AOJu0YwfnO87nOsW4IR8bAJdHC0XgdrKNqoLtA5Fis9+bzmDGpJAV1PC
	JvkuDrfakomXyuQsEi3kXOd3McXyCrJMUe4aYDHqCqQuChy6
X-Google-Smtp-Source: AGHT+IHkgMadWpG2pFbQX6OW2/hvsLmzcv0W5eYi8Bz8c4S0MtIVWop5axHD8jAuetaOK/9LTGwjQEk9wdtEVecMQdw=
X-Received: by 2002:a81:8641:0:b0:5d7:1941:aac with SMTP id
 w62-20020a818641000000b005d719410aacmr3580928ywf.71.1703545465934; Mon, 25
 Dec 2023 15:04:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231224165413.831486-1-linma@zju.edu.cn>
In-Reply-To: <20231224165413.831486-1-linma@zju.edu.cn>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 25 Dec 2023 18:04:14 -0500
Message-ID: <CAM0EoMm8F3UE3N-PBZmJHQpYYjiV23JKf6jGsvzzWs0PBd+AWQ@mail.gmail.com>
Subject: Re: [PATCH net v1] net/sched: cls_api: complement tcf_tfilter_dump_policy
To: Lin Ma <linma@zju.edu.cn>
Cc: xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Dec 24, 2023 at 11:54=E2=80=AFAM Lin Ma <linma@zju.edu.cn> wrote:
>
> In function `tc_dump_tfilter`, the attributes array is parsed via
> tcf_tfilter_dump_policy which only describes TCA_DUMP_FLAGS. However,
> the NLA TCA_CHAIN is also accessed with `nla_get_u32`. According to the
> commit 5e2424708da7 ("xfrm: add forgotten nla_policy for
> XFRMA_MTIMER_THRESH"), such a missing piece could lead to a potential
> heap data leak.
>

Can you clarify what "heap data leak" you are referring to?
As much as i can see any reference to NLA_TCA_CHAIN is checked for
presence before being put to use. So far that reason I  dont see how
this patch qualifies as "net". It looks like an enhancement to me
which should target net-next, unless i am missing something obvious.

cheers,
jamal

> The access to TCA_CHAIN is introduced in commit 5bc1701881e3 ("net:
> sched: introduce multichain support for filters") and no nla_policy is
> provided for parsing at that point. Later on, tcf_tfilter_dump_policy is
> introduced in commit f8ab1807a9c9 ("net: sched: introduce terse dump
> flag") while still ignoring the fact that TCA_CHAIN needs a check. This
> patch does that by complementing the policy.
>
> Note that other functions that access TCA_CHAIN, like tc_new_tfilter,
> are not vulnerable as they choose rtm_tca_policy as the parsing policy
> which describes the TCA_CHAIN already.
>
> Fixes: 5bc1701881e3 ("net: sched: introduce multichain support for filter=
s")
> Signed-off-by: Lin Ma <linma@zju.edu.cn>
> ---
>  net/sched/cls_api.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index 1976bd163986..2b5b8eca2ee3 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -2732,6 +2732,7 @@ static bool tcf_chain_dump(struct tcf_chain *chain,=
 struct Qdisc *q, u32 parent,
>  }
>
>  static const struct nla_policy tcf_tfilter_dump_policy[TCA_MAX + 1] =3D =
{
> +       [TCA_CHAIN]      =3D { .type =3D NLA_U32 },
>         [TCA_DUMP_FLAGS] =3D NLA_POLICY_BITFIELD32(TCA_DUMP_FLAGS_TERSE),
>  };
>
> --
> 2.17.1
>

