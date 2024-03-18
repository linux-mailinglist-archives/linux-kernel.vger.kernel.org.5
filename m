Return-Path: <linux-kernel+bounces-106118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 338E987E95F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAEDD1F230C0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D278C2EB04;
	Mon, 18 Mar 2024 12:36:00 +0000 (UTC)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96891E4BE;
	Mon, 18 Mar 2024 12:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710765360; cv=none; b=Ra15hp24rjBo8nZxICfEJFaQcwZjUuzEjzh77ZmpcCQ6DEo+c1iTpNF80XLOESKaKQiUHTzpfWLp7t25f31D69SoSY0Epm/7wbxo5elh1I5ih/C5G9VnD9c1dhS4HEtJ+K1/1nget80EkOOI/OQT7UIMWrvWE2/lS6V8uKMb37E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710765360; c=relaxed/simple;
	bh=xfZo1SesS+n+5OMh9DO2aODGB6aFCGGu3zN7BKHgJ9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iptHj5Rc21IHvuveCLQw4wJ5p7zRNHiL0p5mDJYk3BeB4PK/MVkRcJSNbPUF3KfxxZOjkUodr/s2qVnLxZe7LdactBENSlcdfnKBm7n5OZqjttQN2fN6n+NH+BwY0xWbqYFuJlWzrSXj/K4/AQ2WXYcFMDePeh9AChJDEFTk4wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-22271941060so614069fac.1;
        Mon, 18 Mar 2024 05:35:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710765358; x=1711370158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s/fmEPoe+d05t3iTfkNMO20tkvfZOlaVp/MVUPaENYY=;
        b=DpaacBI0E7+RGI7z7Ny00h3gs98mCjnSFQO2QUIlmBYWidFlNDAvKwJEhCiRcnU89R
         9zIquom3P52jEAC+Wo+yWERtPBQtpMdihWI2yact8smLTb9+nyVcOTDO/fTBXPcyQE8X
         BPxQ6PxAlDce1fZF/SeGo6v74YDDtNJzPEj5JDfM0jmK3ge8yiv3IwpGXIzjrDRADzoW
         uENmc3vSLNEMujuorABPC8zPvc/3tberofzqcI/pDS2NafxpjesakupcVVoscNnOFhsy
         ScHthpBQ0eY1BFilESqoItCqO2qz3hmEUOGXBOJdcP931y3ezs42zrgENeJKb6DO2zWG
         okRw==
X-Forwarded-Encrypted: i=1; AJvYcCU8Fq6zsGfJAu01SJcbHMhSKS4nK/WB+vA4XzKzdhxR0FkQ7G6MnL5b9FbTaVZn4BFbYwj0GCI54klLc1iTmcYJo9PyBNJBNEk8gqL/4VN0lZ8vTP0X3eveSy92X7A6y7CWUSiOd5g=
X-Gm-Message-State: AOJu0Yz+Q6yX3SQCzA3L1JGiVPCAeLLpEsez169Yh/dPH+oOnkZ8V/3f
	28Da733xPcsSq+Ue53nqgCJzRYYGTLLJ7LVCZslc4nPS3gRW+6qMWLRilnX0glCQIgjdluemVDb
	L3ailGItINYOaNX6GAALI6oDg3HI=
X-Google-Smtp-Source: AGHT+IGt1IQTgrgPRFdEc6cJl7fmMEA9CjFeY3dk+apwbZTEoquOgW6mazdL6/9ocuWf0ETIZpd2J+4NH9eNOxAn0+g=
X-Received: by 2002:a05:6870:3117:b0:222:bfb4:1ead with SMTP id
 v23-20020a056870311700b00222bfb41eadmr4235974oaa.4.1710765357941; Mon, 18 Mar
 2024 05:35:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710754409.git.perry.yuan@amd.com> <b9a60328afad40581eeef694937cebd6158f1f2d.1710754409.git.perry.yuan@amd.com>
In-Reply-To: <b9a60328afad40581eeef694937cebd6158f1f2d.1710754409.git.perry.yuan@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 18 Mar 2024 13:35:42 +0100
Message-ID: <CAJZ5v0ghYCDv2-e0UKXEjSFFbHQ2ingRc1aJco4dSJUknFLadQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/8] cpufreq: amd-pstate: Document the units for freq
 variables in amd_cpudata
To: Perry Yuan <perry.yuan@amd.com>
Cc: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com, 
	viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com, 
	Borislav.Petkov@amd.com, Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, 
	Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 10:49=E2=80=AFAM Perry Yuan <perry.yuan@amd.com> wr=
ote:
>
> From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>

No changelog.

> Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

Sender sign-off missing (when sending somebody else's patch, you need
to add your S-o-b tag to it).

> ---
>  include/linux/amd-pstate.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index 212f377d615b..ab7e82533718 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -51,15 +51,15 @@ struct amd_aperf_mperf {
>   *               priority.
>   * @min_limit_perf: Cached value of the perf corresponding to policy->mi=
n
>   * @max_limit_perf: Cached value of the perf corresponding to policy->ma=
x
> - * @min_limit_freq: Cached value of policy->min
> - * @max_limit_freq: Cached value of policy->max
> - * @max_freq: the frequency that mapped to highest_perf
> - * @min_freq: the frequency that mapped to lowest_perf
> - * @nominal_freq: the frequency that mapped to nominal_perf
> - * @lowest_nonlinear_freq: the frequency that mapped to lowest_nonlinear=
_perf
> + * @min_limit_freq: Cached value of policy->min (in khz)
> + * @max_limit_freq: Cached value of policy->max (in khz)
> + * @max_freq: the frequency (in khz) that mapped to highest_perf
> + * @min_freq: the frequency (in khz) that mapped to lowest_perf
> + * @nominal_freq: the frequency (in khz) that mapped to nominal_perf
> + * @lowest_nonlinear_freq: the frequency (in khz) that mapped to lowest_=
nonlinear_perf
>   * @cur: Difference of Aperf/Mperf/tsc count between last and current sa=
mple
>   * @prev: Last Aperf/Mperf/tsc count value read from register
> - * @freq: current cpu frequency value
> + * @freq: current cpu frequency value (in khz)
>   * @boost_supported: check whether the Processor or SBIOS supports boost=
 mode
>   * @hw_prefcore: check whether HW supports preferred core featue.
>   *               Only when hw_prefcore and early prefcore param are true=
,
> --
> 2.34.1
>
>

