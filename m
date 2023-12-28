Return-Path: <linux-kernel+bounces-12670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F285B81F8B5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 14:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED4E21C21DF8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 13:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800FF8472;
	Thu, 28 Dec 2023 13:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="XcWHpjiZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155C379E2
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 13:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5cece20f006so53411017b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 05:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1703769244; x=1704374044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7n5edAdKp2sw1VexxnRBg7C0RuN6uXmsbFRcdBd1nw=;
        b=XcWHpjiZ72Xqv9M8Q4rejHIMEs3yccZP5hmTcrYBO8xWMvRZCuGMW52VOvIZWUR7N2
         KyG+LTn1kiJo5XuDmM951mbb0/qewAqJVrOL2UEwTEJEkOkrv/YnEMFZdEDVzhfxkGaO
         iO/gn1SeUjacStqayhmTspn9LMpDMq74M9yUqYtKnkIPagD1rWgd5ZLdwKiNrXyKZ9hQ
         MFhUz5cWtQxJwuyXoEFa+YzEKiHtT7ZNGby3Okz58JWeMyg0zE65pNRFKWzWQIuPovgf
         Tl4/MLkrk7LcTA+IYKb5JeDfjdY6FB5bXrxJkGBnbahQqVd8N2NmaxC4AvKcmALOkALc
         hm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703769244; x=1704374044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g7n5edAdKp2sw1VexxnRBg7C0RuN6uXmsbFRcdBd1nw=;
        b=kfBUwWJXE6hlzx+ZBr6i9OmAnQ/nJXvtl409mxcgFfq4RbvM8Asbyj9Ij4n8CH80jf
         kKzhdUVxo9EEv/dfOL0P2A8dBm3XHkogB5GWYFSK+dnZ4mZxHO39bzaov52evSaUY7zO
         wowrifMWWFtNK4SNtFzfEQwwaBucxWtwgHJ76cE9JfeUPSRxxBuhlwIgyApw5kAHoodF
         53F8qocrmaHidoJU8lmqodXAFYr+MXUdicNtQugVmyg7+FPWuWzvbqGn1mU2/L49j5LU
         FfHTjNeFvBPjL2NUQxJd5UroSpzFsl0pdeWY15P28b4KKfZqRXsiSBRcmqYcxcF0Awde
         pNkQ==
X-Gm-Message-State: AOJu0YwMf9ZskBwnMZh4UV+RNRFGVqgpEK9cxMxwi7BzsUpIGD8g0nke
	xLg8mQrWOkXktes5GRMTaPZDxVh90/YF5dSjulbHaowAjGoB
X-Google-Smtp-Source: AGHT+IEvpcf3ph0FCh/as1QBcz6cCZaOokUNzWN5vXaOHCzDr32tNTP6Bo0dDisUpWXp/cuL8RewJyptMHvjCQRk/zM=
X-Received: by 2002:a81:4854:0:b0:5e8:2bd:9b96 with SMTP id
 v81-20020a814854000000b005e802bd9b96mr6056023ywa.17.1703769243836; Thu, 28
 Dec 2023 05:14:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228064358.3042747-1-linma@zju.edu.cn>
In-Reply-To: <20231228064358.3042747-1-linma@zju.edu.cn>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 28 Dec 2023 08:13:52 -0500
Message-ID: <CAM0EoM=2v9-_Y+aiOaMR8=uWnwn_nwOMrBJkP=4UGoKLJniC6g@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net/sched: cls_api: complement tcf_tfilter_dump_policy
To: Lin Ma <linma@zju.edu.cn>
Cc: xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 1:44=E2=80=AFAM Lin Ma <linma@zju.edu.cn> wrote:
>
> In function `tc_dump_tfilter`, the attributes array is parsed via
> tcf_tfilter_dump_policy which only describes TCA_DUMP_FLAGS. However,
> the NLA TCA_CHAIN is also accessed with `nla_get_u32`.
>
> The access to TCA_CHAIN is introduced in commit 5bc1701881e3 ("net:
> sched: introduce multichain support for filters") and no nla_policy is
> provided for parsing at that point. Later on, tcf_tfilter_dump_policy is
> introduced in commit f8ab1807a9c9 ("net: sched: introduce terse dump
> flag") while still ignoring the fact that TCA_CHAIN needs a check. This
> patch does that by complementing the policy to allow the access
> discussed here can be safe as other cases just choose rtm_tca_policy as
> the parsing policy.
>
> Signed-off-by: Lin Ma <linma@zju.edu.cn>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> ---
> V1 -> V2: send to net-next as told by Jamal <jhs@mojatatu.com>
>
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

