Return-Path: <linux-kernel+bounces-77264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F088602B8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68B8B1F21F49
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B0954902;
	Thu, 22 Feb 2024 19:31:52 +0000 (UTC)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1C114B823;
	Thu, 22 Feb 2024 19:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708630311; cv=none; b=Q67kHiCygVDBf3dKdNnckWwCckiO7axmSlah+zY5GjCF1eGc4cmHi0xaHlp6VcqAeCK4GfbMpF5zoYMMNyg6mCHozDqDt+oLt308QtC5I5DHgsKM5LiYpYruHhkEoZYX4iAVgkA1n3DvSaxr8hIS1UjcNZbbXB+SY46l2vezztM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708630311; c=relaxed/simple;
	bh=zSS3FRmSoCnIFn4LD8GRruJxoriuWhGhP0GKYALtiP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HZFaqYb28BkarYR/2PgdXd4Ok389EG9tGvvP0oIoX21jczIgwjJKCxqUO4vmcAvOx/iI3hOG3eTTVQXVkoIc1Oa88RZNYZik/AKJA2gfTRd4XgJXHGcGgNWYJvIewVB7ZWguCNgVCMYs8GjEwDmpYI6ZxK5XCqY9WL5HE+cdhko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e45f7c63f4so293038a34.1;
        Thu, 22 Feb 2024 11:31:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708630309; x=1709235109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUbj5CYmFAIrd6f8PVhsXr4RvnOfcvMJ/SWbSY+6fKE=;
        b=KYfCz24awsBQUtsH66TvjiCbIPRKk32jNeJneZf6CKoKNh3gX7C7YyoaNePfj3zuRj
         6lsXvna2ekQMua7FLpCoBc6yvaQ7zxkjMMeowg96y8LGVFTKrEo6xl2x3YqsAQy5xDBG
         c/wnnymdw649IzQzJUNXUpxrh3USMlsvK5Hvkr+X3HtzHeYFUrVksCENu2cjpJRe1ZRr
         gPzWgx/rdD49tJ6uielEPDt3tCb0zNOSZJeUDFok9RiyW4ouAvrlcb/fKkxy5f4CDi+/
         G/3pix1Fd1yxCr7osbQdzPn8bWIS0b88fqSPSxg0sYZksl55hBCvDdU91kfvopM9udFQ
         AYcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVb1i7VrwlMMU22wONqane1V+zCtS0jRAjs23K8z7as3i3ZaI7Grf7drvRtzG/PzlcCrYNpvUIIdvQ74q1cDlVs3wcSCxpIfNA=
X-Gm-Message-State: AOJu0YxIaJFrfV3f8w31vQRbZvcK+7V+plDsdeMhnqS86yXF6w+efGuI
	+DtZm6oaTZ6p3WqJa4LmNlWhYODkL7dQnGruPsIoPQLe6yYTXQ0ujBFKe0f2RGHGwEVAP6PymZK
	xv4wW09YdyOTYGRIMA2PNCT/4fy7eWIT9
X-Google-Smtp-Source: AGHT+IHNWa1o9YeQF4akikHz17dDCJ8lAipb9BhScgmboGiIWRWb+Pqyce2Vy1FMKNOGuuvP/iMnrb1sizWSJB2cP0g=
X-Received: by 2002:a4a:c3cb:0:b0:5a0:3d13:a45a with SMTP id
 e11-20020a4ac3cb000000b005a03d13a45amr702240ooq.0.1708630309494; Thu, 22 Feb
 2024 11:31:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222153415.2088039-1-pierre.gondois@arm.com>
In-Reply-To: <20240222153415.2088039-1-pierre.gondois@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Feb 2024 20:31:38 +0100
Message-ID: <CAJZ5v0j1cj3wBLNPdX5Oq5z-5BuGHzAj=tugo53r86wapAXtHg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Remove references to 10ms min sampling rate
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Qais Yousef <qyousef@layalina.io>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 4:35=E2=80=AFPM Pierre Gondois <pierre.gondois@arm.=
com> wrote:
>
> A minimum sampling rate value of 10ms was introduced in:
> commit cef9615a853e ("[CPUFREQ] ondemand: Uncouple minimal sampling rate =
from HZ in NO_HZ case")
>
> The use of this value was removed in:
> commit ed4676e25463 ("cpufreq: Replace "max_transition_latency" with "dyn=
amic_switching"")
>
> Remove:
> - a comment referencing this value
> - an unused macro associated to this value
>
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/cpufreq/cpufreq_ondemand.c | 1 -
>  include/linux/cpufreq.h            | 4 +---
>  2 files changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq=
_ondemand.c
> index c52d19d67557..a7c38b8b3e78 100644
> --- a/drivers/cpufreq/cpufreq_ondemand.c
> +++ b/drivers/cpufreq/cpufreq_ondemand.c
> @@ -22,7 +22,6 @@
>  #define DEF_SAMPLING_DOWN_FACTOR               (1)
>  #define MAX_SAMPLING_DOWN_FACTOR               (100000)
>  #define MICRO_FREQUENCY_UP_THRESHOLD           (95)
> -#define MICRO_FREQUENCY_MIN_SAMPLE_RATE                (10000)
>  #define MIN_FREQUENCY_UP_THRESHOLD             (1)
>  #define MAX_FREQUENCY_UP_THRESHOLD             (100)
>
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 8b9026031a28..625949a1869d 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -568,9 +568,7 @@ static inline unsigned long cpufreq_scale(unsigned lo=
ng old, u_int div,
>
>  /*
>   * The polling frequency depends on the capability of the processor. Def=
ault
> - * polling frequency is 1000 times the transition latency of the process=
or. The
> - * ondemand governor will work on any processor with transition latency =
<=3D 10ms,
> - * using appropriate sampling rate.
> + * polling frequency is 1000 times the transition latency of the process=
or.
>   */
>  #define LATENCY_MULTIPLIER             (1000)
>
> --

Applied as 6.9 material, thanks!

