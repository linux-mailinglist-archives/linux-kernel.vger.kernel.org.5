Return-Path: <linux-kernel+bounces-22346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E3C829C6D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7840928205C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6664D4A9AA;
	Wed, 10 Jan 2024 14:21:34 +0000 (UTC)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4F04A997;
	Wed, 10 Jan 2024 14:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6ddf73f0799so131457a34.1;
        Wed, 10 Jan 2024 06:21:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704896491; x=1705501291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y76oX6QBn8qfBuvGxIul5sp+k3OyoCGGyF/zRteSiGA=;
        b=JgZxkNSyrNrrndLxRE9a8Uus5UoOqEpMGV66TGGFVO2Xax1W6e7MqZNvbT4CK7vVc4
         YZwHGrptuQcfxvnUhmfY3+vdjDsBpXUnXyS/UD+gnta88O6Gsv5Lh16eIncbv1TludEJ
         oY+iwiqLkMVJZwkUyF/URL+E5RdMiHp38vL16l+y05xt9pjVJEtF/oF4YMpKaqdVIc4k
         owNyig6VmyThMHgHWqQxEkCm1VxMLNosT2RviE8maBYDz024QMp2q6yvf3PLL8TV44NP
         5WX32cGyrdQTeCC7i6YR+5RXl0ZY36zjD/yFdwnuuwxOmyu0VKMJiNmvWzn14WhKrJc7
         L1pw==
X-Gm-Message-State: AOJu0Ywuu9NH9uLUEMJyZSqz61Sqvc/EXgZdPmf7MO0O7AzcD9MHqZuc
	aV+cpCEYbb8Hx2NttMbO8K5gheND7QcCLw6KHg0=
X-Google-Smtp-Source: AGHT+IFtrZ5KMxRxEORv0sVOK2xbEdcxyqm8++gJWnMg8A7J8vx1gkkEhxeoP6Q7oU/d+RR18IU82MYHOeg0aTzcrAw=
X-Received: by 2002:a05:6820:2e02:b0:598:9a35:71f1 with SMTP id
 ec2-20020a0568202e0200b005989a3571f1mr1505094oob.0.1704896491715; Wed, 10 Jan
 2024 06:21:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109175844.448006-1-e.velu@criteo.com>
In-Reply-To: <20240109175844.448006-1-e.velu@criteo.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 10 Jan 2024 15:21:20 +0100
Message-ID: <CAJZ5v0ipYQURmFGGwmS5oyOuAOFDbG7TaaaWg4Ze-7PpBnSwkQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] cpufreq/amd-pstate: Adding Zen4 support in introduction
To: Erwan Velu <erwanaliasr1@gmail.com>
Cc: Erwan Velu <e.velu@criteo.com>, Huang Rui <ray.huang@amd.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 6:58=E2=80=AFPM Erwan Velu <erwanaliasr1@gmail.com> =
wrote:
>
> amd-pstate is implemented on Zen4, adding this architecture in the
> introduction.
>
> Signed-off-by: Erwan Velu <e.velu@criteo.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 1f6186475715..9a8d083f6ba5 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -14,7 +14,7 @@
>   * communicate the performance hints to hardware.
>   *
>   * AMD P-State is supported on recent AMD Zen base CPU series include so=
me of
> - * Zen2 and Zen3 processors. _CPC needs to be present in the ACPI tables=
 of AMD
> + * Zen2, Zen3 and Zen4 processors. _CPC needs to be present in the ACPI =
tables of AMD

IMO, it would be really nice to avoid extending this line so much, but
this is up to the AMD people.

Also, while you are at it, "include" in the first sentence should be
"including" and a new paragraph after "processors." would make this
comment easier to follow from the logical standpoint, because the
first sentence is about the supported platforms and the second one is
about additional requirements (ie. something else).

>   * P-State supported system. And there are two types of hardware impleme=
ntations
>   * for AMD P-State: 1) Full MSR Solution and 2) Shared Memory Solution.
>   * X86_FEATURE_CPPC CPU feature flag is used to distinguish the differen=
t types.
> --

