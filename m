Return-Path: <linux-kernel+bounces-28507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B903382FF64
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 04:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DCD21F271CD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 03:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0CF53B4;
	Wed, 17 Jan 2024 03:48:48 +0000 (UTC)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6284687;
	Wed, 17 Jan 2024 03:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705463327; cv=none; b=RVCZ6v5wDAq+N3hAZLzx10tElW4V6Z0tiMgNuhv7dpigQqlCTEy4ThobplU/gJAJkA8I/bco+1LnsuxZUYsJFIMhbbtIMV30rUylrqHG88h2zcjVT/0kvsUl9J5OiEMjEd36iugQdwbfNcGM9z+Zunlamy2mg4E2vsNvQdAFKQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705463327; c=relaxed/simple;
	bh=iIDvoHwENUYEtwr8g5Kjbl7iYE5o25mmG9HuxzdDrw8=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding; b=Etl6ezvNP2vhYdxrpfKMkgzuuZ58OEzYTuKgkZHQ56FtxyrlGv1gwATVaIHJDX2eWlMnA9mxZk8KnUlxjHmCt3cqwJgj99Go8sPO0MI8ABxpo0J4YA63MguDq3Ik8GlbSSDettxOh344DkFlT/N4s+vI//ICABHy+VjASsP4ouE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bb9d54575cso7160811b6e.2;
        Tue, 16 Jan 2024 19:48:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705463325; x=1706068125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8EwUOa5X5P/YX7wjujaj+MUMpZ38ko2iPMLPvD5zl0M=;
        b=f9sg8xJz77XM8pdjMmOBZBiKSrqnwhCXm3N427z++3Ck+6M3iwUiWmXNXg32Ez7qqp
         tU4V+jdnCeXkmk3JWCL2nBF69soc0YAwTwHdLpSzhrl56IL255eXLLyxtMcHr/ddXNlv
         EC/h9nqnPnM0rzsb64jYx9W9BYcl1CzsYE77sr4csDDBju4plO6rHH4/4+wIEHb5vgpv
         xQeHc6dXwPT2X1N8Z3SVIfzFynAkyTTXuZCFaj12YTdU1MVQ3L+sCp1J6fDZRG+VhYtp
         E8CFTd0l+w7TYYppEH+yEBTA67gdC4dxaZ5z81rhXdR+DmxxZh6AviDI/7Q4/ZbdClvf
         Q74w==
X-Gm-Message-State: AOJu0YwmzUQPF/IgATbCBIw57jZcADNcQ1I27/Imo8I2nYCmd8er7oph
	QocWKjYWxp5N/4uj0QkxuLXuSF3THhqSTwMGqKQ=
X-Google-Smtp-Source: AGHT+IGXASK/Ubyh7n4OWU7EmiWGgvRQnRO09LODofArwWh9OnKhXfVcIHodYTBOSPq8iAWR2inqr/oMDYyRZb1/bmg=
X-Received: by 2002:a05:6808:3197:b0:3bd:5960:4f5b with SMTP id
 cd23-20020a056808319700b003bd59604f5bmr10530239oib.0.1705463325015; Tue, 16
 Jan 2024 19:48:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116113437.1507537-1-changbin.du@huawei.com>
 <87il3tl6zf.fsf@linux.intel.com> <20240117024546.2npqrprazaobyogn@M910t>
In-Reply-To: <20240117024546.2npqrprazaobyogn@M910t>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 16 Jan 2024 19:48:33 -0800
Message-ID: <CAM9d7cghAPQ+xg=DA1E_YD3SR8afzt+fS15cU1FUA7YLLYDuLQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] perf: script: Intro capstone disasm engine to show
 instruction trace
To: Changbin Du <changbin.du@huawei.com>
Cc: Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Jan 16, 2024 at 6:46=E2=80=AFPM Changbin Du <changbin.du@huawei.com=
> wrote:
>
> On Tue, Jan 16, 2024 at 05:53:40AM -0800, Andi Kleen wrote:
> > Changbin Du <changbin.du@huawei.com> writes:
> >
> > > This series introduces capstone disassembler engine to print instruct=
ions of
> > > Intel PT trace, which was printed via the XED tool.
> >
> > FWIW at least on x86 in my experience capstone isn't that great an
> > disassembler. I used it in another project and ran into many decoding b=
ugs.
> > They're mostly in obscure corners, but can be fairly annoying.
> >
> If so, I will preserve the old --xed option as an alternate.
>
> > My other concern with your patchkit is that you change the default
> > output formats. Since perf script is often used with scripts
> > (as the name implies) there is a certain expectation that the output
> > remains stable and parse-able. There are actually use cases where
> > the raw bytes "insn" output is needed.
> >
> > I would rather define new perf script output types for the new decoded =
output,
> > but keep the old alone.
> Agreed. What about these?
>   - Add a new field 'insn_disam' to display decoded output.
>   - Add params to '--insn-trace' option, that is '--insn-trace=3D[raw|dis=
am]'.
>     'raw' is the default value.

Sounds good.  FWIW capstone has been working fine in my
experience. :)

Thanks,
Namhyung

