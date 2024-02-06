Return-Path: <linux-kernel+bounces-55719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A71B84C0C0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 00:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 475FC28448A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA761CD20;
	Tue,  6 Feb 2024 23:19:01 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6251CD17;
	Tue,  6 Feb 2024 23:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707261541; cv=none; b=KEk/0DtTytYfkHDBGt2YaGdkQqgBrytHvmtUtpqropeHnE3oPwxui3WvfjedJtbCIowfXkBwfcSxFPhqzDdbNOgGUP7JNmfv+98d1PKhQ2SvPF/Cz0Mv+9uqSHd2Alu3z2VR/R5DQtFLJSwVRMwt8QR4skDWMR2otQ1iabt2EYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707261541; c=relaxed/simple;
	bh=sMgP9pFFHrMMIn9L5CwdZGP8g4NZPoWoa5cyyu4+TPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lzDozJQbKNZc4VuZFcX2vAcoZDq+sNq1Vg+orY1OfH/wQfTzfb0ftECesE62Nmp8ROLBaH+toI4P85dP6VW993afqsZnwNlcjFnb4w4sBovs+ew75VMacuOvLLJDf64Btvaq90k8rRZDFoyH3ZOlLur84Irk2j+y9TxeBlB03vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d93ddd76adso564835ad.2;
        Tue, 06 Feb 2024 15:18:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707261539; x=1707866339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jPqZ7Ip2aFum8KHXYgnBN94F/8KhHuRmg9GEgL52ccE=;
        b=TgyFbeKVfis3Q9Z85XbqgfMTqjAQC/+uo2VirVhIMbhJ8/iccl1qWhQXhZ1YfXiiIm
         6EV3Z7kwJr9R1cKKtkzCphhXDBtU8vHuj3FQVpqTUCkS5dYtSYY5N/zcglAtdBWGmxiD
         MsdZP7jR7SthRPzs0H5n6ZGpvnopEJjKL/Tyegdjdk+hB8qvsP0aAzQArmHfjVHxy4r/
         azSYk9fN5TliBWiIsW8TtODsOd/W08zAHkThHFiM8KvSFRvlnupUtp7qGuc9YemRdBAG
         PZeawswNQEE4dUnf3ffXbESrixlfXfFd/vpmcgQf7KNws4ACg7Ori6Yqq/gOk0qJz8E3
         NNhA==
X-Gm-Message-State: AOJu0YwYx2goUwneLsSxVowUj7HrY5Vgiv9PgCZAIJOUmlf5gDjfeWfV
	AxJCeVf5CfMlTU/NEs9604Riqt/vRifH3XHi4xDAkowyiDGvVgssbPfZJbq6n9EGdIKRnA0kpye
	/kkZn/QBLxThaNpQcCvyav+jFBwI=
X-Google-Smtp-Source: AGHT+IH0Nbp2ZG0q/KxIx/5rXv4XbMfUBvfmRpT7CqVh2nDBPY/iQD8QZaXEJvTHi/33Rw9rH4VqpsbXpfH1iFVwUbg=
X-Received: by 2002:a17:90a:ac0a:b0:296:235b:ac61 with SMTP id
 o10-20020a17090aac0a00b00296235bac61mr1162467pjq.32.1707261538839; Tue, 06
 Feb 2024 15:18:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202220459.527138-1-namhyung@kernel.org> <20240202220459.527138-15-namhyung@kernel.org>
 <CAP-5=fUWaKW7d6_YkET0o26=fjBwX6PPJ1gXQ9wndQM_Oi2O3A@mail.gmail.com>
In-Reply-To: <CAP-5=fUWaKW7d6_YkET0o26=fjBwX6PPJ1gXQ9wndQM_Oi2O3A@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 6 Feb 2024 15:18:47 -0800
Message-ID: <CAM9d7cgF_PYm2fG1Vgu25u1hVZUK0wmFBqY7DHW2eVpRV=iERA@mail.gmail.com>
Subject: Re: [PATCH 14/14] perf annotate-data: Add stack canary type
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Stephane Eranian <eranian@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-toolchains@vger.kernel.org, 
	linux-trace-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 7:21=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Fri, Feb 2, 2024 at 2:05=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
> >
> > When the stack protector is enabled, compiler would generate code to
> > check stack overflow with a special value called 'stack carary' at
> > runtime.  On x86_64, GCC hard-codes the stack canary as %gs:40.
> >
> > While there's a definition of fixed_percpu_data in asm/processor.h,
> > it seems that the header is not included everywhere and many places
> > it cannot find the type info.  As it's in the well-known location (at
> > %gs:40), let's add a pseudo stack canary type to handle it specially.
>
> I wonder if cases like this can be handled by debug info rather than
> special cases in the tool. Special cases are fine too, but are
> potentially less portable.

Agreed, but I couldn't find anything special in DWARF.

Thanks,
Namhyung

