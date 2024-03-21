Return-Path: <linux-kernel+bounces-109704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40717881C97
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA8851F21578
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 06:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BF050249;
	Thu, 21 Mar 2024 06:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Labh+Q77"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A2B47A76;
	Thu, 21 Mar 2024 06:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711003563; cv=none; b=hSTkpnh6t81KPoVxilywRUDtxgHNOBTFhMq49/WaHgIjwEljBohhMZ0jfC6YHbx08Sy4lIzL4GqS2Rk9jyLJCdF0Nh1v1gwfvpAiheJBxJHTQBaoMXRpiFFtFS7yfhDH2kxGvYv6n0CkkyTFRWQgrGJSIbhQ4xOSh4jptZ08SQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711003563; c=relaxed/simple;
	bh=/+IBNxFeq6Z7Bevsh2/8GPJyYRvwyX4wy6UVREy7iho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=doBtMXAXBzX7Wx89P6Up0WvjFJMo8r7eKPgWg4o3gSWHZzmic+99OVGfL3utExhaM7eLDzMI1El1F1pSbvulLEOCov1MwQqR33d6QLT9Jj9vI0GZrkS5B7JVQ9OUbi0ACxGCNuTXpmj5KoAhsSIfdooD8Vmob/eDgj3we4rXbqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Labh+Q77; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-414006a0115so5896215e9.3;
        Wed, 20 Mar 2024 23:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711003560; x=1711608360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+IBNxFeq6Z7Bevsh2/8GPJyYRvwyX4wy6UVREy7iho=;
        b=Labh+Q77tgrXA/jJJBEe75LJD9HGbgyKjwD0EoomSds+DKVwFcoZgHAnO/Z+o7RaAh
         lkz2lo5QvQF57160sE0SQhU5HU1aoHD/6/hmFXXBoyYZFvmg66HNhIoiy+6163FSzfg0
         Y4n1/jsoXYGyMbYz9G3VX777xNml3bs2RHCFoIeUfSYIMpzEqS5a+t+SqM/n2ZxTi2w7
         E3NP2v2EBUiQBJE21/2+AK67mLxbemWnwVtnYDoMVlXEmtvYiVc4AlU4z/jtAJVziqyF
         1M0s8KewVFKTJSnBCEYWVEBItxGwkUb8Qf7JUm09R4EUCrw9awMP/Ey3uz5ET4IafT1k
         1NWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711003560; x=1711608360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+IBNxFeq6Z7Bevsh2/8GPJyYRvwyX4wy6UVREy7iho=;
        b=KOlbjccOM1tIZIz+K/IlG/ekT0c+ASoUlWL48dIjqT5WwTeR7wYf0YHySL7TlnMpts
         58H25CuhLkNcBsWmh7ykzJ2KtmylGHHRq1IVeo1eXjijjlgwGVgIWODkxBcFWMTxb0ij
         hxNiLk93GFroD1phgcb9Kn2oAmYJsRUXvPoP5cigeftapMU+xanH3vTDOFU28n405S3Q
         BKCJ8cT59xXvSLM3b9P1Ae3ZjCS0932eEkjxKxvR3o4+wprQoTIG1tZdlxoF3/pzCfY7
         ZhJxQetq+v9h75hWaiqtqUvqdTHv+UZcWuZvQdwq3AhCa+Z/4nGWoDkTrzIV8eD2ksLW
         eWXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVA96mYxhXXPMglg4qsEvdq6vOwchEzXHw/yR/lA/74SDXIKkUpmRPGk+SWiJodTIKWPEV27tEQk+NEBDHJSaT09kRMT74uaFS05GfF0T9yyy/eavzLLmj8aN2W3Aj74dne
X-Gm-Message-State: AOJu0YxzWqVGaveaDf6scA+Gy3sCeFBHFp8sjka/XqBAntLuyGbZLSiR
	hSAQd1Zoe28wcNjtgrzbOOwtHckzsFcTcAIcdbABOTpVnEkZk4Oz7SLV9c2gfbXJORlf1wboeK9
	b8DB7FSbWbJN1jrRUaxvnlG5wvQA=
X-Google-Smtp-Source: AGHT+IGBTB9xCm9iDwZeV47oFiYV1qd6ZcB0fYJuS9xvuJmXKCwGEXovAYH+hyHcL1UYMPN4YX9ghKgazFxqtNBVNJ0=
X-Received: by 2002:a05:600c:1990:b0:414:e72:63b1 with SMTP id
 t16-20020a05600c199000b004140e7263b1mr848723wmq.3.1711003560179; Wed, 20 Mar
 2024 23:46:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABOYnLxfFXYV5mJfNrTKEdohF6_AUFxb3fPHEF=eaCEio3dv9w@mail.gmail.com>
In-Reply-To: <CABOYnLxfFXYV5mJfNrTKEdohF6_AUFxb3fPHEF=eaCEio3dv9w@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 20 Mar 2024 23:45:49 -0700
Message-ID: <CAADnVQLBexmxPEx=sOmZR9sy4i3=NqXhAB88u_a+ga4i9Vgj6w@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in __bpf_strtoull
To: xingwei lee <xrivendell7@gmail.com>
Cc: syzbot+8ac8b7b2292ea867a162@syzkaller.appspotmail.com, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eddy Z <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@google.com>, Song Liu <song@kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>, 
	samsun1006219@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 11:41=E2=80=AFPM xingwei lee <xrivendell7@gmail.com=
> wrote:
>
> Hello, I reproduced this bug and comfired in the latest net tree.
>
> If you fix this issue, please add the following tag to the commit:

Maybe you can fix the issue ?
Or at least debug it and analyze where the bug is?

