Return-Path: <linux-kernel+bounces-7245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5821E81A3B6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D9961F23632
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C6A41844;
	Wed, 20 Dec 2023 16:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="CWQyGDQn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0079841757
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 16:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dbd99c08cd6so931307276.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 08:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1703088367; x=1703693167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUS+E4b1XTZCpmipitw527bXQBzsOD2DIGTWW2tFCFk=;
        b=CWQyGDQn+lJCDeYr1Hn6nLkxnXv13IowwIqrEmUY6rA6ineq/Xk8e8+lawqh3X0Iil
         kaub0xMYIl0S58i+13UIXvMqkJd1sfzwQzeuoKMojeW6kNA2vijve46z3OJKWqY0lw4e
         Tiq/NzvpWGr1adoWnl+JW9aIpefrhivKJqOg+1sSYqAZYnUgDjwxSnx5IDjXrR/WlNda
         Qc9bkKBQ1+ujq6nA0ALvWtpJTSFKjheVLml7K+9tT+0YfynUsYjjvFjv2zUVfQImU6GR
         iPPmgrW0qgO4qLC/pHBeXPD7v2fTO8j59kIxmbj7it8Ce71PG0+SoQomzWjBHrgx5rkh
         VaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703088367; x=1703693167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gUS+E4b1XTZCpmipitw527bXQBzsOD2DIGTWW2tFCFk=;
        b=aVi4UlPKlHo4iDdcSH6qpiZ7T2xPErNkdX/j0yBPpft3DBMT2+86ZH8Q3SkCprHBgw
         t3UL7+HT/TVcYgEUpYmDKoKEiZoPFwa1U1ii9zrR2pX4TMDWAcvgSrri65/U/IH1EIbE
         uLigz/xQ7MGz5shMcE/giXVfy1ioAFfslOaVQtpsHmvhdzOg3yXLIyAOeMBKz88NsHcc
         rDmdmRc6pVpmhTvA/q+CVLLZ9lwB9QOP/BQ+hGxwZ1kkojCZS7jFYMOWlm9poEgCQsJ8
         4ATqYCpYBzE9izFGUuh+KLpIJNjx2x49KMR+wQfMkmU8LpygErYbLqocGOcqRDpo8u7B
         BlZw==
X-Gm-Message-State: AOJu0YxdBTPRz4Qp5ACAfwoHVR+EuGEzfNXQc1nM9vpexGViuBtyuUP2
	EOFSULq3oc3ozhacPyNs5sFEtupx7Kb7Hmy+x/eNfg==
X-Google-Smtp-Source: AGHT+IGbDlkYFm8oLQEkqQKyIalzbolHWzCjRd7CY6nZPCHGT9KC+dfOH9m39U4B3s0F708/DkKgGYPnkqhqQqA6+7M=
X-Received: by 2002:a05:6902:2681:b0:dbd:ae7d:ce7c with SMTP id
 dx1-20020a056902268100b00dbdae7dce7cmr809573ybb.67.1703088366833; Wed, 20 Dec
 2023 08:06:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220030838.11751-1-hbh25y@gmail.com> <CAM0EoMnPgKFK5uyx5YJUYc1F7U0058aYOQb6H6ewcz9Y8OouAw@mail.gmail.com>
In-Reply-To: <CAM0EoMnPgKFK5uyx5YJUYc1F7U0058aYOQb6H6ewcz9Y8OouAw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 20 Dec 2023 11:05:55 -0500
Message-ID: <CAM0EoM=4ZRteGbjAdBuLGtbM_qpnJoUuky-Yj+i+3FOqXXra+Q@mail.gmail.com>
Subject: Re: [PATCH] net: sched: em_text: fix possible memory leak in em_text_destroy()
To: Hangyu Hua <hbh25y@gmail.com>
Cc: xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, tgraf@suug.ch, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 6:55=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> Hi Hangyu,
> While the fix looks correct - can you please describe how you came
> across this issue? Was it a tool or by inspection? Do you have a text
> case that triggered something etc, etc.
>
> On Tue, Dec 19, 2023 at 10:09=E2=80=AFPM Hangyu Hua <hbh25y@gmail.com> wr=
ote:
> >
> > m->data needs to be freed when em_text_destroy is called.
> >
> > Fixes: d675c989ed2d ("[PKT_SCHED]: Packet classification based on texts=
earch (ematch)")
> > Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> > ---
> >  net/sched/em_text.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/sched/em_text.c b/net/sched/em_text.c
> > index 6f3c1fb2fb44..b9d5d4dca2c9 100644
> > --- a/net/sched/em_text.c
> > +++ b/net/sched/em_text.c
> > @@ -97,8 +97,10 @@ static int em_text_change(struct net *net, void *dat=
a, int len,
> >
> >  static void em_text_destroy(struct tcf_ematch *m)
> >  {
> > -       if (EM_TEXT_PRIV(m) && EM_TEXT_PRIV(m)->config)
> > +       if (EM_TEXT_PRIV(m) && EM_TEXT_PRIV(m)->config) {
> >                 textsearch_destroy(EM_TEXT_PRIV(m)->config);
> > +               kfree(m->data);
> > +       }
> >  }
> >
>

the bot just complained about needing a cast, use this:
struct text_match *

cheers,
jamal
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
>
> cheers,
> jamal
>
> >  static int em_text_dump(struct sk_buff *skb, struct tcf_ematch *m)
> > --
> > 2.34.1
> >

