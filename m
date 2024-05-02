Return-Path: <linux-kernel+bounces-166834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B24F8BA03F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C1D41C229B2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08A117334E;
	Thu,  2 May 2024 18:23:30 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB1C16F90C;
	Thu,  2 May 2024 18:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714674210; cv=none; b=bm6/JxYtdP+twv3jMFlSjsZMNlztC49SIGSA53c7KHbcvaWnul8cX86B5dhQybU568VldpmIt3iNGSJw+h1n22nlhdGi80ceiGWNoGvDld/oSAFJSLh/bGx0FOoHaq4Il6B91WulkfWRGMqm+NrumxEgMNaEfGqPsn7qin6hPcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714674210; c=relaxed/simple;
	bh=UGRIpdQuVWv7frbkKdg//Yw72g2vdPMaZMx+CTeZA7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U1s68lvaKWo29FE0Y99ZWXw1wv68b3ITCD2zUOyoQk3Lg7miRb/9eAgSnz6UDeC/kcYzY8dScd2FyLy0vc2WkJoyUhcEI3J/yh8LDrVVLFbRNLrQCbPd9//FvJ14R5b7QQDWa5jL49K45FX7/6POP/ei/w95P3oapCWc98xqzaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2b12b52fbe0so3548749a91.0;
        Thu, 02 May 2024 11:23:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714674208; x=1715279008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1FoMHQWOMW5NazguqbdJ2vyAEy94LpT4il8LmHAdf8=;
        b=Vv+tblQPphPNQZu4JiAO80/I7tVWW0m/6wW2qhw4WUUrWQW5UC5KL8foFfVb0l9pMc
         1LpvQOVNGvF7QO1utv5s3/HCg6pUBhA/GtrCZd0EISvxlXytkOXMBgWEghNzNMDsY1W6
         WrqjWPvnvwqXhjmMkgiohzttocvTfd6XWnBWRgJEf4Xe3oZrAH5Tw1zWLfCkLOgCwo3y
         eS9NIn8aFsq720QAINTOdAAL4JAXzmj4c5xasANdxMMZYPuvHNaY2zJ9Au1J81RBRUo0
         VoHsxg32cIlbCxkYXeSTcE3LzIFMDp+MCu/Eq5UuxLkOTymtG9xpokk7VW6ZQZZbnZBE
         J7JQ==
X-Forwarded-Encrypted: i=1; AJvYcCWV3CqLja085+3ntb5x1qyyyqSpEi/p7ma01VGsb8RMH8+qU/LuCiVFIijd1T1XvCha5fNhAfPJBsKN+kgA506BX7+Lqee5Sbg9y660JRUWc2TMCrSjhH4sWGhNYqEI+s47johEmem8w/5IYiiA7w==
X-Gm-Message-State: AOJu0YxncASIPiz0Oj20MQfrSaLXFvIYACQhA/sDltrqJG1a7zzx0Cx1
	WaiKHPi/dr3UYtcCCYJsr+/QF/xYk19Hm0IPjoAERhPXJP+07+ymy3uG/+R/eCq4/Ng8BxQ01se
	Z9z4p0yFwDu9jvY/Z6cf6cPnZT4PKdg==
X-Google-Smtp-Source: AGHT+IELvn8wMGkyO0TmuNlmN7KfVwK+kTxu3XsielbSKO95n8QHjx2WS0argpa0lMn8GfQSKW8GZ+DdqhMJsnLap5M=
X-Received: by 2002:a17:90b:1089:b0:2b1:9fa4:16fd with SMTP id
 gj9-20020a17090b108900b002b19fa416fdmr629131pjb.4.1714674208317; Thu, 02 May
 2024 11:23:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502060011.1838090-1-namhyung@kernel.org> <20240502060011.1838090-3-namhyung@kernel.org>
 <ZjOaFS7_vEojFnUZ@x1>
In-Reply-To: <ZjOaFS7_vEojFnUZ@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 2 May 2024 11:23:17 -0700
Message-ID: <CAM9d7chGYy9X=3=iRwocUWJurXPGd0WZaE=yr8U1JkrLcaUrow@mail.gmail.com>
Subject: Re: [PATCH 2/6] perf annotate-data: Collect global variables in advance
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 6:50=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Wed, May 01, 2024 at 11:00:07PM -0700, Namhyung Kim wrote:
> > Currently it looks up global variables from the current CU using addres=
s
> > and name.  But it sometimes fails to find a variable as the variable ca=
n
> > come from a different CU - but it's still strange it failed to find a
> > declaration for some reason.
> >
> > Anyway, it can collect all global variables from all CU once and then
> > lookup them later on.  This slightly improves the success rate of my
> > test data set.
>
> It would be interesting you could provide examples from your test data
> set, i.e. after this patch these extra global variables were considered
> in the test results, with some tool output, etc.
>
> This would help intersested parties to reproduce your results,
> validate the end result, etc.

Hmm.. ok.  I'll try to find public data that I can share.
But it's just a perf data file recorded with perf mem.

Thanks,
Namhyung

