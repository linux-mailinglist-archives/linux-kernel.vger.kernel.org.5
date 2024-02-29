Return-Path: <linux-kernel+bounces-87358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 556E386D33F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA5A5B20E2A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1E413C9EB;
	Thu, 29 Feb 2024 19:34:27 +0000 (UTC)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1557A13C9CC;
	Thu, 29 Feb 2024 19:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709235267; cv=none; b=lzL1g44yzB6leFcne7HceYnQ6saGZwswvoDXLoOpuWdomUhsRRtO5//VfbvMiGBuAItXT7AoxwFaKmukfGusX1VbNMWfhYU9MD0vpq4cWRWDMq8aruQD2MhS4t9tHOuS26ZRb/cZUlcB+vXWXznQxuIRPHXlQ4sJweSjqqyfJD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709235267; c=relaxed/simple;
	bh=BayzEVfXNPRBxrY3TA8t49QRKHW7tGfeWTgiPEh7jo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pbWsDuqZ3fs+8wtHGLKkEpFP2M9+g1PE/SPEIGFFTEJkfV2OgPH5pL9BxhUoJ1RaJVrAp/b7XvFv/toRsVdiowjUwfi/vFxnQh7a/gKk/x+k9meu/nGkp6Uq8l4YCc7JZZ/si7qFahGoUt1v9Vdd7zxqHJIbDJHyYH2a3O9erBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e4aa4877a9so118569a34.0;
        Thu, 29 Feb 2024 11:34:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709235265; x=1709840065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GIAd28SmAv9IBBwlBfkFg/XlwEHMj2K+MeQKKpCbJyM=;
        b=OgCvvcJXoahVPlJrpoGMI6SRfmxXwS2hUi8GRGTfuGe7W4ej2+j2myxfA1Ckw01GiZ
         jRqjDQ67oBGG7EisahIyZqHY2htB1UoWcxGFaI3vtnIln5l1BxE52mM5JJAMQvnNc42/
         pg4oCvIMzG0y+nMGLmkdmzyv4PyOSaDPNjO2AFZqz1j7VNHdKZWtlAZzCms57B8a0U+i
         Gmer+mTY+AoUDV2w9LZ0CnIu8dIFVo0hSAcTss/YocAv4jL88bcNnZYZwi4DN2bscJe8
         N1o0BKArVW2JBHI3ihBRscWk6UBBevRKgr6bj5FKqA0oOp6uX2sJEZSFW2TGaoobxd5N
         Yw5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWZIAyq9z9sKV2sBA/aJIb/Urr9650HLsX6981azbRdvK+pwiMiJgi8Xjw8XCYOFoWOkFgpNbf4aPV5rosMgvIrQQ6zLD2Tn7A4DIjUWEJ5pySTNrk5Al8OuRDExyUL3PezIZFGWBl+6+eB16KY+gedJr/TWodNxKC39wt3h7knu+3n7qCpRySIvjMMLD+t591g5D8qDcr0kl37Hqhp
X-Gm-Message-State: AOJu0YxIFALlujgb767oUWAc2E4nOEN8zWLWoNPw0M/Q3ytKZfSmUstW
	qZ5FJlOrgl2dzH4kzWghToTWLyT3u6Jm6Q8bKSG9XQA+uJTFn7HLF0Z0mOMgTFaNboILuW89mWF
	qZGMH2/+XntSI1oav31XlcA9Yqfk=
X-Google-Smtp-Source: AGHT+IFrwvgAc0ISoztnG436NPqz4iJfmmtZTg/ZbF0R2tLMfqoYvGtemVRgaqjKCK/uTdzV46XgjyMdtCfWOLOX1hk=
X-Received: by 2002:a4a:a543:0:b0:5a0:ec66:b56b with SMTP id
 s3-20020a4aa543000000b005a0ec66b56bmr2225901oom.0.1709235265041; Thu, 29 Feb
 2024 11:34:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229-suspend_ops_late_init-v2-1-34852c61a5fa@quicinc.com>
In-Reply-To: <20240229-suspend_ops_late_init-v2-1-34852c61a5fa@quicinc.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 29 Feb 2024 20:34:13 +0100
Message-ID: <CAJZ5v0g_Cb-zPDD6z_C_HEewvsZJA_4FRiOnmhzX=KsRAL8daA@mail.gmail.com>
Subject: Re: [PATCH v2] PM: suspend: Set mem_sleep_current during kernel
 command line setup
To: Maulik Shah <quic_mkshah@quicinc.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, andersson@kernel.org, 
	ulf.hansson@linaro.org, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, 
	Pavel Machek <pavel@ucw.cz>, Sudeep Holla <Sudeep.Holla@arm.com>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, quic_lsrao@quicinc.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 7:45=E2=80=AFAM Maulik Shah <quic_mkshah@quicinc.co=
m> wrote:
>
> psci_init_system_suspend() invokes suspend_set_ops() very early during
> bootup even before kernel command line for mem_sleep_default is setup.
> This leads to kernel command line mem_sleep_default=3Ds2idle not working
> as mem_sleep_current gets changed to deep via suspend_set_ops() and never
> changes back to s2idle.
>
> Set mem_sleep_current along with mem_sleep_default during kernel command
> line setup as default suspend mode.
>
> Fixes: faf7ec4a92c0 ("drivers: firmware: psci: add system suspend support=
")
> CC: stable@vger.kernel.org # 5.4+
> Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
> ---
> Changes in v2:
> - Set mem_sleep_current during mem_sleep_default kernel command line setu=
p
> - Update commit message accordingly
> - Retain Fixes: tag
> - Link to v1: https://lore.kernel.org/r/20240219-suspend_ops_late_init-v1=
-1-6330ca9597fa@quicinc.com
> ---
>  kernel/power/suspend.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 742eb26618cc..e3ae93bbcb9b 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -192,6 +192,7 @@ static int __init mem_sleep_default_setup(char *str)
>                 if (mem_sleep_labels[state] &&
>                     !strcmp(str, mem_sleep_labels[state])) {
>                         mem_sleep_default =3D state;
> +                       mem_sleep_current =3D state;
>                         break;
>                 }
>
>
> ---

Applied as 6.9 material, thanks!

