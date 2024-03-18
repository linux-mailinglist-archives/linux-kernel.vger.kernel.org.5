Return-Path: <linux-kernel+bounces-106132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC3287E995
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 563BB2811CA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCE5364C0;
	Mon, 18 Mar 2024 12:50:12 +0000 (UTC)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2167364B8;
	Mon, 18 Mar 2024 12:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710766212; cv=none; b=MGDFOdrflqgPFqOp452o/Ahpc2dwlxtaKAeQC7sZX2KnAl6+Vl5rXg6+GlE6R0puDnKdCk+3j2Dikonv+vL7LwfI+BREco+hZPxU1jblkw22uaAOM/xNr17rAaOVJ4YOcYhc452iRYona7c6a9S23ibDkgTm2PeUZTZ+17ugcU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710766212; c=relaxed/simple;
	bh=PQqpjSAlS/Y82hZ+pfu3DKlvh/6H4paTGGcF2JvLae4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A3I0ZTTzXUx8HrHJdfqow5mSWGuP/T/Ugiqj03STWFRdOFlODs8/LdV0tyQpiiK9mTCk+ys9sZtgMZ+MxbveOE0HJcnmhqZh0dTjvngYhtMJ+Q83ynOCvZVK7e0gHaSS7qba+Jj+l2zqp++vf3n+xOK/NBJX+tXVpX2ACEVQKCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c383516de2so443597b6e.0;
        Mon, 18 Mar 2024 05:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710766210; x=1711371010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=igexqaivqyyWW/fKHDjv4jwYg+bZZIex5aTWy4MekxE=;
        b=RLa7nx64zBLKPQLsA02E4F4psNH8j/VJF7jK9eoMaSEt/m7eyzqCwTpspIOacbJx7U
         F+6N7YfAXff6bqd8az2qCaeWi7gKcDHSjFplicJmnC8vWVpaxDQn7oKChzhdNU0onq3Y
         aU7JUu+VUpajXxE/IvvK5zdpFaLFce0znEeS47PwiydgRtMYCOLIo8Bq040F+z9+7JIo
         Oodl42sBft/qn9FSrYncUVlMnD0KcwtiFzp0qLFV12JBxLh7PkT0/9EaHSPkor9vNwYL
         tDn6YC/wluzg2K1fTJcfCHJmVfxp10g0puWVFRmi4kcxP937jfwNtkQOVucv+w9XiqVa
         Zgeg==
X-Forwarded-Encrypted: i=1; AJvYcCVyJ6vnXgCylb9ZMOo5uRoZ1MDYecoFFZ+zuo1njR05mBEuOGwT8sy8JZBsV3Afd4dlvx8tBLRh8ah7DgHhKA8fkwP8W73LJYD5AZ6JRHvfn+kgKqw70zF/r68fAoQqhNukM4ARvqE=
X-Gm-Message-State: AOJu0Yy9LlrqC58EyuZDFFu7jCrEVlq4Wo5qlzxIZBP2EIk327wtnmpx
	UC/Ef/f57OzxhZZGl9onrLR+uEecgMLZd4rSvnxhooEbMTL4j3jkX7Inzb0fnS7leBFrilYF9Xb
	3Vc/sd2i4oe1CvVGWUbTrlu4XWls=
X-Google-Smtp-Source: AGHT+IG/IZWhVg5Kt120gzG2Vxc/QXlTFcc7T6H4eSZ0pYKqkAFSesRo9RvMl6YITb2sPJZabPcqbppaaLC2AeBHzZI=
X-Received: by 2002:a05:6871:58a4:b0:221:cb1b:cc05 with SMTP id
 ok36-20020a05687158a400b00221cb1bcc05mr13027339oac.0.1710766210135; Mon, 18
 Mar 2024 05:50:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710754409.git.perry.yuan@amd.com>
In-Reply-To: <cover.1710754409.git.perry.yuan@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 18 Mar 2024 13:49:55 +0100
Message-ID: <CAJZ5v0iQnJCVX0kHNxtOWLcnTXRRjR1HZ6m4CFhKZcQVp1SbEA@mail.gmail.com>
Subject: Re: [PATCH v8 0/8] AMD Pstate Fixes And Enhancements
To: Perry Yuan <perry.yuan@amd.com>, mario.limonciello@amd.com, gautham.shenoy@amd.com
Cc: rafael.j.wysocki@intel.com, viresh.kumar@linaro.org, Ray.Huang@amd.com, 
	Borislav.Petkov@amd.com, Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, 
	Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 10:48=E2=80=AFAM Perry Yuan <perry.yuan@amd.com> wr=
ote:
>
> The patch series adds some fixes and enhancements to the AMD pstate
> driver.
> It enables CPPC v2 for certain processors in the family 17H, as
> requested
> by TR40 processor users who expect improved performance and lower system
> temperature.
>
> Additionally, it fixes the initialization of nominal_freq for each
> cpudata
> and changes latency and delay values to be read from platform firmware
> firstly
> for more accurate timing.
>
> A new quirk is also added for legacy processors that lack CPPC
> capabilities which caused the pstate driver to fail loading.
>
> Testing done with one APU system while cpb boost on:
>
> amd_pstate_lowest_nonlinear_freq:1701000
> amd_pstate_max_freq:3501000
> cpuinfo_max_freq:3501000
> cpuinfo_min_freq:400000
> scaling_cur_freq:3084836
> scaling_max_freq:3501000
> scaling_min_freq:400000
>
> analyzing CPU 6:
>   driver: amd-pstate-epp
>   CPUs which run at the same hardware frequency: 6
>   CPUs which need to have their frequency coordinated by software: 6
>   maximum transition latency:  Cannot determine or is not supported.
>   hardware limits: 400 MHz - 3.50 GHz
>   available cpufreq governors: performance powersave
>   current policy: frequency should be within 400 MHz and 3.50 GHz.
>                   The governor "powersave" may decide which speed to use
>                   within this range.
>   current CPU frequency: Unable to call hardware
>   current CPU frequency: 3.50 GHz (asserted by call to kernel)
>   boost state support:
>     Supported: yes
>     Active: yes
>     AMD PSTATE Highest Performance: 255. Maximum Frequency: 3.50 GHz.
>     AMD PSTATE Nominal Performance: 204. Nominal Frequency: 2.80 GHz.
>     AMD PSTATE Lowest Non-linear Performance: 124. Lowest Non-linear Freq=
uency: 1.70 GHz.
>     AMD PSTATE Lowest Performance: 30. Lowest Frequency: 400 MHz.
>
> If someone would like to test this patchset, it would need to apply
> another patchset on top of this in case of some unexpected issue found.
>
> https://lore.kernel.org/lkml/cover.1707297581.git.perry.yuan@amd.com/
> It implements the amd pstate cpb boost feature
> the below patch link is old version, please apply the latest version
> while you start the testing work.
>
> I would greatly appreciate any feedbacks.

There are missing changelogs and S-o-b tags in a few messages in this serie=
s.

Overall, I would like someone, preferably at AMD, to take
responsibility for the amd-pstate driver, review patches modifying it
and ACK the approved ones.

Huang Rui, who is listed in MAINTAINERS as the official maintainer of
it, does not seem to be interested in it any more.

Can this be addressed, please?

