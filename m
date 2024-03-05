Return-Path: <linux-kernel+bounces-92034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 817B8871A03
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CFA2B21746
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3E5537E9;
	Tue,  5 Mar 2024 09:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMEGTLUf"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407DA4CB58
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 09:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709632485; cv=none; b=Ahxuch5pTR/NiQPDCM4hrO+zMW9MzP6iNKaNFWtMfcUivzcZJ6dIVRZ6wZg4DZbc4eM0NNol+6CNPMNaHiRvnf9mQO7Q27PF+dv2f6A9NL4FKjfND+u5zsv1ELt7eY8Iiemgy9oAtDX4SheYis+SNEhuCZVY5b6DDBzW959Ed38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709632485; c=relaxed/simple;
	bh=47NCv4b4YKpld9Q77z5G+GQ2iwWBK8k/m1TvXxBlivw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hrUAmZrbUoENDGcOI8NGP9oNWXPJWPRiYUoWBgz1s+fSsyEyfZqXyqQsijmPN6fh2jxecdTgPPEPoZaeM2Nmwn1b5a82iH8hh50UIa6sYwQjUWi/d0Gh2QV8/S9cJTUSObOa3BADvH4pdd4Tj/1J89nrkkDYWzVW0/W1zF649vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMEGTLUf; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4d346e4242fso1469673e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 01:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709632483; x=1710237283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YS8qRK8B84XP7qfihivOLSDD2qIA4ikJ3We6CAGKbW0=;
        b=RMEGTLUf8klNyQLjSqaNgr+/pIO0oL0c6aJYAPx6d47z3toE5FJ31xsiyrAThP7kjS
         QoL4c7XKCBwFa3bxmLrAKnlNtVocuZQbRYYTewozuCaHKqhzqitHR8ynOnoMnjJQid7I
         JRI/bDNoXkaa4SQ7BXoB5ABrDZLyycYDczYS+KbdsUiZ3VMSsfuKeW+xk8WglvggQmRf
         1ye9VOFAKEVSNWKxnDgKjjObnRFR2HPL23EnvIqVmd2VT1/mUcl/P0z7JoletaxLwQek
         KwvpSPHprmQp+uxLOLSqqcN1ZqGWWfwfICKtBabmR3IhHLSSP3/gu4EZjTVpB/gruYYb
         CkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709632483; x=1710237283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YS8qRK8B84XP7qfihivOLSDD2qIA4ikJ3We6CAGKbW0=;
        b=HkGrFQJelvbcwLU/wQUGmNvE7g5eLPl2zuK0SFTWeGPv4O0sOxrz+GpdH2YaAj2yzD
         5yVawG1Hu2n8XHmefVdXTVkUmbzAUDGDJk0y/G+JeYcgjr8nvZQ4os7gOTRWF20uRWYL
         1AJBN9+s/OwuQOLTkd8wPxggRjZ3oUOANw38IYUNNNzq+DcBdIjSCgNXLpUD59dqEWma
         N4eyVdPAG95eK5gOt5KB0jPMrCBEAs7ldFgbT27wjZaFuJIlqkV30JXMERp+AsadwWZM
         yI7OvCTiYtWAZsW++L5pMIuI5XC6t+kHpRXf9djAjL1KV/cIc23fUiAgke0MCQYfc8mx
         3mYg==
X-Forwarded-Encrypted: i=1; AJvYcCU9c/rCOmaKJsEbH0b+5+4zugdz7QFC82CBV4C7RPC8J4ZQuMlOfcq4QGR/w6DbWCE/v6syovKe0Ry2vgdqNidGa/8GA2P4tMR2v9+D
X-Gm-Message-State: AOJu0YyHGBoqUWscuViW/7up2Pa/xapTfBUZVeITV6251tjCclEVxkWM
	K++35CJuvFer4clEiQxi9Z3OoOn1u/kJvBuNUEoOpWlDBFtiViXj1RWqdpdssBGJXFrDWYlPsx5
	uaCiC6KGzjn+xznXVmhzyAc93/Mw=
X-Google-Smtp-Source: AGHT+IE6lY0tbo4eaweKeUvXZ+0W4OCGGRJA+YI52RdDKntZSVDadGeNgZdZjqT4do7AqL3FN/QwY6jIr18IjTQbXN0=
X-Received: by 2002:a05:6122:985:b0:4d1:3f59:5c79 with SMTP id
 g5-20020a056122098500b004d13f595c79mr1221720vkd.15.1709632483184; Tue, 05 Mar
 2024 01:54:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025144546.577640-5-ryan.roberts@arm.com> <20240205095155.7151-1-v-songbaohua@oppo.com>
 <d4f602db-403b-4b1f-a3de-affeb40bc499@arm.com> <CAGsJ_4wo7BiJWSKb1K_WyAai30KmfckMQ3-mCJPXZ892CtXpyQ@mail.gmail.com>
 <7061b9f4-b7aa-4dad-858c-53ee186c2d8f@arm.com>
In-Reply-To: <7061b9f4-b7aa-4dad-858c-53ee186c2d8f@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 5 Mar 2024 22:54:31 +1300
Message-ID: <CAGsJ_4w8YWMFjWu2i5NhbOA-pfemvzCHt4hB7rWiOpY63GVWSA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] mm: swap: Swap-out small-sized THP without splitting
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, mhocko@suse.com, shy828301@gmail.com, 
	wangkefeng.wang@huawei.com, willy@infradead.org, xiang@kernel.org, 
	ying.huang@intel.com, yuzhao@google.com, chrisl@kernel.org, surenb@google.com, 
	hanchuanhua@oppo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 10:00=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> Hi Barry,
>
> On 18/02/2024 23:40, Barry Song wrote:
> > On Tue, Feb 6, 2024 at 1:14=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.c=
om> wrote:
> >>
> >> On 05/02/2024 09:51, Barry Song wrote:
> >>> +Chris, Suren and Chuanhua
> >>>
> >>> Hi Ryan,
> [...]
> >>
> >
> > Hi Ryan,
> > I am running into some races especially while enabling large folio swap=
-out and
> > swap-in both. some of them, i am still struggling with the detailed
> > timing how they
> > are happening.
> > but the below change can help remove those bugs which cause corrupted d=
ata.
>
> I'm getting quite confused with all the emails flying around on this topi=
c. Here
> you were reporting a data corruption bug and your suggested fix below is =
the one
> you have now posted at [1]. But in the thread at [1] we concluded that it=
 is not
> fixing a functional correctness issue, but is just an optimization in som=
e
> corner cases. So does the corruption issue still manifest? Did you manage=
 to
> root cause it? Is it a problem with my swap-out series or your swap-in se=
ries,
> or pre-existing?

Hi Ryan,

It is not a problem of your swap-out series, but a problem of my swap-in
series. The bug in swap-in series is triggered by the skipped PTEs in the
thread[1], but my swap-in code should still be able to cope with this situa=
tion
and survive it -  a large folio might be partially but not completely unmap=
ped
after try_to_unmap_one(). I actually replied to you and explained all
the details here[2], but guess you missed it :-)

[1] https://lore.kernel.org/linux-mm/20240304103757.235352-1-21cnbao@gmail.=
com/
[2] https://lore.kernel.org/linux-mm/CAGsJ_4zdh5kOG7QP4UDaE-wmLFiTEJC2PX-_L=
xtOj=3DQrZSvkCA@mail.gmail.com/

apology this makes you confused.

>
> [1] https://lore.kernel.org/linux-mm/20240304103757.235352-1-21cnbao@gmai=
l.com/
>
> Thanks,
> Ryan
>

Thanks
Barry

