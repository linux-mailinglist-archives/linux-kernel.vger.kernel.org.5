Return-Path: <linux-kernel+bounces-99360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB41887874E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37C101F218B2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8251548EE;
	Mon, 11 Mar 2024 18:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkMsk5rt"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B14D53E1E;
	Mon, 11 Mar 2024 18:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710181737; cv=none; b=Bv4JaWfpLyeyYkdHJyWdgUYJ52Dq83Fprjbkd+ROJrwksB8H+/dz99zGXoAWCcycgy4EXMPQ51oQR4SrN2nfQPXc0WFsAUPEBdl+o/Ag3bcUYj8L5Wxr3Pq7z17YCJqjLrZhkzBDggSUnA6EYevcA4TS8UXP5/zVxwZ/5f83WGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710181737; c=relaxed/simple;
	bh=1DFuVCZwt27vmcTybrkyMywbfdDU13ULx2O965nWEPg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d1+zgikBrkGMIVXupZX0KlAmX8shqdDAFXPSnrKbndqRKmn+9sCXrebvWpmhB4unstyt3HKDVUJhg34miq0EEFxGke8SNkzuhgytZ029bsdxvdVbyVi7TIArLt5hEYM5NIw9d+1IXs8krZLf1QHNzzfbp+AFClFIff5njCKuXqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkMsk5rt; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5131c0691feso6065804e87.1;
        Mon, 11 Mar 2024 11:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710181734; x=1710786534; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EA+Rmd4LukCCiQcj2zW077PzEUtEhRdmwmt49q+L1Jc=;
        b=QkMsk5rtLX7bCG8jc5g8LpD+j/F2xZfk6hYzGiFJQww/pqb2BJVLmDZs2EmJkj21LK
         gyfTlIVEeX8RWsRxwNtFIJUlsK4WbvcBIxj1eANYjbqbmd7N8Vr4wAfBSWp+lb6RC/RP
         0Tc1SNLkoTaM7O6IpdEkY5tnNX0sMBfISTjfgYx/FTqPmXUS3bxNjwi0FQ0o2oiA2fDj
         IvGYTPbnlXSyGpYR47A9qn1F1urYwmwPqKFZb17Atgxk8FkWZFqj20Z9cYM/LJxKSNJ0
         JAYnZmzjxU+n4HWI1uWDnhUMNvGJrdVKwRZwZvGV+efRTvjNd50SZkt9YWyHYLpg4aWb
         eOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710181734; x=1710786534;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EA+Rmd4LukCCiQcj2zW077PzEUtEhRdmwmt49q+L1Jc=;
        b=gTOmluRvW64SWC4Hs+x9BtAIx774YuVnQQXVDpLPyUZ3sgeYCYuKa2hIuOHCj6fe80
         agCe0SfwASjIQobfOUa7Tv42m59NPF8sXVBlGZllnn+AsXXe4PHAQmiwpCJqU1Y8VtLP
         nqNX4wR+6tYXtl9GWJ3fT1FL3iNYVu0Gg3nN953+m7XidIb0xNWL6TFLAt2bBK/m2Dp3
         5Mz6/9u0SD/hao/3TQ0ktzpxUY6ZKW7mn4W34tFvxlApDPvfKe5BYUJcKnGW77V9F7qK
         CX2mg8pm1tLFGZ0uX22SoID5tm9ZcoGsAneapE4dVtV11cB7Dd2MurbaPsePhcizYvSg
         Eg0g==
X-Forwarded-Encrypted: i=1; AJvYcCXuh7QPQNh+UIXMKce7xvDNL1AMZIbtJjMS5252sUJh/SoV1QOc60IMpTz2KI03XXU/e+t7EGHPl0YRPjNU+Ug304KmpAT0iSdZrelwKszA7D/nUKFXAiYgZAHIUQZtpl66kJ1DhElPp0H2iUdrz91sYJoseGmZm+9N
X-Gm-Message-State: AOJu0YwRchHTXkiPmFlx7CAmMZeDXv50Cn3TFGZwG/MnnQiAs0keDp6s
	ckfrltoAq6Hq5wbabDvfKtVPZ+czlIOXt4JyZmbozn2fVcWc3Dm7
X-Google-Smtp-Source: AGHT+IGXa50h88Id2A4cH9Gq/82q8SMwoZ6hzlhcwUljLBpO5vwElRErN0BdiuE1MSmCm/Egj0AzlQ==
X-Received: by 2002:a19:7513:0:b0:513:134f:8250 with SMTP id y19-20020a197513000000b00513134f8250mr3895187lfe.55.1710181734181;
        Mon, 11 Mar 2024 11:28:54 -0700 (PDT)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id hg9-20020a05600c538900b00412f855bcc2sm16238600wmb.43.2024.03.11.11.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 11:28:53 -0700 (PDT)
Message-ID: <3b618a33551a0fe0ef5d74b9dc5399afca52209c.camel@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: fix oob in btf_name_valid_section
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Edward Adam Davis <eadavis@qq.com>, 
 syzbot+cc32304f6487ebff9b70@syzkaller.appspotmail.com, andrii@kernel.org, 
 ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 haoluo@google.com,  john.fastabend@gmail.com, jolsa@kernel.org,
 kpsingh@kernel.org,  linux-kernel@vger.kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org,  sdf@google.com, song@kernel.org,
 syzkaller-bugs@googlegroups.com,  yonghong.song@linux.dev
Date: Mon, 11 Mar 2024 20:28:52 +0200
In-Reply-To: <CAEf4BzbbvBEwy6_S1MRjiGWWfS_nxy6qNsEc0_Jdro1c10b8Vw@mail.gmail.com>
References: <00000000000081fb0d06135eb3ca@google.com>
	 <tencent_E4EB1B6A2584BA2BBBB733409EAE1B524B08@qq.com>
	 <5f1446d409322de91946a569edc0b836daa52aae.camel@gmail.com>
	 <CAEf4BzbbvBEwy6_S1MRjiGWWfS_nxy6qNsEc0_Jdro1c10b8Vw@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-03-11 at 11:01 -0700, Andrii Nakryiko wrote:
[...]

> Eduard, I'd also say we should make __btf_name_valid() a bit more
> uniform by dropping that first if and then doing
>=20
> if (!__btf_name_char_ok(*src, src =3D=3D src_orig))
>     return false;
>=20
> where we just remember original string pointer in src_orig.
>=20
> WDYT?

Agree, this looks simpler.

