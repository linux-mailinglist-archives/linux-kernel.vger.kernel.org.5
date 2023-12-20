Return-Path: <linux-kernel+bounces-6853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E14FF819E87
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EE65288F34
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C914922095;
	Wed, 20 Dec 2023 11:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="B0H2/WoA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED7221A01
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 11:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5e266e8d39eso46611237b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 03:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1703073350; x=1703678150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVxwZzh3h8pxKjMB9TUAJZ3olyNLTLH6W0HgoN2vba8=;
        b=B0H2/WoA6Hq4tMRc01Xe9xhHEET6KKjP2BYrYbBBeK3ZiQZvFWZjpUXAI7TKq1V39B
         e8XTfLwHotqK4RC4px8n23gW5BP0sv7Hlcuythrn3c5GsZUqOG5qyqc1BozQTz0FIdh3
         FTf4VBQ4CKYjGMMSD3IIkaMSTRbO296Oi/faUQUMLSlDov5VyvERHB1t5O2RkeGo5ayJ
         ENqSkue97pQWL7Oar6rTYE7+Igi2780pDsnfGQ2Aqta8qjuCHPVZ3doGS9e26VLww6/j
         H7PBioOWRMfWqXK1NEnAMeE3e2YUuAQKjva8yHFMYRVSIt7VzWDe+M016zMhLX2CQahV
         UpTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703073350; x=1703678150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVxwZzh3h8pxKjMB9TUAJZ3olyNLTLH6W0HgoN2vba8=;
        b=g+QWuozQdMzbuo+XkG3M9N6iBGRK7HRQv+jb2/l7wfB7duk9QhTYoRf9W/0yLThgtH
         xx0x8cKYTTxKP6bi9qX1Vmsj+bj4EuKOTJby2XTPOjXqzcIUchDhtbYgj9Bi6GbmOeSt
         7swNaiIG04sNxfTWAikbEM3OzaApWKjVmc2/8BEZWmYlVgqOeCnntDET9ZpGp6XoNL1I
         tDz7wAThAhdZzJ05otu3AVBKoaLArRMXGzdlaWYFumQb4+RZPKn6U7LVIaPKBaMSjqTK
         iWLfQC9iYjQgKF4toHbeHPVVcWbcsI9mOtPk2TaZdKXVmwcJrJRK709b/psCBrt5E9L8
         3kjw==
X-Gm-Message-State: AOJu0YxkFezwuYIa6sKwN32FxndUR6ETLFTMB6BCzcpEqj1zxSLic5hS
	odUqGa2ZKGE4z60aeHVq/Qyzvz64oBEY0vvJRtEhCA==
X-Google-Smtp-Source: AGHT+IGOW+SV5K5m9bPxErTANDh8XRIFC7EduXz5gquRokcNDd6fBZ1eHUOKXvRhGx3ktSahT3bAbs5qdGRIBJkmggg=
X-Received: by 2002:a05:690c:c86:b0:5df:4992:d6f0 with SMTP id
 cm6-20020a05690c0c8600b005df4992d6f0mr15266979ywb.6.1703073350500; Wed, 20
 Dec 2023 03:55:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220030838.11751-1-hbh25y@gmail.com>
In-Reply-To: <20231220030838.11751-1-hbh25y@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 20 Dec 2023 06:55:39 -0500
Message-ID: <CAM0EoMnPgKFK5uyx5YJUYc1F7U0058aYOQb6H6ewcz9Y8OouAw@mail.gmail.com>
Subject: Re: [PATCH] net: sched: em_text: fix possible memory leak in em_text_destroy()
To: Hangyu Hua <hbh25y@gmail.com>
Cc: xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, tgraf@suug.ch, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hangyu,
While the fix looks correct - can you please describe how you came
across this issue? Was it a tool or by inspection? Do you have a text
case that triggered something etc, etc.

On Tue, Dec 19, 2023 at 10:09=E2=80=AFPM Hangyu Hua <hbh25y@gmail.com> wrot=
e:
>
> m->data needs to be freed when em_text_destroy is called.
>
> Fixes: d675c989ed2d ("[PKT_SCHED]: Packet classification based on textsea=
rch (ematch)")
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> ---
>  net/sched/em_text.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/sched/em_text.c b/net/sched/em_text.c
> index 6f3c1fb2fb44..b9d5d4dca2c9 100644
> --- a/net/sched/em_text.c
> +++ b/net/sched/em_text.c
> @@ -97,8 +97,10 @@ static int em_text_change(struct net *net, void *data,=
 int len,
>
>  static void em_text_destroy(struct tcf_ematch *m)
>  {
> -       if (EM_TEXT_PRIV(m) && EM_TEXT_PRIV(m)->config)
> +       if (EM_TEXT_PRIV(m) && EM_TEXT_PRIV(m)->config) {
>                 textsearch_destroy(EM_TEXT_PRIV(m)->config);
> +               kfree(m->data);
> +       }
>  }
>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

>  static int em_text_dump(struct sk_buff *skb, struct tcf_ematch *m)
> --
> 2.34.1
>

