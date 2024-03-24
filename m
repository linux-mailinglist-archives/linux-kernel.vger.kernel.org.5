Return-Path: <linux-kernel+bounces-112820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C46887E91
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 20:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F98E1F21251
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 19:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8653DF5C;
	Sun, 24 Mar 2024 19:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRchD4N2"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8530D502;
	Sun, 24 Mar 2024 19:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711307637; cv=none; b=XSM8fDcRg8gINhNz5fVxJTbyz+oDGOkfCYwSkQGrHOXXArEAQ54VdmmIaKxLj3ZvTgkpph5qGmujLucp0AJQkqUJHYdvUR+RAcsBMwW7GxSbj2E2B3/bV7YZlF0aJfGYF3HH2T1NacO/e6g2e/vwxJWaL/GZnQiEp2cHCDBCYP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711307637; c=relaxed/simple;
	bh=ZABnmvyJVP88YNJpdEJiAvgxsJ3qKpvZGdQEOZrj/Pc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SRqp+2M7Gt7WsTwPML/ZpPHqLosdJGAqqHGG/cYHaUVyu8B2y1Ck9JqEKIs9Y2bJybg1xWsaW66MBb5kaJ9gPsaxqC6/R+8LTVXMmM7iCgRYzASbXZFeIhMY7wXNKmK5zXMzcigI/TqNZZUjuAwRJ26D5FNQI1K2HDnO2Tkswek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRchD4N2; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d475b6609eso47362091fa.2;
        Sun, 24 Mar 2024 12:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711307634; x=1711912434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLOEbFad/btW1UM90DBxbrHE+EF8s9QZ09cwq3HcfTo=;
        b=cRchD4N2yPta5/wIfK38Ngl/GJon591J0/HmMslsdFVxlNipU0x5GqWPA9wwv2oks/
         cx9qVBPY/uRjAZz7qyT95ReGgps4v3/l0fC7ktaBqrJOmL1+RzQE0vcpVNpOZkgivtcI
         LdlEFU9Z/2bNbZuyPnTGvZqZk0DzxjeXPG8f+hN/hjIUpJKdrzIydG9IJx+MMg90aZnD
         9D2fqhKMadlQ8/5J8q7lKMpq4tNvF+ClkZNXq3/z/0Tbrgh15Nmdst0+W4efygc3iG4R
         aLqyifgsraoNFvQdlkORtD8k/rkuKfp/ByvHc3SbuDofZNA2/737rcgOotp1+m5wPdjB
         I0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711307634; x=1711912434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLOEbFad/btW1UM90DBxbrHE+EF8s9QZ09cwq3HcfTo=;
        b=Pw+p9tQSCr+LbhBBrtKN0e6OSMR2l54bTKBNZ04BZT3oJ7+Z3UIFsqZX2HLaBLITdD
         iA9gB8Nt6iXpiu/2Im5G/UdCU24pZ96qu97b9bWbKWcRT0v6w5J4bDCDRrx0obkXkw19
         W893UkYisudEWUnf0nWtjLrPEe3W57+WSlJ7yOpRManeRRH6EEjOd1kK40Juhte5fpBq
         f2yRDigoQPOj4cnlT4RHIGH1PPrC2yq3T8cxdSu/yCJIhq3QDNV8SsYSydJyl9SIOyok
         rZ0SucFUvnd08MUmpRJ0rqX0zupKeLew6ZilrXeY+V7ZsmpHl3VaH8yarBN96096pUe7
         uQRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfveCCZ2p4VRDhDRH5m/Z6cYMJl89++6tIW0MZxmi/Hu5Li/aptpz5eKPUrzK88fol+JtoC6CaK2NGrZ/rdUR/MJ7FGOnGwZaCqt5eMFs97/ZKJ2pNlybE8ZVTauF0i+47CvuanH1n2sE5XX7B7/2ieBleHCMBc5KK
X-Gm-Message-State: AOJu0Yz1KGLRi21GV18KZvReAag8WZzGM78QGO5a35g6mkQ15AM4NbD3
	hJNihDE2Q/EYWM5HV7+7/WIKE/p+Aar+RSIU8nwZucE+VfjViOQjWZzfuiJl4wO7TZCX5l5GfFY
	1/ypBK34cA/4+OD40QrDD0FFCiSc=
X-Google-Smtp-Source: AGHT+IHC5DnT1k1Z0HiLvtcZjSixxTqRFShv7zFU0thnHvW2zoMZ0nzWoYpNJ/QJsNEGEtK1+tHa7n/xnxuXjPeoTjY=
X-Received: by 2002:a2e:7317:0:b0:2d6:c61c:90c9 with SMTP id
 o23-20020a2e7317000000b002d6c61c90c9mr2361635ljc.53.1711307633588; Sun, 24
 Mar 2024 12:13:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324185356.59111-1-puranjay12@gmail.com>
In-Reply-To: <20240324185356.59111-1-puranjay12@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 24 Mar 2024 12:13:42 -0700
Message-ID: <CAADnVQKW2ajQ25BkOO_D2=N2wOHt9fdNY+tWRunXe_sN-w+33g@mail.gmail.com>
Subject: Re: [PATCH bpf v5] bpf: verifier: prevent userspace memory access
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Ilya Leoshkevich <iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 11:54=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.c=
om> wrote:
>
> +u64 bpf_arch_uaddress_limit(void)
> +{
> +       return max(TASK_SIZE_MAX + PAGE_SIZE, VSYSCALL_ADDR);

This is broken. See my other email.
Sadly you didn't test it.

