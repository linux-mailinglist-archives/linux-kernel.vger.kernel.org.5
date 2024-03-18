Return-Path: <linux-kernel+bounces-106117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 834C387E95D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3903B21DC1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39692EB04;
	Mon, 18 Mar 2024 12:35:01 +0000 (UTC)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3E81E532;
	Mon, 18 Mar 2024 12:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710765301; cv=none; b=DauMEx86/tapDLKZhFqphbhhnhTRBxo2MAupQeWe5WO4hfKX/pbYYNSXrD8EDzwuN60L88wkai1t3iFWMZVExtf/q0aRP2Gr/v9ftF7jnn0/Nqo5PGmUnQlE914AL4/eNzxHSY/A8ZYKHoLnYSYdL06XM9px6bPp0nUmtDCzR7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710765301; c=relaxed/simple;
	bh=zeV2VBzNgCMFQ0VvRWDwqW6TeQufRhxF+IYVXZONP0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=evK9xOqLYtD/jiOny0J9YBW2DrPwfBZ2y9FzwEPYCULHG86kjaYYXZ/wk2dtHTHr3SXDntr2y0FNkS9vOjmZAdd8eRRlTuB8hdh/BsK2vK5rWlzcL7nuIY/Cl8mbzFA4Xhn6GNZOzv6X6WUyDjzYG8z7f30z/put9Cy7Jbz8XX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c3868b42daso167934b6e.0;
        Mon, 18 Mar 2024 05:34:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710765299; x=1711370099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUF1nH0gbNVRQaaCW7iiquI+AoJnU4wOe9OIXQOLp9c=;
        b=ixO00PICx1DCX6qnixdFFcDmuDQIDyQ62pwUxbnCGpJ6oMJfCxdYkJbZmsMTLgJYzU
         7M9UTksmIsyKGqiWLzV4Hx/Gku/uA69VjxLQ8aNZZoD7TuaTQB2KF8LYM7jvdXD/7hS4
         KlXArq4b3XAyQcpak6Y1kDlFGB5gP5uMXLBBoj4faxcFivIrL6URfQ/rHWMA8rraRkGd
         zMEeGZRy3WiIdRiLWXlbg1DHpgmFvaMd48CgEnc5ElSqIhV8uDfcRtBZnFE9oS1wQQ7E
         IdM7OafmPGC5rikt19rgD7XcTyv7yzT7zH0VaWINsVz7IRK1IbnLse3qbN4aPrNTUSwi
         VLwA==
X-Forwarded-Encrypted: i=1; AJvYcCVGajguHzWVGGYud6EZidVoXvCf3MjyU23Rxmx62YK4JvSbyePXZ7efmpahkiRWou5i/Vy1vA6y5/zKWa820A09stRokFyo7F7lE4QYC9W5jkW/7uyTvNUxzrASd4qSZUqBvPD/myk=
X-Gm-Message-State: AOJu0Yyg0XhqMVZvjFVGttPe3CMsoyM9KdvWSwFVmGMvj5ydadpiKCrq
	OikY7/7jlNyMsUiG+UVl0TztcFg2mctD7zMvilSE3WTEIJ7tBKfchJ5qQWpRO/q8A9vHWC0slrh
	gpAy5StQxSzS9pwmKTliU2WDDTk4=
X-Google-Smtp-Source: AGHT+IELDHcVVfFxaEIelIg4m0pHb8ZMdOG1ijEhKDvwoQQF3RzkAxfNcCRQhb9ArGVQg48GwuuuAI53wp5uSf7ec7g=
X-Received: by 2002:a05:6820:d92:b0:5a4:6cf3:ebaf with SMTP id
 ek18-20020a0568200d9200b005a46cf3ebafmr8444070oob.1.1710765298834; Mon, 18
 Mar 2024 05:34:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710754409.git.perry.yuan@amd.com> <0988fb808bf358c98f6ae8ad8f65cb0c7e1129b3.1710754409.git.perry.yuan@amd.com>
In-Reply-To: <0988fb808bf358c98f6ae8ad8f65cb0c7e1129b3.1710754409.git.perry.yuan@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 18 Mar 2024 13:34:43 +0100
Message-ID: <CAJZ5v0gEwpcsELkHVZMp_WTPc0sLa=e2wp2v=BFp6fHrg=bvWg@mail.gmail.com>
Subject: Re: [PATCH v8 1/8] cpufreq: amd-pstate: Document *_limit_* fields in
 struct amd_cpudata
To: Perry Yuan <perry.yuan@amd.com>
Cc: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com, 
	viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com, 
	Borislav.Petkov@amd.com, Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, 
	Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 10:48=E2=80=AFAM Perry Yuan <perry.yuan@amd.com> wr=
ote:
>
> From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>

No changelog.

> Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

Sender sign-off missing (when sending a somebody else's patch, you
need to add your S-o-b tag to it).

> ---
>  include/linux/amd-pstate.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index d21838835abd..212f377d615b 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -49,6 +49,10 @@ struct amd_aperf_mperf {
>   * @lowest_perf: the absolute lowest performance level of the processor
>   * @prefcore_ranking: the preferred core ranking, the higher value indic=
ates a higher
>   *               priority.
> + * @min_limit_perf: Cached value of the perf corresponding to policy->mi=
n
> + * @max_limit_perf: Cached value of the perf corresponding to policy->ma=
x
> + * @min_limit_freq: Cached value of policy->min
> + * @max_limit_freq: Cached value of policy->max
>   * @max_freq: the frequency that mapped to highest_perf
>   * @min_freq: the frequency that mapped to lowest_perf
>   * @nominal_freq: the frequency that mapped to nominal_perf
> --
> 2.34.1
>
>

