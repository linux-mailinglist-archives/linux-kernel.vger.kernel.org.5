Return-Path: <linux-kernel+bounces-57474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A865884D98F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB7921C21BD5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 05:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71E267C5F;
	Thu,  8 Feb 2024 05:26:22 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2238767A0F;
	Thu,  8 Feb 2024 05:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707369982; cv=none; b=E0jkGWJhuRkDnhY9bOsqVeyQnxlaFeSL1DwjWcmA/a+2AgmyIy1l+vyXXABHXUZa3xji2YcqSXx6BwKnuN4obRkL2+ZK4DmZlCCQwt7twT8bu7aTOv7aQar/qTsL6SoxnRcnCWh5z3MMEV5XcyoHVaO/5aqCHxfaXz1UK/gwyWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707369982; c=relaxed/simple;
	bh=CYTtPNfSRJs5mB/fUFazg3aKNjzmFnV4jPoEkXWvqng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SXA2Or3MEBKSgAaNilcGXHVQ+Jd2pFXWSp+ej+KwkaoYvUhbYTHfT3qBmiIwcxczs6rGAFH7hn9ikrMQs8frU8CqMR0sqPJQU8qPpj01el2u50We86n9vEAsMqcZ+vjnik7Vp2syA+Im8BDMBgUfIETwwpFMxHaHVCs4Tfvu7dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2909a632e40so1040582a91.0;
        Wed, 07 Feb 2024 21:26:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707369980; x=1707974780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/39RKiJJNQKtN2OpG5VKmulmLADl/ngUFHTYECJgqX0=;
        b=vKy3PrIsf2DBFm3P8COX2Z+n6jiPnxJ/XE0Q+8nBus9Hgm9JXLvxDjb2U+2/5FAcix
         Pt6da6mUYVH31qxFz47yhi59Ovum5cOV6mZScnp01fM2wvvfU/HCEG87WuuUqZwLZBEh
         wQlKeq6EeurZ43X9OdR0e26AVfE9TZvSoOeHL+1Qwy7905Ycym3uiom2QvT0YtJZkZL9
         BQ5mqCZjrQykl6yeOr8sdH6OIEYNk9gybkIy0f2dG7FYE/HcCjlYPTx7F7+BqVqBpYKN
         4yCN6NX8kNBRx5WNsI3bTtMjoCRYyqCZFmBuOiYgXS/JaUFDk3VEs84a627J3ayL1cY+
         GoQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMu2Xp39BLxQeBNpfJpaxSi+BxopHtCk76D6u5jJ5MK6QSKFATOSnI3aZfoK9E96XaOs8y4up4opW4YUPkZ5Hc94hXJz0BgkHuDJJ4OSsjQuaabf8QssMBhykbwDGXzRtctNEeLKA3cvORNF9nhA==
X-Gm-Message-State: AOJu0YxOP73autk92LZgWL+p1/jp2C8Q8uDowFtadumhHiYUrZJvRSW2
	NE6XFE0pJSNs/zjVRV8m92jZ3RYoTTWI/ITjcbYUL99B2bA+PYoPvsw7NSsvhYJPPzwzZBCKtlV
	oD/9bWXffERbJRdksK5DGqioohB+e0yKiVSs=
X-Google-Smtp-Source: AGHT+IHHwstYVfAITxXLYj6k/D6aIkVoH+9yxqs36Cbh6NeMlBj6BPhM4SjkLIZTKJOZYxVcWrsO1LN5TF8UgQR6M7k=
X-Received: by 2002:a17:90a:6f63:b0:296:2101:5d35 with SMTP id
 d90-20020a17090a6f6300b0029621015d35mr4509549pjk.44.1707369980162; Wed, 07
 Feb 2024 21:26:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206130458.8867-1-adrian.hunter@intel.com>
In-Reply-To: <20240206130458.8867-1-adrian.hunter@intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 7 Feb 2024 21:26:09 -0800
Message-ID: <CAM9d7cjiCT7C=WHd9EmPRRRQY=1aq8-NAGgRcZPWz-s=7Js3mw@mail.gmail.com>
Subject: Re: [PATCH V2 0/2] perf symbols: Slightly improve module file
 executable section mappings
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Like Xu <like.xu.linux@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Adrian,

On Tue, Feb 6, 2024 at 5:05=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.c=
om> wrote:
>
> Hi
>
> Currently perf does not record module section addresses except for
> the .text section. In general that means perf cannot get module section
> mappings correct (except for .text) when loading symbols from a kernel
> module file. (Note using --kcore does not have this issue)
>
> Here are a couple of patches to help shed light upon and slightly improve
> the situation.
>
>
> Changes in V2:
>
>   perf tools: Make it possible to see perf's kernel and module memory map=
pings
>     - add dump to perf report (if no browser) as well as perf script
>     - add 'perf --debug kmaps' option also to dump kmaps
>
>
> Adrian Hunter (2):
>       perf tools: Make it possible to see perf's kernel and module memory=
 mappings
>       perf symbols: Slightly improve module file executable section mappi=
ngs

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

>
>  tools/perf/Documentation/perf.txt |  2 ++
>  tools/perf/builtin-report.c       |  2 ++
>  tools/perf/builtin-script.c       |  3 ++
>  tools/perf/util/debug.c           |  3 ++
>  tools/perf/util/debug.h           |  1 +
>  tools/perf/util/python.c          |  1 +
>  tools/perf/util/session.c         | 11 ++++++
>  tools/perf/util/session.h         |  2 ++
>  tools/perf/util/symbol-elf.c      | 75 +++++++++++++++++++++++++++++++++=
++++--
>  9 files changed, 98 insertions(+), 2 deletions(-)
>
>
> Regards
> Adrian

