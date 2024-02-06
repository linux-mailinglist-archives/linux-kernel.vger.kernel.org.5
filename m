Return-Path: <linux-kernel+bounces-55713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AD984C0A5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 00:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 982821F252E9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6523B1CA9C;
	Tue,  6 Feb 2024 23:08:09 +0000 (UTC)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D1A1C291;
	Tue,  6 Feb 2024 23:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707260889; cv=none; b=Rw8isMZ18ODTHZ6wvJXdVXGMcA5XobWjE5KP+bMqnvfIDwwWQ2R7X3LJU4pwfRBQlbmOiE4wGeXD49AR4w684BURRyTBZ/sWJP8yq4BZO2XBF6uAvAkOlFzKjZTiQEPkPE83x4/ojw+N10kjf7i2cnTP0hKe58ZQaSNRdmN4iiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707260889; c=relaxed/simple;
	bh=4SlSmuGQIVhntf3X9E15+aMQ2hWS6HXbFc0a4FNeJRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ct7/tVK3hjpmz+9sOOzRQZ9bhKYP3z59jKUcZSJC+bkMbVa7+bDBCeUc/xqIkNACjieNagGVmcEqzTcQOjNXcZHvnJyVJJCHnVP7stvx120rhG7gSgXyFr3EvsTEwJJkel3LHMSh/9PPXcA64QV09RRTucWKpwMgOUcgedvzUqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d8b70b39efso5530249a12.0;
        Tue, 06 Feb 2024 15:08:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707260887; x=1707865687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=70rMlUj/f4yFlFZOs4vDIs1qT79AEOwrI22oowIL9DI=;
        b=CN1yoCjXqBRGMuyA7lK0Tt6j2NZBscewqXlW2IwVALB/kvFZtAkwEblx+//RmX02zE
         7t3+dOflpH1hJo+DhFsG19yuYlEuozEf9xtbSwF+wKEES0QjYJWJpIgdQTeN/WSApeIO
         lmg/I0TUFlt9WpzWzLhCyQXrwZAyE+7cBpBqkCDG7isUDK6UQM4LLJclCBjtiArhx4Iu
         kQpuqLrGQUMu/MTPs/5IbSwWKVGO69pNr+zKUhkN1E8EdhXmaI2ThY2GBJt2042IqHGM
         /le3Nh8BcI3wKKQ7qWV6l/scEZoHXEgrTrNEuT2JZjJJQVMuLhhrd8tnkkDA8ej9IaC8
         l4BQ==
X-Gm-Message-State: AOJu0Yx8PguNzSQGRHgXtNmTLGN0irq3CCnU1bkdO3UMkkhByWJVLI0K
	mp48tN1P0Db0Iut0ipcxJlzEnRrBArVCp26i2XehkgkvvWpe6m1gP+JdfuZ74sqmSNNSGvYz5gf
	qCskZjNGe308cNj182j3Zb1tc8OU=
X-Google-Smtp-Source: AGHT+IELZtzKIwJRTrwnchugugfXY2kssrUQvemsEbA+JOQUIxUfv6YxSY5KSlWo/fB9I5EnVEXbO9uVFfCqzxdEam0=
X-Received: by 2002:a05:6a20:d42a:b0:19a:fa19:23e7 with SMTP id
 il42-20020a056a20d42a00b0019afa1923e7mr2779992pzb.55.1707260886653; Tue, 06
 Feb 2024 15:08:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202220459.527138-1-namhyung@kernel.org> <20240202220459.527138-8-namhyung@kernel.org>
 <CAP-5=fUWbe-owCHsjQfOuTyt8kEzM_M_4GqS_rqKwL9VY3tJOQ@mail.gmail.com>
In-Reply-To: <CAP-5=fUWbe-owCHsjQfOuTyt8kEzM_M_4GqS_rqKwL9VY3tJOQ@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 6 Feb 2024 15:07:55 -0800
Message-ID: <CAM9d7chabk0Rt8a3_uesVFBF90yVM=Pw9FALq5V2ZGSY4LmnDg@mail.gmail.com>
Subject: Re: [PATCH 07/14] perf annotate-data: Add update_insn_state()
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

On Fri, Feb 2, 2024 at 6:49=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Fri, Feb 2, 2024 at 2:05=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
> >
> > The update_insn_state() function is to update the type state table afte=
r
> > processing each instruction.  For now, it handles MOV (on x86) insn
> > to transfer type info from the source location to the target.
> >
> > The location can be a register or a stack slot.  Check carefully when
> > memory reference happens and fetch the type correctly.  It basically
> > ignores write to a memory since it doesn't change the type info.  One
> > exception is writes to (new) stack slots for register spilling.
>
> Just an aside, it seems a shame objdump can't do this tracking for us.
> objdump already augments its output with symbol and relocation data.

I'd be more than happy if objdump can display a relevant data type on
each instruction. :)

Thanks,
Namhyung

