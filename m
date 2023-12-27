Return-Path: <linux-kernel+bounces-12154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AD681F0AC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 18:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98326283AB3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8524643A;
	Wed, 27 Dec 2023 17:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="RbgWAKUF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE7745C0A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 17:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dbdb8e032f7so4265482276.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 09:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1703696581; x=1704301381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGGpmDyCOAVTfPuNyeaql2/nHGZzSIk1f0fzagp9sTE=;
        b=RbgWAKUFmDHOkoAFKurx+OYuL0dcskN7eTAQZ2pfoH15mz2grBFy81e791IqdWOi/d
         XA/mkaDbeMBoPXPywbESXtPvra4p0NGG7istnFBZgHR0zp/+t56Uhhvbf2GwIvH+cx+K
         Hsyq8TqJG9qgWdvVkaOl69OkDIL8SG0GQVSdK3XjUe4mG4lG4ZQLSaj+EcGwi3W1tA7d
         puNNWrFNQD0NUHE7vKFNkdmPgN/8BRxSZHgxn4uhrLtPiesz/iCgi223Q3ngTqCQ2yHz
         yCocBvHbJ5jR8tr2dzxdHwIJ9JKN/N6LUdYz0SmCtrIbyw/ZZnqbCS4fQkINOeQT2PqN
         7u8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703696581; x=1704301381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGGpmDyCOAVTfPuNyeaql2/nHGZzSIk1f0fzagp9sTE=;
        b=NtbZV/nUDHMxTbRpjue0KSovDtbLWG+45unVkm/CqdhLy/kNGOSXr+e8Y2e562ASFk
         Mw5T9mK0HPzKchkVbZo0KuYlSDXpoJvp7D2LAU1OlutOeESPlBNu/e1wotpCfnFQmgsV
         0nR4y+D9VUOWJRgA92E1pX7PLL8uSrRh641VNeIVSAsSs01og3ZrXGBIOqyM55VuTMEi
         Fw5E3d4Qm2hXBPy4VOdGcKpR8Zv0o5A4X6ZKc97400MW0gd4MPPCd5a1tvfQOOPevkz9
         hgelxCvlHGArfyXC7PvysiqUvyfRf34hWbF7WkjBcbIG046//I3vco9lvDx34RQ1OLkO
         tPLw==
X-Gm-Message-State: AOJu0YxsZ392WkBedhyKM62kCN5AtCak3vQO4RCOODlUMv8O3jPXFbZI
	1HDl4qOFCANqLqeRHwlLlfJth+nvJPFXUyXvbA3ehlsHCDrP
X-Google-Smtp-Source: AGHT+IHTvTD/jP8fxBI/SM3MB9o4zJ5KrqIwobuhiEM5CRa1hOMcDWlEB3sCgezF8eB8Yh4CNzmFkxw8iFwFY/KK4e4=
X-Received: by 2002:a5b:9d1:0:b0:db7:daec:ec5a with SMTP id
 y17-20020a5b09d1000000b00db7daecec5amr6380156ybq.33.1703696581102; Wed, 27
 Dec 2023 09:03:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231224165413.831486-1-linma@zju.edu.cn> <CAM0EoMm8F3UE3N-PBZmJHQpYYjiV23JKf6jGsvzzWs0PBd+AWQ@mail.gmail.com>
 <6aab36aa.56337.18ca3c6af7a.Coremail.linma@zju.edu.cn>
In-Reply-To: <6aab36aa.56337.18ca3c6af7a.Coremail.linma@zju.edu.cn>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 27 Dec 2023 12:02:49 -0500
Message-ID: <CAM0EoMmBp6SWDGhPkusnx0jh4y=1k9ggS+5UpV+0MtEccDgyXw@mail.gmail.com>
Subject: Re: [PATCH net v1] net/sched: cls_api: complement tcf_tfilter_dump_policy
To: Lin Ma <linma@zju.edu.cn>
Cc: xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 25, 2023 at 8:39=E2=80=AFPM Lin Ma <linma@zju.edu.cn> wrote:
>
> Hello Jamal,
>
> >
> > Can you clarify what "heap data leak" you are referring to?
> > As much as i can see any reference to NLA_TCA_CHAIN is checked for
> > presence before being put to use. So far that reason I  dont see how
> > this patch qualifies as "net". It looks like an enhancement to me
> > which should target net-next, unless i am missing something obvious.
> >
>
> Sure, thanks for your reply, (and merry Christmas :D).
> I didn't mention the detail as I consider the commit message in
> `5e2424708da7` could make a point. In short, the code
>
> ```
> if (tca[TCA_CHAIN] && nla_get_u32(tca[TCA_CHAIN])
> ```
>
> only checks if the attribute TCA_CHAIN exists but never checks about
> the attribute length because that attribute is parsed by the function
> nlmsg_parse_deprecated which will parse an attribute even not described
> in the given policy (here, the tcf_tfilter_dump_policy).
>
> Moreover, the netlink message is allocated via netlink_alloc_large_skb
> (see net/netlink/af_netlink.c) that does not clear out the heap buffer.
> Hence a malicious user could send a malicious TCA_CHAIN attribute here
> without putting any payload and the above `nla_get_u32` could dereference
> a dirty data that is sprayed by the user.
>
> Other place gets TCA_CHAIN with provide policy rtm_tca_policy that has a
> description.
>
> ```
> [TCA_CHAIN]             =3D { .type =3D NLA_U32 },
> ```
>
> and this patch aims to do so.
>
> Unfortunately, I have not opened the exploit for CVE-2023-3773
> (https://access.redhat.com/security/cve/cve-2023-3773) yet but the idea
> is similar and you can take it as an example.
>

Sorry, still trying to follow your reasoning that this is a "net issue":
As you point out, the skb will have enough space to carry the 32 bit
value. Worst case is we read garbage. And the dump, using this garbage
chain index,  will not find the chain or will find some unintended
chain. Am i missing something?

Can you send me a repro (privately) that actually causes the "heap
data leak" if you have one?

cheers,
jamal


> > cheers,
> > jamal
> >
>
> Regards
> Lin

