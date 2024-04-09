Return-Path: <linux-kernel+bounces-137694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDEC89E618
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEE9E1C22253
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBDC158DC6;
	Tue,  9 Apr 2024 23:33:01 +0000 (UTC)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E6E158DB6;
	Tue,  9 Apr 2024 23:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712705581; cv=none; b=e3fk3fS5Hbmnu3VkvjHoRcO0OmuWsnyUwdbnlkUnup6MlllBriVouKfwLvsdSkNeKJZt3Eg3wlBqwVYS+zkMMdL52YrYLVOjvMjGfQ08tELrh03D086flM/GsZL2T+rmX6w66MTE3qEOnRFxwefBgkJ6QqAhK0gf/N5sJEky2U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712705581; c=relaxed/simple;
	bh=txAzNccQpB/N8Q5x5o8g15P5MWmrHzoG0VO7jB4WhWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XwRNMiCl3+L9uawtH9P1RKandV+HajJi63FFOyeKsHIblhupfsNVdM3Y16YyvuXhpv6zZYE+gzVfg4hymedPKWH7PbET6wE7g6ms6UH5m8a4vhpecZhoHnIe1zCNfXorVtqVzCdiIK5oxmIq/oRVljlrjZ5syZe/f2Sp0c08T6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4dac19aa9b5so1296630e0c.2;
        Tue, 09 Apr 2024 16:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712705578; x=1713310378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txAzNccQpB/N8Q5x5o8g15P5MWmrHzoG0VO7jB4WhWM=;
        b=sxmFAROBFI9ngDOxs34O/tR+54uA9FoVZvxDv3Tj3JcKiTCzhILQFm8zOed8QOYP/m
         Dv63gmTDlsQ90glWckZxLSFri+T3Mmn5ALw5sFJdptiFJYF6IXpH3uAdJQ8x4xF7S4+1
         9DKGTfA5m7TBpSRf2+CVFY4ywEKnU7oK2Oz5shW0ItJYT/YbL6agmsWqJZtVdCc9PkdC
         OS7C5Mzj2zmh2q1N0aC1O5sPZJNdw5xjipDY2JJWlyfjNQHQXCwyLZHjUR2J7JxUEuXV
         QrQbPZNRuVec/+QC3g18IB/Ba3I/AY+p2X2ms2wRQ/TAxSYH9UKvoJjY18BoQRXzSLmB
         xl7A==
X-Forwarded-Encrypted: i=1; AJvYcCV22xN44uUAQZhEng6GIb/S9XYtzDZV3FXMLdSI9QPzzMWFTPpMrv7ikK7kM57PxEHr7jmamBVseZuas1afVRi8tWSKhpBEQAekGIwxglEmmRSfqHccV4N6ZfjNP+EZabld4F706yYgbtq35FOH5L/V
X-Gm-Message-State: AOJu0Yzh24ZpWvN3vQHetdvKQdETowZn8+9Gd35wl6qITMezrK0jbXoM
	YNuBMFRJlP1NjDgvieB3kmGayxiUIG50OX7J65aN9qjX8YTpgkqEf4Og8SUOl0kgLryJLWsU9Ih
	RrQIrvUz/SpsJ14JOtTJnwuFLeb0=
X-Google-Smtp-Source: AGHT+IH0P06YxJYcGjNdGbH4n1BhiTbFrZ85JMn5dMt5Bha4vj7GogqwsQSAf99h1XtNZHfYrUGBP2RvErupz8nYhvs=
X-Received: by 2002:a05:6122:901:b0:4d4:2398:51a2 with SMTP id
 j1-20020a056122090100b004d4239851a2mr1433844vka.8.1712705578423; Tue, 09 Apr
 2024 16:32:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404192641.GA2628-beaub@linux.microsoft.com>
In-Reply-To: <20240404192641.GA2628-beaub@linux.microsoft.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 9 Apr 2024 16:32:46 -0700
Message-ID: <CAM9d7cjm94EXoGY1BfTMU-n7vHkr+urxMhOTvjyMkL0f=GVxMQ@mail.gmail.com>
Subject: Re: Copying TLS/user register data per perf-sample?
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Apr 4, 2024 at 12:26=E2=80=AFPM Beau Belgrave <beaub@linux.microsof=
t.com> wrote:
>
> Hello,
>
> I'm looking into the possibility of capturing user data that is pointed
> to by a user register (IE: fs/gs for TLS on x86/64) for each sample via
> perf_events.
>
> I was hoping to find a way to do this similar to PERF_SAMPLE_STACK_USER.
> I think it could even use roughly the same ABI in the perf ring buffer.
> Or it may be possible by some kprobe linked to the perf sample function.
>
> This would allow a profiler to collect TLS (or other values) on x64. In
> the Open Telemetry profiling SIG [1], we are trying to find a fast way
> to grab a tracing association quickly on a per-thread basis. The team
> at Elastic has a bespoke way to do this [2], however, I'd like to see a
> more general way to achieve this. The folks I've been talking with seem
> open to the idea of just having a TLS value for this we could capture
> upon each sample. We could then just state, Open Telemetry SDKs should
> have a TLS value for span correlation. However, we need a way to sample
> the TLS value(s) when a sampling event is generated.
>
> Is this already possible via some other means? It'd be great to be able
> to do this directly at the perf_event sample via the ABI or a probe.

I don't think the current perf ABI allows capturing %fs/%gs + offset.
IIRC kprobes/uprobes don't have that too but I could be wrong.

Thanks,
Namhyung

>
> 1. https://opentelemetry.io/blog/2024/profiling/
> 2. https://www.elastic.co/blog/continuous-profiling-distributed-tracing-c=
orrelation

