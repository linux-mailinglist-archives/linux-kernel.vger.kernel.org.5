Return-Path: <linux-kernel+bounces-56402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA6F84C9BD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED7831F23CB9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DBF1D53C;
	Wed,  7 Feb 2024 11:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C13xIH7T"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888631AADD
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 11:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707306017; cv=none; b=ucrta8Z/R8dfk9lx+uZCAu1ODk/r2mZdu21njqIQca+euwYiE2m2rv4vl+nxqjFMBf1dxpv4Mbrrr3wQ7zMqEHmjvkVs/EZ+YvfcZzlw3acGafnxWPsBK6o3ty20ONc39OOwjipic/GmdUHrGsIddLDcLER6sWwbI2P2ieYA0no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707306017; c=relaxed/simple;
	bh=j2hucPWlt4QARh6EpWCHZVZmiT27JEZfL87REB11SSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LNUuKSdnYc8KEbGVAyftEiJB1BJR7ZWnQ6OJ8e/AR9fRw1GJkcqqTSo2emdm/osJnGBg3hA3h7fdAVpMr22kDVZrTJldfqxFaWf9O1rDVf90kRMW2+nAjX+SkNs25p49NZvbOM5IuqjU/iu07STk/ORqYS4vXhdLJRFh4184gqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C13xIH7T; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-60482f88f04so5790027b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 03:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707306014; x=1707910814; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YGulZCD6+zMcYgPZs795MTY99+l/D3vsNxyEgcJw+h8=;
        b=C13xIH7T3/Dq+QRnt/A4mqHwsZtbVadlk1ady5NDtyOg0bUlIQUuj/iuVUKH/3lBx9
         04qGXSf5tWeNVXKzot/q6rHR4zXyxR6mdCeohT/ANOKsAWHhdMn13c0Z0Ms80CG2UU/z
         esaVWnu4eIbvfKcZj0ITfLhZkJfhtFyW0UdMr6h5jn3PfHts5RlEsf5T9JRQ/zOEZcn5
         ar5ufFsEaa3pxzXwO3hD982agh6gjma7LJ08B9+wqRVnEHgcOOu0aSLTw1hg/gnTQ7SG
         OBQeQggZlxzWdf5HXrFmYznwxlbynZV8iBrLkpjzsWxMAhqaUUDNoINV8LNpFo4727lo
         7aUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707306014; x=1707910814;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGulZCD6+zMcYgPZs795MTY99+l/D3vsNxyEgcJw+h8=;
        b=jh/WAn3J7n8CC5sYuS3ddN4Sz1iDf0w2hgHtJ5xXPwpAgcmpAYy4w+I1Vuzy3K8tEl
         dOJSZbb5Bkzjfp4uglOgdulaH/PlbI/VF7NWJyluDbm5s/YIUUNmTYDwuoIRzV1O2EE1
         dtka1oIzGH1qKiGo28q7rAvkJZfIlnSkoV+zydEsGsLWwtEGgMnKAc0PHxLmubreanBX
         lRysPy60NrHs5GgR6GtH61rvoQ9DIkFujDTIqJMeNGDiNBSxNU3+bsmlQCXOVARyKW5h
         Ho6HXlwFx5AswLd3WN9uhsiTZOswaWUmjL/T1FIX26yxPhjua6FzmzJftzNe0yRUQAve
         MGBQ==
X-Gm-Message-State: AOJu0YyQqHTV72Ri0oOXn/5cB6gf+gkuwqc+VlB3JUHfkiUbNS9geG/l
	tJasy8iaJ9Qwsq3Gfd7hU7Z+m88EgyKfbPWhz2Sp5v6FrKDPx48pjafoGC2+/7kaRBGCEgWh5IC
	bxLPstbvI62W3N+t3Wv1hfWWezLVqQ8GpU9e+2w==
X-Google-Smtp-Source: AGHT+IHcJYp0WTpeyXfA6/v0KQqS2+K+bFf4BMoXAxddY+rgyz/NFtVQ2CSaJeYh5kLZrQX4DemLxRgcf++7/oAjGa4=
X-Received: by 2002:a81:9b4b:0:b0:604:926b:94a9 with SMTP id
 s72-20020a819b4b000000b00604926b94a9mr1274134ywg.26.1707306014489; Wed, 07
 Feb 2024 03:40:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130123951.236243-1-ulf.hansson@linaro.org>
In-Reply-To: <20240130123951.236243-1-ulf.hansson@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 7 Feb 2024 12:39:38 +0100
Message-ID: <CAPDyKFruKJhOLRLbxibF3ChDGMcJDvdOmCekRNTDYunbnKgQpw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] PM: domains: Add helpers for multi PM domains to
 avoid open-coding
To: "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Kevin Hilman <khilman@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Nikunj Kela <nkela@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	Stephan Gerhold <stephan@gerhold.net>, Ben Horgan <Ben.Horgan@arm.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, 
	linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jan 2024 at 13:39, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Rafael, my plan is queue up this series via my pmdomain tree. Please let me know
> if you see any issues with that, especially around patch1.
>
> Updates in v3:
>         - Added tested-by, reviewed-by and suggested-by tags. No other changes
>         have been made.
>
> Updates in v2:
>         - Ccing Daniel Baluta and Iuliana Prodan the NXP remoteproc patches to
>         requests help with testing.
>         - Fixed NULL pointer bug in patch1, pointed out by Nikunj.
>         - Added some tested/reviewed-by tags.
>
> Attaching/detaching of a device to multiple PM domains has started to become a
> common operation for many drivers, typically during ->probe() and ->remove().
> In most cases, this has lead to lots of boilerplate code in the drivers.
>
> This series adds a pair of helper functions to manage the attach/detach of a
> device to its multiple PM domains. Moreover, a couple of drivers have been
> converted to use the new helpers as a proof of concept.
>
> Note 1)
> The changes in the drivers have only been compile tested, while the helpers
> have been tested along with a couple of local dummy drivers that I have hacked
> up to model both genpd providers and genpd consumers.
>
> Note 2)
> I was struggling to make up mind if we should have a separate helper to attach
> all available power-domains described in DT, rather than providing "NULL" to the
> dev_pm_domain_attach_list(). I decided not to, but please let me know if you
> prefer the other option.
>
> Note 3)
> For OPP integration, as a follow up I am striving to make the
> dev_pm_opp_attach_genpd() redundant. Instead I think we should move towards
> using dev_pm_opp_set_config()->_opp_set_required_devs(), which would allow us to
> use the helpers that $subject series is adding.
>
> Kind regards
> Ulf Hansson
>
> Ulf Hansson (5):
>   PM: domains: Add helper functions to attach/detach multiple PM domains
>   remoteproc: imx_dsp_rproc: Convert to
>     dev_pm_domain_attach|detach_list()
>   remoteproc: imx_rproc: Convert to dev_pm_domain_attach|detach_list()
>   remoteproc: qcom_q6v5_adsp: Convert to
>     dev_pm_domain_attach|detach_list()
>   media: venus: Convert to dev_pm_domain_attach|detach_list() for vcodec
>
>  drivers/base/power/common.c                   | 134 +++++++++++++++
>  drivers/media/platform/qcom/venus/core.c      |  12 +-
>  drivers/media/platform/qcom/venus/core.h      |   7 +-
>  .../media/platform/qcom/venus/pm_helpers.c    |  48 ++----
>  drivers/remoteproc/imx_dsp_rproc.c            |  82 +--------
>  drivers/remoteproc/imx_rproc.c                |  73 +-------
>  drivers/remoteproc/qcom_q6v5_adsp.c           | 160 ++++++++----------
>  include/linux/pm_domain.h                     |  38 +++++
>  8 files changed, 289 insertions(+), 265 deletions(-)
>
>

I have now applied this to my next branch to my pmdomain tree, to get
it more tested in linux-next.

Please let me know if there are objections to this or if any of you
want to provide an ack/tested/reviewed-by tag, thanks!

Kind regards
Uffe

