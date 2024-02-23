Return-Path: <linux-kernel+bounces-79226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA3A861F39
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECB0F2889F3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE5314CAA0;
	Fri, 23 Feb 2024 21:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail-com.20230601.gappssmtp.com header.i=@gmail-com.20230601.gappssmtp.com header.b="yPUj50H3"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F54F14AD04;
	Fri, 23 Feb 2024 21:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708724663; cv=none; b=ZDOsSd3iUkiA5t/xrSbTv4jh3YAju6gtOgsNcSuQWFl5EiUkmIkT08nRUxoGIpp1Z2Z8aX84t5cIarAJl7dCTKxepsv5x/3Z3lcSwdTyGgIgbV1fBWszU842LlMWCh9XvsgflB28u1qpZ3VurZZzFyDzJNmHvfsP9qlOK8QjTR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708724663; c=relaxed/simple;
	bh=Pe5erZHyCvS6VkWlhzfR04p/Sev+tZt7VSqDg3j4P8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SLqWKOwGeqShL6Gl+QfKdFkgdP3XpdKm6DXfTGDJvBDts0VdRztg2yq+DjQSj9UDbvCjglWLOxppja/8KP4GxIUlefhoOVkxZ3s+JgPuU1TcQxRYaDDJSrMU52y4AqMWG7Lefd+LNqdxf2whRAEUOB66zaOToYhKs2yVNRar0W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ocallahan.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail-com.20230601.gappssmtp.com header.i=@gmail-com.20230601.gappssmtp.com header.b=yPUj50H3; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ocallahan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-42a9f4935a6so6190461cf.1;
        Fri, 23 Feb 2024 13:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail-com.20230601.gappssmtp.com; s=20230601; t=1708724660; x=1709329460; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dflXWGJiHy7MbSy8pXkZb9NeeYUWtRBjyhK7A4GkIig=;
        b=yPUj50H34+iXkWP9ZoINgCfeRvzn6tJnjokRnGWvxpxq64M8AbuGVzv6z1C8niRJkc
         x8Wag+5AsU6w0Rhza3+xw0leWKf5t5FcfMPe1drtcgssIr6Jn+sVSAm8B5iWiMbZNmFw
         Ad9pFgJOzPRgXam5QpgajJz9PoKeDRSraS4lPweW3+70wUaYQaifg4xcmHV4qgyJ5uzf
         wDNIaUS57t4Le+KrJ+vaXlWNQokkXzZsn58aGSm8HyiBEIjYs+KD/qQGJ70cFvStel1Y
         t6JF9XB0CWbI0CvmQ6nBO9AV93rqcd8Xz/bJSwgNLZ0YWucR8bHz96ZXvkAkJ9O1RJ8t
         icww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708724660; x=1709329460;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dflXWGJiHy7MbSy8pXkZb9NeeYUWtRBjyhK7A4GkIig=;
        b=TeqAYOZHOStIQzU1EE7I2PxG95XCvb/jVwDV4RgxktTfTirlR0WxSacdSwNuQ+u/t6
         KS6tuhLJxBNO4fgmNKVS/BrH6WCmG+/fYMQ2QdSxDoijAvi/8ncxIYE4ISonlGVm21/m
         Igj++AQONZ3OzWAa2njnNY0+uXKjGJaznBaTp4EdLCTlQYdacZqICefIKzcvJWWzn718
         dEQZ/yWJlU7lxN7Xg+EmHgu8g2Is7wmepS3GIrWjVEY7HLlImNx7KRf0aeQ7/clduyUl
         F2ef7hfkEtxTQS8YKE2L/Sf62QnRAVAqXCqoRq13lYX5NeO3SfnGC6j+v5o1XNeTioiW
         +UTA==
X-Forwarded-Encrypted: i=1; AJvYcCVUPULJpGqeK0ofqwPdo6FvBte1Z2HFgAxoUvU98NiuW8ubsn8p+ER2b886djN7dbxH6Oy+lmTmSIavLCtdsHLifNtsos0cEc/58FA/wXwj/ZqKubFHh5ETNmg0zdks5r5Z/eKNAQR88Neisg4YAQ==
X-Gm-Message-State: AOJu0YyScr9VITtFLPGSOKOZO6fymQUHNPo/9yliQ0+ba5+RfPXU/4Uj
	52d3x+0jzhc3OJZ3gWL94jpWmsC3yBkI4wueNpw7OjfZKZy8vU38CDAOmu9HM0A1Mnfkgyo8Bf4
	5ji2CGuFTxBPvmMHKTXrQTWA7eDY=
X-Google-Smtp-Source: AGHT+IEdqbE3nTHzTHVnvtCEoIC2+Cn09Y4dZAXa8zWYlw3yYVCckBoDOV8siFuX1rqxLf21t2FTt18kB0pJV1s+ch4=
X-Received: by 2002:ac8:7dca:0:b0:42d:de30:83e1 with SMTP id
 c10-20020ac87dca000000b0042dde3083e1mr694373qte.29.1708724659935; Fri, 23 Feb
 2024 13:44:19 -0800 (PST)
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
 <ZdjdAKIV39A-jpR5@x1>
In-Reply-To: <ZdjdAKIV39A-jpR5@x1>
Reply-To: robert@ocallahan.org
From: "Robert O'Callahan" <robert@ocallahan.org>
Date: Sat, 24 Feb 2024 10:43:38 +1300
Message-ID: <CAOp6jLZKZKyYrJrzjZ90ZdxzzuDV0wp+XS3Rzssd-kvZV45JSQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf test: Test FASYNC with watermark wakeups.
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Kyle Huey <me@kylehuey.com>, Ian Rogers <irogers@google.com>, Kyle Huey <khuey@kylehuey.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

(I work with Kyle.)

IMHO this is more of a bug fix than a feature. `man perf_event_open`
expects this to work already: "watermark: If set, have an overflow
notification happen when we cross the wakeup_watermark boundary" and
later "Alternatively, the overflow events can be captured via a signal
handler, by enabling I/O signaling".

Bug fixes need regression tests. Such tests should fail on any kernel
where the bug is present. It seems strange to expect each such test to
detect whether the bug "should be fixed" in the kernel it's running on
and skip when that's not the case. I haven't seen any other project
try to do this. Instead (as in kernel selftests) the tests, the code
under test, and any metadata about which tests are expected to pass
are all in the repository together and updated together.

It makes sense that tests for the code in tools/perf should not fail
on older kernels, given that the code in tools/perf is expected to
work on older kernels. But tests for bug fixes in the kernel itself
should be expected to fail on older kernels and therefore should live
somewhere else, IMHO.

Rob
-- 
Su ot deraeppa sah dna Rehtaf eht htiw saw hcihw, efil lanrete eht uoy
ot mialcorp ew dna, ti ot yfitset dna ti nees evah ew; deraeppa efil
eht. Efil fo Drow eht gninrecnoc mialcorp ew siht - dehcuot evah sdnah
ruo dna ta dekool evah ew hcihw, seye ruo htiw nees evah ew hcihw,
draeh evah ew hcihw, gninnigeb eht morf saw hcihw taht.

