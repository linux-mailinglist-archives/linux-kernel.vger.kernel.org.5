Return-Path: <linux-kernel+bounces-112379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B2B88791F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 15:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF9341C20DB4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 14:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EACE405F9;
	Sat, 23 Mar 2024 14:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3p6ufTK"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF813A1A3;
	Sat, 23 Mar 2024 14:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711204815; cv=none; b=sOYlk3Sz05umFTtPhGKz2IzepUHnKxLeBF7RYKgzwm+B20C9Y17iUXyiKCj3YMPHMF+nQsP2k1kZMgntmxdyYwBv9DZHq5j8D8UDvEgllu+D1Hy0qwB0tM+lseQUnh5CryEEVhAY3eXK7Zc8VdTax7LbXqeoTuvlU5bbKA4Qqgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711204815; c=relaxed/simple;
	bh=LIfguKYB9Djf8kpPD3j30oGbgEFgX97d18NhdYb5nko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PN5lU0qARbnAEgTy1zqUwEY9GPSdVEYanrfnpEKXa5LC5Df6htx39YSTtss8C5RVVfVV30iTX17T000g8kSMswhHBJ9KXKlHPAfv255A+TDUchm3oI0XfkH3aGYSXo6Ydb+bKYp6zxK+TtpYDdhFOEGXwYZOdmWSN+MBgAkPrr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3p6ufTK; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e0878b76f3so12820105ad.0;
        Sat, 23 Mar 2024 07:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711204813; x=1711809613; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOjc2RPnmpiTXzEKcY++5BWeNTp0iE6fQolvtms4FQ8=;
        b=D3p6ufTKYnYztabs4fVEtKohgqXCwBmAAlUdEAVydfxLz7inFwGVIFSj9PSr2dOTps
         3i982m/rGPZQUOxqwxSAwBPA4jnrk4VEcrJfMr/X0JSvylRUWufoo7qTBS0AL9QUNuGp
         1r8SyQupkaM7DQ7l+GRm1TF2PGixFYuAvIhjcAkNzwqi/Y19PqpbwMxpwQ6qcO/lO5aW
         xv63yfIouKPKSrKowneMr6g+XVTR8PNAME8CEUMjUx8mhOfXhfxxXVPJJxlfIuSuVRR8
         OIjki+lhzL5trO+DP9k7pHnMVcyU1y32Aj+p+53nxeISC2hd+2wszjbiJ2WDEnDHmmr1
         WrbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711204813; x=1711809613;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rOjc2RPnmpiTXzEKcY++5BWeNTp0iE6fQolvtms4FQ8=;
        b=qlBPCEt05wbEKdUs6ESeBxzhNqe0VaK/t8RkyS9oWb3hKA1iNCDEszs83PYYJuanDK
         DWI73q3CQgLG7WGiQ298/0MG9VCR8iGWflLjuOZc+pVa+UEqC7+xHZlLxokvxtPP1cOt
         FuQyAJBREDeeoTWoQMGSN454lOdPbQmv4RofGmt4+mEtOVgFKWYC0cbFfZPXWFeVepdt
         6H7RTKxwnShj31Py/EH4mS91soWigVW/cZEh46nKG1omhfsKDlumdQNV8JeS7hCcSRz9
         expE8LROpPLjrh+lyG5k4NC3AN57B7dkd4RglB8FERhRQ11Z3c7Lb2LwzP2x7rF7W1KO
         GHVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7Y04vosV12m/ZUupGvAAjbgGgyLjO0qmMyO/6T1w8bXpqA4SHnXYUC1fScxZuv9+Y1gXUcc8RfXiw6G7QGaY6HDVjjyVwJNDYy3u5d6FzZijf+ccbhOTcHj61anMtfXOV
X-Gm-Message-State: AOJu0YyEBtywMj+3wxc9nXPfJZ5bgoghM+RA5QOrMxatz+uq8tBWZRCG
	psHF4QDb77fQ/rZLWGoJC0H4Mndwu7t+viNVHA8iNMfwBxEt562U
X-Google-Smtp-Source: AGHT+IH2QWiWWMKVd2VZ9/ojjVulzuuqr43nRxs9SFWCgDsm058vFxAPkDMrC+pBYKAnDZ3h6D/ZoQ==
X-Received: by 2002:a17:903:234b:b0:1e0:2bce:d7e6 with SMTP id c11-20020a170903234b00b001e02bced7e6mr2624148plh.32.1711204812727;
        Sat, 23 Mar 2024 07:40:12 -0700 (PDT)
Received: from [192.168.2.64] ([60.163.62.105])
        by smtp.gmail.com with ESMTPSA id s14-20020a170902b18e00b001def0c700e2sm1631450plr.119.2024.03.23.07.40.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Mar 2024 07:40:12 -0700 (PDT)
Message-ID: <d3677b19-63fa-4787-8d5b-468ddbad173a@gmail.com>
Date: Sat, 23 Mar 2024 22:40:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libbpf: add specific btf name info when do core
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240321170444.388225-1-chen.dylane@gmail.com>
 <CAEf4BzYJeEViQaRJb6u06GJSLa6uBmykRZa4JnWJ9VXw+WoX2g@mail.gmail.com>
 <f5fe3709-bfc8-4906-a0cc-5fe9b388be6b@gmail.com>
 <CAEf4Bzb-Wf5sTnDLu29KQ-zWfCnffdUZYLSe_tQTNW_bTSfnPg@mail.gmail.com>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <CAEf4Bzb-Wf5sTnDLu29KQ-zWfCnffdUZYLSe_tQTNW_bTSfnPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Got it, thanks for your detailed reply.

在 2024/3/23 上午1:57, Andrii Nakryiko 写道:
> On Fri, Mar 22, 2024 at 6:37 AM Tao Chen <chen.dylane@gmail.com> wrote:
>>
>> Hi, Nakryiko, thank you for your reply. I try to familiarize with core
>> in libbpf， the debug info is really helpful for me. But i use the old
>> kernel btf, so origion debuginfo like:
>>    struct task_struct___x: found target candidate [130] struct
>> task_struct in [vmlinux]
> 
> the idea here is to not emit path to BTF (otherwise we normally should
> emit [/sys/kernel/btf/vmlinux], but rather distinguish whether it's a
> kernel BTF ([vmlinux]) or some kernel module BTF ([<module-name>]).
> 
> In your case you are overriding vmlinux BTF by using btf_custom_path
> option (so you should know where to find it, if you need to debug
> something). It's still, conceptually, a [vmlinux], and I'd like to
> keep it this way.
> 
>> I think it may be more clear, if we print btf name when we use old
>> kernel btf like:
>>    struct task_struct___x: found target candidate [130] struct
>> task_struct in [/boot/***.btf]
>> The patch just solve debug info show for newbies above.
>>
>> 在 2024/3/22 上午2:52, Andrii Nakryiko 写道:
>>> On Thu, Mar 21, 2024 at 10:04 AM Tao Chen <chen.dylane@gmail.com> wrote:
>>>>
>>>> No logic changed, just add specific btf name when core info
>>>> print, maybe it seems more understandable.
>>>>
>>>> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
>>>> ---
>>>>    tools/lib/bpf/libbpf.c | 14 +++++++++-----
>>>>    1 file changed, 9 insertions(+), 5 deletions(-)
>>>>
>>>
>>> Can you elaborate on what problem you are trying to solve?
>>> Conceptually libbpf does look for types in vmlinux (meaning main
>>> kernel BTF), even if user overrides BTF location (presumably because
>>> of old kernel). So even when we emit "vmlinux" in logs, it seems
>>> correct.
>>>
>>> pw-bot: cr
>>>
>>>
>>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>>>> index afd09571c482..b32154288b4a 100644
>>>> --- a/tools/lib/bpf/libbpf.c
>>>> +++ b/tools/lib/bpf/libbpf.c
>>>> @@ -5653,7 +5653,8 @@ static int load_module_btfs(struct bpf_object *obj)
>>>>    }
>>>>
>>>>    static struct bpf_core_cand_list *
>>>> -bpf_core_find_cands(struct bpf_object *obj, const struct btf *local_btf, __u32 local_type_id)
>>>> +bpf_core_find_cands(struct bpf_object *obj, const struct btf *local_btf, __u32 local_type_id,
>>>> +                   const char *targ_btf_path)
>>>>    {
>>>>           struct bpf_core_cand local_cand = {};
>>>>           struct bpf_core_cand_list *cands;
>>>> @@ -5680,7 +5681,8 @@ bpf_core_find_cands(struct bpf_object *obj, const struct btf *local_btf, __u32 l
>>>>
>>>>           /* Attempt to find target candidates in vmlinux BTF first */
>>>>           main_btf = obj->btf_vmlinux_override ?: obj->btf_vmlinux;
>>>> -       err = bpf_core_add_cands(&local_cand, local_essent_len, main_btf, "vmlinux", 1, cands);
>>>> +       err = bpf_core_add_cands(&local_cand, local_essent_len, main_btf,
>>>> +                                targ_btf_path ?: "vmlinux", 1, cands);
>>>>           if (err)
>>>>                   goto err_out;
>>>>
>>>> @@ -5793,7 +5795,8 @@ static int bpf_core_resolve_relo(struct bpf_program *prog,
>>>>                                    int relo_idx,
>>>>                                    const struct btf *local_btf,
>>>>                                    struct hashmap *cand_cache,
>>>> -                                struct bpf_core_relo_res *targ_res)
>>>> +                                struct bpf_core_relo_res *targ_res,
>>>> +                                const char *targ_btf_path)
>>>>    {
>>>>           struct bpf_core_spec specs_scratch[3] = {};
>>>>           struct bpf_core_cand_list *cands = NULL;
>>>> @@ -5813,7 +5816,7 @@ static int bpf_core_resolve_relo(struct bpf_program *prog,
>>>>
>>>>           if (relo->kind != BPF_CORE_TYPE_ID_LOCAL &&
>>>>               !hashmap__find(cand_cache, local_id, &cands)) {
>>>> -               cands = bpf_core_find_cands(prog->obj, local_btf, local_id);
>>>> +               cands = bpf_core_find_cands(prog->obj, local_btf, local_id, targ_btf_path);
>>>>                   if (IS_ERR(cands)) {
>>>>                           pr_warn("prog '%s': relo #%d: target candidate search failed for [%d] %s %s: %ld\n",
>>>>                                   prog_name, relo_idx, local_id, btf_kind_str(local_type),
>>>> @@ -5920,7 +5923,8 @@ bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
>>>>                           if (prog->obj->gen_loader)
>>>>                                   continue;
>>>>
>>>> -                       err = bpf_core_resolve_relo(prog, rec, i, obj->btf, cand_cache, &targ_res);
>>>> +                       err = bpf_core_resolve_relo(prog, rec, i, obj->btf, cand_cache, &targ_res,
>>>> +                                                   targ_btf_path);
>>>>                           if (err) {
>>>>                                   pr_warn("prog '%s': relo #%d: failed to relocate: %d\n",
>>>>                                           prog->name, i, err);
>>>> --
>>>> 2.34.1
>>>>

