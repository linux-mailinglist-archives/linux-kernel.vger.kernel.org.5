Return-Path: <linux-kernel+bounces-40638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFF383E37B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB7E7288DB8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235E124211;
	Fri, 26 Jan 2024 20:50:00 +0000 (UTC)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C581DFC3;
	Fri, 26 Jan 2024 20:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706302199; cv=none; b=kTJw3Gl6eCBK50r06re95Ehv4/9JtKauQdkWrBr+MX6y9YDLcZgKHrcDL+GLDGOszMQN9uAg90AoBWgP7nuuyyk1oqyY3+A8xtKG4rAkuplLUMU6Ipct4NgDxmWlj5Qpzuk+qr8mdOLhUeD10xW3Lozzo6tYTIkczjJ8U8R4XgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706302199; c=relaxed/simple;
	bh=WUCo3DsqSu+xp9J259B/yB0VjfJa5aocRq+qn/8C2ko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u8Ba06MhxKu/rplfKfec6BqfJ31wFdpVXn75IuhaOeBBNezKlfAuOOtpOp5ccApqKNMZGIW5ogqMBIaEWdg7h9s1BtO52c+2VMZqsfdK+aqOXbYgzq6biGPayILRybH8de+pE4ePu98FIm7wTwTvpClkY2PcemJ4OM+6iZwkDAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5d8b519e438so49082a12.1;
        Fri, 26 Jan 2024 12:49:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706302197; x=1706906997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQ4nTS4z+tVgC2LfEv/bz+uRmrT1UsRs1Ku//2FW3Uc=;
        b=u5j0kJyU485Jy3qD6G64vyCJbpQgFGCY7D3yG/1/dNioSjxT1yJLgMmpwtNn0dIO/P
         2QIl0C/6Cc7cCt7T2sqSxpFQ8M5ZeCKjmOAivvZG3F8bpRruurt8RWKrV4iCaN11hsuo
         ItX2UW0w8SqT5ur9XN9C+TIEe39ZyaZGMv91DSLdvahd56iY7MZtRKZctbLYC+c/MnB7
         aJcSvQJd3gurKlvRz627vLrCZ1U1qSrGatrL7aWntMCtDhV/dAW7viYWM/I2JjOChbo5
         mY/ec88QrqG3OQeUjcGQ0cbfVSj7xhyt9r0cp25rgbSUgwmThY5Nz/Sb2UQm2/ARP70j
         KOXg==
X-Gm-Message-State: AOJu0YxUxIMGRMu6Quw1XxIcT4/YQEAiyP8nAfUU9IoAaX3sM4+z+h5J
	ctG0dPRWqdzWDrVpQA6bLuFbqx7nJbyg+2Fg+goQE0kqp9gyrnnoyTBChgFPnGtb8zkqsbh3viA
	PI8tlYhvwIrlFou0uVU74smUorbQ=
X-Google-Smtp-Source: AGHT+IHMHf/VH9W8vq/6LNupg16ScO/Onos4Ai07O/lAAWEJf5+LZMxqflq7q2//LzppK7+LnrZaNv6OhCPGV7WAyR4=
X-Received: by 2002:a05:6a20:1614:b0:19a:7a0a:7fdd with SMTP id
 l20-20020a056a20161400b0019a7a0a7fddmr413995pzj.49.1706302197470; Fri, 26 Jan
 2024 12:49:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123102728.239147-1-james.clark@arm.com> <20240123103918.241423-1-james.clark@arm.com>
 <CAM9d7ciSY25Jf-MG24NWJu3aKJWXT2GN43qrV5WCuohLNZn1iw@mail.gmail.com>
 <ea054381-6ba2-d2f6-8de4-978a78a2ed8b@arm.com> <ZbPc-1sqFgb7dJlF@kernel.org>
In-Reply-To: <ZbPc-1sqFgb7dJlF@kernel.org>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 26 Jan 2024 12:49:46 -0800
Message-ID: <CAM9d7cjwaghBYiN2xs61oxBZu4cyJuACEq-ZXKNb6A3h2QpSaA@mail.gmail.com>
Subject: Re: [PATCH v3] perf evlist: Fix evlist__new_default() for > 1 core PMU
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org, 
	irogers@google.com, kan.liang@linux.intel.com, mark.rutland@arm.com, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Changbin Du <changbin.du@huawei.com>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 8:25=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Jan 24, 2024 at 09:03:57AM +0000, James Clark escreveu:
> > On 24/01/2024 00:46, Namhyung Kim wrote:
> > > On Tue, Jan 23, 2024 at 2:39=E2=80=AFAM James Clark <james.clark@arm.=
com> wrote:
> > >> +++ b/tools/perf/util/evlist.c
> > >> @@ -106,6 +106,13 @@ struct evlist *evlist__new_default(void)
> > >>                 evlist =3D NULL;
> > >>         }
>
> > >> +       if (evlist->core.nr_entries > 1) {
>
> > > I think you need a NULL check for evlist here.
>
> > Oops yes. Or just return on the error above.
>
> Was there a v4?

https://lore.kernel.org/linux-perf-users/20240124094358.489372-1-james.clar=
k@arm.com/

> I'm assuming this is for perf-tools, i.e. for v6.8-rc, right?

It fixes 251aa040244a which is added to v6.5.  So I applied it
to perf-tools-next, do you want to take it to perf-tools?

Thanks,
Namhyung

