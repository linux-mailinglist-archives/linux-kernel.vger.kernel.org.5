Return-Path: <linux-kernel+bounces-77239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEF0860276
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDAEF286B24
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B85548F3;
	Thu, 22 Feb 2024 19:17:29 +0000 (UTC)
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2C014B806;
	Thu, 22 Feb 2024 19:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708629448; cv=none; b=Q9mkoefjZYLbgaCkbcuSsCYuIYlqTUlWLV3CdfH+I4HOyrEQLlOqnU5e5oDJpHt0bsKYnjmNw72M4iuwkC8IZiaQ0QjAHoZHRUEGqFFINLXu5FhUb99SEan4Pd5Bs+adEOdaThgQQQzHCgMStC+CqMUmR/Ti/TdNcVJy5tO6xmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708629448; c=relaxed/simple;
	bh=+FiBqcXwDF9fGxhHJbMzAYdObJ5OOnA70ZVAeJXyLA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i8EQImM4/+CD6+AJK/m4KDjnKnyMiG4vFYnruKab8+iWTW3vHzTMIrWzIcAHJ0GvzxjzCHzZBRA5N8RKOZ2s/VgMzkBUqoaAtvmw9146cWD1UxrGZpfRzxl9uk5mIbmD4DzDQLIkIBzSaZ4uwR4UDzuxHKf+yXTt8jDvr88vV2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-59fc31c57easo31928eaf.1;
        Thu, 22 Feb 2024 11:17:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708629446; x=1709234246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+MI/2w5WnJcHnloELfo/rW+YJoUZtVrxFZeibGDU28=;
        b=W8FzwdbFC4l4WyyoUz7nW9NFw+1YidVpNOMaayvdbyQWmerSiFfZ6TfKd+Jg1I4DH6
         UUTtiEgeyYNdYNVeWd7lG8Y3K+sGglgDme+vbvzUB0q8YL5cmqhl2FsLkYCZTX1TXA2e
         n54+NESvRbmY7VPPW5Po+FkKvr8hAYyJOiyQCXtlLFMBUvuIKgrmgsSzaxSehEPLGLNj
         F/XDxcdxykm943JqcFHHrXotwtnZnbyacPBisL2c048nx8AAdpLqrm2ZpOGc1N7eq0D6
         x/jn4PJnQawJ++841whB4mgyqU0of7PZ1oBhhWBdVs6pUV7Vv6hOw44NLsrcgB51SOSk
         eFfA==
X-Forwarded-Encrypted: i=1; AJvYcCUMv2kP40toRnU8cIUaBbQYIELjcC8KOcRJZ0W1N4WUODxT2sn5jmRdQ9/424vStnBYHBzJB9nVFiEe08ouZxgQqwa3cekHxgRGvIyYgMs3uJzvfByALd13jgysfv2Ka4DwXqwbYB8=
X-Gm-Message-State: AOJu0YztV9npwhQXrpmM7ATlCTqeqN57Ul2uhn4+F1PqISdduqNs1b0E
	DUHjiFaZa31mlB26HflzDhMlFwQWK3E3HUmTRlnjvKLoZWVHRESCnsqE8JcEIUC+WseD48sQt8p
	7zDFxyVEqVOdZaRxfBZfb+dLvfoE=
X-Google-Smtp-Source: AGHT+IFETqTxyymobg4G3kxWlo3QRK4ETgfxmYBKmgd4i8xiITql8RhI3Th+w49RAhhZK5Bf6qmRVS0YCu7d31z0FA0=
X-Received: by 2002:a05:6820:134d:b0:59f:881f:9318 with SMTP id
 b13-20020a056820134d00b0059f881f9318mr27299418oow.0.1708629446618; Thu, 22
 Feb 2024 11:17:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220022607.485129-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20240220022607.485129-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Feb 2024 20:17:15 +0100
Message-ID: <CAJZ5v0gC9fvUH89U7L4L_mKzhAAWF0Xi4So9iHwxVoea7NdYuw@mail.gmail.com>
Subject: Re: [PATCH 0/2] cpufreq: intel_pstate: Update Meteor Lake EPPs
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 3:26=E2=80=AFAM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Add feature to update all EPPs and update Meteor Lake EPP values.
>
> Srinivas Pandruvada (2):
>   cpufreq: intel_pstate: Allow model specific EPPs
>   cpufreq: intel_pstate: Update default EPPs for Meteor Lake
>
>  drivers/cpufreq/intel_pstate.c | 43 +++++++++++++++++++++++++++++-----
>  1 file changed, 37 insertions(+), 6 deletions(-)
>
> --

Both patches in the series applied as 6.9 material, thanks!

