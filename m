Return-Path: <linux-kernel+bounces-147478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 095F88A7506
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B210D1F2153C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0131386C8;
	Tue, 16 Apr 2024 19:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMXi/bbN"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E632943C;
	Tue, 16 Apr 2024 19:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713296253; cv=none; b=c559PKy0QojNWWl7s3Z2b2J9ZUNinI9QzfWpwQCAQs8x2VwH1q2sc4V2ToQ1RE826uy9+Vdo3W+ZPES9CcKlamawmutlsGQNPLlbMtcN+GdodPPAgW/s9kuKWf6APKpKb4KgyBAcQHK0lhnuwOpsRAz9rWWnr4Z0EzZKl/951wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713296253; c=relaxed/simple;
	bh=F6vLZMw5iKbm8/K6P0sUwSZXxcZ1d1VPqXfAJPc1ClE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p5TG7N4bCpFLlVJDTBfST+bEH7UYmWkTSo80/X7IaeHCxppdvLm7YTw/QcQQ10aMXMixxoDDvdIs2FA7VkJCL88lseyHIp5PsRJBNUbviLunNHMHObGgq5T9TBR17CgZSxZdydARTrb2xUp1eIq7iE1wM/kn3aMRhYQhz4eLwJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMXi/bbN; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-518e5a74702so88164e87.1;
        Tue, 16 Apr 2024 12:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713296250; x=1713901050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhWQKc/eYOwik0yE3g6ijPo7WAzZsqUpRV7UJ5RlYZU=;
        b=WMXi/bbNsOSmogIMC9C18YcFhLsiKGKEYUUIZwmagPvQ3yxDHooK1xtAOLiiHZzHZS
         j4VMm37RjOqEUBNJh0Ma7/43Dlk2SXyrYKMv0LXncXACUJInyMZG/hcfZPjTyyH5AXoF
         3SQgqxd3/wgeJvwYcPF2M6XmFK+7jL0/gAINLK70YePQVSbXn6RTnk+m+BNFdfBz12+G
         jmUPNeG6KQM/c43KOVyQYV40WGvqaAz676YUDc2d4yzANop7wsAFmuUUi/iauHdfY5lL
         4adMfXxF4SAvCS19TMdOiVvBWdLmiBETxMGtnias8j8Ym4NPpEvo59ATJmphO1x9eWrR
         VtEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713296250; x=1713901050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bhWQKc/eYOwik0yE3g6ijPo7WAzZsqUpRV7UJ5RlYZU=;
        b=UM7WA56DItfDCe0+TpTN4WW6WR/2jCrQnzaIelwk29f/zk+Hy0vCrAPIuGlcBr8oSP
         SAUNDj/H+XGcecZvfbr9QKB/MCCSaYYWGp2HD6Oc3C4/cSyhR5BHGFdvB7OK2Au4VvjA
         EXeAignAewozd181OYppKNJYBKuELeur/5sO3R/vBGtEdRG1DRBy64EzHsQ9ERouccCM
         3XE3K+ljIk+br6HOf9NaCOGWVxfHYUJgKJ7HBsB67CdoVkotro7QEat/k+DD+m4dFfjo
         a/20WK6aLhCZJSZVPluSlKlCXJE0q6fusJ1LpI5Zvgsqc9E4JNEN9Nn7dvrtCCPCBGgY
         j5NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvphNQmojbAKa5dw7+OOE0O74iNOvpB9QqCatdfIqWbqRMLgxOwGN2EXbnpEbvxY75KENrO4YuBWG3rNPG6LHg3h49IEOWtV2K4pRtyBb3VbUOSZ/fc5s6H45BNhJzMJfVcmI13UuuH00Qc/4VcrdLFRNoT0K4UxYpPv2vDOHDu7dV4WQ=
X-Gm-Message-State: AOJu0Yw/M1JeuJhOV6rfj1P2syhrq8fSfW9NHPoSuIFnmwMH2Dh1TcXX
	tmvWvcwfu25q6pQxOR4gOSkgD2y6Pgjadh1yrMwss2f4sf3tOT64y/YUOkoqlgAqlElkqd4gp57
	YwulPiNE2Sci7hltuW6SmZ3ppCYk=
X-Google-Smtp-Source: AGHT+IH9hPdu6JNc6JS8yjgqhAuaq5GbLqml3teWtRplC+EvlAKU3fTiFGUAx2AXF00rfhMM9xrkMQebrE8LWS5Kmiw=
X-Received: by 2002:a2e:6e0c:0:b0:2da:f300:90ff with SMTP id
 j12-20020a2e6e0c000000b002daf30090ffmr700414ljc.2.1713296249388; Tue, 16 Apr
 2024 12:37:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401185222.12015-1-benno.lossin@proton.me>
 <CANiq72=M0L+RG6v701ThedXgYj4SUgotx-BcVoWbMxOcKY5--w@mail.gmail.com> <Zh6wTDoMgvjJZ7T9@boqun-archlinux>
In-Reply-To: <Zh6wTDoMgvjJZ7T9@boqun-archlinux>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 16 Apr 2024 21:36:30 +0200
Message-ID: <CANiq72m4P8NNr7M0Bv6bFpLonPu=WZC_x-k1KdtzqUd=vtLObA@mail.gmail.com>
Subject: Re: [PATCH v2] rust: macros: fix soundness issue in `module!` macro
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Asahi Lina <lina@asahilina.net>, 
	Sumera Priyadarsini <sylphrenadin@gmail.com>, Neal Gompa <neal@gompa.dev>, 
	Thomas Bertschinger <tahbertschinger@gmail.com>, Andrea Righi <andrea.righi@canonical.com>, 
	Matthew Bakhtiari <dev@mtbk.me>, Adam Bratschi-Kaye <ark.email@gmail.com>, stable@vger.kernel.org, 
	Masahiro Yamada <masahiroy@kernel.org>, Wedson Almeida Filho <wedsonaf@google.com>, Finn Behrens <me@kloenk.dev>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 7:07=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> As reported by Dirk Behme:
>
>         https://rust-for-linux.zulipchat.com/#narrow/stream/291565-Help/t=
opic/How.20to.20use.20THIS_MODULE.20with.20.22.20rust.3A.20macros.3A.20fix.=
20soundness.20.2E.22/near/433512583
>
> The following is needed to allow modules using `THIS_MODULE` as a static
> variable. That being said, maybe we can merge this patch as it is, since
> it doesn't break mainline, and the following change can be done in a
> separate patch.

Fixed in `rust-fixes` now.

    [ Moved `THIS_MODULE` out of the private-in-private modules since it
      should remain public, as Dirk Behme noticed [1]. Capitalized comments=
,
      avoided newline in non-list SAFETY comments and reworded to add
      Reported-by and newline. ]
    Link: https://rust-for-linux.zulipchat.com/#narrow/stream/291565-Help/t=
opic/x/near/433512583
[1]

Cheers,
Miguel

