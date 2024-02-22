Return-Path: <linux-kernel+bounces-77250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B7E860297
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21FC128F04A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BDC548F3;
	Thu, 22 Feb 2024 19:23:04 +0000 (UTC)
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1054B548E4;
	Thu, 22 Feb 2024 19:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708629784; cv=none; b=jBEZRf8KCtrbg49aMRr9C04ug+mtRxe2cBW5DeOldGNKQLHU+DfEGtKeM2QCeC6zZSQWleBmdDoJ1bOmBiUU5fXM1Myaxw90L2II0o3D5hbFCYkSNvoE+wWW2Ivnd6s948NVetK3wwOOuH7Ary8sHYYh+9Ts3bqUEYO5aIa5nbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708629784; c=relaxed/simple;
	bh=mkKKAfHtBpwBbPprScKSODOOY3UF1wXLfYJ4H8sAKXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLhvzCGybDGnmXc+YEDIJ3txR7C4pbuVdnVlrOpgYzA3kPasddijr3wff+C/b6HzLf+aqQB6PL2kSEBxmQTCHN+75b+N2bHyRgRYaWXqCf/rY9N0UavhmIG803tZoYaPAeC51Y3jy9g/203Mmv2lye9qdsKW8Ar0eAfW1gw+/kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-59fcf83f92fso18903eaf.1;
        Thu, 22 Feb 2024 11:23:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708629782; x=1709234582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e28EWGdFZkXU/vK65K9Hm+51B7EZKRDZ9oBW2jH53Mg=;
        b=Av6SFYnJRBfPmKhD4Ayi+YsT5O3JSrZjs/SowQvu66wc8BSDPK3juxW9o9e7uPmlnU
         +bmXTCBLn1uVR9q5ql0hOgWNNQ2lIAtql0LKrvWBxXusiLDoLAi73FtH7NjEcwvwdUsr
         PyPZ7yS0/kSF3NGHUKku6UZu8THp3rQqeSNAavnx1H8gzrF3/Tw4xour8X05cKSqQyLW
         uE4u+msJLTQJO44PeHlCbqksrkycPh+WrECUN18Gznv3jPJuRAa45l88bOhzgtIVyvgA
         miZm0o2Utl7K2sAgefGLkX4r/1/zenU+BRBv5lpVjMWhClDzhB0aA9v71FrRuyQbCPQs
         Onww==
X-Forwarded-Encrypted: i=1; AJvYcCVA7xFflWvVx9DrXfYdmlkzMXOU4HsvYEEm9V58Y/E+bQJZ6bTUgmEymEh5z9dO/sZVQIL7fGACPgaeFtbURjO4/yyKNX80CfJWwEytYFu2YUPBn6uSIrUfM9pV24x4OMvfAAnsYal52ELY6uUmcfwttUrctkZHLP4C7GZZLh4=
X-Gm-Message-State: AOJu0YyLHaz3xLcbX/OwxcECf5dMvAHFztP1jQ2H8GPFe2Xa5XSIN4Iw
	FH3WrASz6ugKFAMlTlGu5ycf6pzrFY+Mi0O5IaMAPa78CmsX0Ood4cX6dYd8DRZMLMCZskPsbB5
	lkdBudNTfwTOJkyjaYCDo7L0cVqD+Vn2f
X-Google-Smtp-Source: AGHT+IEfvmDzLHmh4lI0wnu+VW3GpToyWGUFp65c2Z+kPgYDwRnXt/CiRpdE76fuL7CbBioI5YEsYzV+bPDuwKYH3P0=
X-Received: by 2002:a4a:e89a:0:b0:5a0:168b:d91 with SMTP id
 g26-20020a4ae89a000000b005a0168b0d91mr5096155ooe.1.1708629782093; Thu, 22 Feb
 2024 11:23:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222083515.1065025-1-quic_kshivnan@quicinc.com>
In-Reply-To: <20240222083515.1065025-1-quic_kshivnan@quicinc.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Feb 2024 20:22:51 +0100
Message-ID: <CAJZ5v0gDeCbQ5rGOfCdpsVUpAsq3L=9DoLFChHc5=Zdq9Jc_7g@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Limit resolving a frequency to policy min/max
To: Shivnandan Kumar <quic_kshivnan@quicinc.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@quicinc.com, quic_pkondeti@quicinc.com, 
	quic_namajain@quicinc.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 9:35=E2=80=AFAM Shivnandan Kumar
<quic_kshivnan@quicinc.com> wrote:
>
> Resolving a frequency to an efficient one should not transgress policy->m=
ax
> (which can be set for thermal reason) and policy->min. Currently there is
> possibility where scaling_cur_freq can exceed scaling_max_freq when
> scaling_max_freq is inefficient frequency. Add additional check to ensure
> that resolving a frequency will respect policy->min/max.
>
> Fixes: 1f39fa0dccff ("cpufreq: Introducing CPUFREQ_RELATION_E")
> Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
> ---
>  include/linux/cpufreq.h | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index afda5f24d3dd..42d98b576a36 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -1021,6 +1021,19 @@ static inline int cpufreq_table_find_index_c(struc=
t cpufreq_policy *policy,
>                                                    efficiencies);
>  }
>
> +static inline bool cpufreq_table_index_is_in_limits(struct cpufreq_polic=
y *policy,
> +                                                   int idx)

This is not really about the index only, but about the frequency at
that index too, so I'd call the function differently.

> +{
> +       unsigned int freq;
> +
> +       if (idx < 0)
> +               return false;
> +
> +       freq =3D policy->freq_table[idx].frequency;
> +
> +       return (freq =3D=3D clamp_val(freq, policy->min, policy->max));

Redundant outer parens.

> +}
> +
>  static inline int cpufreq_frequency_table_target(struct cpufreq_policy *=
policy,
>                                                  unsigned int target_freq=
,
>                                                  unsigned int relation)
> @@ -1054,7 +1067,10 @@ static inline int cpufreq_frequency_table_target(s=
truct cpufreq_policy *policy,
>                 return 0;
>         }
>
> -       if (idx < 0 && efficiencies) {
> +       /*
> +        * Limit frequency index to honor policy->min/max
> +        */

This comment need not be multi-line.

> +       if (!cpufreq_table_index_is_in_limits(policy, idx) && efficiencie=
s) {
>                 efficiencies =3D false;
>                 goto retry;
>         }
> --

Thanks!

