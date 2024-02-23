Return-Path: <linux-kernel+bounces-78910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448F9861A7C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 000FC288E00
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E527D13DB9D;
	Fri, 23 Feb 2024 17:44:05 +0000 (UTC)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2789112FB11;
	Fri, 23 Feb 2024 17:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710245; cv=none; b=fra+yOjPz81lJic1lk+o2GCwKFHCv6d7XCiriKqCuuvImYTxeGpgDNv1VkkQb5bsJf0tuIxLJ/tPBUsHJPMEigfO7yAkTv/2uso68+XeriaIzF5gpGv2otwdB1SJCpk2bSxu1troni3ODPqsq0gXMsmHcfFbo7TXrvXgcoDwZJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710245; c=relaxed/simple;
	bh=WEk1o9DuGmQhfb4DIwZNU1PBokH4l8izWHl46k4dtUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tgJoRyN9gCrZTJ/FPrFD/fYm7PxlMSqO1iw/bpl4P36ATOGh2peNb03knVrjBbJfXmzZUUKHTEuqDKx+l3fxjDWHDhr3Pj1cK8jO19ngi3Kpmnlsgt/GBXoNHII9yCBACVtWGObRkC0G9irnmalMJM17JgS7+JV24oVl7ayjdZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-59fc31c57easo176327eaf.1;
        Fri, 23 Feb 2024 09:44:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708710243; x=1709315043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98xGer5jHOdOa0i64FybVWh8Yw0etQEzmf5UkGSwIe0=;
        b=Ph4DGrmahlx9JeGn+UwJ44uCAn1BKRsjYw8PLIFKksCBW7fuwnLiZHcT2qx6l+5nxl
         KQmFkGTk8BKbpEAKZLiKyWyzuSHYZXFkBRvX9kEGPrWDFhPJGYCHiJnuHdxfiblRMrGL
         BNTgsSn649LwFqGxpXNv/P8egLiyTCZa7zO1vwiIJTpF2qylR72NKyY1xkMbEDGJl+Hi
         XuSLnvhKRWvyJ68GxzDbRPdBg7tOrz2g5J6vCNdUOuS4PHV+4sMHW3mCBAwdIKmQ4twd
         v4T7RoDYFuSIV9MqF84H7B7nDgtCgCwOsaIFA+2yZ3e4FIivWoYkn3yJHANlH5ojq5rN
         I+1A==
X-Forwarded-Encrypted: i=1; AJvYcCVQxLtQ/322JP/208bE4vv4oYx1c2IsWlnctvKqi9NIVhoaq8p6h1dKL/bT5v4/1VoubyM07IPxIrsAiiO0bQmcPR8ir7hLtFcTzQ/EPAKgtkAtLsClcFyUTpLvEbrc3VlRBYafkIU=
X-Gm-Message-State: AOJu0Yzx3bLltTGjjkEdrjsltqiqq7mCaoXNSwanr1liUyKZflCnwH1R
	AhsUJbwVrld36xxcpVk6HSNQgB1VPZaKtwB7Inf4caU3CQ8vDK4VHFrR9XkFz0x2n/aOe34xzF1
	BbRH9GTa23CjykCkdo2Jzi6a2R+s=
X-Google-Smtp-Source: AGHT+IHvImEtq21fFsYLwZYUaBgEjYxLD1NeXI6eBPFaNO8W1+4H9wliGzA3OofhtI11Qv9j+oIGk6WP6kH280DAE9c=
X-Received: by 2002:a4a:d6d8:0:b0:5a0:3c8a:4940 with SMTP id
 j24-20020a4ad6d8000000b005a03c8a4940mr531977oot.1.1708710243316; Fri, 23 Feb
 2024 09:44:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223143833.1509961-1-guanyulin@google.com>
In-Reply-To: <20240223143833.1509961-1-guanyulin@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 23 Feb 2024 18:43:51 +0100
Message-ID: <CAJZ5v0gM=0rU6a1A6Bh2Ed=4=1AtQ3p5aDJVCOioA6qxGv1jtQ@mail.gmail.com>
Subject: Re: [PATCH v3] PM / core: conditionally skip system pm in
 device/driver model
To: Guan-Yu Lin <guanyulin@google.com>
Cc: rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com, 
	gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com, 
	petr.tesarik.ext@huawei.com, rdunlap@infradead.org, james@equiv.tech, 
	broonie@kernel.org, james.clark@arm.com, masahiroy@kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 3:38=E2=80=AFPM Guan-Yu Lin <guanyulin@google.com> =
wrote:
>
> In systems with a main processor and a co-processor, asynchronous
> controller management can lead to conflicts.  One example is the main
> processor attempting to suspend a device while the co-processor is
> actively using it. To address this, we introduce a new sysfs entry
> called "conditional_skip". This entry allows the system to selectively
> skip certain device power management state transitions. To use this
> feature, set the value in "conditional_skip" to indicate the type of
> state transition you want to avoid.  Please review /Documentation/ABI/
> testing/sysfs-devices-power for more detailed information.
>
> Signed-off-by: Guan-Yu Lin <guanyulin@google.com>

Please explain how this is intended to work.  That is, what exactly
you expect to happen when the new attribute is set.

