Return-Path: <linux-kernel+bounces-92049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 959D7871A40
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 361941F20F88
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D1F54903;
	Tue,  5 Mar 2024 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsPcULCM"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D350B548F4;
	Tue,  5 Mar 2024 10:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709633427; cv=none; b=ZgWU2E/XB2gxbXAMa3Whqkz2XYqrfcLRPma+MCCOYaCKIxFksspdPZol6BbqrtSO1F4Nyblh79Kn42qSM9ZWQ+Kh7dKN10T8a4zO1GU5CCuQ9r4PtWUrQ3yBQ7NDOfbR95qHJ12EOCx4fB6Gn8CS3r/ogv/YS41vHmzLXfM7K0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709633427; c=relaxed/simple;
	bh=gmAtaa2N2nE82MXltIXk8UaUAv8zL+yzOdz4Dk+oass=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k2XBKr5XijLgPg8hNphdnA1oTI6PEGc82k8Ykbg4zTmpqnsZ2rnweeSGj3UXe6qiZ7nQwwo+AH8TfOocbeqwK5PyXVv6K/ptmuJbzryMkSaQAyebf5P79ocMDTXPGliVPr3C1UGQXp93l/0mIhpEtRuWsX+b1OMSC0tF4WZ27pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsPcULCM; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-29b1ee96191so2891149a91.0;
        Tue, 05 Mar 2024 02:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709633425; x=1710238225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmAtaa2N2nE82MXltIXk8UaUAv8zL+yzOdz4Dk+oass=;
        b=CsPcULCMQhRYeSUO5cdzJFv0SrpD3ggfiLZ2DlMJAR5BeNDBa1RYrfXESTM5r8xUHu
         Ay4m56AG1Mt7tsu2mAHprbywLg/Wmqlx/n2AKka4ee0FQvBlSCHlIN8z4X2ol83wpMcH
         qLhhQ634m069VpYnq8xmWeHDipiSPAhxzLUo3Y6eKSGMnnScOIobG3BTUGAxDAwmzUsO
         7MxqSVVd6zcOjvDNIr7bBU0SDtSC0m+FtSeOW7tTFrJjzQapI7WpwZ0YmzZ18iifdIQD
         UwnyfvVdnTMjLRgjHj5z/Og7NaRtlrNiSiExyqKwAJ5d39hsyOb48ABavXAZdRcHl6AD
         XD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709633425; x=1710238225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gmAtaa2N2nE82MXltIXk8UaUAv8zL+yzOdz4Dk+oass=;
        b=t+oJVD2QYuZkXAUvS1Vj/RNQ/1/76YNRTz/ohMGi/SnvL/DQq48y7sGim4sT8jNkU0
         9p1KpyygjGFezojC0nEu3wstHblOjfLz0pqyRSkBdflpcho5wYjfKgATUK/2GCiyfz9q
         L6lhboGacT1Ah7inU2g2hzO0B465THvhia0NC/drJcJrMpxUuOHBHIKpoeRNH6twPztz
         75sXhW958ZCUCoKLPA+W7HOvBfMPJU8SFj7oB0WHhOR/gZuaAKkSadidV3smJUED3bH7
         y3c+O6P3UBQU4JzdwZDj26+CQaBP2XraunXFhyRjM7s43V49X8CFSiWFbIgbfsdi/g3R
         CdTA==
X-Forwarded-Encrypted: i=1; AJvYcCWG4UYGnnlSeq5SEj1bI5I3dIB3LbQb9ajZrS7uSi0L+1xSJaC17oE0cKcjJeBYbL9XfPZGha0uLMmPt8c5kqhvIYIWyiSBJFvIXzr85T/1T25s1G8TZVOgUUY17Dyt+7Z7IvAkvNwH1hmUl+U=
X-Gm-Message-State: AOJu0YxWYyLw9Rz+4Wt7vvk0PEcb5cXCdeTUoMbcD4MTAIvFWeeoBmiY
	7KAhsXBu75vijYSEa5XZ/WGaMYGvsr+SlHrVA7aJ5Wsw+gC8OHh2C7+FeOq7h8CZhXLmcrp4Z5A
	sv31XzZQYd1v53kUCVhMVj4pCUfA=
X-Google-Smtp-Source: AGHT+IFvN55XESn+MGAPLMObN5HMTDIRSYbY4oFEzsZN3jCgHw7bjMfXlZewHZ79chco8tXX7+zcKmmxLZaIv3JU4ik=
X-Received: by 2002:a17:90b:192:b0:29a:67fa:7bb7 with SMTP id
 t18-20020a17090b019200b0029a67fa7bb7mr7859867pjs.47.1709633425130; Tue, 05
 Mar 2024 02:10:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304141426.163517-1-wangrui@loongson.cn> <CANiq72mvdVrzN19PC8pNrvuBLkOEEQ3yX0WG6JcWc+RVaSM2nA@mail.gmail.com>
 <CAAhV-H666zsMadZuzvcRxxkUxSpkka1tt9AJO_WctHDL8j_HNg@mail.gmail.com>
In-Reply-To: <CAAhV-H666zsMadZuzvcRxxkUxSpkka1tt9AJO_WctHDL8j_HNg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 5 Mar 2024 11:10:12 +0100
Message-ID: <CANiq72mHCNU2wGpELBbgOA8LKQhm_-RyG8+9bP9miYJOkUw2Uw@mail.gmail.com>
Subject: Re: [PATCH] loongarch: rust: Switch to use built-in rustc target
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Rui <wangrui@loongson.cn>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Jamie Cunliffe <Jamie.Cunliffe@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, WANG Xuerui <kernel@xen0n.name>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 10:58=E2=80=AFAM Huacai Chen <chenhuacai@kernel.org>=
 wrote:
>
> The base of the loongarch tree doesn't contain the arm64 modifications
> now, so this patch is better to be applied on the rust tree with my
> Acked-by. But if you have some trouble doing that, I can also manually
> merge the arm64 parts to the loongarch tree, and then apply this
> patch. Thanks.

The rust tree doesn't have the arm64 changes either (i.e. they are in
the arm64 tree), so we would have the same issue.

Since it is quite late and there is no rush for this, I would suggest
applying it after the merge window in loongarch64 and thus avoiding a
merge. But, of course, up to you!

Thanks!

Cheers,
Miguel

