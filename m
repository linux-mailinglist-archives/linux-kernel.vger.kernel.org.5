Return-Path: <linux-kernel+bounces-69834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50702858F50
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C87DF1F2227F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 12:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5106A339;
	Sat, 17 Feb 2024 12:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="BMQgdtcd"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDB66A033
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 12:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708172300; cv=none; b=lXng+nS4rANmBbWRny4okJ95thIBEbydW93tZH1CwLHGZTxLTPswhkbpoibGMQZ2qW9VIFPHk4DlmaEnTqwv5tpiYQbwiHDVUv4vfhOocYZ4nPWn0vqtutUYCOE6WrpFxOFn4M6xAvawLAGzAWxoJgeBPqHWcmPzud17UFzZjEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708172300; c=relaxed/simple;
	bh=UKjxS5vpoedsgomMAJB5omeAKldlU4nDgXE0PfEP1jw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKpclUiZgXjzEk/cT+ZZoRYQsiO2zGdObG/iRap40zpjqY7VJbXV/+KRC8HIsozedu+HCEkrI0V5BJPpvOVrAjhSQrZHcrj9odD9PSQL+lt6YBteJSERGtS9ts1WE3etNc7FSwf+DYihGnk1er/1ujHImOfwYLhvLgPIPzQd/dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=BMQgdtcd; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc6d8bd618eso2658007276.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 04:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1708172297; x=1708777097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dakj+J26FIps8JKFMFOM1GnEisCAC0H9NUZsZ7rhH34=;
        b=BMQgdtcdSf3H47IUiwwr8HJdITWC+49arzOLMbs7H86dMe292pGsAe1MIa0AUnBVwM
         DuhuNq502KPZZv8CMl7yUXBDtARRAjeoAy1lcJgfEyCELvGZGRetVkArZBhV7q6iBE2u
         7pJfn4byabokQtnWB3leKjftoaiS7pM8m1rRWbqPWiNiYQqPiyPt81eDOFNDwjZ820Y4
         O7szF1vm/FwlNbhl4XML1+FzlV5Em0B2S+I7aeqR5eKAJc03ZTOqXlxNg1mki0Bbv3ti
         WOA1Lmc5YUvP2FhXI/WixBjj8vCgJG9SKvskt/Y0O4DQq2Q4OBdhIHYDTzhUIa39g3LV
         jlxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708172297; x=1708777097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dakj+J26FIps8JKFMFOM1GnEisCAC0H9NUZsZ7rhH34=;
        b=stwlTdGQFej3qtJYCsLOCKnowm1UIXQYFiY64XducgmKPj4SyoeT0POUDxVWtLXk+s
         8eL8ED8FZsrHsxbOdcRns6cFN8C6lL2GJSG59JSW62JxD7UAT7fQUJSURHBT4TgXSDyz
         s9NwEaqdq7c1WtEDJnrvVBAkdhUydEL9hOkCv30zyz+/JtbfmpHa4sBgxHS7ajViUvpp
         4efi1v70cfPJc7YKBG5vy8dj9f3tjjAlp8KMVnDG4KyOgftBl24B7415PYXKfDeT+cc6
         JtBsw4rwz9nEZ/KUHLGqOazod5FIyIhwRAat5vrLyDtX4X6uXPQ40w1CbcBTBHk9YWkf
         /YAg==
X-Forwarded-Encrypted: i=1; AJvYcCUe7vn4KpmTZOEtzvQnraifkkJVW3LHgepYhyMLnsCptU+/vJAfBwsDBhe87Ify/Ty3LWRjKHh6jkOKBDXOgs5QBZHD1KNFN6AbdzsN
X-Gm-Message-State: AOJu0YwYQ/AWsQ3JDOxhFbZo1BmRo2GPvRIDlNTg8+ahmfVbf4F3tMgR
	KZjcrmq5JIvw10tQipVlCYSyb7xilU+7YudJxj8VkJKJEC1/PfdOSqNd9mm083GRR6oGABG6Dzl
	CV5VtKsAvuMWT9t0yIF/oPzN9Od9Va4sxmL+U
X-Google-Smtp-Source: AGHT+IEYHTeRxmK8Tgb29GhppupMJ2XDrsJxJTUarro8uv3qP63OjBIOPHkVh7dMXpiawqTtzwrBAlosTJQ5VBj7vcw=
X-Received: by 2002:a25:adc9:0:b0:dcd:63f8:ba32 with SMTP id
 d9-20020a25adc9000000b00dcd63f8ba32mr6963090ybe.65.1708172297594; Sat, 17 Feb
 2024 04:18:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216232744.work.514-kees@kernel.org> <9ed28341-8bf7-4b6a-ba9a-6cfe07dc5964@embeddedor.com>
In-Reply-To: <9ed28341-8bf7-4b6a-ba9a-6cfe07dc5964@embeddedor.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 17 Feb 2024 07:18:06 -0500
Message-ID: <CAM0EoMnDHDGao6NToo5WcT16GZCyQ_SR8aXQ3AXmJFYaWoqv1A@mail.gmail.com>
Subject: Re: [PATCH] net: sched: Annotate struct tc_pedit with __counted_by
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Kees Cook <keescook@chromium.org>, Jakub Kicinski <kuba@kernel.org>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, netdev@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 7:04=E2=80=AFPM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
>
>
> On 2/16/24 17:27, Kees Cook wrote:
> > Prepare for the coming implementation by GCC and Clang of the __counted=
_by
> > attribute. Flexible array members annotated with __counted_by can have
> > their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOU=
NDS
> > (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-famil=
y
> > functions).
> >
> > As found with Coccinelle[1], add __counted_by for struct tc_pedit.
> > Additionally, since the element count member must be set before accessi=
ng
> > the annotated flexible array member, move its initialization earlier.
> >
> > Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/exampl=
es/counted_by.cocci [1]
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> > Cc: Cong Wang <xiyou.wangcong@gmail.com>
> > Cc: Jiri Pirko <jiri@resnulli.us>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: netdev@vger.kernel.org
> > Cc: linux-hardening@vger.kernel.org
>
> `opt->nkeys` updated before `memcpy()`, looks good to me:
>
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Looks good to me.
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> Thanks!
> --
> Gustavo
>
> > ---
> >   include/uapi/linux/tc_act/tc_pedit.h | 2 +-
> >   net/sched/act_pedit.c                | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/uapi/linux/tc_act/tc_pedit.h b/include/uapi/linux/=
tc_act/tc_pedit.h
> > index f3e61b04fa01..f5cab7fc96ab 100644
> > --- a/include/uapi/linux/tc_act/tc_pedit.h
> > +++ b/include/uapi/linux/tc_act/tc_pedit.h
> > @@ -62,7 +62,7 @@ struct tc_pedit_sel {
> >       tc_gen;
> >       unsigned char           nkeys;
> >       unsigned char           flags;
> > -     struct tc_pedit_key     keys[0];
> > +     struct tc_pedit_key     keys[] __counted_by(nkeys);
> >   };
> >
> >   #define tc_pedit tc_pedit_sel
> > diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> > index 2ef22969f274..21e863d2898c 100644
> > --- a/net/sched/act_pedit.c
> > +++ b/net/sched/act_pedit.c
> > @@ -515,11 +515,11 @@ static int tcf_pedit_dump(struct sk_buff *skb, st=
ruct tc_action *a,
> >               spin_unlock_bh(&p->tcf_lock);
> >               return -ENOBUFS;
> >       }
> > +     opt->nkeys =3D parms->tcfp_nkeys;
> >
> >       memcpy(opt->keys, parms->tcfp_keys,
> >              flex_array_size(opt, keys, parms->tcfp_nkeys));
> >       opt->index =3D p->tcf_index;
> > -     opt->nkeys =3D parms->tcfp_nkeys;
> >       opt->flags =3D parms->tcfp_flags;
> >       opt->action =3D p->tcf_action;
> >       opt->refcnt =3D refcount_read(&p->tcf_refcnt) - ref;

