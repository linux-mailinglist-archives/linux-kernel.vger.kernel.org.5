Return-Path: <linux-kernel+bounces-82860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B237E868AB8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3275A1F22AD2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1699F5646B;
	Tue, 27 Feb 2024 08:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="dHrfEq1v"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB5B5644F
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 08:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709022304; cv=none; b=IeCtEDD/s9b+JOhxlRupAHthE80IqPFikopIYikKGKCux6MnhspcTyg4JQl9r+V9Ic2yoNVUqZPYxwfYsiJiXBmPJZlJ6HF8qBVMYsFrUrHOTpbw6Srb8qhSZiwZoNOk8BtsRW0KrT7riV1FFLa3SUCFvx/meAYGOksl7r1yrPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709022304; c=relaxed/simple;
	bh=EVI7vz5Qsf5hXRlkN8Ggko0P8CCIhLHJjlFi+HodR6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SRMRr9d+P1yqs3WnUhLsnv1KYClJfERZEQ69DIzNJazCKKyLsy+rU7jW3Sc1QR6N9IU7Lv5jqivUWd8zlNoH+nYcnhbfq9N1mRjr5fFAoL6q1+epQLDe/5XjKu6ihagoflgwWR6wwdYZAD3D8yIp+wtaFefcjhOYT285tr0gu8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=dHrfEq1v; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4d331ba6078so17979e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 00:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1709022301; x=1709627101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3oEZ83ksqzh/6Sv0YNt9LyEJ4eUjhxHm5FyNz/Llm4=;
        b=dHrfEq1v4rBba3ZnKS0wVcQQiTW55EgwCtGAN0kx2vMV/85Pn+nvuyqSYz4xq33lgQ
         6pyS9PrGpxFNt+wLtsGljCD+0sJf0qo5/rgsOWjDK/c78uorH5V+6s3QyCqUm+mhlCRz
         eGX5ZMegOvavZ2xckr+Ezwy3Ph8RzfAFuRimACpqUqumvzR/KbvDFoKBcjiQMD1VeZTy
         QHoztsVcZT57sGJQ36WG36Zi2QNUgLPk1/XXb92dT9Q4KcNnHC7DhDS7L2t/+b/c/jpx
         4lkFTWRVGanm3NFK23xlLyxHgy8885aLEbWCn7GVbNHGB7Rrugf17gHuQiayHBgmW3vy
         1WgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709022301; x=1709627101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3oEZ83ksqzh/6Sv0YNt9LyEJ4eUjhxHm5FyNz/Llm4=;
        b=urmUoTZTf/2pf5pT7V0nQXO2Odhc5l9889TNdZFpcY0K5SU/Fcec/QzjByxZ2n6qy6
         +5sFmYFVWQhzIEQMvq30ZHw01KBh5AWCzgQf4q2+aWo7D4DvzbGCcDp0oPJ+etUrZ0zs
         OflxkGTPDtlmP+1CVRv3Mfgd8CvNPBZqqSpuOMXIsTl2FG83e5aeLMbAwrX07HNA4o/k
         5dsGPp6EysRgwyalFOUApZ0vQkFTPPwBbebu1lNmtyL/UllPRwWrzma6RHhn/13gNhKX
         XWP+tsbq/gjabpPgeUF7K9CaaiPwSZlRXQiSK872vd1nQhP6b3YFKBtcKT83d15k2uYE
         Nolg==
X-Forwarded-Encrypted: i=1; AJvYcCUOI0YRDwl4ok6wb5oUK/uv8ob1xYQ4eo12H7cOhaQJGtha5ini7VaQGsTnT93ZCaeIodnwNCvUlsxJ/ktpHLbeO89Lhg39ptpfvq7F
X-Gm-Message-State: AOJu0YxUX491oOJeUXjxjfNOhVb6zVSaDyKnNizSCSm6b2tbvoLNHI7d
	CS1Z8GXjk82guyWR7+Ew7VTUND0rb96rje1dvv0q8XvGb/5lUysq4g189A9/UOmJJ8DUhblHKTk
	p9aczYrabn/TKdVt4pV2NjFfCtaNvnrEux8BNKg==
X-Google-Smtp-Source: AGHT+IGfKT0WSHnAi9Z8ZhGjHZH5g4Gvo7KWsZdo46pVngPbJr7w6ihyB9HdDw37XGWSuSg0MNM0ZD4/shwz7CPfuAo=
X-Received: by 2002:a1f:da41:0:b0:4cb:2662:3653 with SMTP id
 r62-20020a1fda41000000b004cb26623653mr5475489vkg.9.1709022301389; Tue, 27 Feb
 2024 00:25:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205182810.58382-1-brgl@bgdev.pl> <20240205182810.58382-3-brgl@bgdev.pl>
 <tnylagkmj36lve2ub5voumtkqjdy6j3hr6yyk4mqkaabvc3gdv@voaiu2oqi73o>
 <CAMRc=McmfufqqEvouRCjY1ukVB_ie1r5QEocqRUK0VBheEq5Hg@mail.gmail.com>
 <CAMRc=Mc_iwMzKznfUknm+RwS3jN_GimpirdTDVCPtnYYS_1PNg@mail.gmail.com> <20240226102955.GA19256@hu-kuldsing-hyd.qualcomm.com>
In-Reply-To: <20240226102955.GA19256@hu-kuldsing-hyd.qualcomm.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 27 Feb 2024 09:24:50 +0100
Message-ID: <CAMRc=MdfU0=JBrAJMkeg8XV6SWPybY+rDMG5_Cei1haGGsHmpw@mail.gmail.com>
Subject: Re: [PATCH v7 02/12] firmware: qcom: scm: enable the TZ mem allocator
To: Kuldeep Singh <quic_kuldsing@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Elliot Berman <quic_eberman@quicinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Guru Das Srinagesh <quic_gurus@quicinc.com>, Andrew Halaney <ahalaney@redhat.com>, 
	Maximilian Luz <luzmaximilian@gmail.com>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@quicinc.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Deepti Jaggi <quic_djaggi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 11:30=E2=80=AFAM Kuldeep Singh
<quic_kuldsing@quicinc.com> wrote:
>
> > > > As we're not moving from the callers freely allocating what they ne=
ed,
> > > > to a fixed sized pool of 256kb. Please document why 256kb was choos=
en,
> > > > so that we have something to fall back on when someone runs out of =
this
> > > > space, or wonders "why not 128kb?".
> > > >
> > >
> > > If you worry about these pools being taken out of the total memory an=
d
> > > prefer to have a way to avoid it, I was thinking about another
> > > build-time mode for the allocator - one where there's no pool but it
> > > just allocates chunks using dma_alloc_coherent() like before and pool
> > > size is ignored. Does it sound good?
> > >
> >
> > Or we could even have an argument for the initial size of the pool and
> > then once it's exhausted, we'd add a new chunk (maybe twice the size?)
> > and so on.
>
> Hi Bartosz,
>
> Thanks for shmbridge patch series. Few questions.
>
>         1. With current design of every client maintaining it's own pool,
>         For any target, we might end up occupying lot more space by
>         different clients than we actually need.
>

Technically there are only up to two, three in the future with scminvoke.

>         2. Also, there's no option to configure pool size for each client=
 at
>         runtime level and a fixed 256K value is chosen for qcom_scm/qseec=
om.

You mean via a module parameter?

>         Pool size will be same for each target and thus making it less
>         scalabale if there's adjustment needed at target specific level.
>         Ex: For a low DDR memory target, pool size should scale down acco=
rdingly
>         as 256K will become a big ask but there's no way to choose specif=
ic pool
>         size for just one target.

Do we really have any low-DDR platforms that would be affected by this
change? Even for db401c the 256K is a tiny fraction of the total
memory.

>                 2.1 One way to do configure custom pool size value is to =
add new
>                 property in qcom_scm/qseecom or client DT node and then c=
reate
>                 pool of size with this provided value. Though there are w=
ays to
>                 tackle this, but still clients specifying it's own pool s=
ize
>                 will always fetch more CMA region than what is actually n=
eeded.
>
> Can you please share your ideas as well for upcoming version.
>

I will propose a new solution with several configuration options for
pools. Including scaling the pool size as needed. I hope to send it
this week.

Bart

> Regards
> Kuldeep

