Return-Path: <linux-kernel+bounces-79441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCE786224F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 03:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15D54B240AC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6637E101CE;
	Sat, 24 Feb 2024 02:27:39 +0000 (UTC)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD4E4416;
	Sat, 24 Feb 2024 02:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708741659; cv=none; b=KVKKym7Yb7cBvwnUy/JwRucJwG02zgky4SUYYkkezJFID9xaTM4d30JYbaAxY3ug8jnAy23SXfEM25aXQBLGnmC3eQeMij9fl13znASmI9zoP7tkFmWiX34mgWtll5KWjNNd4fTrsk/sFIDmJVcl8LZ0SnufcchCFxO2nw5Ys8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708741659; c=relaxed/simple;
	bh=SnnpXhRiXHZaJWui/ynS44fsl2ahacrRzi43O20s2Mg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p3/0Vctbxp0t3j6s/949TojPGV0gcvSHTWYNb9wQ7R10h0r2KHBo3k3xDI5RebvmTa6jjprxntDYSF+UM2JARuLaT+iOn0qo5HJe13zNtUGi7r45Ba6EDdqv/82UB1BUcgEndfq45p92wWMWW/senM6HfTAAYE/D8euGA3hcEE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5cddc5455aeso1340503a12.1;
        Fri, 23 Feb 2024 18:27:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708741657; x=1709346457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3eFeIpWyw0JX2LXENpyJpoKJYL5eW5CDm89clQT1CXo=;
        b=q9VXi26rgCfa9b4PCWL4ze0B38OMQWPsCpn+yY0ZVFCaDg2r6DGS+zk/D67fXO/b6O
         r8404biRwrdnyJSGgq98bVA5slLH4CWGzdA8JQzKmMsQxN3istaNonNM48xd6/KsTjFA
         CWRrH5YwnJsacP5tkB8PeOK2UpgcBf6xxplRp5d3KJpNODSuDUqvBw5CwsuCOZX06K/U
         wxRNzwZDWzSkiYUy1a//56Q5+ZCjj8kiqjZgTqb+1ri6b+nSZgElXn0ZFlSZhcf/moLO
         gXrebSYPo/Rea8l9kmLfzfGDTA+eed9ka+MxCkfHnY1qfIF8cQKNdVmOdf0QFj6ukA69
         DECQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgdtPL9hmVBoBM9zcY2DH/F1Sn0iy6HDNirhhnUXAe/pIekmsq1exUzFCSjiLPh15rsP/aUYK7mcsRKY//Z8t4992zY+7imv44V6SWgePOxtgkg3hy11Z9N81H7535pBSvhMys4xIvkq92JX1aOQ==
X-Gm-Message-State: AOJu0Yw+37CCntuhg96Km4i81xNcn4vAs91G4jD1DZMTH9OnTxQ5fFSf
	uPl1MsDMM409XuT2jIJOdw/ow93ZnRsjQVXrv+74Q0z0GT/nz0KSeaKIH1GXgC+Izo+w4X/R3Yl
	nA/YGikQkaeBORQhOmy9zU3LcNOA=
X-Google-Smtp-Source: AGHT+IHqVqHVttZpquBqRuC3S3h2BN6FKvmXVVp8hoov/EKaZg9Jim7KyH/g1jdrYG6Q16kH1FSmYChpSEC5GNstSS0=
X-Received: by 2002:a05:6a20:428a:b0:19e:aaba:a7cb with SMTP id
 o10-20020a056a20428a00b0019eaabaa7cbmr1765148pzj.39.1708741656872; Fri, 23
 Feb 2024 18:27:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221175210.19936-1-khuey@kylehuey.com> <20240221175210.19936-2-khuey@kylehuey.com>
 <CAP-5=fXsv7TJ_SVOZc38fN0gn+7cWBcMWt3FdVLcs5v0_vO=uw@mail.gmail.com>
 <CAP045AoSHWoOP3TN=6Hf2wZj7X9Y41sThBQWCDZ3BEP68qeTBw@mail.gmail.com>
 <ZdemibZepMqWvv6U@x1> <CAP045Aqc6woHGYKJG4d=x4gPd0=PmrLeFv25Rkts1a8xFuocOQ@mail.gmail.com>
 <ZdjdAKIV39A-jpR5@x1> <CAOp6jLZKZKyYrJrzjZ90ZdxzzuDV0wp+XS3Rzssd-kvZV45JSQ@mail.gmail.com>
In-Reply-To: <CAOp6jLZKZKyYrJrzjZ90ZdxzzuDV0wp+XS3Rzssd-kvZV45JSQ@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 23 Feb 2024 18:27:24 -0800
Message-ID: <CAM9d7cg1RDHhaNr94+Gbk+UqZ18gidwDMJnhH2ad1E0Tw5X1xw@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf test: Test FASYNC with watermark wakeups.
To: robert@ocallahan.org
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kyle Huey <me@kylehuey.com>, Ian Rogers <irogers@google.com>, 
	Kyle Huey <khuey@kylehuey.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Feb 23, 2024 at 1:44=E2=80=AFPM Robert O'Callahan <robert@ocallahan=
org> wrote:
>
> (I work with Kyle.)
>
> IMHO this is more of a bug fix than a feature. `man perf_event_open`
> expects this to work already: "watermark: If set, have an overflow
> notification happen when we cross the wakeup_watermark boundary" and
> later "Alternatively, the overflow events can be captured via a signal
> handler, by enabling I/O signaling".
>
> Bug fixes need regression tests. Such tests should fail on any kernel
> where the bug is present. It seems strange to expect each such test to
> detect whether the bug "should be fixed" in the kernel it's running on
> and skip when that's not the case. I haven't seen any other project
> try to do this. Instead (as in kernel selftests) the tests, the code
> under test, and any metadata about which tests are expected to pass
> are all in the repository together and updated together.
>
> It makes sense that tests for the code in tools/perf should not fail
> on older kernels, given that the code in tools/perf is expected to
> work on older kernels. But tests for bug fixes in the kernel itself
> should be expected to fail on older kernels and therefore should live
> somewhere else, IMHO.

I think it makes sense to put the test in the selftests and to be
deployed with the kernel.  AFAICS it doesn't have anything
specific to the perf tools and tests the general kernel behavior.

Thanks,
Namhyung

