Return-Path: <linux-kernel+bounces-108112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C681E880617
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 817BD2833E9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1F23BBDC;
	Tue, 19 Mar 2024 20:34:19 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CA93FB80;
	Tue, 19 Mar 2024 20:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710880458; cv=none; b=uN6v9eIQGb49xwEI6CfmErj8TPMZGR1udrMQBOx+XfxQ0TZJMGFdiGOaZk/XNAtNC92NHftT8MS3VjeURgSudYhO8rJFQ0lUk1NnAC5ATAdZ6OhCNQKAqVCGDZ6C3m5O4oPSWutQrry16kodMrl7XOi5bOutWNdwXMHOWsmXQvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710880458; c=relaxed/simple;
	bh=fiaVOACM/C/ner0zjz+kZWrpVYTb+WyH0bwNXulDEN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mvS2o4r92A1+ZhFbMJLaAt85S4XrrP2C2rZ9CScA3i+tDVtKuGYQRM/AUo7maAZqt5a1J5QLHdS7SiAYXmFPMbsFA0Rw05dwrujz8yrwSbKRBrcmSiH6dxiIJ0SmVQ3m02Nb3G/5Gvu4ovnNOL/SNrsJRrjZxZfWYQEL4FdvfEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-29de2dd22d8so3013214a91.2;
        Tue, 19 Mar 2024 13:34:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710880456; x=1711485256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o+Df92XRVdf3D86q1MMjvFQKOFIc+7iDlGP6UKYnwIg=;
        b=AiCpjm3f78tN+kGNHOtXIgZnXUqRN1W33iKnVVZjrwrn8teLTMX4bFoGUJ9lwVCUEQ
         8ZxQKh/gpc3Okz0S2yoPiz0GE3NkXV5NQI9KjWoWkXvx9qxVnvnn7txe6xFAHerXfksP
         SLpYPjY5QTqOusX5spQaWWDFEgXdgYNCJg2W18dXmcyz2zBBc5L7UOaLpVistWxIgc/t
         5kBnZ8gmcEIisSmDbkTwAo8FJvBxfmpslEOA1NrjyVFejxQ+l4saSutmBoUnKramTOxC
         XS+bXJ1lJn5Je0tgH/w8zvav9XHK2I0y4v12gkr7uX3Qb8NzS2xcOwBYgMoWsgCO3bWW
         FYtg==
X-Forwarded-Encrypted: i=1; AJvYcCV3BD2NdVMhRNCwFwS+TAbmP6APoEaII33M9jgT0JE4VPCjJ0j3pK1CuIQlq7vd+yg4DtVsjGZLxTg+xz1u/jjL61N+wjCFUtnqFn8macEl+QhvvTZxsBr2WP2ncnRHtEyApctkUhnwXb6V4NaE54k2XI8/Ghoam3z+EQI53xpTUouM5V5LEyyCAdK/dxbJAYM/OWdFIcX2nNKWgwcEGvW/NcwtkkE6lIqF3DilAmSGF4wzJA==
X-Gm-Message-State: AOJu0Yz/nEjIDv+cJF116HAhNbxv8F90B4+fa4j07aFg+Pc/HcK6hDOu
	V5bQrn7udDT64BdzWN8E9ClszGCni+nOUZoChWvMajImPZIFP9v7rrm2t1+LIXRhcIBPM7UaUTc
	EnpheVLDNCL4NmR/bcso2/3s9jnM=
X-Google-Smtp-Source: AGHT+IGys9w9aG0aICGyKYR9HP8qtBimUlfM5OddAjz76RdcTxWoj2zCmFD78V8jRzfaZ16Yg9DhrKkOuqZ7xz82XQU=
X-Received: by 2002:a17:90a:6c42:b0:29b:b3fa:b7a5 with SMTP id
 x60-20020a17090a6c4200b0029bb3fab7a5mr13418863pjj.7.1710880456588; Tue, 19
 Mar 2024 13:34:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319055115.4063940-1-namhyung@kernel.org> <20240319055115.4063940-10-namhyung@kernel.org>
 <ZfmcN4YuvQpVgJQN@x1> <CAM9d7cjatKSH7hw_sC3MCmY1fYT+bDBgSpFWJg=RM2oqgL5X0A@mail.gmail.com>
 <ZfnVjPlo_L5l51Bq@x1>
In-Reply-To: <ZfnVjPlo_L5l51Bq@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 19 Mar 2024 13:34:05 -0700
Message-ID: <CAM9d7chUL9P5xBqezArz5sh4e+PFemCPCPt+a+PphGXJJYjRmw@mail.gmail.com>
Subject: Re: [PATCH 09/23] perf annotate-data: Maintain variable type info
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Stephane Eranian <eranian@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-toolchains@vger.kernel.org, 
	linux-trace-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 11:12=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, Mar 19, 2024 at 10:44:31AM -0700, Namhyung Kim wrote:
> > On Tue, Mar 19, 2024 at 7:07=E2=80=AFAM Arnaldo Carvalho de Melo <acme@=
kernel.org> wrote:
> > > > +void exit_type_state(struct type_state *state)
> > > > +{
> > > > +     struct type_state_stack *stack, *tmp;
> > > > +
> > > > +     list_for_each_entry_safe(stack, tmp, &state->stack_vars, list=
) {
> > > > +             list_del(&stack->list);
>
> > > list_del_init()?
>
> > Maybe.. but I'm not sure how much value it'd have as we free it right a=
fter.
>
> Usually the value is in catching use after free more quickly, i.e.
> someone may have a pointer to a freed list and then it would be able to
> traverse the list of freed elements.

Ok, then. :)

